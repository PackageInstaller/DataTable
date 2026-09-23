local PlayerAbilityInfo = require "PlayerAbilityInfo"
-- local PlayerAbilityInfoT = require "PlayerAbilityInfoT"
local this = MgrRegister("PlayerAbilityMgr")

-----------------------------------------------协议发------------------------
function this:Init()
    self.lastResetTime = nil
    self.datas = {}
    local cfgs = Cfgs.CfgPlrAbility:GetAll()
    for i, v in ipairs(cfgs) do
        local info = PlayerAbilityInfo.New()
        info:InitData(v)
        self.datas[v.id] = info
    end
    AbilityProto:GetAbility()
end

function this:Clear()
    self.datas = {}
end

function this:SetData(data)
    for i, v in pairs(self.datas) do
        v:SetLock(true)
    end
    for i, v in ipairs(data.abilitys) do
        if (self.datas[v.id]) then
            self.datas[v.id]:SetLock(false)
        end
    end
    self.lastResetTime = data.lastResetTime
    self:CheckRedPointData()

    EventMgr.Dispatch(EventType.Update_PlayerAbility)
end

function this:GetData(id)
    return self.datas[id]
end

-- ==============================--
-- desc:队列，需要按规则排序（上到下，左到右）
-- isShortByID 根据id排序
-- time:2019-09-17 11:51:54  
-- @return 
-- ==============================--
function this:GetArr(isShortByID)
    local arr = {}
    for i, v in pairs(self.datas) do
        table.insert(arr, v)
    end
    if (isShortByID) then
        table.sort(arr, function(a, b)
            return a:GetCfg().id < b:GetCfg().id
        end)
    else
        table.sort(arr, function(a, b)
            return self.SortFunc(a, b)
        end)
    end
    return arr
end

function this.SortFunc(a, b)
    local pos1 = a:GetCfg().pos or {1, 1}
    local pos2 = b:GetCfg().pos or {1, 1}
    if (pos1[1] == pos2[1]) then
        return pos1[2] < pos2[2]
    else
        return pos1[1] < pos2[1]
    end
end

-- ==============================--
-- desc:整合已获取的能力
-- time:2019-09-18 05:18:05
-- @return 
-- ==============================--
function this:GetAbilitys()
    local cacheDatas = {}
    local arr = {}
    for i, v in pairs(self.datas) do
        if (not v:GetIsLock()) then
            if (v:GetCfg().type == AbilityType.SkillGroup) then
                table.insert(arr, v)
            elseif (v:GetCfg().type == AbilityType.PlrProperty) then
                local active_id = v:GetCfg().active_id
                local buffCfg = Cfgs.CfgLifeBuffer:GetByID(active_id)
                if (cacheDatas[buffCfg.nType]) then
                    local info = PlayerAbilityInfo.New()
                    info:InitData(v:GetCfg())
                    local index = cacheDatas[buffCfg.nType].index
                    local newValue = arr[index]:GetMaxValue() + info:GetValue()
                    arr[index]:SetMaxValue(newValue)

                else
                    local info = PlayerAbilityInfo.New()
                    info:InitData(v:GetCfg())
                    table.insert(arr, info)
                    cacheDatas[buffCfg.nType] = {}
                    -- cacheDatas[buffCfg.nType].tab = info
                    cacheDatas[buffCfg.nType].index = #arr
                    info:SetMaxValue(info:GetValue())
                end
            end
        end
    end
    table.sort(arr, function(a, b)
        if (a:GetCfg().type == AbilityType.SkillGroup and b:GetCfg().type == AbilityType.SkillGroup) then
            return a:GetCfg().id < b:GetCfg().id
        else
            return a:GetCfg().type == AbilityType.SkillGroup
        end
    end)
    return arr
end

-- ==============================--
-- desc:是否有可重置的能力
-- time:2019-09-20 09:57:03
-- @args:
-- @return 
-- ==============================--
function this:CheckCanReset()
    for i, v in pairs(self.datas) do
        if (v:GetCfg().can_reset and not v:GetIsLock()) then
            return true
        end
    end
    return false
end

-- 是否已开启
function this:CheckIsOpen(id)
    local data = self.datas[id]
    if (data) then
        return data:GetIsLock()
    end
    return false
end

this.basePos = {205, 363} -- {143, 140}  230
this.interval = {294, 320} -- {152, 70}

-- sv 宽度
function this:GetHeight(_y)
    return self.basePos[1] + self.interval[1] * (_y - 1) + 150
end

-- 计算坐标
function this:GetPos(_x, _y)
    local x = self.basePos[1] + self.interval[1] * (_y - 1)
    local y = self.basePos[2] - self.interval[2] * (_x - 1)
    return x, y
end

