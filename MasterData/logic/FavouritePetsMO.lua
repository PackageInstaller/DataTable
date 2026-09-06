-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/model/FavouritePetsMO.lua

module("logic.extensions.role.model.FavouritePetsMO", package.seeall)

local FavouritePetsMO = class("FavouritePetsMO")

function FavouritePetsMO:ctor()
	self.petId = -1
	self.raceId = -1
	self.level = -1
	self.zdl = -1
	self.petMo = nil
end

function FavouritePetsMO:setDataByForm(msg)
	self.petId = msg.petId
	self.raceId = -1
	self.level = msg.curLv
	self.awaken = msg.awakenLv

	local pet = BagPetMo.New()

	pet:initBaseView(msg)

	self.petMo = pet

	if pet then
		self.petId = -1
	end

	self.zdl = pet:getFightingPower()
end

function FavouritePetsMO:setPetid(pid)
	self.petId = pid
	self.raceId = -1
	self.level = -1
	self.zdl = -1
	self.awaken = -1
	self.petMo = nil
end

function FavouritePetsMO:getPetMo()
	if self.petId > 0 then
		return (BagModel.instance:getPet(self.petId))
	end

	if self.petMo then
		return self.petMo
	end

	return nil
end

function FavouritePetsMO:getRaceId()
	if self.raceId <= 0 then
		local mo = self:getPetMo()

		self.raceId = mo and mo.raceId or 0
	end

	return self.raceId
end

function FavouritePetsMO:getSkinId()
	local mo = self:getPetMo()

	if mo then
		return mo.curFaceId
	else
		return self.raceId
	end
end

function FavouritePetsMO:getLvl()
	if self.level <= 0 then
		self.level = self:getPetMo() and self:getPetMo().level or 0
	end

	return self.level
end

function FavouritePetsMO:getZdl()
	if self.zdl <= 0 then
		self.zdl = self:getPetMo() and self:getPetMo():getFightingPower() or 0
	end

	return self.zdl
end

function FavouritePetsMO:getAwaken()
	if self.awaken <= 0 then
		self.awaken = self:getPetMo() and self:getPetMo().awakeLevel or 0
	end

	return self.awaken
end

return FavouritePetsMO
