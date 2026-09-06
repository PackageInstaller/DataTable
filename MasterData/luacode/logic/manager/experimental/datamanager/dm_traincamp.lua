local CLightTrainingCourse = BeanManager.GetTableByName("courtyard.clighttrainingcourse")
local TrainStatus = LuaNetManager.GetBeanDef("protocol.yard.train")
local DM_TrainCamp = class("DM_TrainCamp")

function DM_TrainCamp:Ctor()
  self._trainCamp = NekoData.Data.trainCamp
  self._trainCamp.level = 0
  self._trainCamp.trainInfo = {}
  self._trainCamp._workState = 0
  self._trainCamp._pauseNum = 0
  self._trainCamp._getNum = 0
  self._timeCheck = 1
  self._timeCount = 0
  self._trianTaskRecordMap = {}
  local allIds = CLightTrainingCourse:GetAllIds()
  for i = 1, #allIds do
    local record = CLightTrainingCourse:GetRecorder(allIds[i])
    self._trianTaskRecordMap[record.id] = record
  end
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_TrainCamp:Clear()
  self._trainCamp.level = 0
  for k, v in pairs(self._trainCamp.trainInfo) do
    self._trainCamp.trainInfo[k] = nil
  end
end

function DM_TrainCamp:OnSYardInfo(protocol)
  local trainInfo = protocol.trainRoom
  self._trainCamp.level = trainInfo.level
  for i, v in ipairs(trainInfo.trainList) do
    self._trainCamp.trainInfo[i - 1] = {
      index = i - 1,
      taskId = v.id,
      status = v.status,
      roleId = v.roleId,
      leftTime = v.leftTime
    }
  end
end

function DM_TrainCamp:OnSRefreshTrainRoom(protocol)
  for k, v in pairs(self._trainCamp.trainInfo) do
    self._trainCamp.trainInfo[k] = nil
  end
  local trainInfo = protocol.room
  self._trainCamp.level = trainInfo.level
  for i, v in ipairs(trainInfo.trainList) do
    self._trainCamp.trainInfo[i - 1] = {
      index = i - 1,
      taskId = v.id,
      status = v.status,
      roleId = v.roleId,
      leftTime = v.leftTime
    }
  end
end

function DM_TrainCamp:OnSStartTrain(protocol)
  local trainTaskInfo = self._trainCamp.trainInfo[protocol.index]
  if trainTaskInfo then
    trainTaskInfo.roleId = protocol.train.roleId
    trainTaskInfo.leftTime = protocol.train.leftTime
    trainTaskInfo.status = protocol.train.status
  else
    LogErrorFormat("DM_TrainCamp", "Cannot find data by index：%s.", protocol.index)
  end
end

function DM_TrainCamp:OnSCompleteTrain(protocol)
  local trainTaskInfo = self._trainCamp.trainInfo[protocol.index]
  if trainTaskInfo then
    trainTaskInfo.roleId = protocol.train.roleId
    trainTaskInfo.leftTime = protocol.train.leftTime
    trainTaskInfo.taskId = protocol.train.id
    trainTaskInfo.status = protocol.train.status
  else
    LogErrorFormat("DM_TrainCamp", "Cannot find data by index：%s.", protocol.index)
  end
end

function DM_TrainCamp:OnSSTopTrain(protocol)
  local trainTaskInfo = self._trainCamp.trainInfo[protocol.index]
  if trainTaskInfo then
    trainTaskInfo.roleId = 0
    trainTaskInfo.status = TrainStatus.UN_START
  else
    LogErrorFormat("DM_TrainCamp", "Cannot find data by index：%s.", protocol.index)
  end
end

function DM_TrainCamp:OnSArriveTrainTime(protocol)
  local trainTaskInfo = self._trainCamp.trainInfo[protocol.index]
  if trainTaskInfo then
    trainTaskInfo.taskId = protocol.train.id
    trainTaskInfo.roleId = protocol.train.roleId
    trainTaskInfo.status = protocol.train.status
    trainTaskInfo.leftTime = protocol.train.leftTime
  else
    LogErrorFormat("DM_TrainCamp", "Cannot find data by index：%s.", protocol.index)
  end
end

function DM_TrainCamp:OnUpdate(notification)
  if self._trainCamp.level == 0 then
    return
  end
  self._timeCount = self._timeCount + notification.userInfo.unscaledDeltaTime
  if self._timeCount < self._timeCheck then
    return
  end
  local check = self._timeCheck
  if notification.userInfo.unscaledDeltaTime > self._timeCheck then
    check = math.ceil(self._timeCount)
  end
  self._timeCount = self._timeCount - check
  local getNum = 0
  local pauseNum = 0
  local workState = 0
  for k, v in pairs(self._trainCamp.trainInfo) do
    if v.status == TrainStatus.UN_START then
      local record = self._trianTaskRecordMap[v.taskId]
      local costItemId = record.lightcostitem
      local haveNum
      if string.sub(costItemId, 1, 2) == "35" then
        haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(costItemId)
      else
        haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(costItemId)
      end
      if haveNum >= record.lightcostnum then
        pauseNum = pauseNum + 1
      end
    elseif v.status == TrainStatus.PROCESSING then
      workState = workState + 1
      local leftTime = v.leftTime
      if 0 < v.leftTime then
        v.leftTime = v.leftTime - check * 1000
        if 0 >= v.leftTime then
          local carrivetraintime = LuaNetManager.CreateProtocol("protocol.yard.carrivetraintime")
          carrivetraintime.index = k
          carrivetraintime:Send()
        end
      end
    elseif v.status == TrainStatus.COMPLETE then
      getNum = getNum + 1
    end
  end
  if self._trainCamp._workState ~= workState then
    self._trainCamp._workState = workState
    LuaNotificationCenter.PostNotification(Common.n_BuildingWorkStateChanged, nil, {
      buildingId = DataCommon.TrainCamp,
      state = self._trainCamp._workState
    })
  end
  if self._trainCamp._getNum ~= getNum then
    self._trainCamp._getNum = getNum
    LuaNotificationCenter.PostNotification(Common.n_BuildingGetNumChanged, nil, {
      buildingId = DataCommon.TrainCamp,
      state = self._trainCamp._getNum
    })
  end
  if self._trainCamp._pauseNum ~= pauseNum then
    self._trainCamp._pauseNum = pauseNum
    LuaNotificationCenter.PostNotification(Common.n_BuildingPauseTaskNumChanged, nil, {
      buildingId = DataCommon.TrainCamp,
      pauseTaskNum = self._trainCamp._pauseNum
    })
  end
end

return DM_TrainCamp
