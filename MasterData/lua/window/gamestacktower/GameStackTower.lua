local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local U = require("Common/Util")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local Vector3 = CS.UnityEngine.Vector3
local m_activityInfo
local Enum_DropResult = {
  NoCollision = 1,
  CollideButDrop = 2,
  NormalPlace = 3,
  PerfectPlace = 4
}
local m_history, m_rewards
local GAME = {
  totalTime = 60,
  perfectLimit = 30,
  perfectRewardTime = 2,
  failDeductTime = 2,
  bonusTime = 6
}
local CACHE = {
  newCakeRef = nil,
  bottomCakeRef = nil,
  dropRefCount = nil,
  towerRefCount = nil,
  bgHeight = nil,
  gameAreaHeight = nil,
  bgInitPos = Vector3(0, -540, 0),
  plateInitPos = Vector3(0, -433, 0),
  disappearPosY = nil
}
local PENDULUM = {
  rotateR = 5000,
  initAngle = -6,
  rotateGravity = 35,
  rotateAxis = nil,
  rotateCenter = nil,
  rotateAngleV = nil,
  rotateWorldR = nil,
  fixLowest = 300
}
local CAKE = {
  gravity = 1800,
  productionCD = 1,
  collideRotateSpeed = 180,
  shakeCurR = 0,
  shakeT = 2,
  towerHeightest = -100,
  towerMoveSpeed = 400,
  shakeCoe = 20,
  shakeBegin = 4
}
local STATE = {
  hasNewCake = false,
  onGame = false,
  rotateResult = nil,
  productionWaitDuringTime = nil,
  moveTowerDuringTime = nil,
  bonusDuringTime = nil,
  remainTime = nil,
  towerShakeDuringTime = nil,
  towerCakeCount = nil,
  placeCakeCount = nil
}

function SetupWindow()
  WU.BindButtonEvent(REF.BtnGameStart, OnGameStart)
  WU.BindButtonEvent(REF.GameArea, OnDropClick)
  WU.SetActive(REF.NodeEdit, false)
end

function InitWindow()
  local acs = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.MaidCafe_MiniGame)
  m_activityInfo = acs and acs[1]
  WU.SetActive(REF.NodeHistory, true)
  WU.SetActive(REF.NodeRight, true)
  WU.SetActive(REF.GameArea, false)
  WU.SetActive(REF.NodeGameOver, false)
  WU.SetActive(REF.NodeRight, false)
  REF.LabelHistoryHighestScore.UILabel.text = ""
  STATE.onGame = false
  local nowDay = CS.GameTime.serverNow.Day
  m_history = this:GetData("fci/maidcafe/minigame/")
  if m_history == nil or m_history.day ~= nowDay then
    this:GameRequest("fci/maidcafe/minigame/"):Get(function(res)
      m_history = res
      m_history.day = nowDay
      UpdateStaticUI()
    end)
  else
    UpdateStaticUI()
  end
end

function UninitWindow()
  REF.BgBottom.transform.localPosition = CACHE.bgInitPos
  REF.SpritePlate.transform.localPosition = CACHE.plateInitPos
  WU.SetActive(REF.SpritePlate, true)
  WU.SetActive(REF.BgBottom, true)
end

function UpdateWindow(delta)
  if not STATE.onGame then
    return
  end
  if STATE.productionWaitDuringTime then
    STATE.productionWaitDuringTime = STATE.productionWaitDuringTime + delta
    if STATE.productionWaitDuringTime >= CAKE.productionCD then
      STATE.productionWaitDuringTime = nil
      RandomInitACake()
    end
  end
  DoSakuMove(delta)
  if STATE.towerShakeDuringTime then
    DoTowerHorizantalMove(delta)
  end
  if STATE.rotateResult then
    DoCakeRotate(delta)
  end
  if STATE.moveTowerDuringTime then
    DoTowerMove(delta)
  end
  if STATE.bonusDuringTime then
    DoBonusProgressChange(delta)
  end
  for i = 0, CACHE.dropRefCount - 1 do
    local ref = REF.DropCakes[i]
    if ref["$$IsBusy"]() then
      DoCakeDrop(ref, ref["$$GetDropInfo"](), delta)
    end
  end
  STATE.remainTime = STATE.remainTime - delta
  DoTimeUpdate()
end

function OnGameStart()
  if m_history == nil then
    return
  end
  if m_activityInfo == nil then
    return
  end
  local status = ACU.GetStatus(m_activityInfo)
  if status == PB.enum.ActivityStatus.Close or status == PB.enum.ActivityStatus.Finished then
    WU.ShowHintText(WU.GetString("Window_Activity_Close"))
    return
  end
  InitGameInfo()
  ResetGameDataAndUI()
end

