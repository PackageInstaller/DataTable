local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_leaveEffectName
local m_showDuration = 1
local m_closeDuration = 1
local m_closing = false
local m_showing = false
local m_time = 0
local m_callback
local m_hold = false
local m_labelRef, m_contentRef, m_titleRef, m_titleRef2

function SetupWindow()
  REF.NodeMask["$SetCallback"](OnClose)
  m_labelRef = REF.LabelHint
  m_contentRef = REF.Content
  m_titleRef = REF.LabelTitle
  m_titleRef2 = REF.LabelTitle2
end

function UpdateWindow()
  if not m_showing and not m_closing then
    return
  end
  m_time = m_time + CS.GameTime.unscaledDeltaTime
  if m_showing then
    if m_time >= m_showDuration and not m_hold then
      m_showing = false
      m_time = 0
      OnClose()
    end
  elseif m_closing and (m_time >= m_closeDuration or m_hold) then
    m_closing = false
    WU.RecycleWindow(this)
    if m_callback then
      m_callback()
    end
  end
end

function OnClose()
  if m_closing then
    return
  end
  m_time = 0
  ShowEffect(m_closing, m_leaveEffectName)
  REF.LeftRightEffect.gameObject:SetActive(false)
  m_closing = true
  m_showing = false
  if m_labelRef then
    m_labelRef.gameObject:SetActive(false)
  end
  if m_contentRef then
    m_contentRef.gameObject:SetActive(false)
  end
  if m_titleRef then
    m_titleRef.gameObject:SetActive(false)
  end
  if m_titleRef2 then
    m_titleRef2.gameObject:SetActive(false)
  end
  m_closeDuration = REF.EffectBG.EffectGenerator.Duration
end

function ShowHintText(hintString, duration)
  if duration ~= nil then
    m_showDuration = duration
  else
    m_showDuration = 1
  end
  REF.LeftRightEffect.gameObject:SetActive(false)
  m_labelRef.gameObject:SetActive(true)
  m_labelRef.UIHtmlLabel.text = hintString
  m_leaveEffectName = "UI_panle_bg_smallB"
  m_time = 0
  ShowEffect(m_showing, "UI_panle_bg_smallA")
  m_showing = true
  m_closing = false
  this:BroadcastGameEvent("BroadShowHintText")
end

function ShowHintIcon(items, callback, durationTime, bSkinExchange, armDecompose)
  m_callback = callback
  m_showDuration = durationTime or 2
  m_contentRef.gameObject:SetActive(true)
  m_titleRef.gameObject:SetActive(bSkinExchange)
  m_titleRef2.gameObject:SetActive(armDecompose)
  m_leaveEffectName = "UI_panle_bg_middleB"
  for i = 0, #m_contentRef - 1 do
    local widget = m_contentRef[i]
    local item = items[i + 1]
    widget["$gameObject"]:SetActive(item ~= nil)
    if item ~= nil then
      local count = item.count
      if item.countDelta and 0 < item.countDelta then
        count = item.countDelta
      end
      if item.type == PB.enum.ResourceType.ResActor then
        widget["$$SetActorCustom"]({
          id = item.id,
          quality = item.quality
        })
      elseif item.type == PB.enum.ResourceType.ResUniqueWeapon then
        local custom = {
          hideLevel = true,
          showEquip = false,
          phase = 1,
          showStar = false,
          isPreview = true
        }
        widget["$$SetData"](item.type, item.id, item.count, "S")
        widget["$$ShowCustom"](custom)
      else
        widget["$$SetData"](item.type, item.id, count)
      end
      widget["$$SetOwnerBox"](item.ownerBoxId)
    end
  end
  m_contentRef.UIGrid:Reposition()
  m_contentRef.UIPlayTween:Play(true)
  m_time = 0
  ShowEffect(m_showing, "UI_panle_bg_middleA")
  REF.LeftRightEffect.gameObject:SetActive(true)
  m_showing = true
  m_closing = false
end

function ShowEffect(showing, effectName)
  if not showing then
    REF.EffectBG.EffectGenerator.m_EffectName = effectName
    REF.EffectBG.EffectGenerator:Reset()
  end
end
