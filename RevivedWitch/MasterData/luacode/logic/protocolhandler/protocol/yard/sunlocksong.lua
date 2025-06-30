-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/sunlocksong.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("yardmusic.unlockmusicdialog")
  if dialog and dialog._musicId == protocol.id then
    dialog:Destroy()
  end
  ;
  ((NekoData.DataManager).DM_YardMusic):OnSUnlockSong(protocol)
  ;
  ((NekoData.BehaviorManager).BM_YardMusic):SetPlayingId(protocol.id)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_UnlockSong, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

