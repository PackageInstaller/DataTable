-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_magictree.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local DM_MagicTree = class("DM_MagicTree")
DM_MagicTree.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CCourtyardLvUpCfg
  self._magicTree = (NekoData.Data).magicTree
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree).level = 0
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree).tasks = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree).levelUpSpeed = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree)._workState = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree)._getNum = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree).buildingPlots = {}
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree).buildingPlotMap = {}
  self._timeCheck = 1
  self._timeCount = 0
  self._taskRecordMap = {}
  local allIds = CCourtyardLvUpCfg:GetAllIds()
  for i = 1, #allIds do
    local record = CCourtyardLvUpCfg:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._taskRecordMap)[record.id] = record
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_MagicTree.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._magicTree).level = 0
  while ((self._magicTree).tasks)[#(self._magicTree).tasks] do
    (table.remove)((self._magicTree).tasks, #(self._magicTree).tasks)
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree).levelUpSpeed = 0
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree)._workState = 0
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree)._getNum = 0
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._magicTree).buildingPlots = {}
end

DM_MagicTree.OnSYardInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, CCourtyardNameCfg
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._magicTree).level = 0
  while ((self._magicTree).tasks)[#(self._magicTree).tasks] do
    (table.remove)((self._magicTree).tasks, #(self._magicTree).tasks)
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._magicTree).levelUpSpeed = 0
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._magicTree).level = (protocol.magicTree).level
  for k,v in pairs((protocol.magicTree).tasks) do
    local task = {}
    task.buildingId = v.buildId
    task.taskId = v.buildLvId
    task.taskState = v.statue
    task.curProgress = v.progress
    task.leftTime = v.leftTime
    ;
    (table.insert)((self._magicTree).tasks, task)
  end
  ;
  (table.sort)((self._magicTree).tasks, function(a, b)
    -- function num : 0_2_0 , upvalues : CCourtyardNameCfg
    local a_record = CCourtyardNameCfg:GetRecorder(a.buildingId)
    local b_record = CCourtyardNameCfg:GetRecorder(b.buildingId)
    do return a_record.sortID < b_record.sortID end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._magicTree).levelUpSpeed = (protocol.magicTree).speed
end

DM_MagicTree.OnSRefreshMagicTree = function(self, protocol)
  -- function num : 0_3
  self:OnSYardInfo(protocol)
end

DM_MagicTree.OnSRefreshTask = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  for i,task in ipairs((self._magicTree).tasks) do
    if task.buildingId == (protocol.task).buildId then
      task.taskId = (protocol.task).buildLvId
      task.taskState = (protocol.task).statue
      task.curProgress = (protocol.task).progress
      task.leftTime = (protocol.task).leftTime
    end
  end
end

DM_MagicTree.OnUpdate = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, TaskStateEnum
  if (self._magicTree).level == 0 then
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
  local num = 0
  local getNum = 0
  for i,task in ipairs((self._magicTree).tasks) do
    if task.taskId ~= 0 then
      if task.taskState ~= TaskStateEnum.LOCK then
        if task.taskState == TaskStateEnum.UnReceive then
          getNum = getNum + 1
        else
          if task.taskState == TaskStateEnum.PROCESSING then
            if task.leftTime >= 0 then
              task.leftTime = task.leftTime - check * 1000
              if task.leftTime < 0 then
                local CArriveCompleteTime = (LuaNetManager.CreateProtocol)("protocol.yard.carrivecompletetime")
                CArriveCompleteTime.id = task.buildingId
                CArriveCompleteTime:Send()
              end
            end
            do
              num = num + 1
              local taskRecord = (self._taskRecordMap)[task.taskId]
              do
                if taskRecord.openCondition <= (self._magicTree).level then
                  local itemsEnough = true
                  for i,v in ipairs(taskRecord.items) do
                    local haveNum = 0
                    if (string.sub)(v, 1, 2) == "35" then
                      haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(v)
                    else
                      haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v)
                    end
                    if itemsEnough and haveNum < (taskRecord.nums)[i] then
                      itemsEnough = false
                    end
                  end
                  if itemsEnough then
                    getNum = getNum + 1
                  end
                end
                do
                  local taskRecord = (self._taskRecordMap)[task.taskId]
                  if taskRecord.openCondition <= (self._magicTree).level then
                    getNum = getNum + 1
                  end
                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC132: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC139: Confused about usage of register: R5 in 'UnsetPending'

  if (self._magicTree)._workState ~= num then
    (self._magicTree)._workState = num
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingWorkStateChanged, nil, {buildingId = DataCommon.MagicTree, state = (self._magicTree)._workState})
  end
  -- DECOMPILER ERROR at PC158: Confused about usage of register: R5 in 'UnsetPending'

  if (self._magicTree)._getNum ~= getNum then
    (self._magicTree)._getNum = getNum
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingGetNumChanged, nil, {buildingId = DataCommon.MagicTree, state = (self._magicTree)._getNum})
  end
end

return DM_MagicTree

