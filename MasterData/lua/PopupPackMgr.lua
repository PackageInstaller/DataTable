local PopupPackBase = require("PopupPackBase")
local this = MgrRegister("PopupPackMgr")

function this:Init()
    self:Clear()
    if(CSAPI.RegionalCode() == 3) then
    	OperateActiveProto:GetPopupPackInfo(true)
    end   
end

function this:Clear()
    self.datas = {}
    self.arr = {}
    self.minTime = nil
end

function this:GetPopupPackInfoRet(proto)
    for k, v in pairs(proto.infos) do
        local base = PopupPackBase.New()
        base:InitData(v)
        self.datas[v.cfgid] = base
    end
    if (proto.isFinish) then
        self:UpdateDatas()
    end
end

function this:UpdatePopupTimeRet(proto)
    if (proto.res) then
        for k, v in pairs(proto.cfgids) do
            if (self.datas[v]) then
                self.datas[v]:SetPopupTime(proto.popupTime)
            end
        end
    end
end

-- 更新数据
function this:UpdateDatas()
    self.arr = {}
    self.minTime = nil
    local deleteKeys = {}
    for k, v in pairs(self.datas) do
        if (v:IsExpired() or v:IsGet()) then
            table.insert(deleteKeys, k)
        else
            table.insert(self.arr, v)
        end
    end
    for k, v in ipairs(deleteKeys) do
        self.datas[v] = nil
    end
    if (#self.arr > 1) then
        table.sort(self.arr, function(a, b)
            local fta = a:GetFinishTime()
            local ftb = b:GetFinishTime()
            if (fta ~= nil and ftb ~= nil) then
                if (fta == ftb) then
                    return a:GetCfgID() < b:GetCfgID()
                else
                    return fta < ftb
                end
            elseif (fta == nil and ftb == nil) then
                return a:GetCfgID() < b:GetCfgID()
            else
                return fta ~= nil
            end
        end)
    end
    if (#self.arr > 0) then
        for k, v in ipairs(self.arr) do
            if (v:GetFinishTime() ~= nil) then
                self.minTime = v:GetFinishTime()
                break
            end
        end
    end
    EventMgr.Dispatch(EventType.Menu_PopupPack_MinTime)
end

-- 当前还存在时间的礼包且未领取的礼包，时间由小到大排列
function this:GetArr()
    return self.arr
end

-- 礼包最小的消失时间
function this:GetMinTime()
    return self.minTime
end

-- 是否需要弹出
function this:CheckNeedShow()
    local arr = self:GetArr()
    if (#arr > 0) then
        for k, v in pairs(arr) do
            if (not v:IsShow()) then
                return true
            end
        end
    end
    return false
end

--[[
条件类型1：玩家等级达到X
条件类型2：X个主动技能等级达到Y级
条件类型3：获得X个Y星角色
条件类型4：首次通关指定关卡
条件类型5：X个跃升天赋等级达到Y级
条件类型6：获得X个Y品质芯片
条件类型7：X个角色等级达到Y级
]]
-- 按条件触发,直接弹窗
function this:CheckByCondition(_types)
    local eStr = nil
    if (not NetMgr.net:IsConnected()) then
        eStr = "断网"
    end
    if (GuideMgr:HasGuide() or GuideMgr:IsGuiding()) then
        eStr = "引导中"
    end
    local types = {}
    for k, v in pairs(_types) do
        types[v] = 1
    end
    local cfgID = nil
    local arr = self:GetArr()
    for k, v in ipairs(arr) do
        if (types[v:GetCfg().conditionType] ~= nil and not v:IsShow()) then
            if (not cfgID) then
                cfgID = v:GetCfgID()
            end
            v:SetErrorStr(eStr)
        end
    end
    if (not eStr and cfgID) then
        self:ToshowView("自动弹窗", cfgID)
    end
end

-- 展示界面
function this:ToshowView(source, cfgID)
    local ids = {}
    local arr = self:GetArr()
    for k, v in ipairs(arr) do
        if (not v:IsShow()) then
            table.insert(ids, v:GetCfgID())
        end
        v:SetSource(source)
    end
    if (#ids > 0) then
        OperateActiveProto:UpdatePopupTime(ids, function()
            for k, v in pairs(ids) do
                local data = self.datas[v]
                data:SetFirst(true)
            end
            self:TrackEvents_1(ids)
            self:UpdateDatas()
            CSAPI.OpenView("PopupPackView", cfgID)
        end)
    else
        CSAPI.OpenView("PopupPackView")
    end
end

-- 打点 展示弹窗
function this:TrackEvents_1(ids)
    for k, v in ipairs(ids) do
        local data = self.datas[v]
        if (data and data:GetFinishTime() ~= nil) then
            local isCold, eStr = data:GetErrorStr()
            local _data = {}
            _data.gift_id = tostring(data:GetCfgID())
            _data.popup_source = tostring(data:GetSource())
            _data.remaining_time = tostring(data:GetFinishTime() - data:GetPopupTime())
            _data.is_cold_popup = isCold and "true" or "false"
            _data.cold_popup_reason = eStr
            _data.popup_time = tostring(data:GetPopupTime())
            BuryingPointMgr:TrackEvents("growth_pack_popup_show", _data)
        end
    end
end

-- 打点 关闭弹窗
function this:TrackEvents_2()
    local arr = self:GetArr()
    for k, v in ipairs(arr) do
        local _data = {}
        _data.gift_id = tostring(v:GetCfgID())
        _data.is_first_open = tostring(v:GetFirst())
        _data.remaining_time = tostring(v:GetFinishTime() - v:GetPopupTime())
        BuryingPointMgr:TrackEvents("growth_pack_popup_close", _data)
        --
        v:SetFirst(false)
    end
end

-- 打点 购买
function this:TrackEvents_3()
    local arr = self:GetArr()
    for k, v in ipairs(arr) do
        local _data = {}
        _data.gift_id = tostring(v:GetCfgID())
        _data.remaining_diamond = tostring(PlayerClient:GetDiamond())
        _data.click_time = tostring(TimeUtil:GetTime())
        _data.popup_source = tostring(v:GetSource())
        BuryingPointMgr:TrackEvents("growth_pack_click_buy", _data)
    end
end

return this
