local CCourtyardNameCfg = BeanManager.GetTableByName("courtyard.ccourtyardname")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local TaskStateEnum = LuaNetManager.GetBeanDef("protocol.yard.task")
local DM_MagicTree = class("DM_MagicTree")

function DM_MagicTree:Ctor()
  self._magicTree = NekoData.Data.magicTree
  self._magicTree.level = 0
  self._magicTree.tasks = {}
  self._magicTree.levelUpSpeed = 0
  self._magicTree._workState = 0
  self._magicTree._getNum = 0
  self._magicTree.buildingPlots = {}
  self._magicTree.buildingPlotMap = {}
  self._timeCheck = 1
  self._timeCount = 0
  self._taskRecordMap = {}
  local allIds = CCourtyardLvUpCfg:GetAllIds()
  for i = 1, #allIds do
    local record = CCourtyardLvUpCfg:GetRecorder(allIds[i])
    self._taskRecordMap[record.id] = record
  end
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_MagicTree:Clear()
  self._magicTree.level = 0
  while self._magicTree.tasks[#self._magicTree.tasks] do
    table.remove(self._magicTree.tasks, #self._magicTree.tasks)
  end
  self._magicTree.levelUpSpeed = 0
  self._magicTree._workState = 0
  self._magicTree._getNum = 0
  self._magicTree.buildingPlots = {}
end

function DM_MagicTree:OnSYardInfo(protocol)
  self._magicTree.level = 0
  while self._magicTree.tasks[#self._magicTree.tasks] do
    table.remove(self._magicTree.tasks, #self._magicTree.tasks)
  end
  self._magicTree.levelUpSpeed = 0
  self._magicTree.level = protocol.magicTree.level
  for k, v in pairs(protocol.magicTree.tasks) do
    local task = {}
    task.buildingId = v.buildId
    task.taskId = v.buildLvId
    task.taskState = v.statue
    task.curProgress = v.progress
    task.leftTime = v.leftTime
    table.insert(self._magicTree.tasks, task)
  end
  table.sort(self._magicTree.tasks, function(a, b)
    local a_record = CCourtyardNameCfg:GetRecorder(a.buildingId)
    local b_record = CCourtyardNameCfg:GetRecorder(b.buildingId)
    return a_record.sortID < b_record.sortID
  end)
  self._magicTree.levelUpSpeed = protocol.magicTree.speed
end

function DM_MagicTree:OnSRefreshMagicTree(protocol)
  self:OnSYardInfo(protocol)
end

function DM_MagicTree:OnSRefreshTask(protocol)
  for i, task in ipairs(self._magicTree.tasks) do
    if task.buildingId == protocol.task.buildId then
      task.taskId = protocol.task.buildLvId
      task.taskState = protocol.task.statue
      task.curProgress = protocol.task.progress
      task.leftTime = protocol.task.leftTime
    end
  end
end

function DM_MagicTree:OnUpdate(notification)
  if self._magicTree.level == 0 then
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
  local num = 0
  local getNum = 0
  for i, task in ipairs(self._magicTree.tasks) do
    if task.taskId ~= 0 then
      if task.taskState ~= TaskStateEnum.LOCK then
        if task.taskState == TaskStateEnum.UnReceive then
          getNum = getNum + 1
        elseif task.taskState == TaskStateEnum.PROCESSING then
          if 0 <= task.leftTime then
            task.leftTime = task.leftTime - check * 1000
            if 0 > task.leftTime then
              local CArriveCompleteTime = LuaNetManager.CreateProtocol("protocol.yard.carrivecompletetime")
              CArriveCompleteTime.id = task.buildingId
              CArriveCompleteTime:Send()
            end
          end
          num = num + 1
        else
          local taskRecord = self._taskRecordMap[task.taskId]
          if self._magicTree.level >= taskRecord.openCondition then
            local itemsEnough = true
            for i, v in ipairs(taskRecord.items) do
              local haveNum = 0
              if string.sub(v, 1, 2) == "35" then
                haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(v)
              else
                haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
              end
              if itemsEnough and haveNum < taskRecord.nums[i] then
                itemsEnough = false
              end
            end
            if itemsEnough then
              getNum = getNum + 1
            end
          end
        end
      else
        local taskRecord = self._taskRecordMap[task.taskId]
        if self._magicTree.level >= taskRecord.openCondition then
          getNum = getNum + 1
        end
      end
    end
  end
  if self._magicTree._workState ~= num then
    self._magicTree._workState = num
    LuaNotificationCenter.PostNotification(Common.n_BuildingWorkStateChanged, nil, {
      buildingId = DataCommon.MagicTree,
      state = self._magicTree._workState
    })
  end
  if self._magicTree._getNum ~= getNum then
    self._magicTree._getNum = getNum
    LuaNotificationCenter.PostNotification(Common.n_BuildingGetNumChanged, nil, {
      buildingId = DataCommon.MagicTree,
      state = self._magicTree._getNum
    })
  end
end

return DM_MagicTree
