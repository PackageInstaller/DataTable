local _floor = math.floor
local _sformat = string.format

local function generate_histogram(latencies, slowest, fastest)
  if 0 == #latencies then
    return {}
  end
  local bc = 10
  local buckets = {}
  local counts = {}
  local bs = (slowest - fastest) / bc
  for i = 1, bc do
    buckets[i] = fastest + bs * i
  end
  local i = 1
  local bi = 1
  while i <= #latencies do
    if latencies[i] <= buckets[bi] then
      i = i + 1
      counts[bi] = (counts[bi] or 0) + 1
    elseif bi < #buckets then
      bi = bi + 1
    else
      counts[#buckets] = (counts[#buckets] or 0) + 1
      i = i + 1
    end
  end
  local latencyBuckets = {}
  for i = 1, #buckets do
    counts[i] = counts[i] or 0
    latencyBuckets[i] = {
      Mark = buckets[i],
      Count = counts[i],
      Frequency = counts[i] / #latencies
    }
  end
  return latencyBuckets
end

local function generate_latencies(latencies)
  local len = #latencies
  if 0 == len then
    return {}
  end
  local pctls = {
    10,
    25,
    50,
    75,
    90,
    95,
    99
  }
  local data = {}
  for i, p in ipairs(pctls) do
    local j = _floor(p * len / 100)
    if 0 == j then
      j = 1
    elseif len < j then
      j = len
    end
    data[i] = latencies[j]
  end
  local latencyDistribution = {}
  for i = 1, #pctls do
    latencyDistribution[i] = {
      Percentage = pctls[i],
      Latency = data[i]
    }
  end
  return latencyDistribution
end

local function get_ms()
  return _floor(Global.real_time * 1000)
end

local latency_obj_mt = {}
latency_obj_mt.__index = latency_obj_mt

function latency_obj_mt.new(tag)
  local o = {}
  setmetatable(o, latency_obj_mt)
  o:_init(tag)
  return o
end

function latency_obj_mt:_init(tag)
  self.v_tag = tag
  self.v_latencies = {}
  self.v_start_ms = 0
end

function latency_obj_mt:append(lat_ms)
  self.v_latencies[#self.v_latencies + 1] = lat_ms
end

function latency_obj_mt:start()
  self.v_start_ms = get_ms()
end

function latency_obj_mt:stop()
  local lat = get_ms() - self.v_start_ms
  self.v_latencies[#self.v_latencies + 1] = lat
end

function latency_obj_mt:dump(boClearHistory, tag)
  tag = tag or self.v_tag
  Log.Info(_sformat("------------%s latency dump--%s---%s-----------", tag, #self.v_latencies, boClearHistory))
  table.sort(self.v_latencies)
  if #self.v_latencies > 0 then
    local minLat, maxLat = self.v_latencies[1], self.v_latencies[#self.v_latencies]
    local sumMS = 0
    for _, v in ipairs(self.v_latencies) do
      sumMS = sumMS + v
    end
    local avgLat = sumMS / #self.v_latencies
    Log.Info(_sformat("MinLatencyMS: %s, MaxLatencyMS: %s, AvgLatencyMS: %s", minLat, maxLat, avgLat))
    Log.Info("Latency histogram:")
    for _, h in ipairs(generate_histogram(self.v_latencies, maxLat, minLat)) do
      Log.Info(_sformat("%8.2fms|%7d|%8.2f%%\n", h.Mark, h.Count, h.Frequency * 100))
    end
    Log.Info("Latency distribution:")
    for _, d in ipairs(generate_latencies(self.v_latencies)) do
      Log.Info(_sformat("%7d%%     in %8.2fms\n", d.Percentage, d.Latency))
    end
    if boClearHistory then
      self.v_latencies = {}
    end
  end
end

return latency_obj_mt
