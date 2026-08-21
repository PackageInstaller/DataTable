local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local ATU = require("Common/AutumnUtil")
local m_powerMultiple = 1
local m_dungeonId
local m_multiPowerOpend = false
local m_multiPowerLevelLimit = 0
local m_restTimes = 0
local m_dungeonReward, m_price, m_dungeonType, m_dungeonRecord

function Awake()
  WU.TraverseChildren(REF.PowerDropListGrid, function(go, i)
    CS.EventDelegate.Add(REF.PowerDropListGrid[i].root.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        ShowPowerDropList(false)
        m_powerMultiple = i + 1
        if m_price then
          REF.LabelCost.UILabel.text = m_powerMultiple * m_price.count
        end
      end
    end)
  end)
  local num = this:GetData("PowerMultiple")
  if num then
    m_powerMultiple = num
  end
  WU.BindButtonEvent(REF.ButtonMultiPower, OnButtonMultiPowerClick)
  WU.BindButtonEvent(REF.PowerDropListButtonMask, function()
    ShowPowerDropList(false)
  end)
end

function Start()
  ShowPowerDropList(false)
  m_multiPowerOpend = false
  this:Bind("WindowDungeon/DungeonId", OnDungeonInit)
  local type = this:GetData("FightDungeonType")
  m_dungeonType = type
  if type == PB.enum.DungeonType.Normal then
    local chapterId = this:GetData("WindowDungeon/ChapterId")
    this:Bind("fci/dungeon/chapter/" .. chapterId, function(chapter)
      SetMultiPowerStatus(chapter)
    end)
  elseif type == PB.enum.DungeonType.WeekActivity then
    if ATU.UsedForAutumn(this:GetData("Event/ActivityType")) then
      this:Bind("fci/event-dungeon/record/", function(result)
        SetMultiPowerStatus(nil)
      end)
    elseif IsEventActivity() then
      local uri = string.format("fci/activity/record/%s/%s", this:GetData("Event/ActivityType"), this:GetData("Event/ActivityId"))
      this:Bind(uri, function(result)
        SetMultiPowerStatus(nil)
      end)
    else
      this:GameRequest("fci/activity-dungeon/record/"):Get(function(result)
        this:SetData("fci/activity-dungeon/record/", result)
        SetMultiPowerStatus(nil)
      end)
    end
  elseif type == PB.enum.DungeonType.SemiFixed then
    local recordUri = "fci/activity/record/" .. PB.enum.ActivityType.Carnival91 .. "/{SemiFixed/ActivityId}/"
    this:Bind(recordUri, function(result)
      local records = result.records
      local _, record = table.find(records, function(_, v)
        return v.dungeonId == m_dungeonId
      end)
      m_dungeonRecord = record
      SetMultiPowerStatus(nil)
    end)
  else
    SetMultiPowerStatus(nil)
  end
end

function IsEventActivity()
  return this:GetData("Event/ActivityType") ~= nil and not ATU.UsedForAutumn(this:GetData("Event/ActivityType"))
end

