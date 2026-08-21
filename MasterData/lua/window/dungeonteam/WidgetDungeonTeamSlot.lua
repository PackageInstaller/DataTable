local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_activity, m_weekdays, m_dayToday, m_isMultiple, m_isOpen, m_multipleId, firstTime

function Start()
  m_dayToday = U.ToInt(CS.GameTime.serverNow.DayOfWeek)
  if m_dayToday == 0 then
    m_dayToday = 7
  end
  WU.BindButtonEvent(REF["$"], OnButtonChooseClick)
  WU.BindButtonEvent(REF.LockedHint, function()
    WU.ShowHintText(WU.GetString("DungeonTeam_ActivityNotOpen"))
  end)
end

function ModifyContent(activity)
  if activity == nil then
    return
  end
  m_activity = activity
  SetMultiple()
  SetOpenOrNot()
  REF["@activityId"] = m_activity.activityId
  local needShowTime = true
  REF.LabelMaterialTitle.gameObject:SetActive(needShowTime)
  REF.LabelMaterialTime.gameObject:SetActive(needShowTime)
  REF.SpriteLock.gameObject:SetActive(not m_isOpen)
  REF.root.BoxCollider2D.enabled = m_isOpen
  if needShowTime then
    local days = ""
    for i = 1, #m_weekdays do
      if i < #m_weekdays then
        days = days .. WU.GetString("Window_Number_" .. m_weekdays[i]) .. "/"
      else
        days = days .. WU.GetString("Window_Number_" .. m_weekdays[i])
      end
    end
    REF.LabelMaterialTime.UILabel.text = WU.GetString("Window_EveryWeek") .. days .. WU.GetString("Window_Open")
  end
end

function OnButtonChooseClick()
  if m_activity and m_isOpen then
    this:BroadcastGameEvent("ActivitySelect", m_activity)
  end
end

function SetOpenOrNot()
  m_isOpen = false
  for i = 1, #m_weekdays do
    if m_weekdays[i] == m_dayToday and CS.GameTime.serverUtc > m_activity.timestampStart then
      m_isOpen = true
      break
    end
  end
end

function SetMultiple()
  m_isMultiple = false
  local multupleDays
  m_multipleId = 0
  local tab = PB.get("ActivityDungeon", m_activity.activityId)
  if tab ~= nil then
    m_multipleId = tab.multipleActivityId
  end
  local activityTable = PB.get("ActivityDungeon", m_multipleId)
  if activityTable ~= nil and activityTable.multiple > 1 then
    multupleDays = activityTable.multipleDay
    for i = 1, #multupleDays do
      if m_dayToday == multupleDays[i] then
        m_isMultiple = true
        break
      end
    end
  end
  REF.SpriteMultuple.gameObject:SetActive(m_isMultiple)
  m_weekdays = m_activity.weekdays
  if multupleDays ~= nil then
    for i = 1, #multupleDays do
      if 0 < multupleDays[i] and not _ENV["!"](m_weekdays):find(function(k, v)
        return v == multupleDays[i]
      end) then
        table.insert(m_weekdays, multupleDays[i])
      end
    end
  end
end

function IsOpen()
  return m_isOpen
end
