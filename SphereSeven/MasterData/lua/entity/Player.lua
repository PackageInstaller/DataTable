--[[
-- added by wsh @ 2017-12-05
-- 玩家实体
--]]
---@class Player : Entity
local Player = BaseClass("Player",Entity)
local base = Entity

---@param self Player
local function Awake(self,playerInfo)
	base.Awake(self)


	self.AchievementFinishCount = 0
	self.totalRecruitTimes = 0
	self.collection = {
		characterCollection = 0,
		fightSoulCollection = 0,
		equipmentCollection = 0,
		enemyCollection = 0,
	}
	self.SocietyShowGirl = {}
	self.first_character_selected = 0

	self:RefreshInfo(playerInfo)
end

---@param self Player
---@param playerInfo protocol.RoleInfoResp
local function RefreshInfo(self,playerInfo)
	self.Id = playerInfo.uid
	self.AccountId = playerInfo.uid
	self.Nickname = playerInfo.username
	self.Avatar = ""
	if Z_HeadPortrait[playerInfo.using_head_portrait] ~= nil then
		self.Avatar = playerInfo.using_head_portrait--Z_HeadPortrait[playerInfo.using_head_portrait].Resourse
	end
	
	self.Level = playerInfo.level
	--经验
	self.Exp = playerInfo.exp
	--主界面角色id
	self.MainUICardId = playerInfo.show_girl.character_id
	self.MainWife = 0

	self.ShowGirlInfo = playerInfo.show_girl

	if playerInfo.society_show_girl ~= nil then
		self.SocietyShowGirl = playerInfo.society_show_girl
	end
	self.headPortraits = playerInfo.head_portraits

	--寝宫角色id
	self.BedroomCardId = playerInfo.house.character_id
	--上次使用休息的时间戳
	self.LastRoomRestTime = playerInfo.house.last_rest_time
	--上次使用侍寝的时间戳
	self.LastRoomMalTime = playerInfo.house.last_sleep_time
	self.IsAllowFreeCallCard = playerInfo.IsAllowFreeCallCard -- ?
	--角色上限
	self.CardMax = 99999--playerInfo.CardMax
	--装备上限
	self.EquipMax = 99999--playerInfo.EquipMax 
	--装备上限
	self.FightSoulsMax = 99999 --playerInfo.FightSoulMax
	--不限体力时间
	self.UnlimitedEnergyTime = 0 --playerInfo.UnlimitedEnergyTime -- ?
	--梅花圣杖
	self.AddHaftPrTime = 0 --道具
	--最后登录时间戳
	self.LastLoginTime=playerInfo.LastLoginTime
	--创建角色时间戳
	self.RegisterTime=playerInfo.register_time
	--邮件总数量
	self.MailNum= 2 --?
	--在线总时长
	self.OnLineTime=playerInfo.total_online_duration
	--可讨次数
	self.LevelStartCount = playerInfo.battle_info.level_start_times -- 战斗次数
	self.KillCount = playerInfo.battle_info.enemy_slaved_count -- 杀敌数量
	self.MostUsedCharacters = playerInfo.battle_info.most_used_characters -- 常用角色

	-- 任务
	if playerInfo.task_info ~= nil then
		self.AchievementFinishCount = playerInfo.task_info.achievement_finish_count or self.AchievementFinishCount
	end

	-- 抽卡
	if playerInfo.recruit_info ~= nil then
		self.totalRecruitTimes = playerInfo.recruit_info.total_recruit_times or self.totalRecruitTimes
	end

	-- 收集
	if playerInfo.collection ~= nil then
		self.collection.characterCollection = playerInfo.collection.character_collection or self.collection.characterCollection
		self.collection.fightSoulCollection = playerInfo.collection.fight_soul_collection or self.collection.fightSoulCollection
		self.collection.equipmentCollection = playerInfo.collection.equipment_collection or self.collection.equipmentCollection
		self.collection.enemyCollection = playerInfo.collection.enemy_collection or self.collection.enemyCollection
	end

	if playerInfo.support_units ~= nil and playerInfo.support_units[1] ~= nil then
		self.supportCardId = playerInfo.support_units[1].character_id
		self.supportFightSoulId = playerInfo.support_units[1].fight_soul_id
	end

	if playerInfo.first_character_selected ~= 0 then
		self.first_character_selected = playerInfo.first_character_selected
	end

	--设置成援助的卡
	self.AidId = 0 --?

	--签到次数
	self.SigninNum= 2 --?

	--签到次数
	self.SigninNum= 2 --?

	-- 当天是否能签到  0可以 1已签
	self.SigninToday = 1 --?

	self.Captain =  0 --服务端没有此信息  用争霸的段位信息 --?
	--新玩家领取
	self.NewNum = 1 --玩家在线天数 --?
	self.NewToday = 2 --?
	self.OnLineDay = 2 --?
	----------------------------------------------------
	self.EnergyNextTime = playerInfo.last_power_recover_time

	-- 权限等级
	self.AuthLevel = -1 --?

	-- 无限回廊回合
	self.EchoChromeTurnNum = 10 --?
end

---@param msg protocol.RoleInfoUpdatePush
function Player:UpdateData(msg)
	if msg.exp ~= 0 then
		self.Exp = msg.exp
	end

	if msg.level ~= 0 then
		self.Level = msg.level
	end

	if msg.total_online_duration ~= 0 then
		self.OnLineTime = msg.total_online_duration
	end

	if msg.last_power_recover_time ~= 0 then
		self.EnergyNextTime = msg.last_power_recover_time
	end

	if  msg.show_girl ~= nil then
		self.ShowGirlInfo = msg.show_girl
	end

	if msg.society_show_girl ~= nil then
		self.SocietyShowGirl = msg.society_show_girl
	end

	if msg.house ~= nil then
		--寝宫角色id
		self.BedroomCardId = msg.house.character_id
		--上次使用休息的时间戳
		self.LastRoomRestTime = msg.house.last_rest_time
		--上次使用侍寝的时间戳
		self.LastRoomMalTime = msg.house.last_sleep_time
	end

	if msg.battle_info ~= nil then
		self.LevelStartCount = msg.battle_info.level_start_times -- 战斗次数
		self.KillCount = msg.battle_info.enemy_slaved_count -- 杀敌数量
		self.MostUsedCharacters = msg.battle_info.most_used_characters -- 常用角色
	end

	-- 任务
	if msg.task_info ~= nil then
		self.AchievementFinishCount = msg.task_info.achievement_finish_count or 0
	end

	-- 抽卡
	if msg.recruit_info ~= nil then
		self.totalRecruitTimes = msg.recruit_info.total_recruit_times
	end

	-- 收集
	if msg.collection ~= nil then
		self.collection.characterCollection = msg.collection.character_collection
		self.collection.fightSoulCollection = msg.collection.fight_soul_collection
		self.collection.equipmentCollection = msg.collection.equipment_collection
		self.collection.enemyCollection = msg.collection.enemy_collection
	end

	if msg.support_units ~= nil and msg.support_units[1] ~= nil then
		self.supportCardId = msg.support_units[1].character_id
		self.supportFightSoulId = msg.support_units[1].fight_soul_id
	end
end

function Player:ChangeName(name)
	if name == nil or name == "" then return end
	self.Nickname = name
end

local function Dispose(self)
	base.Dispose(self)
end

Player.Awake = Awake
Player.Dispose = Dispose
Player.RefreshInfo = RefreshInfo
return Player