function SetMultiPowerStatus(chapter)
  ShowPowerDropList(false)
  if not m_dungeonReward then
    REF.SpriteMultiPower.UISprite.alpha = 0.3
    REF.ButtonMultiPower.UIButton.isEnabled = false
    return
  end
  local cost = m_dungeonReward.cost[1]
  local costWin = m_dungeonReward.costWin[1]
  if cost == nil or costWin == nil or cost.type ~= PB.enum.ResourceType.ResPlayerPower or costWin.type ~= PB.enum.ResourceType.ResPlayerPower then
    WU.ToggleRendering(REF.ButtonMultiPower, false)
    return
  end
  if not DU.IsShowStar(m_dungeonId) then
    REF.ButtonMultiPower.BoxCollider2D.enabled = false
  end
  WU.ToggleRendering(REF.ButtonMultiPower, true)
  local levelData = PB.all("PlayerLevelInitConfig")
  m_multiPowerLevelLimit = 0
  for i = 1, #levelData do
    if table.has(levelData[i].unlockWindow, PB.enum.UnlockWindow.MultiPower) then
      m_multiPowerLevelLimit = levelData[i].level
      break
    end
  end
  m_multiPowerOpend = this:GetData("fci/baseinfo/").level >= m_multiPowerLevelLimit and not this:GetData("IsCultivationPVPMode")
  REF.SpriteMultiPower.UISprite.alpha = fif(m_multiPowerOpend, 1, 0.3)
  if not m_multiPowerOpend then
    return
  end
  local starCount = 1
  local lastMultiPower = 1
  local dungeonRecord
  local type = this:GetData("FightDungeonType")
  if type == PB.enum.DungeonType.Normal then
    dungeonRecord = chapter and chapter.recordDungeons[m_dungeonId]
  elseif type == PB.enum.DungeonType.WeekActivity then
    local record
    if ATU.UsedForAutumn(this:GetData("Event/ActivityType")) then
      record = this:GetData("fci/event-dungeon/record/")
    elseif IsEventActivity() then
      record = this:GetData(string.format("fci/activity/record/%s/%s/", this:GetData("Event/ActivityType"), this:GetData("Event/ActivityId"))).records
    else
      record = this:GetData("fci/activity-dungeon/record/")
    end
    local _
    _, dungeonRecord = _ENV["!"](record):find(function(k, v)
      return v.dungeonId == m_dungeonId
    end)
  elseif type == PB.enum.DungeonType.SemiFixed then
    dungeonRecord = m_dungeonRecord
  end
  if dungeonRecord ~= nil then
    if dungeonRecord.finished then
      starCount = #dungeonRecord.targetsDone
    end
    if dungeonRecord.multiPower ~= 0 then
      lastMultiPower = dungeonRecord.multiPower
    end
    local dungeonReward = PB.get("DungeonReward", m_dungeonId)
    local doneTimes = dungeonRecord.doneTimes or 0
    m_restTimes = math.max(0, dungeonReward.enterTimes - doneTimes)
  end
  for i = 0, 2 do
    local choice = REF.PowerDropListGrid[i]
    choice.LabelStarReq.UILabel.text = fif(i == 0, "", WU.GetString("Window_starCountToUnlock", i + 1))
    choice.LabelPower.ResourcePrinter:SetResource(cost.type, cost.id, (i + 1) * (cost.count + costWin.count))
    choice.root.UIToggle.optionCanBeNone = true
    choice.root.UIToggle.value = false
    choice.root.UIToggle.optionCanBeNone = false
    choice.root.BoxCollider2D.enabled = starCount > i and (m_restTimes == 0 or i < m_restTimes)
    choice.LabelPower.UIHtmlLabel.color = fif(starCount > i, CS.NGUIMath.HexToColor(4294967295), CS.NGUIMath.HexToColor(2948455935))
    local timesLimited = 0 < m_restTimes and i >= m_restTimes
    WU.ToggleRendering(choice.LabelTimeLimit, timesLimited)
    WU.ToggleRendering(choice.LabelStarReq, not timesLimited and starCount <= i)
  end
  local selectIndex = fif(m_restTimes == 0 or m_restTimes > lastMultiPower - 1, lastMultiPower - 1, 0)
  REF.PowerDropListGrid[selectIndex].root.UIToggle.value = true
end

function ShowPowerDropList(visible)
  WU.ToggleRendering(REF.PowerDropList, visible)
end

function OnButtonMultiPowerClick()
  if m_multiPowerOpend then
    ShowPowerDropList(true)
  elseif this:GetData("IsCultivationPVPMode") then
    WU.ShowHintText(WU.GetString("Window_CultivationPVPNotSupportMultiPower"))
  else
    WU.ShowHintText(WU.GetString("Window_MultiPowerLevelNotReach", m_multiPowerLevelLimit))
  end
end

function GetPowerMultiple()
  return m_powerMultiple
end

function OnDungeonInit(dungeonId)
  if dungeonId then
    m_dungeonId = dungeonId
    local own = this:GetData("fci/resource/ResPlayerPower_0")
    REF.StockPower.UIHtmlLabel.text = tostring(own)
    m_dungeonReward = PB.get("DungeonReward", m_dungeonId)
    m_price = DU.GetDungeonPrice(dungeonId)
    if m_price then
      REF.LabelCost.UILabel.text = m_powerMultiple * m_price.count
    end
    if WU.IsStandaloneGame() then
      REF.LabelCost.gameObject:SetActive(false)
    end
  end
end
