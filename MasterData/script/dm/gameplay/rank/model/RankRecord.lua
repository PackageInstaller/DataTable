-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/model/RankRecord.lua

BaseRankRecord = class("BaseRankRecord", objectlua.Object, _M)

BaseRankRecord:has("_player", {
	is = "rw"
})
BaseRankRecord:has("_rank", {
	is = "rw"
})
BaseRankRecord:has("_rankType", {
	is = "rw"
})
BaseRankRecord:has("_name", {
	is = "rw"
})
BaseRankRecord:has("_heroes", {
	is = "rw"
})
BaseRankRecord:has("_master", {
	is = "rw"
})
BaseRankRecord:has("_headId", {
	is = "rw"
})
BaseRankRecord:has("_headFrame", {
	is = "rw"
})
BaseRankRecord:has("_vipLevel", {
	is = "rw"
})
BaseRankRecord:has("_level", {
	is = "rw"
})
BaseRankRecord:has("_combat", {
	is = "rw"
})
BaseRankRecord:has("_slogan", {
	is = "rw"
})
BaseRankRecord:has("_nickName", {
	is = "r"
})
BaseRankRecord:has("_rid", {
	is = "r"
})
BaseRankRecord:has("_isFriend", {
	is = "rw"
})
BaseRankRecord:has("_online", {
	is = "r"
})
BaseRankRecord:has("_lastOfflineTime", {
	is = "r"
})
BaseRankRecord:has("_changeNum", {
	is = "r"
})
BaseRankRecord:has("_clubName", {
	is = "r"
})
BaseRankRecord:has("_familiarity", {
	is = "r"
})
BaseRankRecord:has("_new", {
	is = "r"
})
BaseRankRecord:has("_change", {
	is = "r"
})
BaseRankRecord:has("_retains", {
	is = "r"
})
BaseRankRecord:has("_gender", {
	is = "rw"
})
BaseRankRecord:has("_birthday", {
	is = "rw"
})
BaseRankRecord:has("_city", {
	is = "rw"
})
BaseRankRecord:has("_tags", {
	is = "rw"
})
BaseRankRecord:has("_block", {
	is = "rw"
})
BaseRankRecord:has("_leadStageId", {
	is = "rw"
})
BaseRankRecord:has("_leadStageLevel", {
	is = "rw"
})
BaseRankRecord:has("_totalStar", {
	is = "rw"
})
BaseRankRecord:has("_totalHeroes", {
	is = "rw"
})
BaseRankRecord:has("_totalSurface", {
	is = "rw"
})
BaseRankRecord:has("_maxStageLevel", {
	is = "rw"
})
BaseRankRecord:has("_showHeroes", {
	is = "rw"
})
BaseRankRecord:has("_rtkpRank", {
	is = "rw"
})
BaseRankRecord:has("_rtpkScore", {
	is = "rw"
})
BaseRankRecord:has("_stageArenaRank", {
	is = "rw"
})
BaseRankRecord:has("_stageArenaScore", {
	is = "rw"
})
BaseRankRecord:has("_title", {
	is = "rw"
})

function BaseRankRecord:initialize()
	super.initialize(self)

	self._player = nil
	self._rank = 0
	self._heroes = {}
	self._master = {}
	self._headId = 0
	self._vipLevel = 0
	self._combat = 0
	self._new = false
	self._change = 0
	self._retains = 0
	self._headFrame = ""
	self._board = "ZTXChang"
	self._surfaceId = nil
	self._totalStar = 0
	self._totalHeroes = 0
	self._totalSurface = 0
	self._maxStageLevel = 0
	self._showHeroes = {}
	self._rtkpRank = 0
	self._rtpkScore = 0
	self._stageArenaRank = 0
	self._stageArenaScore = 0
end

