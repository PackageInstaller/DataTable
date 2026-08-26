-- chunkname: @modules/logic/social/controller/SocialEvent.lua

module("modules.logic.social.controller.SocialEvent", package.seeall)

local SocialEvent = _M

SocialEvent.FriendsInfoChangedSpecial = 100
SocialEvent.FriendsInfoChanged = 101
SocialEvent.BlackListInfoChanged = 102
SocialEvent.SearchInfoChanged = 103
SocialEvent.RequestInfoChanged = 104
SocialEvent.RecommendChanged = 105
SocialEvent.AddUnknownFriend = 111
SocialEvent.AddUnknownBlackList = 112
SocialEvent.MessageInfoChanged = 201
SocialEvent.SelectFriend = 301
SocialEvent.SubTabSwitch = 401
SocialEvent.InformSuccessReply = 501
SocialEvent.InformFailReply = 502
SocialEvent.FriendDescChange = 601
SocialEvent.CutSelectSocialBg = 602

return SocialEvent
