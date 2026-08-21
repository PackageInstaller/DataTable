local WU, DB, REF = require("Common/WindowUtil")(this)
local DBH = require("Manager/DataBindingHandler")
local CardNum = 9
local TotalDiffCards = 9
local CardPrefabURI = "GameCardMatch/WidgetCard"
local CountDownTweenBegin = 10
local TurnOverInterval = 1
local HeadEnum = {
  "game_card_1",
  "game_card_2",
  "game_card_3",
  "game_card_4",
  "game_card_5",
  "game_card_6",
  "game_card_7",
  "game_card_8",
  "game_card_9"
}
local OpenGroup = 111
local CloseGroup = 112
local DontMatchGroup = 113
local MatchedGroup = 114
local Mode = {"memory", "blind"}
local ModeParam = {
  {MemoryCountDown = 8, CountDown = 45},
  {CountDown = 45}
}
local m_isLock = false
local m_isOver = true
local m_first = -1
local m_matchList = {}
local m_generatedCards = {}
local m_mode = 2
local m_countDown, m_delayedCoroutine, m_paused, m_cheatStart, m_startCountDown, m_result, m_onGameStart

function SetupWindow()
  WU.BindButtonEvent(REF.Start, function()
    StartGame()
  end)
  WU.BindButtonEvent(REF.RewardPreview, function()
    if m_isOver then
      WU.AcquireWindowAsync("EventAutumnBonusPreview", function(ui)
        _ENV["$"](ui)["$$SetMode"](2)
      end)
    end
  end)
  CS.EventDelegate.Add(REF.Grid.UIPlayTween.onFinished, function()
    ResetWidgets()
    ShowHint()
  end)
  CS.EventDelegate.Add(REF.BoxPanel.UIPlayTween.onFinished, function()
    REF.Grid.UIPlayTween:Play(true)
  end)
  CS.EventDelegate.Add(REF.StartEndPanel.UIPlayTween.onFinished, function()
    m_startCountDown = m_startCountDown - 1
    REF.HintSprite.gameObject:SetActive(0 < m_startCountDown)
    REF.Texture.gameObject:SetActive(0 < m_startCountDown)
    REF.HintSprite.UISprite.spriteName = "minigame_" .. m_startCountDown
    if 0 < m_startCountDown then
      this:DelayInvokeInFrames(1, function()
        CS.SoundManager.Instance:PlaySound("Sound/system/s_System_91_321", 1.0)
        REF.StartEndPanel.UIPlayTween:Play(true)
      end)
    elseif m_startCountDown == 0 then
      m_countDown = ModeParam[m_mode].CountDown
      m_onGameStart = false
    else
      WU.ShowRewards(m_result)
    end
  end)
end

function InitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", true)
  ResetParams()
  CS.UIBaseProcess.Instance:SwitchUICameraProjection(true)
  this:RegisterGameEvent("TryToOpenCard", OnTryOpenCard)
  this:RegisterGameEvent("UnlockCardClick", function()
    if not m_isOver then
      m_isLock = false
    end
  end)
  local rewards = {
    {type = 7, id = 0},
    {type = 11, id = 2009}
  }
  for i = 0, #REF.GridRewards - 1 do
    REF.GridRewards[i]["$$SetData"](rewards[i + 1].type, rewards[i + 1].id)
  end
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](function()
    OnNavigation(false)
  end)
  _ENV["$"](nav)["$$SetHomeCallback"](function()
    OnNavigation(true)
  end)
end

function UninitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", nil)
  CS.UIBaseProcess.Instance:SwitchUICameraProjection(false)
  local nav = WU.FindWindow("Navigation")
  if nav ~= nil then
    _ENV["$"](nav)["$$Load"]()
  end
end

function UpdateWindow(delta)
  if m_countDown == nil or m_paused then
    return
  end
  if m_countDown == 0 or m_isOver then
    GameEnd()
    SetTimeCountDownLabel(m_countDown)
    m_countDown = nil
    return
  end
  m_countDown = math.max(m_countDown - delta, 0)
  SetTimeCountDownLabel(m_countDown)
end

