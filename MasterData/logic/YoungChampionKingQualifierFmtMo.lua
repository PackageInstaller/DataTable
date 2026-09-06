-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/model/YoungChampionKingQualifierFmtMo.lua

module("logic.extensions.youngchampionking.model.YoungChampionKingQualifierFmtMo", package.seeall)

local YoungChampionKingQualifierFmtMo = class("YoungChampionKingQualifierFmtMo", ICustomFmtMo)

function YoungChampionKingQualifierFmtMo:initParams(stepId)
	self.activityId = YoungChampionKingModel.instance:getCurActId()
	self.curStepId = stepId
	self.topTitleStr = YoungChampionKingController.instance:getCurRoundNameByStepId(self.curStepId)

	local qualifyInfo = YoungChampionKingModel.instance:getQualifierInfo(self.activityId, self.curStepId)

	self.curOpponent = qualifyInfo and qualifyInfo.opponent

	self:clearAllPetList()
end

function YoungChampionKingQualifierFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function YoungChampionKingQualifierFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function YoungChampionKingQualifierFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function YoungChampionKingQualifierFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self:checkCanFight() then
			YoungChampionKingController.instance:sendPM_YCKQualifierFightReq(self.activityId, self.curStepId, self:getCurSimpleForm())
		end
	end, nil)
end

function YoungChampionKingQualifierFmtMo:getMonsterConfigList()
	return {}
end

function YoungChampionKingQualifierFmtMo:getFmtInfoConfig()
	return self.curOpponent.forms.view.curForm.extParams
end

function YoungChampionKingQualifierFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if self.curOpponent then
		local opForm = self.curOpponent.forms

		for _, basePetView in ipairs(opForm.view.petSimpleView) do
			local posId

			for i = 1, 9 do
				if basePetView.petId == opForm.view.curForm.pos[i] then
					posId = i
				end
			end

			if posId then
				local petMo = FightingPowerPetMo.fromBasePetView(basePetView, nil, posId)

				table.insert(teams, petMo)

				formations[posId] = petMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function YoungChampionKingQualifierFmtMo:checkCanFight()
	local canFight, resultCode, tips = YoungChampionKingController.instance:getIsAbleEnterQualifyFight(self.curStepId)

	if resultCode < 0 then
		TipsFacade.instance:openCommonTips(tips)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack)
	end

	return canFight
end

return YoungChampionKingQualifierFmtMo
