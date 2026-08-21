local WU, DB, REF = require("Common/WindowUtil")(this)
local CO = require("Common/Coroutine")
local PB = require("Common/PbHelper")
local m_achievements = {}
local m_showing = false

function SetupWindow()
  REF.BG.gameObject:SetActive(false)
  this:Bind("AchievementContext/UnlockShow", OnUnlockShow)
end

function AddUnlock(id)
  table.insert(m_achievements, id)
end

function OnUnlockShow(val)
  if val and not m_showing then
    CO.coroutine_call(Show, this)()
  end
end

function Show()
  m_showing = true
  WU.ToggleRendering(REF["$"], true)
  while not table.empty(m_achievements) do
    REF.BG.gameObject:SetActive(true)
    local achievementId = tonumber(m_achievements[1])
    local achievementInfo = PB.get("AchievementInfo", achievementId)
    if achievementInfo then
      local achievementPoint = achievementInfo.achievementPoint
      if achievementPoint == nil then
        local _, point = _ENV["!"](achievementInfo.reward):find(function(k, v)
          return v.type == PB.enum.ResourceType.ResAchievementPoint
        end)
        achievementPoint = point.count
      end
      local effectSuffix = "Y"
      if achievementPoint <= 15 then
        effectSuffix = "B"
      elseif achievementPoint <= 25 then
        effectSuffix = "P"
      else
        effectSuffix = "Y"
      end
      REF["OpenEffect_" .. effectSuffix].gameObject:SetActive(true)
      REF.LabelAchievementName.UIHtmlLabel.text = "<img src='Achievement.achievement_bg_3'/>" .. WU.GetString("AchievementName_" .. achievementId) .. "<img src='Achievement.achievement_bg_3'/>"
      REF.Effect.UIPlayTween.tweenGroup = 3457
      REF.Effect.UIPlayTween:Play(true)
      table.remove(m_achievements, 1)
      CO.yield_return(CS.UnityEngine.WaitForSeconds(2.0))
      REF.Effect.UIPlayTween.tweenGroup = 3458
      REF.Effect.UIPlayTween:Play(true)
      REF["OpenEffect_" .. effectSuffix].gameObject:SetActive(false)
      REF["CloseEffect_" .. effectSuffix].gameObject:SetActive(true)
      CO.yield_return(CS.UnityEngine.WaitForSeconds(0.4))
      REF["CloseEffect_" .. effectSuffix].gameObject:SetActive(false)
      REF.BG.gameObject:SetActive(false)
      CO.yield_return(CS.UnityEngine.WaitForSeconds(0.5))
    else
      error("Achievement", "no id " .. achievementId .. " in AchievementInfo.xlsx")
      break
    end
  end
  WU.ToggleRendering(REF["$"], false)
  m_showing = false
end
