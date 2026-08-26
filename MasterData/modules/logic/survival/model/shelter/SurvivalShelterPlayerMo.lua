-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterPlayerMo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterPlayerMo", package.seeall)

local SurvivalShelterPlayerMo = pureTable("SurvivalShelterPlayerMo")

function SurvivalShelterPlayerMo:init(shelterMapId, isNewWeek)
	self.shelterMapId = shelterMapId

	if isNewWeek then
		self:deleteLocalData()
	end

	self:initPos()
end

function SurvivalShelterPlayerMo:initPos()
	local key = self:getLocalkKey()
	local localPos = PlayerPrefsHelper.getString(key)

	if string.nilorempty(localPos) then
		localPos = SurvivalConfig.instance:getShelterPlayerInitPos(self.shelterMapId)

		local posList = string.splitToNumber(localPos, "#")

		self:setPos(posList[1], posList[2], posList[3])

		self.dir = SurvivalEnum.Dir.Right
	else
		local posList = string.splitToNumber(localPos, "#")

		self.dir = posList[4] or SurvivalEnum.Dir.Right

		self:setPos(posList[1], posList[2], posList[3])
	end
end

function SurvivalShelterPlayerMo:setPos(q, r, s)
	local pos = self:getPos()

	pos:set(q, r, s)
end

function SurvivalShelterPlayerMo:getPos()
	if self.pos == nil then
		self.pos = SurvivalHexNode.New()
	end

	return self.pos
end

function SurvivalShelterPlayerMo:setPosAndDir(pos, dir)
	local dirChange = dir and self.dir ~= dir
	local posChange = pos and self.pos ~= pos

	if posChange then
		self:setPos(pos.q, pos.r, pos.s)
	end

	if dirChange then
		self.dir = dir
	end

	if (posChange or dirChange) and not SurvivalMapHelper.instance:isInCollectionRoom() then
		self:savePosAndDir()
	end

	if posChange then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapPlayerPosChange)
	end
end

function SurvivalShelterPlayerMo:savePosAndDir()
	local key = self:getLocalkKey()

	PlayerPrefsHelper.setString(key, string.format("%s#%s#%s#%s", self.pos.q, self.pos.r, self.pos.s, self.dir))
end

function SurvivalShelterPlayerMo:getLocalkKey()
	return (string.format("%s_survival_shelter_playerpos_%s", PlayerModel.instance:getPlayinfo().userId, self.shelterMapId))
end

function SurvivalShelterPlayerMo:deleteLocalData()
	local key = self:getLocalkKey()

	PlayerPrefsHelper.deleteKey(key)
end

return SurvivalShelterPlayerMo
