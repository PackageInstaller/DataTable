local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local FH = require("Logic/HelpLogic")
local LU = require("Common/ListUtil")
local DEFINE = require("Logic/Define")
local m_data
local m_showRows = 0

function Awake()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
end

function SetData(commandInfos, actorCount)
  m_data = commandInfos
  m_showRows = actorCount
  LU.Set(REF.WrapContent, #m_data, false)
end

function UpdateRow(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil then
    local itemIndex = realIndex + 1
    if m_data and itemIndex <= #m_data then
      local roundInfo = m_data[itemIndex]
      for i = 0, #rowRef.SkillsGrid - 1 do
        local ref = rowRef.SkillsGrid[i]
        WU.SetActive(ref["$"], i < m_showRows)
        if i < m_showRows then
          local find
          for k = 1, #roundInfo do
            if roundInfo[k].upDownIndex == i + 1 then
              find = roundInfo[k]
              break
            end
          end
          WU.SetActive(ref.SkillDescribe, false)
          WU.SetActive(ref.SkillIconTexture, false)
          WU.SetActive(ref.IsChanged, false)
          WU.SetActive(ref.SkipRound, false)
          WU.SetActive(ref.GridWeapon, false)
          ref.SkillBg.UISprite.spriteName = "fight_skill_bg_3"
          if find then
            local data = find.command
            local index = data.index
            if 0 < index then
              local haveCard = data.texturePath and U.trim(data.texturePath) ~= ""
              if haveCard then
                ref.SkillBg.UISprite.spriteName = fif(data.useSp == 2, "fight_skill_bg_2", "fight_skill_bg_1")
              elseif index ~= DEFINE.PreDefinedCommand.SkipCommand then
                ref.SkillBg.UISprite.spriteName = "fight_skill_bg_3"
              end
              WU.SetActive(ref.SkipRound, index == DEFINE.PreDefinedCommand.SkipCommand)
              ref.SkillIconTexture.UITexture.mainTexturePath = data.texturePath
              ref.SkillIconTexture.gameObject:SetActive(haveCard)
              ref.SkillDescribe.UISprite.spriteName = data.kindIcon
              ref.SkillDescribe.gameObject:SetActive(haveCard)
              WU.SetActive(ref.IsChanged, data.isChanged)
            end
            local weaponsPrevious = table.select(data.weapons, function(val)
              if val.isPrevious then
                return val
              end
            end):toarray()
            local weapons = table.select(data.weapons, function(val)
              if not val.isPrevious then
                return val
              end
            end):toarray()
            local useWeaponSkill = 0 < #weaponsPrevious or 0 < #weapons
            WU.SetActive(ref.GridWeapon, useWeaponSkill)
            if useWeaponSkill then
              local displayInfo = fif(0 < #weapons, weapons, weaponsPrevious)
              for wi = 0, #ref.GridWeapon - 1 do
                local weaponRef = ref.GridWeapon[wi]
                WU.SetActive(weaponRef["$"], displayInfo[wi + 1])
                if displayInfo[wi + 1] then
                  local weapon = displayInfo[wi + 1]
                  weaponRef.HexIcon.UITexture.mainTexturePath = "Texture/FightImpressionHead/FightImpressionSkillHead/impression_skill_head_" .. weapon.id .. "_" .. weapon.skin
                end
              end
              ref.GridWeapon.UIGrid:Reposition()
            end
          end
          ref.SkillBg.UISprite:MakePixelPerfect()
        end
      end
      rowRef.RoundLabel.UILabel.text = roundInfo.round
      rowRef.BackGround.UISprite.spriteName = fif(roundInfo.round == CS.FightLuaLogic.Instance.GameRound, "record_round_bg_2", "record_round_bg_1")
    end
  end
end
