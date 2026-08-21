local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_callback, m_timeCountdown

function Start()
  WU.BindButtonEvent(REF.Button, function()
    if m_callback ~= nil then
      m_callback(REF["$gameObject"])
    end
  end)
end

function SetClickCallback(callback)
  m_callback = callback
end

function RefreshTimeElapse(data)
  local time = data.lastTime + data.createTime
  local timeElapse = this:GetData("TriggeredEvent/TimeElapse") or _ENV["!"]({})
  if time > CS.GameTime.serverUtc + 1 then
    m_timeCountdown = {
      eventKey = data.eventKey,
      time = time,
      secondsPossess = time - CS.GameTime.serverUtc - 1
    }
    timeElapse[data.eventKey] = m_timeCountdown
  else
    this:BroadcastGameEvent("TriggeredEventClose", {
      data.eventKey
    })
  end
  this:SetData("TriggeredEvent/TimeElapse", timeElapse)
end

function SetData(data, type, level)
  RefreshTimeElapse(data)
  if REF["@data"] ~= nil and REF["@data"].eventKey == data.eventKey then
    return
  end
  REF["@type"] = type
  REF["@data"] = data
  REF["@level"] = level
  if type == PB.enum.TriggeredEventType.Dungeon then
    SetTypeDungeon(data, level)
  else
    warning("todo", "todo")
  end
end

function Update(delta)
  if m_timeCountdown and m_timeCountdown.secondsPossess > 1 then
    SetCountDown(m_timeCountdown.secondsPossess)
  end
end

function SetTypeDungeon(data, level)
  local dungeonReward = PB.get("DungeonReward", data.eventId)
  if dungeonReward then
    REF.MainSprite.UISprite.spriteName = "trigger_event_" .. dungeonReward.displayType or 1
  else
    warning("DungeonReward.xlsx", "can't find id " .. tostring(data.eventId))
    REF.MainSprite.UISprite.spriteName = "trigger_event_1"
  end
  REF.LabelName.UILabel.text = WU.GetString("DungeonName_" .. data.eventId)
  REF.DungeonHint.UIHtmlLabel.text = ""
  REF.DungeonLevel.UILabel.text = WU.GetString("Window_Level", level)
end

function SetCountDown(time)
  if 1 < time then
    REF.DungeonHint.UIHtmlLabel.text = WU.RenderCountDownTime(time, REF.DungeonHint.UIHtmlLabel.fontSize)
  end
end
