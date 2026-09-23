local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_cfg)
    self.cfg = _cfg
end

function this:SetTime(s,e)
    self.sTime =s
    self.eTime =e
    if s then
        self.cfg.sTime = TimeUtil:GetTimeStr2(s,true)
    end
    if e then
        self.cfg.eTime = TimeUtil:GetTimeStr2(e,true)
    end
end

function this:GetStartTime()
    if not self.sTime and self.cfg and self.cfg.sTime then
        self.sTime = TimeUtil:GetTimeStampBySplit(self.cfg.sTime)
    end
    return self.sTime
end

function this:GetEndTime()
    if not self.eTime and self.cfg and self.cfg.eTime then
        self.eTime = TimeUtil:GetTimeStampBySplit(self.cfg.eTime)
    end
    return self.eTime
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetType()
    return self.cfg and self.cfg.type
end

function this:GetSpecType()
    return self.cfg and self.cfg.specType
end

function this:GetGroup()
    return self.cfg and self.cfg.group or 0
end

function this:GetIndex()
    return self.cfg and self.cfg.index or 1
end

function this:GetLeftInfos()
    return self.cfg and self.cfg.leftInfo
end

function this:GetPath()
    return self.cfg and self.cfg.path
end

function this:GetInfo()
    return self.cfg and self.cfg.info
end

--获取信息字段对应内容
function this:GetInfoContent(key)
	if key == nil or key == "" then
		return
	end
	local info = self:GetInfo()
	return info and info[key]
end

function this:GetPopIndex()
    return self.cfg.popIndex
end

function this:IsOpen()
    local isOpen = true
    if self:GetType() == ActivityListType.SignInContinue then
        isOpen = false
        if (SignInMgr:SignInIsOpen()) then
            local signData = SignInMgr:GetSignInContinueData()
            if signData and (not signData:CheckIsDone() or signData:GetRealDay() < 7) then
                isOpen = true
            end
        end
    elseif self:GetType() == ActivityListType.MissionContinue then
        local info = self:GetInfo()
        if info and info[1] and info[1].taskType and info[1].taskType == 2 then
            isOpen = not MissionMgr:IsAllGuideMissionGet()
        else
            isOpen = not MissionMgr:IsAllSevenMissionGet()
        end
    elseif self:GetType() == ActivityListType.Investment then
        local targetTime = PlayerMgr:GetOpenTime(ActivityListType.Investment) + (g_InvestmentTimes * 86400)
        isOpen = targetTime > TimeUtil:GetTime()
    elseif self:GetType() == ActivityListType.AccuCharge2 then
        isOpen = AccuChargeMgr:IsOpen2()
    elseif self:GetType() == ActivityListType.NewPlayerSeven then
        local targetTime = PlayerMgr:GetOpenTime(ActivityListType.NewPlayerSeven) + (g_NewPlayerSevenDayTaskTimes * 86400)
        isOpen = targetTime > TimeUtil:GetTime()
    end

    if self:GetSpecType() == ALType.Pay then
        local active = ActivityMgr:GetOperateActive(self:GetID())
        if active == nil then
            isOpen = false
        end
    elseif isOpen then -- 时间限制
        isOpen = self:IsOpenTime()
    end

    return isOpen
end

function this:IsOpenTime()
    local isOpen = true
    local sTime,eTime = self:GetStartTime(),self:GetEndTime()
    if sTime and eTime then
        isOpen = TimeUtil:GetTime() > sTime and TimeUtil:GetTime() <= eTime
    end
    return isOpen
end

function this:IsShowImg()
    return self.cfg and self.cfg.bIsShow ~= nil
end

return this