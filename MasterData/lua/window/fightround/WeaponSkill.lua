local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local DEFINE = require("Logic/Define")
local FightHelper = require("Common/FightHelper")
local m_lastWeaponEnergy = {}

function SetWeaponInfo(weaponInfos)
  local result = {}
  for i = 0, #REF.WeaponGrid - 1 do
    local widgetRef = REF.WeaponGrid[i]
    WU.SetActive(widgetRef.NotEmpty, false)
    WU.SetActive(widgetRef.Empty, true)
    widgetRef.WeaponRect.BoxCollider2D.enabled = false
    local cardCS = CS.UIActorCardButtonInfo()
    cardCS.btn = widgetRef["$gameObject"]
    cardCS.useEnable = false
    widgetRef["@info"] = cardCS
  end
  weaponInfos = weaponInfos or {}
  for i = 1, #weaponInfos do
    local weaponInfo = weaponInfos[i]
    local weaponDetail = weaponInfo.actorInfo
    local widgetIndex = weaponInfo.baseSeat - DEFINE.ACTOR_NUM - 1
    if 0 < weaponDetail.id and 0 <= widgetIndex and widgetIndex < #REF.WeaponGrid then
      local widgetRef = REF.WeaponGrid[widgetIndex]
      local uniqueWeaponInfo = PB.get("UniqueWeaponInfo", weaponDetail.id)
      if uniqueWeaponInfo then
        local skin = weaponDetail.uniqueWeaponSkin or 0
        widgetRef.HexIcon.UITexture.mainTexturePath = "Texture/FightImpressionHead/FightImpressionSkillHead/impression_skill_head_" .. uniqueWeaponInfo.id .. "_" .. skin
        widgetRef.RectIcon.UITexture.mainTexturePath = "Texture/ImpressionRoleM/impression_role_" .. uniqueWeaponInfo.id .. "_" .. skin
        widgetRef.RectBG.UITexture.mainTexturePath = "Texture/ImpressionRoleM/impression_list_bg_" .. uniqueWeaponInfo.quality
      else
        warning("GamePlay", "missing UniqueWeaponInfo.xlsx id " .. tostring(weaponDetail.id))
      end
      local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.id, weaponDetail.uniqueWeaponPhase or 1)
      if uniqueWeaponSkill then
        WU.SetActive(widgetRef.NotEmpty, true)
        WU.SetActive(widgetRef.Empty, false)
        WU.SetActive(widgetRef.WeaponHexagon, true)
        WU.SetActive(widgetRef.WeaponRect, false)
        if 0 < uniqueWeaponSkill.costWP then
          FightHelper.SetEnergySprite(widgetRef.WPEnergyLimit.UISprite, uniqueWeaponSkill.costWP)
          widgetRef.WPUseCost.UISprite.spriteName = DEFINE.UseCountSprite[uniqueWeaponSkill.costUseCount]
          widgetRef["@costUseCount"] = uniqueWeaponSkill.costUseCount
          widgetRef["@weaponCommand"] = DEFINE.WeaponCommand(false, weaponInfo.team, weaponInfo.baseSeat)
          result[weaponInfo.uniqueID] = widgetRef["@info"]
        end
      else
        warning("GamePlay", "missing UniqueWeaponSkill.xlsx id " .. tostring(weaponDetail.id) .. " , phase : " .. tostring(weaponDetail.uniqueWeaponPhase))
      end
    end
  end
  return result
end

