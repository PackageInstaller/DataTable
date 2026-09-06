local Task = class("Task")
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")
local cmissiontypeconfig = BeanManager.GetTableByName("mission.cmissiontypeconfig")
local TaskTypeMap = {
  Story = BeanManager.GetTableByName("mission.cmissionconfig"),
  Daily = BeanManager.GetTableByName("mission.cdailymissionconfig"),
  Achievement = BeanManager.GetTableByName("mission.cachievemissionconfig"),
  GoldenDaily = BeanManager.GetTableByName("mission.cdailygoldenmissionconfig"),
  Character = BeanManager.GetTableByName("mission.ccharactermissionconfig"),
  Week = BeanManager.GetTableByName("mission.cweekmissionconfig"),
  SevenGrow = BeanManager.GetTableByName("mission.cactivemissionconfig"),
  Halloween = BeanManager.GetTableByName("mission.challoweenmission"),
  Puzzle = BeanManager.GetTableByName("mission.cjigsawmissionconfig"),
  DoubleEleven = BeanManager.GetTableByName("mission.celevenmissioncfg"),
  BirthDay = BeanManager.GetTableByName("mission.cloginmission"),
  ReturnBack = BeanManager.GetTableByName("mission.cbackmissionconfig"),
  CChildrensDayMission = BeanManager.GetTableByName("mission.cchildrensdaymission"),
  WeekBossAchievement = BeanManager.GetTableByName("dungeonselect.cweeklybossachievemissionconfig"),
  CFirstAnniversary = BeanManager.GetTableByName("mission.cfirstanniversarymission"),
  CActiveMissionMod = BeanManager.GetTableByName("mission.cactivemissionmod")
}

function Task:Ctor()
  self._id = -1
  self._status = Status.UNACCEPT
  self._type = nil
  self._cfg = nil
end

function Task:InitFromProtocol(bean)
  self:SetID(bean.taskid)
  self._status = bean.taskstatus
  self._acceptTime = bean.acceptTime
  self._isMultiProgress = #bean.conditions > 1
  self._progress = {}
  if self._cfg.missiontype ~= 4 and self._cfg.missiontype ~= 9 and self._cfg.missiontype ~= 5 and self._cfg.missiontype ~= 11 and self._cfg.missiontype ~= 12 and self._cfg.missiontype ~= 13 and self._cfg.missiontype ~= 10 and self._cfg.missiontype ~= 14 and self._cfg.missiontype ~= 15 and self._cfg.missiontype ~= 18 and self._cfg.missiontype ~= 19 and self._cfg.missiontype ~= 16 then
    for i, v in ipairs(self._cfg.progressnameTextID) do
      self._progress[i] = {
        desc = TextManager.GetText(v),
        current = bean.conditions[i].value,
        total = bean.conditions[i].destValue,
        topmsgid = self._cfg.toptip[i]
      }
    end
  elseif bean.conditions[1] then
    self._progress[1] = {
      current = bean.conditions[1].value,
      total = bean.conditions[1].destValue
    }
  else
    self._progress[1] = {current = 0, total = 0}
  end
  self._visited = bean.visitable == 1
  self._isLock = self._status == Status.ACCEPTED
end

function Task:GetID()
  return self._id
end

function Task:SetID(id)
  if self._id == id then
    return
  end
  self._id = id
  local type, tbl = table.first(TaskTypeMap, function(k, v)
    return v:GetRecorder(id) ~= nil
  end)
  if not type then
    LogError("unknown task id " .. id)
    return
  end
  self._cfgtype = type
  self._cfg = tbl:GetRecorder(id)
  self._awards = {}
  if self._cfg.rewarditem then
    for i, v in ipairs(self._cfg.rewarditem) do
      if v ~= 0 then
        self._awards[i] = Item.Create(tonumber(v))
        self._awards[i]:SetCount(self._cfg.rewardquantity[i])
      end
    end
  end
  if self._cfg.worldimg then
    local recorder = cimagepath:GetRecorder(self._cfg.worldimg)
    self._background = {
      assetBundle = recorder.assetBundle,
      assetName = recorder.assetName
    }
  end
  if self._cfg.roleimg then
    local recorder = cimagepath:GetRecorder(self._cfg.roleimg)
    self._photo = {
      assetBundle = recorder.assetBundle,
      assetName = recorder.assetName
    }
  end
  if self._cfg.sortid then
    self._sortid = self._cfg.sortid
  end
  if self._cfg.unlockid then
    self._unlockTextId = self._cfg.unlockid
  end
end

function Task:GetStatus()
  return self._status
end

function Task:SetStatus(status)
  self._status = status
end

function Task:GetType()
  if not self._cfg then
    LogError("task", "access nonexisting task " .. tostring(self._id))
  end
  return self._cfg.missiontype
end

function Task:GetConfig()
  return self._cfg
end

function Task:IsSpecialDailyTask()
  return self._cfgtype == "GoldenDaily"
end

function Task:GetName()
  if self._cfg.missionnameTextID then
    return TextManager.GetText(self._cfg.missionnameTextID)
  end
end

function Task:GetDesc()
  if self._cfg.descriptionTextID then
    return TextManager.GetText(self._cfg.descriptionTextID)
  end
end

function Task:GetShortDesc()
  if self._cfg.short_descriptionTextID then
    return TextManager.GetText(self._cfg.short_descriptionTextID)
  end
end

function Task:GetActiveValue()
  return self._cfg.activevalue or 0
end

function Task:GetRewardID()
  return self._cfg.rewardid
end

function Task:GetAcceptMsgID()
  return self._cfg.accept_mission
end

function Task:GetBackground()
  return self._background
end

function Task:GetGroupID()
  local recorder = cmissiontypeconfig:GetRecorder(self._cfg.missiontype)
  return recorder.tab
end

function Task:GetAcceptTime()
  return self._acceptTime
end

function Task:IsAutoCommit()
  return self._cfg.rewardtype == 1
end

function Task:GetHintText()
  if self._cfg.instructionTextID then
    return TextManager.GetText(self._cfg.instructionTextID)
  end
end

function Task:GetHintLocation()
  if self._cfg.locationTextID then
    return TextManager.GetText(self._cfg.locationTextID) or ""
  end
end

function Task:CanJump()
  if self._cfg.jumptype == 1 then
    return self._cfg.jumpvalue
  elseif self._cfg.jumptype == 2 then
    return self._cfg.UIjumpvalue ~= 0
  end
  return false
end

function Task:GetJumpType()
  return self._cfg.jumptype
end

function Task:IsNewTask()
  return not self._visited
end

function Task:SetNewTask(value)
  self._visited = not value
end

function Task:GetAcceptTriggerID()
  return self._cfg.startevent
end

function Task:GetFinishTriggerID()
  return self._cfg.endevent
end

function Task:GetFailTriggerID()
  return self._cfg.failevent
end

function Task:GetProgress()
  return self._progress
end

function Task:GetAwards()
  return self._awards
end

function Task:GetRoleImage()
  return self._photo
end

function Task:GetSortID()
  return self._sortid
end

function Task:GetUnlockTextId()
  return self._unlockTextId
end

function Task:IsLock()
  return self._isLock
end

function Task:IsMultiProgress()
  return self._isMultiProgress
end

return Task
