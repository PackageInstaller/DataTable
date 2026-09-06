local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local PeriodTrigger = class("PeriodTrigger", TriggerBase)
PeriodTrigger.TypeOfSection = {
  Middle = 0,
  Head = 1,
  Tail = 2,
  Null = 3,
  OutOfRange = 4
}

function PeriodTrigger:Ctor(triggertype, id, eventid, startTime, endTime)
  PeriodTrigger.super.Ctor(self, triggertype, id, eventid)
  self._start = startTime
  self._end = endTime
end

local function JudgeTime(cur, startTime, endTime)
  if not startTime or not endTime then
    return PeriodTrigger.TypeOfSection.Null
  end
  if startTime < endTime then
    if startTime < cur and cur < endTime then
      return PeriodTrigger.TypeOfSection.Middle
    elseif cur == startTime then
      return PeriodTrigger.TypeOfSection.Head
    elseif cur == endTime then
      return PeriodTrigger.TypeOfSection.Tail
    else
      return PeriodTrigger.TypeOfSection.OutOfRange
    end
  elseif startTime == endTime then
    if cur == endTime then
      return PeriodTrigger.TypeOfSection.Null
    else
      return PeriodTrigger.TypeOfSection.OutOfRange
    end
  else
    return PeriodTrigger.TypeOfSection.OutOfRange
  end
end

local function OpFunc(x, startTime, endTime, head, tail)
  local t = JudgeTime(x.value, startTime.value, endTime.value)
  if t == PeriodTrigger.TypeOfSection.Null then
    head = false
    tail = false
  end
  if head and not tail then
    t = JudgeTime(x.value, startTime.value, x.maxv)
  elseif tail and not head then
    t = JudgeTime(x.value, x.minv, endTime.value)
  elseif head and tail then
    t = JudgeTime(x.value, x.minv, x.maxv)
  end
  if t == PeriodTrigger.TypeOfSection.Middle then
    if x.next then
      return OpFunc(x.next, startTime.next, endTime.next, true, true)
    else
      return true
    end
  elseif t == PeriodTrigger.TypeOfSection.Head then
    if x.next then
      return OpFunc(x.next, startTime.next, endTime.next, true, false)
    else
      return true
    end
  elseif t == PeriodTrigger.TypeOfSection.Tail then
    if x.next then
      return OpFunc(x.next, startTime.next, endTime.next, false, true)
    else
      return true
    end
  elseif t == PeriodTrigger.TypeOfSection.Null then
    if x.next then
      return OpFunc(x.next, startTime.next, endTime.next)
    else
      return true
    end
  elseif t == PeriodTrigger.TypeOfSection.OutOfRange then
    return false
  end
end

function PeriodTrigger:OnCheck(curTime)
  local sec = {
    value = curTime.sec,
    next = nil,
    maxv = 59,
    minv = 0
  }
  local min = {
    value = curTime.min,
    next = sec,
    maxv = 59,
    minv = 0
  }
  local hour = {
    value = curTime.hour,
    next = min,
    maxv = 23,
    minv = 0
  }
  local day = {
    value = curTime.day,
    next = hour,
    maxv = 31,
    minv = 1
  }
  local month = {
    value = curTime.month,
    next = day,
    maxv = 12,
    minv = 1
  }
  local year = {
    value = curTime.year,
    next = month,
    maxv = 2100,
    minv = 1980
  }
  local ssec = {
    value = self._start.sec,
    next = nil
  }
  local smin = {
    value = self._start.min,
    next = ssec
  }
  local shour = {
    value = self._start.hour,
    next = smin
  }
  local sday = {
    value = self._start.day,
    next = shour
  }
  local smonth = {
    value = self._start.month,
    next = sday
  }
  local syear = {
    value = self._start.year,
    next = smonth
  }
  local esec = {
    value = self._end.sec,
    next = nil
  }
  local emin = {
    value = self._end.min,
    next = esec
  }
  local ehour = {
    value = self._end.hour,
    next = emin
  }
  local eday = {
    value = self._end.day,
    next = ehour
  }
  local emonth = {
    value = self._end.month,
    next = eday
  }
  local eyear = {
    value = self._end.year,
    next = emonth
  }
  local timeResult = OpFunc(year, syear, eyear)
  local weekResult = false
  local week = curTime.wday
  if week == 0 then
    week = 7
  end
  if not (self._start.wday and self._end.wday) or week >= self._start.wday and week <= self._end.wday then
    weekResult = true
  end
  return timeResult and weekResult
end

return PeriodTrigger
