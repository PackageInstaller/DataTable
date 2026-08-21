local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local SE = require("Common/SkillEffect")
local m_actor
local m_materialEnough = false
local m_MaxStar = PB.all("Misc"):first().maxStarLevel
local m_StarPhases = PB.index("Misc", 1).starPhases
local m_previewStar, m_previewPhase

function Start()
  WU.BindButtonEvent(REF.ButtonUpgrade, OnUpgradeClick)
  for i = 0, #REF.NodePhaseButtons - 1 do
    WU.BindButtonEvent(REF.NodePhaseButtons[i].root, OnPhaseClick)
  end
end

function OnEnable()
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
  REF["$Animator"]:Play("Open", -1, 0)
  this:RegisterGameEvent("StarUpgradeWindowUninited", OnStarUpgradeWindowUninited)
end

function OnDisable()
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
  this:UnregisterGameEvent("StarUpgradeWindowUninited", OnStarUpgradeWindowUninited)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes
    REF.TextureActor.transform.localPosition = CS.UnityEngine.Vector3(actorConfig.portraitOffsetX, actorConfig.portraitOffsetY, 0)
    local canLevelup, isMax, requiredLevel = AU.StarLevelupValidateActor(m_actor)
    WU.SetActive(REF.NodeActor, isMax)
    WU.SetActive(REF.NodePhase, not isMax)
    WU.SetActive(REF.NodeMax, isMax)
    WU.SetActive(REF.NodePhaseButtons, not isMax)
    WU.SetActive(REF.NodeUpgrade, not isMax)
    if isMax then
      WU.SetActive(REF.NodeEffectAttr, false)
      WU.SetActive(REF.NodeEffectSkill, false)
      REF.LabelMaxAttrEffects.UIHtmlLabel.text = CreateMaxAttrString()
    else
      SetupPhase(m_actor.star, m_actor.curPhase)
      SetPhasePreview(AU.GetNextStarPhase(m_actor.star, m_actor.curPhase))
      for i = 0, #REF.NodeStars - 1 do
        REF.NodeStars[i].root.UISprite.spriteName = string.format("upgrade_star%s_%s", fif(m_actor.star == m_MaxStar, "_x", ""), fif(i < m_actor.star, "2", "1"))
      end
      REF.LabelCondition.UIHtmlLabel.text = fif(canLevelup, "", WU.GetString("Window_StarLevelupError_LevelLimit", requiredLevel))
    end
  end
end

function UpdateConsumption()
  SetConsumption(false)
end

function SetConsumption(reset)
  m_materialEnough = true
  if m_actor then
    local actorAttrStarPromotion = PB.get("ActorAttrStarPromotion", m_actor.id, m_previewStar, m_previewPhase)
    if actorAttrStarPromotion then
      local cost = _ENV["!"](actorAttrStarPromotion.starCost):where(function(k, v)
        return v.type == PB.enum.ResourceType.ResItem
      end):toarray()
      for i = 1, #REF.MaterialList do
        local materialtRef = REF.MaterialList[i - 1]
        local widgetRef = _ENV["$"](materialtRef.WidgetIconSlot)
        local isActive = i <= #cost
        WU.SetActive(materialtRef.root, isActive)
        if isActive then
          local starLevelupCost = cost[i]
          local stock = this:GetData("fci/item/" .. starLevelupCost.id).count
          if reset then
            widgetRef["@id"] = nil
            widgetRef["@stock"] = nil
          else
            local changeNum = stock - widgetRef["@stock"]
            if 0 < changeNum then
            end
          end
          widgetRef["@stock"] = stock
          local _, entry = PB.all("ResourceCompose"):find(function(_, v)
            return v.targetRes.id == starLevelupCost.id and v.targetRes.type == starLevelupCost.type and v.targetRes.count == 1
          end)
          local hasComposeMaterial = entry ~= nil
          local cost = starLevelupCost.count
          local stockString = tostring(stock)
          local costString = tostring(cost)
          if stock < cost then
            stockString = HU.ApplyFontColor(stockString, HU.ColorDefines.Error)
            m_materialEnough = false
          end
          local needCompose = hasComposeMaterial and stock < cost
          if needCompose then
            m_materialEnough = false
          end
          widgetRef["@id"] = starLevelupCost.id
          widgetRef["$$SetData"](PB.enum.ResourceType.ResItem, starLevelupCost.id)
          materialtRef.StackLabel.UIHtmlLabel.text = stockString .. "/" .. costString
          widgetRef["$$SetClickCallback"](function(go)
            WU.RecordButtonClick(_ENV["$"](go)["@id"])
            WU.ShowItemDetail(_ENV["$"](go)["@id"])
          end)
          if reset then
            this:Unbind("fci/item/" .. starLevelupCost.id, UpdateConsumption)
            this:Bind("fci/item/" .. starLevelupCost.id, UpdateConsumption, false)
          end
        end
      end
      REF.MaterialList.UIGrid:Reposition()
    else
      m_materialEnough = false
    end
  end