function BaseRankRecord:synchronize(data)
	if data then
		self._rank = data.rank
		self._vipLevel = data.vipLevel
		self._rid = data.rid
		self._name = data.nickname
		self._level = data.level
		self._headId = data.headImage
		self._headFrame = data.headFrame
		self._board = data.board
		self._surfaceId = data.surfaceId
		self._combat = data.combat
		self._slogan = Strings:get(data.slogan) or ""
		self._heroes = data.heroes
		self._master = data.master
		self._value = data.value
		self._nickName = data.nickname
		self._isFriend = data.isFriend
		self._online = data.online
		self._changeNum = data.change or 0
		self._new = data.new or false
		self._change = data.change or 0
		self._retains = data.retains or 0

		if data.offlineTime then
			self._lastOfflineTime = data.offlineTime
		elseif data.lastOfflineTime then
			self._lastOfflineTime = data.lastOfflineTime
		elseif data.lastOffTime then
			self._lastOfflineTime = data.lastOffTime
		end

		self._clubName = data.clubName
		self._familiarity = data.close
		self._gender = data.gender
		self._birthday = data.birthday
		self._city = data.city
		self._tags = data.tags
		self._block = data.block
		self._leadStageId = data.leadStageId or ""
		self._leadStageLevel = data.leadStageLevel or 0
		self._totalStar = data.totalStar or 0
		self._totalHeroes = data.totalHeroes or 0
		self._totalSurface = data.totalSurface or 0
		self._maxStageLevel = data.maxStageLevel or 0
		self._showHeroes = data.showHeroes or {}
		self._rtkpRank = data.rtkpRank or 0
		self._rtpkScore = data.rtpkScore or 0
		self._stageArenaRank = data.stageArenaRank or 0
		self._stageArenaScore = data.stageArenaScore or 0
		self._title = data.title or ""
	end
end

CombatRankRecord = class("CombatRankRecord", BaseRankRecord, _M)

CombatRankRecord:has("_maxCombat", {
	is = "r"
})

function CombatRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kCombat
end

function CombatRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._maxCombat = data.value or 0
end

BlockRankRecord = class("BlockRankRecord", BaseRankRecord, _M)

BlockRankRecord:has("_star", {
	is = "r"
})

function BlockRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kBlockStar
	self._star = 0
end

function BlockRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._star = data.value or 0
end

HeroRankRecord = class("HeroRankRecord", BaseRankRecord, _M)

HeroRankRecord:has("_heroCombat", {
	is = "r"
})
HeroRankRecord:has("_hero", {
	is = "r"
})

function HeroRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kHeroCombat
	self._hero = {}
	self._heroCombat = 0
end

function HeroRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._heroCombat = data.hCombat or 0
	self._hero = data.hero
end

PetRaceRankRecord = class("PetRaceRankRecord", BaseRankRecord, _M)

PetRaceRankRecord:has("_score", {
	is = "r"
})
PetRaceRankRecord:has("_winNum", {
	is = "r"
})

function PetRaceRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kPetRace
end

function PetRaceRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._score = data.score or 0
	self._winNum = data.winNum or 0
end

SubPetRaceRankRecord = class("SubPetRaceRankRecord", BaseRankRecord, _M)

SubPetRaceRankRecord:has("_score", {
	is = "r"
})
SubPetRaceRankRecord:has("_winNum", {
	is = "r"
})

function SubPetRaceRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kSubPetRace
end

function SubPetRaceRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._score = data.score or 0
	self._winNum = data.winNum or 0
end

PetWorldScoreRankRecord = class("PetWorldScoreRankRecord", BaseRankRecord, _M)

PetWorldScoreRankRecord:has("_score", {
	is = "r"
})
PetWorldScoreRankRecord:has("_winNum", {
	is = "r"
})

function PetWorldScoreRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.KPetWorldScore
end

function PetWorldScoreRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._score = data.value or 0
	self._winNum = data.winNum or 0
end

ClubRankRecord = class("ClubRankRecord", BaseRankRecord, _M)

ClubRankRecord:has("_clubName", {
	is = "r"
})
ClubRankRecord:has("_presidentName", {
	is = "r"
})
ClubRankRecord:has("_comatValue", {
	is = "r"
})
ClubRankRecord:has("_clubId", {
	is = "r"
})
ClubRankRecord:has("_clubLevel", {
	is = "r"
})
ClubRankRecord:has("_clubHeadImg", {
	is = "r"
})
ClubRankRecord:has("_playerMax", {
	is = "r"
})
ClubRankRecord:has("_playerCount", {
	is = "r"
})
ClubRankRecord:has("_announce", {
	is = "r"
})

function ClubRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kClub
end

function ClubRankRecord:synchronize(data)
	local clubData = {}

	clubData.rank = data.rank
	clubData.vipLevel = data.presidentVip
	clubData.rid = data.president
	clubData.nickname = data.presidentName
	clubData.level = data.presidentLevel
	clubData.headImage = data.presidentImg
	clubData.combat = data.presidentCombat
	clubData.slogan = Strings:get(data.presidentSlogan)
	clubData.heroes = data.presidentHeroes
	clubData.master = data.presidentMasterId
	clubData.online = data.online
	clubData.change = data.change
	clubData.clubName = data.clubName
	clubData.offlineTime = data.lastOfflineTime

	super.synchronize(self, clubData)

	self._clubName = data.clubName
	self._presidentName = data.presidentName
	self._comatValue = data.value
	self._clubId = data.clubId
	self._clubHeadImg = data.headImg
	self._playerMax = data.playerMax
	self._announce = data.announce
	self._playerCount = data.playerCount
	self._clubLevel = data.level
	self._isApply = data.isApply
