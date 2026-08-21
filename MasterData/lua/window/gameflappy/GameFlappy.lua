local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local GC = require("Internal/gc")
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local m_collider = {
  [1] = {
    localPoints = {
      [1] = Vector3(26.17972, 50.26546, 0),
      [2] = Vector3(23.42128, 83.29003, 0),
      [3] = Vector3(61.83908, -5.259735, 0),
      [4] = Vector3(39.10232, -24.65325, 0)
    }
  },
  [2] = {
    localPoints = {
      [1] = Vector3(-3.252213, 13.92559, 0),
      [2] = Vector3(-5.662024, 83.25217, 0),
      [3] = Vector3(26.63741, 49.66304, 0),
      [4] = Vector3(38.88158, -24.56728, 0)
    }
  },
  [3] = {
    localPoints = {
      [1] = Vector3(-3.466527, 14.43012, 0),
      [2] = Vector3(-61.44831, -71.44289, 0),
      [3] = Vector3(6.304224, -81.58501, 0),
      [4] = Vector3(26.80861, -69.61768, 0),
      [5] = Vector3(38.34736, -24.66032, 0)
    }
  }
}
local m_mountainTF, m_treeTF, m_foregroundTF, m_obstacleREF, m_groundTopY
local m_gameId = 91001
local m_bgCount = 3
local m_playerInfo, m_state
local Enum_gameState = {
  None = 1,
  Ready = 2,
  Run = 3,
  Over = 4
}
local m_saku, m_distance
local m_countDownSpan = 0.5
local g_v = 320
local g_scoreScale = 360
local g_screenWidthMax = 2400
local g_screenWidth, g_screenHeight, g_bgWidth, g_bgBeginX
local g_oHorizantalSpan = 420
local g_oVerticalSpan = 300
local g_oHeightMin = 180
local g_oHeightMax
local g_oNextRelativeHeightMax = 340
local g_oResetPosX, g_oCurFirst, g_oList, g_oCount

function SetupWindow()
  WU.BindButtonEvent(REF.ClickMask, OnClick)
  WU.BindButtonEvent(REF.BtnPlayerData, OnPlayerDataClick)
  WU.BindButtonEvent(REF.BtnReward, OnPrizePreviewClick)
  WU.BindButtonEvent(REF.BtnGameStart, OnGameStartClick)
  WU.BindButtonEvent(REF.BtnShare, OnShareClick)
  WU.BindButtonEvent(REF.BtnClose, OnCloseClick)
end

function InitWindow()
  WU.SetActive(REF.NodeEdit, false)
  WU.SetActive(REF.BtnShare, WU.IsShareSwitchOn())
  WU.SetActive(REF.NodeShare, false)
  if WU.IsShareSwitchOn() then
    this:RegisterGameEvent("UI/WindowUninited", function(window)
      if window.name == "Share" then
        WU.SetActive(REF.NodeShare, false)
      end
    end)
  end
  SetGameConfigData()
  InitSakuInfo()
  GoToNoneState()
  local playerGameData = this:GetData("fci/mini-game/" .. m_gameId)
  if playerGameData == nil then
    this:GameRequest("fci/mini-game/" .. m_gameId):Get(function(res)
      if res.gameId == nil then
        res.gameId = m_gameId
      end
      if res.activityId == nil then
        res.activityId = this:GetData("GameFlappy/ActivityId")
      end
      if res.activityType == nil then
        res.activityType = this:GetData("GameFlappy/ActivityType")
      end
      if res.joinTimes == nil then
        res.joinTimes = 0
      end
      if res.rewardTimesToday == nil then
        res.rewardTimesToday = 1
      end
      if res.maxScore == nil then
        res.maxScore = 0
      end
      if res.totalScore == nil then
        res.totalScore = 0
      end
      this:SetData("fci/mini-game/" .. m_gameId, res)
      m_playerInfo = res
    end)
  else
    m_playerInfo = playerGameData
  end
end

function UpdateWindow(delta)
  if m_state == nil then
    return
  end
  if m_state == Enum_gameState.Run then
    m_distance = m_distance + g_v * delta / g_scoreScale
    REF.LabelScore.UILabel.text = math.floor(m_distance)
    if DoTestCollision() then
      return
    end
    DoMoveBg(delta)
    DoMoveObstacles(delta)
  elseif m_state == Enum_gameState.Over then
    DoTestCollision()
  end
