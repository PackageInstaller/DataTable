local UnityTime = UnityEngine.Time
local M = {}
local _floor = math.floor
local SERVER_TO_CLIENT_OFFSET = 0
local LAST_SYNC_TIME = 0
local SYNC_INTERVAL = 5
local FIRST_SYNC_SERVER_TIME = 0
local FIRST_SYNC_CLIENT_REAL_TIME = 0
local SERVER_TIME_ZONE = 0
M.SERVER_TIME_SCHEME = "CN"
local LOCAL_TIME_OFFSET = 0
local DAY_HOUR = 24
local MINUTE_SEC = 60
local HOUR_SEC = MINUTE_SEC * 60
local DAY_SEC = HOUR_SEC * DAY_HOUR
local LOCAL_TIME_ZONE = os.difftime(os.time(), os.time(os.date("!*t"))) / HOUR_SEC
local today = os.date("*t", os.time())
today.hour = 0
today.sec = 0
today.sec = 0
M.TODAY_SEC = os.time(today)
M.TODAY_DATE = today
local timetable = {
  year = 0,
  month = 0,
  day = 0,
  hour = 0
}
local _os_date = os.date
local _os_time = os.time

function M.set_time_zone(time_zone)
  SERVER_TIME_ZONE = time_zone
  LOCAL_TIME_OFFSET = (SERVER_TIME_ZONE - LOCAL_TIME_ZONE) * HOUR_SEC
end

function M.set_time_scheme(time_scheme)
  M.SERVER_TIME_SCHEME = time_scheme
end

function M.get_local_time_offset()
  return LOCAL_TIME_OFFSET
end

function M.now()
  return os.time()
end

function M.server_time()
  if 0 == FIRST_SYNC_SERVER_TIME then
    return os.time()
  end
  local real_time = _floor(Global.real_time)
  return FIRST_SYNC_SERVER_TIME + SERVER_TO_CLIENT_OFFSET + (real_time - FIRST_SYNC_CLIENT_REAL_TIME)
end

function M.get_server_time_date()
  local date = os.date("*t", M.server_time() + LOCAL_TIME_OFFSET)
  return date
end

function M.adjust_server_time_offset(server_time)
  if server_time - LAST_SYNC_TIME < SYNC_INTERVAL then
    return
  end
  LAST_SYNC_TIME = server_time
  local real_time = _floor(Global.real_time)
  if 0 == FIRST_SYNC_SERVER_TIME then
    FIRST_SYNC_SERVER_TIME = server_time
    FIRST_SYNC_CLIENT_REAL_TIME = real_time
  end
  SERVER_TO_CLIENT_OFFSET = server_time - (real_time - FIRST_SYNC_CLIENT_REAL_TIME) - FIRST_SYNC_SERVER_TIME
end

function M.standard_data(time)
  return os.date("!%m/%d %H:%M", time + SERVER_TIME_ZONE * HOUR_SEC)
end

function M.standard_data2(time)
  return os.date("!%Y-%m-%d %H:%M", time + SERVER_TIME_ZONE * HOUR_SEC)
end

function M.standard_data_m_d(time)
  return os.date("!%m-%d", time + SERVER_TIME_ZONE * HOUR_SEC)
end

function M.standard_data_y_m_d(time)
  return os.date("!%Y.%m.%d", time + SERVER_TIME_ZONE * HOUR_SEC)
end

function M.get_time_year_month_day(time)
  return os.date("!%Y.%m.%d", time)
end

function M.string_to_timestamp()
  return Global.time
end

function M.time()
  return Global.time
end

function M.delta_time()
  return Global.delta_time
end

function M.real_time()
  return Global.real_time
end

function M.to_timestamp(time_table)
  return os.time(time_table) - LOCAL_TIME_OFFSET
end

function M.string_to_timestamp(str)
  local year, month, day, hour, min, sec = str:match("(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)")
  local timeStep = {
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = tonumber(hour),
    min = tonumber(min),
    sec = tonumber(sec)
  }
  return M.to_timestamp(timeStep)
end

function M.get_week()
  local time = os.date("!*t", M.server_time())
  local y, m, d = time.year, time.month, time.day
  if 1 == m or 2 == m then
    m = m + 12
    y = y - 1
  end
  local m1, _ = math.modf(3 * (m + 1) / 5)
  local m2, _ = math.modf(y / 4)
  local m3, _ = math.modf(y / 100)
  local m4, _ = math.modf(y / 400)
  local iWeek = (d + 2 * m + m1 + y + m2 - m3 + m4) % 7 + 1
  return iWeek
