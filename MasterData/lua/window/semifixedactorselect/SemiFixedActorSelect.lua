local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local SDU = require("Common/SoundUtil")
local AU = require("Common/ActorUtil")
local m_displayActorTable, m_initWindow, m_dungeonId
local m_semiFixedDungeonNPC = {}
local m_targetSlot

function SetupWindow()
  WU.BindButtonEvent(REF.ActorLink, OnActorLinkClick)
  WU.BindButtonEvent(REF.ActorMain, OnActorMainClick)
  WU.BindButtonEvent(REF.Confirm, function()
    OnConfirm()
  end)
  WU.BindButtonEvent(REF.UseFixedActors, OnUseFixedActors)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
  Base.SetData("SetMembers", function(groups, members)
    groups.groupInfo = members
    return true
  end)
  Base.SetData("GetMembers", function(groups)
    return groups.groupInfo.members
  end)
  Base.SetData("GroupChangeCompare", GroupChangeCompare)
  Base.SetData("GroupSlotChangeSuccCallb", GroupSlotChangeSuccCallb)
  Base.SetData("OnGroupSlotChangeCancel", OnGroupSlotChangeCancel)
  Base.SetData("GroupMemberslegalCheck", GroupMemberslegalCheck)
  Base.SetData("OnActorRemoveFromGroup", OnActorRemoveFromGroup)
  Base.SetupWindow()
end

function InitWindow()
  Base.InitWindow()
  this:Bind("SemiFixedActorSelect/DungeonId", On91ActorSelect)
  this:Bind("SemiFixedActorSelect/MainActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Main then
      RefreshWrapContent(list)
    end
  end)
  this:Bind("SemiFixedActorSelect/SubActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Sub then
      RefreshWrapContent(list)
    end
  end)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
end

function UninitWindow()
  Base.UninitWindow()
end

function On91ActorSelect(dungeonId)
  if dungeonId == nil then
    return
  end
  m_dungeonId = dungeonId
  local groups = this:GetData("fci/semifixed-dungeon/actorgroup/" .. dungeonId)
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_initWindow = true
  WU.ToggleRendering(REF.Remove, false)
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(Base.GetData("currentGrid"), false)
  OnActorGroupChanged(groups)
end

function RefreshSemiFixedDungeonNPC(dungeonId, groups)
  local semiFixedDungeon = PB.get("SemiFixedDungeon", dungeonId)
  local members = groups.groupInfo.members
  for i = 1, #semiFixedDungeon.npcId do
    local grouped = table.find(members, function(_, v)
      return v.index + 1 == i and v.isNpc
    end)
    m_semiFixedDungeonNPC[i] = {
      npcId = semiFixedDungeon.npcId[i],
      grouped = grouped ~= nil
    }
  end
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    local groups = _ENV["!"]({})
    table.copy(actorGroup, groups, true)
    Base.SetData("groups", groups)
    RefreshSemiFixedDungeonNPC(m_dungeonId, groups)
    RefreshGroupMembers(groups)
    WU.ToggleRendering(REF.Panel, true)
    if m_initWindow then
      m_initWindow = false
      local index = this:GetData("AutoSlotSelection")
      this:SetData("AutoSlotSelection", nil)
      Base.ResetState(0, true, index)
      REF["$Animator"]:Play("DelayOpen", -1, 0)
    end
  end
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_displayActorTable ~= nil and rowIndex < #m_displayActorTable then
    local actor = m_displayActorTable[rowIndex + 1]
    rowRef["$$SetClickCallback"](OnActorHeadClick)
    rowRef["$$SetHoldCallback"](Base.DefaultActorHeadHold)
    rowRef["@isNpc"] = actor.uid == nil
    if actor.uid then
      SetNormalActor(actor, rowRef)
    else
      SetNpcActor(actor, rowRef)
    end
    local displayNumbers = Base.GetData("displayNumbers")
    rowRef["$$ShowCustom"]({
      showCultivationTotal = displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = displayNumbers == SU.DisplayNumbers.Speed,
      showStar = displayNumbers == SU.DisplayNumbers.Star
    })
    local currentActor
    local slotIndex = Base.GetData("slotIndex")
    local ref = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex)
    if ref ~= nil then
      currentActor = ref["@actor"]
    end
    local linksActorId = Base.GetData("linksActorId")
    if currentActor ~= nil and currentActor.id == actor.id then
      rowRef["$$SetMemberLink"](false)
    elseif linksActorId ~= nil then
      rowRef["$$SetMemberLink"](linksActorId[actor.id])
    end
  end