end

function SetGameConfigData()
  g_screenWidth = REF.WindowSize.UIWidget.width
  g_screenHeight = REF.WindowSize.UIWidget.height
  g_bgWidth = REF.NodeMountain[0]["$UITexture"].width
  g_bgBeginX = -g_screenWidthMax / 2
  g_oHeightMax = g_screenHeight - g_oHeightMin - g_oVerticalSpan
  g_oResetPosX = (0 - g_screenWidthMax - g_oHorizantalSpan) / 2
  g_oCount = #REF.NodeObstacles
  m_mountainTF = _ENV["!"]({})
  for i = 0, #REF.NodeMountain - 1 do
    table.insert(m_mountainTF, REF.NodeMountain[i].root.transform)
  end
  m_treeTF = _ENV["!"]({})
  for i = 0, #REF.NodeTree - 1 do
    table.insert(m_treeTF, REF.NodeTree[i].root.transform)
  end
  m_foregroundTF = _ENV["!"]({})
  for i = 0, #REF.NodeForeground - 1 do
    table.insert(m_foregroundTF, REF.NodeForeground[i].root.transform)
  end
  m_obstacleREF = _ENV["!"]({})
  for i = 0, #REF.NodeObstacles - 1 do
    table.insert(m_obstacleREF, REF.NodeObstacles[i])
  end
  m_groundTopY = REF.NodeForeground[0].root.transform.localPosition.y + REF.NodeForeground.transform.localPosition.y
end

