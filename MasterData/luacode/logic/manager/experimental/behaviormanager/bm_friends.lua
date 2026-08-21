-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_friends.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFriendConfig = (BeanManager.GetTableByName)("friend.cfriendconfig")
local BM_Friends = class("BM_Friends")
BM_Friends.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._friends = ((NekoData.Data).friends).list
  self._redData = ((NekoData.Data).friends).redData
  self._roleInfo = ((NekoData.Data).friends).roleInfo
  self._recommendFriends = ((NekoData.Data).friends).recommendList
end

BM_Friends.GetFriend = function(self, id)
  -- function num : 0_1
  return (self._friends)[id]
end

BM_Friends.IsFriend = function(self, id)
  -- function num : 0_2
  if not (self._friends)[id] then
    return false
  end
  return ((self._friends)[id]):IsFriend()
end

BM_Friends.GetAllFriend = function(self)
  -- function num : 0_3
  return self._friends
end

BM_Friends.GetMaxFriendsNum = function(self)
  -- function num : 0_4 , upvalues : CFriendConfig
  return (CFriendConfig:GetRecorder(1)).FriendMax
end

BM_Friends.GetMaxtBlackFriendsNum = function(self)
  -- function num : 0_5 , upvalues : CFriendConfig
  return (CFriendConfig:GetRecorder(1)).BlackListMax
end

BM_Friends.GetRedData = function(self)
  -- function num : 0_6
  return self._redData
end

BM_Friends.FindFriend = function(self, keyword)
  -- function num : 0_7 , upvalues : _ENV
  local result = {}
  local posS, posE = nil, nil
  for id,friend in pairs(self._friends) do
    if friend:IsFriend() then
      posS = (string.find)(friend:GetName(), keyword)
      if posS then
        (table.insert)(result, friend)
      else
        -- DECOMPILER ERROR at PC32: Overwrote pending register: R4 in 'AssignReg'

        posS = (string.find)(friend:GetID(), keyword)
        if posS then
          (table.insert)(result, friend)
        end
      end
    end
  end
  return result
end

BM_Friends.GetRecommendFriends = function(self)
  -- function num : 0_8
  return self._recommendFriends
end

BM_Friends.RequestRecommendFriend = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshrecommendedfriends")
  protocol:Send()
end

BM_Friends.RequestSearchFriend = function(self, keyword)
  -- function num : 0_10 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.csearchuser")
  protocol.Keyword = keyword
  protocol:Send()
end

BM_Friends.RequesAddFriend = function(self, userId)
  -- function num : 0_11 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.caddfriend")
  protocol.userId = userId
  protocol:Send()
end

BM_Friends.RequestRemoveFriend = function(self, userId)
  -- function num : 0_12 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.cdeletefriend")
  protocol.userId = userId
  protocol:Send()
end

BM_Friends.RequesBlackFriend = function(self, userId)
  -- function num : 0_13 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.caddblacklist")
  protocol.userId = userId
  protocol:Send()
end

BM_Friends.RequesRecoverBlackFriend = function(self, userId)
  -- function num : 0_14 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.crecoverblacklist")
  protocol.userId = userId
  protocol:Send()
end

BM_Friends.ResponseApplicant = function(self, userId, result)
  -- function num : 0_15 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.crespondapplicant")
  protocol.userId = userId
  protocol.result = result
  protocol:Send()
end

BM_Friends.RequestRefreshFriends = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshfriendinfos")
  protocol:Send()
end

BM_Friends.GetSupportRole = function(self)
  -- function num : 0_17 , upvalues : _ENV
  return ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._roleInfo).supportRole)
end

BM_Friends.GetDisplayRoles = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local roleList = {}
  for i,v in ipairs((self._roleInfo).displayRoles) do
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v)
    if role then
      (table.insert)(roleList, role)
    end
  end
  return roleList
end

BM_Friends.GetSupportRoleList = function(self)
  -- function num : 0_19
  return (self._roleInfo).supportRoleList
end

return BM_Friends

