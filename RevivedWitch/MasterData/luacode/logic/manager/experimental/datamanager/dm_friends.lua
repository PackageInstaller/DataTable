-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_friends.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Friends = class("DM_Friends")
local Friend = require("logic.manager.experimental.types.friend")
local RedData = require("logic.manager.experimental.types.reddata")
DM_Friends.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._friends = ((NekoData.Data).friends).list
  self._redData = ((NekoData.Data).friends).redData
  self._roleInfo = ((NekoData.Data).friends).roleInfo
  self._recommendFriends = ((NekoData.Data).friends).recommendList
end

DM_Friends.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs(self._friends) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._friends)[k] = nil
  end
  for k,v in pairs(self._recommendFriends) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

    (self._recommendFriends)[k] = nil
  end
  ;
  (self._redData):Clear()
  for k,v in pairs(self._roleInfo) do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

    (self._roleInfo)[k] = nil
  end
end

DM_Friends.AddFriend = function(self, info)
  -- function num : 0_2 , upvalues : Friend
  local friend = (Friend.Create)()
  friend:SetDataFromProtol(info)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._friends)[(info.baseUserData).userId] = friend
  return friend
end

DM_Friends.RemoveFriend = function(self, userid)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._friends)[userid] = nil
end

DM_Friends.OnSAllFriends = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  for index,info in pairs(protocol.user) do
    self:AddFriend(info)
  end
  self:CheckAddFriendPageRedData()
end

DM_Friends.OnSAddFriend = function(self, protocol)
  -- function num : 0_5 , upvalues : RedData
  local friend = (self._friends)[((protocol.user).baseUserData).userId]
  if not friend then
    friend = self:AddFriend(protocol.user)
  else
    friend:SetDataFromProtol(protocol.user)
  end
  if friend:IsApplicant() then
    (self._redData):SetIndexRedValue(RedData.SecondPage, true)
  end
end

DM_Friends.OnSRefreshFriendsData = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV
  for index,info in pairs(protocol.user) do
    if (self._friends)[(info.baseUserData).userId] then
      ((self._friends)[(info.baseUserData).userId]):SetDataFromProtol(info)
    end
  end
end

DM_Friends.OnSRefreshFriendIdentity = function(self, userid, identity)
  -- function num : 0_7
  if not (self._friends)[userid] then
    return 
  end
  local oldIdentity = ((self._friends)[userid]):GetIdentity()
  ;
  ((self._friends)[userid]):SetIdentity(identity)
  self:CheckFriendPageRedData()
  self:CheckAddFriendPageRedData()
end

DM_Friends.RefreshRecommendFriends = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV, Friend
  for k,v in pairs(self._recommendFriends) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self._recommendFriends)[k] = nil
  end
  for index,info in pairs(protocol.users) do
    local friend = (Friend.Create)()
    friend:SetDataFromProtol(info)
    ;
    (table.insert)(self._recommendFriends, friend)
  end
end

DM_Friends.RemoveRecommendFriend = function(self, userId)
  -- function num : 0_9 , upvalues : _ENV
  local exist = false
  for i = #self._recommendFriends, 1, -1 do
    if ((self._recommendFriends)[i]):GetID() == userId then
      (table.remove)(self._recommendFriends, i)
      exist = true
      break
    end
  end
  do
    return exist
  end
end

DM_Friends.SetIndexRedValue = function(self, index, value)
  -- function num : 0_10
  (self._redData):SetIndexRedValue(index, value)
end

DM_Friends.CheckFriendPageRedData = function(self)
  -- function num : 0_11 , upvalues : _ENV, RedData
  local bHasNotRead = false
  for id,friend in pairs(self._friends) do
    if friend:IsFriend() and friend:IsHasNotReadMsg() then
      bHasNotRead = true
      break
    end
  end
  do
    if not bHasNotRead then
      self:SetIndexRedValue(RedData.FirstPage, (self._redData):IsIndexTrue(3))
    end
  end
end

