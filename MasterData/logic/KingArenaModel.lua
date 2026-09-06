-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/model/KingArenaModel.lua

module("logic.extensions.kingarena.model.KingArenaModel", package.seeall)

local KingArenaModel = class("KingArenaModel", BaseModel)

function KingArenaModel:ctor()
	return
end

function KingArenaModel:onInit()
	self:onReset()
end

function KingArenaModel:onReset()
	self._moPool = {}
	self._customFmtMo = nil
	self._formationCustomFmtMo = nil
	self._formationMoOfView = nil
end

function KingArenaModel:getKingArenaMo(seasonId)
	if self._moPool[seasonId] == nil then
		self._moPool[seasonId] = KingArenaMo.New(seasonId)
	end

	return self._moPool[seasonId]
end

function KingArenaModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = KingArenaFightCustomFmtMo.New()
	end

	return self._customFmtMo
end

function KingArenaModel:getFormationCustomFmtMo()
	if self._formationCustomFmtMo == nil then
		self._formationCustomFmtMo = KingArenaFormationCustomFmtMo.New()
	end

	return self._formationCustomFmtMo
end

function KingArenaModel:handlePM_KingArenaViewFormRes(msg)
	local petSimpleView = msg.playerView.petSimpleView
	local tempList = {}

	self._petMapOfView = self._petMapOfView or {}

	for k, v in pairs(self._petMapOfView) do
		table.insert(tempList, v)

		self._petMapOfView[k] = nil
	end

	for _, v in ipairs(petSimpleView) do
		local petMo = #tempList > 0 and BagPetMo.New() or BagPetMo.New()

		petMo:initBaseView(v)
		petMo.attrMo:resetPublicAttr()
		petMo.attrMo:calcTotalAttrs()
		petMo:refreshAllAttr()

		self._petMapOfView[v.petId] = petMo
	end

	local simpleForm = msg.playerView.curForm
	local formationMo = self:getFormationMoOfView()

	formationMo:SetData(simpleForm)

	local masterId = 0
	local summonId = 0

	for i, v in pairs(formationMo:GetPositions() or {}) do
		local petMo = formationMo:_getPet(v, true)

		if petMo and checknumber(petMo.summonMasterId) > 0 then
			summonId = petMo.petId
			masterId = checknumber(petMo.summonMasterId)
		end
	end

	if checknumber(formationMo.summonMasterPetId) <= 0 and checknumber(formationMo.summonedPetId) <= 0 and masterId > 0 and summonId > 0 then
		formationMo.summonMasterPetId = masterId
		formationMo.summonedPetId = summonId
	end

	local myUserId = checknumber(RoleModel.instance:getUserId())
	local playerId = checknumber(msg.playerId)

	if myUserId == playerId then
		self:setEmptyInMyFmt(formationMo:isEmpty())
	end
end

function KingArenaModel:getFormationMoOfView()
	if self._formationMoOfView == nil then
		self._formationMoOfView = FormationMO.New(GameUtil.handler(self._getPetMoByIdOfView, self))
	end

	return self._formationMoOfView
end

function KingArenaModel:_getPetMoByIdOfView(petId)
	if self._petMapOfView then
		return self._petMapOfView[petId]
	end
end

function KingArenaModel:isEmptyInMyFmt()
	return self._isEmptyInMyFmt
end

function KingArenaModel:setEmptyInMyFmt(value)
	self._isEmptyInMyFmt = value
end

KingArenaModel.instance = KingArenaModel.New()

return KingArenaModel
