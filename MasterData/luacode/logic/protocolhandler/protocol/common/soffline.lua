local function p1(protocol)
  LogInfoFormat("SOffLine", "---------- offtype = %s, reason = %s ---------", protocol.offtype, protocol.reason)
end

local function p2(protocol, client)
end

return {p1, p2}