DM_Friends.CheckAddFriendPageRedData = function(self)
  -- function num : 0_12 , upvalues : _ENV, RedData
  local bHasApplicant = false
  for id,friend in pairs(self._friends) do
    if friend:IsApplicant() then
      bHasApplicant = true
      break
    end
  end
  do
    self:SetIndexRedValue(RedData.SecondPage, bHasApplicant)
  end
end

DM_Friends.AddFriendRandom = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local protocal = {}
  protocal.user = {}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (protocal.user).userId = #self._friends + 1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (protocal.user).userName = ""
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (protocal.user).level = (math.random)(1, 99)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (protocal.user).avatarId = 0
  local random = (math.random)(1, 10)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  if random < 5 then
    (protocal.user).lastLogoutTime = (ServerGameTimer.GetServerTime)() - 3600000 * random
  else
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (protocal.user).lastLogoutTime = 0
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (protocal.user).friendTime = (ServerGameTimer.GetServerTime)() - (math.random)(86400000, 172800000)
end

DM_Friends.OnSSendAssistRoles = function(self, protocol)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._roleInfo).supportRole = protocol.supportRole
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._roleInfo).displayRoles = {}
  for i,v in ipairs(protocol.displayRole) do
    (table.insert)((self._roleInfo).displayRoles, v)
  end
end

DM_Friends.OnSChangeSupportRole = function(self, protocol)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._roleInfo).supportRole = protocol.roleIds
end

DM_Friends.OnSChangeDisplayRoles = function(self, protocol)
  -- function num : 0_16 , upvalues : _ENV
  while ((self._roleInfo).displayRoles)[#(self._roleInfo).displayRoles] do
    (table.remove)((self._roleInfo).displayRoles, #(self._roleInfo).displayRoles)
  end
  for i,v in ipairs(protocol.roleIds) do
    (table.insert)((self._roleInfo).displayRoles, v)
  end
end

DM_Friends.OnSRefreshSupportRoleList = function(self, protocol)
  -- function num : 0_17 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._roleInfo).supportRoleList then
    (self._roleInfo).supportRoleList = {}
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._roleInfo).supportRoleList).rolesFromFriends = {}
    for k,v in pairs(protocol.rolesFromFriends) do
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

      (((self._roleInfo).supportRoleList).rolesFromFriends)[k] = v
    end
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._roleInfo).supportRoleList).rolesFromStrangers = {}
    for k,v in pairs(protocol.rolesFromStrangers) do
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

      (((self._roleInfo).supportRoleList).rolesFromStrangers)[k] = v
    end
  else
    do
      for k,v in pairs(((self._roleInfo).supportRoleList).rolesFromFriends) do
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

        (((self._roleInfo).supportRoleList).rolesFromFriends)[k] = nil
      end
      for k,v in pairs(((self._roleInfo).supportRoleList).rolesFromStrangers) do
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

        (((self._roleInfo).supportRoleList).rolesFromStrangers)[k] = nil
      end
      for k,v in pairs(protocol.rolesFromFriends) do
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

        (((self._roleInfo).supportRoleList).rolesFromFriends)[k] = v
      end
      for k,v in pairs(protocol.rolesFromStrangers) do
        -- DECOMPILER ERROR at PC77: Confused about usage of register: R7 in 'UnsetPending'

        (((self._roleInfo).supportRoleList).rolesFromStrangers)[k] = v
      end
    end
  end
end

DM_Friends.OnSLikeFriends = function(self, protocol)
  -- function num : 0_18 , upvalues : _ENV
  if protocol.userId == -1 then
    for k,v in pairs(self._friends) do
      ((self._friends)[k]):SetLikeStatus(1)
    end
  else
    do
      if (self._friends)[protocol.userId] then
        ((self._friends)[protocol.userId]):SetLikeStatus(1)
      end
    end
  end
end

DM_Friends.OnSNotifyFriendsPoint = function(self)
  -- function num : 0_19 , upvalues : RedData
  (self._redData):SetIndexRedValue(3, true)
  ;
  (self._redData):SetIndexRedValue(RedData.FirstPage, true)
end

DM_Friends.OnReceiveFriendPoints = function(self)
  -- function num : 0_20
  (self._redData):SetIndexRedValue(3, false)
  self:CheckFriendPageRedData()
end

return DM_Friends

