local ActivityPopUpData = require "ActivityPopUpData"

ActivityPopUpMgr = MgrRegister("ActivityPopUpMgr")
local this = ActivityPopUpMgr

function this:Init()
    self.popViewInfos = {}
    self.datas = {}
    self.popInfos = {}
    self.isPop = false
    self:InitDatas()
    self:InitEventListener()
end

function this:InitEventListener()
    EventMgr.AddListener(EventType.Activity_PopUp_View,self.PopUpNextView)
end

function this:Clear()
    self.popViewInfos = {}
    self.datas = {}
    self.popInfos = {}
    self.isPop = false
    EventMgr.RemoveListener(EventType.Activity_PopUp_View,self.PopUpNextView)
end

function this:InitDatas()
    local cfgs = Cfgs.CfgActivePopUp:GetAll()
    if cfgs then
        for _, cfg in pairs(cfgs) do
            local data = ActivityPopUpData.New()
            data:Init(cfg)
            self.datas[cfg.id] = data
        end
    end
end

--检测所有可弹出界面
function this:CheckPopView()
    if (GuideMgr:HasGuide() or GuideMgr:IsGuiding()) then
        return false
    end
    if self.isPop then --正在弹出
        return true
    end
    if self:PopUpNextView() then --未弹出完
        return true
    end
    for id, data in pairs(self.datas) do
        -- LogError("activeId:" .. data:GetActiveId())
        -- LogError("CheckViewOpen:" .. tostring(self:CheckViewOpen(data:GetViewName())))
        -- LogError("PanelCanJump:" .. tostring(self:PanelCanJump(data:GetID())))
        -- LogError("CheckIsPop:" .. tostring(self:CheckIsPop(data:GetActiveId())))
        if self:CheckIsPop(data:GetActiveId()) and self:CheckViewOpen(data:GetViewName()) and self:PanelCanJump(data:GetID()) then
            table.insert(self.popViewInfos,data)
        end
    end
    if #self.popViewInfos >0 then
        table.sort(self.popViewInfos,function (a,b)
            return a:GetIndex() < b:GetIndex()
        end)
    end
    return self:PopUpNextView()
end


--检测能否弹出
function this:CheckIsPop(id)
    local alData = ActivityMgr:GetALData(id)
    if alData and alData:IsOpen() then
        if alData:GetSpecType() == ALType.SignIn then
            local signInInfo = SignInMgr:GetDataByALType(id)
            if signInInfo and not signInInfo:CheckIsDone() then
                return true
            end
        elseif alData:GetSpecType() == ALType.Pay then
            local active = ActivityMgr:GetOperateActive(alData:GetID())
            local signInInfo = SignInMgr:GetDataByALType(id)
            if signInInfo and not signInInfo:CheckIsDone() and active ~= nil then
                return true
            end
        end
    end
    return false
end

-- 界面解锁
function this:CheckViewOpen(viewName)
    return MenuMgr:CheckModelOpen(OpenViewType.main, viewName)     
end

-- 根据记录检测弹出
function this:PanelCanJump(_id)
    if not self.popInfos[_id] or not self.popInfos[_id].recordTime or self.popInfos[_id].recordTime <= 0 then
        return true
    end
    local tab1 = TimeUtil:GetTimeHMS(self.popInfos[_id].recordTime)
    local tab2 = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
    if tab2.day - tab1.day > 1 then --超过一天
        return true
    elseif tab2.day - tab1.day > 0 then --在前后一天
        if tab1.hour < g_ActivityDiffDayTime then --前一次记录在每日刷新前
            return true
        elseif tab2.hour >= g_ActivityDiffDayTime then --当前在每日刷新后
            return true
        end
    elseif tab1.hour < g_ActivityDiffDayTime and tab2.hour >= g_ActivityDiffDayTime then --在同一天但在每日刷新前后
        return true
    end
    return false
end

--获取对应界面是否有弹出
function this:TryPopUpView(viewName)
    if self.popViewInfos[1] and self.popViewInfos[1]:GetViewName() == viewName then
        self:PopUpNextView()
    end
end

--弹出下一个界面
function this:PopUpNextView()
    if #self.popViewInfos > 0 then
        local data = table.remove(self.popViewInfos,1)
        if data:GetViewName() ~= "" then
            self.popInfos[data:GetID()] = self.popInfos[data:GetID()] or {}
            self.popInfos[data:GetID()].recordTime = TimeUtil:GetTime()
            local _data,_elseData = self:GetViewData(data)
            self.isPop = true
            CSAPI.OpenView(data:GetViewName(),_data,_elseData,function ()
                self.isPop = false
            end)
        end
        return true
    end
    return false
end

--获取界面参数
function this:GetViewData(data)
    if not data then
        return
    end
    local _data,_elseData = nil,nil
    local alData = ActivityMgr:GetALData(data:GetActiveId())
    if alData then
        if data:GetViewName() == "ActivityListView" then
            _data = {id = alData:GetID()}
            _elseData = alData:GetGroup() or nil
        elseif data:GetViewName() == "SignInDuanWu" then
            _data = {id = alData:GetID()}
        end
    end
    return _data,_elseData
end

--清空弹出信息
function this:ClearPopUpInfos()
    self.popViewInfos = {}
end

return this