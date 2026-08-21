local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local groupBase = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local SE = require("Common/SkillEffect")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local m_displayActorTable, m_initWindow
local m_repeatedContext = {}
local m_selectedActors = {}
local m_pills = {}
local m_members, m_mode
local m_select = 1
local m_group = 2
local m_tweenFromGroup = {
  80,
  788,
  1496
}
local m_eventActivityType, m_dungeonId, m_dungeonType, m_membersDetail

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  CustomizeWidgetGroup()
  REF.WidgetGroupMembers["$SetClickCallback"]()
end

function InitWindow()
  m_initWindow = true
  this:Bind("fci/Maze/FightActorGroup/", OnActorGroupChanged)
end

function OnActorGroupChanged(result)
  if result ~= nil then
    local dataSource = this:GetData("fci/Maze/Actor/")
    m_selectedActors = dataSource.selectActors
    local groups = _ENV["!"]({})
    local actorGroup = {}
    local dataGroup = {}
    if result.fightGroup then
      dataGroup = result.fightGroup[1]
    else
      dataGroup = result
    end
    actorGroup = NormalizeGroups(dataGroup)
    table.copy(actorGroup, groups, true)
    m_members = groups
    RefreshGroupMembers()
    if m_initWindow then
      m_initWindow = false
      REF.root.Animator:Play("DelayOpen", -1, 0)
    end
    WU.ToggleRendering(REF.Panel, true)
  end
end

function RefreshGroupMembers()
  for i = 1, 3 do
    local root = _ENV["$"](REF["TweenNode" .. i])
    local pos = root.HpDetailNode.transform.localPosition
    root.HpDetailNode.transform.localPosition = CS.UnityEngine.Vector3(pos.x, pos.y - 20, 0)
    root.HpDetailNode.transform.localScale = CS.UnityEngine.Vector3(1, 1.4, 0)
  end
  REF.WidgetGroupMembers["$SetMazeGroupMembers"](m_members)
  REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
end

function CustomizeWidgetGroup()
  REF.WidgetGroupMembers.transform.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
  REF.Grid.UIGrid.cellWidth = 708
  for i = 1, 3 do
    local root = _ENV["$"](REF["TweenNode" .. i])
    local pos = REF["TweenNode" .. i].transform.localPosition
    REF["TweenNode" .. i].TweenPosition.from = CS.UnityEngine.Vector3(m_tweenFromGroup[i], pos.y, 0)
    REF["TweenNode" .. i].TweenPosition.to = CS.UnityEngine.Vector3(m_tweenFromGroup[i] - 75, pos.y, 0)
    root.WidgetActorCardEffectMain.transform.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
    root.WidgetActorCardEffectSub.transform.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
    root.Attrs.UISprite.height = 350
  end
end

function NormalizeGroups(fightGroup)
  local group = fightGroup.members or fightGroup
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