function ResetParams()
  m_cheatStart = false
  m_countDown = nil
  m_isLock = false
  m_isOver = true
  REF.Start.UISprite.spriteName = "yellow_button_fight"
  REF.StartLabel.UILabel.color = CS.NGUIMath.HexToColor(810386175)
  m_first = -1
  m_paused = false
  m_startCountDown = 3
  SetTimeCountDownLabel(ModeParam[m_mode].CountDown)
  ResetBoxEffect()
  REF.Texture.gameObject:SetActive(false)
  REF.HintSprite.gameObject:SetActive(false)
  REF.HintSprite.UISprite.spriteName = "minigame_" .. m_startCountDown
  REF.HintSprite.UISprite:SnapWithoutScale()
end

function OnNavigation(isHome)
  local function Next(isHome)
    if isHome then
      this:BroadcastGameEvent("OnNavigation", "City")
    else
      this:BroadcastGameEvent("OnNavigation", "Back")
    end
  end
  
  if m_onGameStart then
    return
  end
  if m_isOver then
    Next(isHome)
  else
    m_paused = true
    WU.ShowMessageYesNo(WU.GetString("Window_GameCardMatchCancelConfirm"), function(result)
      if result == "YES" then
        Next(isHome)
      else
        m_paused = false
      end
    end)
  end
end

function SetTimeCountDownLabel(time)
  local flag = time < CountDownTweenBegin and 0 < time
  REF.TimeCountDown.TweenScale.enabled = flag and not m_isOver
  REF.TimeCountDown.UIHtmlLabel.color = CS.NGUIMath.HexToColor(fif(flag, 4284966911, 4294967295))
  if time >= CountDownTweenBegin or m_isOver then
    REF.TimeCountDown.transform.localScale = CS.UnityEngine.Vector3.one
  end
  local min = time // 60
  local sec = math.floor(time % 60)
  REF.TimeCountDown.UIHtmlLabel.text = string.format("%02d:%02d", min, sec)
end

function StartGame()
  if m_onGameStart or not m_isOver then
    return
  end
  m_onGameStart = true
  ResetParams()
  REF.Texture.gameObject:SetActive(true)
  if m_delayedCoroutine then
    this:StopCoroutine(m_delayedCoroutine)
  end
  this:GameRequest("fci/activity-purblepairs/create/"):Post({}, function(result)
    local function Next(result)
      if GenerateCards(CardNum, result.data) then
        REF.BoxPanel.UIPlayTween:Play(true)
      else
        StartGameFailed(true)
      end
    end
    
    if not result.canReward then
      WU.ShowMessageYesNo(WU.GetString("Window_GameCardMatch_NoRewardHint"), function(result)
        if result == "YES" then
          Next(result)
        else
          StartGameFailed()
        end
      end)
    else
      Next(result)
    end
  end, function()
    StartGameFailed(true)
  end)
end

function StartGameFailed(showHint)
  REF.Texture.gameObject:SetActive(false)
  m_onGameStart = false
  if showHint then
    WU.ShowHintText(WU.GetString("Window_GameCardMatch_CreateFailed"))
  end
end

