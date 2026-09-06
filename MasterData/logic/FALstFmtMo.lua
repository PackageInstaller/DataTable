-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/model/FALstFmtMo.lua

module("logic.extensions.landlords.model.FALstFmtMo", package.seeall)

local FALstFmtMo = class("FALstFmtMo", BaseCustomFmtMo)

function FALstFmtMo:initParams(activityId)
	self._activityId = activityId
	self._falGameMo = FightAgainstLandlordsController.instance:getFalGameMo()
	self._myUserId = FightAgainstLandlordsController.instance:getMyUserId()
	self.needUpPetCount = 6
	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "FALstFmtMo" .. self._activityId
	self.topTitleStr = "布阵"
	self.isPopRuleDesc = true
	self.isOnlyUpdateExistPet = true

	self:clearAllPetList()
end

function FALstFmtMo:onClickCloseBtn(handler)
	FloatWordMgr.instance:show("游戏中，无法返回")
end

function FALstFmtMo:initPetList()
	self:clearAllPetList()

	local bagCreepsIds = self._falGameMo:getBagCreepsIdsAsUser(self._myUserId)

	for i, creepsId in ipairs(bagCreepsIds) do
		local petMo = FightAgainstLandlordsModel.instance:getPetMoAsFal(creepsId)

		self:addPetToList(self:_changePetMo(petMo))
	end
end

function FALstFmtMo:initFightHandler()
	self:setFightHandler(function()
		return
	end, nil)
end

function FALstFmtMo:saveFmt()
	if not FormationFacade.instance:checkFormationEmptyAndPosNumLimitByFmo(self:getCurFormation(), function()
		self:_finalSaveFmt()
	end) then
		self:_finalSaveFmt()
	end
end

function FALstFmtMo:_finalSaveFmt()
	local simpleForm = self:getCurSimpleForm()

	FightAgainstLandlordsController.instance:sendPM_LandlordsPKFormSetReq(simpleForm)
end

function FALstFmtMo:forceSaveFmt()
	if not FormationFacade.instance:checkFormationEmptyByFmo(self:getCurFormation()) then
		self:_finalSaveFmt()
	end
end

function FALstFmtMo:getFormationExtendViewName()
	return ViewName.FalchallengeextstView
end

return FALstFmtMo
