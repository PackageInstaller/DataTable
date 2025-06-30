-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/task.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = class("Task")
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
local cmissiontypeconfig = (BeanManager.GetTableByName)("mission.cmissiontypeconfig")
local TaskTypeMap = {Story = (BeanManager.GetTableByName)("mission.cmissionconfig"), Daily = (BeanManager.GetTableByName)("mission.cdailymissionconfig"), Achievement = (BeanManager.GetTableByName)("mission.cachievemissionconfig"), GoldenDaily = (BeanManager.GetTableByName)("mission.cdailygoldenmissionconfig"), Character = (BeanManager.GetTableByName)("mission.ccharactermissionconfig"), Week = (BeanManager.GetTableByName)("mission.cweekmissionconfig"), SevenGrow = (BeanManager.GetTableByName)("mission.cactivemissionconfig"), Halloween = (BeanManager.GetTableByName)("mission.challoweenmission"), Puzzle = (BeanManager.GetTableByName)("mission.cjigsawmissionconfig"), DoubleEleven = (BeanManager.GetTableByName)("mission.celevenmissioncfg"), BirthDay = (BeanManager.GetTableByName)("mission.cloginmission"), ReturnBack = (BeanManager.GetTableByName)("mission.cbackmissionconfig"), CChildrensDayMission = (BeanManager.GetTableByName)("mission.cchildrensdaymission"), WeekBossAchievement = (BeanManager.GetTableByName)("dungeonselect.cweeklybossachievemissionconfig"), CFirstAnniversary = (BeanManager.GetTableByName)("mission.cfirstanniversarymission"), CActiveMissionMod = (BeanManager.GetTableByName)("mission.cactivemissionmod")}
Task.Ctor = function(self)
  -- function num : 0_0 , upvalues : Status
  self._id = -1
  self._status = Status.UNACCEPT
  self._type = nil
  self._cfg = nil
end

Task.InitFromProtocol = function(self, bean)
  -- function num : 0_1 , upvalues : _ENV, Status
  self:SetID(bean.taskid)
  self._status = bean.taskstatus
  self._acceptTime = bean.acceptTime
  self._isMultiProgress = #bean.conditions > 1
  self._progress = {}
  if (self._cfg).missiontype ~= 4 and (self._cfg).missiontype ~= 9 and (self._cfg).missiontype ~= 5 and (self._cfg).missiontype ~= 11 and (self._cfg).missiontype ~= 12 and (self._cfg).missiontype ~= 13 and (self._cfg).missiontype ~= 10 and (self._cfg).missiontype ~= 14 and (self._cfg).missiontype ~= 15 and (self._cfg).missiontype ~= 18 and (self._cfg).missiontype ~= 19 and (self._cfg).missiontype ~= 16 then
    for i,v in ipairs((self._cfg).progressnameTextID) do
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R7 in 'UnsetPending'

      (self._progress)[i] = {desc = (TextManager.GetText)(v), current = ((bean.conditions)[i]).value, total = ((bean.conditions)[i]).destValue, topmsgid = ((self._cfg).toptip)[i]}
    end
  else
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R2 in 'UnsetPending'

    (self._progress)[1] = {current = ((bean.conditions)[1]).value, total = ((bean.conditions)[1]).destValue}
  end
  self._visited = bean.visitable == 1
  self._isLock = self._status == Status.ACCEPTED
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

Task.GetID = function(self)
  -- function num : 0_2
  return self._id
end

