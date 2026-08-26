-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotEvent.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotEvent", package.seeall)

local V1a6_CachotEvent = _M

V1a6_CachotEvent.ScenePreloaded = 1001
V1a6_CachotEvent.PlayerBeginMove = 1002
V1a6_CachotEvent.PlayerMove = 1003
V1a6_CachotEvent.PlayerStopMove = 1004
V1a6_CachotEvent.PlayerTriggerInteract = 1005
V1a6_CachotEvent.RoomAssetLoaded = 1006
V1a6_CachotEvent.PlayerMoveTo = 1007
V1a6_CachotEvent.RoomChange = 1008
V1a6_CachotEvent.RoomChangePlayAnim = 1009
V1a6_CachotEvent.RoomChangeAnimEnd = 1010
V1a6_CachotEvent.RoomChangeBegin = 1011
V1a6_CachotEvent.RoomViewOpenAnimEnd = 1012
V1a6_CachotEvent.CheckPlayStory = 1013
V1a6_CachotEvent.EventChangePush = 2001
V1a6_CachotEvent.NearEventMoChange = 2002
V1a6_CachotEvent.SelectChoice = 2003
V1a6_CachotEvent.PlayChoiceDialog = 2004
V1a6_CachotEvent.SelectHero = 2005
V1a6_CachotEvent.RoomEventChange = 2006
V1a6_CachotEvent.SelectEventChange = 2007
V1a6_CachotEvent.SelectEventRemove = 2008
V1a6_CachotEvent.OnReceiveFightReward = 2009
V1a6_CachotEvent.BeginTriggerEvent = 2010
V1a6_CachotEvent.ClickNearEvent = 2011
V1a6_CachotEvent.TriggerEvent = 2012
V1a6_CachotEvent.ShowHideChoice = 2013
V1a6_CachotEvent.OnSelectCollectionItem = 3001
V1a6_CachotEvent.OnSwitchCategory = 3002
V1a6_CachotEvent.OnSelectBagCollection = 4001
V1a6_CachotEvent.OnSelectEnchantCollection = 5001
V1a6_CachotEvent.OnUpdateRogueStateInfo = 6001
V1a6_CachotEvent.OnUpdateRogueInfo = 6002
V1a6_CachotEvent.OnUpdateGoodsInfos = 6003
V1a6_CachotEvent.OnUpdateGroupBoxStar = 6004
V1a6_CachotEvent.OnUpdateCoin = 6005
V1a6_CachotEvent.OnUpdateCurrency = 6006
V1a6_CachotEvent.OnUpdateHeart = 6007
V1a6_CachotEvent.OnUpdateCollectionsInfo = 6008
V1a6_CachotEvent.OnEventFinish = 6009
V1a6_CachotEvent.OnReceiveEnterRogueReply = 7001
V1a6_CachotEvent.OnClickTeamItem = 8001
V1a6_CachotEvent.OnSeatUpgradeSuccess = 8002
V1a6_CachotEvent.OnClickCachotOverItem = 9001
V1a6_CachotEvent.OnFinishGame = 10001
V1a6_CachotEvent.CheckOpenEnding = 10002
V1a6_CachotEvent.CheckGuideEnterLayerRoom = 20000
V1a6_CachotEvent.GuideEnterLayerRoom = 20001
V1a6_CachotEvent.GuideNearEvent = 20002
V1a6_CachotEvent.GuideHeartChange = 20003
V1a6_CachotEvent.GuideCanEnchant = 20004
V1a6_CachotEvent.GuideDragTip = 20005
V1a6_CachotEvent.GuideMoveCollection = 20006

return V1a6_CachotEvent
