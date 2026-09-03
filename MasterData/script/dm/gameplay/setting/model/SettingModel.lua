-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/model/SettingModel.lua

SettingModel = class("SettingModel", objectlua.Object, _M)

SettingModel:has("_isRecording", {
	is = "rw"
})
SettingModel:has("_recordBeginTime", {
	is = "rw"
})
SettingModel:has("_weatherData", {
	is = "rw"
})
SettingModel:has("_actFrameInfo", {
	is = "rw"
})

local kTouchEffectKey = "setting_Toucheffect"
local kBackGroundMusicKey = "setting_musicId"
local kHpShowKey = "setting_hpshow"
local kEffectShowKey = "setting_effectshow"

function SettingModel:initialize()
	super.initialize(self)

	self._isRecording = false
	self._recordBeginTime = 0
	self._weatherData = {}
	self._timeScale = {}
	self._autoBattle = {}
	self._isSaveMusic = true
	self._actFrameInfo = {}
end

function SettingModel:syncActFrameInfo(data)
	self._actFrameInfo = data
end

function SettingModel:isScreenRecordOn()
	return self._isRecording
end

function SettingModel:setScreenRecordOn(isOn)
	if isOn ~= nil then
		self._isRecording = isOn
	end
end

function SettingModel:isMusicOff()
	return (cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kMusicOffKey))
end

function SettingModel:setMusicOff(isOff)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kMusicOffKey, isOff)
end

function SettingModel:setMusicVolumeSave(volume)
	self._isSaveMusic = volume
end

function SettingModel:setMusicVolume(volume)
	if self._isSaveMusic then
		cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kMusicVolumeKey, tostring(volume))
	end

	AudioEngine:getInstance():setMusicVolume(volume)
end

function SettingModel:getMusicVolume()
	local volume = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kMusicVolumeKey)

	volume = volume == "" and 0.75 or tonumber(volume)

	return volume
end

function SettingModel:setEffectVolume(volume)
	if self._isSaveMusic then
		cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kEffectVolumeKey, tostring(volume))
	end

	AudioEngine:getInstance():setEffectsVolume(volume)
end

function SettingModel:getEffectVolume()
	local volume = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kEffectVolumeKey)

	volume = volume == "" and 0.5 or tonumber(volume)

	return volume
end

function SettingModel:setRoleEffectVolume(volume)
	cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kRoleEffectVolumeKey, tostring(volume))
	AudioEngine:getInstance():setCVEffectsVolume(volume)
end

function SettingModel:getRoleEffectVolume()
	local volume = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kRoleEffectVolumeKey)

	volume = volume == "" and 0.5 or tonumber(volume)

	return volume
end

function SettingModel:isSoundEffectOff()
	return (cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kEffectOffKey))
end

function SettingModel:setSoundEffectOff(isOff)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kEffectOffKey, isOff)
end

function SettingModel:isSoundRoleEffectOff()
	return (cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kRoleEffectOffKey))
end

function SettingModel:setRoleEffectOff(isOff)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kRoleEffectOffKey, isOff)
end

function SettingModel:isTouchEffectOff()
	return (cc.UserDefault:getInstance():getBoolForKey(kTouchEffectKey))
end

function SettingModel:setTouchEffectOff(isOff)
	cc.UserDefault:getInstance():setBoolForKey(kTouchEffectKey, isOff)
end

function SettingModel:isPowerSaveOn()
	return self._isPowerSave
end

function SettingModel:setPowerSaveOn(isOn)
	if isOn ~= nil then
		self._isPowerSave = isOn
	end
end

function SettingModel:getBGMusicId()
	return (cc.UserDefault:getInstance():getStringForKey(kBackGroundMusicKey))
end

function SettingModel:setBGMusicId(id)
	cc.UserDefault:getInstance():setStringForKey(kBackGroundMusicKey, id)
end

