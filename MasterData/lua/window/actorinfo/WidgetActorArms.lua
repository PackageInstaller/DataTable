local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local m_misc
local m_storyCnt = 3
local m_actor, m_arm
local m_nameScale = 0.7
local m_porSetting = PB.enum.WeaponPicSituationType.ActorInfo
local m_contentGroups = {}
local m_tabGroups = {}

function Awake()
  m_contentGroups = {}
  m_tabGroups = {}
  WU.TraverseChildren(REF.TabGridArm, function(go, index)
    local gasket = _ENV["$"](go).root
    local key = string.sub(gasket.name, string.len("Tab") + 1)
    table.insert(m_tabGroups, gasket)
    table.insert(m_contentGroups, REF["Content" .. key])
    WU.BindButtonEvent(gasket, function()
      HightLightTab(key)
    end)
  end)
end

function Start()
  WU.BindButtonEvent(REF.ButtonAddArm, OpenBag)
  WU.BindButtonEvent(REF.ButtonArmChange, OpenBag)
  WU.BindButtonEvent(REF.ButtonArmEnhance, function()
    WU.SetClickB4(REF.ArmEnhanceTip)
    WU.AcquireWindowAsync("ArmEnhance", function(window)
      _ENV["$"](window)["$$SetContent"](AU.GetArmByActor(m_actor))
    end)
  end)
  WU.BindButtonEvent(REF.ButtonPrpr, function()
    WU.AcquireWindowAsync("CollectionsActorPicture", function(window)
      _ENV["$"](window)["$$SetArmPic"](AU.GetArmByActor(m_actor))
    end)
  end)
  WU.BindButtonEvent(REF.ButtonPortraitChange, function()
    if m_arm.phase < m_arm.maxPhase then
      return
    end
    local changeTo = fif(m_arm.cardSkinIndex == 0, 1, 0)
    this:GameRequest(string.format("fci/unique-weapon/%s/skin/%s", m_arm.id, changeTo)):Post(nil, function(resp)
      DBH.ResChange(resp.resChange)
      WU.SetClickB4(REF.ArmChangeTip)
      this:SetData("ActorInfo/CurrentActor", this:GetData("ActorInfo/CurrentActor"))
      REF.EffectSkinChange.EffectGenerator:Play()
    end)
  end)
end

function OnEnable()
  WU.SetActive(REF.ContentArm, true)
  WU.SetActive(REF.ContentEmpty, true)
  this:Bind("NavigationContext", ResetContentPos)
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnDisable()
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    m_misc = PB.all("Misc"):first().weaponMisc
    local hasArm = m_actor.uniqueWeaponId and m_actor.uniqueWeaponId ~= 0
    WU.SetActive(REF.ContentArm, hasArm)
    WU.SetActive(REF.ContentEmpty, not hasArm)
    if hasArm then
      m_arm = AU.GetArmByActor(m_actor)
      if m_arm == nil then
        return
      end
      local armId = m_actor.uniqueWeaponId
      local tagName = "impression_button_" .. fif(m_arm.cardSkinIndex == 0, "initial", "max")
      REF.ButtonPortraitChange.UISprite.spriteName = tagName
      WU.SetLabel(REF.LabelLevel, "Lv." .. m_arm.level)
      WU.ActiveByNeverClick(REF.ArmChangeTip)
      WU.ActiveByNeverClick(REF.ArmEnhanceTip)
      REF.ButtonPortraitChange.gameObject:SetActive(m_arm.phase >= m_arm.maxPhase)
      WU.SetLabel(REF.LabelSkillName, WU.GetString("UniqueWeaponSkillName_" .. m_arm.id))
      WU.SetLabel(REF.LabelSkill, SE.GetWeaponSkillDesc(m_arm.id, m_arm.phase))
      WU.SetLabel(REF.LabelCultivation, WU.GetString("Sort_ActorCultivation") .. ": " .. m_arm.cultivation)
      REF.NodePassive.gameObject:SetActive(m_arm.currentSkill.costWP == 0)
      REF.NodeNotPassive.gameObject:SetActive(m_arm.currentSkill.costWP ~= 0)
      WU.SetLabel(REF.LabelCostUseCount, m_arm.currentSkill.costUseCount)
      WU.SetLabel(REF.LabelCostWp, m_arm.currentSkill.costWP)
      WU.ModifyWeaponPortrait(REF.TextureArm, armId, m_porSetting, this.name, m_arm.cardSkinIndex)
      WU.ModifyWeaponName(REF.NodeName, armId, m_nameScale, m_arm.quality - 2, true)
      for i = 0, #REF.NodeArmStar - 1 do
        local slotRef = REF.NodeArmStar[i]
        slotRef.root.UISprite.spriteName = "impression_star_m" .. fif(m_arm.phase < i + 1, "_dark", "")
      end
      RenderAttr(m_arm.baseAttrs)
      RenderStory(m_arm)
      UpdateProcess(m_arm)
      HightLightTab("ArmSummary")
    end
  end
end

