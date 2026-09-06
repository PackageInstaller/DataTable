local function p1(protocol)
  NekoData.DataManager.DM_Dungeon:OnSCommit()
  
  EffectFactory.CreateThawEffect():Run()
end

local function p2(protocol, client)
end

return {p1, p2}