SettingBattleTypes = {
	kSpStage_equipment = "sp_stage_equipment",
	kSpStage_skill_1 = "sp_stage_skill_1",
	kSpStage_crystal = "sp_stage_crystal",
	kEliteStage = "elite_stage",
	kMaze = "maze_battle",
	kActstage = "actstage_battle",
	kSpStage_skill_3 = "sp_stage_skill_3",
	kCrusade = "crusade_battle",
	kStageArena = "stageArena_battle",
	kDreamStage = "dream_battle",
	kExplore = "explore_battle",
	kCooperateBoss = "copper_battle",
	kClubStage = "club_battle",
	kArenaNew = "arena_new_challenge",
	kNormalStage = "normal_stage",
	kMazeTower = "mazeTower_challenge",
	kPetRace = "hegemony_battle",
	kHeroStory = "herostory_battle",
	kTower = "tower_battle",
	kArena = "arena_challenge",
	kSpStage_skill_2 = "sp_stage_skill_2",
	kSpStage = "sp_stage",
	kPractice = "practice_battle",
	kSpStage_exp = "sp_stage_exp",
	kSpStage_gold = "sp_stage_gold"
}

local BattleSettingSpeedKeys = {
	[SettingBattleTypes.kNormalStage] = "normal_stage_setting_speed",
	[SettingBattleTypes.kEliteStage] = "elite_stage_setting_speed",
	[SettingBattleTypes.kArena] = "arena_challenge_setting_speed",
	[SettingBattleTypes.kTower] = "tower_challenge_setting_speed",
	[SettingBattleTypes.kMaze] = "maze_battle_setting_speed",
	[SettingBattleTypes.kSpStage] = "sp_stage_setting_speed",
	[SettingBattleTypes.kPractice] = "practice_battle_setting_speed",
	[SettingBattleTypes.kExplore] = "explore_battle_setting_speed",
	[SettingBattleTypes.kPetRace] = "hegemony_battle_setting_speed",
	[SettingBattleTypes.kHeroStory] = "herostory_battle_setting_speed",
	[SettingBattleTypes.kSpStage_gold] = "sp_stage_gold_battle_setting_speed",
	[SettingBattleTypes.kSpStage_exp] = "sp_stage_exp_battle_setting_speed",
	[SettingBattleTypes.kSpStage_crystal] = "sp_stage_crystal_battle_setting_speed",
	[SettingBattleTypes.kSpStage_equipment] = "sp_stage_equipment_setting_speed",
	[SettingBattleTypes.kSpStage_skill_1] = "sp_stage_skill_1_setting_speed",
	[SettingBattleTypes.kSpStage_skill_2] = "sp_stage_skill_2_setting_speed",
	[SettingBattleTypes.kSpStage_skill_3] = "sp_stage_skill_3_setting_speed",
	[SettingBattleTypes.kCrusade] = "crusade_challenge_setting_speed",
	[SettingBattleTypes.kActstage] = "actstage_battle_setting_speed",
	[SettingBattleTypes.kClubStage] = "clubstage_battle_setting_speed",
	[SettingBattleTypes.kDreamStage] = "dreamstage_battle_setting_speed",
	[SettingBattleTypes.kCooperateBoss] = "copper_battle_setting_speed",
	[SettingBattleTypes.kStageArena] = "stagearena_battle_setting_speed",
	[SettingBattleTypes.kArenaNew] = "arena_new_challenge_setting_speed",
	[SettingBattleTypes.kMazeTower] = "mazeTower_challenge_setting_speed"
}
local BattleSettingIsAutoKeys = {
	[SettingBattleTypes.kNormalStage] = "normal_stage_setting_auto",
	[SettingBattleTypes.kEliteStage] = "elite_stage_setting_auto",
	[SettingBattleTypes.kArena] = "arena_challenge_setting_auto",
	[SettingBattleTypes.kTower] = "tower_challenge_setting_auto",
	[SettingBattleTypes.kCrusade] = "crusade_challenge_setting_auto",
	[SettingBattleTypes.kMaze] = "maze_battle_setting_auto",
	[SettingBattleTypes.kSpStage] = "sp_stage_setting_auto",
	[SettingBattleTypes.kPractice] = "practice_battle_setting_auto",
	[SettingBattleTypes.kExplore] = "explore_battle_setting_auto",
	[SettingBattleTypes.kPetRace] = "hegemony_battle_setting_auto",
	[SettingBattleTypes.kHeroStory] = "herostory_battle_setting_auto",
	[SettingBattleTypes.kSpStage_gold] = "sp_stage_gold_battle_setting_auto",
	[SettingBattleTypes.kSpStage_exp] = "sp_stage_exp_battle_setting_auto",
	[SettingBattleTypes.kSpStage_crystal] = "sp_stage_crystal_battle_setting_auto",
	[SettingBattleTypes.kSpStage_equipment] = "sp_stage_equipment_setting_auto",
	[SettingBattleTypes.kSpStage_skill_1] = "sp_stage_skill_1_setting_auto",
	[SettingBattleTypes.kSpStage_skill_2] = "sp_stage_skill_2_setting_auto",
	[SettingBattleTypes.kSpStage_skill_3] = "sp_stage_skill_3_setting_auto",
	[SettingBattleTypes.kCrusade] = "crusade_challenge_setting_auto",
	[SettingBattleTypes.kActstage] = "actstage_battle_setting_auto",
	[SettingBattleTypes.kClubStage] = "clubstage_battle_setting_auto",
	[SettingBattleTypes.kDreamStage] = "dreamstage_battle_setting_auto",
	[SettingBattleTypes.kCooperateBoss] = "copper_battle_setting_auto",
	[SettingBattleTypes.kStageArena] = "stagearena_battle_setting_auto",
	[SettingBattleTypes.kArenaNew] = "arena_new_challenge_setting_auto",
	[SettingBattleTypes.kMazeTower] = "mazeTower_challenge_setting_auto"
}

