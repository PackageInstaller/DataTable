-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/common/sactive.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  if protocol.result == 1 then
    (DialogManager.DestroySingletonDialog)("login.logincodedialog")
  else
    if protocol.result == 0 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100037)
    else
      if protocol.result == -1 then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100036)
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
  client:OnSLogin(protocol)
end

return {p1, p2}