function OnDropClick()
  if not STATE.hasNewCake or not STATE.onGame then
    return
  end
  local outerPos = REF.NodeRotation.transform.localPosition
  local innerPos = REF.ContentSaku.transform.localPosition
  local newPos = innerPos + outerPos
  local newAngle = REF.ContentSaku.transform.localEulerAngles
  local _, dropCakeRef = GetADropCake()
  dropCakeRef["$$InitCake"]("Copy", CACHE.newCakeRef["@info"])
  dropCakeRef["$transform"].localEulerAngles = newAngle
  WU.SetActive(dropCakeRef["$gameObject"], true)
  WU.SetActive(CACHE.newCakeRef, false)
  STATE.productionWaitDuringTime = 0
  STATE.hasNewCake = false
  local angle = dropCakeRef["$transform"].localEulerAngles.z
  local corners = dropCakeRef["$$GetCornerPoints"]()
  local info = {
    duringTime = 0,
    beginPos = newPos,
    corners = {
      [1] = GetRotateNewPos(corners[1], angle),
      [2] = GetRotateNewPos(corners[2], angle),
      [3] = GetRotateNewPos(corners[3], angle),
      [4] = GetRotateNewPos(corners[4], angle)
    }
  }
  info.isLeftLower = info.corners[1].y < info.corners[4].y
  info.lowestPoint = fif(info.isLeftLower, info.corners[1], info.corners[4]) + newPos
  dropCakeRef["$$SetDropInfo"](info)
end

function UpdateStaticUI()
  table.sort(m_history.floorRewardInfo, function(a, b)
    return a.floor < b.floor
  end)
  local rankCount = #m_history.floorRewardInfo
  for i = 1, rankCount do
    local ref = _ENV["$"](REF["NodeReward" .. i])
    local data = m_history.floorRewardInfo[rankCount - i + 1]
    ref.LabelRank.UILabel.text = WU.GetString("WindowTower_FloorNumber", data.floor) .. WU.GetString("Window_Award")
    WU.SetActive(ref.SpriteGot, data.got)
    for j = 0, #ref.Rewards - 1 do
      local item = data.reward[j + 1]
      if item then
        if item.type == PB.enum.ResourceType.ResActor then
          ref.Rewards[j]["$$SetActorCustom"](item)
        else
          ref.Rewards[j]["$$SetData"](item.type, item.id, item.count or item.countDelta)
        end
        ref.Rewards[j]["$$SetOwnerBox"](item.ownerBoxId)
        ref.Rewards[j]["$$SetClickCallback"](function()
          WU.ShowResourceDetail(item.type, item.id)
        end)
      end
      WU.SetActive(ref.Rewards[j]["$gameObject"], item ~= nil)
    end
  end
  REF.LabelHistoryHighestScore.UILabel.text = m_history.lastFloor or 0
  WU.SetActive(REF.NodeRight, true)
end

function UpdateGameOverUI()
  this:BroadcastGameEvent("NavigationDisplay", true)
  local nowDay = CS.GameTime.serverNow.Day
  local doRequest = m_history.day ~= nowDay
  doRequest = doRequest or STATE.placeCakeCount > m_history.lastFloor
  if not doRequest then
    for i = 1, #m_history.floorRewardInfo do
      local rewardInfo = m_history.floorRewardInfo[i]
      if not rewardInfo.got and STATE.placeCakeCount >= rewardInfo.floor then
        doRequest = true
        break
      end
    end
  end
  REF.LabelCurrentScore.UILabel.text = STATE.placeCakeCount
  WU.ToggleRendering(REF.ListRewards, false)
  WU.SetActive(REF.GameArea, false)
  WU.SetActive(REF.NodeGameOver, true)
  WU.SetActive(REF.NodeRight, true)
  if doRequest then
    this:GameRequest("fci/maidcafe/minigame/"):Post({
      floor = STATE.placeCakeCount
    }, function(res)
      m_history.lastFloor = res.lastFloor
      for i = 1, #m_history.floorRewardInfo do
        if m_history.floorRewardInfo[i].floor <= STATE.placeCakeCount then
          m_history.floorRewardInfo[i].got = true
        end
      end
      local rewardCount = 0
      if res.floorRewardGotInfo then
        m_rewards = _ENV["!"]({})
        for i = 1, #res.floorRewardGotInfo do
          local getInfo = res.floorRewardGotInfo[i]
          DBH.ResChange(getInfo.resChange)
          local rewards = GetItemList(getInfo.resChange)
          table.insert(m_rewards, {
            floor = getInfo.floor,
            rewards = rewards
          })
        end
        rewardCount = #m_rewards
      end
      UpdateGetRewards(rewardCount)
      UpdateStaticUI()
    end)
  else
    UpdateGetRewards(0)
  end