end

function M.to_offline_time_text(leave_time)
  if 0 == leave_time then
    return "在线"
  end
  return "离线"
end

function M.to_leave_cd_text()
end

function M.get_time_tbl()
  local server_time = math.floor(M.server_time())
  return os.date("!*t", server_time)
end

function M.get_print_count_down(sec)
  if sec > HOUR_SEC then
    return string.format("%02d:%02d:%02d", _floor(sec / HOUR_SEC), _floor(sec % HOUR_SEC / MINUTE_SEC), _floor(sec % MINUTE_SEC))
  else
    return string.format("%02d:%02d", _floor(sec / MINUTE_SEC), _floor(sec % MINUTE_SEC))
  end
end

function M.get_long_count_down(sec)
  return string.format("%02d:%02d:%02d", _floor(sec / HOUR_SEC), _floor(sec % HOUR_SEC / MINUTE_SEC), _floor(sec % MINUTE_SEC))
end

function M.get_day_desc(create_time, duration, now_time)
  local end_time = create_time + duration
  local remain_time = end_time - now_time
  local day = math.modf(remain_time / DAY_SEC)
  return day
end

function M.get_time_desc(seconds, not_show_second, not_show_second_keep_hour)
  local day = math.modf(seconds / DAY_SEC)
  if day > 0 then
    local hours = math.modf(math.fmod(seconds, DAY_SEC) / HOUR_SEC)
    return Util.format_str("{1}天{2}时", day, hours)
  end
  local hours = math.modf(seconds / HOUR_SEC)
  if hours > 0 then
    local mins = math.modf(math.fmod(seconds, HOUR_SEC) / MINUTE_SEC)
    return Util.format_str("{1}时{2}分", hours, mins)
  end
  local mins = math.modf(seconds / MINUTE_SEC)
  local secs = math.modf(math.fmod(seconds, MINUTE_SEC))
  if not not_show_second then
    if mins > 0 then
      return Util.format_str("{1}分{2}秒", mins, secs)
    else
      return Util.format_str("{1}秒", secs)
    end
  else
    local hour_str = not_show_second_keep_hour and "0时" or ""
    if mins > 0 then
      return Util.format_str("{1}{2}分", hour_str, mins)
    else
      return Util.format_str("{1}1分", hour_str)
    end
  end
end

function M.get_time_desc2(seconds, not_show_min)
  local day = math.modf(seconds / DAY_SEC)
  if day > 31 then
    return Util.format_str("31天", day)
  end
  if day > 0 then
    return Util.format_str("{1}天", day)
  end
  local hours = math.modf(seconds / HOUR_SEC)
  if hours > 0 or not_show_min then
    return Util.format_str("{1}时", hours)
  end
  local mins = math.modf(seconds / MINUTE_SEC)
  if mins > 0 then
    return Util.format_str("{1}分钟", mins)
  else
    return Util.format_str("1分钟")
  end
end

function M.get_time_formate_1(seconds)
  local day = math.modf(seconds / DAY_SEC)
  local hours = math.modf(math.fmod(seconds, DAY_SEC) / HOUR_SEC)
  local mins = math.modf(math.fmod(seconds, HOUR_SEC) / MINUTE_SEC)
  return Util.format_str("{1}天{2}时{3}分", day, hours, mins)
end

function M.get_next_month_time(now, day, hour)
  local t = _os_date("!*t", now)
  if day < t.day then
    t.month = t.month + 1
  elseif t.day == day and hour < t.hour then
    t.month = t.month + 1
  end
  t.day = day
  t.hour = hour
  t.min, t.sec = 0, 0
  return M.to_timestamp(t)
end

function M.get_time_stamp(day, hours)
  local cur_time_stamp = M.server_time()
  local add_time_stamp = 86400 * day
  local temp_time_stamp = cur_time_stamp + add_time_stamp
  local temp_date = os.date("!*t", temp_time_stamp)
  local target_date = {}
  target_date.year = temp_date.year
  target_date.month = temp_date.month
  target_date.day = temp_date.day
  target_date.hour = hours
  return M.to_timestamp(target_date)
end