end

function SetNormalActor(actor, rowRef)
  rowRef["$$BindActor"](actor)
  rowRef["@uid"] = actor.uid
end

function SetNpcActor(actor, rowRef)
  rowRef["@npcId"] = actor.npcId
  rowRef["$$ResetState"]()
  rowRef["$$SetActor"](actor)
  rowRef["$$SetAsNpc"]()
end

function OnConfirm(isHome)
  local groups = Base.GetData("groups")
  
  local function Recycle()
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  this:GameRequest("fci/semifixed-dungeon/actorgroup/" .. m_dungeonId):Put(groups, function(response)
    this:SetData("fci/semifixed-dungeon/actorgroup/" .. m_dungeonId, groups)
    Recycle()
  end)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "SemiFixedActorSelect" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function OnHomeCallback()
  OnBackValidate(true)
end

function Home()
  this:BroadcastGameEvent("OnNavigation", "City")
end

function OnBackValidate(isHome)
  local function DontSave()
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  local originalGroups = this:GetData("fci/semifixed-dungeon/actorgroup/" .. m_dungeonId)
  local groups = Base.GetData("groups")
  for i = 1, #originalGroups.groupInfo.members do
    local member = originalGroups.groupInfo.members[i]
    if member.actorUid ~= groups.groupInfo.members[i].actorUid or member.isNpc ~= groups.groupInfo.members[i].isNpc then
      WU.ShowMessageYesNo(WU.GetString("Window_ActorSelectBackValidate"), function(result)
        if result == "YES" then
          OnConfirm(isHome)
        else
          DontSave()
        end
      end)
      return
    end
  end
  DontSave()
end

function Focus(on)
  SortFocusBase.FocusActor(on, function()
    Base.SetData("resetActorSelect", true)
    return Base.GetData("advancedFilters")
  end)
  if on then
    local slotIndex = Base.GetData("slotIndex")
    local groups = Base.GetData("groups")
    if groups and slotIndex then
      RefreshGroupMembers(groups)
      local go = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex)
      Base.OnSlotSelected(go)
    end
    WU.SetWindowTitle("SemiFixedActorSelect", "ActorSelect")
  end
end

function RefreshGroupMembers(groups)
  local members = groups.groupInfo.members
  for i = 1, #members do
    members[i].npcId = m_semiFixedDungeonNPC[members[i].index + 1].npcId or 0
  end
  REF.WidgetGroupMembers["$Set91GroupMembers"](members)
  Base.RefreshGroupMembers(false)
  if REF.WidgetGroupCultivation then
    REF.WidgetGroupCultivation["$SetGroupMembers"](members)
  elseif REF.WidgetGroupCultivation4Group then
    REF.WidgetGroupCultivation4Group["$SetGroupMembers"](members)
  end
end

function RefreshWrapContent(list)
  WU.ToggleRendering(Base.GetData("currentGrid"), true)
  m_displayActorTable = _ENV["!"]({})
  _ENV["!"](list):copy(m_displayActorTable)
  Base.RemoveActorsInGroup(m_displayActorTable)
  m_displayActorTable = AddMonster91()
  local resetPosition = true
  local resetActorSelect = Base.GetData("resetActorSelect")
  if resetActorSelect == false then
    resetPosition = false
  end
  local slotIndex = Base.GetData("slotIndex")
  Base.SetData("linksActorId", REF.WidgetGroupMembers["$GetLinksActorIdByIndex"](slotIndex, m_displayActorTable))
  if Base.GetData("currentGrid") == REF.ActorSelectWidgetGrid then
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, resetPosition, not resetPosition)
  end