function RefreshWeaponInfo(weaponInfos, teamInfo)
  local isSelfTeam = teamInfo.team == CS.FightLuaLogic.Instance.SelfTeam
  WU.ToggleRendering(REF["$gameObject"], isSelfTeam)
  if isSelfTeam then
    for i = 1, #weaponInfos do
      local weaponInfo = weaponInfos[i]
      local widgetIndex = weaponInfo.baseSeat - DEFINE.ACTOR_NUM - 1
      if 0 <= widgetIndex and widgetIndex < #REF.WeaponGrid then
        do
          local widgetRef = REF.WeaponGrid[widgetIndex]
          if widgetRef["@delayTriggeredEffect"] then
            widgetRef["@delayTriggeredEffect"] = false
            widgetRef.TriggeredEffect.EffectGenerator:Play()
          end
          local _, card = table.find(teamInfo.cardsInHand, function(_, v)
            return v.actorRuntimeID == weaponInfo.uniqueID
          end)
          local cardUseCount = 0
          local cardLocked = false
          if card then
            cardUseCount = fif(0 < card.useCount, card.useCount, 0)
            cardLocked = card.lock
          end
          WU.SetActive(widgetRef.NotEmpty, 0 < cardUseCount)
          WU.SetActive(widgetRef.Empty, cardUseCount == 0)
          widgetRef["@cardUseCount"] = cardUseCount
          local weaponDetail = weaponInfo.actorInfo
          if 0 < weaponDetail.id then
            widgetRef.EffectRect.EffectGenerator.enabled = false
            local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.id, weaponDetail.uniqueWeaponPhase or 1)
            if uniqueWeaponSkill then
              local passive = uniqueWeaponSkill.costWP == 0
              WU.SetActive(widgetRef.HexLabel, passive)
              WU.SetActive(widgetRef.TriggeredEffect, passive)
              WU.SetActive(widgetRef.Scale, not passive)
              if passive then
                WU.SetActive(widgetRef.WeaponRect, false)
                WU.SetActive(widgetRef.WeaponHexagon, true)
              else
                WU.ToggleRendering(widgetRef.WPEnergy, 0 < weaponInfo.energyWP)
                WU.ToggleRendering(widgetRef.WPEnergyOverlap, weaponInfo.energyWP > uniqueWeaponSkill.costWP)
                if uniqueWeaponSkill.limitWP < uniqueWeaponSkill.costWP then
                  warning("GamePlay", "UniqueWeaponSkill.xlsx id ->" .. tostring(weaponDetail.id) .. " phase -> " .. tostring(weaponDetail.uniqueWeaponPhase) .. " limitWP < costWP ??")
                end
                if 0 < weaponInfo.energyWP then
                  local costWPDisplay = math.min(weaponInfo.energyWP, uniqueWeaponSkill.costWP)
                  FightHelper.SetEnergySprite(widgetRef.WPEnergy.UISprite, costWPDisplay)
                end
                if weaponInfo.energyWP > uniqueWeaponSkill.costWP then
                  local overlapWPDisplay = math.min(weaponInfo.energyWP - uniqueWeaponSkill.costWP, uniqueWeaponSkill.costWP)
                  FightHelper.SetEnergySprite(widgetRef.WPEnergyOverlap.UISprite, overlapWPDisplay)
                end
                local allActors = FH.getAllActors({teamInfo}, true)
                local alive = table.find(allActors, function(_, v)
                  return v.team == weaponInfo.team and v.baseSeat == weaponInfo.baseSeat - DEFINE.ACTOR_NUM
                end)
                local useEnable = weaponInfo.energyWP >= uniqueWeaponSkill.costWP and teamInfo.weaponUseCount >= uniqueWeaponSkill.costUseCount and alive and 0 < cardUseCount
                WU.SetActive(widgetRef.WeaponHexagon, not useEnable)
                WU.SetActive(widgetRef.WeaponRect, useEnable)
                widgetRef.WeaponRect.BoxCollider2D.enabled = useEnable
                local cardCS = widgetRef["@info"]
                cardCS.cardList:Clear()
                cardCS.uniqueID = weaponInfo.uniqueID
                cardCS:SetBtnEnable(alive and not cardLocked)
                widgetRef["@dead"] = alive == nil
                cardCS.useEnable = useEnable
                widgetRef.EffectRect.EffectGenerator.enabled = useEnable and not cardLocked
                if card then
                  cardCS.cardIndex = card.skillIndex
                  cardCS:AddCard(card)
                end
              end
            else
              warning("GamePlay", "missing UniqueWeaponSkill.xlsx id " .. tostring(weaponDetail.id) .. " , phase : " .. tostring(weaponDetail.uniqueWeaponPhase))
            end
          end
        end
      end
    end
    RefreshUseCount(teamInfo, 0)
  end
end