function M.get_day_start(target_timestamp)
  local daily_reset_hour = Global.daily_reset_hour or 5
  local _timetable = os.date("*t", target_timestamp + LOCAL_TIME_OFFSET)
  local target_time_hour = _timetable.hour
  _timetable.hour = daily_reset_hour
  _timetable.min = 0
  _timetable.sec = 0
  local day_timestamp = M.to_timestamp(_timetable)
  if daily_reset_hour > target_time_hour then
    day_timestamp = day_timestamp - DAY_SEC
  end
  return day_timestamp
end

function M.get_time_formate_2(seconds, not_show_min)
  local day = math.modf(seconds / DAY_SEC)
  local hours_sec = seconds - day * DAY_SEC
  local hours = math.modf(hours_sec / HOUR_SEC)
  if day > 0 then
    return Util.format_str("{1}天{2}时", day, hours)
  else
    local mins_sec = math.modf(seconds % HOUR_SEC)
    local mins = math.modf(mins_sec / MINUTE_SEC)
    if not_show_min then
      hours = math.max(1, hours)
      return Util.format_str("{1}时", hours)
    else
      mins = math.max(1, mins)
      return Util.format_str("{1}时{2}分", hours, mins)
    end
  end
end

function M.get_time_formate_3(seconds)
  return os.date("!%Y/%m/%d", seconds)
end

function M.get_time_formate_3_1(seconds)
  local time_table = os.date("*t", seconds)
  return string.format("%02d.%02d", time_table.month, time_table.day)
end

function M.get_time_formate_3_2(seconds)
  local time_table = os.date("*t", seconds)
  return string.format("%d月%d日", time_table.month, time_table.day)
end

function M.get_time_formate_4(seconds, need_sec, single_day)
  local hours = math.modf(seconds / HOUR_SEC)
  if single_day then
    hours = math.modf(hours % DAY_HOUR)
  end
  local mins = math.modf(math.modf(seconds % HOUR_SEC) / MINUTE_SEC)
  if need_sec then
    local sec = math.fmod(seconds, MINUTE_SEC)
    return string.format("%02d:%02d:%02d", hours, mins, sec)
  else
    return string.format("%02d:%02d", hours, mins)
  end
end

function M.get_time_formate_5(seconds, need_sec, single_day)
  local hours = math.modf(seconds / HOUR_SEC)
  if single_day then
    hours = math.modf(hours % DAY_HOUR)
  end
  local mins = math.modf(math.modf(seconds % HOUR_SEC) / MINUTE_SEC)
  if need_sec then
    local sec = math.floor(math.fmod(seconds, MINUTE_SEC))
    return string.format("%.2d时%.2d分%.2d秒", hours, mins, sec)
  else
    return string.format("%.2d时%.2d分", hours, mins)
  end
end

function M.get_time_formate_6(seconds, day_str, hour_str)
  local day = math.modf(seconds / DAY_SEC)
  local hours_sec = seconds - day * DAY_SEC
  local hours = math.modf(hours_sec / HOUR_SEC)
  if day > 0 then
    return string.format(day_str, day, hours)
  else
    local mins_sec = math.modf(seconds % HOUR_SEC)
    local mins = math.modf(mins_sec / MINUTE_SEC)
    return string.format(hour_str, hours, mins)
  end
end

function M.get_time_format_7(seconds)
  local day = math.modf(seconds / DAY_SEC)
  local hour_sec = seconds - day * DAY_SEC
  local hour = math.modf(hour_sec / HOUR_SEC)
  if day > 0 then
    return Util.format_str("{1}天{2}时", day, hour)
  end
  local min_sec = math.modf(seconds % HOUR_SEC)
  local min = math.modf(min_sec / MINUTE_SEC)
  if hour > 0 then
    if 1 == hour and 0 == min then
      return Util.format_str("{1}分", 60)
    end
    return Util.format_str("{1}时{2}分", hour, min)
  end
  return Util.format_str("{1}分", min < 1 and 1 or min)
end

function M.on_daily_reset(data)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_DAILY_RESET)
  msg.mm_obj = data.wday
end

function M.is_daily_first(last_timestamp)
  local cur_timestamp = Date.server_time()
  local duration_in_hour = (cur_timestamp - last_timestamp) // HOUR_SEC
  if duration_in_hour > 23 then
    return true
  else
    timetable.year = os.date("%Y", cur_timestamp)
    timetable.month = os.date("%m", cur_timestamp)
    timetable.day = os.date("%d", cur_timestamp)
    timetable.hour = Global.daily_reset_hour or 5
    local timestamp_of_daily_n = M.to_timestamp(timetable)
    if cur_timestamp >= timestamp_of_daily_n and last_timestamp < timestamp_of_daily_n then
      return true
    end
  end
  return false
