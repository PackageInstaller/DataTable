local WU, DB, REF = require("Common/WindowUtil")(this)
local FSM = require("Common/FSM")
local m_fsm = FSM:new()
local m_subFsm = FSM:new()
local m_callback
local m_thisTouchTime = 0
local m_touchInterval = 0.5
local m_dismissDuration = 3
local m_waitingDuration = 2.5

function Awake()
  WU.BindButtonEvent(REF.ButtonSkip, OnButtonSkip)
end

function Reset(callback)
  m_fsm:ChangeState("", "Phase1")
  m_callback = callback
end

function Update()
  m_fsm:Update()
end

function OnButton()
  local now = CS.GameTime.time
  if m_thisTouchTime == 0 then
    REF.ButtonSkip.gameObject:SetActive(true)
  end
  m_thisTouchTime = now
end

function OnButtonSkip()
  CS.SoundManager.Instance:StopSound("Sound/system/s_System_GameShow01")
  CS.SoundManager.Instance:StopSound("Sound/system/s_System_GameShow02")
  CS.SoundManager.Instance:StopSound("Sound/system/s_System_GameShow03")
  m_fsm:ChangeState("", "Finish")
end

function ChangeToPhase2()
  WU.ClearButtonEvent(REF.Button)
  CS.SoundManager.Instance:StopSound("Sound/system/s_System_GameShow02")
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GameShow03")
  local foreground = _ENV["$"](REF.ATM_Phase1).Foreground
  foreground.gameObject:SetActive(true)
  this:DelayInvokeInSeconds(0.6, function()
    m_fsm:ChangeState("Phase1", "Phase2")
  end)
  m_subFsm:ChangeState("", "")
end

function m_fsm:EnterPhase1()
  WU.BindButtonEvent(REF.Button, OnButton)
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GameShow01")
  REF.ATM_Phase1.gameObject:SetActive(true)
  REF.ATM_Phase1.Animator:Play("SC_01loop")
  m_subFsm:ChangeState("", "Waiting")
end

function m_fsm:UpdatePhase1()
  m_subFsm:Update()
end

function m_subFsm:EnterWaiting()
  self.m_waitStartTime = CS.GameTime.time
end

function m_subFsm:UpdateWaiting()
  local now = CS.GameTime.time
  if 0 < m_thisTouchTime then
    local gachaResult = this:GetData("fci/gachaResult/")
    local hasOrangeActor = false
    for i = 1, #gachaResult.info.resChange do
      local change = gachaResult.info.resChange[i]
      if change.actor and 0 < change.actor.countDelta and change.actor.quality >= 4 then
        hasOrangeActor = true
        break
      end
    end
    if hasOrangeActor then
      m_subFsm:ChangeState("Waiting", "Charge")
    else
      ChangeToPhase2()
    end
  elseif now - self.m_waitStartTime >= m_waitingDuration then
    ChangeToPhase2()
  end
end

function m_subFsm:EnterCharge()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GameShow02")
  local ref = _ENV["$"](REF.ATM_Phase1)
  ref.Charge_A.gameObject:SetActive(true)
  ref.Charge_B.gameObject:SetActive(true)
  local tween = ref.Actor.UIPlayTween:Play(true)
  this:DelayInvokeInSeconds(0.5, function()
    m_subFsm:ChangeState("Charge", "Dismiss")
  end)
end

function m_subFsm:EnterDismiss()
  self.m_dismissStartTime = CS.GameTime.time
end

function m_subFsm:UpdateDismiss()
  local now = CS.GameTime.time
  if now - self.m_dismissStartTime >= m_dismissDuration then
    ChangeToPhase2()
  end
end

function m_fsm:EnterPhase2()
  REF.ATM_Phase1.gameObject:SetActive(false)
  REF.ATM_Phase2.gameObject:SetActive(true)
  local animator = REF.ATM_Phase2.Animator
  animator:Play("SC_02-07")
  animator:Update(0)
  this:DelayInvokeInSeconds(animator:GetCurrentAnimatorStateInfo(0).length, function()
    self:ChangeState("Phase2", "Phase3")
  end)
end

function m_fsm:EnterPhase3()
  REF.ATM_Phase2.gameObject:SetActive(false)
  REF.ATM_Phase3.gameObject:SetActive(true)
  REF.ButtonSkip.gameObject:SetActive(false)
  this:DelayInvokeInSeconds(1, function()
    self:ChangeState("Phase3", "Finish")
  end)
end

function m_fsm:EnterFinish()
  if m_callback ~= nil then
    m_callback()
  end
end