end

function UpdateGetRewards(count)
  REF.NodeScore.transform.localPosition = fif(count == 0, Vector3(0, -200, 0), Vector3.zero)
  if count ~= 0 then
    for i = 0, #REF.GridReward - 1 do
      local ref = REF.GridReward[i]
      local rankReward = m_rewards[i + 1]
      if rankReward == nil then
        WU.SetActive(ref["$gameObject"], false)
      else
        WU.SetActive(ref["$gameObject"], true)
        ref.LabelRank.UILabel.text = WU.GetString("WindowTower_FloorNumber", rankReward.floor)
        local item = rankReward.rewards[1]
        if item.type == PB.enum.ResourceType.ResActor then
          ref.WidgetIconSlot["$SetActorCustom"](item)
        else
          ref.WidgetIconSlot["$SetData"](item.type, item.id, item.countDelta or item.count)
        end
        ref.WidgetIconSlot["$SetOwnerBox"](item.ownerBoxId)
        ref.WidgetIconSlot["$SetClickCallback"](function()
          WU.ShowResourceDetail(item.type, item.id)
        end)
      end
    end
    REF.GridReward.UIGrid:Reposition()
  end
  WU.ToggleRendering(REF.ListRewards, count ~= 0)
end

function InitGameInfo()
  if CACHE.gameAreaHeight then
    return
  end
  CACHE.gameAreaHeight = REF.GameArea.UIWidget.height
  CACHE.dropRefCount = #REF.DropCakes
  CACHE.towerRefCount = #REF.TowerCakes
  CACHE.bgHeight = REF.Bg1.UIWidget.height
  CACHE.newCakeRef = _ENV["$"](REF.NodeSaku).WidgetCake
  CACHE.bottomCakeRef = REF.TowerCakes[CACHE.towerRefCount - 1]
  CACHE.disappearPosY = -0.5 * CACHE.gameAreaHeight - 150
end

function ResetGameDataAndUI()
  STATE.hasNewCake = false
  STATE.productionWaitDuringTime = nil
  STATE.rotateResult = nil
  STATE.towerShakeDuringTime = nil
  STATE.moveTowerDuringTime = nil
  STATE.towerCakeCount = 0
  STATE.placeCakeCount = 0
  CAKE.shakeCurR = 0
  REF.BgBottom.transform.localPosition = CACHE.bgInitPos
  REF.SpritePlate.transform.localPosition = CACHE.plateInitPos
  REF.TowerCakes.transform.localPosition = Vector3.zero
  WU.SetActive(REF.BgBottom, true)
  WU.SetActive(REF.LabelTimeChange, false)
  STATE.remainTime = GAME.totalTime
  RenderTimeContent()
  REF.LabelCount.UILabel.text = 0
  WU.SetActive(REF.SpritePlate, true)
  for i = 0, CACHE.dropRefCount - 1 do
    local ref = REF.DropCakes[i]
    WU.SetActive(ref["$gameObject"], false)
    ref["$$SetEmpty"]()
  end
  for i = 0, CACHE.towerRefCount - 1 do
    WU.SetActive(REF.TowerCakes[i]["$gameObject"], false)
  end
  REF.ContentSaku.transform.localPosition = Vector3(0, -PENDULUM.rotateR, 0)
  REF.NodeRotation.transform.localPosition = Vector3(0, PENDULUM.rotateR + PENDULUM.fixLowest)
  PENDULUM.rotateCenter = REF.NodeRotation.transform.position
  PENDULUM.rotateWorldR = Vector3.Distance(PENDULUM.rotateCenter, REF.ContentSaku.transform.position)
  REF.ContentSaku.transform.localEulerAngles = Vector3.zero
  local t = REF.ContentSaku.transform.position + Vector3.left
  PENDULUM.rotateAxis = Vector3.Cross(t - PENDULUM.rotateCenter, Vector3.down)
  REF.ContentSaku.transform:RotateAround(PENDULUM.rotateCenter, PENDULUM.rotateAxis, PENDULUM.initAngle)
  PENDULUM.rotateAngleV = 0
  WU.SetActive(REF.NodeHistory, false)
  WU.SetActive(REF.NodeGameOver, false)
  WU.SetActive(REF.NodeProgress, false)
  WU.SetActive(REF.NodeRight, false)
  WU.SetActive(REF.GameArea, true)
  RandomInitACake()
  this:BroadcastGameEvent("NavigationDisplay", false)
  STATE.onGame = true
end

