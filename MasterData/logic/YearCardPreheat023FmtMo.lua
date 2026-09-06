-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/model/YearCardPreheat023FmtMo.lua

module("logic.extensions.yearcardpreheat2023.model.YearCardPreheat023FmtMo", package.seeall)

local YearCardPreheat023FmtMo = class("YearCardPreheat023FmtMo", ICustomFmtMo)

function YearCardPreheat023FmtMo:initParams(creespId)
	self._masterList = YearCardPreheat2023Config.instance:getMostersCfgById(creespId)
	self._creepsCfg = YearCardPreheat2023Config.instance:getFormationCfgById(creespId)
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.WinDesc
end

function YearCardPreheat023FmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.YearCardPreheat2023GameView, true)

		local actId = YearCardPreheat2023Model.instance:getActId()
		local posX, posY = YearCardPreheat2023Model.instance:getPos()

		YearCardPreheat2023Controller.instance:dealEvent(actId, posX, posY)
	end

	self:setFightHandler(handler, nil)
end

function YearCardPreheat023FmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function YearCardPreheat023FmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function YearCardPreheat023FmtMo:getMonsterConfigList()
	return self._masterList
end

function YearCardPreheat023FmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

function YearCardPreheat023FmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

return YearCardPreheat023FmtMo
