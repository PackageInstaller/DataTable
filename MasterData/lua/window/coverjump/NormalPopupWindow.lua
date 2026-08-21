local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local m_startFly, m_welfareX, m_welfareY, m_actorId, m_clickCallBack, window
local m_closeTarget = "Welfare"
local m_onEffectArrive

function SetupWindow()
  window = WU.FindWindow("City")
  WU.BindButtonEvent(REF.ButtonFinish, function()
    if m_clickCallBack then
      m_clickCallBack()
    end
    REF["$Animator"]:Play("Close")
    this:DelayInvokeInSeconds(0.16, function()
      REF.Black.gameObject:SetActive(false)
      m_startFly = true
      this:DelayInvokeInSeconds(0.2, function()
        if m_onEffectArrive then
          m_onEffectArrive()
        end
        REF.Effect.transform.position = _ENV["$"](window)[m_closeTarget].gameObject.transform.position
        WU.SetActive(REF.Effect, true)
        REF.ButtonFinish.gameObject:SetActive(false)
        this:DelayInvokeInSeconds(0.8, function()
          WU.RecycleWindow(this)
        end)
      end)
    end)
  end)
end

function InitWindow()
  this:RegisterGameEvent("LeaveCity", function()
    WU.DestroyWindow(this, true)
  end)
  REF.Black.gameObject:SetActive(true)
  REF.ButtonFinish.gameObject:SetActive(true)
  WU.SetActive(REF.Effect, false)
  m_startFly = false
  REF.StarADD.transform.localPosition = CS.UnityEngine.Vector3.zero
  if window ~= nil then
    m_welfareX = _ENV["$"](window).LEFT.transform.localPosition.x + _ENV["$"](window).ActivityGrid.transform.localPosition.x
    m_welfareY = _ENV["$"](window).LEFT.transform.localPosition.y + _ENV["$"](window).ActivityGrid.transform.localPosition.y
  end
end

function SetView(data, clickCallBack)
  if data == nil then
    return
  end
  if data.closeEffect then
    REF.Effect.EffectGenerator.m_EffectName = data.closeEffect
    REF.Effect.EffectGenerator:Reset()
  end
  if data.closeTarget then
    m_closeTarget = data.closeTarget
  end
  if data.texture then
    REF.BG.UITexture.mainTexturePath = data.texture
    REF.BBG.UITexture.mainTexturePath = data.texture
  end
  m_onEffectArrive = data.onEffectArrive or nil
  m_clickCallBack = clickCallBack
  REF["$Animator"]:Play("Open")
end

function UpdateWindow()
  if m_startFly == true and window ~= nil then
    local pos = REF.root.transform:InverseTransformPoint(_ENV["$"](window)[m_closeTarget].gameObject.transform.position)
    U.Translate(REF.StarADD.transform, pos.x / 6, pos.y / 6, 0)
  end
end
