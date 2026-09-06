local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local HeadTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local FrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local OtherUserInfo = LuaNetManager.GetBeanDef("protocol.chat.otheruserinfo")
local Friend = strictclass("Friend")

function Friend:Ctor()
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

function Friend:SetDataFromProtol(bean)
  self._id = bean.baseUserData.userId
  self._name = bean.baseUserData.userName
  self._level = bean.baseUserData.userLv
  self._headid = bean.baseUserData.avatarId
  self._frameid = bean.baseUserData.frameId
  self._spiritvip = bean.baseUserData.spiritvip
  self._identity = bean.identity
  self._lastLogoutTime = bean.lastLogoutTime
  self._friendTime = bean.friendTime
  self._lastOnLineTime = bean.lastOnLineTime
  self._likeStatus = bean.likeStatus
  self._sparkStatus = bean.sparkStatus
end

function Friend:SetDataFromChatMsg(chatinfo)
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(chatinfo.userid)
  if friend and friend:IsFriend() then
    self._id = friend._id
    self._name = friend._name
    self._level = friend._level
    self._headid = friend._headid
    self._frameid = friend._frameid
    self._spiritvip = friend._spiritvip
    self._identity = friend._identity
    self._lastLogoutTime = friend._lastLogoutTime
    self._friendTime = friend._friendTime
    self._lastOnLineTime = friend._lastOnLineTime
    self._likeStatus = friend._likeStatus
    self._sparkStatus = friend._sparkStatus
  else
    self._id = chatinfo.userid
    self._name = chatinfo.username
    self._level = chatinfo.level
    self._headid = chatinfo.headid
    self._frameid = chatinfo.frameid
    self._spiritvip = chatinfo.spiritvip
    self._identity = OtherUserInfo.STRANGER
    self._lastLogoutTime = 0
    self._friendTime = 0
    self._lastOnLineTime = 0
    self._likeStatus = 0
    self._sparkStatus = 0
  end
end

function Friend:SetIdentity(identity)
  self._identity = identity
end

function Friend:GetIdentity()
  return self._identity
end

function Friend:GetID()
  return self._id
end

function Friend:GetName()
  if self._name ~= "" then
    return self._name
  end
  return self._id
end

function Friend:GetLevel()
  return self._level
end

function Friend:GetHeadImagePath()
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

function Friend:GetFrameImagePath()
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

function Friend:GetSpiritVip()
  return self._spiritvip
end

function Friend:IsOnLine()
  return self._lastLogoutTime <= 0
end

function Friend:GetLastOnLineTime()
  return self._lastLogoutTime
end

function Friend:GetFriendTime()
  return self._friendTime
end

function Friend:GetLastLoginTime()
  return self._lastOnLineTime
end

function Friend:IsFriend()
  return self._identity == OtherUserInfo.FRIEND
end

function Friend:IsBlack()
  return self._identity == OtherUserInfo.BLACK_LIST
end

function Friend:IsApplicant()
  return self._identity == OtherUserInfo.APPLICANT
end

function Friend:IsStranger()
  return self._identity == OtherUserInfo.STRANGER
end

function Friend:GetStatusStr()
  if self._lastLogoutTime <= 0 then
    return TextManager.GetText(CstringCfg:GetRecorder(1032).msgTextID)
  end
  local time = ServerGameTimer.GetServerTime() - self._lastLogoutTime
  local day = math.floor(time / 86400000)
  if 7 <= day then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1547).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(day))
  end
  if 0 < day then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1031).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(day))
  end
  local hour = math.floor(time / 3600000)
  if 0 < hour then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1030).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(hour))
  end
  local min = math.floor(time / 60000)
  if 0 < min then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1029).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(min))
  end
  local second = math.floor(time / 1000)
  if 0 < second then
    local str = TextManager.GetText(CstringCfg:GetRecorder(1028).msgTextID)
    return string.gsub(str, "%$parameter1%$", tostring(second))
  end
  local str = TextManager.GetText(CstringCfg:GetRecorder(1552).msgTextID)
  return str
end

function Friend:GetLastChatTime()
  return NekoData.BehaviorManager.BM_FriendsChat:GetLastChatTime(self._id)
end

function Friend:IsHasNotReadMsg()
  return NekoData.BehaviorManager.BM_FriendsChat:GetNotReadNum(self._id) > 0
end

function Friend:SetLikeStatus(status)
  self._likeStatus = status
end

function Friend:GetLikeStatus(status)
  return self._likeStatus
end

function Friend:SetSparkStatus(status)
  self._sparkStatus = status
end

function Friend:GetSparkStatus(status)
  return self._sparkStatus
end

return Friend