end

function SetupPhase(star, curPhase)
  local starPhases = m_StarPhases[star]
  for i = 0, #REF.NodePhaseButtons - 2 do
    WU.SetActive(REF.NodePhaseButtons[i].root, i < starPhases)
    REF.NodePhaseButtons[i].root.UISprite.spriteName = fif(curPhase <= i, "upgrade_stage_1", "upgrade_stage_2")
  end
  REF.NodePhaseButtons.UIGrid:Reposition()
  REF.SpriteLine.UISprite.width = 110 * starPhases
  local unlockSkillId = PB.get("ActorAttrStarPromotion", m_actor.id, star + 1, 0).unlockSkillId
  WU.SetActive(REF.SkillHint, 0 < unlockSkillId)
  if 0 < unlockSkillId then
    REF.LabelUnlockSkillHint.UILabel.text = WU.GetString("Window_EquipUnlock") .. WU.GetString("Window_bracket1", WU.GetString("SkillName_" .. unlockSkillId))
  end
end

function SetPhasePreview(star, phase)
  m_previewStar = star
  m_previewPhase = phase
  local unlockSkillId = PB.get("ActorAttrStarPromotion", m_actor.id, star, phase).unlockSkillId
  WU.SetActive(REF.NodeEffectAttr, unlockSkillId == 0)
  WU.SetActive(REF.NodeEffectSkill, unlockSkillId ~= 0)
  if unlockSkillId ~= 0 then
    local actorSkill = PB.get("ActorSkill", unlockSkillId)
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    local index = fif(actorConfig.kind == PB.enum.ActorType.Sub, actorSkill.resIndex + 2, actorSkill.resIndex)
    REF.TextureSkill.UITexture.mainTexturePath = "Texture/ActorSkillBig/actor_skill_" .. index
    REF.LabelSkillName.UILabel.text = WU.GetString("SkillName_" .. unlockSkillId)
    WU.SetActive(REF.LabelSkillName, star <= m_MaxStar)
    REF.LabelAttrEffects2.UIHtmlLabel.text = CreateStarEffectString(star, phase)
  else
    REF.LabelAttrEffects1.UIHtmlLabel.text = CreateStarEffectString(star, phase)
  end
  local nextStar, nextPhase = AU.GetNextStarPhase(m_actor.star, m_actor.curPhase)
  for i = 0, #REF.NodePhaseButtons - 1 do
    local starClicked, phaseClicked = GetStarPhaseByButton(REF.NodePhaseButtons[i].root.gameObject)
    WU.SetActive(REF.NodePhaseButtons[i].EffectSelected, star == starClicked and phase == phaseClicked)
  end
  REF.ButtonUpgrade.UIButton.isEnabled = star == nextStar and phase == nextPhase
  REF.LabelUpgrade.UILabel.text = WU.GetString(fif(phase == 0, "Window_ActorStarLevelup", "Window_ActorStarPhaseLevelup"))
  if phase == 0 then
    REF.LabelStarPreview.UILabel.text = WU.GetString("Window_ActorStar", star)
  else
    REF.LabelStarPreview.UILabel.text = WU.GetString("Window_ActorStarPhase", star, phase)
  end
  local canLevelup, _, requiredLevel = AU.StarLevelupValidate(m_actor, star, phase)
  REF.LabelCondition.UIHtmlLabel.text = fif(canLevelup, "", WU.GetString("Window_StarLevelupError_LevelLimit", requiredLevel))
  SetConsumption(true)
end

