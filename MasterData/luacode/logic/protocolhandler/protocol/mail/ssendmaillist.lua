local function p1(protocol)
  NekoData.DataManager.DM_Mail:OnSSendMailList(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
