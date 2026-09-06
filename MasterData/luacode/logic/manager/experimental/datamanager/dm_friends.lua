local DM_Friends = class("DM_Friends")
local Friend = require("logic.manager.experimental.types.friend")
local RedData = require("logic.manager.experimental.types.reddata")

function DM_Friends:Ctor()
  self._friends = NekoData.Data.friends.list
  self._redData = NekoData.Data.friends.redData
  self._roleInfo = NekoData.Data.friends.roleInfo
  self._recommendFriends = NekoData.Data.friends.recommendList
  self._worldmsgblocks = NekoData.Data.friends.worldMsgBlockList
end

function DM_Friends:Clear()
  for k, v in pairs(self._friends) do
    self._friends[k] = nil
  end
  for k, v in pairs(self._recommendFriends) do
    self._recommendFriends[k] = nil
  end
  for k, v in pairs(self._worldmsgblocks) do
    self._worldmsgblocks[k] = nil
  end
  self._redData:Clear()
  for k, v in pairs(self._roleInfo) do
    self._roleInfo[k] = nil
  end
end

function DM_Friends:AddFriend(info)
  local friend = Friend.Create()
  friend:SetDataFromProtol(info)
  self._friends[info.baseUserData.userId] = friend
  return friend
end

function DM_Friends:RemoveFriend(userid)
  self._friends[userid] = nil
end

function DM_Friends:OnSAllFriends(protocol)
  for index, info in pairs(protocol.user) do
    self:AddFriend(info)
  end
  self:CheckAddFriendPageRedData()
end

function DM_Friends:OnSAddFriend(protocol)
  local friend = self._friends[protocol.user.baseUserData.userId]
  if not friend then
    friend = self:AddFriend(protocol.user)
  else
    friend:SetDataFromProtol(protocol.user)
  end
  if friend:IsApplicant() then
    self._redData:SetIndexRedValue(RedData.SecondPage, true)
  end
end

function DM_Friends:OnSRefreshFriendsData(protocol)
  for index, info in pairs(protocol.user) do
    if self._friends[info.baseUserData.userId] then
      self._friends[info.baseUserData.userId]:SetDataFromProtol(info)
    end
  end
end

function DM_Friends:OnSRefreshFriendIdentity(userid, identity)
  if not self._friends[userid] then
    return
  end
  local oldIdentity = self._friends[userid]:GetIdentity()
  self._friends[userid]:SetIdentity(identity)
  self:CheckFriendPageRedData()
  self:CheckAddFriendPageRedData()
end

function DM_Friends:RefreshRecommendFriends(protocol)
  for k, v in pairs(self._recommendFriends) do
    self._recommendFriends[k] = nil
  end
  for index, info in pairs(protocol.users) do
    local friend = Friend.Create()
    friend:SetDataFromProtol(info)
    table.insert(self._recommendFriends, friend)
  end
end

function DM_Friends:RemoveRecommendFriend(userId)
  local exist = false
  for i = #self._recommendFriends, 1, -1 do
    if self._recommendFriends[i]:GetID() == userId then
      table.remove(self._recommendFriends, i)
      exist = true
      break
    end
  end
  return exist
end

function DM_Friends:OnBlockWorldMsgList(protocol)
  for k, v in pairs(self._worldmsgblocks) do
    self._worldmsgblocks[k] = nil
  end
  for index, userid in pairs(protocol.userIds) do
    table.insert(self._worldmsgblocks, userid)
  end
  local userinfo = {}
  LuaNotificationCenter.PostNotification(Common.n_ChatBlockWorldMsg, nil, userinfo)
end

function DM_Friends:SetIndexRedValue(index, value)
  self._redData:SetIndexRedValue(index, value)
end

function DM_Friends:CheckFriendPageRedData()
  local bHasNotRead = false
  for id, friend in pairs(self._friends) do
    if friend:IsFriend() and friend:IsHasNotReadMsg() then
      bHasNotRead = true
      break
    end
  end
  self:SetIndexRedValue(RedData.FirstPage, bHasNotRead or self._redData:IsIndexTrue(RedData.ThirdPage))
