local BASE = inherit("Window/DungeonPrepareBase/DungeonPrepareBase", _ENV)
local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("Common/HtmlUtil")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local m_activityManager = S:Get("ActivityManager")
local m_isInCultivationPVPActivity, m_fromWelfare
local m_repeatedContext = {}
local m_rankRequsetSended
local BuffBGHeight = {
  [0] = 177,
  [1] = 310,
  [2] = 445,
  [3] = 580
}
local BuffCnt = 3
local m_cultivationDungeonId, m_affixDescText, m_dungeonId, m_chapterId, m_dropDisplay, m_record

function SetupWindow()
  BASE.BindDrop()
  WU.BindButtonEvent(REF.ButtonFight, function()
    BASE.ButtonFightClick(m_dungeonId, m_chapterId)
  end)
  WU.BindButtonEvent(REF.TouchInfo, function()
    if m_dungeonId then
      REF.PanelBuff.gameObject:SetActive(not REF.PanelBuff.gameObject.activeSelf)
      if REF.PanelBuff.gameObject.activeSelf == true then
        ShowBuff(m_dungeonId)
      end
    end
  end)
  WU.BindButtonEvent(REF.SpriteHelp, function()
    REF.HelpNode.gameObject:SetActive(not REF.HelpNode.gameObject.activeSelf)
    if REF.HelpNode.gameObject.activeSelf == true then
      ShowHelp()
    end
  end)
  WU.BindButtonEvent(REF.ButtonFightCultivationPVP, OnClickFightCultivationPVP)
  WU.BindButtonEvent(_ENV["$"](REF.RankListHistory).SpriteHint, OnClickRankListHint)
  WU.BindButtonEvent(_ENV["$"](REF.RankListCurrent).SpriteHint, OnClickRankListHint)
  WU.BindButtonEvent(REF.PlayerList, OnClickRankListHint)
end

function InitWindow()
  m_fromWelfare = false
  this:Bind("DungeonPrepare/DungeonId", OnDungeonId)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
    if activity then
      local ac = activity[1]
      local status = ACU.GetStatus(ac)
      if status ~= PB.enum.ActivityStatus.Finished and status ~= PB.enum.ActivityStatus.None then
        this:BindRemote(DB:GameRequest("fci/chipexchange/"), ReplaceChip)
      end
    end
  end)
  this:RegisterGameEvent("SetDungeonPrepareFightButton", function(dungeonType, dungeonRecord)
    if dungeonType == PB.enum.DungeonType.Story then
      REF.Label1.UIHtmlLabel.text = WU.GetString("Window_StoryDungeon_FightButton")
      if WU.IsStandaloneGame() then
        WU.ToggleRendering(REF.LabelCost, false)
      end
    else
      REF.Label1.UIHtmlLabel.text = WU.GetString("WindowTower_Prepare")
    end
  end)
  REF.PanelBuff.gameObject:SetActive(false)
  REF.HelpNode.gameObject:SetActive(false)
end

function SaveContext()
  table.insert(m_repeatedContext, {
    fromWelfare = m_fromWelfare,
    dungeonId = m_dungeonId,
    chapterId = m_chapterId
  })
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    m_fromWelfare = m_fromWelfare
    this:SetData("DungeonPrepare/ChapterId", context.chapterId)
    this:SetData("DungeonPrepare/DungeonId", context.dungeonId)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function Goto(dungeonId, fromWelfare)
  BASE.Goto(dungeonId)
  m_fromWelfare = fromWelfare
end

function OnDungeonId(dungeonId)
  if dungeonId then
    m_dungeonId = dungeonId
    m_chapterId = this:GetData("DungeonPrepare/ChapterId")
    local reward = PB.get("DungeonReward", m_dungeonId)
    m_dropDisplay = reward.dropDisplay
    m_record = this:GetData("fci/dungeon/chapter/" .. m_chapterId).recordDungeons[m_dungeonId]
    ReplaceChip(DB:GetData("fci/chipexchange/"))
    BASE.SetDrop(reward, m_dropDisplay)
    BASE.ShowAffixList(m_dungeonId)
    BASE.SetDungeonInfo(m_dungeonId, m_chapterId, m_record)
    local dungeon = PB.get("DungeonMonster", dungeonId)
    WU.SetActive(REF.SpriteHelp, dungeon and dungeon.isShowHelp)
    if m_cultivationDungeonId then
      this:Unbind("fci/challenge-mode/season/" .. m_cultivationDungeonId, OnRankListHistory)
    end
    local cultivationDungeonId = DU.GetCultivationDungeonId(dungeonId)
    m_cultivationDungeonId = cultivationDungeonId
    m_isInCultivationPVPActivity = ACU.IsInCultivationPVPActivity(m_cultivationDungeonId)
    local activityId = this:GetData("dungeon2cultivationPVPActivityId")[m_cultivationDungeonId]
    if m_isInCultivationPVPActivity then
      local acInfo = m_activityManager.GetActivitySync(PB.enum.ActivityType.CultivationPvP, activityId)
      _ENV["$"](REF.RankListCurrent).LabelTitle.UILabel.text = WU.RenderTime2(acInfo.timestampStart) .. " ~ " .. WU.RenderTime2(acInfo.timestampEnd)
    end
    WU.SetActive(REF.NodeCultivationPVP, m_isInCultivationPVPActivity)
    WU.SetActive(REF.RankListHistory, false)
    local p = REF.NodeFight.transform.localPosition
    p.x = fif(m_isInCultivationPVPActivity, -445, 0)
    REF.NodeFight.transform.localPosition = p
    if activityId and m_isInCultivationPVPActivity then
      WU.SetActive(REF.PlayerList, false)
      this:GameRequest("fci/challenge-mode-rank/top/10/dungeon/" .. m_cultivationDungeonId):Get(OnRankListCurrent)
    else
    end
  end
