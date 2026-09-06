local CExploreAreaCfg = BeanManager.GetTableByName("courtyard.cexplorearea")
local CExploreLvUpCfg = BeanManager.GetTableByName("courtyard.cexplorelvup")
local SlotStateEnum = LuaNetManager.GetBeanDef("protocol.yard.caverntask")
local CNotice = BeanManager.GetTableByName("notice.cnotice")
local Item = require("logic.manager.experimental.types.item")
local DM_Explore = class("DM_Explore")

function DM_Explore:Ctor()
  self._explore = NekoData.Data.explore
  self._explore.level = 0
  self._explore.refreshTimes = 0
  self._explore.refreshLeftTime = 0
  self._explore.slots = {}
  self._explore.roles = {}
  self._explore._workState = 0
  self._explore._getNum = 0
  self._explore._pauseNum = 0
  self._refreshMaxTimes = 0
  self._timeCheck = 1
  self._timeCount = 0
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_Explore:Clear()
  self._explore.level = 0
  while self._explore.slots[#self._explore.slots] do
    local slot = self._explore.slots[#self._explore.slots]
    while slot.roles[#slot.roles] do
      table.remove(slot.roles, #slot.roles)
    end
    table.remove(self._explore.slots, #self._explore.slots)
  end
  for k, v in pairs(self._explore.roles) do
    self._explore.roles[k] = nil
  end
  self._explore._workState = 0
  self._explore._getNum = 0
  self._refreshMaxTimes = 0
end

function DM_Explore:OnSYardInfo(protocol)
  self._explore.level = 0
  while self._explore.slots[#self._explore.slots] do
    local slot = self._explore.slots[#self._explore.slots]
    while slot.roles[#slot.roles] do
      self._explore.roles[slot.roles[#slot.roles]] = nil
      table.remove(slot.roles, #slot.roles)
    end
    table.remove(self._explore.slots, #self._explore.slots)
  end
  self._refreshMaxTimes = 0
  self._explore.refreshTimes = protocol.cavern.refreshNums
  self._explore.refreshLeftTime = protocol.cavern.leftRefreshTime
  self._explore.level = protocol.cavern.level
  local record = CExploreLvUpCfg:GetRecorder(self._explore.level)
  if record then
    self._refreshMaxTimes = record.refreshTimes
  end
  for k, v in pairs(protocol.cavern.tasks) do
    local slot = {}
    slot.slotId = v.Id
    slot.cavernId = v.cavernId
    slot.taskState = v.statue
    slot.getItems = {}
    if slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 then
      local exploreCavernRecord = CExploreAreaCfg:GetRecorder(slot.cavernId)
      if exploreCavernRecord then
        local item = Item.Create(exploreCavernRecord.mainItem)
        item:SetCount(0)
        table.insert(slot.getItems, item)
        for i, v in ipairs(exploreCavernRecord.secondaryItem) do
          local item = Item.Create(v)
          item:SetCount(0)
          table.insert(slot.getItems, item)
        end
      else
        LogErrorFormat("DM_Explore", "exploreCavern with id %s is not exist in cexplorearea", slot.cavernId)
      end
    end
    for i, value in ipairs(v.product) do
      for index, item in ipairs(slot.getItems) do
        if value.itemId == item:GetID() then
          item:SetCount(value.nums)
        end
      end
    end
    slot.curCapacity = v.progress
    slot.nextGetLeftTime = v.leftReceiveTime
    slot.finishLeftTime = v.leftDeadline
    local needNotification = NekoData.BehaviorManager.BM_Game:GetIfNeedActivityExploreNotification()
    if needNotification then
      local canTimerWorker = slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 and slot.taskState ~= SlotStateEnum.UNLOCKING and slot.taskState ~= SlotStateEnum.DEADLINE and 0 < slot.finishLeftTime
      if canTimerWorker then
        local spiritNoticeRecorder = CNotice:GetRecorder(3)
        LogInfoFormat("DM_Explore", "open the notification : scheduling activity explore worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "slot" .. tostring(v.Id), TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000)
        CS.PixelNeko.Lua.SchedulingPushStaticFunctions.SetPushNotification(spiritNoticeRecorder.id, "slot" .. tostring(v.Id), TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000, TextManager.GetText(spiritNoticeRecorder.titleID))
      end
    end
    slot.getRewardsTimes = v.exploreTimes
    slot.roles = {}
    for i, roleInfo in ipairs(v.roles) do
      table.insert(slot.roles, roleInfo.roleId)
      self._explore.roles[roleInfo.roleId] = {
        roleKey = roleInfo.roleId,
        energy = roleInfo.energy / DataCommon.RoleEnergyRatio
      }
    end
    table.insert(self._explore.slots, slot)
  end
  table.sort(self._explore.slots, function(a, b)
    return a.slotId < b.slotId
  end)
end

function DM_Explore:OnSRefreshCavern(protocol)
  self:OnSYardInfo(protocol)
end

function DM_Explore:OnSRefreshCavernTask(protocol)
  for i, slot in ipairs(self._explore.slots) do
    if slot.slotId == protocol.task.Id then
      slot.cavernId = protocol.task.cavernId
      slot.taskState = protocol.task.statue
      while slot.getItems[#slot.getItems] do
        table.remove(slot.getItems, #slot.getItems)
      end
      if slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 then
        local exploreCavernRecord = CExploreAreaCfg:GetRecorder(slot.cavernId)
        if exploreCavernRecord then
          local item = Item.Create(exploreCavernRecord.mainItem)
          item:SetCount(0)
          table.insert(slot.getItems, item)
          for i, v in ipairs(exploreCavernRecord.secondaryItem) do
            local item = Item.Create(v)
            item:SetCount(0)
            table.insert(slot.getItems, item)
          end
        else
          LogErrorFormat("DM_Explore", "exploreCavern with id %s is not exist in cexplorearea", slot.cavernId)
        end
        for i, value in ipairs(protocol.task.product) do
          for index, item in ipairs(slot.getItems) do
            if value.itemId == item:GetID() then
              item:SetCount(value.nums)
            end
          end
        end
      end
      slot.curCapacity = protocol.task.progress
      slot.nextGetLeftTime = protocol.task.leftReceiveTime
      slot.finishLeftTime = protocol.task.leftDeadline
      local needNotification = NekoData.BehaviorManager.BM_Game:GetIfNeedActivityExploreNotification()
      if needNotification then
        local canTimerWorker = slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 and slot.taskState ~= SlotStateEnum.UNLOCKING and slot.taskState ~= SlotStateEnum.DEADLINE and 0 < slot.finishLeftTime
        if canTimerWorker then
          local spiritNoticeRecorder = CNotice:GetRecorder(3)
          LogInfoFormat("DM_Explore", "open the notification : scheduling activity explore worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "slot" .. tostring(protocol.task.Id), TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000)
          CS.PixelNeko.Lua.SchedulingPushStaticFunctions.SetPushNotification(spiritNoticeRecorder.id, "slot" .. tostring(protocol.task.Id), TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000, TextManager.GetText(spiritNoticeRecorder.titleID))
        end
      end
      slot.getRewardsTimes = protocol.task.exploreTimes
      while slot.roles[#slot.roles] do
        self._explore.roles[slot.roles[#slot.roles]] = nil
        table.remove(slot.roles, #slot.roles)
      end
      for i, roleInfo in ipairs(protocol.task.roles) do
        table.insert(slot.roles, roleInfo.roleId)
        self._explore.roles[roleInfo.roleId] = {
          roleKey = roleInfo.roleId,
          energy = roleInfo.energy / DataCommon.RoleEnergyRatio
        }
      end
    end
  end
end

function DM_Explore:OnSRefreshCavernTaskActive(protocol)
  for i, slot in ipairs(self._explore.slots) do
    local task = protocol.cavernTask
    if slot.slotId == task.Id then
      slot.cavernId = task.cavernId
      slot.taskState = task.statue
      while slot.getItems[#slot.getItems] do
        table.remove(slot.getItems, #slot.getItems)
      end
      if slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 then
        local exploreCavernRecord = CExploreAreaCfg:GetRecorder(slot.cavernId)
        if exploreCavernRecord then
          local item = Item.Create(exploreCavernRecord.mainItem)
          item:SetCount(0)
          table.insert(slot.getItems, item)
          for i, v in ipairs(exploreCavernRecord.secondaryItem) do
            local item = Item.Create(v)
            item:SetCount(0)
            table.insert(slot.getItems, item)
          end
        else
          LogErrorFormat("DM_Explore", "exploreCavern with id %s is not exist in cexplorearea", slot.cavernId)
        end
        for i, value in ipairs(task.product) do
          for index, item in ipairs(slot.getItems) do
            if value.itemId == item:GetID() then
              item:SetCount(value.nums)
            end
          end
        end
      end
      slot.curCapacity = task.progress
      slot.nextGetLeftTime = task.leftReceiveTime
      slot.finishLeftTime = task.leftDeadline
      local needNotification = NekoData.BehaviorManager.BM_Game:GetIfNeedActivityExploreNotification()
      if needNotification then
        local canTimerWorker = slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 and slot.taskState ~= SlotStateEnum.UNLOCKING and slot.taskState ~= SlotStateEnum.DEADLINE and 0 < slot.finishLeftTime
        if canTimerWorker then
          local spiritNoticeRecorder = CNotice:GetRecorder(3)
          LogInfoFormat("DM_Explore", "open the notification : scheduling activity explore worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "slot" .. tostring(task.Id), TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000)
          CS.PixelNeko.Lua.SchedulingPushStaticFunctions.SetPushNotification(spiritNoticeRecorder.id, "slot" .. tostring(task.Id), TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000, TextManager.GetText(spiritNoticeRecorder.titleID))
        end
      end
      slot.getRewardsTimes = task.exploreTimes
      while slot.roles[#slot.roles] do
        self._explore.roles[slot.roles[#slot.roles]] = nil
        table.remove(slot.roles, #slot.roles)
      end
      for i, roleInfo in ipairs(task.roles) do
        table.insert(slot.roles, NekoData.BehaviorManager.BM_AllRoles:GetRole(roleInfo.roleId))
        self._explore.roles[roleInfo.roleId] = {
          roleKey = roleInfo.roleId,
          energy = roleInfo.energy / DataCommon.RoleEnergyRatio
        }
      end
    end
  end
  self._explore.refreshTimes = protocol.nums
  self._explore.refreshLeftTime = protocol.leftRefreshTime
end

function DM_Explore:OnSSySynchronizationRefreshNums(protocol)
  self._explore.refreshTimes = protocol.nums
  self._explore.refreshLeftTime = protocol.leftRefreshTime
end

function DM_Explore:OnUpdate(notification)
  if self._explore.level == 0 then
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
  local pauseTaskNum = 0
  for i, slot in ipairs(self._explore.slots) do
    if slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 then
      if slot.taskState ~= SlotStateEnum.UNLOCKING then
        if slot.taskState == SlotStateEnum.DEADLINE then
          getNum = getNum + 1
        end
        if slot.taskState ~= SlotStateEnum.DEADLINE then
          if 0 < #slot.roles then
            local finishLeftTime = slot.finishLeftTime
            local nextGetLeftTime = slot.nextGetLeftTime
            if 0 <= slot.finishLeftTime and 0 <= slot.nextGetLeftTime then
              slot.finishLeftTime = slot.finishLeftTime - check * 1000
              slot.nextGetLeftTime = slot.nextGetLeftTime - check * 1000
            elseif 0 <= slot.finishLeftTime then
              slot.finishLeftTime = slot.finishLeftTime - check * 1000
            elseif 0 <= slot.nextGetLeftTime then
              slot.nextGetLeftTime = slot.nextGetLeftTime - check * 1000
            end
            if 0 <= finishLeftTime and 0 > slot.finishLeftTime or 0 <= nextGetLeftTime and 0 > slot.nextGetLeftTime then
              local CSynchronizationCavernTask = LuaNetManager.CreateProtocol("protocol.yard.csynchronizationcaverntask")
              CSynchronizationCavernTask.id = slot.slotId
              CSynchronizationCavernTask:Send()
            end
            if num ~= -1 then
              num = num + 1
            end
          else
            pauseTaskNum = pauseTaskNum + 1
            num = -1
          end
        end
      else
        pauseTaskNum = pauseTaskNum + 1
      end
    end
  end
  if self._explore._workState ~= num then
    self._explore._workState = num
    LuaNotificationCenter.PostNotification(Common.n_BuildingWorkStateChanged, nil, {
      buildingId = DataCommon.Explore,
      state = self._explore._workState
    })
  end
  if self._explore._getNum ~= getNum then
    self._explore._getNum = getNum
    LuaNotificationCenter.PostNotification(Common.n_BuildingGetNumChanged, nil, {
      buildingId = DataCommon.Explore,
      state = self._explore._getNum
    })
  end
  if self._explore._pauseNum ~= pauseTaskNum then
    self._explore._pauseNum = pauseTaskNum
    LuaNotificationCenter.PostNotification(Common.n_BuildingPauseTaskNumChanged, nil, {
      buildingId = DataCommon.Explore,
      pauseTaskNum = self._explore._pauseNum
    })
  end
  if self._explore.refreshTimes < self._refreshMaxTimes and 0 < self._explore.refreshLeftTime then
    self._explore.refreshLeftTime = self._explore.refreshLeftTime - check * 1000
    if 0 >= self._explore.refreshLeftTime then
      local csySynchronizationRefreshNums = LuaNetManager.CreateProtocol("protocol.yard.csysynchronizationrefreshnums")
      csySynchronizationRefreshNums:Send()
    end
  end
end

return DM_Explore
