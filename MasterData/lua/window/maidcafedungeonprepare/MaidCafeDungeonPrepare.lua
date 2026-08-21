local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local U = require("Common/Util")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local GU = require("Common/GroupUtil")
local m_activityManager = S:Get("ActivityManager")
local m_dungeonId = 0
local m_dungeonReward = {}
local m_displayTable = {}
local m_dungeonRecord, m_dungeonType, m_rankModeInfoAll, m_rankType, m_score, m_activityId
local m_dungeonChainId = {}
local m_balanceDungeonId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFight, OnButtonFightClick)
  LU.Bind(REF.DropContent, {
    updateRow = UpdateEventDropSlot
  })
end

function ShowHelp()
  local dunID = m_dungeonId
  if dunID then
    local dungeon = PB.get("DungeonMonster", dunID)
    REF.TipsMethonLabel.UIHtmlLabel.text = WU.GetString(string.format("RecommendDesc_%d", dungeon.recommendDesc))
    for i = 1, 3 do
      local refActor = REF.GameObjectRole[i - 1]
      local actorID = dungeon.recommendID[i]
      if actorID and actorID ~= 0 then
        refActor.root.gameObject:SetActive(true)
        refActor["$$SetData"](actorID)
      else
        refActor.root.gameObject:SetActive(false)
      end
    end
  end
end

function InitWindow()
  m_rankType = this:GetData("WindowDungeon/MaidRankType")
  m_activityId = this:GetData("MaidCafe/RankActivityId")
  this:Bind("fci/maidcafe/rank-mode", OnRankModeInfoChange)
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_dungeonId = dungeonId
  m_dungeonRecord = nil
  m_dungeonReward = nil
  local dungeonInfo = PB.get("DungeonMonster", m_dungeonId)
  if dungeonInfo == nil then
    error("DungeonID not exist", m_dungeonId)
    return
  end
  REF.TextureStage.UITexture.mainTexturePath = "Texture/StageThumb/" .. dungeonInfo.stageID
  OnDungeonIdChanged(dungeonId)
end

function Focus(on)
  if on then
    WU.SetWindowTitle("MaidCafeDungeonPrepare", "EventStagePrepare")
  end
end

function OnDungeonIdChanged(dungeonId)
  if dungeonId then
    m_dungeonId = dungeonId
    this:SetData("WindowDungeon/DungeonId", m_dungeonId)
    m_dungeonChainId[1] = m_dungeonId
    local i = 1
    while m_dungeonChainId[i] do
      local dun = PB.get("DungeonMonster", m_dungeonChainId[i])
      if dun and dun.nextDungeonId ~= 0 and dun.nextDungeonId ~= -1 then
        m_dungeonChainId[i + 1] = dun.nextDungeonId
      end
      i = i + 1
    end
    m_balanceDungeonId = m_dungeonChainId[#m_dungeonChainId]
    for k = 0, #REF.TeamInfo - 1 do
      WU.SetActive(REF.TeamInfo[k].root, k < #m_dungeonChainId)
      if k < #m_dungeonChainId then
        local actorList = {}
        local monsterList = {}
        local showTypeList = {}
        local showDescList = {}
        local dungeon = PB.get("DungeonMonster", m_dungeonChainId[k + 1])
        for j = 1, #dungeon.monsterId do
          monsterList[j] = dungeon.monsterId[j]
        end
        for j = 1, #dungeon.showType do
          showTypeList[j] = dungeon.showType[j]
        end
        ShowStoryDungeonActorList(REF.TeamInfo[k], monsterList, showTypeList)
      end
    end
  end
  m_dungeonReward = PB.get("DungeonReward", m_balanceDungeonId)
  local initDungeonReward = PB.get("DungeonReward", m_dungeonId)
  WU.SetActive(REF.NodeDrops, 0 < #m_displayTable)
  if 0 < #m_displayTable then
    m_displayTable = m_dungeonReward.dropDisplay
    LU.Set(REF.DropContent, #m_displayTable)
    REF.TeamInfo.gameObject.transform.localPosition = {
      x = 10,
      y = -255,
      z = 0
    }
  else
    REF.TeamInfo.gameObject.transform.localPosition = {
      x = 10,
      y = 34,
      z = 0
    }
  end
  local hasCost = 0 < #initDungeonReward.cost
  if hasCost then
    local cost = initDungeonReward.cost[1]
    local costWin = m_dungeonReward.costWin[1] or {count = 0}
    REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count + costWin.count)
  end
  WU.ToggleRendering(REF.LabelCost, hasCost)
  REF.AffixWidget["$ShowAffixWidget"](m_dungeonId)
end

function OnButtonFightClick(obj)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_RankMode, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity) and activity.activityId == m_activityId then
          WU.AcquireWindowAsync("MaidCafeActorGroup", function(ui)
            this:SetData("MaidCafe/DungeonInfo", {
              dungeonId = m_dungeonId,
              activityId = m_activityId,
              rankType = m_rankType,
              balanceDungeonId = m_balanceDungeonId
            })
          end)
          return
        end
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function UpdateEventDropSlot(ref, wrapIndex, realIndex)
  if m_displayTable then
    if realIndex < 0 or realIndex >= #m_displayTable then
      return
    end
    local widgetIconSlot = ref.root
    local item = m_displayTable[realIndex + 1]
    if item.type == 11 then
      widgetIconSlot["$SetData"](item.type, item.id)
    else
      widgetIconSlot["$SetData"](item.type, item.id, item.count)
    end
    widgetIconSlot["$SetClickCallback"](function()
      WU.ShowResourceDetail(item.type, item.id)
    end)
  end
end

function ShowStoryDungeonActorList(groupRef, monsterIds, showTypeList)
  local actors = GU.MonsterGroup(monsterIds)
  groupRef.WidgetDungeonGroup["$SetTips"](showTypeList, true)
  groupRef.WidgetDungeonGroup["$SetViewByActors"](actors, true, true)
end

function OnRankModeInfoChange(info)
  if info == nil then
    return
  end
  m_rankModeInfoAll = info
  m_score = m_rankModeInfoAll.rankModeInfo[m_rankType].rankModeValue
  REF.RankScore.UILabel.text = m_score
end
