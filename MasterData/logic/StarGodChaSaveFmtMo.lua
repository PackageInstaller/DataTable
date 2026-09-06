-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/model/StarGodChaSaveFmtMo.lua

module("logic.extensions.stargodchallenge.model.StarGodChaSaveFmtMo", package.seeall)

local StarGodChaSaveFmtMo = class("StarGodChaSaveFmtMo", ICustomFmtMo)

function StarGodChaSaveFmtMo:initParams()
	self.isShowBtnSave = true
end

function StarGodChaSaveFmtMo:initSaveHandler()
	printInfo("test StarGodChaSaveFmtMo:initSaveHandler")
	self:setSaveHandler(function()
		local simpleForm = self:getCurSimpleForm()

		StarGodChallengeAgent.instance:sendPM_StarGodChallengeSetFormReq(simpleForm)
	end, nil)
end

function StarGodChaSaveFmtMo:updateData()
	printInfo("test StarGodChaSaveFmtMo:updateData")

	self.isShowBtnFormation = false
	self.isShowTab = false

	self:_setFmtData()
end

function StarGodChaSaveFmtMo:initFormationMo()
	printInfo("test StarGodChaSaveFmtMo:initFormationMo")

	self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))

	self:_setFmtData()
end

function StarGodChaSaveFmtMo:_setFmtData()
	if self.formationMo then
		local simpleForm = StarGodChallengeModel.instance:getTeamForm()

		if simpleForm then
			self.formationMo:SetData(simpleForm)
		end
	end
end

function StarGodChaSaveFmtMo:getCurFormation()
	return self.formationMo
end

function StarGodChaSaveFmtMo:getMonsterConfigList()
	return {}
end

function StarGodChaSaveFmtMo:getFmtInfoConfig()
	return {}
end

function StarGodChaSaveFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function StarGodChaSaveFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return StarGodChaSaveFmtMo
