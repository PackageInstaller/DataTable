-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/model/SaintKnightRuiCustomFmtMo.lua

module("logic.extensions.saintknightrui.model.SaintKnightRuiCustomFmtMo", package.seeall)

local SaintKnightRuiCustomFmtMo = class("SaintKnightRuiCustomFmtMo", ICustomFmtMo)

function SaintKnightRuiCustomFmtMo:initParams(activityId, stageId, cfgEnemy)
	self._activityId = activityId
	self._stageId = stageId
	self._cfgEnemy = cfgEnemy
	self._masterList = SaintKnightRuiConfig.instance:getFmtPetsList(self._cfgEnemy.creepsMasterId)
	self._supportPetName = ""

	printInfo("test 支援精灵1", self._supportPetName)
	SaintKnightRuiModel.instance:setWinId(nil)
end

function SaintKnightRuiCustomFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.levelDescription or ""
	self.isShowBtnFormation = false

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()

	local fmt = self:getCurFormation()

	if fmt then
		fmt:ResetPosition()
	end
end

function SaintKnightRuiCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.SaintKnightRuiMainView, true)
		UIJumper.instance:pushOneStack(ViewName.SaintKnightRuiChallengeView, true)
		UIJumper.instance:pushOneStack(ViewName.SaintKnightRuiLevelView, true, self._stageId)
		SaintKnightRuiModel.instance:setWinId(self._cfgEnemy.winId)
		BattleFacade.instance:startBattle(GameEnum.MissionType.SaintKnightRui)

		local simpleForm = self:getCurSimpleForm()

		SaintKnightRuiAgent.instance:sendPM_SaintKnightRuiPlayStageReq(self._activityId, self._stageId, self._cfgEnemy.creepsMasterId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function SaintKnightRuiCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function SaintKnightRuiCustomFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function SaintKnightRuiCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)

		if self._allMyPetList then
			local isHas = false

			for i, v in ipairs(self._allMyPetList) do
				if v.petId == petId then
					self._allMyPetList[i] = petMo
					isHas = true

					break
				end
			end

			if isHas == false then
				table.insert(self._allMyPetList, petMo)
			end
		end
	end
end

function SaintKnightRuiCustomFmtMo:initPetList()
	self:clearAllPetList()

	self._allMyPetList = {}

	local helpMasterId = self._cfgEnemy.helpMasterId
	local helpSummonId = self._cfgEnemy.helpSummonId
	local supportCfgs = {}
	local cfgMaster = SaintKnightRuiConfig.instance:getSupportPetCfg(helpMasterId)
	local cfgSummon = SaintKnightRuiConfig.instance:getSupportPetCfg(helpSummonId)

	table.insert(supportCfgs, cfgMaster)
	table.insert(supportCfgs, cfgSummon)

	self._supportPetName = cfgMaster.creepsName

	for i, v in ipairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		local mo = petMo:GetClone()

		self:addPetToList(mo)
		table.insert(self._allMyPetList, mo)
	end
end

function SaintKnightRuiCustomFmtMo:getAllContractPetList()
	return self._allMyPetList
end

function SaintKnightRuiCustomFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local totalPos = MissionModel.instance:getMaxPetNum()
	local curFormation = self:getCurFormation()
	local numPos = FormationFacade.instance:curFormationPetNum(curFormation)
	local petsNum = BagModel.instance:diffRacePetCount()
	local minNeedCount = math.min(petsNum, totalPos)
	local isLimit = false

	if numPos == 0 then
		isLimit = true

		local tip = langPara("空阵不能进行挑战，请返回布阵")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)
	elseif numPos > 0 and numPos < minNeedCount then
		isLimit = true

		local text = langPara("当前未上满%s只精灵，是否进入战斗？", minNeedCount)

		TipsFacade.instance:openPopupWindowWithX(lang("tip"), text, function()
			self:sendFightMsg()
		end, nil, lang("进入战斗"), lang("去布阵"))
	end

	return isLimit
end

return SaintKnightRuiCustomFmtMo
