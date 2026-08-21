local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_dungeonId, m_rewardDisplay, m_towerSumry
local m_rewards = {}
local m_enemies, m_pillGot
local m_scoreGetAble = false
local m_normalGetAble = false
local m_ticketCnt
local m_setBtnB4 = false
local m_NodeFinalActiveBeforeShare

function SetupWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  LU.Bind(REF.DropContent, {
    updateRow = UpdateDropSlot
  })
  ManageButtonEvents()
end

function InitWindow()
  REF.NodeInfo.gameObject:SetActive(false)
  REF.NodeNormal.gameObject:SetActive(false)
  REF.NodeFinal.gameObject:SetActive(false)
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/select-actors/"), function(result)
    this:SetData("Share/TowerNewHasScore", result and #result.actors > 0)
  end)
  this:RegisterGameEvent("TowerNewRefresh", function()
  end)
  this:Bind("fci/extreme-challenge/summary/", OnSummaryChanged)
end

function UninitWindow()
  this:SetData("Share/TowerNewHasScore", nil)
  this:SetData("Share/TowerNewPrepare", nil)
end

function SetShareInfo()
  this:SetData("ShareConfig", {
    shareName = "TowerNewPrepare",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  local data = {
    selectActors = DB:GetData("fci/extreme-challenge/select-actors/").actors,
    curFloor = m_towerSumry.curFloor - 1
  }
  m_NodeFinalActiveBeforeShare = REF.NodeFinal.gameObject.activeSelf
  WU.SetActive(REF.NodeFinal, false)
  this:SetData("Share/TowerNewPrepare", data)
end

function OnSummaryChanged(result)
  if result == nil or result.curDifficulty == 0 then
    return
  end
  m_towerSumry = result
  local ticket = PB.index("Misc", 1).extremeChallengeTicket
  m_ticketCnt = this:GetData("fci/item/" .. ticket.id).count
  REF.LabelResetCount.UILabel.text = m_ticketCnt
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/reward/"), ManageReward)
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/socre-reward/"), ManageScoreReward)
  this:BroadcastGameEvent("TowerNew/SummaryChanged", result)
  if 1 < m_towerSumry.curFloor and m_towerSumry.itemSelectFloor < m_towerSumry.curFloor and m_towerSumry.curFloor <= PB.index("Misc", 1).TowerNewMaxFloor then
    RandomPills()
  end
  SetVisual()
end

function NormalizeEnemy(enemies)
  for k, v in pairs(enemies) do
    if type(v) ~= "table" then
      enemies[k] = {id = v}
    end
  end
  return enemies
end

function ManageReward(result)
  if result == nil then
    return
  end
  m_rewards = PB.all("ExtremeChallengeReward"):where(function(k, v)
    return v.difficulty == m_towerSumry.curDifficulty
  end):toarray()
  table.sort(m_rewards, function(a, b)
    return a.floor < b.floor
  end)
  WU.TraverseChildren(REF.RewardButtonGroup, function(go, index)
    local ref = _ENV["$"](go)
    local realIndex = index + 1
    local rewardFloor = m_rewards[realIndex].floor
    local hasAchieve = table.find(result.rewardGot, function(_, v)
      return v == rewardFloor
    end) ~= nil
    local getAble = rewardFloor <= m_towerSumry.curFloor - 1 and not hasAchieve
    ref.EffectReward.gameObject:SetActive(getAble)
    ref.SpriteNormal.gameObject:SetActive(not getAble)
    ref.LabelReward.UILabel.text = rewardFloor .. WU.GetString("Tower_Level")
    m_normalGetAble = getAble
    WU.ClearButtonEvent(ref.root)
    WU.BindButtonEvent(ref.root, function()
      WU.RecordButtonClick(100121101)
      if getAble then
        DB:GameRequest("fci/extreme-challenge/reward/"):Post({floor = rewardFloor}, function(pResult)
          DBH.ResChange(pResult.resChange)
          WU.ShowRewards(pResult.resChange, function()
            this:SetData("fci/extreme-challenge/reward/", pResult)
          end)
        end)
      else
        WU.AcquireWindowAsync("TowerNewRewardTip", function(win)
          _ENV["$"](win)["$$Show"](m_rewards[realIndex].reward, rewardFloor, getAble)
        end)
      end
    end)
  end)
end

function ManageScoreReward(sRewards)
  if sRewards == nil then
    return
  end
  local flag = false
  local sRewardGot = sRewards.scoreRewardGot
  local sAllRewards = PB.all("ExtremeChallengeScoreReward"):where(function(k, v)
    return v.difficulty == m_towerSumry.curDifficulty
  end):toarray()
  for key, data in pairs(sAllRewards) do
    local sHasAchieve = table.find(sRewardGot, function(_, v)
      return v == data.score
    end) ~= nil
    local sGetAble = m_towerSumry.curScore >= data.score and not sHasAchieve
    if sGetAble then
      flag = true
      break
    end
  end
  m_scoreGetAble = flag
  REF.EffectRewardFinal.gameObject:SetActive(flag)
end

function SetEnemyPreview()
  WU.TraverseChildren(REF.NodeEnemies, function(go, index)
    local ref = _ENV["$"](go)
    local realIndex = index + 1
    local info = PB.get("ActorConfig", m_enemies[realIndex].id)
    ref.TexturePreview.ActorUIPreview:ResetActor(m_enemies[realIndex].id, AU.GetActorPaletteIndex(m_enemies[realIndex].id, 0))
    ref.root.transform.localPosition = CS.UnityEngine.Vector3(index * 320, 0, 0) + CS.UnityEngine.Vector3(info.AnimOffsetX or 0, info.AnimOffsetY or 0, 0)
  end)
end

function UpdateDropSlot(ref, wrapIndex, realIndex)
  local widgetIconSlot = ref.root
  if m_rewardDisplay == nil or realIndex >= #m_rewardDisplay then
    return
  end
  local dropDisplay = m_rewardDisplay[realIndex + 1]
  if dropDisplay.type == PB.enum.ResourceType.ResPlayerGold or dropDisplay.type == PB.enum.ResourceType.ResPlayerExp or dropDisplay.type == PB.enum.ResourceType.ResPlayerMoney then
    widgetIconSlot["$SetData"](dropDisplay.type, dropDisplay.id, dropDisplay.count)
  else
    widgetIconSlot["$SetData"](dropDisplay.type, dropDisplay.id)
  end
  widgetIconSlot["$SetClickCallback"](function()
    WU.ShowResourceDetail(dropDisplay.type, dropDisplay.id)
  end)
end

function ManageButtonEvents()
  WU.BindButtonEvent(REF.ButtonChoosePills, function()
    WU.AcquireWindowAsync("TowerNewPills")
  end)
  WU.BindButtonEvent(REF.ButtonChooseTeam, function()
    WU.RecordButtonClick(100121105)
    local selectedActors = this:GetData("TowerNew/SelectedActorsLocal")
    if (selectedActors == nil or #selectedActors < 1) and not m_towerSumry.memberSelected then
      WU.AcquireWindowAsync("TowerNewTeam")
    elseif this:GetData("TowerNew/PillChoice") == nil and m_towerSumry.itemSelectFloor < m_towerSumry.curFloor then
      WU.AcquireWindowAsync("TowerNewPills")
    else
      WU.AcquireWindowAsync("TowerNewTeamPreview")
    end
  end)
  WU.BindButtonEvent(REF.ButtonReset, function()
    WU.RecordButtonClick(100121104)
    WU.SetClickB4(REF.ResetTip)
    if m_ticketCnt <= 0 then
      WU.ShowHintText(WU.GetString("Tower_NoTicket"))
    else
      WU.ResetTowerData(WU.GetString("Tower_ResetBack", m_ticketCnt), nil, nil, true, function(result)
        DBH.ResChange(result.resChange)
        WU.ShowRewards(result.resChange, function()
          WU.AcquireWindowAsync("TowerNewEntrance", function(win)
            _ENV["$"](win)["$$ShowResetHint"]()
          end, true)
        end)
      end)
    end
  end)
  WU.BindButtonEvent(REF.ButtonGroup, function()
    WU.RecordButtonClick(100121103)
    WU.EnableToRequest("TowerNew/SelectActor-NeverUpdate", "fci/extreme-challenge/select-actors/", function(result)
      WU.AcquireWindowAsync("TowerNewActorSelect")
    end)
  end)
  WU.BindButtonEvent(REF.ButtonRewardFinal, function()
    WU.RecordButtonClick(100121102)
    WU.AcquireWindowAsync("TowerNewReward")
  end)
end

function OnWindowUninited(window)
  if window.name == "Share" then
    WU.SetActive(REF.NodeFinal, m_NodeFinalActiveBeforeShare)
  end
end

function RandomPills()
  WU.EnableToRequest("TowerNew/PillUpdateAble", "fci/extreme-challenge/select-buffitems/" .. m_towerSumry.curFloor - 1 .. "/", function(result)
    if result == nil then
      return
    end
    local providedList = result.groups
    local rand = math.random(1, #providedList)
    this:GameRequest("fci/extreme-challenge/select-buffitems/" .. m_towerSumry.curFloor - 1 .. "/"):Post({selectGroup = rand}, function(response)
      m_towerSumry.itemSelectFloor = response.itemSelectFloor
      local gotPills = m_towerSumry.challengeItems or {}
      local pillGot = providedList[rand].items
      WU.AcquireWindowAsync("HintPills", function(win)
        _ENV["$"](win)["$$SetContent"](pillGot)
      end)
      for k, v in pairs(pillGot) do
        table.insert(gotPills, v)
      end
      local newList = WU.SplitItems(gotPills)
      this:SetData("TowerNew/PillsGot", newList)
      this:SetData("fci/extreme-challenge/summary/", m_towerSumry)
    end)
  end)
end

function SetVisual()
  local chosen = m_towerSumry.memberSelected and m_towerSumry.itemSelectFloor >= m_towerSumry.curFloor
  local passAll = m_towerSumry.curFloor > PB.index("Misc", 1).TowerNewMaxFloor
  REF.SpriteProgress.UISprite.fillAmount = (m_towerSumry.curFloor - 1) / PB.index("Misc", 1).TowerNewMaxFloor
  REF.NodeInfo.gameObject:SetActive(chosen or passAll)
  REF.NodeNormal.gameObject:SetActive(not passAll)
  REF.NodeFinal.gameObject:SetActive(passAll)
  REF.ButtonGroup.gameObject:SetActive(not passAll)
  if not passAll then
    m_enemies = NormalizeEnemy(m_towerSumry.enemyGroups[m_towerSumry.curFloor].enemies)
    local ids = PB.get("ExtremeChallengeDungeon", m_towerSumry.curDifficulty).dungeonId
    m_dungeonId = ids[m_towerSumry.curFloor]
    this:SetData("ActorGroupTower/DungeonId", m_dungeonId)
    local reward = PB.get("DungeonReward", m_dungeonId)
    m_rewardDisplay = reward.dropDisplay
    LU.Set(REF.DropContent, #m_rewardDisplay)
    REF.AffixWidget["$ShowAffixWidget"](m_dungeonId, {affixBG = "buff_bg"})
    REF.WidgetDungeonGroup["$SetViewByActors"](m_enemies, true, true)
    SetEnemyPreview()
    REF.LabelTip.gameObject:SetActive(not chosen)
    REF.LabelCurLevel.UILabel.text = WU.GetString("Tower_CurrentLevel", m_towerSumry.curFloor)
    REF.LabelCurInfo.UILabel.text = WU.GetString("Tower_DifficultyLevel", WU.GetString("Tower_DifficultyRecommend_" .. m_towerSumry.curDifficulty), m_towerSumry.curFloor)
    REF.LabelChooseTeam.UILabel.text = fif(not m_towerSumry.memberSelected, WU.GetString("Tower_ChooseTeam"), WU.GetString("Tower_ChosenTeam"))
    REF.LabelChoosePills.UILabel.text = fif(m_towerSumry.itemSelectFloor < m_towerSumry.curFloor, WU.GetString("Tower_ChoosePills"), WU.GetString("Tower_ChosenPills"))
    REF.ButtonChooseTeam.UISprite.spriteName = "challenge_" .. fif(not m_towerSumry.memberSelected, 6, 8)
    REF.ButtonChoosePills.UISprite.spriteName = "challenge_" .. fif(m_towerSumry.itemSelectFloor < m_towerSumry.curFloor, 6, 7)
    REF.EffectChooseTeam.gameObject:SetActive(not m_towerSumry.memberSelected)
    REF.EffectChooseTeam.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, 30)
    REF.EffectChoosePills.gameObject:SetActive(m_towerSumry.itemSelectFloor < m_towerSumry.curFloor)
    REF.EffectChoosePills.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, 30)
    this:DelayInvokeInFrames(1, function()
      REF.ResetTipEffect.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 180, 0)
    end)
  end
  WU.ActiveByNeverClick(REF.ResetTip)
  if REF.ResetTip.gameObject.activeSelf then
    REF.ResetTip.TweenPosition:ResetToBeginning()
    REF.ResetTip.TweenPosition:PlayForward()
  end
  REF.WaitTip.gameObject:SetActive(passAll)
  REF.LabelCurScore.UILabel.text = WU.GetString("Tower_Score") .. "  " .. m_towerSumry.curScore
end

function ShowResetTip()
  local towerTime = WU.GetGameDataCache("TowerAskTime")
  local timeSetting = CS.System.TimeSpan.Parse(PB.index("Misc", 1).dailyRefreshTime)
  local askAble = towerTime == nil or not WU.IsToday(CS.GameTime.UtcToLocal(towerTime)) and U.ToInt(CS.GameTime.UtcToLocal(CS.GameTime.serverUtc).Hour) >= U.ToInt(timeSetting.Hours)
  if askAble and m_towerSumry.isOld then
    WU.ShowHintText(WU.GetString("Tower_ResetTip"))
    WU.SetGameDataCache("TowerAskTime", CS.GameTime.serverUtc)
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001211, on)
end
