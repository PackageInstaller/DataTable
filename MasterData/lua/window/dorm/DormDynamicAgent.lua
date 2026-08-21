local WU, DB, REF = require("Common/WindowUtil")(this)
local DormAI = require("Common/DormAI")
local FSM = require("Common/FSM")
local DU = require("Common/DormUtil")
local PB = require("Common/PbHelper")
local BoxTerm = CS.IsometricGame.BoxTerm
local DEFAULT_ORIGIN_POSITION = CS.UnityEngine.Vector3(1.09, -0.19, 0)
local DIR_UP = CS.UnityEngine.Vector3(0, 1, 0)
local DIR_DOWN = CS.UnityEngine.Vector3(0, -1, 0)
local DIR_LEFT = CS.UnityEngine.Vector3(-1, 0, 0)
local DIR_RIGHT = CS.UnityEngine.Vector3(1, 0, 0)
local DIRS = {
  DIR_UP,
  DIR_DOWN,
  DIR_LEFT,
  DIR_RIGHT
}
local MAX_MOVE_DISTANCE = 1
local NEIGHBOUR_OFFSET = {
  {x = 0, y = 2},
  {x = 1, y = 2},
  {x = 0, y = -1},
  {x = 1, y = -1},
  {x = -1, y = 0},
  {x = -1, y = 1},
  {x = 2, y = 0},
  {x = 2, y = 1}
}
local STATE_ANIM = {
  [DormAI.AGENT_STATE.Idle] = "idle",
  [DormAI.AGENT_STATE.Move] = "walk",
  [DormAI.AGENT_STATE.Control] = "drag"
}
local m_box, m_dorm, m_AIController, m_actorId, m_skeleton
local m_fsm = FSM:new()
local m_view, m_prevPos
local m_accDeviation = {x = 0, y = 0}
local m_timer = 0
local m_timerStop = 0
local m_stopDuration = 0
local m_deltaTime, m_moveDir
local m_speed = 2
local m_nextAction
local m_moveDistance = 0
local m_idleDuration = 1
local m_nextIdleDuration, m_actorState, m_furnBox, m_furnId, m_intDuration, m_actorIntId, m_actorIntAgents, m_otherAnimTimeline, m_forcedNextAction

function Awake()
  m_box = REF.root.IsometricBox
  m_view = REF.View
end

function Init(actorId, dorm, AIController)
  m_actorId = actorId
  m_dorm = dorm
  m_AIController = AIController
  local skeletonDataAsset = WU.AcquireAsset("Dependencies/Spine/leafa/lifa_SkeletonData")
  skeletonDataAsset:GetSkeletonData(false)
  m_skeleton = CS.Spine.Unity.SkeletonAnimation.NewSkeletonAnimationGameObject(skeletonDataAsset)
  m_skeleton.transform:SetParent(REF.SkeletonHolder.transform)
  m_skeleton.transform.localPosition = CS.UnityEngine.Vector3.zero
  m_skeleton.transform.localScale = CS.UnityEngine.Vector3.one
  ExecuteNextAction()
end

function PlayAnim(preAnim, lastAnim, position)
  if preAnim then
    m_skeleton.AnimationState:SetAnimation(0, preAnim, false)
    m_skeleton.AnimationState:AddAnimation(0, lastAnim, true, 0)
  else
    m_skeleton.AnimationState:SetAnimation(0, lastAnim, true)
  end
  if position then
    REF.SkeletonHolder.transform.localPosition = position
  end
end

function GetAnim(animName)
  return m_skeleton.AnimationState.Data.SkeletonData:FindAnimation(animName)
end

function InteractiveFurn(furnBox)
  m_furnBox = furnBox
  m_furnId = DU.GetFurnIdByName(m_furnBox.gameObject.name)
  EnterState(DormAI.AGENT_STATE.Furniture)
end

function GetState()
  local stateEnum = table.find(DormAI.AGENT_STATE, function(k, v)
    return v == m_fsm.state
  end)
  return stateEnum
end

function GetFurnBox()
  return m_furnBox
end