function DoCakeDrop(dropRef, info, delta)
  if info.onEffect then
    return
  end
  if info.waitToDie then
    dropRef["$$CollideEffect"]()
    info.onEffect = true
    info.waitToDie = false
    this:DelayInvokeInSeconds(1, function()
      WU.SetActive(dropRef["$gameObject"], false)
      dropRef["$$SetEmpty"]()
    end)
    STATE.remainTime = STATE.remainTime - GAME.failDeductTime
    DoTimeUpdate(false)
    return
  end
  info.duringTime = info.duringTime + delta
  local dropHeight = 0.5 * CAKE.gravity * info.duringTime * info.duringTime
  local dropNewPos = info.beginPos + Vector3(0, -dropHeight, 0)
  local lowestPointY = info.lowestPoint.y - dropHeight
  local topCakeTopY
  if 1 <= STATE.towerCakeCount then
    local topCakeRef = REF.TowerCakes[GetTopCakeIndexInTower()]
    local height = topCakeRef["$$GetCakeInfo"]().height
    topCakeTopY = topCakeRef["$transform"].localPosition.y + 0.5 * height
  else
    local sprite = REF.SpritePlate.UISprite
    topCakeTopY = REF.SpritePlate.transform.localPosition.y + 0.5 * sprite.height
  end
  if lowestPointY > topCakeTopY then
    dropRef["$transform"].localPosition = dropNewPos
  else
    local result = CaculateCollideResult(dropRef, info, dropHeight)
    if result.collideResult == Enum_DropResult.CollideButDrop then
      dropRef["$transform"].localPosition = dropNewPos
      info.waitToDie = true
    elseif result.collideResult == Enum_DropResult.NoCollision then
      if dropNewPos.y < CACHE.disappearPosY then
        WU.SetActive(dropRef["$gameObject"], false)
        dropRef["$$SetEmpty"]()
        STATE.remainTime = STATE.remainTime - GAME.failDeductTime
        DoTimeUpdate(false)
      else
        dropRef["$transform"].localPosition = dropNewPos
      end
    else
      local index = GetTopCakeIndexInTower() - 1
      local newRef = REF.TowerCakes[index]
      newRef["$$InitCake"]("Copy", dropRef["$$GetCakeInfo"]())
      WU.SetActive(newRef["$gameObject"], true)
      newRef["$transform"].localEulerAngles = dropRef["$transform"].localEulerAngles
      local relativeX = 0
      if STATE.towerShakeDuringTime then
        relativeX = REF.TowerCakes.transform.localPosition.x
      end
      newRef["$transform"].localPosition = dropNewPos + Vector3(-relativeX, result.changeHeight, 0)
      WU.SetActive(dropRef["$gameObject"], false)
      dropRef["$$SetEmpty"]()
      STATE.towerCakeCount = STATE.towerCakeCount + 1
      STATE.rotateResult = result
    end
  end
end

function DoCakeRotate(delta)
  local cakeRef = REF.TowerCakes[GetTopCakeIndexInTower()]
  local info = STATE.rotateResult
  local wCollidePoint = REF.TowerCakes.transform:TransformPoint(info.collidePoint)
  local isLeft = info.isLeftLower
  local corners = cakeRef["$$GetCornerPoints"]()
  if info.fixAngle == nil then
    local p = fif(isLeft, corners[4], corners[1])
    local angle = cakeRef["$transform"].localEulerAngles.z
    local point = GetRotateNewPos(p, angle) + cakeRef["$transform"].localPosition
    local tanAlpha = 1.0 * (point.y - info.collidePoint.y) / (point.x - info.collidePoint.x)
    info.fixAngle = math.deg(math.atan(tanAlpha))
  end
  local axis = fif(isLeft, Vector3.back, Vector3.forward)
  local angleChange = CAKE.collideRotateSpeed * delta
  if angleChange < info.fixAngle then
    info.fixAngle = info.fixAngle - angleChange
    cakeRef["$transform"]:RotateAround(wCollidePoint, Vector3.back, angleChange)
  else
    angleChange = info.fixAngle
    cakeRef["$transform"]:RotateAround(wCollidePoint, Vector3.back, angleChange)
    info.fixAngle = 0
    STATE.rotateResult = nil
    DoCakePlace(cakeRef, info)
  end
end

