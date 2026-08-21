
Û‰
proto/protocol.protoprotocol"v
ReqLogin
channel (	Rchannel
userID (	RuserID
token (	Rtoken"
refreshToken (	RrefreshToken"B
AckLogin
userID (	RuserID

sessionKey (	R
sessionKey"Ñ
CServiceInfo
	ServiceId (R	ServiceId
Host (	RHost
Port (RPort
Load (RLoad
HostName (	RHostName"’
	CRoleInfo
Nick (	RNick
Sign (	RSign
	PictureId (R	PictureId
BuyGold (RBuyGold
CostGold (RCostGold
Level (RLevel
	MissionId (R	MissionId
TeamId (RTeamId

CreateTick	 (R
CreateTick
Data
 (	RData(
ShareRewardTime (RShareRewardTime"
ClientConfig (	RClientConfig"9
	CRoleItem
ItemId (RItemId
Stack (RStack"r
CRoleLimitTimeItem
Id (RId
ItemId (RItemId
Count (RCount

ExpireTime (R
ExpireTime"=
CRoleCurrency
ItemId (RItemId
Stack (RStack"ì
CPlayerBaseInfo
	AccountId (R	AccountId
	ServiceId (R	ServiceId
AvatarId (RAvatarId
Level (RLevel
Nick (	RNick">
HeroTicketRank
Nick (	RNick
VoteCnt (RVoteCnt"ñ
BridgeLevelRank5
BaseInfo (2.protocol.CPlayerBaseInfoRBaseInfo 
BridgeLevel (RBridgeLevel*
BridgeUpdateTime (RBridgeUpdateTime"á
CRoleCycleEvent
TypeId (RTypeId
Value (RValue
Field0 (RField0
Field1 (RField1
Field2 (RField2"
CRoleMission
	MissionId (R	MissionId
Star (RStar
	FirstTick (R	FirstTick
Count (RCount
DailyRec (RDailyRec
	AwardMask (R	AwardMask"
ClientConfig (	RClientConfig
	SweepFlag (R	SweepFlag"†
CRoleChapter
	ChapterId (R	ChapterId
StarNum (RStarNum
	AwardFlag (R	AwardFlag
Status (RStatus&
ChallengeTimes (RChallengeTimes0
ChallengeUpdateTime (RChallengeUpdateTime

SweepTimes (R
SweepTimes(
SweepUpdateTime (RSweepUpdateTime"ë
	CRoleTask
TaskId (RTaskId
State (RState
Type (RType
Value0 (RValue0
Value1 (RValue1
Tick (RTick"m
CItem
Id (RId
Cnt (RCnt,
ObjType (2.protocol.ItemTypeRObjType
SrcId (RSrcId"Ω
	CRoleMail
Id (RId
SendId (RSendId
Nick (	RNick
TargetId (RTargetId
MailId (RMailId

CreateTime (R
CreateTime
Title (	RTitle
Content (	RContent)
State	 (2.protocol.MailStateRState

ItemLength
 (R
ItemLength%
Items (2.protocol.CItemRItems"œ
	CRoleHero
HeroId (RHeroId

ExpireTime (R
ExpireTime
Fashion (RFashion
Weapon (RWeapon
Level (RLevel
Grade (RGrade
Happy (RHappy
Star (RStar
	CoreLevel	 (R	CoreLevel

SkillLevel
 (R
SkillLevel
Story (RStory
Eater (REater
Garrison (RGarrison
	GenesStar (R	GenesStar*
PersonalityStory (RPersonalityStory

AwakeLevel (R
AwakeLevel
Misc (	RMisc"@

FriendTeam
FriendId (RFriendId
HeroId (RHeroId"À
	CRoleTeam
TeamId (RTeamId

HeroLength (R
HeroLength
Heroes (RHeroes(
CommanderSkills (RCommanderSkills
Name (	RName0
FriTeams (2.protocol.FriendTeamRFriTeams"·
CRoleLottoRec
LottoId (RLottoId

TotalTimes (R
TotalTimes$
GuaranteeFlag (RGuaranteeFlag"
SsrCountdown (RSsrCountdown$
ConditionTime (RConditionTime&
ConditionValue (RConditionValue"≥
CRoleActivity

ActivityId (R
ActivityId$
SubActivityId (RSubActivityId
Value0 (RValue0
Value1 (RValue1
Value2 (RValue2
State (RState"4
CRoleCDK
Id (RId
CdkCode (	RCdkCode"
CDKInfo
Id (RId
CdkCode (	RCdkCode
Reward (RReward
Times (RTimes
	LimitDate (R	LimitDate"í
CPlayerRank
	AccountId (R	AccountId
RankVal (RRankVal
RankExt (RRankExt1
Resume (2.protocol.CPlayerBaseInfoRResume"V

GameNotice
Times (RTimes
Interval (RInterval
Notice (	RNotice"∑
GameCycleNotice
PicOnly (RPicOnly
Interval (RInterval
	StartTick (R	StartTick
EndTick (REndTick

PictureUrl (	R
PictureUrl
Notice (	RNotice"
CRoleBridge"R
CRoleHeroStory
Id (RId
Rec (RRec

UnlockTick (R
UnlockTick"9
	CRoleHall,
Stoves (2.protocol.CRoleStoveRStoves"ù
CRoleHallDesk+
Dishes (2.protocol.CRoleDishRDishes,
Stoves (2.protocol.CRoleStoveRStoves1
	RoleLives (2.protocol.CRoleLiveR	RoleLives"¢

CRoleStove
Type (RType
MenuId (RMenuId
Fire (RFire 
Ingredients (RIngredients&
IngredientsCut (RIngredientsCut
MakeNum (RMakeNum
AwardNum (RAwardNum

SingleTick	 (R
SingleTick
EndTick
 (REndTick
CalcTick (RCalcTick"[
	CRoleDish
Position (RPosition
DishId (RDishId
EatTimes (REatTimes"∫
CRoleFurniture
HeroId (RHeroId
ParentId (RParentId 
FurnitureId (RFurnitureId

TemplateId (R
TemplateId
PosIndex (RPosIndex
Expire (RExpire"@
CHeroDailyAction
Tick (RTick
Actions (RActions"[
	CRoleLive
HeroId (RHeroId
Position (RPosition
LiveType (RLiveType"∑

StudioRoom
StudioId (RStudioId
Name (	RName
Type (RType
Level (RLevel
	BuildTick (R	BuildTick1
	RoleLives (2.protocol.CRoleLiveR	RoleLives"C
CGarrisonInfo
HeroId (RHeroId
Position (RPosition"n
CRoleExtraBuff
Id (RId
BuffId (RBuffId
ModuleId (RModuleId
EndTick (REndTick"Ü

CRolePlant 
FurnitureId (RFurnitureId
Id (RId
Stage (RStage
CalcTick (RCalcTick
State (RState"M
CRolePlantPests 
FurnitureId (RFurnitureId
BugTime (RBugTime"Ñ
CRoleGameMail
Id (RId
MailId (RMailId

CreateTick (R
CreateTick+
Status (2.protocol.MailStateRStatus"H
RedPoint&
Mod (2.protocol.EGameModelRMod
Value (RValue"U
RoleHeroGenes
HeroId (RHeroId
Stars (	RStars
Levels (	RLevels"§

BattleInfo
	AccountId (R	AccountId
	MissionId (R	MissionId
TeamId (RTeamId

Conditions (R
Conditions"
HelpHeroFlag (RHelpHeroFlag"Å

CSweepItem
SweepIdx (RSweepIdx'
Awards (2.protocol.CItemRAwards.
AwardExt (2.protocol.AwardExtRAwardExt"m
HeroSkillInfo

SkillLevel (R
SkillLevel

GradeLevel (R
GradeLevel
	MonsterId (R	MonsterId"â
HeroBattleDetail
HeroId (RHeroId5
	SkillInfo (2.protocol.HeroSkillInfoR	SkillInfo&
ResourceBoxNum (RResourceBoxNum"Ø
CommonMessage
r0 (Rr0
	messageId (R	messageId

sequenceId (R
sequenceId 
messageData (RmessageData

messageLen (R
messageLen
r1 (Rr1"õ
NotifyHeartbeat8
ServiceInfo (2.protocol.CServiceInfoRServiceInfo
Maximum (RMaximum
Online (ROnline
	Privilege (R	Privilege"<
NotifyRedPoint*
Points (2.protocol.RedPointRPoints"A
RequestUpdateRedPoint(
Point (2.protocol.RedPointRPoint"Z
ResponseUpdateRedPoint
Result (RResult(
Point (2.protocol.RedPointRPoint"n
NotifyGameNotice,
Notice (2.protocol.GameNoticeRNotice,
Type (2.protocol.GameNoticeTypeRType"J
NotifyGameCycleNotice1
Notice (2.protocol.GameCycleNoticeRNotice"M
NotifyGameCycleNotices3
Notices (2.protocol.GameCycleNoticeRNotices"+
NotifyNewNotice
version (Rversion"g
RequestRegister
Account (	RAccount
Password (	RPassword

PlatformId (R
PlatformId"*
ResponseRegister
Result (RResult"~
RequestLogin
Account (	RAccount 
TokenLength (RTokenLength
Token (RToken
	LoginMode (R	LoginMode"Î
ResponseLogin
	AccountId (R	AccountId 
TokenLength (RTokenLength
Token (RToken*
SessionKeyLength (RSessionKeyLength

SessionKey (R
SessionKey
	ServiceId (R	ServiceId
OpenTick (ROpenTick"i
NotifyGameServiceInfo
Length (RLength8
ServiceInfo (2.protocol.CServiceInfoRServiceInfo"Ã
RequestPlatformLogin0
Platform (2.protocol.PlatformIdRPlatform$
PlatformIdLen (RPlatformIdLen

PlatformId (R
PlatformId*
PlatformTokenLen (RPlatformTokenLen$
PlatformToken (RPlatformToken(
PlatformMiscLen (RPlatformMiscLen"
PlatformMisc (RPlatformMisc
	Timestamp	 (	R	Timestamp"¬
RequestAccountInfo4

PlatformId (2.protocol.PlatformIdR
PlatformId$
AccountLength (RAccountLength
Account (RAccount 
TokenLength (RTokenLength
Token (RToken"√
ResponseAccountInfo4

PlatformId (2.protocol.PlatformIdR
PlatformId$
AccountLength (RAccountLength
Account (RAccount
	AccountId (R	AccountId
	Privilege (R	Privilege 
TokenLength (RTokenLength
Token (RToken&
PasswordLength (RPasswordLength
Password	 (RPassword"b
RequestAccountBind4

PlatformId (2.protocol.PlatformIdR
PlatformId
OpenId (	ROpenId"{
ResponseAccountBind
Result (RResult4

PlatformId (2.protocol.PlatformIdR
PlatformId
OpenId (	ROpenId"M
RequestGetAccountBind4

PlatformId (2.protocol.PlatformIdR
PlatformId"z
ResponseGetAccountBind
Result (RResult4

PlatformId (2.protocol.PlatformIdR
PlatformId
Data (	RData"
RequestEnterWorld
account (	Raccount
Token (	RToken'
Type (2.protocol.EnterTypeRType
	ServiceId (R	ServiceId&
MessageVersion (RMessageVersion
	ChannelId (R	ChannelId

DeviceInfo (	R
DeviceInfo"Î
ResponseEnterWorld
Result (RResult

ServerTime (R
ServerTime
	AccountId (R	AccountId/
RoleInfo (2.protocol.CRoleInfoRRoleInfo&
MessageVersion (RMessageVersion&
ServerOpenTick (RServerOpenTick"A
RequestSaveRoleClientConfig"
ClientConfig (	RClientConfig"6
ResponseSaveRoleClientConfig
Result (RResult"0
NotifyLeaveWorld
	AccountId (R	AccountId"3
NotifyIgnoreMessage
	MessageId (R	MessageId"9
NotifyRoleItem'
data (2.protocol.CRoleItemRdata"E
NotifyRoleCycleEvent-
data (2.protocol.CRoleCycleEventRdata"C
NotifyRoleHeroStory,
data (2.protocol.CRoleHeroStoryRdata"A
NotifyRoleCurrency+
data (2.protocol.CRoleCurrencyRdata"Q
NotifyRoleHero'
data (2.protocol.CRoleHeroRdata
Module (RModule"9
NotifyRoleTeam'
data (2.protocol.CRoleTeamRdata"?
NotifyRoleMission*
data (2.protocol.CRoleMissionRdata"?
NotifyRoleChapter*
data (2.protocol.CRoleChapterRdata"M
NotifyRoleTask
type (Rtype'
data (2.protocol.CRoleTaskRdata"A
NotifyRoleActivity+
data (2.protocol.CRoleActivityRdata"9
NotifyRoleMail'
data (2.protocol.CRoleMailRdata"A
NotifyRoleLottoRec+
data (2.protocol.CRoleLottoRecRdata"A
NotifyUpdateChapter*
data (2.protocol.CRoleChapterRdata"
RequestLoadChapter"Y
ResponseLoadChapter
Result (RResult*
data (2.protocol.CRoleChapterRdata"
RequestLoadCurrencies"]
ResponseLoadCurrencies
Result (RResult+
Data (2.protocol.CRoleCurrencyRData"Y
NotifyClientHeartbeat
	AccountId (R	AccountId"
Milliseconds (RMilliseconds"e
RequestCreateRole
	AccountId (R	AccountId
RoleName (	RRoleName
RoleId (RRoleId",
ResponseCreateRole
Result (RResult"'
NotifyKickOff
Result (RResult"C
RequestRenameRole
Type (RType
RoleName (	RRoleName"\
ResponseRenameRole
Result (RResult
Type (RType
RoleName (	RRoleName"6
RequestUpdatePictureId
	PictureId (R	PictureId"O
ResponseUpdatePictureId
Result (RResult
	PictureId (R	PictureId"D
RequestCreateTeam/
RoleTeam (2.protocol.CRoleTeamRRoleTeam"]
ResponseCreateTeam
Result (RResult/
RoleTeam (2.protocol.CRoleTeamRRoleTeam"+
RequestActiveTeam
TeamId (RTeamId"D
ResponseActiveTeam
Result (RResult
TeamId (RTeamId"
RequestLoadTeam"S
ResponseLoadTeam
Result (RResult'
Data (2.protocol.CRoleTeamRData"q
RequestUpdateTeam+
Operate (2.protocol.OptionsROperate/
RoleTeam (2.protocol.CRoleTeamRRoleTeam"ä
ResponseUpdateTeam
Result (RResult+
Operate (2.protocol.OptionsROperate/
RoleTeam (2.protocol.CRoleTeamRRoleTeam"=
RequestGameBattle(
Info (2.protocol.BattleInfoRInfo"j
ResponseGameBattle
Result (RResult
Seed (RSeed(
Info (2.protocol.BattleInfoRInfo"B
RequestGameBattleElite(
Info (2.protocol.BattleInfoRInfo"o
ResponseGameBattleElite
Result (RResult
Seed (RSeed(
Info (2.protocol.BattleInfoRInfo"E
RequestGameBattleResource(
Info (2.protocol.BattleInfoRInfo"r
ResponseGameBattleResource
Result (RResult
Seed (RSeed(
Info (2.protocol.BattleInfoRInfo"‘
RequestBattleResult
	MissionId (R	MissionId)
IsWin (2.protocol.BattleResRIsWin
	BattleRec (R	BattleRec2
Detail (2.protocol.HeroBattleDetailRDetail"
HelpHeroFlag (RHelpHeroFlag"∏
ResponseBattleResult
Result (RResult
	MissionId (R	MissionId)
IsWin (2.protocol.BattleResRIsWin
Star (RStar
Score (RScore 
AwardLength (RAwardLength'
Awards (2.protocol.CItemRAwards
TotalExp (RTotalExp.
AwardExt	 (2.protocol.AwardExtRAwardExt"C
AwardExt
Tp (RTp'
Awards (2.protocol.CItemRAwards"1
RequestPassDialog
	MissionId (R	MissionId"J
ResponsePassDialog
Result (RResult
	MissionId (R	MissionId"H
RequestSweepBattle
	MissionId (R	MissionId
Times (RTimes"©
ResponseSweepBattle
Result (RResult
	MissionId (R	MissionId
Times (RTimes*
Items (2.protocol.CSweepItemRItems
TotalExp (RTotalExp"M
RequestSweepBattleElite
	MissionId (R	MissionId
Times (RTimes"Æ
ResponseSweepBattleElite
Result (RResult
	MissionId (R	MissionId
Times (RTimes*
Items (2.protocol.CSweepItemRItems
TotalExp (RTotalExp"P
RequestSweepBattleResource
	MissionId (R	MissionId
Times (RTimes"±
ResponseSweepBattleResource
Result (RResult
	MissionId (R	MissionId
Times (RTimes*
Items (2.protocol.CSweepItemRItems
TotalExp (RTotalExp"@
NotifyMissionScore*
Data (2.protocol.CRoleMissionRData"3
NotifyMissionChange
	MissionId (R	MissionId"P
RequestSaveMissionConfig
	MissionId (R	MissionId
Config (	RConfig"i
ResponseSaveMissionConfig
Result (RResult
Config (	RConfig
	MissionId (R	MissionId"r
RequestSaveCopyMissionConfig
	ChapterId (R	ChapterId
	MissionId (R	MissionId
Config (	RConfig"ã
ResponseSaveCopyMissionConfig
Result (RResult
	ChapterId (R	ChapterId
	MissionId (R	MissionId
Config (	RConfig"E
RequestChapterAward
	ChapterId (R	ChapterId
Idx (RIdx"á
ResponseChapterAward
Result (RResult
	ChapterId (R	ChapterId
Idx (RIdx'
Awards (2.protocol.CItemRAwards"D
ChapterActInfo
SubId (RSubId
	AwardFlag (R	AwardFlag"1
RequestChapterActInfo
EntryId (REntryId"^
ResponseChapterActInfo
Result (RResult,
Info (2.protocol.ChapterActInfoRInfo"f
RequestChapterActAward
	ChapterId (R	ChapterId
EntryId (REntryId
SubId (RSubId"à
ResponseChapterActAward
Result (RResult,
info (2.protocol.ChapterActInfoRinfo'
Awards (2.protocol.CItemRAwards"+
RequestGetGrowthAward
step (Rstep"m
ResponseGetGrowthAward
Result (RResult
step (Rstep'
Awards (2.protocol.CItemRAwards"0
RequestFastCollect
FreeFlag (RFreeFlag"Ú
ResponseFastCollect
Result (RResult
	FreeTimes (R	FreeTimes
	StarTimes (R	StarTimes

TotalTimes (R
TotalTimes/

AwardItems (2.protocol.CItemR
AwardItems
	MissionId (R	MissionId
Refresh (RRefresh"u
NotifyMissionHangingAward/
Event (2.protocol.CRoleCycleEventREvent'
Awards (2.protocol.CItemRAwards"+
RequestLoadTaskByType
Type (RType"q
ResponseLoadTaskByType
Type (RType'
Data (2.protocol.CRoleTaskRData
Finished (RFinished"-
RequestCompleteTask
TaskId (RTaskId"o
ResponseCompleteTask
Result (RResult
TaskId (RTaskId'
Awards (2.protocol.CItemRAwards".
RequestCompleteTasks
TaskId (RTaskId"ä
ResponseCompleteTasks
Result (RResult
TaskId (RTaskId
Results (RResults'
Awards (2.protocol.CItemRAwards"`
NotifyUpdateTask#
Opt (2.protocol.OptionsROpt'
Task (2.protocol.CRoleTaskRTask"a
NotifyUpdateTasks#
Opt (2.protocol.OptionsROpt'
Data (2.protocol.CRoleTaskRData";
NotifyDailyTasks'
Data (2.protocol.CRoleTaskRData"(
RequestDelMail
MailId (RMailId"A
ResponseDelMail
Result (RResult
MailId (RMailId"C
RequestOpenMail
MailId (RMailId
Extract (RExtract"Å
ResponseOpenMail
Result (RResult
MailId (RMailId
Extract (RExtract#
Data (2.protocol.CItemRData"F
RequestOpenMails
MailIds (RMailIds
Extract (RExtract"ú
ResponseOpenMails
Result (RResult
Results (RResults
MailId (RMailId
Extract (RExtract#
Data (2.protocol.CItemRData"+
RequestDelMails
MailIds (RMailIds"^
ResponseDelMails
Result (RResult
MailIds (RMailIds
Results (RResults"h
NotifyNewMail
SenderId (RSenderId
Nick (	RNick'
Mail (2.protocol.CRoleMailRMail"+
RequestGetNewMail
MailId (RMailId"m
ResponseGetNewMail
Result (RResult
MailId (RMailId'
Mail (2.protocol.CRoleMailRMail"&
RequestLoadMails
Page (RPage"ñ
ResponseLoadMails
Result (RResult
Page (RPage
Count (RCount
Total (RTotal)
Mails (2.protocol.CRoleMailRMails"&
RequestLoadItems
Page (RPage"î
ResponseLoadItems
Result (RResult
Page (RPage
Count (RCount
Total (RTotal'
Data (2.protocol.CRoleItemRData"_
NotifyClientItemInfo

IsFinished (R
IsFinished'
Data (2.protocol.CRoleItemRData";
NotifyUpdateItem'
Data (2.protocol.CRoleItemRData"8
NotifyDelItem'
Data (2.protocol.CRoleItemRData"E
RequestSellItem
	PackageId (R	PackageId
Count (RCount"r
ResponseSellItem
Result (RResult
	PackageId (R	PackageId
Count (RCount
Coin (RCoin"9
RequestSellItems%
Items (2.protocol.CItemRItems"f
ResponseSellItems
Result (RResult
Coin (RCoin%
Items (2.protocol.CItemRItems"Ç
RequestUseItem
	Decompose (R	Decompose
Count (RCount
	PackageId (R	PackageId

SelItemIdx (R
SelItemIdx"†
ResponseUseItem
Result (RResult
	PackageId (R	PackageId
	Decompose (R	Decompose
Count (RCount#
Objs (2.protocol.CItemRObjs"K
NotifyItemOverStack
ItemId (RItemId
	OverStack (R	OverStack",
RequestHeroLevelUp
HeroId (RHeroId"V
ResponseHeroLevelUp
Result (RResult'
Data (2.protocol.CRoleHeroRData"O
RequestHeroLevelsUp
HeroId (RHeroId 
TargetLevel (RTargetLevel"W
ResponseHeroLevelsUp
Result (RResult'
Data (2.protocol.CRoleHeroRData"G
RequestHeroAdvanced
HeroId (RHeroId
BreakId (RBreakId"`
ResponseHeroAdvanced
Result (RResult
HeroId (RHeroId
BreakId (RBreakId"C
RequestHeroStar
HeroId (RHeroId
Instead (RInstead"Z
ResponseHeroStar
Result (RResult
HeroId (RHeroId
StarId (RStarId"?
NotifyUpdateRoleHero'
Data (2.protocol.CRoleHeroRData"~
RequestUpdateGuide 
CurrentStep (RCurrentStep
Value0 (RValue0
Value1 (RValue1
Value2 (RValue2"T
ResponseUpdateGuide
Result (RResult%
Items (2.protocol.CItemRItems"I
NotifyUpdateCycleEvent/
Event (2.protocol.CRoleCycleEventREvent"i
RequestGameLotto
LottoId (RLottoId
Times (RTimes%
Items (2.protocol.CItemRItems"—
ResponseGameLotto
Result (RResult
LottoId (RLottoId
Length (RLength9
Data (2%.protocol.ResponseGameLotto.CLottoObjRData#
Cost (2.protocol.CItemRCost%
Other (2.protocol.CItemROtherk
	CLottoObj
ObjId (RObjId
ObjNum (RObjNum
ChipId (RChipId
ChipNum (RChipNum"j
NotifyUpdateLottoRec%
Type (2.protocol.OptionsRType+
Data (2.protocol.CRoleLottoRecRData"
RequestLoadActivities"E
ResponseLoadActivities+
data (2.protocol.CRoleActivityRdata"t
RequestCommonActivityAward

ActivityId (R
ActivityId$
SubActivityId (RSubActivityId
Num (RNum"w
SubActivityAward
Result (RResult$
SubActivityId (RSubActivityId%
Items (2.protocol.CItemRItems"ù
ResponseCommonActivityAward
Result (RResult

ActivityId (R
ActivityIdF
SubActivityAward (2.protocol.SubActivityAwardRSubActivityAward"$
RequestActivityBuy
Id (RId"f
ResponseActivityBuy
Result (RResult
Id (RId'
Awards (2.protocol.CItemRAwards"$
RequestOnlineAward
Id (RId"f
ResponseOnlineAward
Result (RResult
Id (RId'
Awards (2.protocol.CItemRAwards"%
RequestDailyAward
Ids (RIds"g
ResponseDailyAward
Result (RResult
Ids (RIds'
Awards (2.protocol.CItemRAwards"P
RequestActivityAward
Idx (RIdx&
Type (2.protocol.EACTTypeRType"í
ResponseActivityAward
Result (RResult
Idx (RIdx&
Type (2.protocol.EACTTypeRType'
Awards (2.protocol.CItemRAwards"?
RequestActivityAwards&
Type (2.protocol.EACTTypeRType"Å
ResponseActivityAwards
Result (RResult&
Type (2.protocol.EACTTypeRType'
Awards (2.protocol.CItemRAwards"C
NotifyUpdateActivity+
Data (2.protocol.CRoleActivityRData"]
NotifyUpdateActivities
Length (RLength+
Data (2.protocol.CRoleActivityRData"5
RequestOpenActivity

ActivityId (R
ActivityId"§
ResponseOpenActivity
Result (RResult7

ConfigData (2.protocol.ActConfigDataR
ConfigData;
ActivityData (2.protocol.CRoleActivityRActivityData"
RequestActConfig"Ö
ActConfigData

ActivityId (R
ActivityId
	StartTime (R	StartTime
EndTime (REndTime
	CloseTime (R	CloseTime"X
ResponseActConfig
Result (RResult+
Data (2.protocol.ActConfigDataRData"0
RequestActData

ActivityId (R
ActivityId"v
ResponseActData
Result (RResult

ActivityId (R
ActivityId+
Data (2.protocol.CRoleActivityRData"R
RequestTriggerTask$
TaskCondition (RTaskCondition
Params (RParams"-
ResponseTriggerTask
Result (RResult"]
RequestVote

ActivityId (R
ActivityId
HeroId (RHeroId
Ticket (RTicket"M
ResponseVote
Result (RResult%
Award (2.protocol.CItemRAward"I
RequestVoteInfo

ActivityId (R
ActivityId
HeroId (RHeroId"P
ResponseVoteInfo
Result (RResult
Cnt (RCnt
Rank (RRank"1
RequestHeroRank

ActivityId (R
ActivityId"√
ResponseHeroRank
Result (RResult:
Data (2&.protocol.ResponseHeroRank.CHeroTicketRData
	Countdown (R	Countdown=
CHeroTicket
HeroId (RHeroId
Ticket (RTicket"P
RequestHeroSupportRank

ActivityId (R
ActivityId
HeroId (RHeroId"_
ResponseHeroSupportRank
Result (RResult,
Data (2.protocol.HeroTicketRankRData"1
RequestLastRank

ActivityId (R
ActivityId"\
ResponseLastRank
Result (RResult
HeroId (RHeroId
players (	Rplayers"o
RequestBridgeRank

ActivityId (R
ActivityId
	StartRank (R	StartRank
	RankCount (R	RankCount"π
ResponseBridgeRank
Result (RResult

ActivityId (R
ActivityId
	StartRank (R	StartRank

TotalCount (R
TotalCount-
Data (2.protocol.BridgeLevelRankRData"5
RequestBridgeMyRank

ActivityId (R
ActivityId"F
ResponseBridgeMyRank
Result (RResult
MyRank (RMyRank"
RequestLoadGlobalCDK"V
ResponseLoadGlobalCDK
Result (RResult%
Data (2.protocol.CDKInfoRData"?
RequestUpdateGlobalCDK%
Data (2.protocol.CDKInfoRData"
RequestLoadRoleCDK"=
ResponseLoadRoleCDK&
Data (2.protocol.CRoleCDKRData">
RequestUpdateRoleCDK&
Data (2.protocol.CRoleCDKRData"%
RequestUseCDK
CDKey (	RCDKey"c
ResponseUseCdk
Result (RResult
CDKey (	RCDKey#
Data (2.protocol.CItemRData";
RequestRoleSign
Type (RType
Index (RIndex"c
ResponseRoleSign
Result (RResult
Type (RType#
Data (2.protocol.CItemRData"ë
RequestRoleRecharge
	AccountId (R	AccountId

RechargeId (R
RechargeId"
RechargeType (RRechargeType
ExtData (	RExtData"˛
ResponseRoleRecharge
Result (RResult

RechargeId (R
RechargeId
OrderId (ROrderId
ServerId (RServerId
	TransData (	R	TransData"
RechargeType (RRechargeType
	OrderInfo (	R	OrderInfo
ExtData (	RExtData"Õ
NotifyRechargeResult
Result (RResult

RechargeId (R
RechargeId
OrderId (ROrderId
Diamond (RDiamond$
RechargeState (RRechargeState#
Data (2.protocol.CItemRData"N
RequestStoryReward
StoryId (RStoryId

StoryIndex (R
StoryIndex"å
ResponseStoryReward
Result (RResult
StoryId (RStoryId

StoryIndex (R
StoryIndex#
Data (2.protocol.CItemRData"
RequestBrowseStudio"Å
ResponseBrowseStudio
Result (RResult.
Studios (2.protocol.StudioRoomRStudios,
Maker (2.protocol.ProduceMakerRMaker8

Expedition (2.protocol.ExpeditionTaskR
Expedition9
DiningTable (2.protocol.DiningTableCDRDiningTable".
RequestHouseRename
NewName (	RNewName"G
ResponseHouseRename
Result (RResult
NewName (	RNewName"(
RequestBuildStudio
Type (RType"W
ResponseBuildStudio
Result (RResult(
Data (2.protocol.StudioRoomRData"ú
RequestGarrisonStudio
Clean (RClean
LiveType (RLiveType
StudioId (RStudioId5
	Garrisons (2.protocol.CGarrisonInfoR	Garrisons"`
ResponseGarrisonStudio
Result (RResult.
Studios (2.protocol.StudioRoomRStudios"q
RequestCancelGarrisonStudio
LiveType (RLiveType
StudioId (RStudioId
Position (RPosition"d
ResponseCancelGarrisonStudio
Result (RResult,
Studio (2.protocol.StudioRoomRStudio"2
RequestStudioUpgrade
StudioId (RStudioId"]
ResponseStudioUpgrade
Result (RResult,
Studio (2.protocol.StudioRoomRStudio";
MakerBuffUnit
Final (RFinal
Ratio (RRatio"€
ProduceMaker
StudioId (RStudioId

MakeItemId (R
MakeItemId
Position (RPosition 
MakeItemNum (RMakeItemNum$
CalculateTick (RCalculateTick
EndTick (REndTick
AwardNum (RAwardNum
Progress (RProgress"
TerminalTick	 (RTerminalTick5
	BuffUnits
 (2.protocol.MakerBuffUnitR	BuffUnits"l
RequestStudioProduce
StudioId (RStudioId

MakeItemId (R
MakeItemId
MakeNum (RMakeNum"a
ResponseStudioProduce
Result (RResult0
Produce (2.protocol.ProduceMakerRProduce"Q
NotifyStudioMakeStateChange2
Produces (2.protocol.ProduceMakerRProduces"5
RequestStudioMakerAward
StudioId (RStudioId"ß
ResponseStudioMakerAward
Result (RResult
StudioId (RStudioId0
Produce (2.protocol.ProduceMakerRProduce%
Items (2.protocol.CItemRItems"
RequestStudioMakerAwardAll"é
ResponseStudioMakerAwardAll
Result (RResult%
Items (2.protocol.CItemRItems0
Produce (2.protocol.ProduceMakerRProduce"4
RequestStudioMakerFast
StudioId (RStudioId"c
ResponseStudioMakerFast
Result (RResult0
Produce (2.protocol.ProduceMakerRProduce"_
RequestGiveHeroItem
HeroId (RHeroId
ItemId (RItemId
ItemNum (RItemNum"∞
ResponseGiveHeroItem
Result (RResult
HeroId (RHeroId
AddFavor (RAddFavor%
Items (2.protocol.CItemRItems%
Gifts (2.protocol.CItemRGifts"
RequestFeedbackGift"S
ResponseFeedbackGift
Result (RResult#
Gift (2.protocol.CItemRGift"^
RequestCooking
	MakeTimes (R	MakeTimes
MenuId (RMenuId
Studio (RStudio"≥
ResponseCooking
Result (RResult
MenuId (RMenuId
Studio (RStudio%
Items (2.protocol.CItemRItems1
EffectItems (2.protocol.CItemREffectItems"}
DiningTableCD
StudioId (RStudioId
Position (RPosition
EndTick (REndTick
Capacity (RCapacity"[
NotifyDiningTableEatCdChange;
DiningTables (2.protocol.DiningTableCDRDiningTables"j
RequestInviteHeroEat
StudioId (RStudioId
	Positions (R	Positions
HeroIds (RHeroIds"l
ResponseInviteHeroEat
Result (RResult;
DiningTables (2.protocol.DiningTableCDRDiningTables"
RequestCanteenStar"i
ResponseCanteenStar
Result (RResult
Star (RStar
Tick (RTick
Food (RFood"»
ExpeditionTask
Id (RId
ConfigId (RConfigId
Weather (RWeather
EventId (REventId
Pos (RPos
Heroes (RHeroes
Food (RFood
EndTick (REndTick"j
RequestBeginExpMission
Foods (RFoods"
ExpMissionId (RExpMissionId
Heroes (RHeroes"s
ResponseBeginExpMission
Result (RResult@
ExpMissionTask (2.protocol.ExpeditionTaskRExpMissionTask"
RequestAwardExpMissionAll"ù
ResponseAwardExpMissionAll
Result (RResult'
Awards (2.protocol.CItemRAwards>
NewExpMission (2.protocol.ExpeditionTaskRNewExpMission"<
RequestAwardExpMission"
ExpMissionId (RExpMissionId"æ
ResponseAwardExpMission
Result (RResult"
ExpMissionId (RExpMissionId'
Awards (2.protocol.CItemRAwards>
NewExpMission (2.protocol.ExpeditionTaskRNewExpMission";
RequestExpMissionFast"
ExpMissionId (RExpMissionId"j
ResponseExpMissionFast
Result (RResult8

Expedition (2.protocol.ExpeditionTaskR
Expedition"
RequestRefreshExpMission"c
ResponseRefreshExpMission
Result (RResult.
Tasks (2.protocol.ExpeditionTaskRTasks"H
NotifyExpeditionChange.
Tasks (2.protocol.ExpeditionTaskRTasks"E
NotifyUpdateFurniture,
Data (2.protocol.CRoleFurnitureRData"å
 RequestLookHeroFeelingLevelStory
HeroId (RHeroId"
FeelingLevel (RFeelingLevel
StepId (RStepId
Index (RIndex"ö
!ResponseLookHeroFeelingLevelStory
Result (RResult'
Awards (2.protocol.CItemRAwards
HeroId (RHeroId
	RoomStory (R	RoomStory"
RequestAwardStudio"V
ResponseAwardStudio
Result (RResult'
Awards (2.protocol.CItemRAwards"
RequestEnterHeroStory"l
ResponseEnterHeroStory
Result (RResult:
HeroStories (2.protocol.CRoleHeroStoryRHeroStories"J
RequestDrawStoryGift
StoryId (RStoryId
Choices (RChoices"õ
ResponseDrawStoryGift
Result (RResult
HeroId (RHeroId
AddFavor (RAddFavor6
	HeroStory (2.protocol.CRoleHeroStoryR	HeroStory"0
RequestAwardAtmosphere
HeroId (RHeroId"p
ResponseAwardAtmosphere
Result (RResult
Level (RLevel'
Awards (2.protocol.CItemRAwards"*
RequestLoadFurniture
Page (RPage"©
ResponseLoadFurniture
Result (RResult
Page (RPage
Count (RCount
Total (RTotal8

Furnitures (2.protocol.CRoleFurnitureR
Furnitures"0
RequestLoadFurnitureByType
Type (RType"É
ResponseLoadFurnitureByType
Result (RResult
Type (RType8

Furnitures (2.protocol.CRoleFurnitureR
Furnitures"2
RequestLoadRoomFurniture
HeroId (RHeroId"Ö
ResponseLoadRoomFurniture
Result (RResult
HeroId (RHeroId8

Furnitures (2.protocol.CRoleFurnitureR
Furnitures"M
RequestSetFurniture6
	Furniture (2.protocol.CRoleFurnitureR	Furniture"f
ResponseSetFurniture
Result (RResult6
	Furniture (2.protocol.CRoleFurnitureR	Furniture"P
RequestSetFurnitures8

Furnitures (2.protocol.CRoleFurnitureR
Furnitures"i
ResponseSetFurnitures
Result (RResult8

Furnitures (2.protocol.CRoleFurnitureR
Furnitures"v
CRoleExtraMapCondition
Id (RId
ConfigId (RConfigId
Origin (ROrigin
EndTick (REndTick"
RequestExtraMapCondition"{
ResponseExtraMapCondition
Result (RResultF
MapConditions (2 .protocol.CRoleExtraMapConditionRMapConditions"
RequestLoadLimitTimeItems"f
ResponseLoadLimitTimeItems
Result (RResult0
Data (2.protocol.CRoleLimitTimeItemRData"?
RequestUseLimitTimeItem
Id (RId
Count (RCount"X
ResponseUseLimitTimeItem
Result (RResult
Id (RId
Count (RCount"M
NotifyUpdateLimitTimeItem0
Data (2.protocol.CRoleLimitTimeItemRData"%
RequestLoadHero
Page (RPage"{
ResponseLoadHero
Page (RPage
Count (RCount
Total (RTotal'
Data (2.protocol.CRoleHeroRData"
RequestLoadCycleEvent"G
ResponseLoadCycleEvent-
Data (2.protocol.CRoleCycleEventRData"%
RequestLoadTask
Type (RType"k
ResponseLoadTask
Type (RType'
Data (2.protocol.CRoleTaskRData
Finished (RFinished"(
RequestLoadMission
Page (RPage"ô
ResponseLoadMission
Result (RResult
Page (RPage
Count (RCount
Total (RTotal*
Data (2.protocol.CRoleMissionRData"8
RequestLoadCopyMission

ChapterIds (R
ChapterIds"}
ResponseLoadCopyMission
Result (RResult

ChapterIds (R
ChapterIds*
Data (2.protocol.CRoleMissionRData"
RequestLoadLottoRec"ü
ResponseLoadLottoRec
Result (RResult 
FirstHeroId (RFirstHeroId 
FirstItemId (RFirstItemId+
Data (2.protocol.CRoleLottoRecRData"
RequestMonthSign"P
ResponseMonthSign
Result (RResult#
data (2.protocol.CItemRdata"
RequestEnterShop"U
ResponseEnterShop
Result (RResult(
Shops (2.protocol.ShopDataRShops"t
ShopData
ShopId (RShopId
DueTick (RDueTick6
BuyShopItems (2.protocol.ShopItemRBuyShopItems"d
ShopItem
ItemId (RItemId
BuyTimes (RBuyTimes$
NextResetTime (RNextResetTime",
RequestRefreshShop
ShopId (RShopId"U
ResponseRefreshShop
Result (RResult&
Data (2.protocol.ShopDataRData"`
RequestBuyItem
ShopId (RShopId

ShopItemId (R
ShopItemId
BuyCnt (RBuyCnt"ê
ResponseBuyItem
Result (RResult
ShopId (RShopId&
Item (2.protocol.ShopItemRItem%
Items (2.protocol.CItemRItems"È
NotifyRechargeShopBuy
ShopId (RShopId&
Item (2.protocol.ShopItemRItem/

AwardItems (2.protocol.CItemR
AwardItems9
	FirstInfo (2.protocol.FirstRechargeInfoR	FirstInfo$
RechargeState (RRechargeState"
RequestShopRedPoint"N
ResponseShopRedPoint
Result (RResult

PointCount (R
PointCount"0
RequestHeroCoreLevelUp
HeroId (RHeroId"g
ResponseHeroCoreLevelUp
Result (RResult
	CoreLevel (R	CoreLevel
HeroId (RHeroId"Y
RequestGameCmd-
cmdType (2.protocol.GmCmdTypeRcmdType
cmdPara (	RcmdPara")
ResponseGameCmd
Result (RResult">
LiveInfo
HeroId (RHeroId
Position (RPosition"i
	TrainInfo
StudioId (RStudioId"
EndTrainTime (REndTrainTime
	StartTime (R	StartTime"5
RequestEnterTrainStudio
StudioId (RStudioId"N
ResponseEnterTrainStudio
Result (RResult
StudioId (RStudioId"B
NotifyTrainStudioChange'
Info (2.protocol.TrainInfoRInfo"G
NotifyLeaveStudio
StudioId (RStudioId
HeroId (RHeroId"•
StudioHeroEater
HeroId (RHeroId
Eater (REater

ChangeTick (R
ChangeTick

EaterRatio (R
EaterRatio$
EaterRatioEnd (REaterRatioEnd"L
NotifyHeroSatietyChange1
Heroes (2.protocol.StudioHeroEaterRHeroes"E
NotifyHeroFavorChange
HeroId (RHeroId
Favor (RFavor"7
RequestEnterProduceStudio
StudioId (RStudioId"P
ResponseEnterProduceStudio
Result (RResult
StudioId (RStudioId"7
RequestEnterCanteenStudio
StudioId (RStudioId"P
ResponseEnterCanteenStudio
Result (RResult
StudioId (RStudioId"5
RequestEnterDormitoryStudio
HeroId (RHeroId"N
ResponseEnterDormitoryStudio
Result (RResult
HeroId (RHeroId"-
RequestDormInteract
HeroId (RHeroId".
ResponseDormInteract
Result (RResult"Â
CRoleStudioHero
HeroId (RHeroId
Eater (REater
Favor (RFavor

StageStory (R
StageStory
	RoomStory (R	RoomStory

EaterRatio (R
EaterRatio$
EaterRatioEnd (REaterRatioEnd
CallTick (RCallTick
	RoomStyle	 (R	RoomStyle

EventLevel
 (R
EventLevel$
EventNodeType (REventNodeType
	EventNode (R	EventNode
GiftRec (RGiftRec 
RepresentId (RRepresentId
	LoveValue (R	LoveValue
	TimeStamp (R	TimeStamp
	IsTrigger (R	IsTrigger

Atmosphere (R
Atmosphere
	DormState (R	DormState
Fashion (RFashion"+
RequestLoadStudioHero
Page (RPage"Ø
ResponseLoadStudioHero
Result (RResult
Page (RPage
Count (RCount
Total (RTotal=
StudioHeroes (2.protocol.CRoleStudioHeroRStudioHeroes"Q
NotifyStudioHero=
StudioHeroes (2.protocol.CRoleStudioHeroRStudioHeroes"T
NotifyNewStudioHero=
StudioHeroes (2.protocol.CRoleStudioHeroRStudioHeroes"N
RequestChangeRoomStyle
HeroId (RHeroId
	RoomStyle (R	RoomStyle"g
ResponseChangeRoomStyle
Result (RResult
HeroId (RHeroId
	RoomStyle (R	RoomStyle"T
CRoleCommander
CmdId (RCmdId
Level (RLevel
HeroId (RHeroId"
RequestEnterCommanderSkill"o
ResponseEnterCommanderSkill
Result (RResult8

Commanders (2.protocol.CRoleCommanderR
Commanders"8
RequestCommanderSkillUpgrade
SkillId (RSkillId"o
ResponseCommanderSkillUpgrade
Result (RResult6
	Commander (2.protocol.CRoleCommanderR	Commander"T
 RequestCommanderSkillSettingHero
SkillId (RSkillId
HeroId (RHeroId"s
!ResponseCommanderSkillSettingHero
Result (RResult6
	Commander (2.protocol.CRoleCommanderR	Commander"»
RoleBook
BookType (RBookType
Rewards (RRewards
EntryId (REntryId3
Pages (2.protocol.RoleBook.PagesEntryRPages?
	Dormitory (2!.protocol.RoleBook.DormitoryEntryR	Dormitory8

PagesEntry
key (Rkey
value (Rvalue:8<
DormitoryEntry
key (Rkey
value (Rvalue:8"(
RequestEnterBook
Types (RTypes"U
ResponseEnterBook
Result (RResult(
Books (2.protocol.RoleBookRBooks"V
RequestRewardBookAward
BookType (RBookType 
RewardIndex (RRewardIndex"ñ
ResponseRewardBookAward
Result (RResult
BookType (RBookType 
RewardIndex (RRewardIndex%
Items (2.protocol.CItemRItems"W
RequestRewardBooksAward
BookType (RBookType 
RewardIndex (RRewardIndex"ó
ResponseRewardBooksAward
Result (RResult
BookType (RBookType 
RewardIndex (RRewardIndex%
Items (2.protocol.CItemRItems")
RequestEnterBookStory
Ids (RIds"Z
ResponseEnterBookStory
Result (RResult(
Books (2.protocol.RoleBookRBooks"Z
RequestUnlockBookStory 
BookStoryId (RBookStoryId

SubStoryId (R
SubStoryId"s
ResponseUnlockBookStory
Result (RResult 
BookStoryId (RBookStoryId

SubStoryId (R
SubStoryId"Y
RequestRewardBookStoryAward
EntryId (REntryId 
RewardIndex (RRewardIndex"ô
ResponseRewardBookStoryAward
Result (RResult
EntryId (REntryId 
RewardIndex (RRewardIndex%
Items (2.protocol.CItemRItems";
NotifyLevelChange
Level (RLevel
Exp (RExp"n
RequestHeroEventStoryTrigger
HeroId (RHeroId
	EventType (R	EventType
EventId (REventId"á
ResponseHeroEventStoryTrigger
Result (RResult
HeroId (RHeroId
	EventType (R	EventType
EventId (REventId"5
RequestHeroEventStoryCommit
HeroId (RHeroId"ó
ResponseHeroEventStoryCommit
Result (RResult
HeroId (RHeroId

EventLevel (R
EventLevel'
Awards (2.protocol.CItemRAwards"G
RequestPersonalityStory
HeroId (RHeroId
Grade (RGrade"µ
ResponsePersonalityStory
Result (RResult
HeroId (RHeroId
Grade (RGrade*
PersonalityStory (RPersonalityStory'
Awards (2.protocol.CItemRAwards"Æ
MiniGameRecord
Id (RId
SpanTime (RSpanTime
Score (RScore

RewardTime (R
RewardTime 
RewardCount (RRewardCount
Payload (	RPayload"
RequestMiniGameRecord"d
ResponseMiniGameRecord
Result (RResult2
Records (2.protocol.MiniGameRecordRRecords"á
RequestMiniGameResult
Id (RId
Hero (RHero
SpanTime (RSpanTime
Score (RScore
Payload (	RPayload"b
ResponseMiniGameResult
Result (RResult0
Record (2.protocol.MiniGameRecordRRecord".
RequestSetTimeOffset
Offset (ROffset"A
ResponseSetTimeOffset
Result (RResult
Now (RNow"
RequestEnterEncounter"Å
ResponseEnterEncounter
Result (RResult

Difficulty (R
Difficulty
CycleId (RCycleId 
LastCycleId (RLastCycleId&
LastDifficulty (RLastDifficulty+
Data (2.protocol.EncounterDataRData

CreateTick (R
CreateTick"G
RequestGarrisonHero
ZoneId (RZoneId
HeroIds (RHeroIds".
ResponseGarrisonHero
Result (RResult"¡
EncounterTeam
TeamIdx (RTeamIdx
Heroes (RHeroes.
FriTeam (2.protocol.FriendTeamRFriTeam$
CommandSkills (RCommandSkills(
GarrisonHeroIds (RGarrisonHeroIds"å
EncounterData
ZoneId (RZoneId
State (RState 
RewardState (RRewardState+
Team (2.protocol.EncounterTeamRTeam"É
RequestEncounterStart
ZoneId (RZoneId.
EncounterMissionId (REncounterMissionId"
HelpHeroFlag (RHelpHeroFlag"x
ResponseEncounterStart
Result (RResult
ZoneId (RZoneId.
EncounterMissionId (REncounterMissionId"∂
RequestEncounterEnd
ZoneId (RZoneId/
Result (2.protocol.MissionResultRResult"
HelpHeroFlag (RHelpHeroFlag2
Detail (2.protocol.HeroBattleDetailRDetail"q
MissionResult.
EncounterMissionId (REncounterMissionId
WordList (RWordList
IsWin (RIsWin"ƒ
ResponseEncounterEnd
Result (RResult
ZoneId (RZoneId.
EncounterMissionId (REncounterMissionId
State (RState 
RewardState (RRewardState
IsWin (RIsWin"a
RequestUpdateEncounterTeam
ZoneId (RZoneId+
Team (2.protocol.EncounterTeamRTeam"5
ResponseUpdateEncounterTeam
Result (RResult"/
RequestEncounterReset
ZoneId (RZoneId"0
ResponseEncounterReset
Result (RResult"`
RequestEncounterAwards
ZoneId (RZoneId.
EncounterMissionId (REncounterMissionId"º
ResponseEncounterAwards
Result (RResult%
Award (2.protocol.CItemRAward
TotalExp (RTotalExpF
RewardStates (2".protocol.EncounterZoneRewardStateRRewardStates"T
EncounterZoneRewardState
ZoneId (RZoneId 
RewardState (RRewardState".
RequestLoadHeroGenes
HeroId (RHeroId"\
ResponseLoadHeroGenes
Result (RResult+
data (2.protocol.RoleHeroGenesRdata"[
RequestHeroGenesLevelUp
HeroId (RHeroId
Slot (RSlot
Level (RLevel"t
ResponseHeroGenesLevelUp
Result (RResult
HeroId (RHeroId
Slot (RSlot
Level (RLevel"X
RequestHeroGenesStarUp
HeroId (RHeroId
Slot (RSlot
Star (RStar"á
ResponseHeroGenesStarUp
Result (RResult
HeroId (RHeroId
Slot (RSlot
Star (RStar
Level (RLevel"2
RequestHeroGenesActivate
HeroId (RHeroId"i
ResponseHeroGenesActivate
Result (RResult
HeroId (RHeroId
	StarLevel (R	StarLevel":
RequestEnterActivityCopy

ActivityId (R
ActivityId"3
ResponseEnterActivityCopy
Result (RResult"∂
RequestActivityStartBattle

ActivityId (R
ActivityId
	MissionId (R	MissionId
TeamId (RTeamId"
HelpHeroFlag (RHelpHeroFlag

Conditions (R
Conditions"i
ResponseActivityStartBattle
Result (RResult

ActivityId (R
ActivityId
Seed (RSeed"ë
RequestActivityEndBattle

ActivityId (R
ActivityId
	MissionId (R	MissionId"
HelpHeroFlag (RHelpHeroFlag)
IsWin (2.protocol.BattleResRIsWin
Length (RLength
	BattleRec (R	BattleRec2
Detail (2.protocol.HeroBattleDetailRDetail"•
ResponseActivityEndBattle
Result (RResult

ActivityId (R
ActivityId)
IsWin (2.protocol.BattleResRIsWin
Star (RStar'
Awards (2.protocol.CItemRAwards
	MissionId (R	MissionId
TotalExp (RTotalExp.
AwardExt (2.protocol.AwardExtRAwardExt"p
RequestActivitySweepBattle

ActivityId (R
ActivityId
	MissionId (R	MissionId
Times (RTimes"ª
ResponseActivitySweepBattle
Result (RResult

ActivityId (R
ActivityId
	MissionId (R	MissionId*
Items (2.protocol.CSweepItemRItems
TotalExp (RTotalExp"4
RequestGlobalTimes

ActivityId (R
ActivityId"O
ResponseGlobalTimes
Result (RResult 
GlobalTimes (RGlobalTimes"0
RequestBuyPass

ActivityId (R
ActivityId")
ResponseBuyPass
Result (RResult"
RequestRechargeInfo"Ö
ResponseRechargeInfo
Result (RResult$
RechargeState (RRechargeState/
Info (2.protocol.FirstRechargeInfoRInfo"
RequestFirstChargeReward"ó
ResponseFirstChargeReward
Result (RResult'
Reward (2.protocol.CItemRReward9
	FirstInfo (2.protocol.FirstRechargeInfoR	FirstInfo"
RequestMonthCardInfo"o
ResponseMonthCardInfo
Result (RResult
EndTime (REndTime$
GetRewardTime (RGetRewardTime"Î
NotifyRechargeMonthCard
EndTime (REndTime$
GetRewardTime (RGetRewardTime/

AwardItems (2.protocol.CItemR
AwardItems9
	FirstInfo (2.protocol.FirstRechargeInfoR	FirstInfo$
RechargeState (RRechargeState"O
RequestBuyPassExp

ActivityId (R
ActivityId
BuyGrade (RBuyGrade",
ResponseBuyPassExp
Result (RResult"
RequestActivityRedPoint"_
ResponseActivityRedPoint
Result (RResult+
Data (2.protocol.CRoleActivityRData"t
CAchievement
Id (RId
State (RState

Parameter1 (R
Parameter1

FinishTime (R
FinishTime"B
CAchievementDone
Id (RId

FinishTime (R
FinishTime"y
CAchievementGroup
GroupId (RGroupId
Score (RScore
AwardNum (RAwardNum
DoneNum (RDoneNum"R
CAchievementShow
Id (RId
Score (RScore
DoneNum (RDoneNum"
RequestAchievementShowInfo"u
ResponseAchievementShowInfo
Result (RResult>
Achievements (2.protocol.CAchievementShowRAchievements"^
RequestUpdateAchievementShow>
Achievements (2.protocol.CAchievementShowRAchievements"7
ResponseUpdateAchievementShow
Result (RResult"
RequestEnterAchievementGroup"∫
ResponseEnterAchievementGroup
Result (RResultI
AchievementGroups (2.protocol.CAchievementGroupRAchievementGroups6
Finished (2.protocol.CAchievementDoneRFinished"O
RequestAchievementGroupDetail.
AchievementGroupId (RAchievementGroupId"§
ResponseAchievementGroupDetail
Result (RResult.
AchievementGroupId (RAchievementGroupId:
achievements (2.protocol.CAchievementRachievements"o
RequestAchievementAward.
AchievementGroupId (RAchievementGroupId$
AchievementId (RAchievementId"Å
ResponseAchievementAward
Result (RResult'
Awards (2.protocol.CItemRAwards$
AchievementId (RAchievementId"
RequestAchievementAwardAll"^
ResponseAchievementAwardAll
Result (RResult'
Awards (2.protocol.CItemRAwards"Z
NotifyUpdateAchievement?

notifyData (2.protocol.NotifyAchievementDataR
notifyData"s
NotifyAchievementData.
AchievementGroupId (RAchievementGroupId*
data (2.protocol.CAchievementRdata"5
RequestLoadPersonalCopy
Chapters (RChapters"V
PersonalCopyData
	ChapterId (R	ChapterId$
LastMissionId (RLastMissionId"b
ResponseLoadPersonalCopy
Result (RResult.
Data (2.protocol.PersonalCopyDataRData"¨
RequestPersonalCopyStartBattle
HeroId (RHeroId
	ChapterId (R	ChapterId
	MissionId (R	MissionId
TeamId (RTeamId

Conditions (R
Conditions"M
ResponsePersonalCopyStartBattle
Result (RResult
Seed (RSeed"Ô
RequestPersonalCopyEndBattle
HeroId (RHeroId
	ChapterId (R	ChapterId
	MissionId (R	MissionId)
IsWin (2.protocol.BattleResRIsWin
	BattleRec (R	BattleRec2
Detail (2.protocol.HeroBattleDetailRDetail"°
ResponsePersonalCopyEndBattle
Result (RResult)
IsWin (2.protocol.BattleResRIsWin
HeroId (RHeroId
	ChapterId (R	ChapterId
	MissionId (R	MissionId$
LastMissionId (RLastMissionId'
Awards (2.protocol.CItemRAwards
TotalExp (RTotalExp"
RequestEnergyInfo"¶
ResponseEnergyInfo
Result (RResult
Value (RValue
BuyTimes (RBuyTimes
BuyTime (RBuyTime,
StartRecoveryTime (RStartRecoveryTime"
RequestRecoveryEnergy"0
ResponseRecoveryEnergy
Result (RResult"X
NotifyEnergyChange
Value (RValue,
StartRecoveryTime (RStartRecoveryTime"
RequestBuyEnergy"a
ResponseBuyEnergy
Result (RResult
BuyTimes (RBuyTimes
BuyTime (RBuyTime"L
RequestChangeFashion
HeroId (RHeroId
	FashionId (R	FashionId"e
ResponseChangeFashion
Result (RResult
HeroId (RHeroId
	FashionId (R	FashionId"P
RequestChangeDormFashion
HeroId (RHeroId
	FashionId (R	FashionId"i
ResponseChangeDormFashion
Result (RResult
HeroId (RHeroId
	FashionId (R	FashionId"-
RequestAwakeUpgrade
HeroId (RHeroId".
ResponseAwakeUpgrade
Result (RResult"<
RequestGetWantedBattleInfo

ActivityId (R
ActivityId"á
ResponseGetWantedBattleInfo
Result (RResult
Level (RLevel
Exp (RExp
Rewarded (RRewardedO
Missions (23.protocol.ResponseGetWantedBattleInfo.MissionsEntryRMissions;
MissionsEntry
key (Rkey
value (Rvalue:8";
RequestWantedBattleReward

ActivityId (R
ActivityId"y
ResponseWantedBattleReward
Result (RResult'
Awards (2.protocol.CItemRAwards
Rewarded (RRewarded"»
RequestWantedBattleStart

ActivityId (R
ActivityId
WantedId (RWantedId
TeamId (RTeamId
Words (RWords

UseHormone (R
UseHormone"
HelpHeroFlag (RHelpHeroFlag"G
ResponseWantedBattleStart
Result (RResult
Seed (RSeed"è
RequestWantedBattleEnd

ActivityId (R
ActivityId
WantedId (RWantedId)
IsWin (2.protocol.BattleResRIsWin
TeamId (RTeamId
Words (RWords

UseHormone (R
UseHormone
	BattleRec (R	BattleRec"
HelpHeroFlag (RHelpHeroFlag"ú
ResponseWantedBattleEnd
Result (RResult)
IsWin (2.protocol.BattleResRIsWin
AddExp (RAddExp
Level (RLevel
Exp (RExp"
RequestTriggerRepresent"Z
ResponseTriggerRepresent
Result (RResult
Id (RId
HeroId (RHeroId"2
RequestGetRepresentAward
HeroId (RHeroId"\
ResponseGetRepresentAward
Result (RResult'
Awards (2.protocol.CItemRAwards"?
NotifyStudioRepresent
Id (RId
HeroId (RHeroId"p
RepresentFixedInfo
EventId (REventId
Time (RTime
Story (RStory
Reward (RReward"
RequestRepresentFixedLoad"j
ResponseRepresentFixedLoad
Result (RResult4
Events (2.protocol.RepresentFixedInfoREvents"8
RequestRepresentFixedTrigger
EventId (REventId"É
ResponseRepresentFixedTrigger
Result (RResult
EventId (REventId0
Data (2.protocol.RepresentFixedInfoRData"7
RequestRepresentFixedReward
EventId (REventId"y
ResponseRepresentFixedReward
Result (RResult
EventId (REventId'
Awards (2.protocol.CItemRAwards"G
RequestCompoundMakeItem
ItemId (RItemId
count (Rcount"å
ResponseCompoundMakeItem
Result (RResult%
Items (2.protocol.CItemRItems1
EffectItems (2.protocol.CItemREffectItems"i
RequestRefreshLoveValue
HeroId (RHeroId
	LoveValue (R	LoveValue
EventId (REventId"«
ResponseRefreshLoveValue
Result (RResult
HeroId (RHeroId&
TotalLoveValue (RTotalLoveValue
	Timestamp (R	Timestamp5
FlipCardAward (2.protocol.CItemRFlipCardAward"•
RequestLoveValueAward
Index (RIndex
Type (RType
HeroId (RHeroId
EventId (REventId
GroupId (RGroupId
StepId (RStepId"®
ResponseLoveValueAward
Result (RResult'
Awards (2.protocol.CItemRAwards
HeroId (RHeroId5
FlipCardAward (2.protocol.CItemRFlipCardAward"K
NotifyUnlockStory6
	HeroStory (2.protocol.CRoleHeroStoryR	HeroStory"
RequestGetShareReward"
ResponseGetShareReward
Result (RResult'
Awards (2.protocol.CItemRAwards$
GetRewardTime (RGetRewardTime"
RequestHelpTimesInfo"ù
HelpTimesData(
NormalHelpTimes (RNormalHelpTimes,
ResourceHelpTimes (RResourceHelpTimes.
EncounterHelpTimes (REncounterHelpTimes4
ActivityCopyHelpTimes (RActivityCopyHelpTimes(
WantedHelpTimes (RWantedHelpTimes$
LastResetTime (RLastResetTime"\
ResponseHelpTimesInfo
Result (RResult+
Data (2.protocol.HelpTimesDataRData"D
NotifyHelpTimesChange+
Data (2.protocol.HelpTimesDataRData"¸
PassInfo

ActivityId (R
ActivityId*
FreeRewardValue0 (RFreeRewardValue0*
FreeRewardValue1 (RFreeRewardValue1(
PayRewardValue0 (RPayRewardValue0(
PayRewardValue1 (RPayRewardValue1$
LastBuyShopId (RLastBuyShopId"
RequestEnterPass"S
ResponseEnterPass
Result (RResult&
Data (2.protocol.PassInfoRData">
NotifyPassInfoChange&
Data (2.protocol.PassInfoRData"
RequestBossBattleInfo"∏
ResponseBossBattleInfo
Result (RResult
Level (RLevel(
NextRefreshTick (RNextRefreshTick
Words (RWords0
Bosses (2.protocol.BossBattleBossRBosses"û
BossBattleBoss
	BossWarId (R	BossWarId
Heroes (RHeroes(
CommanderSkills (RCommanderSkills

StepPassed (R
StepPassed$
StepHpPercent (RStepHpPercent&
FirstChestMask (RFirstChestMask
	ChestMask (R	ChestMask 
BattleTimes (RBattleTimes"s
RequestBossBattleUpdateTeam
Type (RType
Heroes (RHeroes(
CommanderSkills (RCommanderSkills"6
ResponseBossBattleUpdateTeam
Result (RResult"L
RequestBossBattleStart
	BossWarId (R	BossWarId
Words (RWords"E
ResponseBossBattleStart
Result (RResult
Seed (RSeed"•
RequestBossBattleEnd)
IsWin (2.protocol.BattleResRIsWin
	BattleRec (R	BattleRec

StepPassed (R
StepPassed$
StepHpPercent (RStepHpPercent"Z
ResponseBossBattleEnd
Result (RResult)
IsWin (2.protocol.BattleResRIsWin"P
RequestBossBattleFirstChests
	BossWarId (R	BossWarId
Step (RStep"ö
ResponseBossBattleFirstChests
Result (RResult'
Awards (2.protocol.CItemRAwards8
Masks (2".protocol.BossBattleFirstChestMaskRMasks"L
BossBattleFirstChestMask
	BossWarId (R	BossWarId
Mask (RMask"K
RequestBossBattleChests
	BossWarId (R	BossWarId
Step (RStep"y
ResponseBossBattleChests
Result (RResult'
Awards (2.protocol.CItemRAwards
	ChestMask (R	ChestMask"?
RequestFlipCardActive
ActId (RActId
Idx (RIdx"X
ResponseFlipCardActive
Result (RResult
ActId (RActId
Idx (RIdx"Q
RequestFlipCardStoryTrigger
ActId (RActId
	EventType (R	EventType"Ñ
ResponseFlipCardStoryTrigger
Result (RResult
ActId (RActId
	EventType (R	EventType
EventId (REventId"2
RequestFlipCardStoryCommit
ActId (RActId"é
ResponseFlipCardStoryCommit
Result (RResult
ActId (RActId
EventId (REventId'
Awards (2.protocol.CItemRAwards"
RequestGetContact"r
ResponseGetContact
Result (RResult
User (	RUser
Phone (	RPhone
LastTick (RLastTick"=
RequestSetContact
User (	RUser
Phone (	RPhone",
ResponseSetContact
Result (RResult"Q
RequestHeroSkillUpgrade
HeroId (RHeroId

SkillLevel (R
SkillLevel"j
ResponseHeroSkillUpgrade
Result (RResult
HeroId (RHeroId

SkillLevel (R
SkillLevel"X
TurntableCardBuf
Points (RPoints
Times (RTimes
GetAll (RGetAll"6
RequestTurntableInfo

ActivityId (R
ActivityId"≥
ResponseTurntableInfo
Result (RResult2
Buffer (2.protocol.TurntableCardBufRBuffer
	positions (R	positions
Times (RTimes
Rewarded (RRewarded"~
RequestUseTurntableCard

ActivityId (R
ActivityId+
Card (2.protocol.TurntableCardRCard
Points (RPoints"2
ResponseUseTurntableCard
Result (RResult"U
RequestThrowTurntablePoints

ActivityId (R
ActivityId
Points (RPoints"_
ResponseThrowTurntablePoints
Result (RResult'
Awards (2.protocol.CItemRAwards"O
RequestTurntableRewards

ActivityId (R
ActivityId
Index (RIndex"w
ResponseTurntableRewards
Result (RResult'
Awards (2.protocol.CItemRAwards
Rewarded (RRewarded"O
FirstRechargeInfo
	Timestamp (R	Timestamp
	AwardMask (R	AwardMask"
RequestGrowGoldInfo"à
ResponseGrowGoldInfo
Result (RResult
PayId (RPayId
	AwardMask (R	AwardMask$
AwardMaskPaid (RAwardMaskPaid"9
RequestGrowGoldAwards
Id (RId
Tpe (RTpe"ù
ResponseGrowGoldAwards
Result (RResult'
Awards (2.protocol.CItemRAwards
	AwardMask (R	AwardMask$
AwardMaskPaid (RAwardMaskPaid",
NotifyActiveGrowGold
PayId (RPayId*C
	MailState

MS_NEW 
MS_OPEN

MS_EXTRACT
	MS_DELETE*#
	EnterType

Normal 

ReConn*5
MailOpt
MO_OPEN 

MO_EXTRACT
	MO_DELETE*√
ECurrencyType
ECT_None 
Coin
Exp
HeroExp
	HeroBreak
Gold

Source	
FCoin	
Heart

Ticket
DailyAP
WeeklyAP

SkillPoint
CommanderScope*n

StudioType
	Undefined 

Bridge
Produce	
Train
Communication
	Dormitory
Canteen*\

PlatformId
	DEVELOPER 
XiaoNiu

XiaoNiuIOS
HYKB

TapTapV
BilibiliW*)
	BattleRes
FAIL 
WIN	
DRAWˇ*3
Options
	DB_UPDATE 

DB_ADD
	DB_DELETE*)

CollectOpt
ColOPEN 

ColEXTRACT*∑

EGameModel
	ERoleInfo 
ERoleMission
	ERoleItem
	ERoleHero
	ERoleTeam
ERoleCycleEvent
	ERoleTask
ERoleActivity
ERoleChapter
ERoleCollect	
ERoleLottoRec

ERoleStudio
ERoleExtraBuff
ERoleHeroStory
ERoleGameMail
ERoleCdk
ERoleExpMission*<
EACTType
EACT_Common 

EACT_Daily
EACT_Weekly*˘
ECycleEvent
None 
ECET_MinË
ECET_OnlineTimeÈ
ECET_Guide_AwardÍ
ECET_Award_OnlineÎ
ECET_Award_SignÏ
ECET_Award_Sign7Ì
ECET_Award_SignAllÓ
ECET_Account_RecÔ
ECET_Shop_Refresh
ECET_Daily_EliteÒ
ECET_Daily_TaskÚ
ECET_Weekly_TaskÛ
ECET_Avatar_PettingÙ
ECET_Activity_Recordı
ECET_Novice_Guideˆ
ECET_Lotto_Free˜
ECET_Recharge_Record¯!
ECET_Recharge_ActivityRecord˘
ECET_Seven_Day_Target˙
ECET_Free_Express˚
ECET_Cost_Item_Express¸
ECET_Daily_Gift˝ 
ECET_Everyday_Feedback_Gift˛
ECET_AtmosphereCountˇ
ECET_Online_Act_ConfigÄ$
ECET_Limit_Time_Copy_Act_ConfigÅ%
 ECET_Seven_Day_Target_Act_ConfigÇ$
ECET_Seven_Day_Login_Act_ConfigÉ
ECET_Voting_Act_ConfigÑ$
ECET_Airship_Upgrade_Act_ConfigÖ
ECET_Exchange_Act_ConfigÜ
ECET_Seven_Day_Loginá
ECET_Hero_Special_Dailyà
ECET_Fast_Collectâ
ECET_Hero_Lotty_Dailyä
ECET_Item_Lotty_Dailyã
ECET_ROLE_MASKç*õ
	GmCmdType
CMD_None 
CMD_Add_ITEM
CMD_Recharge
CMD_Add_HERO_FAVOR
CMD_UnLockHeroAllStory
CMD_Recharge_MonthCard
CMD_Recharge_Shop_Buy
CMD_Recharge_Pass
CMD_Hero_Attribute
CMD_SetHeroBreakAndLeveld
CMD_SetHeroEatere
CMD_StudioRoomFullf
CMD_RechargeYKg
CMD_OpenStudioDormh
CMD_RandomPRDíN
CMD_ActiveFirstRechargeìN
CMD_ResetLottoCountîN*A
ItemType
E_Normal_Item 

E_Hero
E_FurnitureConvert*B

NoticeType
PrivateNotice 
PublicNotice
CycleNotice**
GameNoticeType
Refresh 
StopAll*:
TurntableCard
FixedPoints 
SlowDown

GetAllBZprotocol;protocolbproto3
√B
proto/friend.protofriendpb"◊
CacheAccountInfo
version (Rversion

account_id (R	accountId
nickname (	Rnickname
level (Rlevel
avatar (Ravatar
online (Ronline

logoutTime (R
logoutTime9
achievements (2.friendpb.AchievementRachievements*
achievementsShow	 (RachievementsShow
mission
 (Rmission"
missionElite (RmissionElite?
helpBattleHeroes (2.friendpb.HeroBriefRhelpBattleHeroes"
PlayerIconId (RPlayerIconId"+
BroadcastAccountInfos
data (Rdata"	
TestReq"

TestResp"@

FriendInfo
FriendId (RFriendId
Remark (	RRemark"
GetFriendshipsReq"g
GetFriendshipsResp'
code (2.friendpb.ErrorCodeRcode(
list (2.friendpb.FriendInfoRlist"É
AddFriendRequestReq
	friend_id (RfriendId#
friends_limit (RfriendsLimit*
add_friends_limit (RaddFriendsLimit"?
AddFriendRequestResp'
code (2.friendpb.ErrorCodeRcode"*
IsFriendReq
	friend_id (RfriendId"T
IsFriendResp'
code (2.friendpb.ErrorCodeRcode
	is_friend (RisFriend"2
DeleteFriendshipReq
	friend_id (RfriendId"?
DeleteFriendshipResp'
code (2.friendpb.ErrorCodeRcode"P
UpdateFriendshipRemarkReq
	friend_id (RfriendId
remark (	Rremark"E
UpdateFriendshipRemarkResp'
code (2.friendpb.ErrorCodeRcode"?
AgreeAllFriendRequestReq#
friends_limit (RfriendsLimit"c
AgreeAllFriendRequestResp'
code (2.friendpb.ErrorCodeRcode

friend_ids (R	friendIds"
RefuseAllFriendRequestReq"d
RefuseAllFriendRequestResp'
code (2.friendpb.ErrorCodeRcode

friend_ids (R	friendIds"P
GetFriendRequestFromReq
start_index (R
startIndex
count (Rcount"x
GetFriendRequestFromResp'
code (2.friendpb.ErrorCodeRcode
total (Rtotal

friend_ids (R	friendIds"]
AgreeFriendshipRequestReq
	friend_id (RfriendId#
friends_limit (RfriendsLimit"E
AgreeFriendshipRequestResp'
code (2.friendpb.ErrorCodeRcode"9
RefuseFriendshipRequestReq
	friend_id (RfriendId"F
RefuseFriendshipRequestResp'
code (2.friendpb.ErrorCodeRcode"T
FriendshipEstablishedNotify
	friend_id (RfriendId
friends (Rfriends"9
FriendshipTerminatedNotify
	friend_id (RfriendId"\
AddFriendRequestNotify
	friend_id (RfriendId%
total_pendings (RtotalPendings"8
NotifyAddFriendRequest

TotalCount (R
TotalCount"J
RequestFriendships

StartIndex (R
StartIndex
Count (RCount"m
ResponseFriendships
Result (RResult
Total (RTotal(
List (2.friendpb.FriendshipRList"/
RequestFriendship
FriendId (RFriendId"b
ResponseFriendship
Result (RResult4

Friendship (2.friendpb.FriendshipR
Friendship"»

Friendship
FriendId (RFriendId
Nickname (	RNickname
Avatar (RAvatar
Level (RLevel
Online (ROnline

LogoutTime (R
LogoutTime
Remark (	RRemark"
PlayerIconId (RPlayerIconId
	MissionId	 (R	MissionId
EliteId
 (REliteId/
HeroList (2.friendpb.HeroBriefRHeroList9
Achievements (2.friendpb.AchievementRAchievements<
AchievementsFinishedCount (RAchievementsFinishedCount"≈
	HeroBrief
HeroId (RHeroId
Level (RLevel

SkillLevel (R
SkillLevel
	CoreLevel (R	CoreLevel
AIWeapon (RAIWeapon
Favor (RFavor
Type (RType

AwakeLevel (R
AwakeLevel
Grade	 (RGrade
	GenesStar
 (R	GenesStar
Skin (RSkin

GenesStars (R
GenesStars"9
RequestAddFriendshipRequest
FriendId (RFriendId"6
ResponseAddFriendshipRequest
Result (RResult"T
RequestGetFriendshipRequests

StartIndex (R
StartIndex
Count (RCount"à
ResponseGetFriendshipRequests
Result (RResult
Total (RTotal9
Requests (2.friendpb.FriendshipApplicantRRequests"∑
FriendshipApplicant
FriendId (RFriendId
Nickname (	RNickname
Avatar (RAvatar
Level (RLevel
Online (ROnline"
PlayerIconId (RPlayerIconId";
RequestAgreeFriendshipRequest
FriendId (RFriendId"8
ResponseAgreeFriendshipRequest
Result (RResult"<
RequestRefuseFriendshipRequest
FriendId (RFriendId"9
ResponseRefuseFriendshipRequest
Result (RResult"2
RequestDelFriendship
FriendId (RFriendId"/
ResponseDelFriendship
Result (RResult"4
RequestSetHelpBattleHero
HeroIds (RHeroIds"3
ResponseSetHelpBattleHero
Result (RResult"!
RequestGetFriendshipSuggestions"U
 ResponseGetFriendshipSuggestions1
List (2.friendpb.FriendshipApplicantRList"/
RequestFindFriend
FriendId (RFriendId"c
ResponseFindFriend
Result (RResult5
friend (2.friendpb.FriendshipApplicantRfriend"i
RequestGetAllHelpBattleHeroes

StartIndex (R
StartIndex
Count (RCount
Type (RType"|
ResponseGetAllHelpBattleHeroes
Result (RResult
Total (RTotal,
Heroes (2.friendpb.FriendHeroRHeroes"K
RequestHelpBattleHero
FriendId (RFriendId
HeroId (RHeroId"Z
ResponseHelpBattleHero
Result (RResult(
Hero (2.friendpb.FriendHeroRHero"Í

FriendHero
FriendId (RFriendId
Nickname (	RNickname
HeroId (RHeroId
Level (RLevel

SkillLevel (R
SkillLevel
	CoreLevel (R	CoreLevel
AIWeapon (RAIWeapon
Favor (RFavor
Type	 (RType

AwakeLevel
 (R
AwakeLevel
Grade (RGrade
	GenesStar (R	GenesStar

GenesStars (R
GenesStars"
RequestGetFriendshipData"h
ResponseGetFriendshipData
Result (RResult3

HelpHeroes (2.friendpb.HeroBriefR
HelpHeroes"S
RequestUpdateFriendshipRemark
FriendId (RFriendId
Remark (	RRemark"8
ResponseUpdateFriendshipRemark
Result (RResult"#
!RequestAgreeAllFriendshipRequests"R
"ResponseAgreeAllFriendshipRequests
Result (RResult
Total (RTotal"$
"RequestRefuseAllFriendshipRequests"=
#ResponseRefuseAllFriendshipRequests
Result (RResult"7
RequestFriendAchievements
FriendId (RFriendId"â
ResponseFriendAchievements
Result (RResult9
Achievements (2.friendpb.AchievementRAchievements
ShowIds (RShowIds"Y
Achievement
Id (RId
Score (RScore$
FinishedCount (RFinishedCount"†
FriendHelpBattleHero
FriendId (RFriendId
HeroId (RHeroId
Level (RLevel
Grade (RGrade
Awake (RAwake
Skin (RSkin"
RequestFriendHelpBattleInfo"î
ResponseFriendHelpBattleInfo
Result (RResult6
Heroes (2.friendpb.FriendHelpBattleHeroRHeroesS
	Nicknames (25.friendpb.ResponseFriendHelpBattleInfo.NicknamesEntryR	NicknamesS
	IsFriends (25.friendpb.ResponseFriendHelpBattleInfo.IsFriendsEntryR	IsFriends<
NicknamesEntry
key (Rkey
value (	Rvalue:8<
IsFriendsEntry
key (Rkey
value (Rvalue:8"8
RequestRecommendFriendInfo
FriendId (RFriendId"Ÿ
ResponseRecommendFriendInfo
Result (RResult
FriendId (RFriendId
Nickname (	RNickname
Avatar (RAvatar
Level (RLevel
Online (ROnline

LogoutTime (R
LogoutTime
	MissionId (R	MissionId
EliteId	 (REliteId/
HeroList
 (2.friendpb.HeroBriefRHeroList9
Achievements (2.friendpb.AchievementRAchievements<
AchievementsFinishedCount (RAchievementsFinishedCount"
PlayerIconId (RPlayerIconId* 
	ErrorCode
Success 
Internal

ServerBusy
SystemError
InvalidData
FuncNotOpen
FriendAlreadyRequest–
FriendAlreadyExists—
FriendInBlack“
FriendIsFull”
TargetFriendFull‘
InTargetBlack’
TargetIsOffline÷
FriendRequestNotExists◊
WaitForSocialÿ
IsNotFriendŸ
AddSelfFriend⁄
FriendIsOffline€
FriendAlreadyGivePoints‹
FriendAlreadyDrawnPoints›
FriendNotGivePointsﬁ
FriendInvalidSlotﬂ
FriendHeroNotAtHelpSlot‡
FriendHelpTimesNotEnough·
FriendRemarkTooLong‚
FriendInvalidUID„
FriendFindNoResult‰ 
FriendAlreadyDrawnHelpBonusÂ
FriendAddRequestFullÊ
FriendRequestAlreadySendÁ
HeroNotExistsË
FriendInvalidHeroCountÈ
AccountNotExistsÍ
TargetFriendAddRequestFullÎ
FriendRemarkSensitiveÏ*Å
InfoType	
Level 

SkillLevel
	CoreLevel
AIWeapon	
Favor

AwakeLevel	
Grade
	GenesStar
SkinBZ
./friendpbbproto3