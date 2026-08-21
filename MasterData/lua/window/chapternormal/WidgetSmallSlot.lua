local base = inherit("Window/ChapterNormal/WidgetDungeonBaseSlot", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local S = require("Common/Singleton")
local m_dungeonId

function SetStatus(dungeonRecord)
  local isUnlock = DU._IsDungeonUnlock(dungeonRecord)
  local stageLockIcon = 0
  local rewardInfo
  if dungeonRecord then
    rewardInfo = PB.get("DungeonReward", dungeonRecord.dungeonId)
  end
  if rewardInfo and rewardInfo.displayType == 5 then
    WU.SetActive(REF.SmallSlot, true)
    WU.SetActive(REF.TrainingSlot, false)
    REF.BGSprite.gameObject:SetActive(false)
    REF.BGSpriteSpecial.gameObject:SetActive(true)
    local refBg = REF.BGSpriteSpecial
    if not isUnlock then
      refBg.UISprite.spriteName = "special_off"
    elseif dungeonRecord.finished == false then
      refBg.UISprite.spriteName = "special_on"
    else
      refBg.UISprite.spriteName = "special_on"
    end
  else
    REF.BGSprite.gameObject:SetActive(true)
    REF.BGSpriteSpecial.gameObject:SetActive(false)
    local refBg = REF.BGSprite
    if m_dungeonId == 2 or m_dungeonId == 5 or m_dungeonId == 7 or m_dungeonId == 9 or m_dungeonId == 13 or m_dungeonId == 15 then
      WU.SetActive(REF.SmallSlot, false)
      WU.SetActive(REF.TrainingSlot, true)
      REF.Reward.UIPlayTween:Stop()
      if isUnlock then
        REF.RewardBG.UISprite.spriteName = "training_on"
        if dungeonRecord.finished == false then
          REF.Reward.UIPlayTween:Play(true)
        end
      else
        REF.RewardBG.UISprite.spriteName = "training_off"
      end
      REF.FinishedSprite.gameObject:SetActive(isUnlock and dungeonRecord.finished)
    else
      WU.SetActive(REF.SmallSlot, true)
      WU.SetActive(REF.TrainingSlot, false)
      if not isUnlock then
        refBg.UISprite.spriteName = "normal_locked"
      elseif dungeonRecord.finished == false then
        refBg.UISprite.spriteName = "normal_on"
      else
        refBg.UISprite.spriteName = "normal_off"
      end
    end
    refBg.UISprite:MakePixelPerfect()
  end
end

function SetData(data)
  base._SetData(data)
  local chapter = data.chapter
  m_dungeonId = data.dungeonId
  local dungeonRecord = chapter.recordDungeons[m_dungeonId]
  SetStatus(dungeonRecord)
end
