-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswCompleteTierFmtInfoMo.lua

module("logic.extensions.godstatueswar.data.GswCompleteTierFmtInfoMo", package.seeall)

local GswCompleteTierFmtInfoMo = class("GswCompleteTierFmtInfoMo")

function GswCompleteTierFmtInfoMo:ctor()
	self._onlyId = nil
	self._playerId = nil
	self._formId = 0
	self._zdl = 0
	self._speed = 0
	self._maxHp = 0
	self._curHp = 0
	self._simpleForm = nil
	self._petSimpleView = nil
	self._carriedPetView = nil
	self._posList = {}
	self._petMoPool = {}
end

function GswCompleteTierFmtInfoMo:onReset()
	self._onlyId = nil
	self._playerId = nil
	self._formId = 0
	self._zdl = 0
	self._speed = 0
	self._maxHp = 0
	self._curHp = 0
	self._simpleForm = nil
	self._petSimpleView = nil
	self._carriedPetView = nil

	table.clear(self._posList)
	table.clear(self._petMoPool)
end

function GswCompleteTierFmtInfoMo:initData(info)
	self:onReset()

	self._onlyId = GodStatuesWarController.instance:getOnlyIdByFmtInfoMo(info.playerId, info.formId)
	self._playerId = info.playerId
	self._formId = info.formId
	self._zdl = info.zdl
	self._speed = info.speed
	self._maxHp = info.maxHp
	self._curHp = info.curHp
	self._simpleForm = info.otherPlayerView.curForm
	self._petSimpleView = info.otherPlayerView.petSimpleView
	self._carriedPetView = info.otherPlayerView.carriedPetView

	for posId = 1, 9 do
		self._posList[posId] = self._simpleForm.pos[posId]
	end

	for _, v in ipairs(self._petSimpleView) do
		local mo = BagPetMo.New()

		mo:initBaseView(v)

		self._petMoPool[mo:getPetId()] = mo
	end
end

function GswCompleteTierFmtInfoMo:getOnlyId()
	return self._onlyId
end

function GswCompleteTierFmtInfoMo:getPlayerId()
	return self._playerId
end

function GswCompleteTierFmtInfoMo:getFormId()
	return self._formId
end

function GswCompleteTierFmtInfoMo:getZdl()
	return self._zdl
end

function GswCompleteTierFmtInfoMo:getSpeed()
	return self._speed
end

function GswCompleteTierFmtInfoMo:getPosList()
	return self._posList
end

function GswCompleteTierFmtInfoMo:getPetIdByPos(posId)
	return self._posList[posId]
end

function GswCompleteTierFmtInfoMo:getPetMoByPos(posId)
	local petId = self:getPetIdByPos(posId)

	return self:getPetMo(petId)
end

function GswCompleteTierFmtInfoMo:getPetMo(petId)
	return self._petMoPool[petId]
end

function GswCompleteTierFmtInfoMo:getSimpleForm()
	return self._simpleForm
end

function GswCompleteTierFmtInfoMo:getPetSimpleView()
	return self._petSimpleView
end

function GswCompleteTierFmtInfoMo:getCarriedPetView()
	return self._carriedPetView
end

function GswCompleteTierFmtInfoMo:getMaxHp()
	return self._maxHp
end

function GswCompleteTierFmtInfoMo:getCurHp()
	return self._curHp
end

return GswCompleteTierFmtInfoMo
