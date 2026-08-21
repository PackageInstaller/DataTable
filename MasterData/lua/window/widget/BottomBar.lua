local WU, DB, REF = require("Common/WindowUtil")(this)
local m_showTweenerGroup = 0
local m_hideTweenerGroup = 1
local m_uiPlayTween, m_status

function Start()
  m_uiPlayTween = REF["$UIPlayTween"]
end

function Show()
  if m_status == 1 then
    return
  end
  if m_uiPlayTween ~= nil then
    m_uiPlayTween:Finish()
    m_uiPlayTween.tweenGroup = m_showTweenerGroup
    m_uiPlayTween:Play(true)
  end
  m_status = 1
end

function Hide()
  if m_status == 0 then
    return
  end
  if m_uiPlayTween ~= nil then
    m_uiPlayTween:Finish()
    m_uiPlayTween.tweenGroup = m_hideTweenerGroup
    m_uiPlayTween:Play(true)
  end
  m_status = 0
end

function Reset()
  if m_uiPlayTween ~= nil then
    m_uiPlayTween:Finish()
  end
  m_status = 0
  REF.root.transform.localPosition = CS.UnityEngine.Vector3(0, -1000, 0)
end