function EnterState(state)
  if m_fsm.nextState ~= state then
    m_fsm:ChangeState(m_fsm.state, state)
    if state ~= DormAI.AGENT_STATE.Resolve and m_actorState ~= state then
      m_actorState = state
      if state == DormAI.AGENT_STATE.Furniture then
        local intConfig = PB.get("FurnitureInteractive", m_furnId)
        if intConfig then
          local actorAnim = intConfig.actorAnim
          if GetAnim("fall_" .. actorAnim.name) then
            PlayAnim("fall_" .. actorAnim.name, actorAnim.name, fif(intConfig.attached, CS.UnityEngine.Vector3(actorAnim.x, actorAnim.y, 0), nil))
          else
            PlayAnim(nil, actorAnim.name, fif(intConfig.attached, CS.UnityEngine.Vector3(actorAnim.x, actorAnim.y, 0), nil))
          end
        end
      else
        PlayAnim(nil, STATE_ANIM[state], DEFAULT_ORIGIN_POSITION)
      end
    end
  end
end

function Move(dir, distance)
  MoveImpl(m_box.isoPositionRaw + distance * dir)
  local isoPos = m_box.isoPosition
  if isoPos ~= m_prevPos then
    m_prevPos = isoPos
    if not m_dorm.RearrangeAllBox() then
      ExecuteNextAction()
    end
    m_dorm.UpdateMovableBoard(m_dorm.m_root.boxList)
  end
end

function MoveImpl(pos)
  local rx, ry
  local checkPos = {
    x = pos.x + m_accDeviation.x,
    y = pos.y + m_accDeviation.y
  }
  pos.x, rx = Round(checkPos.x)
  pos.y, ry = Round(checkPos.y)
  m_accDeviation.x = fif(rx, checkPos.x - pos.x, 0)
  m_accDeviation.y = fif(ry, checkPos.y - pos.y, 0)
  if IsMovable(pos, rx, ry) then
    m_box.isoPosition = pos
    local p = CS.IsometricGame.IsometricTools.IsoToCart(m_box.unitSize, m_box.isoPositionRaw)
    p = m_dorm.m_root.transform:TransformPoint(p)
    m_box.transform.position = p
  end
end

function IsMovable(pos, rx, ry)
  local root = m_dorm.m_root
  local bound = m_box.bound
  local occlusion = GetOcclusionRaw(pos, rx, ry)
  if pos.x < 0 or 0 > pos.y or pos.x > root.size.x - bound.x or pos.y > root.size.y - bound.y then
    return false
  end
  for _, o in ipairs(occlusion) do
    if not m_dorm.IsMovableAtPoint(o.x, o.y) then
      return false
    end
  end
  return true
end

function GetOcclusionRaw(pos, rx, ry)
  local bd = m_box.bound
  local tx = fif(rx, 0, 1) + bd.x
  local ty = fif(ry, 0, 1) + bd.y
  local result = {}
  local x = math.floor(pos.x)
  local y = math.floor(pos.y)
  for i = 0, tx - 1 do
    for j = 0, ty - 1 do
      table.insert(result, {
        x = x + i,
        y = y + j
      })
    end
  end
  return result
end

function Round(val)
  local floor = math.floor(val)
  local ceil = math.ceil(val)
  if math.abs(val - floor) < 0.1 then
    return floor, true
  elseif math.abs(val - ceil) < 0.1 then
    return ceil, true
  else
    return val, false
  end
end

function ExecuteNextAction()
  EnterState(DormAI.AGENT_STATE.Resolve)
end

