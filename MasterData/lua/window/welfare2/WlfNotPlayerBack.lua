local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_misc = PB.index("Misc", 1)
local m_activityManager = S:Get("ActivityManager")
local m_clientFlag, m_activeTime, m_url1, m_activityInfo

function Awake()
  WU.BindButtonEvent(REF.ButtonVideo, function()
    if m_url1 then
      WU.OpenUrl(m_url1)
    end
  end)
end

function OnEnable()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.NotPlayerBack, function(activityList)
    if activityList then
      for k, v in pairs(activityList) do
        if v.type == PB.enum.ActivityType.NotPlayerBack and ACU.IsOpenForDoing(v) then
          m_activityInfo = v
          SetTime()
          break
        end
      end
    end
  end)
  this:Bind("fci/half-year-not-back-activity", OnActivityInfoChange)
end

function OnActivityInfoChange(activityInfo)
  if activityInfo == nil then
    return
  end
  if activityInfo.videoUrl and activityInfo.videoUrl[1] then
    m_url1 = activityInfo.videoUrl[1]
  end
end

function SetTime()
  local nowTime = CS.GameTime.serverUtc - m_activityInfo.timestampStart
  local allTime = m_activityInfo.timestampEnd - m_activityInfo.timestampStart
  local timeSpanNow = CS.System.TimeSpan(0, 0, nowTime)
  local timeSpanAll = CS.System.TimeSpan(0, 0, allTime)
  local startTime = CS.GameTime.UtcToLocal(m_activityInfo.timestampStart)
  local endTime = CS.GameTime.UtcToLocal(m_activityInfo.timestampEnd)
  REF.LabelLastTime.UIHtmlLabel.text = WU.GetString("Window_Month_Day_Hour", startTime.Month, startTime.Day, startTime.Hour) .. " ~ " .. WU.GetString("Window_Month_Day_Hour", endTime.Month, endTime.Day, endTime.Hour + 1)
end
