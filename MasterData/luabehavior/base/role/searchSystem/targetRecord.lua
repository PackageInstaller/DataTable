local tarRecordInfoBase = Util.create_class()

function tarRecordInfoBase.new(base, npc, idx)
  if not idx then
    Util.debug_output("idx is lost")
  end
  local info = setmetatable({}, base)
  info.npc = npc
  info.time = get_time()
  info.idx = idx or -1
  return info
end

function tarRecordInfoBase.update(info, idx)
  info.time = get_time()
  if not idx then
    Util.debug_output("idx is lost")
  end
  info.idx = idx or -1
  return info
end

local infoListBase = {__mode = "k"}
local tarRecordBase = Util.create_class()

function tarRecordBase.new(base)
  local ret = setmetatable({}, base)
  ret.idx = 0
  ret.list = setmetatable({}, infoListBase)
  return ret
end

function tarRecordBase.getInfo(record, npc)
  return record.list[npc]
end

function tarRecordBase.add(record, npc)
  local info = record:getInfo(npc)
  local idx = record.idx + 1
  record.idx = idx
  if info then
    return info:update(idx)
  else
    local info = tarRecordInfoBase:new(npc, idx)
    record.list[npc] = info
    return info
  end
end

function tarRecordBase.clear(record)
  local list = record.list
  for key, _ in pairs(list) do
    list[key] = nil
  end
end

function tarRecordBase.getDeltaIdx(record, npc)
  local info = record:getInfo(npc)
  if not info then
    return
  end
  return record.idx - info.idx
end

function tarRecordBase.getDeltaTime(record, npc)
  local info = record:getInfo(npc)
  if not info then
    return
  end
  return get_time() - info.time
end

function tarRecordBase.getDelta(record, npc)
  local info = record:getInfo(npc)
  if not info then
    return
  end
  return record.idx - info.idx, get_time() - info.time
end

return tarRecordBase