function DoCakePlace(cakeRef, info)
  if STATE.bonusDuringTime then
    STATE.remainTime = STATE.remainTime + GAME.perfectRewardTime
    DoTimeUpdate(true)
  end
  local cakePos = cakeRef["$transform"].localPosition
  local height = cakeRef["$$GetCakeInfo"]().height
  if info.collideResult == Enum_DropResult.PerfectPlace then
    if STATE.bonusDuringTime == nil then
      REF.NodePerfect.transform.localPosition = Vector3(cakePos.x, cakePos.y + height * 0.5, 0)
      REF.EffectPerfect.EffectGenerator.m_EffectName = "MaidCafeGame_text_03"
      REF.EffectPerfect.EffectGenerator:Reset()
      REF.EffectPerfect.EffectGenerator:Play()
      STATE.bonusDuringTime = 0
      REF.NodeProgress.UIProgressBar.value = 1
      REF.LabelBonusRemainTime.UILabel.text = GAME.bonusTime
      WU.SetActive(REF.EffectTextAppear, true)
      WU.SetActive(REF.EffectTextDisappear, false)
      WU.SetActive(REF.NodeProgress, true)
    else
      REF.NodePerfect.transform.localPosition = Vector3(cakePos.x, cakePos.y + height * 0.5, 0)
      REF.EffectPerfect.EffectGenerator.m_EffectName = "MaidCafeGame_text_04"
      REF.EffectPerfect.EffectGenerator:Reset()
      REF.EffectPerfect.EffectGenerator:Play()
    end
  end
  local height = cakePos.y + cakeRef["$$GetCakeInfo"]().height * 0.5
  if height > CAKE.towerHeightest then
    STATE.moveTowerDuringTime = 0
  end
  STATE.placeCakeCount = STATE.placeCakeCount + 1
  REF.LabelCount.UILabel.text = STATE.placeCakeCount
  CAKE.shakeCurR = (CAKE.shakeCurR * (STATE.placeCakeCount - 1) + cakePos.x) * 1.0 / STATE.placeCakeCount
  if STATE.towerShakeDuringTime == nil and REF.SpritePlate.gameObject.activeSelf ~= true then
    STATE.towerShakeDuringTime = 0
  end
end

function DoTowerMove(delta)
  local topIndex = GetTopCakeIndexInTower()
  local topCakeRef = REF.TowerCakes[topIndex]
  local pos = topCakeRef["$transform"].localPosition
  local topCakeHeight = topCakeRef["$$GetCakeInfo"]().height
  local needChangeHeight = pos.y + topCakeHeight * 0.5 - CAKE.towerHeightest
  local changeY
  if needChangeHeight < delta * CAKE.towerMoveSpeed then
    changeY = -needChangeHeight
    STATE.moveTowerDuringTime = nil
  else
    changeY = -delta * CAKE.towerMoveSpeed
  end
  if REF.BgBottom.gameObject.activeSelf then
    U.Translate(REF.BgBottom.transform, 0, changeY, 0)
    if REF.BgBottom.transform.localPosition.y < -0.5 * CACHE.gameAreaHeight - REF.BgBottom.UITexture.height then
      WU.SetActive(REF.BgBottom, false)
    end
  end
  if REF.SpritePlate.gameObject.activeSelf then
    U.Translate(REF.SpritePlate.transform, 0, changeY, 0)
    if REF.SpritePlate.transform.localPosition.y < -0.5 * CACHE.gameAreaHeight - REF.BgBottom.UITexture.height then
      WU.SetActive(REF.SpritePlate, false)
    end
  end
  local bg1Pos = REF.Bg1.transform.localPosition
  local bg2Pos = REF.Bg2.transform.localPosition
  local bg1Height = bg1Pos.y + changeY
  local bg2Height = bg2Pos.y + changeY
  if bg1Height < bg2Height then
    if bg1Height < -CACHE.bgHeight then
      bg1Height = bg1Height + 2 * CACHE.bgHeight
    end
  elseif bg2Height < -CACHE.bgHeight then
    bg2Height = bg2Height + 2 * CACHE.bgHeight
  end
  REF.Bg1.transform.localPosition = Vector3(0, bg1Height, 0)
  REF.Bg2.transform.localPosition = Vector3(0, bg2Height, 0)
  for i = topIndex, CACHE.towerRefCount - 1 do
    local cakeRef = REF.TowerCakes[i]
    U.Translate(cakeRef["$transform"], 0, changeY, 0)
    if i == topIndex then
      local pos = cakeRef["$transform"].localPosition
      local height = cakeRef["$$GetCakeInfo"]().height
      REF.NodePerfect.transform.localPosition = Vector3(pos.x, pos.y + height * 0.5, 0)
    end
  end
  if STATE.moveTowerDuringTime == nil then
    local bottomPos = CACHE.bottomCakeRef["$transform"].localPosition
    if bottomPos.y < CACHE.disappearPosY then
      for i = CACHE.towerRefCount - 1, topIndex + 1, -1 do
        local cakeRef = REF.TowerCakes[i]
        local upCakeRef = REF.TowerCakes[i - 1]
        local pos = upCakeRef["$transform"].localPosition
        cakeRef["$transform"].localPosition = pos
        cakeRef["$$InitCake"]("Copy", upCakeRef["$$GetCakeInfo"]())
        if i == topIndex + 1 then
          local height = cakeRef["$$GetCakeInfo"]().height
          REF.NodePerfect.transform.localPosition = Vector3(pos.x, pos.y + height * 0.5, 0)
        end
      end
      WU.SetActive(topCakeRef["$gameObject"], false)
      STATE.towerCakeCount = STATE.towerCakeCount - 1
    end
  end
