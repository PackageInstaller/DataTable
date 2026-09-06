-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/mo/TRDefendFmtMo.lua

module("logic.extensions.treasureraider.model.mo.TRDefendFmtMo", package.seeall)

local TRDefendFmtMo = class("TRDefendFmtMo", ICustomFmtMo)

function TRDefendFmtMo:onReset()
	TRDefendFmtMo.super.onReset(self)
end

function TRDefendFmtMo:initParams(activityId, buildingId, lockPetMap, formationData)
	self._activityId = activityId
	self._buildingId = buildingId
	self._lockPetMap = lockPetMap

	self.formationMo:SetData(formationData)
end

function TRDefendFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function TRDefendFmtMo:getMonsterConfigList()
	return {}
end

function TRDefendFmtMo:getFmtInfoConfig()
	return {}
end

function TRDefendFmtMo:initFightHandler()
	return
end

function TRDefendFmtMo:initSaveHandler()
	return
end

function TRDefendFmtMo:updateCellTop(cell, petMo)
	local luaCls = TreasureraidepeticonView
	local url = TreasureraidepeticonView.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:setTire(self._lockPetMap[petMo.petId])
	end
end

function TRDefendFmtMo:checkPetIsForbit(petMo)
	return self._lockPetMap[petMo.petId]
end

function TRDefendFmtMo:clearCellTop(cell)
	MaterialMgr.resetAll(cell)
end

function TRDefendFmtMo:sendSaveMsg()
	local formationMo = self:getCurFormation()
	local req = RichManExtension_pb.PM_RichManDefendSetFormReq()

	req.activityId = self._activityId
	req.buildConfigId = self._buildingId

	CustomFmtController.instance:createFormPb(formationMo, req.form)
	TreasureRaiderController.instance:reqSetDefendFormation(req)
end

return TRDefendFmtMo