end

ClubBossRankRecord = class("ClubBossRankRecord", BaseRankRecord, _M)

ClubBossRankRecord:has("_clubName", {
	is = "r"
})
ClubBossRankRecord:has("_presidentName", {
	is = "r"
})
ClubBossRankRecord:has("_comatValue", {
	is = "r"
})
ClubBossRankRecord:has("_clubId", {
	is = "r"
})
ClubBossRankRecord:has("_clubLevel", {
	is = "r"
})
ClubBossRankRecord:has("_clubHeadImg", {
	is = "r"
})
ClubBossRankRecord:has("_playerMax", {
	is = "r"
})
ClubBossRankRecord:has("_playerCount", {
	is = "r"
})
ClubBossRankRecord:has("_announce", {
	is = "r"
})

function ClubBossRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kClubBoss
end

function ClubBossRankRecord:synchronize(data)
	local clubData = {}

	clubData.rank = data.rank
	clubData.vipLevel = data.presidentVip
	clubData.rid = data.president
	clubData.nickname = data.presidentName
	clubData.level = data.presidentLevel
	clubData.headImage = data.presidentImg
	clubData.combat = data.presidentCombat
	clubData.slogan = Strings:get(data.presidentSlogan)
	clubData.heroes = data.presidentHeroes
	clubData.master = data.presidentMasterId
	clubData.online = data.online
	clubData.change = data.change
	clubData.clubName = data.clubName
	clubData.offlineTime = data.lastOfflineTime

	super.synchronize(self, clubData)

	self._clubName = data.clubName
	self._presidentName = data.presidentName
	self._comatValue = data.value
	self._clubId = data.clubId
	self._clubHeadImg = data.headImg
	self._playerMax = data.playerMax
	self._announce = data.announce
	self._playerCount = data.playerCount
	self._clubLevel = data.level
	self._isApply = data.isApply
end

SpGoldRankRecord = class("SpGoldRankRecord", BaseRankRecord, _M)

SpGoldRankRecord:has("_damage", {
	is = "r"
})

function SpGoldRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kGold
end

function SpGoldRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._damage = data.combat or 0
end

SpExpRankRecord = class("SpExpRankRecord", BaseRankRecord, _M)

SpExpRankRecord:has("_damage", {
	is = "r"
})

function SpExpRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kExp
end

function SpExpRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._damage = data.combat or 0
end

SpCrystalRankRecord = class("SpCrystalRankRecord", BaseRankRecord, _M)

SpCrystalRankRecord:has("_damage", {
	is = "r"
})

function SpCrystalRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kCrystal
end

function SpCrystalRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._damage = data.combat or 0
end

MapRankRecord = class("MapRankRecord", BaseRankRecord, _M)

MapRankRecord:has("_dp", {
	is = "r"
})

function MapRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kMap
	self._dp = 0
end

function MapRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._dp = data.value or 0
end

MazeRankRecord = class("MazeRankRecord", BaseRankRecord, _M)

MazeRankRecord:has("_chapterCount", {
	is = "r"
})

function MazeRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kMaze
	self._chapterCount = 0
end

function MazeRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._chapterCount = data.chapterCount or 0
end

ArenaRankRecord = class("ArenaRankRecord", BaseRankRecord, _M)

ArenaRankRecord:has("_score", {
	is = "r"
})

function ArenaRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kArena
	self._score = 0
end

function ArenaRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._score = data.value or 0
end

ArenaNewRankRecord = class("ArenaNewRankRecord", BaseRankRecord, _M)

ArenaNewRankRecord:has("_winCount", {
	is = "r"
})
ArenaNewRankRecord:has("_rank", {
	is = "r"
})
ArenaNewRankRecord:has("_headImg", {
	is = "r"
})

function ArenaNewRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.KNewAreana
	self._winCount = 0
end

function ArenaNewRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._winCount = data.winCount or 0
	self._rid = data.id
	self._headId = data.headImg
	self._headImg = data.headImg
	self._rank = data.rank
end

CrusadeRankRecord = class("CrusadeRankRecord", BaseRankRecord, _M)

CrusadeRankRecord:has("_point", {
	is = "r"
})

function CrusadeRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kCrusade
	self._point = 0
end

function CrusadeRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._point = data.value or 0
end

MiniGameRankRecord = class("MiniGameRankRecord", BaseRankRecord, _M)

MiniGameRankRecord:has("_score", {
	is = "r"
})

function MiniGameRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kDarts
	self._score = 0
end

function MiniGameRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._score = data.value or 0
end

MiniGameJumpRankRecord = class("MiniGameJumpRankRecord", BaseRankRecord, _M)

MiniGameJumpRankRecord:has("_score", {
	is = "r"
})

function MiniGameJumpRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kJump
	self._score = 0
end

function MiniGameJumpRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._score = data.value or 0
end

MiniGamePlaneRankRecord = class("MiniGamePlaneRankRecord", MiniGameJumpRankRecord, _M)

function MiniGamePlaneRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.KPlane
end

RTPKRankRecord = class("RTPKRankRecord", BaseRankRecord, _M)

RTPKRankRecord:has("_score", {
	is = "r"
})

function RTPKRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.KRTPK
	self._score = 0
end

function RTPKRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._rank = data.rank
	self._rid = data.r or data.rid
	self._headId = data.h or data.headImage
	self._name = data.n or data.nickname
	self._level = data.l or data.level
	self._headFrame = data.f or data.headFrame
	self._board = data.s or data.board
	self._combat = data.c or data.combat
	self._nickName = data.n or data.nickname
	self._score = data.p or data.value
end

StageAreanaRankRecord = class("StageAreanaRankRecord", BaseRankRecord, _M)

StageAreanaRankRecord:has("_oldCoin", {
	is = "r"
})

function StageAreanaRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.KStageAreana
end

function StageAreanaRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._rank = data.rank
	self._rid = data.r
	self._headId = data.h
	self._name = data.n
	self._level = data.l
	self._headFrame = data.f
	self._board = data.s
	self._combat = data.c
	self._nickName = data.n
	self._oldCoin = data.p
end

MazeTowerRankRecord = class("MazeTowerRankRecord", BaseRankRecord, _M)

MazeTowerRankRecord:has("_score", {
	is = "r"
})

function MazeTowerRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kMazeTower
	self._score = 0
end

function MazeTowerRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._score = data.value or 0
end

CollectionRankRecord = class("CollectionRankRecord", BaseRankRecord, _M)

CollectionRankRecord:has("_score", {
	is = "r"
})

function CollectionRankRecord:initialize()
	super.initialize(self)

	self._rankType = RankType.kCollection
	self._score = 0
end

function CollectionRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._score = data.value or 0
end

WorldBossRankRecord = class("WorldBossRankRecord", BaseRankRecord, _M)

WorldBossRankRecord:has("_hurtNum", {
	is = "r"
})

function WorldBossRankRecord:initialize()
	super.initialize(self)
end

function WorldBossRankRecord:synchronize(data)
	super.synchronize(self, data)

	self._hurtNum = data.value
end

WorldPeaceHurtRecord = class("WorldPeaceHurtRecord", BaseRankRecord, _M)

WorldPeaceHurtRecord:has("_level", {
	is = "r"
})
WorldPeaceHurtRecord:has("_nickName", {
	is = "r"
})
WorldPeaceHurtRecord:has("_headImage", {
	is = "r"
})
WorldPeaceHurtRecord:has("_headFrame", {
	is = "r"
})
WorldPeaceHurtRecord:has("_scores", {
	is = "r"
})

function WorldPeaceHurtRecord:initialize()
	super.initialize(self)

	self._scores = 0
end

function WorldPeaceHurtRecord:synchronize(data)
	super.synchronize(self, data)

	self._scores = data.score or 0
	self._level = data.level or 0
	self._nickName = data.nickName or 0
	self._headImage = data.headImage or 0
	self._headFrame = data.headFrame or 0
end

WorldPeaceScoreRecord = class("WorldPeaceScoreRecord", BaseRankRecord, _M)

WorldPeaceScoreRecord:has("_scores", {
	is = "r"
})
WorldPeaceScoreRecord:has("_level", {
	is = "r"
})
WorldPeaceScoreRecord:has("_nickName", {
	is = "r"
})
WorldPeaceScoreRecord:has("_headImage", {
	is = "r"
})
WorldPeaceScoreRecord:has("_headFrame", {
	is = "r"
})
WorldPeaceScoreRecord:has("_clubName", {
	is = "r"
})

function WorldPeaceScoreRecord:initialize()
	super.initialize(self)

	self._scores = 0
	self._clubName = ""
end

function WorldPeaceScoreRecord:synchronize(data)
	super.synchronize(self, data)

	self._scores = data.score or 0
	self._level = data.level or 0
	self._nickName = data.nickName or 0
	self._headImage = data.headImage or 0
	self._headFrame = data.headFrame or 0
	self._clubName = data.clubName or 0
end
