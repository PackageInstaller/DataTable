-- 打开界面是设置一份复制的数据，离开时赋值到真实数据并移除复制的数据，避免频繁交互
local CRoleDisplayData = require("CRoleDisplayData")
local this = MgrRegister("CRoleDisplayMgr")

function this:Init()
    self:Clear()
    self:InitDatas()
    PlayerProto:GetNewPanel(true)
end

function this:Clear()
    self.panels = {}
    self.panelRet = {} -- PlayerProto:GetNewPanelRet的内容但不包含panels
    self:ClearCopyData()

    self.random_panels = {}
    self.random_idx = 7
    self.name_list = {}
end

function this:InitDatas()
    self.panels = {}
    for k = 1, 6 do
        local _data = CRoleDisplayData.New()
        _data:InitIndex(k)
        self.panels[k] = _data
    end
end

-----------------------------------------------------------------------------------------------------------

function this:GetDatas()
    return self.panels
end
function this:GetData(idx)
    return self.panels[idx]
end

function this:GerRamdomDatas()
    return self.random_panels
end
function this:GerRamdomData(idx)
    return self.random_panels[idx]
end

--
function this:GetPanelRet()
    return self.panelRet
end

-- 获取随机看板
function this:GetRandomPanels(random_type)
    local arr = {}
    if (random_type == nil or random_type == eRandomPanelType.ALL) then
        for k, v in pairs(self.random_panels) do
            table.insert(arr, v)
        end
    else
        for k, v in pairs(self.random_panels) do
            if ((random_type == eRandomPanelType.SINGLE and v:GetTy() == 2) or
                (random_type == eRandomPanelType.DOUBLE and v:GetTy() == 3)) then
                table.insert(arr, v)
            end
        end
    end
    return arr
end

-- 获取随机看板 k:modleID
function this:GetRandomPanelsDic(random_type)
    local dic = {}
    if (random_type == nil or random_type == eRandomPanelType.ALL) then
        for k, v in pairs(self.random_panels) do
            local id = v:GetIDs()[1]
            dic[id] = 1
        end
    else
        for k, v in pairs(self.random_panels) do
            if ((random_type == eRandomPanelType.SINGLE and v:GetTy() == 2) or
                (random_type == eRandomPanelType.DOUBLE and v:GetTy() == 3)) then
                local id = v:GetIDs()[1]
                dic[id] = 1
            end
        end
    end
    return dic
end

function this:GetRandomType()
    return self.panelRet.random_type or eRandomPanelType.SINGLE
end

function this:GetRandomIdx()
    return self.random_idx
end

function this:IsRandom()
    return self:GetPanelRet().random == 1
end

function this:GetUsingData()
    if (self:IsRandom()) then
        return self.random_panels[self:GetPanelRet().using]
    else
        return self.panels[self:GetPanelRet().using]
    end
end

-----------------------------------------------------------------------------------------------------------

