local function p1(protocol)
  NekoData.DataManager.DM_SEnterDungeon:OnSUnRemainEvents(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
