local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local HU = require("Common/HtmlUtil")
local GotoUtil = require("Common/GotoUtil")
local DBH = require("Manager/DataBindingHandler")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local m_curArm
local m_repeatedContext = {}
local m_contextData, m_isFakeContent
local m_attrShow = false
local m_heightAttr = 426
local m_heightOther = 514

function SetupWindow()
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        m_attrShow = REF.TabAttrs.UIToggle.value
        REF.ButtonEnhance.gameObject:SetActive(m_attrShow and not m_isFakeContent)
        REF.DetailScrollView.UIScrollView:ResetPosition()
        ChangeScrollView(m_attrShow)
      end
    end)
  end)
  WU.BindButtonEvent(REF.ButtonEnhance, function()
    WU.AcquireWindowAsync("ArmEnhance", function(window)
      _ENV["$"](window)["$$SetContent"](m_curArm)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "ArmDetail",
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    this:SetData("Share/ArmDetail", m_curArm)
    WU.AcquireWindowAsync("Share")
  end)
  WU.BindButtonEvent(REF.ButtonEquipped, function()
    this:SetData("Actor/SelectedUid", m_curArm.actorUid)
    WU.AcquireWindowAsync("ActorInfo", function(window)
      _ENV["$"](window)["$$SetSelectedTab"]("TabArm")
    end)
  end)
  LU.Bind(REF.WrapContentAttrs, {
    updateRow = UpdateAttrs
  })
end

function SetContent(content, custom)
  if custom and custom.fake == true then
    m_isFakeContent = true
    SetArmContent(content, custom)
  else
    this:Bind("fci/arms/" .. content.id, function(result)
      m_isFakeContent = false
      SetArmContent(result, custom)
    end)
  end
end

function SetArmContent(result, custom)
  if result == nil then
    return
  end
  m_contextData = {result, custom}
  REF.ButtonEnhance.gameObject:SetActive(true)
  m_curArm = result
  custom = custom or {}
  custom.hideNew = true
  LU.Set(REF.WrapContentAttrs, 0)
  local starStr = ""
  for i = 1, m_curArm.maxPhase do
    starStr = starStr .. "<img src='ActorRelation.impression_star_m" .. fif(i <= m_curArm.phase, "", "_dark") .. "'/>" .. "&nbsp;"
  end
  WU.SetLabel(REF.LabelStar, starStr)
  WU.SetLabel(REF.LabelPos, WU.GetString("UniqueWeapon_Pos" .. m_curArm.position))
  WU.SetLabel(REF.LabelName, m_curArm.name)
  WU.SetLabel(REF.LabelArtist, WU.GetString("UniqueWeapon_ArtistPrefix") .. m_curArm.Artist)
  if m_curArm.cultivation then
    WU.SetLabel(REF.LabelCultivation, WU.GetString("Sort_ActorCultivation") .. ": " .. m_curArm.cultivation)
  else
    WU.SetLabel(REF.LabelCultivation, "")
  end
  REF.WidgetIconSlot["$SetArm"](m_curArm)
  REF.WidgetIconSlot["$ShowCustom"](custom)
  local hasEquipped = m_curArm.actorUid ~= nil and m_curArm.actorUid ~= 0
  if hasEquipped then
    if custom.hideEquip or custom.isPreview then
      WU.SetActive(REF.ButtonEquipped, false)
    else
      WU.SetActive(REF.ButtonEquipped, true)
      REF.SpriteActorIcon.UISprite.spriteName = "actor_head_" .. m_curArm.actorId .. "a"
    end
  else
    WU.SetActive(REF.ButtonEquipped, false)
  end
  WU.SetActive(REF.ButtonEnhance, not m_isFakeContent)
  WU.SetActive(REF.ButtonShare, not custom.isPreview)
  WU.SetActive(REF.ButtonPrPr, not custom.isPreview)
  WU.ClearButtonEvent(REF.ButtonPrPr)
  WU.BindButtonEvent(REF.ButtonPrPr, function()
    WU.AcquireWindowAsync("CollectionsActorPicture", function(window)
      _ENV["$"](window)["$$SetArmPic"](m_curArm, custom)
    end)
  end)
  WU.SetLabel(REF.LabelStory, WU.GetString("UniqueWeapon_Story_" .. m_curArm.id .. "_short"))
  LU.Set(REF.WrapContentAttrs, #m_curArm.baseAttrs)
  UpdateProcess()
  SetSkill()
  REF.TabAttrs.UIToggle.value = true
end

function SaveContext(context)
  table.insert(m_repeatedContext, m_contextData)
  m_contextData = {}
end

function LoadContext(context)
  if 0 < #m_repeatedContext then
    local data = m_repeatedContext[#m_repeatedContext]
    REF["$Animator"]:Play("Open", -1, 0)
    SetArmContent(data[1], data[2])
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function UpdateAttrs(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_curArm == nil or realIndex >= #m_curArm.baseAttrs then
    return
  end
  local ref = _ENV["$"](rowRef.root)
  local attr = m_curArm.baseAttrs[realIndex + 1].attr
  ref.LabelType.UIHtmlLabel.text = WU.GetString("Window_ActorAttrName_" .. attr.type)
  ref.LabelValue.UIHtmlLabel.text = attr.value
  ref.SpriteIcon.UISprite.spriteName = "attr_type_" .. attr.type
end

function UpdateProcess()
  local process = SE.GetWeaponProcess(m_curArm.id)
  WU.TraverseChildren(REF.ContentProcess, function(go, index)
    local gasket = _ENV["$"](go).root
    local realIndex = index + 1
    local pro = process[realIndex + 1]
    if pro then
      gasket.gameObject:SetActive(true)
      WU.SetLabel(_ENV["$"](go).LabelDescPro, pro)
      WU.SetLabel(_ENV["$"](go).LabelPreDescPro, "<img src='ActorRelation.impression_star_m" .. fif(realIndex <= m_curArm.phase, "", "_dark") .. "' height = 50%  width = 50%/>" .. WU.GetString("UniqueWeapon_Process") .. realIndex)
    else
      gasket.gameObject:SetActive(false)
    end
  end)
end

function SetSkill()
  REF.NodePassive.gameObject:SetActive(m_curArm.currentSkill.costWP == 0)
  REF.NodeNotPassive.gameObject:SetActive(m_curArm.currentSkill.costWP ~= 0)
  WU.SetLabel(REF.LabelCostUseCount, m_curArm.currentSkill.costUseCount)
  WU.SetLabel(REF.LabelCostWp, m_curArm.currentSkill.costWP)
  WU.SetLabel(REF.LabelSkillName, WU.GetString("UniqueWeaponSkillName_" .. m_curArm.id))
  WU.SetLabel(REF.LabelSkill, SE.GetWeaponSkillDesc(m_curArm.id, m_curArm.phase))
end

function ChangeScrollView(short)
  local pos = REF.DragDetail.transform.localPosition
  local height = fif(short, m_heightAttr, m_heightOther)
  local y = fif(short, -39, -83)
  REF.DragDetail.UIWidget.height = height
  REF.DragDetail.transform.localPosition = CS.UnityEngine.Vector3(pos.x, y, 0)
end
