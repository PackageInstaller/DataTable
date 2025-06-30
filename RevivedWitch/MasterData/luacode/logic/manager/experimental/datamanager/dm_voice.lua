-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_voice.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Voice = class("DM_Voice")
DM_Voice.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).voice
end

DM_Voice.Clear = function(self)
  -- function num : 0_1
end

return DM_Voice