-- 服务器数据 2
function this:GetNewPanelRet(proto,isLoging)
    local random_panel = nil 
    if (proto.panels) then
        for k, v in pairs(proto.panels) do
            self.panels[k]:InitRet(v)
        end
    end
    if (proto.random_panel) then
        random_panel = table.copy(proto.random_panel)
        if (self.random_panels[proto.random_panel.idx]) then
            self.random_panels[proto.random_panel.idx]:InitRet(proto.random_panel)
        end
    end
    self.panelRet = proto
    self.panelRet.panels = nil
    self.panelRet.random_panel = nil

    if(isLoging)then 
        return
    end
    -- 打点
    local panelids = {}
    if(random_panel)then 
        panelids = random_panel.ids
    else 
        local _data = self.panels[self.panelRet.using]
        if (_data) then
            local ids = _data:GetIDs()
            for k, v in pairs(ids) do
                if(v~=0)then 
                    table.insert(panelids, v)
                end 
            end
        end
    end
    if(#panelids > 0) then
        self:TrackEvents2(panelids)
    end
    --打点
    local panelids2 = {}
    for k, v in pairs(self.panels) do
        local ids = v:GetIDs()
        for k, v in pairs(ids) do
            if(v~=0)then 
                table.insert(panelids2, v)
            end 
        end
    end
    if(#panelids2 > 0) then
        self:TrackEvents3(panelids2)
    end
end
-- 服务器数据 1
function this:GetRandomPanelRet(proto)
    if (proto.random_panels) then
        for k, v in pairs(proto.random_panels) do
            local _data = CRoleDisplayData.New()
            _data:InitIndex(v.idx, v.ty)
            _data:InitRet(v)
            self.random_panels[v.idx] = _data
        end
    end
    if (proto.finish) then
        self.random_idx = proto.random_idx
        self.name_list = proto.name_list
    end
end

-- 选择新看板返回
function this:SetNewPanelUsingRet(proto, noIn)
    self.panelRet.using = proto.using
    self.panelRet.update_time = proto.update_time
    if (proto.random_panel and proto.random_panel.ty ~= 1 and self.random_panels[proto.random_panel.idx]) then
        self.random_panels[proto.random_panel.idx]:InitRet(proto.random_panel)
    end
    -- 取消入场动画
    if (noIn) then
        local _data = nil
        if (proto.random_panel) then
            _data = self.random_panels[self.panelRet.using]
        else
            _data = self.panels[self.panelRet.using]
        end
        if (_data) then
            local _id = _data:GetIDs()[_data:GetTopSlot()]
            self:SetPlayInID(_id)
        end
    end
    EventMgr.Dispatch(EventType.Player_Select_Card)
    -- 打点
    local panelids = {}
    if(proto.random_panel)then 
        panelids = proto.random_panel.ids
    else 
        local _data = self.panels[self.panelRet.using]
        if (_data) then
            local ids = _data:GetIDs()
            for k, v in pairs(ids) do
                if(v~=0)then 
                    table.insert(panelids, v)
                end 
            end
        end
    end 
    if(#panelids > 0) then
        self:TrackEvents2(panelids)
    end
end 

-- 设置随机看板返回
function this:SetRandomPanelRet(proto)
    self.random_idx = proto.random_idx
    --
    if (not self.random_panels[proto.random_panel.idx]) then
        local _data = CRoleDisplayData.New()
        _data:InitIndex(proto.random_panel.idx)
        self.random_panels[proto.random_panel.idx] = _data
    end
    self.random_panels[proto.random_panel.idx]:InitRet(proto.random_panel)
    -- 打点
    if(#proto.random_panel.ids > 0) then
        self:TrackEvents4(1,proto.random_panel.ids)
    end
end

-- 一键添加
function this:AddRandomSkinsAllRet(proto)
    local panelids = {}
    -- 
    self.random_idx = proto.random_idx
    --
    for k, v in pairs(proto.panels) do
        if (not self.random_panels[v.idx]) then
            local _data = CRoleDisplayData.New()
            _data:InitIndex(v.idx, v.ty)
            _data:InitDetail(1, v.ids[1])
            self.random_panels[v.idx] = _data
        end
        if(v.ids)then 
            for k, v in pairs(v.ids) do
                if(v~=0)then 
                    table.insert(panelids, v)
                end 
            end
        end 
    end
    -- 打点
    if(#panelids > 0) then
        self:TrackEvents4(1,panelids)
    end
end

-- 获取随机看板详细
function this:GetRandomPanelDetailRet(proto)
    if (self.random_panels[proto.idx]) then
        self.random_panels[proto.idx]:InitRet(proto.random_panel)
    end
end

-- 设置当前看板随机类型返回
function this:SetPanelRandomTypeRet(random_type)
    self.panelRet.random_type = random_type
end

-- 移除随机看板返回
function this:RemoveRandomPanelRet(idx)
    if (not self.random_panels[idx]) then
        return
    end
    local ids = self.random_panels[idx]:GetIDs()
    self.random_panels[idx] = nil
    -- 打点
    if(#ids > 0) then
        self:TrackEvents4(2,ids)
    end
end
--------------------------------------------临时当前使用的数据(方便切换随机看板时使用)------------------------------------------------------------

function this:SetRandon(random, using)
    self.panelRet.random = random
    self.panelRet.using = using
end
--------------------------------------------复制的数据------------------------------------------------------------

function this:ClearCopyData()
    self.c_panels = {}
    self.c_panelRet = {}
    self.c_len = 0 -- 最大空槽数量
end

function this:GetCLen()
    if (self.c_len == 0) then
        for k = 1, 5 do
            if (g_BulletinBoardOpen[k] ~= 0) then
                local _id = g_BulletinBoardOpen[k]
                local _isOpen = MenuMgr:CheckConditionIsOK({_id})
                if (not _isOpen) then
                    break
                else
                    self.c_len = self.c_len + 1
                end
            else
                self.c_len = self.c_len + 1
            end
        end
    end
    return self.c_len
end

function this:GetCopyDatas()
    self.c_panels = {}
    for k, v in ipairs(self.panels) do
        self.c_panels[k] = self:GetCopyData(v)
    end
    return self.c_panels
end

function this:GetCopyData(data)
    local _data = CRoleDisplayData.New()
    _data:InitIndex(data:GetIndex())
    _data:InitRet(table.copy(data:GetRet()))
    return _data
end

function this:GetCopyPanelRet()
    self.c_panelRet = table.copy(self:GetPanelRet())
    return self.c_panelRet
end

-- 当前使用
function this:GetCopyUsing()
    return self.c_panelRet.using or 1
end
function this:SetCopyUsing(index)
    self.c_panelRet.using = index
end

-- -- 保存修改的数据并清除复制的数据
-- function this:CheckSave(c_datas, c_panelRet)
--     if (FuncUtil.TableIsSame(c_panelRet, self.panelRet) and FuncUtil.TableIsSame(c_datas, self.panels)) then
--         return -- 数据无改动
--     end
--     local panels = {}
--     for k, v in pairs(c_datas) do
--         panels[v:GetIndex()] = v:GetRet()
--     end
--     PlayerProto:SetNewPanel(panels, c_panelRet.setting, c_panelRet.random, c_panelRet.using)
--     self:ClearCopyData()
-- end

--------------------------------------看板多选功能
-- 是否使用中 模型表id
function this:CheckSkinIsUse(skinID)
    for k, v in ipairs(self.c_panels) do
        if (v:GetIndex() <= self:GetCLen() and v:GetIDs()[1] == skinID) then
            return true, v
        end
    end
    return false
end

-- 角色是否在使用中(判断所有可用皮肤)
function this:CheckRoleIsUse(cRoleInfo)
    local skinDic = cRoleInfo:GetAllCanUseSkinDic()
    for k, v in pairs(self.c_panels) do
        local id = v:GetIDs()[1]
        if (v:GetIndex() <= self:GetCLen() and id ~= 0 and skinDic[id] ~= nil) then
            return true, id, v
        end
    end
    local cardSkin = RoleMgr:GetSkinIDByRoleID(cRoleInfo:GetID())
    return false, cardSkin -- cRoleInfo:GetFirstSkinId() 改用卡牌当前使用的皮肤
end

-- 清空
function this:RemoveAll()
    if (self:GetCopyUsing() <= self:GetCLen()) then
        -- 设置默认队长
        local baseModelID = RoleMgr:GetBaseModelID()
        for k, v in ipairs(self.c_panels) do
            if (v:GetIndex() <= self:GetCLen()) then
                v:GetRet().ids = k == 1 and {baseModelID} or {0}
            end
        end
    else
        -- 全清
        for k, v in ipairs(self.c_panels) do
            if (v:GetIndex() <= self:GetCLen()) then
                v:GetRet().ids = {0}
            end
        end
    end
    EventMgr.Dispatch(EventType.CRoleDisplayDX_Refresh)
end

-- 清空某角色的
function this:RemoveForRole(cRoleInfo)
    local role_id = cRoleInfo:GetID()
    for k, v in ipairs(self.c_panels) do
        local id = v:GetIDs()[1]
        if (v:GetIndex() <= self:GetCLen() and id ~= 0 and id > 10000) then
            local _role_id = Cfgs.character:GetByID(id).role_id
            if (_role_id and role_id == _role_id) then
                v:GetRet().ids = {0}
            end
        end
    end
    -- 
    if (self:GetCopyUsing() <= self:GetCLen() and self:GetCopyCount() <= 0) then
        -- 设置默认队长
        local baseModelID = RoleMgr:GetBaseModelID()
        for k, v in ipairs(self.c_panels) do
            if (v:GetIndex() <= self:GetCLen()) then
                v:GetRet().ids = k == 1 and {baseModelID} or {0}
            end
        end
    end
    EventMgr.Dispatch(EventType.CRoleDisplayDX_Refresh)
end

-- 只有一个并且是队长则不行
function this:CheckOnlyLeader()
    if (self:GetCopyUsing() <= self:GetCLen() and self:GetCopyCount() <= 1) then
        local baseModelID = RoleMgr:GetBaseModelID()
        for k, v in ipairs(self.c_panels) do
            if (v:GetIndex() <= self:GetCLen() and v:GetRet().ids[1] == baseModelID) then
                return true
            end
        end
    end
    return false
end

-- 选中或者移除
-- 移除：如果是用到槽位1-5，则要保留最后一个，如果是全部清除，则选择总队长
-- 添加：已满则不能添加，同角色的皮肤则内部更换
function this:UseOrRemove(isUse, modelID, c_data, toIndex)
    if (isUse) then
        -- 移除
        if (self:GetCopyUsing() <= self:GetCLen() and self:GetCopyCount() <= 1) then
            local str = LanguageMgr:GetByID(7082)
            Tips.ShowTips(str)
        else
            for k, v in ipairs(self.c_panels) do
                if (v:GetIndex() <= self:GetCLen() and v:GetIDs()[1] == modelID) then
                    v:GetRet().ids = {0}
                    EventMgr.Dispatch(EventType.CRoleDisplayDX_Refresh)
                    break
                end
            end
            LanguageMgr:ShowTips(27018)
        end
    else
        -- 添加
        local index = toIndex
        -- 改 不替换同角色的皮肤
        -- local role_id = nil
        -- if (modelID > 10000) then
        --     role_id = Cfgs.character:GetByID(modelID).role_id
        --     for k, v in ipairs(self.c_panels) do
        --         local id = v:GetIDs()[1]
        --         if (v:GetIndex() <= self:GetCLen() and id ~= 0 and id > 10000) then
        --             local _role_id = Cfgs.character:GetByID(id).role_id
        --             if (_role_id and role_id == _role_id) then
        --                 index = k
        --                 break
        --             end
        --         end
        --     end
        -- end
        if (index == nil) then
            if (self:GetCopyCount() >= self:GetCLen()) then
                local str = LanguageMgr:GetByID(7083)
                Tips.ShowTips(str) -- 已满
                return
            end
            for k, v in ipairs(self.c_panels) do
                if (v:GetIndex() <= self:GetCLen() and v:GetIDs()[1] == 0) then
                    index = k
                    break
                end
            end
        end
        if (index) then
            local _data = CRoleDisplayData.New()
            _data:InitIndex(index)
            _data:InitDetail(1, modelID)
            local sNewPanel = nil
            if (c_data) then
                sNewPanel = table.copy(c_data:GetRet())
                sNewPanel.idx = index
            else
                sNewPanel = _data:GetRet()
            end
            self.c_panels[index]:InitRet(sNewPanel)
            EventMgr.Dispatch(EventType.CRoleDisplayDX_Refresh)
        end
    end
end

-- 刷新某个(保存按钮)
function this:RefreshData(c_data)
    for k, v in pairs(self.c_panels) do
        if (v:GetIndex() <= self:GetCLen() and v:GetIDs()[1] == c_data:GetIDs()[1]) then
            v:InitRet(table.copy(c_data:GetRet()))
            EventMgr.Dispatch(EventType.CRoleDisplayDX_Refresh)
            break
        end
    end
end

function this:GetCopyCount()
    local count = 0
    for k, v in ipairs(self.c_panels) do
        if (v:GetIndex() <= self:GetCLen() and v:GetIDs()[1] ~= 0) then
            count = count + 1
        end
    end
    return count
end

function this:SetCopyUsing2()
    local using = self:GetCopyUsing()
    if (using <= self:GetCLen() and self.c_panels[using]:GetIDs()[1] == 0) then
        for k, v in ipairs(self.c_panels) do
            if (v:GetIndex() <= self:GetCLen() and v:GetIDs()[1] ~= 0) then
                self.c_panelRet.using = k
                EventMgr.Dispatch(EventType.CRoleDisplayDX_Refresh)
                break
            end
        end
    end
end

function this:CheckCanAdd()
    if (self:GetCopyCount() < self:GetCLen()) then
        return true
    end
    return false
end

--------------------------------------------通用函数------------------------------------------------------------
function this:SetPlayInID(_id)
    self.oldPlayInID = _id
end
-- 是否与上一次播放的l2d相同
function this:CheckIsPlayIn(_id)
    return self.oldPlayInID ~= nil and self.oldPlayInID == _id
end
function this:IsFirst()
    if (not self.isFirst) then
        self.isFirst = 1
        return true
    end
    return false
end

-- 当前选择的槽位
function this:GetCurData()
    if (self:IsRandom()) then
        return self.random_panels[self.panelRet.using]
    else
        return self.panels[self.panelRet.using]
    end
end
function this:GetCopyCurData()
    local curData = self:GetCurData()
    if (curData) then
        return self:GetCopyData(curData)
    end
    return nil
end

-- 当前选择的top的id
function this:GetTopID(data)
    if (data) then
        if (data:GetDetail(1).top) then
            return data:GetIDs()[1]
        end
        if (data:GetDetail(2).top) then
            return data:GetIDs()[2]
        end
    end
    return nil
end

-- 数据真实长度
function this:GetRealLen()
    local len = 0
    if (self:IsRandom()) then
        local arr = self:GetRandomPanels(self:GetRandomType())
        len = #arr
    else
        for k, v in pairs(self.panels) do
            if (v:CheckIsEntity()) then
                len = len + 1
            end
        end
    end
    return len
end

-- 按顺序下一个下标（有数据的）
function this:GetNextUsing()
    if (self:GetRealLen() <= 1) then
        return self.panelRet.using
    end
    local using = self.panelRet.using
    while using < 7 do
        using = using + 1
        if (using > 6) then
            using = 1
        end
        if (self.panels[using]:CheckIsEntity()) then
            return using
        end
    end
end

-- 随机一个下标
-- function this:GetRandomUsing()
--     if (self:GetRealLen() <= 1) then
--         return self.panelRet.using
--     end
--     local list = {}
--     local using = self.panelRet.using
--     for k, v in pairs(self.panels) do
--         if (k ~= using and v:CheckIsEntity()) then
--             table.insert(list, k)
--         end
--     end
--     local num = CSAPI.RandomInt(1, #list)
--     return list[num]
-- end

-- 随机一个
function this:GetRandomUsing(random_type)
    local arr = {}
    if (random_type == eRandomPanelType.ALL) then
        arr = self.random_panels
    else
        arr = self:GetRandomPanels(random_type)
    end
    local ids = {}
    for k, v in pairs(arr) do
        if (v:GetIdx() ~= self.panelRet.using) then
            table.insert(ids, v:GetIdx())
        end
    end
    local len = #ids
    local num = CSAPI.RandomInt(1, len)
    return ids[num]
end

-- 登录
function this:Change()
    local nextUsing = self:IsRandom() and self:GetRandomUsing(self:GetRandomType()) or self:GetNextUsing()
    PlayerProto:SetNewPanelUsing(nextUsing, false)
end

-- 主界面的切换
function this:Change2()
    local nextUsing = self:IsRandom() and self:GetRandomUsing(self:GetRandomType()) or self:GetNextUsing()
    local _data = self:IsRandom() and self.random_panels[nextUsing] or self.panels[nextUsing]
    PlayerProto:SetNewPanelUsing(nextUsing, true)
end

-- 切到另一页的任意一个
function this:Change3(_type)
    local arr = self:GetRandomPanels(_type)
    PlayerProto:SetNewPanelUsing(arr[1]:GetIdx(), false)
end

-- 登录返回
-- 如果是登录轮换，则需要换一下
function this:LoginCheck()
    if (self:GetRealLen() > 1) then
        if (self.panelRet.setting == 2) then
            -- 每次登录更换
            self:Change()
        elseif (self.panelRet.setting == 1) then
            -- 每天 
            if (not TimeUtil:IsSameDay(self.panelRet.update_time, TimeUtil:GetTime())) then
                self:Change()
            end
        end
    end
end

-- 打开Main界面修改后的返回 触发
-- 1、如果轮换选返回主界面触发，那么不做处理，让NormalCheck2处理(但长度要大于2，如果修改后长度小于1则需要抛事件处理)
-- 2、如过是其他触发(不换，每天，每次登录)，那么只判断当前选择的是否改动，是的话则抛事件
function this:NormalCheck1(old_curData)
    self.check1 = nil
    if (self.panelRet.setting ~= 3 or self:GetRealLen() <= 1) then
        if (old_curData ~= nil and not FuncUtil.TableIsSame(old_curData, self:GetCurData())) then
            EventMgr.Dispatch(EventType.Player_Select_Card)
            self.check1 = 1
        end
    end
end

-- -- 返回主界面 触发
function this:NormalCheck2()
    self.check2 = nil
    if (self.panelRet.setting == 3 and self:GetRealLen() > 1) then
        self:Change()
        self.check2 = 1
    end
    --
    return self:CheckPlayIn()
end

-- 如果是完整模式，每次关闭界面都要播放一次入场，这里在无改动的情况下抛时事件处理
function this:CheckPlayIn()
    local isPlay = false
    if (not self.check1 and not self.check2 and CRoleDisplayMgr:GetSpineInType() == 2) then
        EventMgr.Dispatch(EventType.Player_Select_Card)
        isPlay = true
    end
    self.check1 = nil
    self.check2 = nil
    if (not isPlay) then
        isPlay = self:CheckCRoleDisplayS()
    end
    return isPlay
end

function this:SetCRoleDisplayS()
    if (not self.old_curDataS) then
        local curDisplayData = CRoleDisplayMgr:GetCurData()
        self.old_curDataS = table.copy(curDisplayData:GetRet())
    end
end
-- 是否只是改变了随机看板的内容
function this:CheckCRoleDisplayS()
    local isPlay = false
    if (self.old_curDataS) then
        local curDisplayData = CRoleDisplayMgr:GetCurData()
        if (not FuncUtil.TableIsSame(self.old_curDataS, curDisplayData:GetRet())) then
            EventMgr.Dispatch(EventType.Player_Select_Card)
            isPlay = true
        end
    end
    self.old_curDataS = nil
    return isPlay
end

-- -- 更换队长
-- function this:ChangeLeader(ocfgid)
--     local cfg = Cfgs.CardData:GetByID(ocfgid)
--     local skinsDic = RoleSkinMgr:GetDatas(cfg.role_id, true) or {}
--     for k, v in pairs(self.panels) do
--         local ids = v:GetIDs()
--         for p, q in ipairs(ids) do
--             if (q ~= 0 and skinsDic[q] ~= nil) then
--                 -- 使用了旧队长的某皮肤，替换成现队长的皮肤
--                 local leader = RoleMgr:GetLeader()
--                 ids[p] = leader:GetSkinID()
--                 local panels = {}
--                 for k, v in pairs(self.panels) do
--                     panels[v:GetIndex()] = v:GetRet()
--                 end
--                 PlayerProto:SetNewPanel(panels, self.panelRet.setting, self.panelRet.random, self.panelRet.using,
--                     function(old_curData)
--                         if (old_curData) then
--                             local curData = self:GetCurData()
--                             local ids = curData:GetIDs()
--                             local old_topID = self:GetTopID(old_curData)
--                             for n, m in ipairs(ids) do
--                                 if (old_topID == m) then
--                                     EventMgr.Dispatch(EventType.Player_Select_Card)
--                                     break
--                                 end
--                             end
--                         end
--                     end)
--                 break
--             end
--         end
--     end
-- end

--------------------------------------------更多设置------------------------------------------------------------
-- 入场动画播放设置 1：简洁模式  2：完整模式 3：例登模式（默认）4：例次模式
function this:GetSpineInType()
    local key = "spineintype"
    local num = PlayerPrefs.GetInt(key) or 0
    if (num == 0) then
        num = 3
        PlayerPrefs.SetInt(key, num)
    end
    return num
end
function this:SetSpineInType(num)
    local key = "spineintype"
    PlayerPrefs.SetInt(key, num)
end
-----------------------------------------------------------------------------------------------------

-- 随机看板的数据结构
function this:CreateRandomData(idx, ty)
    local _data = CRoleDisplayData.New()
    _data:InitIndex(idx, ty)
    return _data
end

-- 能否随机
function this:CheckCanRandom()
    local arr = self:GetRandomPanels(self:GetRandomType())
    if (#arr > 0) then
        return true, arr[1]:GetIdx()
    end
    return false
end

-- 获取从1-6位置第一个有用的位置
function this:GetUsefulUsing()
    for k = 1, 6 do
        local item = self.c_panels[k]
        if (item and item:CheckIsEntity()) then
            return k
        end
    end
    return self.panelRet.using
end

-- 演习 模拟创建基数据
function this:CreateDisplayData(_modelID, _live2d)
    local _data = CRoleDisplayData.New()
    _data:InitIndex(1, 4)
    _data:GetRet().ids = {_modelID}
    _data:GetDetail(1).live2d = _live2d
    _data:GetDetail(1).top = true
    return _data
end

function this:GetYSName(index)
    local str = nil
    if (self.name_list) then
        for k, v in pairs(self.name_list) do
            if (v.second == index) then
                str = v.first
            end
        end
    end
    if (not str) then
        str = LanguageMgr:GetByID(7078 + index)
    end
    return str
end

function this:SetRandomPanelNameRet(proto)
    self.name_list = proto.name_list
end

function this:RandomPanelCleanRet(proto)
    local arr = {}
    local _ty = proto.random_type + 1
    local using = proto.idx -- self:GetPanelRet().using
    for k, v in pairs(self.random_panels) do
        if (v:GetRet().ty == _ty and (not using or (v:GetIdx() ~= using))) then
            table.insert(arr, v:GetIdx())
        end
    end
    for k, v in pairs(arr) do
        self.random_panels[v] = nil
    end
    -- 打点
    if(#arr > 0) then
        self:TrackEvents4(2,arr)
    end
end

-- 主题名称
function this:GetTypeSName(nType, theme_type)
    local sName = ""
    if nType == 1 then
        local tCfg = Cfgs.CfgMultiImageThemeType:GetByID(theme_type)
        sName = tCfg.sName or ""
    elseif nType == 2 then
        local tCfg = Cfgs.CfgHalfBodyType:GetByID(theme_type)
        sName = tCfg.sName or ""
    end
    return sName
end

-- 打点 点击记录
function this:TrackEvents(_id, _index)
    local _data = {}
    _data.id = tostring(_id)
    _data.index = tostring(_index)
    BuryingPointMgr:TrackEvents("card_touch", _data)
end

--卡牌更换皮肤
function this:TrackEvents1(_cid, _skinid,_skinida)
    local _data = {}
    _data.cid = tostring(_cid)
    _data.skinid = tostring(_skinid)
    _data.skinida = _skinida and tostring(_skinida) or ""
    BuryingPointMgr:TrackEvents("use_skin", _data)
end

--主界面看板更换
function this:TrackEvents2(_panelids)
    local _data = {}
    _data.panelids = _panelids
    BuryingPointMgr:TrackEvents("panel_change", _data)
end

--6位置看板更换
function this:TrackEvents3(_panelids)
    if(self.old_panelids6 and FuncUtil.TableListIsSame(self.old_panelids6, _panelids))then 
        return
    end 
    self.old_panelids6 = _panelids
    local _data = {}
    _data.panelids = _panelids
    BuryingPointMgr:TrackEvents("set_panel", _data)
end

--随机看板更换
function this:TrackEvents4(_ty,_panelids)
    local _data = {}
    _data.ty = tostring(_ty)
    _data.panelids = _panelids
    BuryingPointMgr:TrackEvents("set_random_panel", _data)
end


return this
