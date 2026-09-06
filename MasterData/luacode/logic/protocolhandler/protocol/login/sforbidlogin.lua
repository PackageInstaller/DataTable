local function p1(protocol)
  NekoData.DataManager.DM_Login:SetForbidLoginRestTime(protocol.restTime)
end

local function p2(protocol, client)
end

return {p1, p2}
