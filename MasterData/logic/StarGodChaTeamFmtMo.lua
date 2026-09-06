-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/model/StarGodChaTeamFmtMo.lua

module("logic.extensions.stargodchallenge.model.StarGodChaTeamFmtMo", package.seeall)

local StarGodChaTeamFmtMo = class("StarGodChaTeamFmtMo", ICustomFmtMo)

function StarGodChaTeamFmtMo:initParams()
	self.isShowTab = false
	self._curTeamInfo = FormTeamModel.instance:getCurTeamInfo()

	if self._curTeamInfo then
		local cfg = StarGodChallengeConfig.instance:getChallengeCfgByGroupId(self._curTeamInfo.groupId)

		self._cfgEnemy = StarGodChallengeConfig.instance:getMasterCfg(cfg.creepsMasterId)
		self._masterList = StarGodChallengeConfig.instance:getCreepsCfg(cfg.creepsMasterId)
		self.topTitleStr = cfg.name
		self.ruleDescStr = self._cfgEnemy.levelDescription
	end
end

function StarGodChaTeamFmtMo:updateData()
	self.isShowBtnFormation = false

	self:_setFmtData()

	local formCondition = checknumber(StarGodChallengeConfig.instance:getConstValue("GROUP_FORM_CONDITION"))

	self:setFormCondition(formCondition)
end

function StarGodChaTeamFmtMo:initFormationMo()
	self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))

	self:_setFmtData()
end

function StarGodChaTeamFmtMo:getExtendViewName()
	return ViewName.StarGodChallengeExtView
end

function StarGodChaTeamFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function StarGodChaTeamFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function StarGodChaTeamFmtMo:onClickCloseBtn(handler)
	FloatWordMgr.instance:show("组队模式已进入布阵后无法返回。")
end

function StarGodChaTeamFmtMo:initFightHandler()
	self:setFightHandler(function()
		StarGodChallengeAgent.instance:sendPM_StarGodChallengeReadyReq(self:getCurSimpleForm())
	end)
end

function StarGodChaTeamFmtMo:getMonsterConfigList()
	return self._masterList
end

function StarGodChaTeamFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function StarGodChaTeamFmtMo:autoExitFormation()
	StarGodChaTeamFmtMo.super.autoExitFormation(self)

	local simpleForm = self:getCurSimpleForm()

	printInfo("test StarGodChaTeamFmtMo:autoExitFormation")
	StarGodChallengeAgent.instance:sendPM_StarGodChallengeSetFormReq(simpleForm)
end

function StarGodChaTeamFmtMo:checkLimitAutoTeamReady()
	local isLimit = false
	local numPos = FormationFacade.instance:curFormationPetNum(self:getCurFormation())

	if numPos == 0 then
		isLimit = true

		local tip = langPara("空阵不能进行挑战，请返回布阵")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)
	end

	return isLimit
end

function StarGodChaTeamFmtMo:_setFmtData()
	if self.formationMo then
		local simpleForm = StarGodChallengeModel.instance:getTeamForm()

		if simpleForm then
			self.formationMo:SetData(simpleForm)
		end
	end
end

return StarGodChaTeamFmtMo
