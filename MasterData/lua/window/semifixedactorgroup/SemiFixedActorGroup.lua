local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local AU = require("Common/ActorUtil")
local m_dungeonId, m_replayTween, m_chapter, m_groups, m_reloadAura

function SetupWindow()
  Base.SetupWindow()
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups.groupInfo = patchData
    OnActorGroupChanged(m_groups)
  end)
  Base.SetData("Fight", Fight)
  WU.BindButtonEvent(REF.Carnival91Pass, function()
    WU.AcquireWindowAsync("Carnival91Pass")
  end)
end

function InitWindow()
  Base.InitAutoFight(PB.enum.DungeonType.SemiFixed)
  REF.DescribeNode.transform.localPosition = CS.UnityEngine.Vector3(-912, -473, 0)
  m_reloadAura = true
  WU.SetActive(REF.CarnivalAdditions, false)
  this:Bind("SemiFixedActorGroup/DungeonId", OnActorGroupDungeonId)
end

function UninitWindow()
  this:SetData("equipMinRequireLevelPosMap", nil)
end

function OnActorGroupDungeonId(dungeonId)
  if dungeonId == nil then
    return
  end
  local recordUri = "fci/activity/record/" .. PB.enum.ActivityType.Carnival91 .. "/{SemiFixed/ActivityId}/"
  if m_dungeonId ~= nil then
    this:Unbind("fci/semifixed-dungeon/actorgroup/" .. m_dungeonId, OnActorGroupChanged)
  end
  m_dungeonId = dungeonId
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  Base.SetData("powerMultiple", 1)
  REF.WidgetStarGridMTargets["$SetStar"](0)
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  if m_reloadAura then
    m_reloadAura = false
    Base.ResetAuraSelection()
  end
  Base.OnDungeonInfo(dungeonId)
  this:BindRemote(DB:GameRequest("fci/semifixed-dungeon/actorgroup/" .. dungeonId), OnActorGroupChanged)
  this:Unbind(recordUri, OnDungeonRecord)
  this:BindRemote(DB:GameRequest(recordUri), OnDungeonRecord)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
end

