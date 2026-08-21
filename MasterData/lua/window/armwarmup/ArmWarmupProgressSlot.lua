local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local CO = require("Common/Coroutine")
local m_maxProgressId, m_progressInfo, m_roleDefaultPos, m_parentRef, m_curWidget, m_roleWarnRect, m_nextSlot, m_talkTweenShow, m_talkTweenHide, m_objectEffect, m_clickCallback
local TalkState = {
  None = -1,
  Hidden = 0,
  Showing = 1,
  Static = 2
}
local m_chapterTalks
local m_time = 0
local m_talkShowing = false
local m_talkState = TalkState.None
local m_talk
local m_warned = false

function Start()
  WU.BindButtonEvent(REF.root, OnClick)
  m_parentRef = _ENV["$"](REF.root.transform.parent)
  m_roleDefaultPos = REF.Role.transform.localPosition
  m_curWidget = REF.root.UIWidget
  local tweeners = REF.Talk.gameObject:GetComponents(typeof(CS.UITweener))
  m_talkTweenShow = fif(tweeners[0].tweenGroup == 1, tweeners[0], tweeners[1])
  m_talkTweenHide = fif(tweeners[0].tweenGroup == 2, tweeners[0], tweeners[1])
end

function Update(delta)
  if m_talkState == TalkState.None or not REF.Role.gameObject.activeSelf then
    return
  end
  local warn = CheckOverlap(m_roleWarnRect, false)
  if warn and not m_warned then
    REF.HtmlLabelTalk.UIHtmlLabel.text = WU.GetString("ArmWarmup_RoleBlocked")
    ShowTalk()
  elseif not warn and m_warned then
    if m_talkState == TalkState.Hidden then
      HideTalk()
    else
      REF.HtmlLabelTalk.UIHtmlLabel.text = WU.GetString(m_talk)
    end
  end
  m_warned = warn
  if warn then
    return
  end
  m_time = m_time + delta
  if m_talkState == TalkState.Hidden then
    if 6 < m_time then
      m_time = 0
      m_talkState = TalkState.Showing
      ShowTalk(m_chapterTalks[math.random(#m_chapterTalks)])
    end
  elseif m_talkState == TalkState.Showing and 3 < m_time then
    m_time = 0
    m_talkState = TalkState.Hidden
    HideTalk()
  end
end

function OnClick()
  if m_clickCallback ~= nil then
    m_clickCallback()
  end
end

function SetView(info, currentProgressId, maxProgressId, wrapIndex, roleWarnRect, clickCallback)
  m_roleWarnRect = roleWarnRect
  m_progressInfo = info
  m_maxProgressId = maxProgressId
  m_clickCallback = clickCallback
  local nextSlotIndex = fif(wrapIndex + 1 >= #m_parentRef.root, 0, wrapIndex + 1)
  m_nextSlot = m_parentRef.root[nextSlotIndex]
  m_chapterTalks = PB.get("WarmupChapterConfig", m_progressInfo.chapterId).talk
  local gridName, objectName
  m_objectEffect = nil
  if info.progressType == PB.enum.WarmupProgressType.Normal then
    gridName = "Impression/grid_normal"
  elseif info.progressType == PB.enum.WarmupProgressType.Reward then
    gridName = "Impression/grid_gift"
    objectName = "Impression/gift_icon"
    m_objectEffect = "UI_FightActivation_treasurebox"
  elseif info.progressType == PB.enum.WarmupProgressType.Story then
    gridName = "Impression/grid_story"
    objectName = "Impression/story_icon"
    m_objectEffect = "UI_FightActivation_photosphere"
  end
  REF.SpriteGrid.UISprite.spriteName = gridName
  REF.SpriteObject.UISprite.spriteName = objectName
  WU.SetActive(REF.SpriteStory, objectName ~= nil)
  WU.SetActive(REF.ObjectEffect, false)
  local showRole = m_progressInfo.progressId == currentProgressId and m_progressInfo.progressId ~= m_maxProgressId
  WU.SetActive(REF.Role, showRole)
  if showRole then
    REF.RoleEffect.EffectGenerator:Play()
    SetTalk()
    SetGridStatus(1)
  else
    SetGridStatus(0)
    WU.SetActive(REF.Talk, false)
    m_talkState = TalkState.None
  end
  SetObjectStatus(currentProgressId)
end

function Next()
  HideTalk()
  m_talkState = TalkState.None
  m_time = 0
  REF.RoleEffect.EffectGenerator.m_EffectName = "UI_AoliduoQ_Walk"
  REF.RoleEffect.EffectGenerator:Reset()
  REF.RoleEffect.EffectGenerator:Play()
  local pos = {
    x = m_roleDefaultPos.x,
    y = m_roleDefaultPos.y,
    z = 0
  }
  pos.x = pos.x + REF.root.UIWidget.width
  CS.TweenPosition.Begin(REF.Role.gameObject, 1.5, pos, false)
  CO.yield_return(CS.UnityEngine.WaitForSeconds(0.7))
  SetObjectStatus(m_progressInfo.progressId + 1)
  REF.Object.UIPlayTween:Play(true)
  SetGridStatus(2)
  m_nextSlot["$$SetGridStatus"](1)
  CO.yield_return(CS.UnityEngine.WaitForSeconds(0.9))
  REF.Role.transform.localPosition = m_roleDefaultPos
  WU.SetActive(REF.Role, false)
  REF.RoleEffect.EffectGenerator.m_EffectName = "UI_AoliduoQ_Idle"
  REF.RoleEffect.EffectGenerator:Reset()
  m_nextSlot["$$ToBeCurrent"]()
end

function SetGridStatus(status)
  local hasEffect = status ~= 0
  WU.SetActive(REF.SpriteGrid, not hasEffect)
  WU.SetActive(REF.GridEffect, hasEffect)
  if hasEffect then
    local effectName
    if m_progressInfo.progressType == PB.enum.WarmupProgressType.Normal then
      effectName = "UI_Grid_B" .. status
    elseif m_progressInfo.progressType == PB.enum.WarmupProgressType.Reward then
      effectName = "UI_Grid_A" .. status
    elseif m_progressInfo.progressType == PB.enum.WarmupProgressType.Story then
      effectName = "UI_Grid_C" .. status
    end
    local effect = REF.GridEffect.EffectGenerator
    effect.m_EffectName = effectName
    effect:Reset()
    effect:Play()
  end
end

function SetObjectStatus(currentProgressId)
  local passed = currentProgressId >= m_progressInfo.progressId
  local isCurrent = m_progressInfo.progressId == currentProgressId and m_progressInfo.progressId ~= m_maxProgressId
  REF.SpriteObject.UISprite.graify = passed
  WU.SetActive(REF.Object, not isCurrent)
  if passed then
    REF.ObjectTween.TweenPosition:FinishImmediately()
    REF.ObjectTween.TweenPosition.enabled = false
  else
    REF.ObjectTween.TweenPosition:PlayForward()
  end
end

function SetTalk()
  if m_progressInfo.talk ~= "" then
    m_talkState = TalkState.Static
    ShowTalk(m_progressInfo.talk)
  else
    WU.SetActive(REF.Talk, false)
    m_talkState = TalkState.Hidden
  end
end

function ShowTalk(talk)
  if talk ~= nil then
    m_talk = talk
    REF.HtmlLabelTalk.UIHtmlLabel.text = WU.GetString(talk)
  end
  WU.SetActive(REF.Talk, true)
  if not m_talkShowing then
    m_talkTweenHide:ResetToBeginning()
    m_talkTweenHide.enabled = false
    m_talkTweenShow:PlayForward()
    m_talkShowing = true
  end
end

function HideTalk()
  if m_talkShowing then
    m_talkTweenShow:ResetToBeginning()
    m_talkTweenShow.enabled = false
    m_talkTweenHide:PlayForward()
    m_talkShowing = false
  end
end

function ToBeCurrent()
  SetTalk()
  WU.SetActive(REF.Role, true)
  REF.RoleEffect.EffectGenerator:Play()
  WU.SetActive(REF.Object, false)
  if m_objectEffect ~= nil then
    WU.SetActive(REF.ObjectEffect, true)
    local effect = REF.ObjectEffect.EffectGenerator
    effect.m_EffectName = m_objectEffect
    effect:Reset()
    effect:Play(function()
      WU.SetActive(REF.ObjectEffect, false)
    end)
  end
end

function FinishChapter()
  if m_progressInfo.progressId == m_maxProgressId and REF.Role.gameObject.activeSelf then
    m_talkState = TalkState.None
    HideTalk()
    SetGridStatus(0)
    WU.SetActive(REF.Role, true)
    local effect = REF.RoleEffect.EffectGenerator
    effect.m_EffectName = "UI_FightActivation_Role"
    effect:Reset()
    effect:Play(function()
      WU.SetActive(REF.Role, false)
      effect.m_EffectName = "UI_AoliduoQ_Idle"
      effect:Reset()
      SetObjectStatus(m_progressInfo.progressId + 1)
      REF.Object.UIPlayTween:Play(true)
    end)
  end
end

function CheckOverlap(widget, isAllOverlay)
  if not REF.Role.gameObject.activeSelf then
    return false
  end
  local curCorners = m_curWidget.worldCorners
  local validCorners = widget.worldCorners
  local overlaped
  if REF.root.transform.position.x < widget.transform.position.x then
    if isAllOverlay then
      overlaped = curCorners[0].x > validCorners[0].x
    else
      overlaped = curCorners[3].x > validCorners[0].x
    end
  elseif isAllOverlay then
    overlaped = curCorners[3].x < validCorners[3].x
  else
    overlaped = curCorners[0].x < validCorners[3].x
  end
  return overlaped
end