end

function DoTowerHorizantalMove(delta)
  local newT = STATE.towerShakeDuringTime + delta
  if newT > CAKE.shakeT then
    newT = newT - CAKE.shakeT
  end
  STATE.towerShakeDuringTime = newT
  local coe = math.sin(2.0 * math.pi * newT / CAKE.shakeT)
  local towerCoe = 0
  if 0 < STATE.placeCakeCount - CAKE.shakeBegin + 2 then
    towerCoe = CAKE.shakeCoe * math.log(STATE.placeCakeCount - CAKE.shakeBegin + 2)
  end
  local nowShakeSpan = (math.abs(CAKE.shakeCurR) + fif(0 <= towerCoe, towerCoe, 0)) * coe
  REF.TowerCakes.transform.localPosition = Vector3(nowShakeSpan, 0, 0)
end

function DoSakuMove(t)
  local pos = REF.ContentSaku.transform.position
  local l = math.abs(pos.x - PENDULUM.rotateCenter.x)
  local axis = Vector3.Cross(pos - PENDULUM.rotateCenter, Vector3.down)
  if Vector3.Dot(axis, PENDULUM.rotateAxis) < 0 then
    l = -l
  end
  local cosAlpha = l * 1.0 / PENDULUM.rotateWorldR
  local a = cosAlpha * PENDULUM.rotateGravity / PENDULUM.rotateWorldR
  PENDULUM.rotateAngleV = PENDULUM.rotateAngleV + a * t
  local thelta = PENDULUM.rotateAngleV * t * 180 / math.pi
  REF.ContentSaku.transform:RotateAround(PENDULUM.rotateCenter, PENDULUM.rotateAxis, thelta)
end

function DoTimeUpdate(isAdd)
  if STATE.onGame == false then
    return
  end
  if isAdd ~= nil then
    if isAdd == true then
      REF.LabelTimeChange.UILabel.text = "+" .. GAME.perfectRewardTime
    else
      REF.LabelTimeChange.UILabel.text = "-" .. GAME.failDeductTime
    end
    WU.SetActive(REF.LabelTimeChange, true)
    REF.LabelTimeChange.TweenPosition:ResetToBeginning()
    REF.LabelTimeChange.TweenPosition:PlayForward()
    this:DelayInvokeInSeconds(1, function()
      WU.SetActive(REF.LabelTimeChange, false)
    end)
  end
  if STATE.remainTime <= 0 then
    RenderTimeContent(true)
    STATE.onGame = false
    UpdateGameOverUI()
  else
    RenderTimeContent()
  end
end

function DoBonusProgressChange(delta)
  STATE.bonusDuringTime = STATE.bonusDuringTime + delta
  if STATE.bonusDuringTime > GAME.bonusTime then
    STATE.bonusDuringTime = GAME.bonusTime
  end
  local value = 1 - 1.0 * STATE.bonusDuringTime / GAME.bonusTime
  REF.NodeProgress.UIProgressBar.value = value
  REF.LabelBonusRemainTime.UILabel.text = math.floor((GAME.bonusTime - STATE.bonusDuringTime) * 10) / 10.0
  if STATE.bonusDuringTime == GAME.bonusTime then
    STATE.bonusDuringTime = nil
    WU.SetActive(REF.EffectTextAppear, false)
    WU.SetActive(REF.EffectTextDisappear, true)
    this:DelayInvokeInSeconds(0.2, function()
      WU.SetActive(REF.NodeProgress, false)
    end)
  end
end

function RenderTimeContent(isEnd)
  if isEnd then
    REF.LabelTime.UILabel.text = "00:00"
  else
    local time = math.ceil(STATE.remainTime)
    local min = time // 60
    local sec = math.floor(time % 60)
    REF.LabelTime.UILabel.text = string.format("%02d:%02d", min, sec)
  end
end