function OnDungeonRecord(result)
  if result == nil then
    return
  end
  local records = result.records
  local _, record = table.find(records, function(_, v)
    return v.dungeonId == m_dungeonId
  end)
  if record then
    local isMultiPowerLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.MultiPower)
    local multiPowerShow = DU.IsShowStar(m_dungeonId)
    REF.ButtonMultiPower.BoxCollider2D.enabled = multiPowerShow
    REF.SpriteMultiPower.gameObject:SetActive(multiPowerShow)
    REF.SpriteMultiPower.UISprite.alpha = fif(isMultiPowerLocked, 0.3, 1)
    local starCount = 0
    if multiPowerShow then
      starCount = fif(record.finished, #record.targetsDone, 0)
    end
    Base.ShowStars(starCount)
    WU.ToggleRendering(REF.PowerDropList, false)
    if not isMultiPowerLocked and multiPowerShow then
      Base.SetMultiPowerStatus(record)
    end
  else
    warning("SemiFixedActorGroup", "no record for dungeonId -> " .. tostring(m_dugneonId))
  end
end

function OnActorGroupButtonClick(go)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  this:SetData("SemiFixedActorSelect/DungeonId", m_dungeonId)
  WU.AcquireWindowAsync("SemiFixedActorSelect")
end

function OnActorGroupChanged(actorGroup)
  if actorGroup then
    m_groups = actorGroup
    local members = actorGroup.groupInfo.members
    RefreshSemiFixedDungeonNPC(m_dungeonId, m_groups)
    RefreshAdditions(members)
    RefreshGroupMembersAndTween(members, m_replayTween)
    m_replayTween = false
  end
end

function RefreshAdditions(members)
  local npcInfo = {}
  for i = 1, #members do
    local member = members[i]
    if member.isNpc then
      local actor = PB.get("DungeonNPC", member.npcId)
      AU.RenameDungeonNPCFields(actor)
      if actor == nil then
        warning("DungeonNPC", "can't find npc id -> " .. tostring(member.npcId))
      else
        table.insert(npcInfo, actor)
      end
    end
  end
  REF.AdditionsInfo.UILabel.text = fif(table.empty(npcInfo), WU.GetString("Window_SemiFixedAdditionsNoActor"), WU.GetString("Window_SemiFixedAdditionsActors"))
  local additionsActors = ""
  for i = 1, #npcInfo do
    additionsActors = additionsActors .. WU.GetString("ActorName_" .. npcInfo[i].id)
    if i ~= #npcInfo then
      additionsActors = additionsActors .. "\227\128\129"
    end
  end
  REF.AdditionsActors.UILabel.text = additionsActors
  WU.SetActive(REF.AdditionsOutput, not table.empty(npcInfo))
  WU.SetActive(REF.CarnivalAdditions, true)
end

function RefreshSemiFixedDungeonNPC(dungeonId, groups)
  local semiFixedDungeon = PB.get("SemiFixedDungeon", dungeonId)
  local members = groups.groupInfo.members
  for i = 1, #semiFixedDungeon.npcId do
    local grouped = table.find(members, function(_, v)
      return v.index + 1 == i and v.isNpc
    end)
    if grouped then
      members[grouped].npcId = semiFixedDungeon.npcId[i]
    end
  end
end

function Fight()
  local members = m_groups.groupInfo.members
  if GU.GroupIsOK(members, true) then
    local isReach, testResult = Base.FightAfterCultivationTest(members, m_dungeonId)
    if isReach then
      RequestPostDungeon()
    else
      Base.FightCultivationHint(testResult, RequestPostDungeon)
    end
  end
end

function RequestPostDungeon()
  local members = m_groups.groupInfo.members
  Base.Member2FightActorInfo(members)
  local fightActorInfo = this:GetData("FightActorInfo")
  this:GameRequest("fci/semifixed-dungeon/actorgroup/" .. m_dungeonId):Put(m_groups, function(resp)
    local powerMultiple = Base.GetData("powerMultiple")
    local param = {
      dungeonId = m_dungeonId,
      multiPower = powerMultiple,
      activityId = this:GetData("SemiFixed/ActivityId"),
      activityType = PB.enum.ActivityType.Carnival91
    }
    Base.AppendAuraAttrs(param)
    this:SetData("PowerMultiple", powerMultiple)
    this:SetData("WindowDungeon/EnterParam", param)
    this:SetData("BalanceInfo/Groups", {groups = m_groups})
    this:GameRequest("fci/semifixed-dungeon/"):Post(param, function(result)
      DBH.ResChange(result.resChange)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, m_dungeonId, PB.enum.DungeonType.SemiFixed, 1, true)
    end)
  end)
end

function Focus(on)
  if on and m_groups then
    local members = m_groups.groupInfo.members
    RefreshGroupMembersAndTween(members, true)
  end
  if on then
    WU.SetWindowTitle("SemiFixedActorGroup", "ActorGroup")
  end
end

function RefreshGroupMembersAndTween(members, replay)
  if m_dungeonId == nil then
    return
  end
  local semiFixedDungeon = PB.get("SemiFixedDungeon", m_dungeonId)
  for i = 1, #members do
    members[i].npcId = semiFixedDungeon.npcId[members[i].index + 1] or 0
  end
  REF.WidgetGroupMembers["$Set91GroupMembers"](members)
  if REF.WidgetGroupCultivation then
    REF.WidgetGroupCultivation["$SetGroupMembers"](members)
  elseif REF.WidgetGroupCultivation4Group then
    REF.WidgetGroupCultivation4Group["$SetGroupMembers"](members)
  end
  REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
  WU.ToggleRendering(REF.WidgetGroupMembers, true)
  if replay then
    REF.WidgetGroupMembers.UIPlayTween.enabled = false
    REF.WidgetGroupMembers.UIPlayTween.enabled = true
  end
end
