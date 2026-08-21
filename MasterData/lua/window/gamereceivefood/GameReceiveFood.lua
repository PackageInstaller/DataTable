local WU, DB, REF = require("Common/WindowUtil")(this)
local U = require("Common/Util")
local CO = require("Common/Coroutine")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local P = {
  MinSpeed = 600,
  MaxSpeed = 1350,
  TotalTime = 45,
  ColWidth = 100,
  DelayDropMinTime = 1,
  DelayDropMaxTime = 2,
  BetweenInterval = 20,
  TimeIncrease = 5,
  BounsTimeIncrease = 10,
  InGameDropChance = 0.2,
  DropBounsTimeItemDelay = 30,
  BounsTimeMinSpeed = 750,
  BounsTimeMaxSpeed = 750,
  BounsTimeSpeedUp = 450,
  CountDownRedThresh = 10,
  EachMoneyPrice = 20
}
local ReceiverBounds = REF.ReceiverNode.UIWidget:CalculateBounds(REF.BoxPanel.transform)
local InGameDrops = {
  "Bomb",
  "TimeIncrease",
  "Magnet"
}
local DropState = {
  "NotOnDropping",
  "OnWaiting",
  "OnDropping"
}
local m_bounsTime, m_totalTime
local m_drops = {
  {},
  {}
}
local m_dropLines = {}
local m_onDropWidget = {}
local m_isGameOver, m_magnet, m_isReward, m_rewardRes, m_scoreEffect, m_timeChange, m_bounsTimeChange, m_lineCount, m_dropBounsTimeDelay, m_timeBounsItem
local m_speedUp = 0
local m_savedInGameDropChance, m_isLocal, m_catchItemMinigame

function SetupWindow()
  WU.SetActive(REF.Debug, false)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_rewardRes and m_rewardRes[dataIndex]
    end,
    updateSlot = UpdateSlot
  })
  WU.BindButtonEvent(REF.Start, function()
    StartGame()
  end)
  WU.BindButtonEvent(REF.StartGame, function()
    StartGame(true)
  end)
end

function InitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", true)
  ResetGame()
  this:RegisterGameEvent("ScoreChange", OnScoreChange)
  this:RegisterGameEvent("TimeChange", OnTimeChange)
  this:RegisterGameEvent("BounsTimeChange", OnBounsTimeChange)
  this:RegisterGameEvent("Magnet", function()
    m_magnet = true
  end)
  this:RegisterGameEvent("Bomb", OnBomb)
  CS.UIBaseProcess.Instance:SwitchUICameraProjection(true)
end

function UninitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", nil)
  CS.UIBaseProcess.Instance:SwitchUICameraProjection(false)
end

function StartGame(skipServer)
  m_drops = {
    {},
    {}
  }
  
  local function func(gameReceiveFood)
    for i = 1, #gameReceiveFood.drops do
      local drop = gameReceiveFood.drops[i]
      local inGameDrop = InGameDrops[drop.id] ~= nil
      local dropPool = m_drops[fif(inGameDrop, 2, 1)]
      local maxCount = drop.maxCount
      if drop.type == PB.enum.ResourceType.ResPlayerGold then
        maxCount = math.floor(drop.maxCount / P.EachMoneyPrice)
      end
      for count = 1, maxCount do
        local c = {
          typeName = fif(inGameDrop, InGameDrops[drop.id], "Food"),
          inGameDrop = inGameDrop
        }
        if not inGameDrop then
          c.type = drop.type
          c.typeId = drop.typeId
        end
        c.minSpeed = drop.minSpeed or 0
        c.maxSpeed = drop.maxSpeed or 0
        table.insert(dropPool, c)
      end
    end
    ResetGame()
    m_isGameOver = false
    this:BroadcastGameEvent("NavigationDisplay", false)
    m_dropBounsTimeDelay = P.DropBounsTimeItemDelay
    m_totalTime = P.TotalTime
    DisplayChange()
    WU.SetActive(REF.EffectArrow, true)
    CO.coroutine_call(GenDropFromCache, this)()
  end
  
  m_isLocal = skipServer
  if skipServer then
    func(PB.get("GameReceiveFood", 1))
  else
    this:GameRequest("fci/catch-item-minigame/"):Get(function(resp)
      m_catchItemMinigame = resp
      if resp.randomIndex == 0 then
        WU.ShowHintText(WU.GetString("ReceiveFood_GameNotTriggered"))
        return
      end
      local gameReceiveFood = PB.get("GameReceiveFood", resp.randomIndex)
      if gameReceiveFood == nil then
        warning("GameReceiveFood", "GameReceiveFood can't find id " .. tostring(resp.randomIndex))
        return
      end
      func(gameReceiveFood)
    end)
  end