end

function M.is_in_time(time_table, last_receive_time)
  local function compare(a, b)
    return a[1][1] * 60 + a[1][2] < b[1][1] * 60 + b[1][2]
  end
  
  table.sort(time_table, compare)
  local server_time = Date.server_time()
  local tb = os.date("!*t", server_time)
  tb.sec = os.date("!%S", server_time)
  local time_list = {}
  local zero_point_timestamp = M.to_timestamp({
    year = tb.year,
    month = tb.month,
    day = tb.day,
    hour = 0,
    min = 0,
    sec = 0
  })
  for index, time_period in ipairs(time_table) do
    time_list[index] = {}
    time_list[index][1] = zero_point_timestamp + time_period[1][1] * HOUR_SEC + time_period[1][2] * 60
    time_list[index][2] = zero_point_timestamp + time_period[2][1] * HOUR_SEC + time_period[2][2] * 60 + 59
  end
  local in_time = false
  for _, time_range in ipairs(time_list) do
    local start_time_in_minutes = time_range[1]
    local end_time_in_minutes = time_range[2]
    if server_time >= start_time_in_minutes and server_time <= end_time_in_minutes and (not last_receive_time or last_receive_time < start_time_in_minutes) then
      in_time = true
      break
    end
  end
  local remaining_time = -1
  if not in_time then
    local next_start_time_in_minutes
    for _, time_range in ipairs(time_list) do
      if server_time < time_range[1] then
        next_start_time_in_minutes = time_range[1]
        break
      end
    end
    next_start_time_in_minutes = next_start_time_in_minutes or time_list[1][1] + 24 * HOUR_SEC
    remaining_time = next_start_time_in_minutes - server_time
  end
  return remaining_time
end

function M.is_in_time2(timestamp, start_time, end_time)
  if not timestamp then
    return false
  end
  local time = M.get_day_start(timestamp)
  local begin_time = start_time + time
  local finish_time = end_time + time
  local is_in_time = timestamp >= begin_time and timestamp <= finish_time
  local left_time = 0
  if not is_in_time then
    left_time = begin_time - Date.server_time()
  end
  if left_time < 0 then
    left_time = 0
  end
  return is_in_time, left_time
end

function M.get_left_time(time_table, last_receive_time)
  last_receive_time = last_receive_time or 0
  local time = M.get_day_start(Date.server_time())
  local time_list = {}
  for index, times in ipairs(time_table) do
    local start_time = time + times[1]
    local end_time = time + times[2]
    time_list[index] = {start_time, end_time}
  end
  local in_time = false
  local end_timestamp = 0
  local server_time = Date.server_time()
  for _, time_range in ipairs(time_list) do
    local start_time_in_minutes = time_range[1]
    local end_time_in_minutes = time_range[2]
    if server_time >= start_time_in_minutes and server_time <= end_time_in_minutes and (not last_receive_time or last_receive_time < start_time_in_minutes) then
      in_time = true
      end_timestamp = end_time_in_minutes
      break
    end
  end
  local remaining_time = -1
  if not in_time then
    local next_start_time
    for _, time_range in ipairs(time_list) do
      if server_time < time_range[1] then
        next_start_time = time_range[1]
        break
      end
    end
    next_start_time = next_start_time or time_list[1][1] + 24 * HOUR_SEC
    remaining_time = next_start_time - server_time
  end
  return remaining_time, end_timestamp
end

function M.get_time_stamp_by_scheme_id(scheme_id)
  if not scheme_id then
    Log.Error("时间方案ID为空", debug.traceback())
    return
  end
  local time_stamp = ShareRes.get_time_scheme_cfg(scheme_id, M.SERVER_TIME_SCHEME)
  return time_stamp
end

function M.check_time_pass_by_scheme_id(scheme_id)
  local time_stamp = M.get_time_stamp_by_scheme_id(scheme_id)
  return time_stamp and time_stamp < M.server_time()
end

function M.get_language_month(month)
  return LanguageMgr:get_code_text(tostring(772 + month))
end

function M.get_diff_days(start_timestamp, end_timestamp)
  return math.abs(math.floor((end_timestamp - start_timestamp) / 8640) / 10)
end

return M
