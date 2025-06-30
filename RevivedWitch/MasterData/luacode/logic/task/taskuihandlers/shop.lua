-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/shop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self, jumpAim)
  -- function num : 0_0 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Shop) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100192)
    return 
  end
  if jumpAim and jumpAim ~= 0 then
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(jumpAim)
  else
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
end

return TaskUIHandler

