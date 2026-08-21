local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local GU = require("Common/GroupUtil")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local RU = require("Common/RedMarkUtil")
local TriggeredEventTicket = {
  type = PB.enum.ResourceType.ResItem,
  id = PB.all("Misc"):first().triggeredEventTickets[1]
}
local m_data, m_selection, m_dropDisplay, m_dungeonId, m_costWin
local m_closedEvents = {}

function SetupWindow()
  WU.BindButtonEvent(REF.DetailInfo, function()
    WU.AcquireWindowAsync("DungeonDetail", function(ui)
      _ENV["$"](ui)["$$SetData"](m_dungeonId)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonFightPrepare, function()
    WU.RecordButtonClick(100119002)
    local level = this:GetData("fci/baseinfo/").level
    if level < m_selection.level then
      WU.ShowHintText(WU.GetString("TriggeredEvent_LevelNotReach"))
      return
    end
    WU.AcquireWindowAsync("TriggeredActorGroup", function()
      this:SetData("CurrentTriggeredEvent", m_selection.data)
      this:SetData("TriggeredActorGroup/DungeonId", m_selection.data.eventId)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonFind, OnSearchTriggeredEvent)
  WU.BindButtonEvent(REF.ButtonSearch, OnSearchTriggeredEvent)
  WU.TraverseChildren(REF.ActivityContent, function(go)
    _ENV["$"](go)["$$SetClickCallback"](OnTriggeredEventSelected)
  end)
  LU.Bind(REF.ActivityContent, {
    updateRow = UpdateSlot
  })
  LU.Bind(REF.DropContent, {
    updateRow = UpdateDropSlot
  })
end

function InitWindow()
  m_selection = nil
  REF.EmptyHint.gameObject:SetActive(false)
  REF.NotEmpty.gameObject:SetActive(false)
  this:RegisterGameEvent("TriggeredEventClose", function(events)
    table.append(m_closedEvents, events)
  end)
  this:RegisterGameEvent("TriggeredEventNew", function()
    local top = WU.TopWindow()
    if top and top.name == "TriggeredEvent" then
      WU.ShowHintText(WU.GetString("TriggeredEvent_NewEventReceived"))
    end
  end)
  this:BindRemote(DB:GameRequest("fci/triggered-event/"), OnTriggeredEventList)
  REF.WidgetTicketLabel["$UpdateTickets"](TriggeredEventTicket)
  REF.WidgetTicketLabel1["$UpdateTickets"](TriggeredEventTicket)
  RU.SetRedMark(string.format("Activity/%s/CanPlay", PB.enum.ActivityType.TriggeredEvent), false)
  this:SetData("triggeredEventRedMarkViewed", true)
end

function UninitWindow()
  this:SetData("TriggeredEvent/TimeElapse", nil)
end

function UpdateWindow(delta)
  local timeElapse = this:GetData("TriggeredEvent/TimeElapse") or {}
  local closedEvents = _ENV["!"]({})
  for k, data in pairs(timeElapse) do
    data.secondsPossess = data.secondsPossess - delta
    if data.time <= CS.GameTime.serverUtc + 1 or data.secondsPossess <= 1 then
      timeElapse[k] = nil
      table.insert(closedEvents, data.eventKey)
    end
  end
  table.append(m_closedEvents, closedEvents)
end

function LateUpdateWindow()
  if table.empty(m_closedEvents) then
    return
  end
  local triggeredEvent = this:GetData("fci/triggered-event/")
  local cntOld = #triggeredEvent.eventInfo
  for i = 1, #m_closedEvents do
    DBH.DBRemove(triggeredEvent.eventInfo, "eventKey", m_closedEvents[i])
  end
  m_closedEvents = {}
  this:SetData("fci/triggered-event/", triggeredEvent)
  local top = WU.TopWindow()
  if cntOld ~= #triggeredEvent.eventInfo and top and top.name == "TriggeredEvent" then
    WU.ShowHintText(WU.GetString("TriggeredEvent_DeleteRefresh"))
  end
end

function OnTriggeredEventList(result)
  if result ~= nil then
    local canSearch = result.displayTriggeredEventTicket
    REF.SearchNode.gameObject:SetActive(canSearch)
    REF.EmptySearch.gameObject:SetActive(canSearch)
    REF.LabelHint.UILabel.text = fif(canSearch, WU.GetString("TriggeredEvent_Empty"), WU.GetString("TriggeredEvent_EmptyNoSearch"))
    m_data = _ENV["!"]({})
    for i = 1, #result.eventInfo do
      local row = {
        data = result.eventInfo[i],
        type = result.eventInfo[i].eventType,
        level = 0
      }
      if result.eventInfo[i].eventType == PB.enum.TriggeredEventType.Dungeon then
        row.level = DungeonLevel(result.eventInfo[i].eventId)
        table.insert(m_data, row)
      else
        warning("todo", "todo")
      end
    end
    local empty = table.empty(m_data)
    REF.EmptyHint.gameObject:SetActive(empty)
    REF.NotEmpty.gameObject:SetActive(not empty)
    table.sort(m_data, function(v1, v2)
      if v1.level ~= v2.level then
        return v1.level > v2.level
      else
        return v1.data.lastTime + v1.data.createTime < v2.data.lastTime + v2.data.createTime
      end
    end)
    local newTriggeredEvent = this:GetData("TriggeredEvent/New")
    if newTriggeredEvent ~= nil then
      m_selection = {
        data = newTriggeredEvent,
        level = newTriggeredEvent.eventLevel
      }
      this:SetData("TriggeredEvent/New", nil)
    end
    local contentPivot = fif(#m_data < #REF.ActivityContent - 1, CS.UIWidget.Pivot.Center, CS.UIWidget.Pivot.TopLeft)
    REF.ActivityScrollView.UIScrollView.contentPivot = contentPivot
    LU.Set(REF.ActivityContent, #m_data)
    local find = table.find(m_data, function(_, v)
      return m_selection ~= nil and v.data.eventKey == m_selection.data.eventKey
    end)
    if not empty then
      if find == nil then
        OnTriggeredEventSelected(REF.ActivityContent[0]["$gameObject"])
      elseif contentPivot == CS.UIWidget.Pivot.TopLeft then
        local relative = math.max(find + 2 - #REF.ActivityContent, 0)
        REF.ActivityScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(-relative * REF.ActivityContent.UIWrapContent.itemSize, 0, 0))
      end
    else
      m_selection = nil
    end
  end
end

function UpdateSlot(ref, wrapIndex, realIndex)
  if m_data ~= nil and realIndex < #m_data then
    local row = m_data[realIndex + 1]
    ref["$$SetData"](row.data, row.type, row.level)
    local flag = m_selection ~= nil and m_selection.data.eventKey == row.data.eventKey
    ref.SelectedSprite.gameObject:SetActive(flag)
    if flag and ref["@type"] == PB.enum.TriggeredEventType.Dungeon then
      m_dungeonId = row.data.eventId
      InitDropList(row.data.eventId)
    end
  end
end

function UpdateDropSlot(ref, wrapIndex, realIndex)
  if m_dropDisplay ~= nil and realIndex < #m_dropDisplay then
    local widgetIconSlot = ref.root
    local dropDisplay = m_dropDisplay[realIndex + 1]
    if dropDisplay.type == PB.enum.ResourceType.ResPlayerGold or dropDisplay.type == PB.enum.ResourceType.ResPlayerExp or dropDisplay.type == PB.enum.ResourceType.ResItem then
      widgetIconSlot["$SetData"](dropDisplay.type, dropDisplay.id, dropDisplay.count)
    else
      widgetIconSlot["$SetData"](dropDisplay.type, dropDisplay.id)
    end
    widgetIconSlot["$SetClickCallback"](function()
      WU.ShowResourceDetail(dropDisplay.type, dropDisplay.id)
    end)
  end
end

function InitDropList(dungeonId)
  local reward = PB.get("DungeonReward", dungeonId)
  if reward == nil then
    warning("TriggeredEvent", "no reward view dungeonId : " .. dungeonId)
    return
  end
  REF.WidgetTicketLabelEnter["$UpdateTickets"](reward.costWin[1])
  m_costWin = reward.costWin[1]
  m_dropDisplay = {}
  for k, v in pairs(reward.dropDisplay) do
    m_dropDisplay[k] = v
  end
  LU.Set(REF.DropContent, #m_dropDisplay)
end

function OnTriggeredEventSelected(go)
  WU.RecordButtonClick(100119001)
  local ref = _ENV["$"](go)
  m_selection = {
    data = ref["@data"],
    level = ref["@level"]
  }
  LU.Set(REF.ActivityContent, #m_data, false, true)
end

function OnSearchTriggeredEvent()
  this:GameRequest("fci/triggered-event/"):Post({
    ticketId = TriggeredEventTicket.id
  }, function(result)
    DBH.ResChange(result.resChange)
    result.resChange = nil
    local newEventList = table.select(result.eventInfo, function(v)
      local index = table.find(m_data, function(_, row)
        return row.data.eventKey == v.eventKey
      end)
      if index == nil then
        return v
      end
    end):toarray()
    if table.empty(newEventList) then
      return
    end
    local level = 0
    if newEventList[1].eventType == PB.enum.TriggeredEventType.Dungeon then
      level = DungeonLevel(newEventList[1].eventId)
    end
    m_selection = {
      data = newEventList[1],
      level = level
    }
    this:SetData("fci/triggered-event/", result)
  end)
end

function FocusOn(eventKey)
  local exist = this:GetData("fci/triggered-event/")
  if exist then
    local _, target = table.find(m_data, function(_, v)
      return v.data.eventKey == eventKey
    end)
    if target ~= nil then
      m_selection = {
        data = target.data,
        level = target.level
      }
      this:SetData("fci/triggered-event/", exist)
    end
  else
    this:GameRequest("fci/triggered-event/"):Get(function(result)
      local _, target = table.find(result.eventInfo, function(_, v)
        return v.eventKey == eventKey
      end)
      if target ~= nil and target.eventType == PB.enum.TriggeredEventType.Dungeon then
        m_selection = {
          data = target,
          level = DungeonLevel(target.eventId)
        }
      end
      this:SetData("fci/triggered-event/", result)
    end)
  end
end

function DungeonLevel(dungeonId)
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if dungeonReward ~= nil then
    return dungeonReward.unlockLevel
  else
    warning("DungeonReward.xlsx", "can't find id " .. tostring(dungeonId))
  end
  return 0
end