function ResolveNextAction()
  local neighbourInteractiveBoxs = {}
  local boxPos = m_box.isoPosition
  local luaPos = {
    x = boxPos.x,
    y = boxPos.y
  }
  local canMoveDirs = {
    1,
    2,
    3,
    4
  }
  if m_dorm.m_aiOptions.enableActorInteractive then
    m_actorIntId = nil
    m_actorIntAgents = nil
    m_actorIntId, m_actorIntAgents = ResolveActorInteractive()
    if m_actorIntId then
      m_nextAction = DormAI.AGENT_STATE.Idle
      for _, agent in ipairs(m_actorIntAgents) do
        agent["$SetActorIntData"](m_actorIntId, m_actorIntAgents)
        agent["$DecideToTalk"]()
      end
      return
    end
  end
  for i, v in ipairs(NEIGHBOUR_OFFSET) do
    local dirIdx = (i + 1) // 2
    local p = Vector2Add(luaPos, v)
    local boxList = m_dorm.GetBoxListByGridOnMovable(p.x, p.y)
    if boxList then
      if boxList.size > 0 then
        local box = boxList[boxList.size - 1]
        if box ~= m_box then
          local idx = table.find(canMoveDirs, function(k, v)
            return v == dirIdx
          end)
          if idx then
            table.remove(canMoveDirs, idx)
          end
          local canUse = false
          local furnId = DU.GetFurnIdByName(box.gameObject.name)
          local intConfig = PB.get("FurnitureInteractive", furnId)
          if intConfig then
            if intConfig.attached then
              canUse = m_dorm.CanInteractive(box)
            elseif not box.flip and InverseDirIdx(intConfig.condition.dir) == dirIdx and intConfig.condition.actorFlip == m_box.flip then
              canUse = true
            elseif box.flip and InverseDirIdx((intConfig.condition.dir + 2) % 4) == dirIdx and intConfig.condition.actorFlip == not m_box.flip then
              canUse = true
            end
          end
          if canUse then
            neighbourInteractiveBoxs[dirIdx] = box
          end
        end
      end
    else
      do
        local idx = table.find(canMoveDirs, function(k, v)
          return v == dirIdx
        end)
        if idx then
          table.remove(canMoveDirs, idx)
        end
      end
    end
  end
  m_furnBox = nil
  m_furnBox = ResolveFurnInteractive(neighbourInteractiveBoxs)
  if m_furnBox then
    m_furnId = DU.GetFurnIdByName(m_furnBox.gameObject.name)
    m_nextAction = DormAI.AGENT_STATE.Furniture
    return
  end
  if math.random(1, 10000) > 5000 then
    m_nextAction = DormAI.AGENT_STATE.Idle
    return
  end
  m_moveDir = nil
  if 0 < #canMoveDirs then
    m_moveDir = DIRS[canMoveDirs[math.random(1, #canMoveDirs)]]
  end
  if 0 >= m_AIController:GetMovingCount() and m_moveDir then
    m_nextAction = DormAI.AGENT_STATE.Move
    return
  end
  m_nextAction = DormAI.AGENT_STATE.Idle
end

function ResolveActorInteractive()
  local r = math.random(1, 10000)
  local totalP = 0
  local agentMap = m_dorm.GetAgentMap()
  local agentInteractiveMap = m_dorm.GetAgentInteractiveMap()
  local intIds = agentInteractiveMap[m_actorId]
  if intIds then
    local intId
    for _, id in ipairs(intIds) do
      local config = PB.get("ActorInteractive", id)
      local p = config.interactiveProbability
      totalP = totalP + p
      if r <= totalP then
        intId = id
        break
      end
    end
    if intId then
      local boxs = {}
      local agents = {}
      local config = PB.get("ActorInteractive", intId)
      for i = 1, #config.participants do
        local par = config.participants[i]
        local box = table.find(agentMap, function(k, v)
          local theActorId = v["$GetActorId"]()
          return theActorId == par.actorId
        end)
        local agent = agentMap[box]
        if par.furnitureId ~= 0 then
          if box.boxParent == nil or DU.GetFurnIdByName(box.boxParent.gameObject.name) ~= par.furnitureId then
            return nil
          end
        else
          local state = agent["$GetState"]()
          if m_box ~= box and state ~= DormAI.AGENT_STATE.Idle then
            return nil
          end
        end
        table.insert(boxs, box)
        table.insert(agents, agentMap[box])
      end
      if CanTalk(boxs) then
        return intId, agents
      end
    end
  end
end

function ResolveFurnInteractive(boxs)
  local r = math.random(1, 10000)
  local totalP = 0
  for _, box in pairs(boxs) do
    local id = DU.GetFurnIdByName(box.gameObject.name)
    local p = PB.get("FurnitureInteractive", id).interactiveProbability
    totalP = totalP + p
    if r <= totalP then
      return box
    end
  end
end

function Say(content, duration)
  m_dorm.AgentSay(m_box, content, duration)
end

function SayMore(configs)
  m_dorm.AgentSayMore(m_box, configs)
end

function StopSaying()
  m_dorm.AgentStopSaying(m_box)
end

function Vector2Add(a, b)
  return {
    x = a.x + b.x,
    y = a.y + b.y
  }
end

function InverseDirIdx(dir)
  if dir == 1 then
    return 2
  elseif dir == 2 then
    return 1
  elseif dir == 3 then
    return 4
  elseif dir == 4 then
    return 3
  end
end

function CanTalk(boxs)
  local agentMap = m_dorm.GetAgentMap()
  for i = 1, #boxs do
    local agent = agentMap[boxs[i]]
  end
  for i = 1, #boxs do
    for j = i + 1, #boxs do
      if DU.AgentBoxFaceToFace(boxs[i], boxs[j]) then
        return true
      end
    end
  end
  return false
end

function GetActorId()
  return m_actorId
end

function SetActorIntData(intId, intAgents)
  m_actorIntId = intId
  m_actorIntAgents = intAgents
end

function ForceNextAction(nextAction, cmder)
  m_forcedNextAction = nextAction
  ExecuteNextAction()
end

function SetTimerStop(stopDuration)
  m_timerStop = 0
  m_stopDuration = stopDuration
end

function DecideToTalk()
  local intConfig = PB.get("ActorInteractive", m_actorIntId)
  local stopDuration = 0
  local scenarioConfigs = {}
  for i = 1, #intConfig.scenarios do
    local scenario = intConfig.scenarios[i]
    table.insert(scenarioConfigs, {
      content = fif(scenario.actorId == m_actorId, WU.GetString(string.format("Dorm_Scenario_%s_%s", m_actorIntId, i)), ""),
      duration = scenario.duration
    })
    stopDuration = stopDuration + scenario.duration
  end
  SetTimerStop(stopDuration)
  SayMore(scenarioConfigs)
end

function UpdateState(deltaTime)
  m_deltaTime = deltaTime
  m_timerStop = m_timerStop + deltaTime
  if m_timerStop > m_stopDuration then
    m_timer = m_timer + deltaTime
  end
  m_fsm:Update()
end

function m_fsm:EnterResolve()
  local i = 0
  if m_forcedNextAction then
    m_nextAction = m_forcedNextAction
    m_forcedNextAction = nil
  else
    ResolveNextAction()
    i = 1
  end
  if m_nextAction == DormAI.AGENT_STATE.Furniture then
    local intConfig = PB.get("FurnitureInteractive", m_furnId)
    if intConfig.attached then
      DU.TranslateActorToInteractiveFurn(m_box, m_furnBox)
      m_dorm.RearrangeAllBox()
    end
    if intConfig.dialogueIndex ~= 0 then
      Say(WU.GetString("Dorm_Dialogue_" .. intConfig.dialogueIndex), intConfig.duration)
    end
  end
  EnterState(m_nextAction)
end

function m_fsm:EnterFurniture()
  local intConfig = PB.get("FurnitureInteractive", m_furnId)
  if intConfig.attached then
    m_intDuration = nil
  else
    m_timer = 0
    m_intDuration = intConfig.duration
  end
end

function m_fsm:UpdateFurniture()
  if m_intDuration and m_timer > m_intDuration then
    ExecuteNextAction()
  end
end

function m_fsm:LeaveFurniture()
  m_furnBox = nil
  m_furnId = nil
end

function m_fsm:EnterMove()
  m_moveDistance = 0
  m_AIController:IncreaseMovingCount()
  local flip = m_moveDir == DIR_UP or m_moveDir == DIR_RIGHT
  m_box.flip = flip
  m_view["$SetFlip"](flip)
end

function m_fsm:UpdateMove()
  local distance = m_speed * m_deltaTime
  m_moveDistance = m_moveDistance + distance
  if m_moveDistance >= MAX_MOVE_DISTANCE or m_AIController:GetMovingCount() > 1 then
    ExecuteNextAction()
  end
  Move(m_moveDir, distance)
end

function m_fsm:LeaveMove()
  m_AIController:DecreaseMovingCount()
end

function m_fsm:EnterIdle()
  m_timer = 0
  if m_nextIdleDuration then
    m_idleDuration = m_nextIdleDuration
    m_nextIdleDuration = nil
  else
    m_idleDuration = math.random(10, 30) / 10
  end
end

function m_fsm:UpdateIdle()
  if m_timer > m_idleDuration then
    ExecuteNextAction()
  end
end

function m_fsm:EnterControl()
  StopSaying()
end

function m_fsm:EnterOther()
  m_timer = 0
  m_intDuration = 0
  local config = PB.get("ActorInteractive", m_actorIntId)
  for i = 1, #config.scenarios do
    local scenario = config.scenarios[i]
    m_intDuration = m_intDuration + scenario.duration
  end
end

function m_fsm:UpdateOther()
  if m_intDuration and m_timer > m_intDuration then
    ExecuteNextAction()
  end
end

function m_fsm:LeaveOther()
  m_actorIntId = nil
  m_actorIntAgents = nil
end
