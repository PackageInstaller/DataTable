local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local ATU = require("Common/AutumnUtil")
local IU = require("Common/ItemUtil")
local m_moveTime = 3.0
local m_lineSpeed = 0.2
local m_speed, m_clawContainer, m_lineGb, m_leftBorder, m_rightBorder, m_playing
local m_bStop = false
local m_bClaw = false
local m_canClaw = false
local m_initPos, m_lineGbPos
local m_v0 = 10
local m_startTime = 0
local m_timeFlag = false
local m_gachaTicketId = 60001

function OnTouchClaw()
  if not m_canClaw then
    return
  end
  PlayStart()
end

function DoRequest()
  this:GameRequest("fci/ClawCraneBingo/"):Post(function(result)
    warning("result is " .. table.dump(result))
  end)
end

function PlayStart()
  if m_playing then
    return
  end
  m_playing = true
  m_bStop = true
  REF.Claw.gameObject:SetActive(false)
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GachaAutumn")
  local aniClaw
  local gachaResult = this:GetData("fci/ClawCraneBingo/")
  local resChange = gachaResult.resChange
  local getPresent = ATU.GetPresent(resChange)
  m_bClaw = getPresent
  if m_bClaw then
    aniClaw = REF.ClawAniOk
    REF.ClawAni.gameObject:SetActive(false)
    REF.ClawAniOk.gameObject:SetActive(true)
    REF.EffectFront.gameObject:SetActive(true)
    REF.EffectFront.EffectGenerator:Play()
  else
    aniClaw = REF.ClawAni
    REF.ClawAni.gameObject:SetActive(true)
    REF.ClawAniOk.gameObject:SetActive(false)
  end
  _ENV["$"](REF.Panel)["$Animator"]:Play("Move", -1, 0)
  aniClaw.EffectGenerator:Play(function()
    if not getPresent then
      WU.ShowRewards(resChange, function()
        WU.RecycleWindow(this)
      end)
    else
      m_lineGb.transform.localPosition = CS.UnityEngine.Vector3(-10000, 0, 0)
      WU.AcquireWindowAsync("GachaClawResult", function(w)
        local win = _ENV["$"](w)
        for k, v in pairs(resChange) do
          local itemInfo = PB.get("ItemInfo", v.baseRes.id)
          if itemInfo.funcType == PB.enum.ItemFuncType.AutoBox then
            resChange = IU.FlatInboxItems(resChange)
          end
        end
        win["$$ManageReschange"](resChange)
        win["$$SetResultLabel"](WU.GetString("EventActivity_GachaResult"))
      end, true)
    end
  end)
end

function ResetClaw()
  REF.Claw.gameObject:SetActive(true)
  REF.ClawAni.gameObject:SetActive(false)
  REF.ClawAniOk.gameObject:SetActive(false)
  m_clawContainer.transform.localPosition = m_initPos
  m_lineGb.transform.localPosition = m_lineGbPos
  m_lineGb.transform.localScale = CS.UnityEngine.Vector3.one
  m_playing = false
  m_bStop = false
  m_startTime = nil
  m_timeFlag = false
  REF.EffectFront.gameObject:SetActive(false)
end

function SetupWindow()
  WU.BindButtonEvent(REF.TouchBg, OnTouchClaw)
  m_leftBorder = REF.LeftBorder.transform.localPosition.x
  m_rightBorder = REF.RightBorder.transform.localPosition.x
  m_speed = (m_rightBorder - m_leftBorder) / m_moveTime
  m_clawContainer = REF.ClawContainer
  m_lineGb = REF.LINE
  m_initPos = m_clawContainer.transform.localPosition
  m_lineGbPos = m_lineGb.transform.localPosition
  WU.PreloadWindow("GachaClawResult")
end

function InitWindow()
  this:DelayInvokeInSeconds(1.0, function()
    m_canClaw = true
  end)
  ResetClaw()
  REF.Claw.EffectGenerator:Play()
end

function UpdateWindow()
  if m_bStop then
    return
  end
  if m_clawContainer.transform.localPosition.x <= m_leftBorder then
    m_speed = (m_rightBorder - m_leftBorder) / m_moveTime
  elseif m_clawContainer.transform.localPosition.x >= m_rightBorder then
    m_speed = -(m_rightBorder - m_leftBorder) / m_moveTime
  end
  local factor = fif(0 < m_speed, 1, -1)
  m_lineSpeed = factor * math.abs(m_lineSpeed)
  local vec = m_clawContainer.transform.localPosition
  local deltaX = m_speed * CS.GameTime.deltaTime
  local deltaScaleX = m_lineSpeed * CS.GameTime.deltaTime
  local deltaVec = CS.UnityEngine.Vector3(deltaX, 0, 0)
  local deltaScale = CS.UnityEngine.Vector3(deltaScaleX, 0, 0)
  vec.x = vec.x + m_speed * CS.GameTime.deltaTime
  m_clawContainer.transform.localPosition = m_clawContainer.transform.localPosition + deltaVec
  m_lineGb.transform.localPosition = m_lineGb.transform.localPosition + deltaVec
  m_lineGb.transform.localScale = m_lineGb.transform.localScale + deltaScale
  REF.EffectFront.transform.localPosition = CS.UnityEngine.Vector3(m_clawContainer.transform.localPosition.x, 0, 0)
end

function SetData(data)
  m_bClaw = data.isClaw
end