function CaculateCollideResult(cakeRef, info, dropHeight)
  local relativeX = 0
  local topPos, corners
  if STATE.towerCakeCount >= 1 then
    local topCakeRef = REF.TowerCakes[GetTopCakeIndexInTower()]
    topPos = topCakeRef["$transform"].localPosition
    corners = topCakeRef["$$GetCornerPoints"]()
    if STATE.towerShakeDuringTime ~= nil then
      relativeX = REF.TowerCakes.transform.localPosition.x
    end
  end
  if topPos == nil then
    local sprite = REF.SpritePlate.UISprite
    local platePos = REF.SpritePlate.transform.localPosition
    local x = sprite.width * 0.5
    local y = sprite.height * 0.5
    topPos = Vector3(platePos.x, platePos.y, 0)
    corners = {
      [1] = Vector3(-x, -y, 0),
      [2] = Vector3(-x, y, 0),
      [3] = Vector3(x, y, 0),
      [4] = Vector3(x, -y, 0)
    }
  end
  local topRealPos = topPos
  local pLeftB = topRealPos + corners[1]
  local pLeftT = topRealPos + corners[2]
  local dCenter = info.beginPos + Vector3(-relativeX, -dropHeight, 0)
  local dLeftT = dCenter + info.corners[2]
  local dRightT = dCenter + info.corners[3]
  local dHighestY = fif(info.isLeftLower, dRightT.y, dLeftT.y)
  local dLowestY = info.lowestPoint.y - dropHeight
  local isTopCakeRange = IsOverlap(dHighestY, dLowestY, pLeftT.y, pLeftB.y)
  local result = {}
  result.collideResult = Enum_DropResult.NoCollision
  local halfWidth = cakeRef["$$GetCakeInfo"]().width * 0.5
  if isTopCakeRange then
    result = HasCollision(topRealPos, corners, dCenter, info.corners, halfWidth, true)
    if result.collideResult ~= Enum_DropResult.NoCollision then
      return result
    end
  end
  if STATE.towerCakeCount >= 1 then
    for i = GetTopCakeIndexInTower(), CACHE.towerRefCount - 1 do
      local cakeRef = REF.TowerCakes[i]
      local pos = cakeRef["$transform"].localPosition
      local corners = cakeRef["$$GetCornerPoints"]()
      halfWidth = cakeRef["$$GetCakeInfo"]().width * 0.5
      result = HasCollision(pos, corners, dCenter, info.corners, halfWidth)
      if result.collideResult ~= Enum_DropResult.NoCollision then
        return result
      end
    end
  end
  return result
end

function RandomInitACake()
  local oldInfo = CACHE.newCakeRef["@info"] or {}
  CACHE.newCakeRef["@info"] = CACHE.newCakeRef["$InitCake"]("Create", oldInfo.kind)
  WU.SetActive(CACHE.newCakeRef, true)
  CACHE.newCakeRef["$AppearEffect"]()
  STATE.hasNewCake = true
end

function GetADropCake(pos, parent)
  for i = 0, CACHE.dropRefCount - 1 do
    local ref = REF.DropCakes[i]
    if not ref["$$IsBusy"]() then
      return i, ref
    end
  end
end

function GetTopCakeIndexInTower()
  return CACHE.towerRefCount - STATE.towerCakeCount
end

function GetRotateNewPos(oldPos, angle)
  local x = oldPos.x
  local y = oldPos.y
  local rad = math.rad(angle)
  local x0 = x * math.cos(rad) - y * math.sin(rad)
  local y0 = x * math.sin(rad) + y * math.cos(rad)
  return Vector3(x0, y0, 0)
end

function GetItemList(resChange)
  local rewards = IU.FlatInboxItems(resChange)
  local items = _ENV["!"]({})
  local actors = _ENV["!"]({})
  for _, reward in pairs(rewards) do
    if reward.baseRes then
      if reward.baseRes.countDelta > 0 and reward.baseRes.param == PB.enum.ResourceParamType.None then
        local type = reward.baseRes.type
        if type ~= PB.enum.ResourceType.ResMonthCardDays and type ~= PB.enum.ResourceType.ResDelayReward then
          table.insert(items, {
            type = reward.baseRes.type,
            id = reward.baseRes.id,
            count = reward.baseRes.count,
            countDelta = reward.baseRes.countDelta,
            ownerBoxId = reward.ownerBoxId
          })
        end
      end
    elseif reward.equip then
      if 0 < reward.equip.countDelta then
        table.insert(items, {
          type = PB.enum.ResourceType.ResEquip,
          id = reward.equip.id,
          count = 1,
          ownerBoxId = reward.ownerBoxId
        })
      end
    elseif reward.actor and 0 < reward.actor.countDelta then
      table.insert(items, {
        type = PB.enum.ResourceType.ResActor,
        id = reward.actor.id,
        count = 1,
        ownerBoxId = reward.ownerBoxId,
        quality = reward.actor.quality
      })
    end
  end
  return items
end

function IsOverlap(m1, m2, n1, n2)
  if m2 < m1 then
    m1, m2 = m2, m1
  end
  if n2 < n1 then
    n1, n2 = n2, n1
  end
  if n1 < m1 and m1 < n2 then
    return true
  end
  if n1 < m2 and m2 < n2 then
    return true
  end
  if m1 < n1 and n1 < m2 then
    return true
  end
  if m1 < n2 and m2 > n2 then
    return true
  end
  return false
