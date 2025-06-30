-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/smainlinereward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Task):OnSMainLineReward(protocol)
  local str = ""
  for i,v in ipairs(protocol.mainLineRewardStates) do
    if str ~= "" then
      str = str .. ", {id=" .. v.mainLineId .. ", status=" .. v.mainLineState .. "}"
    else
      str = str .. "{id=" .. v.mainLineId .. ", status=" .. v.mainLineState .. "}"
    end
  end
  LogInfoFormat("smainlinereward", "%s", str)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

