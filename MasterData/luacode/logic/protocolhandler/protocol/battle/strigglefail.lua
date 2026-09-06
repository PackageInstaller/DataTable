local function p1(protocol)
  LogError("event", "event " .. protocol.eventId .. " execution failed on server")
end

local function p2(protocol, client)
end

return {p1, p2}