end

function OnRankListCurrent(result)
  if result then
    if result.rankInfo and result.rankInfo[1] and result.rankInfo[1].dungeonId ~= m_cultivationDungeonId then
      return
    end
    local rankList = result.rankInfo
    for i = 1, 10 do
      WU.SetActive(REF.ScrollViewPlayerList[i - 1].root, false)
    end
    for i = 1, #rankList do
      local widgetGasket = REF.ScrollViewPlayerList[i - 1]
      WU.SetActive(widgetGasket.root, true)
      local rankInfo = rankList[i]
      widgetGasket.LabelRank.UILabel.text = i
      widgetGasket.LabelPlayerName.UILabel.text = rankInfo.playerName
      widgetGasket.LabelScore.UILabel.text = -rankInfo.score
    end
    WU.SetActive(REF.PlayerList, true)
    REF.ScrollViewPlayerList.UIScrollView:ResetPosition()
  end
end

function OnRankListHistory(result)
  if result then
    local rankList = result.rankList
    WU.SetActive(REF.RankListHistory, rankList[1] ~= nil)
    if rankList[1] then
      _ENV["$"](REF.RankListHistory).LabelPlayerName.UILabel.text = rankList[1].playerName
      _ENV["$"](REF.RankListHistory).LabelScore.UILabel.text = -rankList[1].score
    end
  end
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

function ShowBuff(dungeonId)
  local dungeon = PB.get("DungeonMonster", dungeonId)
  if dungeon == nil then
    error("no DungeonMonster for dungeonId:" .. tostring(dungeonId))
    return
  end
  InitEnemyAttr()
  if table.empty(dungeon.team1Affix) and table.empty(dungeon.team2Affix) then
    SetBuffVisible(0)
    return
  end
  local affixList = _ENV["!"]({})
  affixList:append(dungeon.team1Affix)
  affixList:append(dungeon.team2Affix)
  affixList = affixList:distinct()
  local player = WU.GetString("Window_OurSide")
  local enemy = WU.GetString("Window_EnemySide")
  m_affixDescText = ""
  local index = 0
  for _, affix in pairs(affixList) do
    m_affixDescText = WU.GetString("AffixDesc_" .. affix) .. HU.HtmlSplitLine("Common.Line_dark")
    local desc = WU.GetString("AffixTitle_" .. affix) .. ":"
    local playerDesc = ""
    local playerOwn = false
    if table.has(dungeon.team1Affix, affix) then
      playerDesc = playerDesc .. player
      playerOwn = true
    end
    if table.has(dungeon.team2Affix, affix) then
      if playerOwn then
        playerDesc = playerDesc .. "/"
      end
      playerDesc = playerDesc .. enemy
    end
    local refBuff = _ENV["$"](REF[string.format("NodeBuff%d", index + 1)])
    if index < BuffCnt then
      refBuff.AffixTitleLabel.UIHtmlLabel.text = desc
      refBuff.AffixLabel.UIHtmlLabel.text = playerDesc
      refBuff.root.gameObject:SetActive(true)
      refBuff.AffixDescLabel.UIHtmlLabel.text = m_affixDescText
    end
    index = index + 1
  end
  SetBuffVisible(index)
end

