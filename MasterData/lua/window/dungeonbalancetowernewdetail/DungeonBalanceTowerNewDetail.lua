local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local LU = require("Common/ListUtil")
local m_dungeonId, m_drops, m_summary, m_groups, m_balanceUI

function SetupWindow()
  LU.Bind(REF.DropContent, {
    updateRow = OnDropItemShow
  })
  WU.BindButtonEvent(REF.ButtonFight, OnButtonContinueClick)
  m_balanceUI = _ENV["$"](WU.FindWindow("DungeonBalanceTowerNew")).root
end

function InitWindow()
  WU.ToggleRendering(REF.BottomButtons, false)
  WU.ToggleRendering(_ENV["$"](REF.LEFT).WidgetDungeonGroup, false)
  WU.ToggleRendering(_ENV["$"](REF.RIGHT).WidgetDungeonGroup, false)
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/summary/"), OnTowerSummary)
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/actorgroup/"), OnActorGroup)
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
  SetDrops(m_summary.curFloor)
  SetOpponents(m_summary.curFloor)
  REF.LabelCurrentFloor.UILabel.text = WU.GetString("WindowTower_CurrentFloor", m_summary.curFloor - 1)
end

function OnActorGroup(result)
  if result == nil then
    return
  end
  m_groups = result
  WU.ToggleRendering(REF.WidgetDungeonGroup, true)
  REF.WidgetDungeonGroup.gameObject:SetActive(true)
  local tempGroup = {
    members = m_groups.actorGroup
  }
  REF.WidgetDungeonGroup["$SetView"](tempGroup)
  REF.WidgetDungeonGroup["$SetHp"](tempGroup)
  WU.ToggleRendering(REF.BottomButtons, true)
end

function SetDrops(floor)
  local ids = PB.get("ExtremeChallengeDungeon", m_summary.curDifficulty).dungeonId
  m_dungeonId = ids[floor]
  m_drops = PB.get("DungeonReward", m_dungeonId).dropDisplay
  LU.Set(REF.DropContent, #m_drops)
end

function SetOpponents(floor)
  local enemies = NormalizeEnemy(m_summary.enemyGroups[floor].enemies)
  REF.AffixWidget["$ShowAffixWidget"](m_dungeonId)
  REF.WidgetEnemyGroup["$SetViewByActors"](enemies, true, true)
end

function NormalizeEnemy(enemies)
  for k, v in pairs(enemies) do
    if type(v) ~= "table" then
      enemies[k] = {id = v}
    end
  end
  return enemies
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