function RefreshUseCount(teamInfo, delta)
  local useCountPreview = fif(teamInfo.weaponUseCount - delta <= 0, 0, teamInfo.weaponUseCount - delta)
  WU.SetActive(REF.WeaponUseCount, 0 < useCountPreview)
  REF.WeaponUseCount.UISprite.spriteName = DEFINE.UseCountSprite[useCountPreview]
  REF.WeaponUseCountNum.UILabel.text = useCountPreview
end

function PlayEffectEnergy(weaponInfos)
  for i = 1, #weaponInfos do
    local weaponInfo = weaponInfos[i]
    local weaponDetail = weaponInfo.actorInfo
    local widgetIndex = weaponInfo.baseSeat - DEFINE.ACTOR_NUM - 1
    if weaponDetail.id > 0 and 0 <= widgetIndex and widgetIndex < #REF.WeaponGrid then
      local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.id, weaponDetail.uniqueWeaponPhase or 1)
      local widgetRef = REF.WeaponGrid[widgetIndex]
      if 0 < widgetRef["@cardUseCount"] and not widgetRef["@dead"] and (m_lastWeaponEnergy[weaponInfo.uniqueID] or 0) < weaponInfo.energyWP and uniqueWeaponSkill then
        WU.ToggleRendering(widgetRef.WPEnergy, 0 < weaponInfo.energyWP)
        WU.ToggleRendering(widgetRef.WPEnergyOverlap, weaponInfo.energyWP > uniqueWeaponSkill.costWP)
        local costWPDisplay = math.min(weaponInfo.energyWP, uniqueWeaponSkill.costWP)
        local overlapWPDisplay = math.min(weaponInfo.energyWP - uniqueWeaponSkill.costWP, uniqueWeaponSkill.costWP)
        FightHelper.SetEnergySprite(widgetRef.WPEnergy.UISprite, costWPDisplay)
        FightHelper.SetEnergySprite(widgetRef.WPEnergyOverlap.UISprite, overlapWPDisplay)
        widgetRef.EffectEnergyE.EffectGenerator:Play()
      end
      m_lastWeaponEnergy[weaponInfo.uniqueID] = weaponInfo.energyWP
    end
  end
  return m_lastWeaponEnergy
end

function PlayEffectUseWeapon(weaponInfos, ref)
  if weaponInfos == nil or ref == nil then
    return
  end
  ref.EffectRect.EffectGenerator.enabled = false
  ref.EffectClick.EffectGenerator.enabled = true
  ref.EffectClick.EffectGenerator:Play(function()
    ref.EffectClick.EffectGenerator.enabled = false
  end)
  ref.EffectEnergyC.EffectGenerator:Play()
  local _, weaponInfo = table.find(weaponInfos, function(_, v)
    return v.uniqueID == ref["@info"].uniqueID
  end)
  if weaponInfo then
    local weaponDetail = weaponInfo.actorInfo
    local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.id, weaponDetail.uniqueWeaponPhase or 1)
    if uniqueWeaponSkill then
      local predictEnergy = weaponInfo.energyWP - uniqueWeaponSkill.costWP
      WU.ToggleRendering(ref.WPEnergy, 0 < predictEnergy)
      WU.ToggleRendering(ref.WPEnergyOverlap, predictEnergy > uniqueWeaponSkill.costWP)
      local costWPDisplay = math.min(predictEnergy, uniqueWeaponSkill.costWP)
      FightHelper.SetEnergySprite(ref.WPEnergy.UISprite, costWPDisplay)
      local overlapWPDisplay = math.min(predictEnergy - uniqueWeaponSkill.costWP, uniqueWeaponSkill.costWP)
      FightHelper.SetEnergySprite(ref.WPEnergyOverlap.UISprite, overlapWPDisplay)
    end
  end
end

function PlayEffectPassive(roundActorInfo)
  local weaponDetail = roundActorInfo.actorInfo
  local widgetIndex = roundActorInfo.baseSeat - 1
  if weaponDetail.uniqueWeaponId > 0 and 0 <= widgetIndex and widgetIndex < #REF.WeaponGrid then
    local widgetRef = REF.WeaponGrid[widgetIndex]
    local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.uniqueWeaponId, weaponDetail.uniqueWeaponPhase or 1)
    if uniqueWeaponSkill and uniqueWeaponSkill.costWP == 0 then
      widgetRef["@delayTriggeredEffect"] = true
    end
  end
end
