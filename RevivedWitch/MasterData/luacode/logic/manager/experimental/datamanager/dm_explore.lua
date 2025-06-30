-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_explore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CExploreAreaCfg = (BeanManager.GetTableByName)("courtyard.cexplorearea")
local CExploreLvUpCfg = (BeanManager.GetTableByName)("courtyard.cexplorelvup")
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local CNotice = (BeanManager.GetTableByName)("notice.cnotice")
local Item = require("logic.manager.experimental.types.item")
local DM_Explore = class("DM_Explore")
DM_Explore.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._explore = (NekoData.Data).explore
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._explore).level = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._explore).refreshTimes = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._explore).refreshLeftTime = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._explore).slots = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._explore).roles = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._explore)._workState = 0
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._explore)._getNum = 0
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._explore)._pauseNum = 0
  self._refreshMaxTimes = 0
  self._timeCheck = 1
  self._timeCount = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_Explore.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._explore).level = 0
  do
    while ((self._explore).slots)[#(self._explore).slots] do
      local slot = ((self._explore).slots)[#(self._explore).slots]
      while (slot.roles)[#slot.roles] do
        (table.remove)(slot.roles, #slot.roles)
      end
      ;
      (table.remove)((self._explore).slots, #(self._explore).slots)
    end
    for k,v in pairs((self._explore).roles) do
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

      ((self._explore).roles)[k] = nil
    end
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._explore)._workState = 0
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._explore)._getNum = 0
    self._refreshMaxTimes = 0
  end
end

DM_Explore.OnSYardInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, CExploreLvUpCfg, SlotStateEnum, CExploreAreaCfg, Item, CNotice
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._explore).level = 0
  do
    while ((self._explore).slots)[#(self._explore).slots] do
      local slot = ((self._explore).slots)[#(self._explore).slots]
      while 1 do
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

        if (slot.roles)[#slot.roles] then
          ((self._explore).roles)[(slot.roles)[#slot.roles]] = nil
          ;
          (table.remove)(slot.roles, #slot.roles)
          -- DECOMPILER ERROR at PC35: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC35: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
      ;
      (table.remove)((self._explore).slots, #(self._explore).slots)
    end
    self._refreshMaxTimes = 0
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._explore).refreshTimes = (protocol.cavern).refreshNums
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._explore).refreshLeftTime = (protocol.cavern).leftRefreshTime
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._explore).level = (protocol.cavern).level
    local record = CExploreLvUpCfg:GetRecorder((self._explore).level)
    if record then
      self._refreshMaxTimes = record.refreshTimes
    end
    for k,v in pairs((protocol.cavern).tasks) do
      local slot = {}
      slot.slotId = v.Id
      slot.cavernId = v.cavernId
      slot.taskState = v.statue
      slot.getItems = {}
      if slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 then
        local exploreCavernRecord = CExploreAreaCfg:GetRecorder(slot.cavernId)
        if exploreCavernRecord then
          local item = (Item.Create)(exploreCavernRecord.mainItem)
          item:SetCount(0)
          ;
          (table.insert)(slot.getItems, item)
          for i,v in ipairs(exploreCavernRecord.secondaryItem) do
            local item = (Item.Create)(v)
            item:SetCount(0)
            ;
            (table.insert)(slot.getItems, item)
          end
        else
          do
            do
              LogErrorFormat("DM_Explore", "exploreCavern with id %s is not exist in cexplorearea", slot.cavernId)
              for i,value in ipairs(v.product) do
                for index,item in ipairs(slot.getItems) do
                  if value.itemId == item:GetID() then
                    item:SetCount(value.nums)
                  end
                end
              end
              slot.curCapacity = v.progress
              slot.nextGetLeftTime = v.leftReceiveTime
              slot.finishLeftTime = v.leftDeadline
              local needNotification = ((NekoData.BehaviorManager).BM_Game):GetIfNeedActivityExploreNotification()
              if slot.taskState == SlotStateEnum.LOCK or slot.cavernId == 0 or slot.taskState == SlotStateEnum.UNLOCKING or slot.taskState == SlotStateEnum.DEADLINE or slot.finishLeftTime <= 0 then
                local canTimerWorker = not needNotification
                do
                  do
                    if canTimerWorker then
                      local spiritNoticeRecorder = CNotice:GetRecorder(3)
                      LogInfoFormat("DM_Explore", "open the notification : scheduling activity explore worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "slot" .. tostring(v.Id), (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000)
                      ;
                      ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "slot" .. tostring(v.Id), (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000, (TextManager.GetText)(spiritNoticeRecorder.titleID))
                    end
                    slot.getRewardsTimes = v.exploreTimes
                    slot.roles = {}
                    for i,roleInfo in ipairs(v.roles) do
                      (table.insert)(slot.roles, roleInfo.roleId)
                      -- DECOMPILER ERROR at PC257: Confused about usage of register: R15 in 'UnsetPending'

                      ;
                      ((self._explore).roles)[roleInfo.roleId] = {roleKey = roleInfo.roleId, energy = roleInfo.energy / DataCommon.RoleEnergyRatio}
                    end
                    ;
                    (table.insert)((self._explore).slots, slot)
                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
      end
    end
    ;
    (table.sort)((self._explore).slots, function(a, b)
    -- function num : 0_2_0
    do return a.slotId < b.slotId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

DM_Explore.OnSRefreshCavern = function(self, protocol)
  -- function num : 0_3
  self:OnSYardInfo(protocol)
end

DM_Explore.OnSRefreshCavernTask = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV, SlotStateEnum, CExploreAreaCfg, Item, CNotice
  for i,slot in ipairs((self._explore).slots) do
    if slot.slotId == (protocol.task).Id then
      slot.cavernId = (protocol.task).cavernId
      slot.taskState = (protocol.task).statue
      while (slot.getItems)[#slot.getItems] do
        (table.remove)(slot.getItems, #slot.getItems)
      end
      if slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 then
        local exploreCavernRecord = CExploreAreaCfg:GetRecorder(slot.cavernId)
        if exploreCavernRecord then
          local item = (Item.Create)(exploreCavernRecord.mainItem)
          item:SetCount(0)
          ;
          (table.insert)(slot.getItems, item)
          for i,v in ipairs(exploreCavernRecord.secondaryItem) do
            local item = (Item.Create)(v)
            item:SetCount(0)
            ;
            (table.insert)(slot.getItems, item)
          end
        else
          do
            LogErrorFormat("DM_Explore", "exploreCavern with id %s is not exist in cexplorearea", slot.cavernId)
            for i,value in ipairs((protocol.task).product) do
              for index,item in ipairs(slot.getItems) do
                if value.itemId == item:GetID() then
                  item:SetCount(value.nums)
                end
              end
            end
            do
              slot.curCapacity = (protocol.task).progress
              slot.nextGetLeftTime = (protocol.task).leftReceiveTime
              slot.finishLeftTime = (protocol.task).leftDeadline
              local needNotification = ((NekoData.BehaviorManager).BM_Game):GetIfNeedActivityExploreNotification()
              if slot.taskState == SlotStateEnum.LOCK or slot.cavernId == 0 or slot.taskState == SlotStateEnum.UNLOCKING or slot.taskState == SlotStateEnum.DEADLINE or slot.finishLeftTime <= 0 then
                local canTimerWorker = not needNotification
                do
                  if canTimerWorker then
                    local spiritNoticeRecorder = CNotice:GetRecorder(3)
                    LogInfoFormat("DM_Explore", "open the notification : scheduling activity explore worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "slot" .. tostring((protocol.task).Id), (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000)
                    ;
                    ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "slot" .. tostring((protocol.task).Id), (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000, (TextManager.GetText)(spiritNoticeRecorder.titleID))
                  end
                  slot.getRewardsTimes = (protocol.task).exploreTimes
                  while 1 do
                    -- DECOMPILER ERROR at PC202: Confused about usage of register: R8 in 'UnsetPending'

                    if (slot.roles)[#slot.roles] then
                      ((self._explore).roles)[(slot.roles)[#slot.roles]] = nil
                      ;
                      (table.remove)(slot.roles, #slot.roles)
                      -- DECOMPILER ERROR at PC209: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC209: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                  for i,roleInfo in ipairs((protocol.task).roles) do
                    (table.insert)(slot.roles, roleInfo.roleId)
                    -- DECOMPILER ERROR at PC231: Confused about usage of register: R13 in 'UnsetPending'

                    ;
                    ((self._explore).roles)[roleInfo.roleId] = {roleKey = roleInfo.roleId, energy = roleInfo.energy / DataCommon.RoleEnergyRatio}
                  end
                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

DM_Explore.OnSRefreshCavernTaskActive = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, SlotStateEnum, CExploreAreaCfg, Item, CNotice
  for i,slot in ipairs((self._explore).slots) do
    local task = protocol.cavernTask
    if slot.slotId == task.Id then
      slot.cavernId = task.cavernId
      slot.taskState = task.statue
      while (slot.getItems)[#slot.getItems] do
        (table.remove)(slot.getItems, #slot.getItems)
      end
      if slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 then
        local exploreCavernRecord = CExploreAreaCfg:GetRecorder(slot.cavernId)
        if exploreCavernRecord then
          local item = (Item.Create)(exploreCavernRecord.mainItem)
          item:SetCount(0)
          ;
          (table.insert)(slot.getItems, item)
          for i,v in ipairs(exploreCavernRecord.secondaryItem) do
            local item = (Item.Create)(v)
            item:SetCount(0)
            ;
            (table.insert)(slot.getItems, item)
          end
        else
          do
            LogErrorFormat("DM_Explore", "exploreCavern with id %s is not exist in cexplorearea", slot.cavernId)
            for i,value in ipairs(task.product) do
              for index,item in ipairs(slot.getItems) do
                if value.itemId == item:GetID() then
                  item:SetCount(value.nums)
                end
              end
            end
            do
              slot.curCapacity = task.progress
              slot.nextGetLeftTime = task.leftReceiveTime
              slot.finishLeftTime = task.leftDeadline
              local needNotification = ((NekoData.BehaviorManager).BM_Game):GetIfNeedActivityExploreNotification()
              if slot.taskState == SlotStateEnum.LOCK or slot.cavernId == 0 or slot.taskState == SlotStateEnum.UNLOCKING or slot.taskState == SlotStateEnum.DEADLINE or slot.finishLeftTime <= 0 then
                local canTimerWorker = not needNotification
                do
                  if canTimerWorker then
                    local spiritNoticeRecorder = CNotice:GetRecorder(3)
                    LogInfoFormat("DM_Explore", "open the notification : scheduling activity explore worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "slot" .. tostring(task.Id), (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000)
                    ;
                    ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "slot" .. tostring(task.Id), (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000, (TextManager.GetText)(spiritNoticeRecorder.titleID))
                  end
                  slot.getRewardsTimes = task.exploreTimes
                  while 1 do
                    -- DECOMPILER ERROR at PC193: Confused about usage of register: R9 in 'UnsetPending'

                    if (slot.roles)[#slot.roles] then
                      ((self._explore).roles)[(slot.roles)[#slot.roles]] = nil
                      ;
                      (table.remove)(slot.roles, #slot.roles)
                      -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                  for i,roleInfo in ipairs(task.roles) do
                    (table.insert)(slot.roles, ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleInfo.roleId))
                    -- DECOMPILER ERROR at PC226: Confused about usage of register: R14 in 'UnsetPending'

                    ;
                    ((self._explore).roles)[roleInfo.roleId] = {roleKey = roleInfo.roleId, energy = roleInfo.energy / DataCommon.RoleEnergyRatio}
                  end
                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC233: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._explore).refreshTimes = protocol.nums
  -- DECOMPILER ERROR at PC236: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._explore).refreshLeftTime = protocol.leftRefreshTime
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

DM_Explore.OnSSySynchronizationRefreshNums = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._explore).refreshTimes = protocol.nums
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._explore).refreshLeftTime = protocol.leftRefreshTime
end

DM_Explore.OnUpdate = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV, SlotStateEnum
  if (self._explore).level == 0 then
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
  local pauseTaskNum = 0
  for i,slot in ipairs((self._explore).slots) do
    if slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 then
      if slot.taskState ~= SlotStateEnum.UNLOCKING then
        if slot.taskState == SlotStateEnum.DEADLINE then
          getNum = getNum + 1
        end
        if slot.taskState ~= SlotStateEnum.DEADLINE then
          if #slot.roles > 0 then
            local finishLeftTime = slot.finishLeftTime
            local nextGetLeftTime = slot.nextGetLeftTime
            if slot.finishLeftTime >= 0 and slot.nextGetLeftTime >= 0 then
              slot.finishLeftTime = slot.finishLeftTime - check * 1000
              slot.nextGetLeftTime = slot.nextGetLeftTime - check * 1000
            else
              if slot.finishLeftTime >= 0 then
                slot.finishLeftTime = slot.finishLeftTime - check * 1000
              else
                if slot.nextGetLeftTime >= 0 then
                  slot.nextGetLeftTime = slot.nextGetLeftTime - check * 1000
                end
              end
            end
            do
              do
                do
                  if (finishLeftTime >= 0 and slot.finishLeftTime < 0) or nextGetLeftTime >= 0 and slot.nextGetLeftTime < 0 then
                    local CSynchronizationCavernTask = (LuaNetManager.CreateProtocol)("protocol.yard.csynchronizationcaverntask")
                    CSynchronizationCavernTask.id = slot.slotId
                    CSynchronizationCavernTask:Send()
                  end
                  if num ~= -1 then
                    num = num + 1
                  end
                  pauseTaskNum = pauseTaskNum + 1
                  num = -1
                  pauseTaskNum = pauseTaskNum + 1
                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC126: Confused about usage of register: R6 in 'UnsetPending'

  if (self._explore)._workState ~= num then
    (self._explore)._workState = num
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingWorkStateChanged, nil, {buildingId = DataCommon.Explore, state = (self._explore)._workState})
  end
  -- DECOMPILER ERROR at PC145: Confused about usage of register: R6 in 'UnsetPending'

  if (self._explore)._getNum ~= getNum then
    (self._explore)._getNum = getNum
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingGetNumChanged, nil, {buildingId = DataCommon.Explore, state = (self._explore)._getNum})
  end
  -- DECOMPILER ERROR at PC164: Confused about usage of register: R6 in 'UnsetPending'

  if (self._explore)._pauseNum ~= pauseTaskNum then
    (self._explore)._pauseNum = pauseTaskNum
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingPauseTaskNumChanged, nil, {buildingId = DataCommon.Explore, pauseTaskNum = (self._explore)._pauseNum})
  end
  -- DECOMPILER ERROR at PC192: Confused about usage of register: R6 in 'UnsetPending'

  if (self._explore).refreshTimes < self._refreshMaxTimes and (self._explore).refreshLeftTime > 0 then
    (self._explore).refreshLeftTime = (self._explore).refreshLeftTime - check * 1000
    if (self._explore).refreshLeftTime <= 0 then
      local csySynchronizationRefreshNums = (LuaNetManager.CreateProtocol)("protocol.yard.csysynchronizationrefreshnums")
      csySynchronizationRefreshNums:Send()
    end
  end
end

return DM_Explore