function SettingModel:setHpShowSetting(hpshow)
	if hpshow then
		cc.UserDefault:getInstance():setIntegerForKey(kHpShowKey, hpshow)
	end
end

function SettingModel:getHpShowSetting()
	return cc.UserDefault:getInstance():getIntegerForKey(kHpShowKey, BattleHp_ShowType.Show)
end

function SettingModel:setEffectShowSetting(effectShow)
	if effectShow ~= nil then
		cc.UserDefault:getInstance():setIntegerForKey(kEffectShowKey, effectShow)
	end
end

function SettingModel:getEffectShowSetting()
	return cc.UserDefault:getInstance():getIntegerForKey(kEffectShowKey, BattleEffect_ShowType.All)
end

function SettingModel:getBattleSetting(battleType)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local speed = cc.UserDefault:getInstance():getStringForKey(BattleSettingSpeedKeys[battleType] .. "_" .. player:getRid())
	local isAuto = cc.UserDefault:getInstance():getBoolForKey(BattleSettingIsAutoKeys[battleType] .. "_" .. player:getRid())

	if isAuto == nil then
		isAuto = battleType == SettingBattleTypes.kArena
	end

	speed = speed and tonumber(speed)

	return isAuto, speed
end

function SettingModel:setBattleSetting(battleType, isAuto, speed)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local player = developSystem:getPlayer()

	if isAuto ~= nil then
		cc.UserDefault:getInstance():setBoolForKey(BattleSettingIsAutoKeys[battleType] .. "_" .. player:getRid(), isAuto)
	end

	if speed ~= nil then
		cc.UserDefault:getInstance():setStringForKey(BattleSettingSpeedKeys[battleType] .. "_" .. player:getRid(), speed)
	end
end

function SettingModel:setHeroShowed(heroBaseId)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local key = "heroShowed_" .. player:getRid() .. "_" .. heroBaseId

	cc.UserDefault:getInstance():setBoolForKey(key, true)
end

function SettingModel:getHeroShowed(heroBaseId)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local key = "heroShowed_" .. player:getRid() .. "_" .. heroBaseId

	return cc.UserDefault:getInstance():getBoolForKey(key, false)
end

function SettingModel:setRoleDynamic(isDynamic)
	cc.UserDefault:getInstance():setBoolForKey("roleDynamic", isDynamic)
end

function SettingModel:getRoleDynamic()
	return cc.UserDefault:getInstance():getBoolForKey("roleDynamic", true)
end

function SettingModel:getRoleAndBgRandom()
	local result = false
	local customDataSystem = DmGame:getInstance()._injector:getInstance(CustomDataSystem)
	local data = customDataSystem:getValue(PrefixType.kGlobal, "roleAndBgRandom", false)

	if data and data ~= "false" then
		result = true
	end

	result = result and CommonUtils.GetSwitch("fn_board_random")

	return result
end

function SettingModel:setRoleAndBgRandom(isRandom)
	local customDataSystem = DmGame:getInstance()._injector:getInstance(CustomDataSystem)

	customDataSystem:setValue(PrefixType.kGlobal, "roleAndBgRandom", isRandom)
end
