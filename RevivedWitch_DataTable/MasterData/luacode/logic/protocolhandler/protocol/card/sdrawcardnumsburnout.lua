-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/card/sdrawcardnumsburnout.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("SDrawCardNumsBurnOut", "--- type = %s --- : ", protocol.kind)
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100081)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_DrawCard, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

