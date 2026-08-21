local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_callback, m_inbox, m_maxPhase
local m_nameScale = 0.8
local m_porSetting = PB.enum.WeaponPicSituationType.Wake

function SetupWindow()
  LU.Bind(REF.WrapContentMaterial, {
    updateRow = OnMaterialShow
  })
  WU.BindButtonEvent(REF.ButtonNext2, function()
    if m_callback then
      m_callback()
      m_callback = nil
    end
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  m_maxPhase = PB.all("Misc"):first().weaponMisc.weaponMaxPhase - 1
end

function SetContent(arm, inboxOrArm, callback)
  local show2Arms = #inboxOrArm <= 0
  REF.Arm1["$SetArm"](arm)
  REF.Arm1["$ShowCustom"]({hideNew = true})
  REF.NodeArm.gameObject:SetActive(show2Arms)
  REF.NodeMaterial.gameObject:SetActive(not show2Arms)
  REF.Panel1.gameObject:SetActive(true)
  REF.Panel2.gameObject:SetActive(false)
  REF.ButtonNext1.gameObject:SetActive(false)
  REF.ButtonNext2.gameObject:SetActive(false)
  if show2Arms then
    REF.Arm2["$SetArm"](inboxOrArm)
    REF.Arm2["$ShowCustom"]({hideNew = true})
  else
    m_inbox = inboxOrArm
    LU.Set(REF.WrapContentMaterial, #m_inbox)
  end
  local idx = fif(inboxOrArm.phase >= m_maxPhase, 1, 0)
  WU.ModifyWeaponPortrait(REF.TextureArmBig, arm.id, m_porSetting, this.name, idx)
  WU.ModifyWeaponName(REF.Bottom, inboxOrArm.id, m_nameScale)
  WU.SetLabel(REF.LabelCultivation, ": " .. string.format("%.0f", AU.GetCultivationDegreeArm(inboxOrArm)))
  m_callback = callback
  REF["$Animator"]:Play("OPEN", -1, 0)
  REF["Effect" .. inboxOrArm.phase].EffectGenerator:Reset()
  this:DelayInvokeInSeconds(1.7, function()
    REF.Panel1.gameObject:SetActive(false)
    REF.Panel2.gameObject:SetActive(true)
    REF.WakeFrame.EffectGenerator:Play()
    for i = 1, #REF.NodeStar do
      local name = fif(i <= inboxOrArm.phase, "impression_star_b", "impression_star_b_dark")
      REF["Sprite" .. i].UISprite.spriteName = name
    end
    REF["Effect" .. inboxOrArm.phase].EffectGenerator:Play()
    this:DelayInvokeInSeconds(0.5, function()
      REF.ButtonNext2.gameObject:SetActive(true)
    end)
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
