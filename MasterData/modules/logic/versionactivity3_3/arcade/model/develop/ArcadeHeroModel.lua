-- chunkname: @modules/logic/versionactivity3_3/arcade/model/develop/ArcadeHeroModel.lua

module("modules.logic.versionactivity3_3.arcade.model.develop.ArcadeHeroModel", package.seeall)

local ArcadeHeroModel = class("ArcadeHeroModel", BaseModel)

function ArcadeHeroModel:onInit()
	self:reInit()
end

function ArcadeHeroModel:reInit()
	self._selectHeroId = nil
	self._equipHeroId = nil
	self._heroMoList = nil
	self._talentMoList = nil
end

function ArcadeHeroModel:refreshInfo(player, talentInfo)
	self:_refreshPlayerInfo(player)
	self:_refreshTalentInfo(talentInfo)
end

function ArcadeHeroModel:_refreshPlayerInfo(player)
	local moList = self:getHeroMoList()

	self:setEquipHeroId(player.id)

	local selectId = self:getSelectHeroId()
	local equipId = self:getEquipHeroId()

	for _, heroMo in ipairs(moList) do
		heroMo:checkSelect(selectId)
		heroMo:checkEquip(equipId)

		local isLock = heroMo:isLock()
		local prefsKey, key = heroMo:getReddotKey()
		local isNew = ArcadeOutSizeModel.instance:getPlayerPrefsValue(prefsKey, key, 0, true) == 0

		heroMo:setNew(not isLock and isNew)
	end

	self:setCharacterPos(player.pos.x, player.pos.y)
end

function ArcadeHeroModel:_refreshTalentInfo(talentInfo)
	local list = {}

	if talentInfo.talents then
		for i = 1, #talentInfo.talents do
			local info = talentInfo.talents[i]

			list[info.id] = info
		end
	end

	for _, mo in ipairs(self:getTalentMoList()) do
		mo:refreshInfo(list[mo.id])
	end
end

function ArcadeHeroModel:getHeroMos()
	if not self._heroMoList then
		local moList = ArcadeHandBookModel.instance:getMoListByType(ArcadeEnum.HandBookType.Character)

		self._heroMoList = BaseModel.New()

		for _, mo in ipairs(moList) do
			local heroMo = ArcadeHeroMO.New(mo)

			self._heroMoList:addAtLast(heroMo)
		end
	end

	return self._heroMoList
end

function ArcadeHeroModel:getHeroMoList()
	return self:getHeroMos():getList()
end

function ArcadeHeroModel:setSelectHeroId(id)
	self._selectHeroId = id

	local moList = self:getHeroMoList()

	for _, mo in ipairs(moList) do
		mo:checkSelect(id)
	end
end

function ArcadeHeroModel:getSelectHeroId()
	return self._selectHeroId or self:getEquipHeroId()
end

function ArcadeHeroModel:setEquipHeroId(id)
	self._equipHeroId = id

	local moList = self:getHeroMoList()

	for _, mo in ipairs(moList) do
		mo:checkEquip(id)
	end
end

function ArcadeHeroModel:getEquipHeroId()
	return self._equipHeroId or self:getDefaultEquipHeroId()
end

function ArcadeHeroModel:getDefaultEquipHeroId()
	return ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.DefaultEquipedHero, true)
end

function ArcadeHeroModel:getHeroMoById(id)
	local moList = self:getHeroMos()

	return moList:getById(id)
end

function ArcadeHeroModel:getTalentMos()
	if not self._talentMoList then
		self._talentMoList = BaseModel.New()

		for i, coList in pairs(lua_arcade_talent.configDict) do
			local mo = ArcadeTalentMO.New(i, coList)

			self._talentMoList:addAtLast(mo)
		end
	end

	return self._talentMoList
end

function ArcadeHeroModel:getTalentMoList()
	return self:getTalentMos():getList()
end

function ArcadeHeroModel:setTalentLevel(id, level)
	local mos = self:getTalentMos()
	local mo = mos:getById(id)

	if mo then
		mo:setLevel(level)
	end
end

function ArcadeHeroModel:getReddotType()
	if self:hasReddotCharacter() then
		return ArcadeEnum.ReddotType.Normal
	end

	if self:hasReddotTalent() then
		return ArcadeEnum.ReddotType.Normal
	end
end

function ArcadeHeroModel:hasReddotCharacter()
	local list = self:getHeroMoList()

	for _, mo in ipairs(list) do
		if mo:isNew() then
			return true
		end
	end
end

function ArcadeHeroModel:hasReddotTalent()
	local list = self:getTalentMoList()

	for _, mo in ipairs(list) do
		if mo:canUpLV() then
			return true
		end
	end
end

function ArcadeHeroModel:_getInitHeroPos()
	self._initHeroPos = self._initHeroPos or ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.DefaultHallHeroPos, true, "#")

	return self._initHeroPos
end

function ArcadeHeroModel:getCharacterPos()
	local initPos = self:_getInitHeroPos()

	return self._characterPosX or initPos[1], self._characterPosY or initPos[2]
end

function ArcadeHeroModel:setCharacterPos(x, y)
	local mos = ArcadeHallModel.instance:getInteractiveMOs()

	for i, mo in pairs(mos) do
		if mo:isEnterRange(x, y) then
			return
		end
	end

	self._characterPosX, self._characterPosY = x, y
end

ArcadeHeroModel.instance = ArcadeHeroModel.New()

return ArcadeHeroModel
