-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_traincamp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CLightTrainingCourse = (BeanManager.GetTableByName)("courtyard.clighttrainingcourse")
local TrainStatus = (LuaNetManager.GetBeanDef)("protocol.yard.train")
local DM_TrainCamp = class("DM_TrainCamp")
DM_TrainCamp.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CLightTrainingCourse
  self._trainCamp = (NekoData.Data).trainCamp
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._trainCamp).level = 0
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._trainCamp).trainInfo = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._trainCamp)._workState = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._trainCamp)._pauseNum = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._trainCamp)._getNum = 0
  self._timeCheck = 1
  self._timeCount = 0
  self._trianTaskRecordMap = {}
  local allIds = CLightTrainingCourse:GetAllIds()
  for i = 1, #allIds do
    local record = CLightTrainingCourse:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._trianTaskRecordMap)[record.id] = record
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_TrainCamp.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._trainCamp).level = 0
  for k,v in pairs((self._trainCamp).trainInfo) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    ((self._trainCamp).trainInfo)[k] = nil
  end
end

DM_TrainCamp.OnSYardInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  local trainInfo = protocol.trainRoom
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._trainCamp).level = trainInfo.level
  for i,v in ipairs(trainInfo.trainList) do
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

    ((self._trainCamp).trainInfo)[i - 1] = {index = i - 1, taskId = v.id, status = v.status, roleId = v.roleId, leftTime = v.leftTime}
  end
end

DM_TrainCamp.OnSRefreshTrainRoom = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  for k,v in pairs((self._trainCamp).trainInfo) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ((self._trainCamp).trainInfo)[k] = nil
  end
  local trainInfo = protocol.room
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._trainCamp).level = trainInfo.level
  for i,v in ipairs(trainInfo.trainList) do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

    ((self._trainCamp).trainInfo)[i - 1] = {index = i - 1, taskId = v.id, status = v.status, roleId = v.roleId, leftTime = v.leftTime}
  end
end

DM_TrainCamp.OnSStartTrain = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  local trainTaskInfo = ((self._trainCamp).trainInfo)[protocol.index]
  if trainTaskInfo then
    trainTaskInfo.roleId = (protocol.train).roleId
    trainTaskInfo.leftTime = (protocol.train).leftTime
    trainTaskInfo.status = (protocol.train).status
  else
    LogErrorFormat("DM_TrainCamp", "Cannot find data by index：%s.", protocol.index)
  end
end

DM_TrainCamp.OnSCompleteTrain = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  local trainTaskInfo = ((self._trainCamp).trainInfo)[protocol.index]
  if trainTaskInfo then
    trainTaskInfo.roleId = (protocol.train).roleId
    trainTaskInfo.leftTime = (protocol.train).leftTime
    trainTaskInfo.taskId = (protocol.train).id
    trainTaskInfo.status = (protocol.train).status
  else
    LogErrorFormat("DM_TrainCamp", "Cannot find data by index：%s.", protocol.index)
  end
end

DM_TrainCamp.OnSSTopTrain = function(self, protocol)
  -- function num : 0_6 , upvalues : TrainStatus, _ENV
  local trainTaskInfo = ((self._trainCamp).trainInfo)[protocol.index]
  if trainTaskInfo then
    trainTaskInfo.roleId = 0
    trainTaskInfo.status = TrainStatus.UN_START
  else
    LogErrorFormat("DM_TrainCamp", "Cannot find data by index：%s.", protocol.index)
  end
end

DM_TrainCamp.OnSArriveTrainTime = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  local trainTaskInfo = ((self._trainCamp).trainInfo)[protocol.index]
  if trainTaskInfo then
    trainTaskInfo.taskId = (protocol.train).id
    trainTaskInfo.roleId = (protocol.train).roleId
    trainTaskInfo.status = (protocol.train).status
    trainTaskInfo.leftTime = (protocol.train).leftTime
  else
    LogErrorFormat("DM_TrainCamp", "Cannot find data by index：%s.", protocol.index)
  end
end

DM_TrainCamp.OnUpdate = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV, TrainStatus
  if (self._trainCamp).level == 0 then
    return 
  end
  self._timeCount = self._timeCount + (notification.userInfo).unscaledDeltaTime
  if self._timeCount < self._timeCheck then
    return 
  end
  local check = self._timeCheck
  if self._timeCheck < (notification.userInfo).unscaledDeltaTime then
    check = (math.ceil)(self._timeCount)
  end
  self._timeCount = self._timeCount - check
  local getNum = 0
  local pauseNum = 0
  local workState = 0
  for k,v in pairs((self._trainCamp).trainInfo) do
    if v.status == TrainStatus.UN_START then
      local record = (self._trianTaskRecordMap)[v.taskId]
      local costItemId = record.lightcostitem
      local haveNum = nil
      if (string.sub)(costItemId, 1, 2) == "35" then
        haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(costItemId)
      else
        haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(costItemId)
      end
      if record.lightcostnum <= haveNum then
        pauseNum = pauseNum + 1
      end
    else
      do
        if v.status == TrainStatus.PROCESSING then
          workState = workState + 1
          local leftTime = v.leftTime
          if v.leftTime > 0 then
            v.leftTime = v.leftTime - check * 1000
            if v.leftTime <= 0 then
              local carrivetraintime = (LuaNetManager.CreateProtocol)("protocol.yard.carrivetraintime")
              carrivetraintime.index = k
              carrivetraintime:Send()
            end
          end
        else
          do
            do
              if v.status == TrainStatus.COMPLETE then
                getNum = getNum + 1
              end
              -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC110: Confused about usage of register: R6 in 'UnsetPending'

  if (self._trainCamp)._workState ~= workState then
    (self._trainCamp)._workState = workState
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingWorkStateChanged, nil, {buildingId = DataCommon.TrainCamp, state = (self._trainCamp)._workState})
  end
  -- DECOMPILER ERROR at PC129: Confused about usage of register: R6 in 'UnsetPending'

  if (self._trainCamp)._getNum ~= getNum then
    (self._trainCamp)._getNum = getNum
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingGetNumChanged, nil, {buildingId = DataCommon.TrainCamp, state = (self._trainCamp)._getNum})
  end
  -- DECOMPILER ERROR at PC148: Confused about usage of register: R6 in 'UnsetPending'

  if (self._trainCamp)._pauseNum ~= pauseNum then
    (self._trainCamp)._pauseNum = pauseNum
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingPauseTaskNumChanged, nil, {buildingId = DataCommon.TrainCamp, pauseTaskNum = (self._trainCamp)._pauseNum})
  end
end

return DM_TrainCamp

