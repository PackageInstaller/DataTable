local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local LU = require("Common/ListUtil")
local m_drops, m_summary, m_groups, m_balanceUI

function SetupWindow()
  LU.Bind(REF.DropContent, {
    updateRow = OnDropItemShow
  })
  WU.BindButtonEvent(REF.ButtonFight, OnButtonContinueClick)
  WU.BindButtonEvent(REF.ButtonSwitchTeam, OnClickSwitchTeam)
  m_balanceUI = _ENV["$"](WU.FindWindow("DungeonBalanceTower")).root
end

function InitWindow()
  WU.ToggleRendering(REF.BottomButtons, false)
  WU.ToggleRendering(_ENV["$"](REF.LEFT).WidgetDungeonGroup, false)
  WU.ToggleRendering(_ENV["$"](REF.RIGHT).WidgetDungeonGroup, false)
  this:BindRemote(DB:GameRequest("fci/tower/summary/"), OnTowerSummary)
  this:BindRemote(DB:GameRequest("fci/tower/actorgroup-confirm/"), OnActorGroupConfirm)
end

function OnTowerSummary(result)
  if result == nil then
    WU.ToggleRendering(REF.DropList, false)
    return
  end
  this:DelayInvokeInSeconds(0.34, function()
    WU.ToggleRendering(_ENV["$"](REF.RIGHT).WidgetDungeonGroup, true)
    _ENV["$"](REF.RIGHT).TweenerGroup1.UIPlayTween:Play(true)
  end)
  this:DelayInvokeInSeconds(0.75, function()
    WU.ToggleRendering(REF.DropList, true)
    REF.DropContent.UIPlayTween:Play(true)
  end)
  m_summary = result
  SetDrops(m_summary.towerFloor)
  SetOpponents(m_summary.towerFloor)
  REF.LabelCurrentFloor.UILabel.text = WU.GetString("WindowTower_CurrentFloor", m_summary.towerFloor)
end

function OnActorGroupConfirm(result)
  if result == nil then
    return
  end
  this:DelayInvokeInSeconds(0.34, function()
    WU.ToggleRendering(_ENV["$"](REF.LEFT).WidgetDungeonGroup, true)
    _ENV["$"](REF.LEFT).TweenerGroup2.UIPlayTween:Play(true)
  end)
  m_groups = result
  local selectGroupId = this:GetData("fci/SelectedGroupId/tower/").selectActorGroupId
  REF.WidgetDungeonGroup["$SetView"](m_groups[tostring(selectGroupId)])
  REF.WidgetDungeonGroup["$SetHp"](m_groups[tostring(selectGroupId)])
  REF.BottomButtons.UIGrid:Reposition()
  WU.ToggleRendering(REF.BottomButtons, true)
end

function SetDrops(floor)
  local dungeonId = PB.get("TowerFloor", floor).dungeonId
  m_drops = PB.get("DungeonReward", dungeonId).dropDisplay
  LU.Set(REF.DropContent, #m_drops)
end

function SetOpponents(floor)
  local dungeonId = PB.get("TowerFloor", floor).dungeonId
  local dungeonMonster = PB.get("DungeonMonster", dungeonId)
  if dungeonMonster == nil then
    error("Tower", "no dungeonId " .. dungeonId .. " in DungeonMonster! ")
    return
  end
  local actors, pairCount = GU.MonsterGroup(dungeonMonster.monsterId)
  _ENV["$"](REF.Opponents).WidgetDungeonGroup["$SetViewByActors"](actors, true, true)
  _ENV["$"](REF.Opponents).WidgetDungeonGroup["$SetFilledHp"](pairCount, true)
  REF.AffixWidget["$ShowAffixWidget"](dungeonId)
end

function OnDropItemShow(ref, wrapIndex, realIndex)
  if m_drops ~= nil and realIndex < #m_drops then
    local award = m_drops[realIndex + 1]
    ref.root["$SetData"](award.type, award.id, award.count)
  end
end

function OnButtonContinueClick()
  m_balanceUI["$OnButtonContinueClick"]()
end

function OnClickSwitchTeam()
  m_balanceUI["$OnClickSwitchTeam"]()
end