function RenderAttr(attrs)
  local cnt = 0
  local attrPerLine = 2
  local attrString = "<l width=100% valign=center>"
  for k, v in pairs(attrs) do
    if cnt % attrPerLine == 0 and cnt ~= 0 then
      attrString = attrString .. "</l>" .. HU.HtmlSplitLine("Common.Line_dark") .. "<l width=100% valign=center>"
    end
    if cnt % attrPerLine == 0 then
      local icon = "<img src='ActorUI.attr_type_" .. v.attr.type .. "'/>&nbsp;&nbsp;"
      attrString = attrString .. "<c width=38% align=left>" .. icon .. WU.GetString("Window_ActorAttrName_" .. v.attr.type) .. "</c>"
      attrString = attrString .. "<c width=16% align=left>" .. v.attr.value .. "</c>"
    else
      local icon = "<img src='ActorUI.attr_type_" .. v.attr.type .. "'/>&nbsp;&nbsp;"
      attrString = attrString .. "<c width=19% align=left>" .. icon .. WU.GetString("Window_ActorAttrName_" .. v.attr.type) .. "</c>"
      attrString = attrString .. "<c width=26% align=right>" .. v.attr.value .. "</c>"
    end
    cnt = cnt + 1
  end
  REF.LabelAttributes.UIHtmlLabel.text = attrString .. "</l>"
end

function RenderStory(arm)
  local unlockCnt = 0
  local level = arm.speAttr[1].level
  local story = m_misc.weaponLevelToStory
  
  local function ManageAnchor(ref, gbTarget, param)
    ref.root.UIWidget:SetAnchor(gbTarget.gameObject, param[1], param[2], param[3], param[4])
    ref.root.UIWidget.bottomAnchor.relative = 0
    ref.root.UIWidget.topAnchor.relative = 0
    ref.root.UIWidget.leftAnchor.relative = 0
    ref.root.UIWidget.rightAnchor.relative = 0
    ref.root.UIWidget:UpdateAnchors()
  end
  
  for i = 1, m_storyCnt do
    if REF["NodeUnlock" .. i] then
      if level >= story[i] then
        unlockCnt = unlockCnt + 1
      end
      REF["NodeUnlock" .. i].gameObject:SetActive(level >= story[i])
      local ref = _ENV["$"](REF["NodeUnlock" .. i])
      WU.SetLabel(ref.LabelStory, WU.GetString("UniqueWeapon_Story_" .. arm.id .. "_" .. i))
      WU.SetLabel(ref.LabelTitle, "<img src='ActorRelation.impression_title_1'/>" .. WU.GetString("UniqueWeapon_StoryTitle_" .. arm.id .. "_" .. i))
      if 1 < i then
        local param = {
          619,
          -393,
          30,
          -293
        }
        ManageAnchor(ref, _ENV["$"](REF["NodeUnlock" .. i - 1]).LabelStory, param)
      end
    end
    if REF["NodeLock" .. i] then
      REF["NodeLock" .. i].gameObject:SetActive(level < story[i])
      local lockRef = _ENV["$"](REF["NodeLock" .. i])
      local starStr = ""
      WU.SetLabel(lockRef.LabelStar, WU.GetString("UniqueWeapon_StoryTitle_" .. arm.id .. "_" .. i))
      WU.SetLabel(lockRef.LabelNextStory, WU.GetString("UniqueWeapon_StoryUnlockContent", story[i]))
      if REF["NodeUnlock" .. i - 1] then
        if i == unlockCnt + 1 then
          local param = {
            660,
            0,
            0,
            -16
          }
          ManageAnchor(lockRef, _ENV["$"](REF["NodeUnlock" .. i - 1]).LabelStory, param)
        elseif REF["NodeLock" .. i - 1] then
          local param = {
            0,
            0,
            0,
            -352
          }
          ManageAnchor(lockRef, REF["NodeLock" .. i - 1], param)
        end
      end
    end
  end
end

function UpdateProcess(arm)
  local process = SE.GetWeaponProcess(m_arm.id)
  WU.TraverseChildren(REF.ContentProcess, function(go, index)
    local gasket = _ENV["$"](go).root
    local realIndex = index + 1
    local pro = process[realIndex + 1]
    if pro then
      gasket.gameObject:SetActive(true)
      WU.SetLabel(_ENV["$"](go).LabelDescPro, pro)
      WU.SetLabel(_ENV["$"](go).LabelPreDescPro, "<img src='ActorRelation.impression_star_m" .. fif(realIndex <= m_arm.phase, "", "_dark") .. "' height = 50%  width = 50%/>" .. WU.GetString("UniqueWeapon_Process") .. realIndex)
    else
      gasket.gameObject:SetActive(false)
    end
  end)
end

function HightLightTab(name)
  local gasket = REF["Tab" .. name]
  for k, v in pairs(m_contentGroups) do
    v.gameObject:SetActive(false)
  end
  for k, v in pairs(m_tabGroups) do
    v.UISprite.color = CS.NGUIMath.HexToColor(4294967295)
  end
  gasket.UISprite.color = CS.NGUIMath.HexToColor(4293020415)
  REF["Content" .. name].gameObject:SetActive(true)
  ResetContentPos()
end

function OpenBag()
  local arms = this:GetData("fci/arms/")
  local armInKind = {}
  for k, v in pairs(arms) do
    if v.position == m_actor.kind then
      table.insert(armInKind, v)
    end
  end
  if armInKind and 0 < #armInKind then
    WU.AcquireWindowAsync("ArmBag")
  else
    WU.ShowHintText(WU.GetString("UniqueWeapon_NoArmToEquip"))
  end
end

function ResetContentPos()
  REF.DetailScrollView.UIScrollView:ResetPosition()
  REF.StoryScrollView.UIScrollView:ResetPosition()
end
