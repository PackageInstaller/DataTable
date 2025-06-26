-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_message.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Message = class("DM_Message")
DM_Message.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._message = (NekoData.Data).message
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._message).topNoticeBar = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._message).functionUnlock = {}
end

DM_Message.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  while ((self._message).topNoticeBar)[#(self._message).topNoticeBar] do
    (table.remove)((self._message).topNoticeBar, #(self._message).topNoticeBar)
  end
  while ((self._message).functionUnlock)[#(self._message).functionUnlock] do
    (table.remove)((self._message).functionUnlock, #(self._message).functionUnlock)
  end
end

return DM_Message

