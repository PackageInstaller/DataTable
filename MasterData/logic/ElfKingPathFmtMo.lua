-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/model/ElfKingPathFmtMo.lua

module("logic.extensions.elfkingpath.model.ElfKingPathFmtMo", package.seeall)

local ElfKingPathFmtMo = class("ElfKingPathFmtMo", BaseCustomFmtMo)

function ElfKingPathFmtMo:initParams(stageId, sonStageId)
	self.isShowOneKey = false
	self.isShowClean = true
	self.isShowPetBag = false
	self.isShowBtnCutePet = false
	self.isShowBtnFormationUse = false
	self.isOnlyUpdateExistPet = true
	self.stageId = stageId
	self.stageCfg = ElfKingPathConfig.instance:getStageCfg(self.stageId)
	self.sonStageId = sonStageId
	self.sonStageCfg = ElfKingPathConfig.instance:getSonStageCfg(self.stageId, self.sonStageId)
	self.battleGuideId = self.sonStageCfg.battleGuideId or 0

	if self.sonStageCfg then
		self.isShowOneKey = self.sonStageCfg.isShowOneKey
	end

	local creepsMasterId = self.sonStageCfg.creepsMasterId

	self._masterData = ElfKingPathConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = ElfKingPathConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.helpCfgs = ElfKingPathConfig.instance:getSupportPetCfgs(self.sonStageCfg.supportPetPlan)

	self:getCurFormation():ResetPosition(true)
	self:clearAllPetList()
end

function ElfKingPathFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		if self.battleGuideId and self.battleGuideId > 0 then
			ElfKingPathController.instance:processGuideData(self.battleGuideId, true)
			GuideController.instance:setViewVar("elf_king_path_battle", self.battleGuideId)
		end

		local simpleForm = self:getCurSimpleForm()

		ElfKingPathController.instance:startChallenge(simpleForm, self.stageId, self.sonStageId)
	end

	self:setFightHandler(handler, nil)
end

function ElfKingPathFmtMo:initPetList()
	self:clearAllPetList()

	if self.helpCfgs then
		local fmo = self:_getFightPowerPetMo()

		for _, helpData in pairs(self.helpCfgs) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			self:addPetToList(petMo)
		end
	end
end

function ElfKingPathFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function ElfKingPathFmtMo:getFmtInfoConfig()
	return self._masterData
end

function ElfKingPathFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function ElfKingPathFmtMo:getExtendViewName()
	return ViewName.ElfKingPathFmtExView
end

function ElfKingPathFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if FormationFacade.instance:checkFormationEmptyByFmo(self:getCurFormation()) then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("fight_unformation"), function()
				return
			end, onekeyCallBack, lang("fight_goto_fmt"), lang("一键布阵"))
		else
			TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), nil, lang("fight_goto_fmt"))
		end

		return true
	end

	if self.sonStageCfg and self.sonStageCfg.isFmtShowTips then
		return (FormationFacade.instance:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, self:getCurFormation()))
	else
		return false
	end
end

return ElfKingPathFmtMo
