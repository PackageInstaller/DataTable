local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local HU = require("Common/HtmlUtil")
local RU = require("Common/RedMarkUtil")
local DU = require("Common/DungeonUtil")
local AM = S:Get("ActivityManager")
local LU = require("Common/ListUtil")
local m_dungeonId, costWin, m_drops

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonPrepare, OnClickPrepare)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateSlot
  })
end

function InitWindow()
  DetermineGoldLevel()
  costWin = DU.GetDungeonGoldCost()
  UpdateTickets()
end

function DetermineGoldLevel()
  local baseInfo = DB:GetData("fci/baseinfo")
  local goldDungeonLevel = DU.GetDungeonGoldLevel()
  if goldDungeonLevel then
    m_dungeonId = goldDungeonLevel.dungeonId
    local roma_sprite = goldDungeonLevel.romanLevel
    REF.GoldTitleNumber.UISprite.spriteName = "roma_num" .. roma_sprite
    this:SetData("WindowDungeon/DungeonId", m_dungeonId)
    UpdateDropList(goldDungeonLevel)
    local nextLevel = goldDungeonLevel
    local allLevels = PB.all("GoldDungeonLevel")
    for i = baseInfo.level, #allLevels do
      local level = allLevels[i]
      if level ~= nil and level.dungeonId ~= m_dungeonId then
        nextLevel = level
        break
      end
    end
    if nextLevel == goldDungeonLevel then
      REF.NextLevelGold.gameObject:SetActive(false)
      REF.NextLevelHint_2.gameObject:SetActive(false)
      REF.NextLevelHint_1.UIHtmlLabel.text = WU.GetString("Gold_Max_Level_Hint")
    else
      REF.NextLevelGold.gameObject:SetActive(true)
      REF.NextLevelHint_1.UIHtmlLabel.text = WU.GetString("Gold_Next_Level_Hint1")
      REF.NextLevelGold.ResourcePrinter:SetAutoColor(false)
      REF.NextLevelGold.ResourcePrinter:SetResource(PB.enum.ResourceType.ResPlayerGold, 0, nextLevel.rewardGold)
      REF.NextLevelHint_2.gameObject:SetActive(false)
      REF.NextLevelHint_2.gameObject:SetActive(true)
      REF.NextLevelHint_2.UIHtmlLabel.text = WU.GetString("Gold_Next_Level_Hint2", "<font color=#ffe800>" .. WU.GetString("Window_Level", nextLevel.level) .. "</font>")
    end
    info("DungeonGold", "dungeonId Set To " .. tostring(m_dungeonId))
  else
    warning("DungeonGold", "Gold level not found for level:" .. tostring(baseInfo.level))
    REF.NextLevelGold.gameObject:SetActive(false)
    REF.NextLevelHint_2.gameObject:SetActive(false)
    REF.NextLevelHint_1.UIHtmlLabel.text = WU.GetString("Gold_Max_Level_Hint")
  end
end

function UpdateTickets()
  if costWin ~= nil then
    local tickets = this:GetData("fci/item/" .. costWin.id).count
    local _, refresh = PB.all("DailyRefresh"):find(function(k, v)
      return v.refreshRes.id == costWin.id
    end)
    if refresh ~= nil then
      if 0 < tickets then
        REF.TicketLabel.UIHtmlLabel.text = tickets
      else
        REF.TicketLabel.UIHtmlLabel.text = "<font color=#fd5454>" .. tickets .. "</font>"
      end
      WU.ClearButtonEvent(REF.TicketInfo)
      WU.BindButtonEvent(REF.TicketInfo, function()
        OnShowTicketMessage(costWin)
      end)
    else
      error("GamePlay", "DungeonGold cannot find entry in DailyRefresh by refreshRes.id:" .. costWin.id)
    end
  end
end

function OnShowTicketMessage(cost)
  if cost.type == PB.enum.ResourceType.ResItem then
    WU.ShowItemDetail(cost.id)
  else
    WU.ShowHintText(WU.GetString("ResourceTypeName_" .. cost.type))
  end
end

function UpdateDropList(level)
  local baseDrop = _ENV["!"]({
    type = PB.enum.ResourceType.ResPlayerGold,
    id = 0,
    count = level.rewardGold
  })
  REF.WidgetIconSlot0["$SetData"](baseDrop.type, baseDrop.id, baseDrop.count)
  REF.WidgetIconSlot0["$SetClickCallback"](function()
    WU.ShowResourceDetail(baseDrop.type, baseDrop.id)
  end)
  local bonusDrop = _ENV["!"]({
    type = PB.enum.ResourceType.ResPlayerGold,
    id = 0,
    count = level.rewardGoldKill
  })
  m_drops = {}
  for i = 1, 3 do
    table.insert(m_drops, bonusDrop)
  end
  AM.GetTimeLimitExtraReward({type = 8}, function(extra)
    for i = 1, #extra do
      table.insert(m_drops, extra[i])
    end
    LU.Set(REF.WrapContent, #m_drops)
  end)
end

function OnClickPrepare()
  if costWin ~= nil then
    WU.RecordButtonClick(122001)
    local tickets = this:GetData("fci/item/" .. costWin.id).count
    if tickets <= 0 then
      WU.ShowHintText(WU.GetString("Error_NotEnoughGoldTicket"))
      return
    end
    WU.AcquireWindowAsync("DungeonGoldActorGroup")
  end
end

function UpdateSlot(rowRef, wrapIndex, rowIndex)
  local itemIndex = rowIndex + 1
  if itemIndex > #m_drops then
    return
  end
  local item = m_drops[itemIndex]
  rowRef["$$SetData"](item.type, item.id, item.count)
  rowRef["$$SetClickCallback"](function()
    WU.ShowResourceDetail(item.type, item.id)
  end)
end

function Focus(on)
  WU.RecordWindowFocus(100122, on)
end