end

function HasCollision(c1, corners1, c2, corners2, halfWidth, isTopTest)
  local result = {}
  result.collideResult = Enum_DropResult.NoCollision
  if isTopTest then
    local topLineStart = c1 + corners1[2]
    local topLineEnd = c1 + corners1[3]
    local dropLineStart = c2 + corners2[1]
    local dropLineEnd = c2 + corners2[4]
    local isXCover = IsOverlap(topLineStart.x, topLineEnd.x, dropLineStart.x, dropLineEnd.x)
    local isYCover = IsOverlap(topLineStart.y, topLineEnd.y, dropLineStart.y, dropLineEnd.y)
    local allUnderTop = topLineStart.y > dropLineStart.y and topLineStart.y > dropLineEnd.y and topLineEnd.y > dropLineStart.y and topLineEnd.y > dropLineEnd.y
    local isOverlap = isXCover and (isYCover or allUnderTop)
    local isLeftLower = dropLineStart.y < dropLineEnd.y
    result.isLeftLower = isLeftLower
    if isOverlap then
      local lowerPoint = fif(isLeftLower, dropLineStart, dropLineEnd)
      local m2, n1, n2
      if isLeftLower then
        m2 = dropLineStart.x
        n1 = topLineStart.x
        n2 = topLineEnd.x
      else
        m2 = -dropLineEnd.x
        n1 = -topLineEnd.x
        n2 = -topLineStart.x
      end
      local coe = fif(isLeftLower, 1, -1)
      if m2 > n1 and m2 < n2 then
        local rotatedCenterX = lowerPoint.x + coe * halfWidth
        if n2 > coe * rotatedCenterX + 10 and n1 < coe * rotatedCenterX - 10 then
          if math.abs(rotatedCenterX - c1.x) < GAME.perfectLimit then
            result.collideResult = Enum_DropResult.PerfectPlace
          else
            result.collideResult = Enum_DropResult.NormalPlace
          end
        else
          result.collideResult = Enum_DropResult.CollideButDrop
        end
        result.changeHeight = topLineStart.y - lowerPoint.y
        result.collidePoint = lowerPoint + Vector3(0, result.changeHeight, 0)
      else
        local collide = fif(isLeftLower, topLineStart, topLineEnd)
        local startPoint = dropLineStart
        local endPoint = dropLineEnd
        local collisionHappenDuringDropHeight = 1.0 * (startPoint.y - endPoint.y) * (startPoint.x - collide.x) / (startPoint.x - endPoint.x) + collide.y - startPoint.y
        result.changeHeight = collisionHappenDuringDropHeight
        result.collidePoint = collide
        local nearestPoint = lowerPoint + Vector3(0, result.changeHeight, 0)
        local minDistance = Vector3.Distance(nearestPoint, collide)
        local rotatedCenterX = collide.x + coe * (halfWidth - minDistance)
        if n2 > coe * rotatedCenterX and n1 < coe * rotatedCenterX then
          if math.abs(rotatedCenterX - c1.x) < GAME.perfectLimit then
            result.collideResult = Enum_DropResult.PerfectPlace
          else
            result.collideResult = Enum_DropResult.NormalPlace
          end
        else
          result.collideResult = Enum_DropResult.CollideButDrop
        end
      end
      return result
    end
  end
  for i = 1, 4 do
    local p1 = c1 + corners1[i]
    local index = fif(i == 4, 1, i + 1)
    local p2 = c1 + corners1[index]
    for j = 1, 4 do
      if i ~= 2 and j ~= 4 then
        local q1 = c2 + corners2[j]
        local index = fif(j == 4, 1, j + 1)
        local q2 = c2 + corners2[index]
        local isXCover = IsOverlap(p1.x, p2.x, q1.x, q2.x)
        local isYCover = IsOverlap(p1.y, p2.y, q1.y, q2.y)
        local isOverlap = isXCover and isYCover
        if isOverlap then
          result.collideResult = Enum_DropResult.CollideButDrop
          result.collidePoint = GetCollidePoint(p1, p2, q1, q2)
          return result
        end
      end
    end
  end
  return result
end

function GetCollidePoint(a, b, c, d)
  local k1 = 1.0 * (a.x - b.x) / (a.y - b.y)
  local k2 = 1.0 * (c.x - d.x) / (c.y - d.y)
  if k1 == k2 then
    return 1.0 * (c + d) / 2
  else
    local n = (a.x - c.x - k1 * a.y + k2 * c.y) / (k2 - k1)
    local m = a.x - k1 * (a.y - n)
    return Vector3(m, n, 0)
  end
end