Task.SetID = function(self, id)
  -- function num : 0_3 , upvalues : _ENV, TaskTypeMap, Item, cimagepath
  if self._id == id then
    return 
  end
  self._id = id
  local type, tbl = (table.first)(TaskTypeMap, function(k, v)
    -- function num : 0_3_0 , upvalues : id
    do return v:GetRecorder(id) ~= nil end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if not type then
    LogError("unknown task id " .. id)
    return 
  end
  self._cfgtype = type
  self._cfg = tbl:GetRecorder(id)
  self._awards = {}
  if (self._cfg).rewarditem then
    for i,v in ipairs((self._cfg).rewarditem) do
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R9 in 'UnsetPending'

      if v ~= 0 then
        (self._awards)[i] = (Item.Create)(tonumber(v))
        ;
        ((self._awards)[i]):SetCount(((self._cfg).rewardquantity)[i])
      end
    end
  end
  do
    do
      if (self._cfg).worldimg then
        local recorder = cimagepath:GetRecorder((self._cfg).worldimg)
        self._background = {assetBundle = recorder.assetBundle, assetName = recorder.assetName}
      end
      do
        if (self._cfg).roleimg then
          local recorder = cimagepath:GetRecorder((self._cfg).roleimg)
          self._photo = {assetBundle = recorder.assetBundle, assetName = recorder.assetName}
        end
        if (self._cfg).sortid then
          self._sortid = (self._cfg).sortid
        end
        if (self._cfg).unlockid then
          self._unlockTextId = (self._cfg).unlockid
        end
      end
    end
  end
end

Task.GetStatus = function(self)
  -- function num : 0_4
  return self._status
end

Task.SetStatus = function(self, status)
  -- function num : 0_5
  self._status = status
end

Task.GetType = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self._cfg then
    LogError("task", "access nonexisting task " .. tostring(self._id))
  end
  return (self._cfg).missiontype
end

Task.GetConfig = function(self)
  -- function num : 0_7
  return self._cfg
end

Task.IsSpecialDailyTask = function(self)
  -- function num : 0_8
  do return self._cfgtype == "GoldenDaily" end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Task.GetName = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (self._cfg).missionnameTextID then
    return (TextManager.GetText)((self._cfg).missionnameTextID)
  end
end

Task.GetDesc = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if (self._cfg).descriptionTextID then
    return (TextManager.GetText)((self._cfg).descriptionTextID)
  end
end

Task.GetShortDesc = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (self._cfg).short_descriptionTextID then
    return (TextManager.GetText)((self._cfg).short_descriptionTextID)
  end
end

Task.GetActiveValue = function(self)
  -- function num : 0_12
  return (self._cfg).activevalue or 0
end

Task.GetRewardID = function(self)
  -- function num : 0_13
  return (self._cfg).rewardid
end

Task.GetAcceptMsgID = function(self)
  -- function num : 0_14
  return (self._cfg).accept_mission
end

Task.GetBackground = function(self)
  -- function num : 0_15
  return self._background
end

Task.GetGroupID = function(self)
  -- function num : 0_16 , upvalues : cmissiontypeconfig
  local recorder = cmissiontypeconfig:GetRecorder((self._cfg).missiontype)
  return recorder.tab
end

Task.GetAcceptTime = function(self)
  -- function num : 0_17
  return self._acceptTime
end

Task.IsAutoCommit = function(self)
  -- function num : 0_18
  do return (self._cfg).rewardtype == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Task.GetHintText = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if (self._cfg).instructionTextID then
    return (TextManager.GetText)((self._cfg).instructionTextID)
  end
end

Task.GetHintLocation = function(self)
  -- function num : 0_20 , upvalues : _ENV
  do return not (self._cfg).locationTextID or (TextManager.GetText)((self._cfg).locationTextID) or "" end
end

Task.CanJump = function(self)
  -- function num : 0_21
  if (self._cfg).jumptype == 1 then
    return (self._cfg).jumpvalue
  else
    if (self._cfg).UIjumpvalue == 0 then
      do return (self._cfg).jumptype ~= 2 end
      do return false end
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

Task.GetJumpType = function(self)
  -- function num : 0_22
  return (self._cfg).jumptype
end

Task.IsNewTask = function(self)
  -- function num : 0_23
  return not self._visited
end

Task.SetNewTask = function(self, value)
  -- function num : 0_24
  self._visited = not value
end

Task.GetAcceptTriggerID = function(self)
  -- function num : 0_25
  return (self._cfg).startevent
end

Task.GetFinishTriggerID = function(self)
  -- function num : 0_26
  return (self._cfg).endevent
end

Task.GetFailTriggerID = function(self)
  -- function num : 0_27
  return (self._cfg).failevent
end

Task.GetProgress = function(self)
  -- function num : 0_28
  return self._progress
end

Task.GetAwards = function(self)
  -- function num : 0_29
  return self._awards
end

Task.GetRoleImage = function(self)
  -- function num : 0_30
  return self._photo
end

Task.GetSortID = function(self)
  -- function num : 0_31
  return self._sortid
end

Task.GetUnlockTextId = function(self)
  -- function num : 0_32
  return self._unlockTextId
end

Task.IsLock = function(self)
  -- function num : 0_33
  return self._isLock
end

Task.IsMultiProgress = function(self)
  -- function num : 0_34
  return self._isMultiProgress
end

return Task