end

function ResetGame()
  WU.SetActive(REF.BounsTime, false)
  WU.SetActive(REF.EffectBG, false)
  WU.SetActive(REF.EffectScore, false)
  WU.SetActive(REF.EffectArrow, false)
  local lp = REF.DropsNode.transform.localPosition
  REF.DropsNode.transform.localPosition = CS.UnityEngine.Vector3(lp.x, 540 + P.ColWidth + 50, 0)
  m_lineCount = math.floor(REF.BoxPanel.UIWidget.width / P.ColWidth)
  for _, dropPool in pairs(m_drops) do
    for i = 1, #dropPool do
      local swapIndex = math.random(1, #dropPool)
      dropPool[i].dropped = false
      dropPool[swapIndex].dropped = false
      dropPool[i], dropPool[swapIndex] = dropPool[swapIndex], dropPool[i]
    end
  end
  m_speedUp = 0
  m_rewardRes = {}
  m_bounsTime = 0
  m_isGameOver = true
  this:BroadcastGameEvent("NavigationDisplay", true)
  m_totalTime = nil
  m_isReward = false
  DisplayChange()
end

function UpdateWindow(delta)
  if m_totalTime == nil or m_isGameOver then
    return
  end
  m_totalTime = m_totalTime - delta
  if 0 < m_bounsTime then
    m_bounsTime = m_bounsTime - delta
  end
  if m_dropBounsTimeDelay then
    m_dropBounsTimeDelay = m_dropBounsTimeDelay - delta
    if m_dropBounsTimeDelay <= 0 then
      m_dropBounsTimeDelay = nil
      m_timeBounsItem = {
        typeName = "TimeBouns",
        inGameDrop = true,
        minSpeed = P.BounsTimeMinSpeed,
        maxSpeed = P.BounsTimeMaxSpeed
      }
      CO.coroutine_call(GenDropSpecific, this)()
    end
  end
  if m_totalTime <= 0 then
    OverGame()
    return
  end
  RefreshTimeCountDown()
  local trans = REF.BoxPanel.transform:InverseTransformPoint(WU.ScreenToWorld(WU.MousePosition()))
  local x = trans.x
  x = math.max(-REF.BoxPanel.UIWidget.width / 2 + ReceiverBounds.extents.x, x)
  x = math.min(REF.BoxPanel.UIWidget.width / 2 - ReceiverBounds.extents.x, x)
  local oriPos = REF.ReceiverNode.transform.localPosition
  REF.ReceiverNode.transform.localPosition = CS.UnityEngine.Vector3(x, oriPos.y, 0)
  IntersectsLogic()
  if m_magnet then
    m_magnet = false
    OnMagnet()
  end
end

function IntersectsLogic()
  local receiverBounds = this:CalculateRelativeWidgetBounds(REF.Receiver.transform, REF["$transform"])
  
  local function func(ref, garbageGather)
    if DropState[ref["@dropState"]] == "NotOnDropping" then
      return
    end
    local boundsB = this:CalculateRelativeWidgetBounds(ref.Bounds.transform, REF["$transform"])
    if receiverBounds:Intersects(boundsB) then
      WU.SetActive(REF.EffectArrow, false)
      local cacheNode = fif(ref["@typeName"] == "Food", REF.DropsCache1.transform, REF.DropsCache2.transform)
      ref["$$OnDropEnd"](2, cacheNode)
    elseif ref["$transform"].localPosition.y < -(REF.DropsNode.transform.localPosition.y * 2) then
      table.insert(garbageGather, ref["$transform"])
      ref["$$OnDropEnd"](1)
    end
  end
  
  TraverseDrops(func)
end

function TraverseDrops(func)
  local garbageGather1 = {}
  local garbageGather2 = {}
  for i = 0, REF.DropsNode.transform.childCount - 1 do
    local ref = _ENV["$"](REF.DropsNode.transform:GetChild(i))
    local gather = fif(ref["@typeName"] == "Food", garbageGather1, garbageGather2)
    func(ref, gather)
  end
  for i = 1, #garbageGather1 do
    garbageGather1[i].parent = REF.DropsCache1.transform
    garbageGather1[i].transform.localPosition = CS.UnityEngine.Vector3.zero
  end
  for i = 1, #garbageGather2 do
    garbageGather2[i].parent = REF.DropsCache2.transform
    garbageGather2[i].transform.localPosition = CS.UnityEngine.Vector3.zero
  end
end

function GenDropSpecific()
  if m_isGameOver then
    return
  end
  local dropItem = m_timeBounsItem
  while true do
    if m_isGameOver or dropItem == nil then
      return
    end
    if not dropItem.dropped then
      if P.MinSpeed > P.MaxSpeed or P.DelayDropMinTime > P.DelayDropMaxTime then
        warning("\229\143\130\230\149\176\230\156\137\232\175\175", "\230\156\128\229\176\143\233\128\159\229\186\166\228\184\141\232\131\189\229\164\167\228\186\142\230\156\128\229\164\167\233\128\159\229\186\166 \239\188\129\239\188\129\239\188\129 \230\156\128\229\176\143\229\187\182\232\191\159\230\151\182\233\151\180\228\184\141\232\131\189\229\164\167\228\186\142\230\156\128\229\164\167\229\187\182\232\191\159\230\151\182\233\151\180 ")
        CO.yield_return(CS.UnityEngine.WaitForSeconds(2))
      else
        local x, line = GetProperXAxisVal()
        if x and REF.DropsCache2.transform.childCount > 0 then
          local widget = REF.DropsCache2.transform:GetChild(0)
          DropLogic(widget, dropItem, x, line)
          dropItem = nil
        else
          CO.yield_return()
        end
      end
    end
    if dropItem == nil then
      break
    end
  end
end

function DropLogic(widget, dropItem, x, line)
  dropItem.dropped = true
  local ref = _ENV["$"](widget)
  ref["$$SetData"](dropItem)
  widget.transform.parent = REF.DropsNode.transform
  widget.transform.localPosition = CS.UnityEngine.Vector3.zero
  U.Translate(widget.transform, x, 0, 0)
  m_dropLines[line] = widget
  this:DelayInvokeInSeconds(math.random(P.DelayDropMinTime, P.DelayDropMaxTime), function()
    if m_isGameOver or DropState[ref["@dropState"]] == "NotOnDropping" then
      return
    end
    local min = fif(dropItem.minSpeed == 0, P.MinSpeed, dropItem.minSpeed) + m_speedUp
    local max = fif(dropItem.maxSpeed == 0, P.MaxSpeed, dropItem.maxSpeed) + m_speedUp
    local waitForDrop = ref["$$OnDropStart"](min, max)
    if not waitForDrop then
      m_dropLines[line] = nil
    end
  end)
end

function GenDropFromCache()
  if m_isGameOver then
    return
  end
  local pool = {1, 1}
  local poolIndex = fif(math.random() < P.InGameDropChance, 2, 1)
  local dropsPool = m_drops[poolIndex]
  local dropItem = dropsPool[pool[poolIndex]]
  while true do
    if m_isGameOver or dropItem == nil then
      return
    end
    if not dropItem.dropped then
      if P.MinSpeed > P.MaxSpeed or P.DelayDropMinTime > P.DelayDropMaxTime then
        warning("\229\143\130\230\149\176\230\156\137\232\175\175", "\230\156\128\229\176\143\233\128\159\229\186\166\228\184\141\232\131\189\229\164\167\228\186\142\230\156\128\229\164\167\233\128\159\229\186\166 \239\188\129\239\188\129\239\188\129 \230\156\128\229\176\143\229\187\182\232\191\159\230\151\182\233\151\180\228\184\141\232\131\189\229\164\167\228\186\142\230\156\128\229\164\167\229\187\182\232\191\159\230\151\182\233\151\180 ")
        CO.yield_return(CS.UnityEngine.WaitForSeconds(2))
      else
        local x, line = GetProperXAxisVal()
        if x and REF["DropsCache" .. poolIndex].transform.childCount > 0 then
          local widget = REF["DropsCache" .. poolIndex].transform:GetChild(0)
          DropLogic(widget, dropItem, x, line)
          pool[poolIndex] = pool[poolIndex] + 1
          poolIndex = fif(math.random() < P.InGameDropChance, 2, 1)
          dropsPool = m_drops[poolIndex]
          dropItem = dropsPool[pool[poolIndex]]
        else
          CO.yield_return()
        end
      end
    end
    if dropItem == nil then
      break
    end
  end
end

function GetProperXAxisVal()
  for i = 1, m_lineCount do
    if m_dropLines[i] ~= nil then
      local ref = _ENV["$"](m_dropLines[i])
      if DropState[ref["@dropState"]] == "OnDropping" and (ref["@dropTime"] or 0) * ref["@speed"] > P.BetweenInterval then
        m_dropLines[i] = nil
      elseif DropState[ref["@dropState"]] == "NotOnDropping" then
        m_dropLines[i] = nil
      end
    end
  end
  local l = math.random(1, m_lineCount)
  if m_dropLines[l] then
    return
  end
  local result = l * P.ColWidth
  local limit = math.floor(P.ColWidth / 3)
  if 1 < l and l < m_lineCount then
    if m_dropLines[l - 1] == nil then
      result = result - math.random(1, limit)
    elseif m_dropLines[l + 1] == nil then
      result = result + math.random(1, limit)
    end
  elseif l == 1 then
    if m_dropLines[l + 1] == nil then
      result = result + math.random(1, limit)
    end
  elseif l == m_lineCount and m_dropLines[l - 1] == nil then
    result = result - math.random(1, limit)
  end
  return result, l
end

function OnScoreChange(receiveItems)
  if receiveItems == nil or table.empty(receiveItems) then
    return
  end
  table.append(m_rewardRes, receiveItems)
  GoodThingCatchedEffect()
end

function OnTimeChange()
  m_totalTime = m_totalTime + P.TimeIncrease
  REF.TimeIncrease.UILabel.text = "+" .. P.TimeIncrease
  WU.SetActive(REF.TimeIncrease, true)
  REF.GamePlay.UIPlayTween:Play(true)
  if m_timeChange then
    this:StopCoroutine(m_timeChange)
  end
  local duration = REF.TimeIncrease.TweenAlpha.duration
  m_timeChange = this:DelayInvokeInSeconds(duration, function()
    WU.SetActive(REF.TimeIncrease, false)
  end)
  GoodThingCatchedEffect()
end

function OnBounsTimeChange()
  m_bounsTime = m_bounsTime + P.BounsTimeIncrease
  m_speedUp = P.BounsTimeSpeedUp
  m_savedInGameDropChance = P.InGameDropChance
  P.InGameDropChance = 0
  WU.SetActive(REF.BounsTime, true)
  WU.SetActive(REF.EffectBG, true)
  REF.EffectBG.EffectGenerator:Play()
  REF.BounsTime.EffectGenerator:Play()
  if m_bounsTimeChange then
    this:StopCoroutine(m_bounsTimeChange)
  end
  m_bounsTimeChange = this:DelayInvokeInSeconds(P.BounsTimeIncrease, function()
    WU.SetActive(REF.EffectBG, false)
    WU.SetActive(REF.BounsTime, false)
    m_speedUp = 0
    P.InGameDropChance = m_savedInGameDropChance
  end)
  GoodThingCatchedEffect()
  
  local function func(ref, garbageGather)
    if ref["@typeName"] == "Bomb" then
      ref["$$OnDropEnd"](3, REF.DropsCache2.transform)
    end
  end
  
  TraverseDrops(func)
end

function OnMagnet()
  local magnetItems = {}
  
  local function func(ref, garbageGather)
    if DropState[ref["@dropState"]] == "OnDropping" then
      if ref["@typeName"] == "Food" then
        ref["$$MagnetMovement"](REF.ReceiverNode.transform)
        table.insert(magnetItems, {
          type = ref["@type"],
          id = ref["@typeId"],
          count = 1
        })
      elseif ref["@typeName"] == "Bomb" then
        ref["$$OnDropEnd"](3, REF.DropsCache2.transform)
      end
    end
  end
  
  TraverseDrops(func)
  OnScoreChange(magnetItems)
end

function RefreshTimeCountDown()
  local min = m_totalTime // 60
  local sec = math.floor(m_totalTime % 60)
  REF.TimeCountDown.UIHtmlLabel.text = string.format("%02d:%02d", min, sec)
  local isHot = m_totalTime <= P.CountDownRedThresh
  REF.TimeCountDown.UIHtmlLabel.color = fif(isHot, CS.NGUIMath.HexToColor(4278190335), CS.NGUIMath.HexToColor(4294967295))
  REF.TimeCountDown.TweenScale.enabled = isHot
  min = m_bounsTime // 60
  sec = math.floor(m_bounsTime % 60)
end

function OverGame()
  m_totalTime = nil
  m_isGameOver = true
  this:BroadcastGameEvent("NavigationDisplay", true)
  
  local function func(ref, garbageGather)
    table.insert(garbageGather, ref["$transform"])
    ref["$$OnDropEnd"](1)
  end
  
  TraverseDrops(func)
  WU.SetActive(REF.TimeCountDown, false)
  local gathered = {}
  for i = 1, #m_rewardRes do
    local reward = m_rewardRes[i]
    local _, find = table.find(gathered, function(_, v)
      return v.type == reward.type and v.id == reward.id
    end)
    local countInc = fif(reward.type == PB.enum.ResourceType.ResPlayerGold, P.EachMoneyPrice, 1)
    if not find then
      table.insert(gathered, {
        type = reward.type,
        id = reward.id,
        count = countInc
      })
    else
      find.count = find.count + countInc
    end
  end
  if m_isLocal then
    m_rewardRes = gathered
    local row = math.ceil(#m_rewardRes / #REF.LineGrid)
    LU.Set(REF.WrapContent, row)
    m_isReward = true
    DisplayChange()
  else
    local gameReceiveFood = PB.get("GameReceiveFood", m_catchItemMinigame.randomIndex)
    if gameReceiveFood == nil then
      warning("GameReceiveFood", "GameReceiveFood can't find id " .. tostring(resp.randomIndex))
      return
    end
    for i = 1, #gameReceiveFood.drops do
      local drop = gameReceiveFood.drops[i]
      local _, find = table.find(gathered, function(_, v)
        return v.type == drop.type and v.id == drop.typeId
      end)
      if find then
        find.count = math.min(find.count, drop.maxCount)
      end
    end
    this:GameRequest("fci/catch-item-minigame/"):Post({gameResult = gathered}, function(result)
      RU.SetRedMark("Welfare/ChineseNewYear/MiniGame", false)
      DBH.ResChange(result.resChange)
      m_rewardRes = result.resChange
      local row = math.ceil(#m_rewardRes / #REF.LineGrid)
      LU.Set(REF.WrapContent, row)
      m_isReward = true
      DisplayChange()
    end)
  end
end

function DisplayChange()
  WU.SetActive(REF.TimeCountDown, true)
  WU.SetActive(REF.Reward, m_isReward)
  WU.SetActive(REF.Prepare, m_isGameOver and not m_isReward)
  WU.SetActive(REF.BoxPanel, not m_isGameOver)
  WU.SetActive(REF.GamePlay, not m_isGameOver)
end

function UpdateSlot(widget, data)
  WU.ToggleRendering(widget["$"], data ~= nil)
  if data then
    if m_isLocal then
      widget["$$SetData"](data.type, data.id, data.count)
    else
      widget["$$SetData"](data.baseRes.type, data.baseRes.id, data.baseRes.countDelta)
    end
  end
end

function GoodThingCatchedEffect()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Get_Food", 1.0)
  REF.EffectScore.gameObject:SetActive(false)
  REF.EffectScore.gameObject:SetActive(true)
  local duration = REF.EffectScore.EffectGenerator.Duration
  if m_scoreEffect then
    this:StopCoroutine(m_scoreEffect)
  end
  m_scoreEffect = this:DelayInvokeInSeconds(duration, function()
    REF.EffectScore.gameObject:SetActive(false)
  end)
end

function OnBomb()
  local function func(ref, garbageGather)
    if DropState[ref["@dropState"]] == "OnDropping" then
      local cacheNode = fif(ref["@typeName"] == "Food", REF.DropsCache1.transform, REF.DropsCache2.transform)
      
      ref["$$OnDropEnd"](3, cacheNode)
    end
  end
  
  TraverseDrops(func)
end
