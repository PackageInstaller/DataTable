local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local Vector2 = CS.UnityEngine.Vector2
local mComboText, mComboNum1, mComboNum2, mComboNum3
local mComboAnimState = 0
local mBaseSize, mRunSize, mBaseSize2, mRunSize2
local mMaxComboCount = 0
local mActorComboCount = 0
local mActorComboTime = 0
local mActorComboDelay = 3.0

function Awake()
  mComboText = REF.combo_text.UISprite
  mComboNum1 = REF.combo_1.UISprite
  mComboNum2 = REF.combo_2.UISprite
  mComboNum3 = REF.combo_3.UISprite
  mBaseSize = Vector2(mComboNum1.width, mComboNum1.height)
  mRunSize = mBaseSize
  mBaseSize2 = Vector2(mComboText.width, mComboText.height)
  mRunSize2 = mBaseSize2
end

function Start()
  this:RegisterGameEvent("FightUI_Combo", addCombo)
  setComboVisible(false)
end

function Update(delta)
  updateCombo(delta)
end

function addCombo(count)
  mActorComboCount = mActorComboCount + count
  if 999 < mActorComboCount then
    mActorComboCount = 999
  end
  if mActorComboCount > mMaxComboCount then
    mMaxComboCount = mActorComboCount
  end
  mActorComboTime = mActorComboDelay
  local index1 = mActorComboCount // 100
  local index2 = mActorComboCount % 100 // 10
  local index3 = mActorComboCount % 100 % 10
  setComboVisible(true)
  if 100 <= mActorComboCount then
    mComboNum1.spriteName = "hits_" .. index1
    mComboNum2.spriteName = "hits_" .. index2
    mComboNum3.spriteName = "hits_" .. index3
  elseif 10 <= mActorComboCount then
    mComboNum1.spriteName = "hits_" .. index2
    mComboNum2.spriteName = "hits_" .. index3
    mComboNum3.spriteName = ""
  else
    mComboNum1.spriteName = "hits_" .. index3
    mComboNum2.spriteName = ""
    mComboNum3.spriteName = ""
  end
end

function updateCombo(delta)
  if mActorComboTime ~= 0 then
    mActorComboTime = mActorComboTime - delta
    if mActorComboTime < 0 then
      mActorComboTime = 0
      mActorComboCount = 0
      setComboVisible(false)
    end
    local alpha = mActorComboTime / mActorComboDelay
    CS.UIWindowHelp.ChangeUIWidgetAlpha(mComboText, alpha)
    CS.UIWindowHelp.ChangeUIWidgetAlpha(mComboNum1, alpha)
    CS.UIWindowHelp.ChangeUIWidgetAlpha(mComboNum2, alpha)
    CS.UIWindowHelp.ChangeUIWidgetAlpha(mComboNum3, alpha)
  end
  if mComboAnimState == 1 then
    mRunSize = Vector2.Lerp(mRunSize, mBaseSize * 1.5, delta * 18.0)
    mRunSize2 = Vector2.Lerp(mRunSize2, mBaseSize2 * 1.5, delta * 18.0)
    if Vector2.Distance(mRunSize, mBaseSize * 1.5) <= 2.0 then
      mComboAnimState = 2
    end
  end
  if mComboAnimState == 2 then
    mRunSize = Vector2.Lerp(mRunSize, mBaseSize, delta * 10.0)
    mRunSize2 = Vector2.Lerp(mRunSize2, mBaseSize2, delta * 10.0)
    if Vector2.Distance(mRunSize, mBaseSize) <= 2.0 then
      mComboAnimState = 0
    end
  end
  if mComboAnimState ~= 0 then
    mComboNum1.width = math.floor(mRunSize.x)
    mComboNum1.height = math.floor(mRunSize.y)
    mComboNum2.width = math.floor(mRunSize.x)
    mComboNum2.height = math.floor(mRunSize.y)
    mComboNum3.width = math.floor(mRunSize.x)
    mComboNum3.height = math.floor(mRunSize.y)
    mComboText.width = math.floor(mRunSize2.x)
    mComboText.height = math.floor(mRunSize2.y)
  end
end

function setComboVisible(val)
  WU.ToggleRendering(mComboText, val)
  WU.ToggleRendering(mComboNum1, val)
  WU.ToggleRendering(mComboNum2, val)
  WU.ToggleRendering(mComboNum3, val)
end