function GenerateCards(needCount, serializationData)
  local cardData = {}
  local levelData = {}
  m_generatedCards = {}
  for i = 1, TotalDiffCards do
    table.insert(cardData, {
      head = HeadEnum[i]
    })
  end
  if serializationData then
    for i = 1, #serializationData do
      local index = serializationData[i]
      if cardData[index] then
        local image = {
          id = index,
          head = cardData[index].head,
          turn = false
        }
        table.insert(m_generatedCards, image)
      else
        return false
      end
    end
  else
    local usedIndex = {}
    local randomIndex
    for i = 1, needCount do
      repeat
        randomIndex = math.random(1, #cardData)
      until usedIndex[randomIndex] == nil
      usedIndex[randomIndex] = true
      local oriCard = cardData[randomIndex]
      local generatedCard = {
        id = randomIndex,
        head = oriCard.head,
        turn = false
      }
      table.insert(levelData, generatedCard)
      local image = {}
      table.copy(generatedCard, image)
      table.insert(levelData, image)
    end
    local max = #levelData
    for i = 1, #levelData do
      local rdm = math.random(1, max)
      table.insert(m_generatedCards, levelData[rdm])
      table.remove(levelData, rdm)
      max = max - 1
    end
  end
  return true
end

function ResetWidgets()
  for i = 1, 18 do
    local ref = REF.Grid[i - 1]
    ref["@index"] = i
    ref["$$SetData"](m_generatedCards[i])
    m_generatedCards[i].ref = ref
  end
end

function ShowHint()
  if not m_isOver then
    return
  end
  m_isOver = false
  REF.Start.UISprite.spriteName = "disable_button_02"
  REF.StartLabel.UILabel.color = CS.NGUIMath.HexToColor(1651344127)
  m_matchList = {}
  if Mode[m_mode] == "blind" then
    REF.HintSprite.gameObject:SetActive(true)
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_91_321", 1.0)
    REF.StartEndPanel.UIPlayTween:Play(true)
  elseif Mode[m_mode] == "memory" then
    OpenAllCards()
    m_delayedCoroutine = this:DelayInvokeInSeconds(ModeParam[m_mode].MemoryCountDown, function()
      if m_isOver then
        return
      end
      CloseAllCards()
      REF.HintSprite.gameObject:SetActive(true)
      CS.SoundManager.Instance:PlaySound("Sound/system/s_System_91_321", 1.0)
      REF.StartEndPanel.UIPlayTween:Play(true)
    end)
  end
end

function CloseAllCards()
  for i = 1, #m_generatedCards do
    m_generatedCards[i].ref["$$CloseCard"]()
    m_generatedCards[i].turn = false
  end
end

function OpenAllCards()
  for i = 1, #m_generatedCards do
    m_generatedCards[i].ref["$$OpenCard"]()
    m_generatedCards[i].turn = true
  end
end

function OnTryOpenCard(go)
  if m_isLock or m_isOver then
    return
  end
  local ref = _ENV["$"](go)
  local index = ref["@index"]
  if not m_generatedCards[index].turn then
    if m_first == -1 then
      ref["$$OpenCard"]()
      ref["$$SetFrame"](true)
      m_first = index
      m_generatedCards[index].turn = true
    else
      ref["$$OpenCard"]()
      m_generatedCards[index].turn = true
      CheckOpen(index)
    end
  end
end

function CheckOpen(index)
  m_isLock = true
  if m_generatedCards[m_first].id == m_generatedCards[index].id then
    table.insert(m_matchList, m_first)
    table.insert(m_matchList, index)
    this:DelayInvokeInSeconds(0.6, function()
      CS.SoundManager.Instance:PlaySound("Sound/system/s_System_CardMatchSuccess", 1.0)
      m_generatedCards[index].ref["$$Matched"]()
      m_generatedCards[m_first].ref["$$Matched"]()
      if #m_matchList // 2 == CardNum then
        GameEnd(true)
      end
      m_first = -1
      m_isLock = false
    end)
  else
    this:DelayInvokeInSeconds(0.6, function()
      CS.SoundManager.Instance:PlaySound("Sound/system/s_System_CardMatchFail", 1.0)
      m_generatedCards[index].ref["$$DontMatch"]()
      m_generatedCards[index].turn = false
      m_generatedCards[m_first].ref["$$DontMatch"]()
      m_generatedCards[m_first].turn = false
      m_first = -1
    end)
  end
end

function GameEnd(noTimesUp)
  if m_isOver then
    return
  end
  m_isOver = true
  REF.Start.UISprite.spriteName = "yellow_button_fight"
  REF.StartLabel.UILabel.color = CS.NGUIMath.HexToColor(810386175)
  local postData = {
    matchPairs = #m_matchList // 2,
    indexList = m_matchList
  }
  this:GameRequest("fci/activity-purblepairs/balance/"):Post(postData, function(result)
    DBH.ResChange(result.resChange)
    m_result = result.resChange
    if noTimesUp then
      WU.ShowRewards(m_result)
    else
      REF.Texture.gameObject:SetActive(true)
      REF.HintSprite.UISprite.spriteName = "minigame_timesup"
      REF.HintSprite.UISprite:SnapWithoutScale()
      REF.HintSprite.gameObject:SetActive(true)
      CS.SoundManager.Instance:PlaySound("Sound/system/s_System_91_timesup", 1.0)
      REF.StartEndPanel.UIPlayTween:Play(true)
    end
  end)
end

function ResetBoxEffect()
  for i = 0, 17 do
    local ref = REF.Grid[i]
    ref["$$SetFrame"](false)
    ref["$$SetLight"](false)
  end
end
