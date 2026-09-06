-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/mo/TRAttackFmtMo.lua

module("logic.extensions.treasureraider.model.mo.TRAttackFmtMo", package.seeall)

local TRAttackFmtMo = class("TRAttackFmtMo", ICustomFmtMo)

function TRAttackFmtMo:onReset()
	TRAttackFmtMo.super.onReset(self)
end

function TRAttackFmtMo:initParams(activityId, formationData)
	self._activityId = activityId

	self.formationMo:SetData(formationData)
end

function TRAttackFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function TRAttackFmtMo:getMonsterConfigList()
	return {}
end

function TRAttackFmtMo:getFmtInfoConfig()
	return {}
end

function TRAttackFmtMo:initFightHandler()
	return
end

function TRAttackFmtMo:initSaveHandler()
	return
end

function TRAttackFmtMo:sendSaveMsg()
	local formationMo = self:getCurFormation()
	local req = RichManExtension_pb.PM_RichManAttackSetFormReq()

	req.activityId = self._activityId

	CustomFmtController.instance:createFormPb(formationMo, req.form)
	TreasureRaiderController.instance:reqSetAttackFormation(req)
end

return TRAttackFmtMo
