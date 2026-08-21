local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local mIsClose = false
local mScrollView
local mLastClipOffset = 10000000
local m_novelData, m_gameData
local m_showIdOrder = {
  17,
  8,
  23,
  11,
  15,
  7,
  3,
  1,
  24,
  20,
  13,
  12,
  2,
  6,
  25,
  9,
  10,
  18,
  4,
  19,
  21,
  14,
  5,
  16,
  22,
  999
}
local m_startPos = 0
local m_isStop = false

function SetupWindow()
  WU.BindButtonEvent(REF.Close, OnUIClose)
  WU.BindButtonEvent(REF.TouchArea, OnClickContent)
  mScrollView = REF.ScrollView
  LU.Bind(REF.WrapContentNovels, {
    updateRow = UpdateNovelInfo
  })
  LU.Bind(REF.Credits, {
    updateRow = UpdateCreditInfo
  })
end

function InitWindow()
  WU.ToggleRendering(REF.FadeOut, false)
  REF.Close.gameObject:SetActive(false)
  mIsClose = false
  mLastClipOffset = 10000000
  m_isStop = true
  m_novelData = PB.all("NovelCredits")
  m_gameData = PB.all("GameCredits")
  LU.Set(REF.WrapContentNovels, #m_novelData)
  LU.Set(REF.Credits, #m_gameData)
  m_startPos = REF.WrapContentNovels.transform.localPosition.y - #m_novelData * REF.WrapContentNovels.UIWrapContent.itemSize
  REF.Credits.transform.localPosition = {
    x = 0,
    y = m_startPos,
    z = 0
  }
  m_startPos = m_startPos - #m_gameData * REF.Credits.UIWrapContent.itemSize - 250
  REF.OtherInfo.transform.localPosition = {
    x = 0,
    y = m_startPos,
    z = 0
  }
  PlayLineByLineEffect()
end

function PlayLineByLineEffect()
  this:DelayInvokeInFrames(1, function()
    REF.ScrollView.UIScrollView:ResetPosition()
    m_isStop = false
  end)
end

function UpdateNovelInfo(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_novelData and realIndex < #m_novelData then
    local id = m_showIdOrder[realIndex + 1]
    local _, novelInfo = table.find(m_novelData, function(k, v)
      return v.id == id
    end)
    if novelInfo then
      rowRef["$$SetUI"](novelInfo)
    end
  end
end

function UpdateCreditInfo(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_gameData and realIndex < #m_gameData then
    local creditInfo = m_gameData[realIndex + 1]
    if creditInfo then
      rowRef.cLeft.UIHtmlLabel.text = creditInfo.cDepartment or ""
      rowRef.eLeft.UIHtmlLabel.text = creditInfo.eDepartment or ""
      rowRef.cRight1.UIHtmlLabel.text = creditInfo.cName or ""
      rowRef.eRight.UIHtmlLabel.text = creditInfo.eName or ""
    end
    rowRef.cRight2.gameObject:SetActive(false)
  end
end

function UpdateWindow(deltaTime)
  if mIsClose or m_isStop then
    return
  end
  local clipOffsetY = mScrollView.UIScrollView.panel.clipOffset.y
  if mLastClipOffset == clipOffsetY then
    this:DelayInvokeInSeconds(1, OnUIClose)
    return
  else
    mLastClipOffset = clipOffsetY
  end
  local velocity = PB.all("Misc"):first().CreditsListScrollVelocity * -1 * deltaTime
  REF.ScrollView.UIScrollView:Scroll(velocity)
end

function OnClickContent()
  m_isStop = not m_isStop
  REF.Close.gameObject:SetActive(m_isStop)
  if m_isStop then
    CS.SoundManager.Instance:PauseMusic()
  else
    CS.SoundManager.Instance:PlayMusic()
  end
end

function OnUIClose()
  WU.RecordButtonClick(1001370260)
  if mIsClose then
    return
  end
  mIsClose = true
  WU.ToggleRendering(REF.FadeOut, true)
  local effect = REF.FadeOut.EffectGenerator
  effect:Play(function()
    WU.RecycleWindow(this)
  end)
end
