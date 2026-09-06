local Protocols = require("protocols.protocols")

local function p1(protocol)
  LogInfoFormat("SCancelLoading", "-- protocolType = %s, protocolName = %s --", protocol.protocolType, Protocols[protocol.protocolType])
end

local function p2(protocol, client)
end

return {p1, p2}
