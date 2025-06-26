-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/period/periodtrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local PeriodTrigger = class("PeriodTrigger", TriggerBase)
PeriodTrigger.TypeOfSection = {Middle = 0, Head = 1, Tail = 2, Null = 3, OutOfRange = 4}
PeriodTrigger.Ctor = function(self, triggertype, id, eventid, startTime, endTime)
  -- function num : 0_0 , upvalues : PeriodTrigger
  ((PeriodTrigger.super).Ctor)(self, triggertype, id, eventid)
  self._start = startTime
  self._end = endTime
end

local JudgeTime = function(cur, startTime, endTime)
  -- function num : 0_1 , upvalues : PeriodTrigger
  if not startTime or not endTime then
    return (PeriodTrigger.TypeOfSection).Null
  end
  if startTime < endTime then
    if startTime < cur and cur < endTime then
      return (PeriodTrigger.TypeOfSection).Middle
    else
      if cur == startTime then
        return (PeriodTrigger.TypeOfSection).Head
      else
        if cur == endTime then
          return (PeriodTrigger.TypeOfSection).Tail
        else
          return (PeriodTrigger.TypeOfSection).OutOfRange
        end
      end
    end
  else
    if startTime == endTime then
      if cur == endTime then
        return (PeriodTrigger.TypeOfSection).Null
      else
        return (PeriodTrigger.TypeOfSection).OutOfRange
      end
    else
      return (PeriodTrigger.TypeOfSection).OutOfRange
    end
  end
end

local OpFunc = function(x, startTime, endTime, head, tail)
  -- function num : 0_2 , upvalues : JudgeTime, PeriodTrigger, OpFunc
  local t = JudgeTime(x.value, startTime.value, endTime.value)
  if t == (PeriodTrigger.TypeOfSection).Null then
    head = false
    tail = false
  end
  if head and not tail then
    t = JudgeTime(x.value, startTime.value, x.maxv)
  else
    if tail and not head then
      t = JudgeTime(x.value, x.minv, endTime.value)
    else
      if head and tail then
        t = JudgeTime(x.value, x.minv, x.maxv)
      end
    end
  end
  if t == (PeriodTrigger.TypeOfSection).Middle then
    if x.next then
      return OpFunc(x.next, startTime.next, endTime.next, true, true)
    else
      return true
    end
  else
    if t == (PeriodTrigger.TypeOfSection).Head then
      if x.next then
        return OpFunc(x.next, startTime.next, endTime.next, true, false)
      else
        return true
      end
    else
      if t == (PeriodTrigger.TypeOfSection).Tail then
        if x.next then
          return OpFunc(x.next, startTime.next, endTime.next, false, true)
        else
          return true
        end
      else
        if t == (PeriodTrigger.TypeOfSection).Null then
          if x.next then
            return OpFunc(x.next, startTime.next, endTime.next)
          else
            return true
          end
        else
          if t == (PeriodTrigger.TypeOfSection).OutOfRange then
            return false
          end
        end
      end
    end
  end
end

PeriodTrigger.OnCheck = function(self, curTime)
  -- function num : 0_3 , upvalues : OpFunc
  local sec = {value = curTime.sec, next = nil, maxv = 59, minv = 0}
  local min = {value = curTime.min, next = sec, maxv = 59, minv = 0}
  local hour = {value = curTime.hour, next = min, maxv = 23, minv = 0}
  local day = {value = curTime.day, next = hour, maxv = 31, minv = 1}
  local month = {value = curTime.month, next = day, maxv = 12, minv = 1}
  local year = {value = curTime.year, next = month, maxv = 2100, minv = 1980}
  local ssec = {value = (self._start).sec, next = nil}
  local smin = {value = (self._start).min, next = ssec}
  local shour = {value = (self._start).hour, next = smin}
  local sday = {value = (self._start).day, next = shour}
  local smonth = {value = (self._start).month, next = sday}
  local syear = {value = (self._start).year, next = smonth}
  local esec = {value = (self._end).sec, next = nil}
  local emin = {value = (self._end).min, next = esec}
  local ehour = {value = (self._end).hour, next = emin}
  local eday = {value = (self._end).day, next = ehour}
  local emonth = {value = (self._end).month, next = eday}
  local eyear = {value = (self._end).year, next = emonth}
  local timeResult = OpFunc(year, syear, eyear)
  local weekResult = false
  local week = curTime.wday
  if week == 0 then
    week = 7
  end
  if not (self._start).wday or not (self._end).wday or (self._start).wday <= week and week <= (self._end).wday then
    weekResult = true
  end
  return not timeResult or weekResult
end

return PeriodTrigger

