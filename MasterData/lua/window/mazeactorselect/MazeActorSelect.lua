local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local SU = require("Common/SortUtil")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local SDU = require("Common/SoundUtil")
local LU = require("Common/ListUtil")
local TU = require("Common/TaskUtil")
local WidgetGroupMembers = REF.WidgetGroupMembers
local m_displayActorTable, m_members, m_selectedActors, m_initWindow

function SetupWindow()
  Base.SetupWindow()
  WU.BindButtonEvent(REF.Confirm, function()
    OnConfirm()
  end)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("GetMembers", function(groups)
    return groups
  end)
  Base.SetData("SetMembers", function(groups, patchData)
    m_members = patchData.members
    Base.SetData("groups", m_members)
    return true
  end)
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
end

function InitWindow()
  m_initWindow = true
  Base.InitWindow()
  this:Bind("fci/Maze/FightActorGroup/", OnActorGroupChanged)
  this:Bind("MazeActorSelect/MainActors/", function(list)
    warning("list", table.dump(list))
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Main then
      RefreshWrapContent(list)
    end
  end)
  this:Bind("MazeActorSelect/SubActors/", function(list)
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

function OnActorGroupChanged(result)
  if result ~= nil then
    local dataSource = this:GetData("fci/Maze/Actor/")
    warning("dataSource", table.dump(dataSource))
    m_selectedActors = dataSource.selectActors
    local groups = _ENV["!"]({})
    local actorGroup = {}
    warning("resultgroup", table.dump(result))
    local dataGroup = {}
    if result.fightGroup then
      dataGroup = result.fightGroup[1]
    else
      dataGroup = result
    end
    actorGroup = NormalizeGroups(dataGroup)
    warning("actorGroup", table.dump(actorGroup))
    table.copy(actorGroup, groups, true)
    Base.SetData("groups", groups)
    m_members = groups
    REF.WidgetGroupMembers["$SetMazeGroupMembers"](m_members)
    Base.RefreshGroupMembers()
    WU.ToggleRendering(REF.Panel, true)
    if m_initWindow then
      m_initWindow = false
      Base.ClearAllSelect()
      REF.root.Animator:Play("DelayOpen", -1, 0)
    end
  end
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_displayActorTable ~= nil and rowIndex < #m_displayActorTable then
    local actor = m_displayActorTable[rowIndex + 1]
    rowRef["$$BindActor"](actor)
    rowRef["$$SetClickCallback"](OnActorHeadClick)
    local currentActor
    local currentActorUid = Base.GetData("currentActorUid")
    if currentActorUid ~= nil then
      currentActor = this:GetData("fci/mazeactor/" .. currentActorUid).actor
    end
    local linksActorId = Base.GetData("linksActorId")
    if currentActor ~= nil and currentActor.id == actor.id then
      rowRef["$$SetMemberLink"](false)
    elseif linksActorId ~= nil then
      rowRef["$$SetMemberLink"](linksActorId[actor.id])
    end
    rowRef["@uid"] = actor.uid
    local displayNumbers = Base.GetData("displayNumbers")
    rowRef["$$ShowCustom"]({
      showCultivationTotal = displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = displayNumbers == SU.DisplayNumbers.Speed,
      showStar = displayNumbers == SU.DisplayNumbers.Star
    })
  end
end

function OnActorHeadClick(go)
  local ref = _ENV["$"](go)
  local actorUid = ref["@uid"]
  if actorUid == nil then
    info("Actor", "actorUid nil?")
    return
  end
  local top = WU.TopWindow()
  if top and top.name == "ActorPeek" then
    WU.ShowActorPeek(this:GetData("fci/mazeactor/" .. actorUid).actor)
  else
    local currentActorUid = Base.GetData("currentActorUid")
    local slotIndex = Base.GetData("slotIndex")
    if currentActorUid == actorUid then
      return
    end
    ClearAllSelect()
    local eventData = {
      index = slotIndex,
      cardUid = currentActorUid or 0,
      cardSUid = actorUid
    }
    eventData.actorS = this:GetData("fci/mazeactor/" .. actorUid).actor
    WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess)
    Base.SetData("currentActorUid", actorUid)
  end
end

function RefreshWrapContent(displayMode)
  WU.ToggleRendering(Base.GetData("currentGrid"), true)
  m_displayActorTable = _ENV["!"]({})
  _ENV["!"](displayMode):copy(m_displayActorTable)
  Base.RemoveActorsInGroup(m_displayActorTable)
  local resetPosition = true
  local resetActorSelect = Base.GetData("resetActorSelect")
  if resetActorSelect == false then
    resetPosition = false
  end
  if Base.GetData("currentGrid") == REF.ActorSelectWidgetGrid then
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, resetPosition, not resetPosition)
  end
end

function OnConfirm(isHome)
  local groups = Base.GetData("groups")
  warning("groupsssss", table.dump(groups))
  local groupMembers = GetGroupMembers(groups)
  this:GameRequest("fci/Maze/FightActorGroup/"):Post({members = groupMembers}, function(result)
    this:SetData("fci/Maze/FightActorGroup/", result)
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "MazeActorSelect" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function OnHomeCallback()
  OnBackValidate(true)
end

function Home()
  local winName = "City"
  if WU.IsStandaloneGame() then
    winName = "StoryMode"
  end
  S:Get("TutorialManager").SetNavigation(winName)
  this:BroadcastGameEvent("OnNavigation", winName)
end

function OnBackValidate(isHome)
  local function DontSave()
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  local originalGroups = this:GetData("fci/Maze/FightActorGroup/")
  local groups = Base.GetData("groups")
  for k, v in pairs(originalGroups) do
    for i = 1, #v.members do
      local member = v.members[i]
      if member.actorUid ~= groups[k].members[i].actorUid then
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
  end
  DontSave()
end

function Focus(on)
  Base.Focus(on)
  if on then
    WU.SetWindowTitle("MazeActorSelect", "ActorSelect")
  end
end

function NormalizeGroups(fightGroup)
  warning("m_selectedActors1111", table.dump(m_selectedActors))
  warning("fightGroup", table.dump(fightGroup))
  local group = fightGroup.members or fightGroup
  warning("group", table.dump(group))
  for i = 1, #group do
    for k, v in pairs(m_selectedActors) do
      if v.actor and v.actor.uid == group[i].actorUid then
        group[i].actor = v.actor
        group[i].hp = v.hp
        group[i].dead = v.dead
        group[i].spSkillUsed = v.spSkillUsed
        break
      end
    end
  end
  return group
end

function GetGroupMembers(group)
  local members = {}
  for i = 1, #group do
    table.insert(members, {
      index = group[i].index,
      actorUid = group[i].actorUid
    })
  end
  return members
end