-- ==============================--
-- desc:弹提示
-- time:2019-09-25 11:51:19
-- @data:
-- @return 
-- ==============================--
function this:ShowTips(data)
    if (data:CanOpen()) then
        -- 需要消耗的点数
        local dialogData = {}
        local costStr = StringUtil:SetColor(data:GetCfg().cost_num, "orange")
        local b = data:GetCfg().cost_num <= PlayerClient:GetCoin(g_AbilityCoinId) -- 能力开启判断
        if b and data:GetCost() > 0 and not data:GetIsLock() then -- 技能组升级判断
            b = data:GetCost() <= PlayerClient:GetCoin(g_AbilityCoinId)
        end
        local okFunc = nil
        local content = nil
        if b then
            local name = StringUtil:SetColor(data:GetCfg().name, "orange")
            local id = data:GetCfg().id
            content = string.format(LanguageMgr:GetByID(9005), costStr, name)
            okFunc = function()
                EventMgr.Dispatch(EventType.Player_Ability_Add)
                AbilityProto:AddAbility(id)
            end
        else
            content = LanguageMgr:GetTips(26102)
            okFunc = function()
                if CSAPI.IsViewOpen("PlayerAbility") then
                    local viewGO = CSAPI.GetView("PlayerAbility")
                    local viewLua = ComUtil.GetLuaTable(viewGO)
                    viewLua.view:Close()
                end
                CSAPI.OpenView("Section")
            end
        end
        dialogData.content = content
        dialogData.okCallBack = okFunc
        CSAPI.OpenView("Dialog", dialogData)
    else
        local str = ""
        -- 前置
        local perv_id = data:GetCfg().prev_id
        if (perv_id) then
            for i, v in ipairs(perv_id) do
                local data = PlayerAbilityMgr:GetData(v)
                if (data and data:GetIsLock()) then
                    if (str == "") then
                        str = string.format(LanguageMgr:GetByID(9006) .. "%s",
                            StringUtil:SetColor(data:GetCfg().name, "orange"))
                    else
                        str = ";" ..
                                  string.format(LanguageMgr:GetByID(9006) .. "%s",
                                StringUtil:SetColor(data:GetCfg().name, "orange"))
                    end
                end
            end
        end
        if (str == "") then
            -- 等级
            local lv = data:GetCfg().open_lv
            if (PlayerClient:GetLv() < lv) then
                local lvStr = LanguageMgr:GetByID(1033) or "LV."
                if (str == "") then
                    str = string.format(LanguageMgr:GetByID(9006), StringUtil:SetColor(lvStr .. lv, "orange"))
                else
                    str = str .. ";" ..
                              string.format(LanguageMgr:GetByID(9006), StringUtil:SetColor(lvStr .. lv, "orange"))
                end
            end
        end
        if (str ~= "") then
            -- local dialogData = {}
            -- dialogData.content = str
            -- CSAPI.OpenView("Dialog", dialogData)
            Tips.ShowTips(str)
        end
    end
end

-- 检测红点
function this:CheckRedPointData()
    RedPointMgr:UpdateData(RedPointType.PlayerAbility, self:GetRed() and 1 or nil)
end

-- 获取红点
function this:GetRed(id)
    if (self.datas) then
        local count = PlayerClient:GetCoin(g_AbilityCoinId)
        if (count > 0) then
            if (id) then
                local data = self.datas[id]
                if (data and data:CanOpen()) then
                    local isSkill = data:GetCfg().type == AbilityType.SkillGroup
                    if (data:GetIsLock()) then
                        return count >= data:GetCfg().cost_num
                    elseif (isSkill and data:GetCost() > 0) then
                        return count >= data:GetCost()
                    end
                end
            else
                for _, data in pairs(self.datas) do
                    local needCount = 0
                    if (data:CanOpen()) then
                        local isSkill = data:GetCfg().type == AbilityType.SkillGroup
                        if (data:GetIsLock()) then
                            needCount = data:GetCfg().cost_num
                        elseif (isSkill) then
                            needCount = data:GetCost()
                        end
                        if (needCount > 0 and needCount <= count) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

-- 获取已开启经验和金币加成
function this:GetFightOverBuff()
    local buffs = {}
    local cacheBuff = {}
    for i, v in pairs(self.datas) do
        if (not v:GetIsLock()) then
            local cfg = Cfgs.CfgLifeBuffer:GetByID(v:GetCfg().active_id)
            if cfg and cfg.nType == 34 then -- 合并
                cacheBuff[cfg.id] = cacheBuff[cfg.id] or {}
                cacheBuff[cfg.id].id = cfg.id
                cacheBuff[cfg.id].val = cacheBuff[cfg.id].val and cacheBuff[cfg.id].val + cfg.jVal[1][2] or cfg.jVal[1][2]
            end
        end
    end
    for k, m in pairs(cacheBuff) do --转换成有序
        table.insert(buffs, m)
    end
    return buffs
end

function this:IsFreeReset()
    if self.lastResetTime then
       return not GCalHelp:CheckSameMonth(self.lastResetTime, TimeUtil:GetTime())
    end
    return false
end

return this
