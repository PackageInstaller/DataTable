local CFriendConfig = BeanManager.GetTableByName("friend.cfriendconfig")
local BM_Friends = class("BM_Friends")

function BM_Friends:Ctor()
  self._friends = NekoData.Data.friends.list
  self._redData = NekoData.Data.friends.redData
  self._roleInfo = NekoData.Data.friends.roleInfo
  self._recommendFriends = NekoData.Data.friends.recommendList
  self._worldmsgblocks = NekoData.Data.friends.worldMsgBlockList
end

function BM_Friends:GetFriend(id)
  return self._friends[id]
end

function BM_Friends:IsFriend(id)
  if not self._friends[id] then
    return false
  end
  return self._friends[id]:IsFriend()
end

function BM_Friends:GetAllFriend()
  return self._friends
end

function BM_Friends:GetMaxFriendsNum()
  return CFriendConfig:GetRecorder(1).FriendMax
end

function BM_Friends:GetMaxtBlackFriendsNum()
  return CFriendConfig:GetRecorder(1).BlackListMax
end

function BM_Friends:GetRedData()
  return self._redData
end

function BM_Friends:FindFriend(keyword)
  local result = {}
  local posS, posE
  for id, friend in pairs(self._friends) do
    if friend:IsFriend() then
      posS, posE = string.find(friend:GetName(), keyword)
      if posS then
        table.insert(result, friend)
      else
        posS, posE = string.find(friend:GetID(), keyword)
        if posS then
          table.insert(result, friend)
        end
      end
    end
  end
  return result
end

function BM_Friends:GetRecommendFriends()
  return self._recommendFriends
end

function BM_Friends:GetBlockWorldMsgList()
  return self._worldmsgblocks
end

function BM_Friends:IsBlockWorldMsgList(id)
  for k, userid in pairs(self._worldmsgblocks) do
    if userid == id then
      return true
    end
  end
  return false
end

function BM_Friends:RequestRecommendFriend()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.crefreshrecommendedfriends")
  protocol:Send()
end

function BM_Friends:RequestSearchFriend(keyword)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.csearchuser")
  protocol.Keyword = keyword
  protocol:Send()
end

function BM_Friends:RequesAddFriend(userId)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.caddfriend")
  protocol.userId = userId
  protocol:Send()
end

function BM_Friends:RequestRemoveFriend(userId)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.cdeletefriend")
  protocol.userId = userId
  protocol:Send()
end

function BM_Friends:RequesBlackFriend(userId)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.caddblacklist")
  protocol.userId = userId
  protocol:Send()
end

function BM_Friends:RequesRecoverBlackFriend(userId)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.crecoverblacklist")
  protocol.userId = userId
  protocol:Send()
end

function BM_Friends:ResponseApplicant(userId, result)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.crespondapplicant")
  protocol.userId = userId
  protocol.result = result
  protocol:Send()
end

function BM_Friends:RequestRefreshFriends()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.crefreshfriendinfos")
  protocol:Send()
end

function BM_Friends:GetSupportRole()
  return NekoData.BehaviorManager.BM_AllRoles:GetRole(self._roleInfo.supportRole)
end

function BM_Friends:GetDisplayRoles()
  local roleList = {}
  for i, v in ipairs(self._roleInfo.displayRoles) do
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v)
    if role then
      table.insert(roleList, role)
    end
  end
  return roleList
end

function BM_Friends:GetSupportRoleList()
  return self._roleInfo.supportRoleList
end

return BM_Friends
