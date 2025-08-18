-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfo.lua

local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResMasterMisc = require("ClientData/ResMasterMisc")
local strClassName = "RoleInfo"
local OtherPlayer = require("Common/Object/OtherPlayer")
local Hero = require("Common/Object/Hero")
local Equip = require("Common/Object/Equip")
local Artifact = require("Common/Object/Artifact")
local Relic = require("Common/Object/Relic")
local RoleInfo = Class(strClassName)

function RoleInfo:ctor(role_comm, personal, power, vow, signet)
	self:refreshData(role_comm, personal, power, vow, signet)
end

local function sortHero(heroA, heroB)
	if heroA.star ~= heroB.star then
		return heroA.star > heroB.star
	elseif heroA.level ~= heroB.level then
		return heroA.level > heroB.level
	end

	return heroA.id < heroB.id
end

function RoleInfo:refreshData(role_comm, personal, power, vow, signet)
	self.uid = role_comm.uid
	self.refreshTime = os.time()

	local otherPlayer = CurAvatar.friendList[self.uid]

	if CurAvatar:isMyMaster(self.uid) then
		otherPlayer = CurAvatar.master
	elseif CurAvatar:isMyApprentice(self.uid) then
		otherPlayer = CurAvatar.apprenticeDic[self.uid]
	end

	otherPlayer = otherPlayer or OtherPlayer()

	otherPlayer:initDataByCommonData(role_comm)

	self.commInfo = otherPlayer

	if personal then
		self.heroInfo = personal
		self.guildName = personal.clanname
	end

	if power then
		self.powerList = power
	end

	self.vow = vow
	self.signet = signet

	self:_parseData(self.heroInfo)
end

function RoleInfo:getPowerByType(typeIndex)
	if self.powerList and self.powerList.power_item and self.powerList.power_item[typeIndex] then
		return self.powerList.power_item[typeIndex].power
	end

	return 0
end

function RoleInfo:_parseData(heroInfo)
	if heroInfo == nil then
		return
	end

	heroInfo = heroInfo or {}
	self.houseFavor = heroInfo.house_favor
	self.signature = heroInfo.signature or ""
	self.isEditHero = heroInfo.edit_hero ~= 0
	self.openId = heroInfo.openid or 0
	self.stage = self:_parseStage(heroInfo.stage)
	self.heros = {}
	self.power = heroInfo.power or 0

	for i, pHero in ipairs(heroInfo.phero or {}) do
		local hero = Hero(pHero.hero)

		if self.uid == CurAvatar.uid then
			hero = CurAvatar.heroDic[hero.gid] or hero
		else
			local equips = {}

			for j, e in ipairs(pHero.equip or {}) do
				if e.equip.gid ~= "0" then
					local _equip = Equip(e.equip)

					_equip.inWearing = hero.gid
					equips[_equip.subType] = _equip
				end
			end

			local artifact

			if pHero.artifact ~= nil and pHero.artifact.gid ~= "0" then
				artifact = Artifact(pHero.artifact)
				artifact.inWearing = hero.gid
			end

			if pHero.paint_level and pHero.paint_level > 0 then
				hero:setPaintData(utils.getPaintData(hero.id, pHero.paint_level, pHero.ability))
			end

			if pHero.develop then
				hero:setRelationPointData(pHero.develop.point)
			end

			local relic

			if pHero.relic and pHero.relic.id ~= 0 then
				relic = Relic(pHero.relic)
				relic.inWearing = hero.gid
			end

			hero:setEquips(equips, artifact, relic)

			local sData = {}

			sData.skin = {}
			sData.base = {}

			local data = pHero.skin

			if data and data.skin then
				sData.skin = ClientUtils.getBitsDictFromByteString(data.skin)
			end

			if data and data.base then
				sData.base = ClientUtils.getBitsDictFromByteString(data.base)
			end

			hero:setSkinData(sData)

			if Const.PAINT_PLUS_OPEN then
				local newPaintData = {}

				newPaintData.level = pHero.new_paint_level

				hero:setPaintPlusData(newPaintData)
			end

			hero.otherCrystalStep = pHero.crystal_step
			hero.otherCrystalType = pHero.crystal_type
		end

		table.insert(self.heros, hero)
	end

	if self.uid == CurAvatar.uid and self.isEditHero == false then
		table.sort(self.heros, sortHero)
	end

	self:setHeros(self.heros)
end

function RoleInfo:setHeros(heros)
	self.heros = heros
end

function RoleInfo:_parseStage(stage)
	if stage == nil then
		return 0
	end

	local s1, s2, s3

	s1 = stage % 100
	s2 = math.floor(stage / 100) % 100
	s3 = math.floor(stage / 10000)
	self.stateInfo = {
		s3,
		s2,
		s1
	}

	return ClientUtils.getMainStageLevelStr(s3, s2, s1)
end

function RoleInfo:isPassStage(limitId)
	if not self.stateInfo then
		return
	end

	local info = ResConditionLimit[limitId]

	if info and info.unlock_stage and self.stateInfo[1] >= info.unlock_stage[1] then
		if self.stateInfo[2] > info.unlock_stage[2] then
			return true
		elseif self.stateInfo[2] == info.unlock_stage[2] then
			return self.stateInfo[3] >= info.unlock_stage[3]
		end
	end
end

function RoleInfo:isConditionOk(limitId)
	local config = ResConditionLimit[limitId]

	if not config then
		return true
	end

	if config.unlock_stage then
		if not self.stateInfo then
			return false
		end

		if self.stateInfo[1] >= config.unlock_stage[1] then
			if self.stateInfo[2] > config.unlock_stage[2] then
				return true
			elseif self.stateInfo[2] == config.unlock_stage[2] then
				return self.stateInfo[3] >= config.unlock_stage[3]
			end
		end
	elseif config.unlock_crystal_level then
		local crystalLv = self.commInfo.crystalLv or 0

		return crystalLv and crystalLv >= config.unlock_crystal_level
	end

	return false
end

function RoleInfo:getGuildName(...)
	if CurAvatar and CurAvatar.uid == self.uid then
		if CurAvatar:isInCircle() then
			return CurAvatar:getCircleName()
		end
	else
		return self.guildName
	end
end

function RoleInfo:checkCanAddMaster()
	local conditionList = ResMasterMisc[1].add_master_condition

	if conditionList then
		for i = 1, #conditionList do
			if self:isConditionOk(conditionList[i]) then
				return false
			end
		end
	end

	return true
end

function RoleInfo:checkCanAddApprentice()
	local conditionList = ResMasterMisc[1].add_apprentice_condition

	if conditionList then
		for i = 1, #conditionList do
			if not self:isConditionOk(conditionList[i]) then
				return false
			end
		end
	end

	return true
end

return RoleInfo
