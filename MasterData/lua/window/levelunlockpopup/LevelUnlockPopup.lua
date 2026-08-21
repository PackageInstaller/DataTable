local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_targetX, m_targetY, m_speedX, m_speedY, m_startFly
local m_flyTime = 0.36
local m_targetName, m_city, m_clickCallBack, m_unlockWin, m_texture
local m_setOnce = false

function SetupWindow()
  m_city = WU.FindWindow("City")
  WU.BindButtonEvent(REF.ButtonFinish, function()
    if m_clickCallBack then
      m_clickCallBack()
    end
    REF.NodeOpen.gameObject:SetActive(false)
    WU.SetActive(REF.ButtonFinish, false)
    m_startFly = true
    REF.EffectClose.EffectGenerator:Play(function()
      this:DelayInvokeInSeconds(m_flyTime, function()
        m_startFly = false
        REF.EffectFly.transform.position = _ENV["$"](m_city)[m_targetName].transform.position
        WU.RecycleWindow(this)
      end)
    end)
  end)
end

function SetView(data, clickCallBack)
  if data == nil then
    return
  end
  m_setOnce = false
  m_unlockWin = data.unlockWin
  local winInfo = PB.get("UnlockWindowPos", m_unlockWin)
  m_targetName = winInfo.targetName
  m_clickCallBack = clickCallBack
  if _ENV["$"](m_city)[m_targetName] == nil then
    error("UI", string.format("No Such GameObject[%s] in City!", m_targetName))
    WU.RecycleWindow(this)
  end
  WU.SetActive(REF.ButtonFinish, false)
  REF.NodeOpen.gameObject:SetActive(true)
  REF.NodeLabel.UIPlayTween:ResetToBeginning()
  REF.NodeLabel.UIPlayTween:Play(true)
  REF.EffectOpen.EffectGenerator:Play(function()
    WU.SetActive(REF.ButtonFinish, true)
  end)
  REF.LabelUnlock.UILabel.text = WU.GetString("UnlockType_" .. m_unlockWin)
  WU.SetActive(REF.EffectFly, false)
  m_startFly = false
  REF.EffectFly.transform.localPosition = CS.UnityEngine.Vector3.zero
  if m_city ~= nil then
    local starPos = REF.EffectFly.transform.position
    m_targetX = _ENV["$"](m_city)[m_targetName].transform.position.x
    m_targetY = _ENV["$"](m_city)[m_targetName].transform.position.y
    m_speedX = math.abs(m_targetX - starPos.x) / m_flyTime
    m_speedY = math.abs(m_targetY - starPos.y) / m_flyTime
  end
end

function UpdateWindow()
  if m_startFly == true then
    local starPos = REF.EffectFly.transform.position
    REF.EffectFly.gameObject:SetActive(true)
    if starPos.x < m_targetX then
      REF.EffectFly.transform.position = REF.EffectFly.transform.position + CS.UnityEngine.Vector3(m_speedX * CS.GameTime.deltaTime, 0, 0)
    else
      REF.EffectFly.transform.position = REF.EffectFly.transform.position + CS.UnityEngine.Vector3(-m_speedX * CS.GameTime.deltaTime, 0, 0)
    end
    if starPos.y < m_targetY then
      REF.EffectFly.transform.position = REF.EffectFly.transform.position + CS.UnityEngine.Vector3(0, m_speedY * CS.GameTime.deltaTime, 0)
    else
      REF.EffectFly.transform.position = REF.EffectFly.transform.position + CS.UnityEngine.Vector3(0, -m_speedY * CS.GameTime.deltaTime, 0)
    end
  end
  if REF.IconOpen ~= nil and REF.IconClose and not m_setOnce then
    m_texture = WU.AcquireAsset("Texture/NewFunction/UnlockType_" .. m_unlockWin)
    REF.IconOpen.MeshRenderer.material:SetTexture("_MainTex", m_texture)
    REF.IconClose.MeshRenderer.material:SetTexture("_MainTex", m_texture)
    m_setOnce = true
  end
end
