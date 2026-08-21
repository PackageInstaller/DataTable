local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local RU = require("Common/RedMarkUtil")
local m_allData, m_typeData, m_allTypes, m_levelData, m_maxLevelData, m_initWindow, m_curType, m_defaultSelectAll, m_maxLevelSlot, m_activeData
local m_totalRewards = {totalPlayerMoneyRewards = 0, totalGachaRewards = 0}
local m_currentRewards = {currentPlayerMoneyRewards = 0, currentGachaRewards = 0}

function SetupWindow()
  WU.SetActive(REF.RewardsPreview, false)
  m_maxLevelSlot = REF.AchievementLevels[#REF.AchievementLevels - 1].root
  WU.TraverseChildren(REF.AchievementLevels, function(g)
    WU.BindPressEvent(_ENV["$"](g).root, OnAchievementLevelClick)
  end)
  LU.Bind(REF.TypeWrapContent, {
    updateRow = UpdateTabSlot
  })
  LU.Bind(REF.Content, {
    dataSource = function(dataIndex)
      return m_activeData and m_activeData[dataIndex]
    end,
    updateSlot = OnAchievementItemShow
  })
  for i = 0, #REF.Content - 1 do
    for j = 0, #REF.Content[i].root - 1 do
      local item = REF.Content[i].root[j]
      WU.BindButtonEvent(item.Click, function(g)
        WU.RecordButtonClick(100136301)
        WU.AcquireWindowAsync("AchievementDetail", function(ui)
          _ENV["$"](ui).root["$SetView"](item["@data"])
        end)
      end)
    end
  end
  WU.BindPressEvent(REF.RewardsPreview, OnClickRewardsPreview)
  GetALlAchievementsByRewards()
end

function OnClickRewardsPreview(go, pressed)
  if pressed then
    local currentPlayerMoneyRewards = m_currentRewards.currentPlayerMoneyRewards
    local currentGachaRewards = m_currentRewards.currentGachaRewards
    local text = WU.GetString("Window_AchievemetTip", currentPlayerMoneyRewards, m_totalRewards.totalPlayerMoneyRewards, currentGachaRewards, m_totalRewards.totalGachaRewards)
    WU.ShowHoverTips3(text)
  else
    WU.HideHoverTips()
  end
end

function InitWindow()
  WU.SetActive(REF.AchievementLevelProgress, false)
  WU.ToggleRendering(REF.TypeBG, false)
  REF.AchievementLevel.gameObject:SetActive(false)
  REF.DragBG.gameObject:SetActive(false)
  m_initWindow = true
  m_defaultSelectAll = true
  this:Bind("fci/resource/ResAchievementPoint_0", OnAchievementPointChange)
  this:BindRemote(DB:GameRequest("fci/achievement/"), OnAchievementListChange)
end

function UninitWindow()
  RU.SetRedMark("Journey/Achievement", IsRewardAvailable())
end

function OnAchievementListChange(list)
  if list == nil then
    return
  end
  HandleAchievementData(list)
  WU.ToggleRendering(REF.TypeBG, true)
  REF.DragBG.gameObject:SetActive(true)
  LU.Set(REF.TypeWrapContent, #m_allTypes + 1)
  if m_initWindow then
    REF["$Animator"]:Play("DelayOpen", -1, 0)
    m_initWindow = false
  end
  local toggle = REF.TypeWrapContent[0].root.UIToggle
  if m_defaultSelectAll and not toggle.value then
    m_defaultSelectAll = false
    REF.TypeWrapContent[0].root["$SetSelected"]()
  else
    SetWrapContent()
  end
end

function OnAchievementPointChange(achievementPoint)
  if achievementPoint == nil then
    return
  end
  GetAchievementLevelData(math.max(0, achievementPoint))
  REF.AchievementLevel.gameObject:SetActive(true)
  REF.AchievementLevelIcon.UISprite.spriteName = this:GetData("AchievementIconName")
  REF.LabelAchievementLevelName.UILabel.text = this:GetData("AchievementLevelName")
  local maxLevel = achievementPoint >= m_maxLevelData.targetAchievementPoint
  local pointTitle = WU.GetString("Window_Total") .. WU.GetString("ResourceTypeName_" .. PB.enum.ResourceType.ResAchievementPoint) .. ": "
  REF.LabelAchievementPoint.UILabel.text = pointTitle .. achievementPoint
  local posY
  if not maxLevel then
    local corners = REF.SpriteProgressBG.UISprite.worldCorners
    local beginPosX = corners[0].x
    local endPosX = corners[2].x
    local width = (endPosX - beginPosX) / (#m_levelData - 1)
    local begin = m_levelData[1].targetAchievementPoint
    REF.AchievementLevelProgress.UIProgressBar.value = (achievementPoint - begin) / (m_levelData[#m_levelData].targetAchievementPoint - begin)
    m_maxLevelSlot.transform:SetSiblingIndex(#m_levelData - 1)
    for i = 0, #REF.AchievementLevels - 1 do
      local child = REF.AchievementLevels.transform:GetChild(i)
      local ref = _ENV["$"](child)
      local data = m_levelData[i + 1]
      ref["$gameObject"]:SetActive(data ~= nil)
      if data ~= nil then
        ref["@levelInfo"] = data
        local p = ref["$transform"].position
        p.x = beginPosX + i * width
        ref["$transform"].position = p
      end
    end
  else
  end
end

function OnAchievementItemShow(ref, data)
  if data ~= nil then
    ref["@data"] = data
    ref.LabelName.UIHtmlLabel.text = "<img src='Achievement.achievement_bg_3'/>" .. WU.GetString("AchievementName_" .. data.id) .. "<img src='Achievement.achievement_bg_3'/>"
    WU.ToggleRendering(ref.SpriteSpecialIcon, data.info.achievementPoint == 0)
    WU.ToggleRendering(ref.LabelPoint, data.info.achievementPoint ~= 0)
    if data.info.achievementPoint ~= 0 then
      ref.LabelPoint.UILabel.text = data.info.achievementPoint
    end
    local colorProgressSpriteName
    if data.info.achievementPoint <= 15 then
      colorProgressSpriteName = "achievement_blue"
    elseif data.info.achievementPoint <= 25 then
      colorProgressSpriteName = "achievement_purple"
    else
      colorProgressSpriteName = "achievement_orange"
    end
    ref.SpriteColorProgress.UISprite.spriteName = colorProgressSpriteName
    ref.SpriteColorProgress.UISprite.fillAmount = data.progress / data.info.maxProgress
    ref.EffectCanGet.gameObject:SetActive(data.isDone and not data.rewardGot)
    WU.ToggleRendering(ref.SpriteComplete, data.rewardGot)
  end
end

function OnAchievementLevelClick(go, pressed)
  local info = _ENV["$"](go)["@levelInfo"]
  local ownPoint = this:GetData("fci/resource/ResAchievementPoint_0")
  if ownPoint >= info.targetAchievementPoint then
    return
  end
  local levelName = WU.GetString("AchievementTrophy_" .. info.trophy)
  if info.trophy ~= m_maxLevelData.trophy then
    levelName = levelName .. WU.GetString("AchievementLevel_" .. info.level)
  end
  local title = levelName
  local desc = WU.GetString("WindowAchievement_LevelupProgress") .. ownPoint .. "/" .. info.targetAchievementPoint
  if pressed then
    WU.ShowHoverTips(title, desc)
  else
    WU.HideHoverTips()
  end
end

function SetWrapContent(type)
  if type ~= nil then
    m_curType = type
  end
  if m_curType == 0 or m_curType == nil then
    m_activeData = m_allData
  else
    m_activeData = m_typeData[m_curType]
  end
  local row = #REF.Content[0]["$"]
  LU.Set(REF.Content, math.ceil(#m_activeData / row))
end

function HandleAchievementData(list)
  m_allData = {}
  for _, v in ipairs(list) do
    v.info = PB.get("AchievementInfo", v.id)
    if v.info == nil then
      error("Achievement", "no id " .. v.id .. " in AchievementInfo.xlsx")
      break
    end
    if v.info.achievementPoint == nil then
      local _, point = _ENV["!"](v.info.reward):find(function(k, v)
        return v.type == PB.enum.ResourceType.ResAchievementPoint
      end)
      v.info.achievementPoint = point.count
    end
    if v.info.playerMoney == nil and v.rewardGot then
      local _, playerMoney = _ENV["!"](v.info.reward):find(function(k, v)
        return v.type == PB.enum.ResourceType.ResPlayerMoney
      end)
      if playerMoney ~= nil then
        v.info.playerMoney = playerMoney.count
        m_currentRewards.currentPlayerMoneyRewards = m_currentRewards.currentPlayerMoneyRewards + v.info.playerMoney
      else
        v.info.playerMoney = 0
      end
    end
    if v.info.gachaReward == nil and v.rewardGot then
      local _, gacha = _ENV["!"](v.info.reward):find(function(k, v)
        return v.type == PB.enum.ResourceType.ResItem and v.id == 60001
      end)
      if gacha ~= nil then
        v.info.gachaReward = gacha.count
        m_currentRewards.currentGachaRewards = m_currentRewards.currentGachaRewards + v.info.gachaReward
      else
        v.info.gachaReward = 0
      end
    end
    table.insert(m_allData, v)
  end
  table.sort(m_allData, SortAchievement)
  m_typeData = {}
  local typeRewardCount = {}
  for _, v in ipairs(m_allData) do
    local type = v.info.category
    if m_typeData[type] == nil then
      m_typeData[type] = {}
    end
    table.insert(m_typeData[type], v)
    if typeRewardCount[type] == nil then
      typeRewardCount[type] = 0
    end
    if v.isDone and not v.rewardGot then
      typeRewardCount[type] = typeRewardCount[type] + 1
    end
  end
  m_allTypes = {}
  for type, data in pairs(m_typeData) do
    table.insert(m_allTypes, {
      type = type,
      rewardCount = typeRewardCount[type]
    })
  end
  table.sort(m_allTypes, function(a, b)
    return a.type < b.type
  end)
  local gachaText = WU.GetString("Achievements_RewardsPreviewGacha", m_currentRewards.currentGachaRewards, m_totalRewards.totalGachaRewards)
  local moneyText = WU.GetString("Achievements_RewardsPreviewMoney", m_currentRewards.currentPlayerMoneyRewards, m_totalRewards.totalPlayerMoneyRewards)
  WU.SetActive(REF.GachaSprite, true)
  WU.SetActive(REF.MoneySprite, true)
  REF.GachaLabel.UIHtmlLabel.text = gachaText
  REF.PlayerMoneyLabel.UIHtmlLabel.text = moneyText
end

function IsRewardAvailable()
  if m_allTypes == nil then
    return false
  end
  for i = 1, #m_allTypes do
    if m_allTypes[i].rewardCount > 0 then
      return true
    end
  end
  return false
end

function GetAchievementLevelData(point)
  m_levelData = {}
  local all = PB.all("AchievementPointTarget")
  m_maxLevelData = all[#all]
  local levelName, curTrophy = AU.GetAchievementInfo(point, all)
  this:SetData("AchievementLevelName", levelName)
  this:SetData("AchievementIconName", "cup_icon_" .. curTrophy)
  for i = 1, #all do
    local data = all[i]
    if data.trophy == curTrophy or data.trophy == curTrophy + 1 and data.level == 1 then
      table.insert(m_levelData, data)
    elseif data.trophy == curTrophy + 1 and data.level ~= 1 then
      break
    end
  end
end

function SortAchievement(a, b)
  if a.rewardGot or b.rewardGot then
    if a.rewardGot and b.rewardGot then
      return Compare(a, b)
    else
      return not a.rewardGot and b.rewardGot
    end
  elseif a.isDone or b.isDone then
    if a.isDone and b.isDone then
      return Compare(a, b, true)
    else
      return a.isDone and not b.isDone
    end
  else
    return Compare(a, b)
  end
end

function Compare(a, b, descend)
  if a.info.priority ~= b.info.priority then
    return a.info.priority > b.info.priority
  else
    return fif(descend, a.id < b.id, a.id > b.id)
  end
end

function UpdateTabSlot(goRef, wrapIndex, realIndex)
  if m_allTypes ~= nil and realIndex ~= nil and realIndex <= #m_allTypes then
    local type, hasRedMark
    if realIndex == 0 then
      type = 0
      hasRedMark = false
    else
      type = m_allTypes[realIndex].type
      hasRedMark = 0 < m_allTypes[realIndex].rewardCount
    end
    local content = WU.GetString("AchievementCategory_" .. type)
    local spriteName = "achievement_category_" .. type
    goRef["$$SetTab"](content, "Achievement", spriteName, hasRedMark)
    goRef["$$SetClickCallback"](nil)
    goRef["$UIToggle"].optionCanBeNone = true
    goRef["$UIToggle"].value = m_curType == type
    goRef["$UIToggle"].optionCanBeNone = false
    goRef["$$SetClickCallback"](function(go)
      if _ENV["$"](go)["@type"] == nil then
        error("Achievement", "@type is nil")
      end
      SetWrapContent(_ENV["$"](go)["@type"])
    end)
    goRef["@type"] = type
  end
end

function GetALlAchievementsByRewards()
  local allAchievements = PB.all("AchievementInfo")
  for _, achievement in pairs(allAchievements) do
    local _, playerMoneyReward = _ENV["!"](achievement.reward):find(function(k, v)
      return PB.enum.ResourceType.ResPlayerMoney == v.type
    end)
    if playerMoneyReward ~= nil then
      m_totalRewards.totalPlayerMoneyRewards = m_totalRewards.totalPlayerMoneyRewards + playerMoneyReward.count
    end
    local _, gachaReward = _ENV["!"](achievement.reward):find(function(k, v)
      return PB.enum.ResourceType.ResItem == v.type and 60001 == v.id
    end)
    if gachaReward ~= nil then
      m_totalRewards.totalGachaRewards = m_totalRewards.totalGachaRewards + gachaReward.count
    end
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001363, on)
end