end

function AddMonster91()
  local function FindMonsters(actors, bg, ed)
    for i = bg, ed do
      if m_semiFixedDungeonNPC[i].npcId > 0 and not m_semiFixedDungeonNPC[i].grouped then
        local npc = PB.get("DungeonNPC", m_semiFixedDungeonNPC[i].npcId)
        
        if npc == nil then
          warning("DungeonNPC", "Can't find NPC id -> " .. tostring(m_semiFixedDungeonNPC[i].npcId))
        else
          AU.RenameDungeonNPCFields(npc)
          table.insert(actors, npc)
        end
      end
    end
  end
  
  local actors = _ENV["!"]({})
  if Base.GetData("actorType") == PB.enum.ActorType.Main then
    FindMonsters(actors, 1, 3)
  else
    FindMonsters(actors, 4, 6)
  end
  actors:append(m_displayActorTable)
  return actors
end

function GetCurrentActor()
  local slotIndex = Base.GetData("slotIndex")
  local ref = _ENV["$"](REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex))
  local actor
  if ref then
    actor = ref["@actor"]
  end
  return actor
end

function OnActorLinkClick()
  local actor = GetCurrentActor()
  if actor then
    if actor.uid then
      WU.AcquireWindowAsync("ActorInfo", function()
        this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
        this:SetData("Actor/SelectedUid", actor.uid)
        this:BroadcastGameEvent("EventSwitchTab", "TabRelation")
      end)
    else
      WU.AcquireWindowAsync("ActorInfoDisplay", function(ui)
        _ENV["$"](ui).TabEquipDisplay.gameObject:SetActive(false)
        this:SetData("Space/DisplayInfo", {actorInfo = actor})
        this:BroadcastGameEvent("EventSwitchTab", "TabRelation")
      end)
    end
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function OnActorMainClick()
  local actor = GetCurrentActor()
  if actor then
    if actor.uid then
      this:SetData("Actor/SelectedUid", nil)
      WU.AcquireWindowAsync("ActorMain", function()
        this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
        this:SetData("Actor/SelectedUid", actor.uid)
      end)
    else
      WU.AcquireWindowAsync("ActorInfoDisplay", function(ui)
        _ENV["$"](ui).TabEquipDisplay.gameObject:SetActive(false)
        this:SetData("Space/DisplayInfo", {actorInfo = actor})
        this:BroadcastGameEvent("EventSwitchTab", "TabTalent")
      end)
    end
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function CreateRollerTraverse()
  local traverseData = _ENV["!"]({})
  local groups = Base.GetData("groups")
  local members = groups.groupInfo.members
  for i = 1, #members do
    if members[i].actorUid ~= 0 then
      table.insert(traverseData, this:GetData("fci/actor/" .. members[i].actorUid))
    end
  end
  return traverseData
end

function OnActorHeadClick(go)
  m_targetSlot = nil
  local ref = _ENV["$"](go)
  if ref["@isNpc"] then
    HandlerNpcActor(ref)
  else
    Base.DefaultActorHeadClick(go)
  end
end

function HandlerNpcActor(ref)
  local slotIndex, info = table.find(m_semiFixedDungeonNPC, function(_, v)
    return v.npcId == ref["@npcId"]
  end)
  slotIndex = slotIndex - 1
  local npc = PB.get("DungeonNPC", info.npcId)
  if npc == nil then
    warning("DungeonNPC", "Can't find npc id -> " .. tostring(info.npcId))
    return
  end
  AU.RenameDungeonNPCFields(npc)
  local top = WU.TopWindow()
  if top and top.name == "ActorPeek" then
    WU.ShowActorPeek(npc)
  else
    local targetRef = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex)
    local card = _ENV["$"](targetRef)["@actor"]
    ClearAllSelect()
    local eventData = {
      index = slotIndex,
      card = card,
      cardS = npc,
      actorS = npc
    }
    m_targetSlot = slotIndex
    REF.WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess, OnGroupSlotChangeCancel)
    Base.SetData("currentActorUid", npc.uid)
    WU.ShowHintText(WU.GetString("Window_SemiFixedActorSelect_FixedOn"))
  end
