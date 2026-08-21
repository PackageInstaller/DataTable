local WU, DB, REF = require("Common/WindowUtil")(this)
local m_showTweenerGroup = 0
local m_hideTweenerGroup = 1
local m_visible, m_hideCallback

function Start()
  WU.BindButtonEvent(REF.Blocker, function(go)
    Hide()
  end)
end

function Show(hideCallback)
  if not m_visible then
    REF.Blocker.gameObject:SetActive(true)
    REF["$UIPlayTween"]:Finish()
    REF["$UIPlayTween"].tweenGroup = m_showTweenerGroup
    REF["$UIPlayTween"]:Play(true)
    m_hideCallback = hideCallback
    m_visible = true
  end
end

function Hide(instant)
  if m_visible or m_visible == nil then
    REF.Blocker.gameObject:SetActive(false)
    REF["$UIPlayTween"]:Finish()
    REF["$UIPlayTween"].tweenGroup = m_hideTweenerGroup
    REF["$UIPlayTween"]:Play(true)
    if instant then
      REF["$UIPlayTween"]:Finish()
    end
    if m_hideCallback then
      m_hideCallback()
      m_hideCallback = nil
    end
    m_visible = false
  end
end
