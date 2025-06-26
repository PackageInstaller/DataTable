-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/friend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local HeadTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local FrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local OtherUserInfo = (LuaNetManager.GetBeanDef)("protocol.chat.otheruserinfo")
local Friend = strictclass("Friend")
Friend.Ctor = function(self)
  -- function num : 0_0
  self._id = -1
  self._name = nil
  self._level = nil
  self._headid = nil
  self._isBlack = nil
  self._lastLogoutTime = nil
  self._friendTime = nil
  self._lastOnLineTime = nil
  self._likeStatus = nil
  self._sparkStatus = nil
end

Friend.SetDataFromProtol = function(self, bean)
  -- function num : 0_1
  self._id = (bean.baseUserData).userId
  self._name = (bean.baseUserData).userName
  self._level = (bean.baseUserData).userLv
  self._headid = (bean.baseUserData).avatarId
  self._frameid = (bean.baseUserData).frameId
  self._spiritvip = (bean.baseUserData).spiritvip
  self._identity = bean.identity
  self._lastLogoutTime = bean.lastLogoutTime
  self._friendTime = bean.friendTime
  self._lastOnLineTime = bean.lastOnLineTime
  self._likeStatus = bean.likeStatus
  self._sparkStatus = bean.sparkStatus
end

Friend.SetIdentity = function(self, identity)
  -- function num : 0_2
  self._identity = identity
end

Friend.GetIdentity = function(self)
  -- function num : 0_3
  return self._identity
end

Friend.GetID = function(self)
  -- function num : 0_4
  return self._id
end

Friend.GetName = function(self)
  -- function num : 0_5
  if self._name ~= "" then
    return self._name
  end
  return self._id
end

Friend.GetLevel = function(self)
  -- function num : 0_6
  return self._level
end

Friend.GetHeadImagePath = function(self)
  -- function num : 0_7 , upvalues : HeadTable, ImageTable
  local temp = HeadTable:GetRecorder(self._headid)
  if not temp then
    return 
  end
  local gamerInfo = ImageTable:GetRecorder(temp.photoid)
  if not gamerInfo then
    return 
  end
  return gamerInfo
end

Friend.GetFrameImagePath = function(self)
  -- function num : 0_8 , upvalues : FrameTable, ImageTable
  local temp = FrameTable:GetRecorder(self._frameid)
  if not temp then
    return 
  end
  local gamerInfo = ImageTable:GetRecorder(temp.photoid)
  if not gamerInfo then
    return 
  end
  return gamerInfo
end

Friend.GetSpiritVip = function(self)
  -- function num : 0_9
  return self._spiritvip
end

Friend.IsOnLine = function(self)
  -- function num : 0_10
  do return self._lastLogoutTime <= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Friend.GetLastOnLineTime = function(self)
  -- function num : 0_11
  return self._lastLogoutTime
end

Friend.GetFriendTime = function(self)
  -- function num : 0_12
  return self._friendTime
end

Friend.GetLastLoginTime = function(self)
  -- function num : 0_13
  return self._lastOnLineTime
end

Friend.IsFriend = function(self)
  -- function num : 0_14 , upvalues : OtherUserInfo
  do return self._identity == OtherUserInfo.FRIEND end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Friend.IsBlack = function(self)
  -- function num : 0_15 , upvalues : OtherUserInfo
  do return self._identity == OtherUserInfo.BLACK_LIST end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Friend.IsApplicant = function(self)
  -- function num : 0_16 , upvalues : OtherUserInfo
  do return self._identity == OtherUserInfo.APPLICANT end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Friend.IsStranger = function(self)
  -- function num : 0_17 , upvalues : OtherUserInfo
  do return self._identity == OtherUserInfo.STRANGER end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Friend.GetStatusStr = function(self)
  -- function num : 0_18 , upvalues : _ENV, CstringCfg
  if self._lastLogoutTime <= 0 then
    return (TextManager.GetText)((CstringCfg:GetRecorder(1032)).msgTextID)
  end
  local time = (ServerGameTimer.GetServerTime)() - self._lastLogoutTime
  local day = (math.floor)(time / 86400000)
  do
    if day >= 7 then
      local str = (TextManager.GetText)((CstringCfg:GetRecorder(1547)).msgTextID)
      return (string.gsub)(str, "%$parameter1%$", tostring(day))
    end
    do
      if day > 0 then
        local str = (TextManager.GetText)((CstringCfg:GetRecorder(1031)).msgTextID)
        return (string.gsub)(str, "%$parameter1%$", tostring(day))
      end
      local hour = (math.floor)(time / 3600000)
      do
        if hour > 0 then
          local str = (TextManager.GetText)((CstringCfg:GetRecorder(1030)).msgTextID)
          return (string.gsub)(str, "%$parameter1%$", tostring(hour))
        end
        local min = (math.floor)(time / 60000)
        do
          if min > 0 then
            local str = (TextManager.GetText)((CstringCfg:GetRecorder(1029)).msgTextID)
            return (string.gsub)(str, "%$parameter1%$", tostring(min))
          end
          local second = (math.floor)(time / 1000)
          do
            if second > 0 then
              local str = (TextManager.GetText)((CstringCfg:GetRecorder(1028)).msgTextID)
              return (string.gsub)(str, "%$parameter1%$", tostring(second))
            end
            local str = (TextManager.GetText)((CstringCfg:GetRecorder(1552)).msgTextID)
            return str
          end
        end
      end
    end
  end
end

Friend.GetLastChatTime = function(self)
  -- function num : 0_19 , upvalues : _ENV
  return ((NekoData.BehaviorManager).BM_FriendsChat):GetLastChatTime(self._id)
end

Friend.IsHasNotReadMsg = function(self)
  -- function num : 0_20 , upvalues : _ENV
  do return ((NekoData.BehaviorManager).BM_FriendsChat):GetNotReadNum(self._id) > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Friend.SetLikeStatus = function(self, status)
  -- function num : 0_21
  self._likeStatus = status
end

Friend.GetLikeStatus = function(self, status)
  -- function num : 0_22
  return self._likeStatus
end

Friend.SetSparkStatus = function(self, status)
  -- function num : 0_23
  self._sparkStatus = status
end

Friend.GetSparkStatus = function(self, status)
  -- function num : 0_24
  return self._sparkStatus
end

return Friend

