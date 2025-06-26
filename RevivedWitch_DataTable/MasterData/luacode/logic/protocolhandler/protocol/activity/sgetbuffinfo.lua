-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sgetbuffinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local temp = ""
  for i,v in pairs(protocol.buffIds) do
    temp = temp .. i .. ":" .. v .. ";"
  end
  LogInfoFormat("sgetbuffinfo", "protocol.buffIds:%s", temp)
  ;
  (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):OnSGetBuffInfo(protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

