local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_callback, m_inbox

function SetupWindow()
  LU.Bind(REF.WrapContentMaterial, {
    updateRow = OnMaterialShow
  })
  WU.BindButtonEvent(REF.Black, function()
    REF.EffectOpen.gameObject:SetActive(false)
    REF.EffectLabelOpen.gameObject:SetActive(false)
    REF.ContentResult.gameObject:SetActive(false)
    REF.Black.BoxCollider2D.enabled = false
    REF.EffectLabelClose.EffectGenerator:Play()
    REF.EffectClose.EffectGenerator:Play()
    this:DelayInvokeInSeconds(0.6, function()
      if m_callback then
        m_callback()
        m_callback = nil
      end
      WU.RecycleWindow(this)
    end)
  end)
end

function SetContent(arm, inboxOrArm, callback)
  REF.ContentResult.gameObject:SetActive(true)
  REF.EffectOpen.gameObject:SetActive(true)
  REF.EffectLabelOpen.gameObject:SetActive(true)
  REF.Black.BoxCollider2D.enabled = false
  local show2Arms = #inboxOrArm <= 0
  REF.Arm1["$SetArm"](arm, "S")
  REF.Arm1["$ShowCustom"]({
    hideLevel = true,
    showStar = false,
    hideNew = true
  })
  REF.NodeArm.gameObject:SetActive(show2Arms)
  REF.NodeMaterial.gameObject:SetActive(not show2Arms)
  if show2Arms then
    REF.Arm2["$SetArm"](inboxOrArm)
    REF.Arm2["$ShowCustom"]({hideNew = true})
  else
    m_inbox = inboxOrArm
    LU.Set(REF.WrapContentMaterial, #m_inbox, true)
    REF.ScrollViewMaterial.UIScrollView:ResetPosition()
  end
  m_callback = callback
  REF["$Animator"]:Play("Open", -1, 0)
  REF.EffectLabelOpen.EffectGenerator:Play()
  REF.EffectOpen.EffectGenerator:Play(function()
    REF.Black.BoxCollider2D.enabled = true
  end)
end

function OnMaterialShow(rowRef, wrapIndex, realIndex)
  if m_inbox and realIndex < #m_inbox then
    local item = m_inbox[realIndex + 1].baseRes
    rowRef["$$SetData"](item.type, item.id, item.countDelta)
    rowRef["$$SetClickCallback"](function()
      WU.ShowResourceDetail(item.type, item.id)
    end)
  end
end

function UninitWindow()
end
