-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/chat/ssendfriendmsg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_FriendsChat):OnSAddFriendChat(protocol)
  local dialog = (DialogManager.GetDialog)("friend.friendslistdialog")
  if dialog and dialog:IsActive() and dialog:GetSelectedFriend() == protocol.userId then
    do
      local userInfo = {}
      userInfo.userId = protocol.userId
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_FriendNotReadNumChange, nil, userInfo)
      ;
      ((NekoData.DataManager).DM_Friends):CheckFriendPageRedData()
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_FriendChatReceive, nil, protocol)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

