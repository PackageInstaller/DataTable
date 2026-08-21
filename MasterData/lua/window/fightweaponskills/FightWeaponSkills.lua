local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local DEFINE = require("Logic/Define")
local FightHelper = require("Common/FightHelper")

function SetupWindow()
  WU.BindButtonEvent(REF.Black, OnUIContinue)
end

function OnUIContinue(obj)
  local sceneFight = CS.SceneFight.Instance
  if sceneFight ~= nil then
    sceneFight:PauseGame(false)
  end
  this:BroadcastGameEvent("OnFightGamePause")
  WU.RecycleWindow(this)
end

function RefreshWeaponInfo(weaponInfos, teamInfo, tempEnergyInfo)
  tempEnergyInfo = tempEnergyInfo or {}
  WU.TraverseChildren(REF.Grid, function(go)
    WU.SetActive(go, false)
  end)
  for i = 1, #weaponInfos do
    local weaponInfo = weaponInfos[i]
    local weaponDetail = weaponInfo.actorInfo
    local widgetIndex = weaponInfo.baseSeat - DEFINE.ACTOR_NUM - 1
    if weaponDetail.id > 0 and 0 <= widgetIndex and widgetIndex < #REF.Grid then
      local widgetRef = REF.Grid[widgetIndex]
      local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.id, weaponDetail.uniqueWeaponPhase or 1)
      if uniqueWeaponSkill then
        WU.SetActive(widgetRef["$gameObject"], true)
        WU.SetActive(widgetRef.EnergyInfo, 0 < uniqueWeaponSkill.costWP)
        if 0 < uniqueWeaponSkill.costWP then
          widgetRef.UseCountCost.UISprite.spriteName = DEFINE.UseCountSprite[uniqueWeaponSkill.costUseCount]
          FightHelper.SetEnergySprite(widgetRef.WPEnergyLimit.UISprite, uniqueWeaponSkill.costWP)
          local predictEnergy = tempEnergyInfo[weaponInfo.uniqueID] or weaponInfo.energyWP
          WU.SetActive(widgetRef.WPEnergy, 0 < predictEnergy)
          WU.SetActive(widgetRef.WPEnergyOverlap, predictEnergy > uniqueWeaponSkill.costWP)
          if 0 < predictEnergy then
            local costWPDisplay = math.min(predictEnergy, uniqueWeaponSkill.costWP)
            FightHelper.SetEnergySprite(widgetRef.WPEnergy.UISprite, costWPDisplay)
          end
          if predictEnergy > uniqueWeaponSkill.costWP then
            local overlapWPDisplay = math.min(predictEnergy - uniqueWeaponSkill.costWP, uniqueWeaponSkill.costWP)
            FightHelper.SetEnergySprite(widgetRef.WPEnergyOverlap.UISprite, overlapWPDisplay)
          end
        end
        local skin = weaponDetail.uniqueWeaponSkin or 0
        widgetRef.WeaponBG.UITexture.mainTexturePath = "Texture/FightImpressionHead/ImpressionSkillRole/impression_skill_role_" .. uniqueWeaponSkill.id .. "_" .. skin
        widgetRef.WeaponTitle.UILabel.text = WU.GetString("UniqueWeaponName_" .. uniqueWeaponSkill.id)
        local describe = WU.GetString("UniqueWeaponSkill_" .. uniqueWeaponSkill.id)
        for i = 1, #uniqueWeaponSkill.specials do
          local special = uniqueWeaponSkill.specials[i]
          local specialIndex = special.index
          if 0 < specialIndex then
            local effect = SE.GetSpecialEffect(specialIndex, weaponDetail.uniqueWeaponPhase or 1)
            describe = describe .. WU.FormatString(TU.render(WU.GetString("UniqueWeaponSpecial_" .. specialIndex), effect), "#72e6ff", "#ff8888")
          end
        end
        widgetRef.Describe.UIHtmlLabel.text = describe
        widgetRef.Describe.transform.localPosition = CS.UnityEngine.Vector3(0, fif(0 < uniqueWeaponSkill.costWP, -170, -88), 0)
      else
        warning("GamePlay", "missing UniqueWeaponSkill.xlsx id " .. tostring(weaponDetail.id) .. " , phase : " .. tostring(weaponDetail.uniqueWeaponPhase))
      end
    end
  end
  REF.Grid.UIGrid:Reposition()
end
