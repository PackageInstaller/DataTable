local PlantDataMgr = BaseClass("PlantDataMgr", Updatable)
local M = PlantDataMgr

function M:UpdataData(data)
    if self._plantData then
        self._IsRefrshModle = self._plantData.Stage < data.Stage
    end
    
    self._plantData = data
    self:_InitData()
    self:_IsUpdate()
end

function M:UpdataNextTime(time)
    self._nextTime = time.BugTime
    self._isPests = true
end

function M:ChangeState(state)
    self._curState = state
    self._IsRefrshModle = self._IsRefrshModle or self._curState == self._plantState.Fail
    
    EventMgr:Broadcast(UIMessageNames.DORM_PLANT_STATE, self._plantData.FurnitureId, self._IsRefrshModle)
end

function M:NextTime()
    return self._nextTime
end

function M:State()
    return self._curState
end

function M:Time()
    return self._rewardTime
end

function M:Config()
    return self._plantCfg
end

function M:Stage()
    return self._plantData.Stage
end

function M:_InitData()
    self._plantCfg = ConfigHelper.GetCfgByLua("furniturePlant", self._plantData.Id)
    self._isInstall = self._plantData.State
    self._rewardTime = self._plantData.CalcTick
    self:ChangeState(self._plantData.Stage)
end

function M:_IsUpdate()
    if self._isInstall > 0 then
        self:EnableUpdate(false)
        return 
    end
    
    self:EnableUpdate(true)
end

function M:IsFirst()
    return self._nextTime < self._rewardTime
end

function M:__init()
    self._nextTime = 0
    self._curState = 0
    self._isInstall = 1
    self._plantState = DormConst.PlantType
    self._isPests = false
    self:_IsUpdate()
end

function M:_PlantUp()
    if TimeUtil.GetNowTimeStamp() >= self._rewardTime then
        self:ChangeState(self._plantState.Water)
    end
end

function M:_PlantReward()
    if TimeUtil.GetNowTimeStamp() >= self._rewardTime then
        self:ChangeState(self._plantState.Reward)
    end
end

function M:Update()
    if self._curState == self._plantState.Fall then
        return 
    end
    
    if self._curState == self._plantState.Reward then
        return 
    end
    
    if self._curState == self._plantState.Water then
        return 
    end
    
    if TimeUtil.GetNowTimeStamp() >= self._nextTime and self._nextTime > 0 and self._isPests and self:IsFirst() then
        self:ChangeState(self._plantState.Fall)
        self._isPests = false
        return 
    end
    
    if self._curState == self._plantState.Complete then
        self:_PlantReward()
        return 
    end
    
    self:_PlantUp()
end





return PlantDataMgr