function InitEnemyAttr()
  local dungeons = PB.get("DungeonMonster", m_dungeonId)
  local mainMonster = {}
  local assistMonster = {}
  local monsterList = {}
  local count = 0
  local hp = 0
  local speed = 0
  local index = 1
  local mainIndex = 1
  local subIndex = 4
  local mainMonsterLv = 0
  for i = 1, 6 do
    local monsterID = 0
    local monsterLv = 0
    local monsterIndex = 0
    count = count + 1
    if (i - 1) % 2 == 0 then
      monsterID = dungeons.monsterId[mainIndex]
      monsterLv = dungeons.level[mainIndex]
      monsterIndex = dungeons.levelUpIndex[mainIndex]
      mainIndex = mainIndex + 1
    else
      monsterID = dungeons.monsterId[subIndex]
      monsterLv = dungeons.level[subIndex]
      monsterIndex = dungeons.levelUpIndex[subIndex]
      subIndex = subIndex + 1
    end
    local ret = WU.GetMonsterAttr(monsterID, monsterLv, monsterIndex)
    if ret and ret[PB.enum.AttrType.Hp] then
      hp = hp + ret[PB.enum.AttrType.Hp].value
    end
    if ret and ret[PB.enum.AttrType.Speed] and ret[PB.enum.AttrType.Speed].value ~= 0 then
      speed = ret[PB.enum.AttrType.Speed].value
      mainMonsterLv = monsterLv
    end
    if count == 2 then
      local refAttr = _ENV["$"](REF[string.format("NodeAttr%d", index)])
      if speed == 0 then
        refAttr["$gameObject"]:SetActive(false)
      else
        refAttr["$gameObject"]:SetActive(true)
        refAttr.SpeedValue.UIHtmlLabel.text = tostring(speed)
        refAttr.LifeValue.UIHtmlLabel.text = tostring(math.floor(mainMonsterLv / 5))
      end
      count = 0
      hp = 0
      speed = 0
      index = index + 1
    end
  end
end

function SetBuffVisible(index)
  REF.SpriteBuffBg.UISprite.height = BuffBGHeight[0]
  for i = 1, 3 do
    local ref = REF[string.format("NodeBuff%d", i)]
    if i <= index then
      ref.gameObject:SetActive(true)
      if i == index then
        REF.SpriteBuffBg.UISprite.height = BuffBGHeight[index]
      end
    else
      ref.gameObject:SetActive(false)
    end
  end
end

function OnClickFightCultivationPVP(obj)
  WU.AcquireWindowAsync("ActorGroupCultivationPVP", function(w)
    this:SetData("ActorGroupCultivationPVP/DungeonId", m_cultivationDungeonId)
    this:SetData("ActorGroupCultivationPVP/ChapterId", m_chapterId)
    this:SetData("CultivationPVPFromWelfare", m_fromWelfare)
  end)
end

function OnClickRankListHint()
  this:SetData("CultivationPVPRanks/GotoDungeon", m_cultivationDungeonId)
  WU.AcquireWindowAsync("CultivationPVPRanks")
end

function ReplaceChip(info)
  if REF.NodeActorChipActivity then
    WU.SetActive(REF.NodeActorChipActivity, false)
  elseif info == nil or m_dropDisplay == nil then
    return
  else
    return
  end
  if info == nil then
    return
  end
  local ac
  local exchangeInfo = info
  local setB4 = false
  for k, v in pairs(exchangeInfo.settlePosInfo) do
    if v ~= 0 then
      setB4 = true
      break
    end
  end
  local GotoShowAble = exchangeInfo and not setB4
  m_activityManager.GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
    if activity then
      ac = activity[1]
    end
  end)
  if ac then
    local replaceId, tmpList, index = DU.ReplaceActorChip(m_dungeonId, m_dropDisplay)
    if ACU.GetStatus(ac) == PB.enum.ActivityStatus.Started and replaceId then
      m_dropDisplay = tmpList
      BASE.SetCustom({replaceChip = true})
      BASE.RefreshDrop()
    end
    if ACU.GetStatus(ac) == PB.enum.ActivityStatus.PreHeat or ACU.GetStatus(ac) == PB.enum.ActivityStatus.Started then
      if not GotoShowAble then
        return
      end
      if tmpList then
        WU.SetActive(REF.NodeActorChipActivity, GotoShowAble)
        if m_record then
          local index2First = m_record.new
          index = fif(index2First, 1, index)
        end
        local chipPosX = CS.UnityEngine.Vector3.zero
        local nodePos = REF.NodeActorChipActivity.transform.localPosition
        local ref = REF.DropContent[index - 1]
        chipPosX = ref["$transform"].localPosition.x
        REF.NodeActorChipActivity.transform.localPosition = CS.UnityEngine.Vector3(chipPosX, nodePos.y, nodePos.z)
        WU.ClearButtonEvent(REF.ButtonActorChip)
        WU.BindButtonEvent(REF.ButtonActorChip, function()
          if WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare, PB.enum.UnlockWindow.Welfare) then
            return
          end
          this:SetData("WelfareTab", "ActorChipExchange")
          WU.AcquireWindowAsync("Welfare")
        end)
      end
    end
  end
end