function CreateStarEffectString(star, phase)
  local oldAttrs = AU.GenActorStarPromotionsAccumulated(m_actor.id, m_actor.quality, m_actor.star, m_actor.curPhase)
  local newAttrs = AU.GenActorStarPromotionsAccumulated(m_actor.id, m_actor.quality, star, phase)
  local result = ""
  for _, attrType in ipairs(AU.ActorAttrIndices) do
    local newAttr = newAttrs[attrType]
    local oldAttr = oldAttrs[attrType]
    if newAttr then
      if oldAttr == nil then
        oldAttr = _ENV["!"](newAttr):duplicate()
        oldAttr.value = 0
      end
      if result ~= "" then
        result = result .. HU.HtmlSplitLine("Common.Line_dark2")
      end
      local icon = "<img src='ActorUI.attr_type_" .. attrType .. "'/>&nbsp;&nbsp;"
      result = result .. "<l width=100%><c width=30% align=left>" .. icon .. WU.GetString("Window_ActorAttrName_" .. attrType) .. "</c>"
      result = result .. "<c width=30% align=right>+" .. U.FormatAttrValue(oldAttr) .. "</c>"
      result = result .. "<c width=10% align=right><img src='Common.arrow_right' width=100% height=100%/></c>"
      result = result .. "<c width=30% align=right><i>" .. HU.ApplyFontColor("+" .. U.FormatAttrValue(newAttr), U.AttrColorTable.Positive) .. "</i></c></l>"
    end
  end
  return result
end

function CreateMaxAttrString()
  local result = ""
  local attrs = AU.GenActorStarPromotionsAccumulated(m_actor.id, m_actor.quality, m_actor.star, m_actor.curPhase)
  for _, attrType in ipairs(AU.ActorAttrIndices) do
    local attr = attrs[attrType]
    if attr then
      if result ~= "" then
        result = result .. HU.HtmlSplitLine("Common.Line_dark2")
      end
      local icon = "<img src='ActorUI.attr_type_" .. attr.type .. "'/>&nbsp;&nbsp;"
      result = result .. "<l width=100%><c width=60% align=left>" .. icon .. WU.GetString("Window_ActorAttrName_" .. attr.type) .. "</c>"
      result = result .. "<c width=40% align=right>+" .. U.FormatAttrValue(attr) .. "</c></l>"
    end
  end
  return result
end

function OnStarUpgradeWindowUninited(star, resChange)
  DBH.ResChange(resChange)
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_star_B")
  _ENV["$"](REF["SpriteStar" .. star]).EffectUpgrade.EffectGenerator:Play()
end

function OnUpgradeClick()
  WU.RecordButtonClick(105014)
  if m_actor then
    local isLevelOk, reachedMax, requiredLevel = AU.StarLevelupValidateActor(m_actor)
    if reachedMax then
      WU.RecycleWindow(this)
    elseif not isLevelOk then
      WU.ShowLevelLimitMsg(requiredLevel, m_actor.uid)
    elseif not m_materialEnough then
      WU.ShowHintText(WU.GetString("Window_StarLevelupError_MaterialNotEnough"))
    else
      RequestUpgrade()
    end
  end
end

function RequestUpgrade()
  this:GameRequest("fci/actor/" .. m_actor.uid .. "/starupgrade/"):Post({}, function(result)
    local _, change = table.find(result.resChange, function(_, change)
      return change.actor
    end)
    local actor = change.actor
    if actor and actor.curPhase == 0 then
      WU.AcquireWindowAsync("ActorStarLevelupResult", function(window)
        _ENV["$"](window)["$$SetActor"](actor, result.resChange)
      end)
    elseif actor then
      DBH.ResChange(result.resChange)
      _ENV["$"](REF["ButtonPhase" .. actor.curPhase]).EffectUpgrade.EffectGenerator:Play()
      CS.SoundManager.Instance:PlaySound("Sound/system/s_System_star")
    end
  end)
end

function OnPhaseClick(go)
  SetPhasePreview(GetStarPhaseByButton(go))
end

function GetStarPhaseByButton(go)
  local star = m_actor.star
  local phase = 0
  if go.name == "ButtonStar" then
    star = star + 1
  else
    phase = math.floor(tonumber(string.sub(go.name, -1)))
  end
  return star, phase
end