end

function OnGroupSlotChangeCancel()
  local targetSlot = m_targetSlot or Base.GetData("slotIndex")
  if targetSlot then
    local go = REF.WidgetGroupMembers["$GetSlotByIndex"](targetSlot)
    Base.OnSlotSelected(go)
  end
end

function GroupSlotChangeSuccCallb()
  local slotIndex = Base.GetData("slotIndex")
  local currentActorId = Base.GetData("currentActorID")
  local go = REF.WidgetGroupMembers["$GetSlotByIndex"](m_targetSlot or slotIndex)
  if go then
    local ref = _ENV["$"](go)
    if ref["@actor"] ~= nil then
      if currentActorId then
        SDU.StopActorAdded(currentActorId)
        Base.SetData("currentActorID", ref["@actor"].id)
      end
      SDU.PlayActorAdded(ref["@actor"].id)
    end
  end
  Base.OnSlotSelected(go)
end

function GroupChangeCompare(membersBefore, members)
  local flag = 0
  local changedIndex = {}
  for i = 1, #membersBefore do
    if membersBefore[i].actorUid ~= members[i].actorUid or membersBefore[i].isNpc ~= members[i].isNpc then
      flag = flag + 1
      if members[i].actorUid ~= 0 or members[i].isNpc == true then
        table.insert(changedIndex, members[i].index)
      end
    end
  end
  return flag, changedIndex
end

function GroupMemberslegalCheck(members)
  local legal = true
  for _, v in pairs(members) do
    local actor
    if v.isNpc then
      actor = PB.get("DungeonNPC", v.npcId)
      if actor ~= nil then
        AU.RenameDungeonNPCFields(actor)
      end
    else
      actor = this:GetData("fci/actor/" .. v.actorUid)
    end
    if actor ~= nil and actor.id > 0 then
      local actorConfig = PB.get("ActorConfig", actor.id)
      local mainIndex = GU.IsMainIndex(v.index)
      if mainIndex and actorConfig.kind == PB.enum.ActorType.Sub or not mainIndex and actorConfig.kind == PB.enum.ActorType.Main then
        legal = false
        v.actorUid = 0
      end
    end
  end
  return legal
end

function OnActorRemoveFromGroup()
  local actor = GetCurrentActor()
  if actor then
    local eventData = {
      index = Base.GetData("slotIndex"),
      card = actor
    }
    REF.WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess, OnGroupSlotChangeCancel)
  end
end

function OnUseFixedActors()
  local showHint = false
  for i = 1, #m_semiFixedDungeonNPC do
    local info = m_semiFixedDungeonNPC[i]
    if info.npcId > 0 and not info.grouped then
      showHint = true
      local npc = PB.get("DungeonNPC", info.npcId)
      if npc == nil then
        warning("DungeonNPC", "Can't find npc id -> " .. tostring(info.npcId))
        return
      end
      AU.RenameDungeonNPCFields(npc)
      local targetRef = REF.WidgetGroupMembers["$GetSlotByIndex"](i - 1)
      local card = _ENV["$"](targetRef)["@actor"]
      ClearAllSelect()
      local eventData = {
        index = i - 1,
        card = card,
        cardS = npc,
        actorS = npc
      }
      m_targetSlot = i - 1
      REF.WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess, OnGroupSlotChangeCancel)
      Base.SetData("currentActorUid", npc.uid)
    end
  end
  if showHint then
    WU.ShowHintText(WU.GetString("Window_SemiFixedActorSelect_FixedOn"))
  end
end

function SwitchButtonGrid(go)
  local ref = _ENV["$"](go)
  WU.SetActive(REF.ActorLink, not ref["@isNpc"])
  WU.SetActive(REF.ActorMain, not ref["@isNpc"])
end