function InitSakuInfo()
  m_saku = {}
  m_saku.sakuGo = REF.WidgetSaku["$GetSaku"]()
  m_saku.height = m_saku.sakuGo.UIWidget.height
  m_saku.width = m_saku.sakuGo.UIWidget.width
  m_saku.localLeft = -m_saku.width / 2
  m_saku.localRight = m_saku.width / 2
  m_saku.localTop = m_saku.height / 2
  m_saku.localBottom = -m_saku.height / 2
  m_saku.outerTF = REF.WidgetSaku.transform
  m_saku.colliders = m_collider
  for i = 1, #m_collider do
    local points = m_collider[i].localPoints
    local normals = _ENV["!"]({})
    for j = 1, #points do
      if j ~= 1 then
        local normal = GetUnitNormal(points[j - 1], points[j])
        table.insert(normals, normal)
      end
    end
    local normal = GetUnitNormal(points[#points], points[1])
    table.insert(normals, normal)
    m_collider[i].normals = normals
  end
end

function OnPlayerDataClick()
  if m_playerInfo == nil then
    return
  end
  REF.LabelJoinCount.UIHtmlLabel.text = WU.GetString("GameFlappy_JoinCount") .. "<font color=#FFE254>" .. m_playerInfo.joinTimes .. "</font>"
  REF.LabelLDistance1.UIHtmlLabel.text = WU.GetString("GameFlappy_LongestDistance") .. "<font color=#FFE254>" .. m_playerInfo.maxScore .. "m</font>"
  local numstr
  if m_playerInfo.totalScore < 1000 then
    numstr = m_playerInfo.totalScore .. "m"
  else
    numstr = math.floor(m_playerInfo.totalScore / 100) / 10 .. "km"
  end
  REF.LabelDistanceAmount.UIHtmlLabel.text = WU.GetString("GameFlappy_DistanceAmount") .. "<font color=#FFE254>" .. numstr .. "</font>"
  WU.SetActive(REF.SpriteStaticSaku, false)
  WU.SetActive(REF.NodeGameArea, false)
  WU.SetActive(REF.NodeObstacles, false)
  WU.SetActive(REF.NodeGameOver, false)
  WU.SetActive(REF.NodePlayerData, true)
  WU.SetActive(REF.NodeDialog, true)
end

function OnPrizePreviewClick()
  WU.AcquireWindowAsync("PrizePreview", function(window)
    local xlsxFilter = {
      [1] = {
        key = "activityId",
        value = m_playerInfo.activityId
      },
      [2] = {key = "gameId", value = m_gameId}
    }
    _ENV["$"](window)["$$SetPrizePreview"]("GameFlappy", xlsxFilter)
  end)
end

function OnCloseClick()
  WU.SetActive(REF.NodeDialog, false)
  WU.SetActive(REF.SpriteStaticSaku, true)
end

function OnShareClick()
  this:SetData("ShareConfig", {
    shareName = "GameFlappy",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  REF.LabelJoinCountS.UIHtmlLabel.text = WU.GetString("GameFlappy_JoinCount") .. m_playerInfo.joinTimes
  REF.LabelLDistanceS.UIHtmlLabel.text = WU.GetString("GameFlappy_LongestDistance") .. m_playerInfo.maxScore .. "m"
  local numstr
  if m_playerInfo.totalScore < 1000 then
    numstr = m_playerInfo.totalScore .. "m"
  else
    numstr = math.floor(m_playerInfo.totalScore / 100) / 10 .. "km"
  end
  REF.LabelDistanceAmountS.UIHtmlLabel.text = WU.GetString("GameFlappy_DistanceAmount") .. numstr
  WU.SetActive(REF.NodeShare, true)
  WU.AcquireWindowAsync("Share")
end

function OnClick()
  if m_state == Enum_gameState.Ready then
    GoToRunState()
    REF.WidgetSaku["$FlyUp"]()
  elseif m_state == Enum_gameState.Run then
    REF.WidgetSaku["$FlyUp"]()
  end
end

function OnGameStartClick()
  GoToReadyState()
end

function GoToNoneState()
  m_state = Enum_gameState.None
  WU.SetActive(REF.SpriteStaticSaku, true)
  WU.SetActive(REF.NodeStartTutorial, false)
  WU.SetActive(REF.NodeGameArea, false)
  WU.SetActive(REF.NodeObstacles, false)
  WU.SetActive(REF.NodeDialog, false)
  WU.SetActive(REF.NodeRight, true)
  for i = 1, 3 do
    local beginX = g_bgBeginX + (i - 1) * g_bgWidth
    local pos = m_mountainTF[i].localPosition
    m_mountainTF[i].localPosition = Vector3(beginX, pos.y, pos.z)
    pos = m_treeTF[i].localPosition
    m_treeTF[i].localPosition = Vector3(beginX, pos.y, pos.z)
    pos = m_foregroundTF[i].localPosition
    m_foregroundTF[i].localPosition = Vector3(beginX, pos.y, pos.z)
  end
end

function GoToReadyState()
  m_state = Enum_gameState.Ready
  REF.WidgetSaku["$Reset"]()
  m_distance = 0
  REF.LabelScore.UILabel.text = math.floor(m_distance)
  ResetObstacle()
  REF.LabelNumber.UILabel.text = 3
  WU.SetActive(REF.SpriteStaticSaku, false)
  WU.SetActive(REF.NodeStartTutorial, true)
  WU.SetActive(REF.NodeGameArea, true)
  WU.SetActive(REF.NodeObstacles, true)
  WU.SetActive(REF.NodeDialog, false)
  WU.SetActive(REF.NodeRight, false)
  GC:collect()
  CS.System.GC.Collect()
end

function GoToRunState()
  m_state = Enum_gameState.Run
  WU.SetActive(REF.NodeStartTutorial, false)
  REF.WidgetSaku["$FlyStart"]()
end

function GoToOverState(isGround)
  this:GameRequest("fci/mini-game/"):Post({
    gameId = m_gameId,
    activityId = m_playerInfo.activityId,
    score = math.floor(m_distance),
    activityType = m_playerInfo.activityType
  }, function(result)
    m_playerInfo = result.gameRecord[m_gameId]
    this:SetData("fci/mini-game/" .. m_gameId, m_playerInfo)
    REF.LabelCurrentDistance.UIHtmlLabel.text = WU.GetString("GameFlappy_CurrentDistance") .. math.floor(m_distance) .. "m"
    REF.LabelLDistance2.UIHtmlLabel.text = WU.GetString("GameFlappy_LongestDistance") .. m_playerInfo.maxScore .. "m"
    WU.SetActive(REF.SpriteTrophy, m_distance >= m_playerInfo.maxScore)
    WU.SetActive(REF.NodeGameOver, true)
    WU.SetActive(REF.NodePlayerData, false)
    WU.SetActive(REF.NodeRight, true)
    WU.SetActive(REF.NodeDialog, true)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
  end)
end

function ResetObstacle()
  g_oList = _ENV["!"]({})
  g_oCurFirst = 1
  local firstPosX = -g_oResetPosX
  local prePosX = 0
  for i = 1, g_oCount do
    local ref = m_obstacleREF[i]
    local pos = ref.root.transform.localPosition
    prePosX = fif(i == 1, firstPosX, prePosX + g_oHorizantalSpan)
    ref.root.transform.localPosition = Vector3(prePosX, pos.y, pos.z)
    local reference
    if i ~= 1 then
      reference = g_oList[i - 1]
    end
    local config = CreateObstacleConfig(ref, reference)
    ref.TriangleUp.UISprite.height = config.up.height
    ref.TriangleDown.UISprite.height = config.down.height
    table.insert(g_oList, config)
  end
end

function DoCountDown()
  this:DelayInvokeInSeconds(m_countDownSpan * 1, function()
    REF.LabelNumber.UILabel.text = 2
  end)
  this:DelayInvokeInSeconds(m_countDownSpan * 2, function()
    REF.LabelNumber.UILabel.text = 1
  end)
  this:DelayInvokeInSeconds(m_countDownSpan * 3, function()
    REF.LabelNumber.UILabel.text = 0
    GoToRunState()
  end)
end

function DoMoveBg(delta)
  for i = 1, m_bgCount do
    DoMoveBgObject(m_mountainTF[i], delta * g_v / 5)
    DoMoveBgObject(m_treeTF[i], delta * g_v / 3)
    DoMoveBgObject(m_foregroundTF[i], delta * g_v)
  end
end

function DoMoveBgObject(tf, subX)
  local pos = tf.localPosition
  local posX = pos.x - subX
  if posX < g_bgBeginX - g_bgWidth then
    posX = posX + 3 * g_bgWidth
  end
  tf.localPosition = Vector3(posX, pos.y, pos.z)
end

function DoMoveObstacles(delta)
  local count = #m_obstacleREF
  for i = 1, count do
    local ref = m_obstacleREF[i]
    local tf = ref.root.transform
    local pos = tf.localPosition
    local posX = pos.x - g_v * delta
    if posX <= g_oResetPosX then
      posX = posX + count * g_oHorizantalSpan
      local refIndex = i - 1
      if refIndex == 0 then
        refIndex = count
      end
      local reference = g_oList[refIndex]
      local config = g_oList[i]
      UpdateObstacleConfig(ref, reference, config)
      ref.TriangleUp.UISprite.height = config.up.height
      ref.TriangleDown.UISprite.height = config.down.height
      if g_oCurFirst == count then
        g_oCurFirst = 1
      else
        g_oCurFirst = g_oCurFirst + 1
      end
    end
    tf.localPosition = Vector3(posX, pos.y, pos.z)
  end
end

function DoTestCollision()
  if REF.WidgetSaku["$IsStop"]() then
    return
  end
  if m_state == Enum_gameState.Run then
    if DOTestGroundCollision() then
      MarkSakuDie(true)
      return true
    elseif DoTestObstacleCollision() then
      MarkSakuDie(false)
      return true
    end
  elseif m_state == Enum_gameState.Over and DOTestGroundCollision() then
    REF.WidgetSaku["$StopDrop"]()
    this:DelayInvokeInSeconds(1, function()
      GoToOverState()
    end)
  end
end

function DOTestGroundCollision()
  local sakuWorldY = m_saku.outerTF.localPosition.y + m_saku.localBottom
  return sakuWorldY < m_groundTopY
end

function DoTestObstacleCollision()
  m_saku.worldLeft = m_saku.localLeft + m_saku.outerTF.localPosition.x
  m_saku.worldRight = m_saku.localRight + m_saku.outerTF.localPosition.x
  m_saku.worldTop = m_saku.localTop + m_saku.outerTF.localPosition.y
  m_saku.worldBottom = m_saku.localBottom + m_saku.outerTF.localPosition.y
  local hasTestOne = false
  local ranges = _ENV["!"]({})
  for i = g_oCurFirst, g_oCurFirst + g_oCount - 1 do
    local index = fif(i <= g_oCount, i, i - g_oCount)
    local config = g_oList[index]
    local ref = m_obstacleREF[index]
    if config.new then
      UpdateObstacleLocalPoints(ref, config)
    end
    UpdateObstacleWorldPoints(ref, config)
    local upPoints = config.up.worldPoints
    if m_saku.worldRight > upPoints[1].x and m_saku.worldRight < upPoints[2].x and m_saku.worldTop > upPoints[1].y then
      return true
    end
    local nodeIndex = index
    local testUp = false
    local testDown = false
    if m_saku.worldLeft > upPoints[1].x and m_saku.worldLeft < upPoints[2].x and m_saku.worldTop > upPoints[3].y and m_saku.worldTop < upPoints[1].y then
      testUp = true
    end
    if m_saku.worldRight > upPoints[1].x and m_saku.worldRight < upPoints[2].x and m_saku.worldTop > upPoints[3].y and m_saku.worldTop < upPoints[1].y then
      testUp = true
    end
    local downPoints = config.down.worldPoints
    if m_saku.worldLeft > downPoints[1].x and m_saku.worldLeft < downPoints[2].x and m_saku.worldBottom > downPoints[1].y and m_saku.worldBottom < downPoints[3].y then
      testDown = true
    end
    if m_saku.worldRight > downPoints[1].x and m_saku.worldRight < downPoints[2].x and m_saku.worldBottom > downPoints[1].y and m_saku.worldBottom < downPoints[3].y then
      testDown = true
    end
    if testUp or testDown then
      table.insert(ranges, {
        index = nodeIndex,
        up = testUp,
        down = testDown
      })
      hasTestOne = true
    elseif hasTestOne then
      break
    end
  end
  if #ranges == 0 then
    return false
  end
  local sakuColliders = m_saku.colliders
  local sakuPolygons = _ENV["!"]({})
  for i = 1, #sakuColliders do
    local collider = sakuColliders[i]
    local points = collider.localPoints
    if collider.worldPoints == nil then
      collider.worldPoints = _ENV["!"]({})
    end
    for j = 1, #points do
      collider.worldPoints[j] = points[j] + m_saku.outerTF.localPosition
    end
  end
  for i = 1, #ranges do
    local oConfig = g_oList[ranges[i].index]
    if ranges[i].up then
      for j = 1, #sakuColliders do
        if TestPolygenCollision(sakuColliders[j], oConfig.up) then
          return true
        end
      end
    end
    if ranges[i].down then
      for j = 1, #sakuColliders do
        if TestPolygenCollision(sakuColliders[j], oConfig.down) then
          return true
        end
      end
    end
  end
  return false
end

function CreateObstacleConfig(ref, reference)
  local downHeight = RandomProduceAHeight(reference)
  local config = {
    new = true,
    outerTF = ref.root.transform,
    down = {
      height = downHeight,
      localPoints = {
        Vector3.zero,
        Vector3.zero,
        Vector3.zero
      },
      worldPoints = {
        Vector3.zero,
        Vector3.zero,
        Vector3.zero
      },
      normals = {
        Vector2.zero,
        Vector2.zero
      }
    },
    up = {
      height = g_oHeightMax + g_oHeightMin - downHeight,
      localPoints = {
        Vector3.zero,
        Vector3.zero,
        Vector3.zero
      },
      worldPoints = {
        Vector3.zero,
        Vector3.zero,
        Vector3.zero
      },
      normals = {
        Vector2.zero,
        Vector2.zero
      }
    }
  }
  return config
end

function UpdateObstacleConfig(ref, reference, config)
  local downHeight = RandomProduceAHeight(reference)
  config.down.height = downHeight
  config.up.height = g_oHeightMax + g_oHeightMin - downHeight
  config.new = true
end

function RandomProduceAHeight(reference)
  local min = g_oHeightMin
  local max = g_oHeightMax
  if reference then
    local relativeMin = reference.down.height - g_oNextRelativeHeightMax
    local relativeMax = reference.down.height + g_oNextRelativeHeightMax
    min = math.max(min, relativeMin)
    max = math.min(max, relativeMax)
  end
  return math.random(min, max)
end

function UpdateObstacleLocalPoints(ref, config)
  local outPos = ref.TriangleUp.transform.localPosition
  local innerUpPos = ref.InnerUp.transform.localPosition
  local upHeight = ref.InnerUp.UIWidget.height
  local upWidth = ref.InnerUp.UIWidget.width
  local pLeft = Vector3(innerUpPos.x, innerUpPos.y + upHeight, 0)
  local pRight = Vector3(innerUpPos.x + upWidth, innerUpPos.y + upHeight, 0)
  local pTop = Vector3(innerUpPos.x + upWidth / 2, innerUpPos.y, 0)
  config.up.localPoints[1] = pLeft + outPos
  config.up.localPoints[2] = pRight + outPos
  config.up.localPoints[3] = pTop + outPos
  config.up.normals[1] = GetUnitNormal(pLeft, pTop)
  config.up.normals[2] = GetUnitNormal(pTop, pRight)
  outPos = ref.TriangleDown.transform.localPosition
  local innerDownPos = ref.InnerDown.transform.localPosition
  local downHeight = ref.InnerDown.UIWidget.height
  local downWidth = ref.InnerDown.UIWidget.width
  pLeft = Vector3(innerDownPos.x - downWidth / 2, innerDownPos.y - downHeight, 0)
  pRight = Vector3(innerDownPos.x + downWidth / 2, innerDownPos.y - downHeight, 0)
  pTop = Vector3(innerDownPos.x, innerDownPos.y, 0)
  config.down.localPoints[1] = pLeft + outPos
  config.down.localPoints[2] = pRight + outPos
  config.down.localPoints[3] = pTop + outPos
  config.down.normals[1] = GetUnitNormal(pLeft, pTop)
  config.down.normals[2] = GetUnitNormal(pTop, pRight)
  config.new = false
end

function UpdateObstacleWorldPoints(ref, config)
  config.up.worldPoints[1] = config.up.localPoints[1] + config.outerTF.localPosition
  config.up.worldPoints[2] = config.up.localPoints[2] + config.outerTF.localPosition
  config.up.worldPoints[3] = config.up.localPoints[3] + config.outerTF.localPosition
  config.down.worldPoints[1] = config.down.localPoints[1] + config.outerTF.localPosition
  config.down.worldPoints[2] = config.down.localPoints[2] + config.outerTF.localPosition
  config.down.worldPoints[3] = config.down.localPoints[3] + config.outerTF.localPosition
end

function GetUnitNormal(p1, p2)
  local edgeX = p2.x - p1.x
  local edgeY = p2.y - p1.y
  local sqrtV = math.sqrt(edgeX * edgeX + edgeY * edgeY)
  local norAxis = Vector2(-edgeY / sqrtV, edgeX / sqrtV)
  return norAxis
end

function MarkSakuDie(isGround)
  REF.WidgetSaku["$Die"](isGround)
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_FlappyFail")
  m_state = Enum_gameState.Over
  if isGround then
    this:DelayInvokeInSeconds(1, function()
      GoToOverState()
    end)
  end
end

function TestPolygenCollision(polygon1, polygon2)
  for i = 1, #polygon1.normals do
    local normal = polygon1.normals[i]
    local pRange1, pRange2 = GetProject(polygon1.worldPoints, normal), GetProject(polygon2.worldPoints, normal)
    if not IsOverlap(pRange1, pRange2) then
      return false
    end
  end
  for i = 1, #polygon2.normals do
    local normal = polygon2.normals[i]
    local pRange1, pRange2 = GetProject(polygon1.worldPoints, normal), GetProject(polygon2.worldPoints, normal)
    if not IsOverlap(pRange1, pRange2) then
      return false
    end
  end
  return true
end

function Vector2ToVector3(v)
  return Vector3(v.x, v.y, 0)
end

function GetProject(points, norAxis)
  local min = points[1].x * norAxis.x + points[1].y * norAxis.y
  local max = min
  for i = 1, #points do
    local proj = points[i].x * norAxis.x + points[i].y * norAxis.y
    if min > proj then
      min = proj
    end
    if max < proj then
      max = proj
    end
  end
  return {min, max}
end

function IsOverlap(range1, range2)
  if IsInclude(range2, range1[1]) then
    return true
  elseif IsInclude(range2, range1[2]) then
    return true
  elseif IsInclude(range1, range2[1]) then
    return true
  elseif IsInclude(range1, range2[2]) then
    return true
  end
  return false
end

function IsInclude(range, val)
  return val >= range[1] and val <= range[2]
end
