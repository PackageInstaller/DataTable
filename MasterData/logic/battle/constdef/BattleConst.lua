-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/constdef/BattleConst.lua

module("logic.battle.constdef.BattleConst", package.seeall)

local BattleConst = {}

BattleConst.KeyDefaultBackCount = "defaultBackCount"
BattleConst.DefaultStateKey = "default_state_key_of_battle"
BattleConst.StoryStateKey = "default_story_active_ui_of_battle"
BattleConst.DEFAULT_CAMP_ID = 0
BattleConst.MIN_SANITY = -1
BattleConst.MAX_SANITY = 1
BattleConst.START_CAMERA_CODE = 7
BattleConst.ATTACK_CAMERA_CODE = 2
BattleConst.ATTACK_RIGHT_CAMERA_CODE = 12
BattleConst.BattleCalcuate = "BattleCalcuate"
BattleConst.CameraRotationTime = 0.3
BattleConst.ChaseTagName = "Chase"
BattleConst.DelayOne = 1
BattleConst.DelayTwo = 2
BattleConst.DelayThree = 3
BattleConst.DelayFive = 5
BattleConst.DelayZeroPointOne = 0.1
BattleConst.DelayZeroPointTwo = 0.2
BattleConst.DelayZeroPointFive = 0.5
BattleConst.DelayOnePointFive = 1.5
BattleConst.DeadDuration = 1.5
BattleConst.WeakPointBrokenSkillCode = -1
BattleConst.WeakPointResumedSkillCode = -2
BattleConst.HitHalfTime = 0.27
BattleConst.ObjPoolCapacityMin = 10
BattleConst.ObjPoolCapacityMid = 60
BattleConst.ObjPoolCapacityMax = 100
BattleConst.ObjPoolCapacityMaxx = 300
BattleConst.ObjPoolCapacityDefault = BattleConst.ObjPoolCapacityMin
BattleConst.PrepareRatioMin = 0.1
BattleConst.PrepareRatioHalf = 0
BattleConst.PrepareRatioMax = 1
BattleConst.PrepareRatioDefault = BattleConst.PrepareRatioHalf
BattleConst.ConfigKeyCriticalRatio = "criticalRatio"
BattleConst.ConfigKeyNearRatio = "nearRatio"
BattleConst.ConfigKeyNotCriticalInspiration = "notCriticalInspiration"
BattleConst.SystemOpenKey = "systemOpen"
BattleConst.Chase = "Chase"
BattleConst.UIBloodBarForecastAddColor = "#52FF00"
BattleConst.UIBloodBarForecastDecColor = "#FF5C66"
BattleConst.MonsterEscapeArea = 1004
BattleConst.SelfEscapeArea = 1005

local kOffsetPrecision = 0.001
local kCurrentOffset = 0

local function genNextOffset()
	kCurrentOffset = kCurrentOffset + kOffsetPrecision

	return kCurrentOffset
end

BattleConst.YOffsetBoard = genNextOffset()
BattleConst.YOffsetDangerArea = genNextOffset()
BattleConst.YOffsetPathArrow = genNextOffset()
BattleConst.YOffsetBornArea = genNextOffset()
BattleConst.YOffsetAvatar = genNextOffset()
BattleConst.YOffsetSign = genNextOffset()
BattleConst.YOffsetUnitShadow = genNextOffset()
BattleConst.WEAK_POINT_BROKEN = 10007
BattleConst.WEAK_POINT_RESUME = 10008
BattleConst.WEAK_POINT_RESUME_BOSS = 10009
BattleConst.EFFECT_DEATH_MONSTERS = {
	10011,
	10012,
	10013
}
BattleConst.EFFECT_DEATH_ROLE = 10014
BattleConst.ADD_BUFF = 10018
BattleConst.ADD_DEBUFF = 10019
BattleConst.CURE = 10020
BattleConst.DAMAGE = 10021
BattleConst.PLACE_ENTITY = 10022
BattleConst.PLACE_ENTITY2x2 = 10048
BattleConst.PLACE_ENTITY2 = 10026
BattleConst.SANITY_ADD = 10029
BattleConst.SANITY_SUB = 10030
BattleConst.LOW_SANITY = 10039
BattleConst.LAZZY_OR_SLEEP = 10040
BattleConst.TERRAIN_DAMAGE = 10040
BattleConst.EFFECT_CREATE_FORECAST_UNIT = 10049
BattleConst.ELITE_ENEMY_EFFECT = 10050
BattleConst.SANITY_BURN_EFFECT = 10051
BattleConst.SANITY_BURN_LOOP_EFFECT = 10052
BattleConst.SANITY_STRENGTHEN_REALEASE_EFFECT = 10053
BattleConst.BOSS_COVERED_BURN_EFFECT = 10055
BattleConst.SANITY_BROKEN = 10059
BattleConst.SANITY_BROKEN_LOOP = 10060
BattleConst.HighlandHeight = 0.8
BattleConst.SPECIAL_MODELID_AILISI = 100002

function BattleConst.clampSanity(sanity)
	return math.min(math.max(sanity, BattleConst.MIN_SANITY), BattleConst.MAX_SANITY)
end

function BattleConst.judgeCameraFocusTime(tox, toy, toz)
	local p = VirtualCameraMgr.instance:getFollowPosition()
	local distance = BattleMathUtil.distance(p.x, p.z, tox, toz)

	if distance < 0.01 then
		return 0.01
	end

	return distance > 5 and 0.8 or 0.4
end

return BattleConst
