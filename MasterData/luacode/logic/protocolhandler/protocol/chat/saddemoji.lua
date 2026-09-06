local function p1(protocol)
  NekoData.DataManager.DM_Chat:OnAddEmoji(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
