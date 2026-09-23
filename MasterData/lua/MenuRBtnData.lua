local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_cfg)
    self.cfg = _cfg
    --
    self.isShow = true
    self.isOpen = true
    self.isRed = false
    self.begTime = nil
    self.endTime = nil
    --
    self:CheckIsShow()
end

-- 是否显示出来
function this:CheckIsShow()
    self.isShow = false
    local curTime = TimeUtil:GetTime()
    if (self.cfg.nType == 1) then
        self.begTime, self.endTime = 0, curTime * 2
    elseif (self.cfg.nType == 2) then
        self.begTime, self.endTime = nil, nil
        if (not CSAPI.IsAppReview()) then
            local curData = MenuBuyMgr:GetCurData()
            if (curData) then
                self.endTime = curData:GetEndTime() or curTime * 2
            end
        end
    elseif (self.cfg.nType == 3) then
        local isOpen, id = ActivityMgr:IsOpenByType(ActivityListType.SkinRebate)
        if (isOpen) then
            self.endTime = ActivityMgr:GetRefreshTime(ActivityListType.SkinRebate)
        end
    elseif (self.cfg.nType == 4) then
        local popupPackTime = PopupPackMgr:GetMinTime()
        if (popupPackTime and popupPackTime > curTime) then
            self.endTime = popupPackTime
        end
    elseif (self.cfg.nType == 5) then
        local curData = CumulativeSpendingMgr:GetFirstData()
        if curData then
            self.begTime = curData:GetStartTimeStamp()
            self.endTime = curData:GetEndTimeStamp()
        end
    elseif (self.cfg.nType == 6) then -- 皮肤折扣券
        local isOpen, id = ActivityMgr:IsOpenByType(ActivityListType.SkinDeals)
        if (isOpen) then
            self.endTime = ActivityMgr:GetRefreshTime(ActivityListType.SkinDeals)
        end
    elseif (self.cfg.nType == 7) then -- 早餐卡
        local isOpen, id = OperationActivityMgr:IsBCOpen() --购买完所有商品后下次刷新才关闭
        if isOpen then
            self.endTime = OperationActivityMgr:GetBCRefreshTime()
        else
            self.begTime = OperationActivityMgr:GetBCRefreshTime()
        end
    elseif (self.cfg.nType == 8) then -- 节拍联动(只在日服上)
        -- if CSAPI.IsADVRegional(3) then
            local openInfo = DungeonMgr:GetActiveOpenInfo(54)
            if openInfo then
                self.begTime = openInfo:GetStartTime()
                self.endTime = openInfo:GetEndTime()
            end
        -- end
    elseif (self.cfg.nType == 9) then -- 予金回赠
        local curData = GoldenRebateMgr:GetData(tonumber(self.cfg.page))
        if curData then
            self.begTime = curData:GetStartTime()
            self.endTime = curData:GetEndTime()
        end
    elseif (self.cfg.nType == 10) then -- 星辉回溯
        local isOpen, id = ActivityMgr:IsOpenByType(ActivityListType.SkinRabate2)
        if (isOpen) then
            self.endTime = ActivityMgr:GetRefreshTime(ActivityListType.SkinRebate2)
        end
    elseif (self.cfg.nType == 11) then
        local isOpen, id = ActivityMgr:IsOpenByType(ActivityListType.StoryActive)
        if (isOpen) then
            self.endTime = ActivityMgr:GetRefreshTime(ActivityListType.StoryActive)
        end
    end
    if (self.begTime == nil and self.endTime == nil) then
        self.isShow = false
    elseif (not self.isShow and (self.begTime == nil or curTime >= self.begTime)) then
        if (self.endTime == nil or curTime < self.endTime) then
            self.isShow = true
        end
    end
    return self.isShow
end

function this:GetCfg()
    return self.cfg
end

function this:IsShow()
    return self.isShow
end

-- 是否已解锁(上锁状态与否)
function this:IsOpen()
    self.isOpen = true
    local str = ""
    if (self.cfg.nType == 1) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ActivityListView")
    elseif (self.cfg.nType == 2) then
        self.isOpen, str = MenuBuyMgr:CheckMenuBuyIsOpen()
    elseif (self.cfg.nType == 3) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "SkinRebate")
    elseif (self.cfg.nType == 5) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "CumulativeSpending")
    elseif (self.cfg.nType == 6) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "SkinDealsMain")
    elseif (self.cfg.nType == 7) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "Breakfast")
    elseif (self.cfg.nType == 8) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "MelodyDarling")
    elseif (self.cfg.nType == 9) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "GoldenRebate")
    elseif (self.cfg.nType == 10) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "SkinRebate2")
    elseif (self.cfg.nType == 11) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "StoryActivityView")
    end
    return self.isOpen, str
end

function this:IsRed()
    self.isRed = false
    if (self.isShow and self.isOpen) then
        if (self.cfg.nType == 1) then
            self.isRed = RedPointMgr:GetData(RedPointType.ActivityList1) ~= nil
        elseif (self.cfg.nType == 2) then
            local curData = MenuBuyMgr:GetCurData()
            if (curData and curData:GetRed()) then
                self.isRed = curData:GetRed()
            end
        elseif (self.cfg.nType == 3) then
            local isOpen, id = ActivityMgr:IsOpenByType(ActivityListType.SkinRebate)
            if (isOpen) then
                self.isRed = ActivityMgr:CheckRed(id)
            end
        elseif (self.cfg.nType == 5) then
            self.isRed = RedPointMgr:GetData(RedPointType.CumulativeSpending) ~= nil
        elseif (self.cfg.nType == 6) then
            self.isRed = RedPointMgr:GetData(RedPointType.SkinDeals) ~= nil
        elseif (self.cfg.nType == 7) then
            self.isRed = RedPointMgr:GetData(RedPointType.BreakfastCard) ~= nil
        elseif (self.cfg.nType == 8) then
            self.isRed = MissionMgr:CheckRed({eTaskType.SONICO})
        elseif (self.cfg.nType == 9) then
            self.isRed = MissionMgr:CheckRed({eTaskType.GoldenRebate})
        elseif (self.cfg.nType == 10) then
            self.isRed = RedPointMgr:GetData(RedPointType.SkinRebate2) ~= nil
        elseif (self.cfg.nType == 11) then
            self.isRed = MissionMgr:CheckRed({eTaskType.StoryCollectionAct,eTaskType.StoryCollection})
        end
    end
    return self.isRed
end

-- 刷新时间
function this:RefreshTime()
    local time = nil
    if (self.cfg.nType == 2) then
        -- 付费弹窗的要特殊处理，拿最近的刷新时间点，而不是当前展示的结束时间
        local _data = MenuBuyMgr:GetOpenEndTimeInfo()
        if(_data)then 
            time = _data[1]
        end
    else
        if (self.begTime and self.begTime ~= 0) then
            time = self.begTime
        elseif (self.endTime and self.endTime ~= 0) then
            time = self.endTime
        end
        if (time and time <= TimeUtil:GetTime()) then
            time = nil
        end
    end
    return time
end

return this
