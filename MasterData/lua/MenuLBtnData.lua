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
    elseif (self.cfg.nType == 7) then
        self.endTime = nil
        if (CSAPI.IsADV()) then
            local lv = g_ZilongWebBtnLv or 1
            if (PlayerClient:GetLv() >= lv) then
                if (g_ZilongWebBtnOpen) then
                    self.begTime = TimeUtil:GetTimeStampBySplit(g_ZilongWebBtnOpen)
                end
                if (g_ZilongWebBtnClose) then
                    self.endTime = TimeUtil:GetTimeStampBySplit(g_ZilongWebBtnClose)
                end
            end
        end
    elseif (self.cfg.isShowStr ~= nil) then
        local strs = StringUtil:split(self.cfg.isShowStr, "_")
        local mgr = _G[strs[1]]
        local funcName = strs[2]
        local parm = strs[3] ~= nil and tonumber(strs[3]) or nil
        local func = mgr[funcName]
        if(not func)then 
            LogError(self:GetCfg().Name.."活动代码还没提交或者合并")
        else 
            self.begTime, self.endTime = func(mgr, parm)
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
-- 是否已解锁
function this:IsOpen()
    self.isOpen = true
    local str = ""
    if (self.cfg.nType == 1) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ExplorationMain")
        if (self.isOpen) then
            self.isOpen = ExplorationMgr:CanOpenExploration()
            str = LanguageMgr:GetTips(22003)
        end
    elseif (self.cfg.isOpenStr) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, self.cfg.isOpenStr)
    end
    return self.isOpen, str
end

function this:IsRed()
    self.isRed = false
    if (self.isShow and self.isOpen) then
        if (self.cfg.nType == 8) then
            local info = ItemPoolActivityMgr:GetPoolInfoByType(ItemPoolType.LuckyGacha);
            if info then
                self.isRed = ItemPoolActivityMgr:CheckPoolHasRedPoint(info:GetID());
            end
        elseif (self.cfg.nType == 9) then
            local info = PuzzleMgr:CheckRedInfo(self:GetCfg().page);
            if info then
                self.isRed = info ~= nil;
            end
        elseif (self.cfg.nType == 13 and self.cfg.page) then
            local infos = RedPointMgr:GetData(RedPointType.Riddle);
            self.isRed = infos ~= nil and infos[self:GetCfg().page] ~= nil or false;
        elseif self.cfg.nType == 17 then
            self.isRed = RedPointMgr:GetData(RedPointType.RichMan) == true
        elseif (self.cfg.nType == 19) then
            local info = ItemPoolActivityMgr:GetPoolInfo(self:GetCfg().page);
            if info then
                self.isRed = ItemPoolActivityMgr:CheckPoolHasRedPoint(info:GetID());
            end
        else
            if (self.cfg.isRedStr) then
                self.isRed = RedPointMgr:GetData(self.cfg.isRedStr) ~= nil
            end
        end
    end
    return self.isRed
end

function this:IsNew()
     self.isNew = false
    if (self.isShow and self.isOpen) then
        if self.cfg.nType == 18 then
            self.isNew = OperationActivityMgr:IsSkinPassNew()
        elseif self.cfg.nType == 20 then
            self.isNew = CharacterRaisingMgr:CheckNewInfo()
        end
    end
    return self.isNew
end

function this:IsRed7(obj, redPos)
    ShiryuSDK.QueryRedDotState(3, function(isAdd)
        if (obj ~= nil) then
            UIUtil:SetRedPoint(obj, isAdd, redPos[1], redPos[2])
        end
    end)
end

-- 刷新时间
function this:RefreshTime()
    local time = nil
    if (self.begTime and self.begTime ~= 0) then
        time = self.begTime
    elseif (self.endTime and self.endTime ~= 0) then
        time = self.endTime
    end
    if (time and time <= TimeUtil:GetTime()) then
        time = nil
    end
    return time
end

return this