end

function DM_Friends:CheckAddFriendPageRedData()
  local bHasApplicant = false
  for id, friend in pairs(self._friends) do
    if friend:IsApplicant() then
      bHasApplicant = true
      break
    end
  end
  self:SetIndexRedValue(RedData.SecondPage, bHasApplicant)
end

function DM_Friends:AddFriendRandom()
  local protocal = {}
  protocal.user = {}
  protocal.user.userId = #self._friends + 1
  protocal.user.userName = ""
  protocal.user.level = math.random(1, 99)
  protocal.user.avatarId = 0
  local random = math.random(1, 10)
  if random < 5 then
    protocal.user.lastLogoutTime = ServerGameTimer.GetServerTime() - 3600000 * random
  else
    protocal.user.lastLogoutTime = 0
  end
  protocal.user.friendTime = ServerGameTimer.GetServerTime() - math.random(86400000, 172800000)
end

function DM_Friends:OnSSendAssistRoles(protocol)
  self._roleInfo.supportRole = protocol.supportRole
  self._roleInfo.displayRoles = {}
  for i, v in ipairs(protocol.displayRole) do
    table.insert(self._roleInfo.displayRoles, v)
  end
end

function DM_Friends:OnSChangeSupportRole(protocol)
  self._roleInfo.supportRole = protocol.roleIds
end

function DM_Friends:OnSChangeDisplayRoles(protocol)
  while self._roleInfo.displayRoles[#self._roleInfo.displayRoles] do
    table.remove(self._roleInfo.displayRoles, #self._roleInfo.displayRoles)
  end
  for i, v in ipairs(protocol.roleIds) do
    table.insert(self._roleInfo.displayRoles, v)
  end
end

function DM_Friends:OnSRefreshSupportRoleList(protocol)
  if not self._roleInfo.supportRoleList then
    self._roleInfo.supportRoleList = {}
    self._roleInfo.supportRoleList.rolesFromFriends = {}
    for k, v in pairs(protocol.rolesFromFriends) do
      self._roleInfo.supportRoleList.rolesFromFriends[k] = v
    end
    self._roleInfo.supportRoleList.rolesFromStrangers = {}
    for k, v in pairs(protocol.rolesFromStrangers) do
      self._roleInfo.supportRoleList.rolesFromStrangers[k] = v
    end
  else
    for k, v in pairs(self._roleInfo.supportRoleList.rolesFromFriends) do
      self._roleInfo.supportRoleList.rolesFromFriends[k] = nil
    end
    for k, v in pairs(self._roleInfo.supportRoleList.rolesFromStrangers) do
      self._roleInfo.supportRoleList.rolesFromStrangers[k] = nil
    end
    for k, v in pairs(protocol.rolesFromFriends) do
      self._roleInfo.supportRoleList.rolesFromFriends[k] = v
    end
    for k, v in pairs(protocol.rolesFromStrangers) do
      self._roleInfo.supportRoleList.rolesFromStrangers[k] = v
    end
  end
end

function DM_Friends:OnSLikeFriends(protocol)
  if protocol.userId == -1 then
    for k, v in pairs(self._friends) do
      self._friends[k]:SetLikeStatus(1)
    end
  elseif self._friends[protocol.userId] then
    self._friends[protocol.userId]:SetLikeStatus(1)
  end
end

function DM_Friends:OnSNotifyFriendsPoint()
  self._redData:SetIndexRedValue(RedData.ThirdPage, true)
  self._redData:SetIndexRedValue(RedData.FirstPage, true)
end

function DM_Friends:OnReceiveFriendPoints()
  self._redData:SetIndexRedValue(RedData.ThirdPage, false)
  self:CheckFriendPageRedData()
end

return DM_Friends
