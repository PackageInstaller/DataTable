-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/model/ICustomFmtMo.lua

module("logic.extensions.customfmt.model.ICustomFmtMo", package.seeall)

local ICustomFmtMo = class("ICustomFmtMo")

ICustomFmtMo.max_strength_info = nil
ICustomFmtMo.EEnterShowRuleFlag_None = 0
ICustomFmtMo.EEnterShowRuleFlag_DailyOnce = 1
ICustomFmtMo.EEnterShowRuleFlag_Always = 2
ICustomFmtMo.EEnterShowRuleFlag_UserSet = 3
ICustomFmtMo.EEnterShowRuleFlag_First = 4

function ICustomFmtMo:ctor()
	self:onInit()
end

function ICustomFmtMo:onInit()
	self._curBagPetVersion = BagPetsController.instance:getPetChangeVersion()

	self:onReset()
	self:initFormationMo()
end

function ICustomFmtMo:onReset()
	self._tmpFmo = nil
	self.isShowBtnFormationUse = true
	self.isShowBtnFormationEdit = false
	self.isShowBtnFormation = false
	self.isShowBtnContractPet = true
	self.isShowBtnBuffForm = true
	self.isShowMaxBuffFormLv = false
	self.isShowBtnCutePet = true
	self.isStartButtonAvailable = true
	self.isShowOneKey = true
	self.isShowClean = true
	self.isShowNegoRight = true
	self.isShowPetBag = true
	self.topTitleStr = ""
	self.ruleDescStr = ""
	self.isPopRuleDesc = false
	self.showBtnVideo = false
	self.showSetDefense = false
	self.validatorDescStr = ""
	self.validatorDescIsShowYesOrNo = nil
	self.isValidatorDescYesOrNo = nil
	self._formCondition = nil
	self.needUpPetCount = 5
	self._onFightHandler = nil
	self._onFightHandlerObject = nil
	self.isShowRuleDescToggle = false
	self.ruleDescToggleName = ""
	self.ruleDestToggleDesc = ""
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = nil
	self.ruleViewName = nil
	self.ruleViewArgs = nil
	self.isNeedOpenCustomFmtFeatureView = false
	self._rightPetList = nil
	self._rightPetMap = nil
	self.isHideFmtZdl = false
	self.isSetEnemySimpleForm = false
	self.enemySimpleForm = nil
	self.formationTips = nil
	self._onSaveHandler = nil
	self._onSaveHandlerObject = nil
	self.isShowBtnSave = nil
	self.isShowTab = false
	self.curTabIndex = 1
	self.maxTabCount = 3
	self.tabPos = Vector2.New(0, -180)
end

function ICustomFmtMo:initParams(...)
	return
end

function ICustomFmtMo:updateData()
	return
end

function ICustomFmtMo:onBeforeEditFmt()
	return
end

function ICustomFmtMo:onBeforeSetDefenseFmt()
	return
end

function ICustomFmtMo:initFormationMo()
	self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
end

function ICustomFmtMo:initFightHandler()
	error(">>>> 必须重写，提供 点击挑战 回调 ，必须使用 self:setFightHandler( handler,handlerObj) ")
end

function ICustomFmtMo:initPetList()
	error(">>>> 必须重写，提供 精灵列表 调用 self:addPetToList(mo) 建议先调用 self:clearAllPetList() 配合重写 :refreshPetList(map) 用来增加更改精灵 ")
end

function ICustomFmtMo:getMonsterConfigList()
	error(">>>>存在 FMT view 必须重写，提供 敌阵阵上精灵的信息 构建 fightPetMo ")
end

function ICustomFmtMo:getFmtInfoConfig()
	error(">>>>存在 FMT view  必须重写，提供  敌阵 面板信息 主要提供 英雄技 和 通灵技 ")
end

function ICustomFmtMo:initSaveHandler()
	error(">>>> 必须重写，提供 点击保存按钮 回调 ，必须使用 self:setSaveHandler( handler,handlerObj) ")
end

function ICustomFmtMo:getExtParams()
	return
end

function ICustomFmtMo:onClickCloseBtn(handler)
	GameUtil.callBack(handler)
end

function ICustomFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if creepCfg then
		for i, v in pairs(creepCfg) do
			if checknumber(v.posId) > 0 then
				local petMo = FightingPowerPetMo.New()

				petMo:fromChallengeCreepCo(v, creepCfg)

				petMo.creepName = v.creepName

				table.insert(teams, petMo)

				formations[v.posId] = petMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function ICustomFmtMo:updatePetListEachTime()
	return
end

function ICustomFmtMo:updatePetListVersion()
	local tmp = BagPetsController.instance:getPetChangeVersion()

	if tmp > self._curBagPetVersion then
		local changePetMoMap = BagPetsController.instance:getPetVersionChangeMap(self._curBagPetVersion)

		self:refreshPetList(changePetMoMap)

		self._curBagPetVersion = tmp

		GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
	end
end

function ICustomFmtMo:refreshPetList(changePetMoMap)
	return
end

function ICustomFmtMo:getExtendViewName()
	return ""
end

function ICustomFmtMo:getFormationExtendViewName()
	return ""
end

function ICustomFmtMo:getPetMoById(petId)
	self:tryInitPetList()

	if self._rightPetMap then
		return self._rightPetMap[petId]
	end

	return nil
end

function ICustomFmtMo:clearAllPetList()
	self._rightPetList = nil
	self._rightPetMap = nil
end

function ICustomFmtMo:addPetToList(mo)
	if mo and mo:isExist() then
		self._rightPetList = self._rightPetList or {}
		self._rightPetMap = self._rightPetMap or {}

		table.insert(self._rightPetList, mo)

		self._rightPetMap[mo.petId] = mo
	end
end

function ICustomFmtMo:tryInitPetList()
	if self._rightPetMap == nil then
		self:initPetList()
	end
end

function ICustomFmtMo:tryRemovePetByIds(petId_or_list)
	if self._rightPetList and self._rightPetMap and petId_or_list then
		local map = {}

		if type(petId_or_list) == "table" then
			for i, v in ipairs(petId_or_list) do
				map[v] = true
			end
		else
			map[petId_or_list] = true
		end

		local count = #self._rightPetList

		for i = count, 1, -1 do
			local mo = self._rightPetList[i]

			if mo and map[mo.petId] then
				self._rightPetMap[mo.petId] = nil

				table.remove(self._rightPetList, i)
			end
		end
	end
end

function ICustomFmtMo:onFilterPetShow(petMo)
	return true
end

function ICustomFmtMo:updatePetMo(mo, isOnlyExisted)
	self._rightPetList = self._rightPetList or {}
	self._rightPetMap = self._rightPetMap or {}

	if isOnlyExisted and self._rightPetMap[mo.petId] == nil then
		return
	end

	local isHas = false

	for i, v in ipairs(self._rightPetList) do
		if v.petId == mo.petId then
			isHas = true

			if mo:isExist() then
				self._rightPetList[i] = mo
				self._rightPetMap[mo.petId] = mo

				break
			end

			table.remove(self._rightPetList, i)

			self._rightPetMap[mo.petId] = nil

			break
		end
	end

	if isHas == false and mo:isExist() then
		table.insert(self._rightPetList, mo)

		self._rightPetMap[mo.petId] = mo
	end
end

function ICustomFmtMo:getCurFormation()
	return self.formationMo
end

function ICustomFmtMo:getCurSimpleForm()
	local curFmtMo = self:getCurFormation()

	return CustomFmtController.instance:createFormPb(curFmtMo)
end

function ICustomFmtMo:setFightHandler(handler, handlerObj)
	self._onFightHandler = handler
	self._onFightHandlerObject = handlerObj
end

function ICustomFmtMo:sendFightMsg()
	GameUtil.callBack(self._onFightHandler, self._onFightHandlerObject)
end

function ICustomFmtMo:setSaveHandler(handler, handlerObj)
	self._onSaveHandler = handler
	self._onSaveHandlerObject = handlerObj
end

function ICustomFmtMo:sendSaveMsg(fromBtnSave)
	GameUtil.callBack(self._onSaveHandler, self._onSaveHandlerObject, fromBtnSave)
	self:onExitView()
end

function ICustomFmtMo:onExitView()
	return
end

function ICustomFmtMo:getAllShowPetList()
	self:tryInitPetList()
	self:updatePetListVersion()
	self:updatePetListEachTime()

	return self._rightPetList or {}
end

function ICustomFmtMo:getAllContractPetList()
	return self:getAllShowPetList()
end

function ICustomFmtMo:sendCancelContract(summonMasterId, summonedPetId)
	return
end

function ICustomFmtMo:sendMakeContract(summonMasterId, summonedPetId)
	return
end

function ICustomFmtMo:checkIsSummonMasterPetsNotInBag(petMo, limitLv)
	return checknumber(petMo.summonedPetId) > 0
end

function ICustomFmtMo:getSummonPetLimitLvl()
	return (checknumber(ContractConfig.instance:getConstValueByKey("SUMMONED_PET_MIN_LVL")))
end

function ICustomFmtMo:setFormCondition(condition)
	self._formCondition = condition
end

function ICustomFmtMo:getFormCondition()
	return self._formCondition
end

function ICustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if self._formCondition then
		return FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._formCondition, self:getCurFormation(), isShowTip)
	else
		return true
	end
end

function ICustomFmtMo:autoCloneFormation()
	return
end

function ICustomFmtMo:revertLastFormation()
	self._tmpFmo = self:getCurFormation():trySaveMySelf()
end

function ICustomFmtMo:beforeUseFormationMo(teamId)
	return
end

function ICustomFmtMo:onFmoSetDown()
	return
end

function ICustomFmtMo:onSummonPosSetdown()
	return
end

function ICustomFmtMo:autoExitFormation()
	self:getCurFormation():Clone(self._tmpFmo)
end

function ICustomFmtMo:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, (self:isUseMaxStreng() and fid > 0 or nil) and BattleConfig.instance:getFormStrengthMaxLv(fid)
end

function ICustomFmtMo:getFmtPowerByParams(team, heroSkill, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, summonMasterId, summonPetId)
	return FightingPowerFormula.instance:getTeamFightingPower(team, heroSkill, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, summonMasterId, summonPetId)
end

function ICustomFmtMo:isUseMaxStreng()
	return false
end

function ICustomFmtMo:updateCellTop(cell, petMo)
	return
end

function ICustomFmtMo:clearCellTop(cell)
	MaterialMgr.resetAll(cell)
end

function ICustomFmtMo:checkPetIsForbit(petMo, baseCheck)
	return false
end

function ICustomFmtMo:showForbitPetAlert(petMo)
	return
end

function ICustomFmtMo:getFinalFmoList(posList, petPool, needPets)
	return posList, petPool
end

function ICustomFmtMo:getFixedPosList()
	return nil
end

function ICustomFmtMo:getFixedPosPetMap()
	return nil
end

function ICustomFmtMo:getCurFormTab()
	return self.curTabIndex
end

function ICustomFmtMo:getNextTabIndex()
	local nextTab = self.curTabIndex + 1

	nextTab = 1 + (nextTab - 1) % self.maxTabCount

	self:jumpToTabIndex(nextTab)
end

function ICustomFmtMo:jumpToTabIndex(idx)
	self.curTabIndex = idx

	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function ICustomFmtMo:checkIsLastTab()
	return self.curTabIndex == self.maxTabCount
end

function ICustomFmtMo:shouldShowStartButton()
	if not self.isStartButtonAvailable then
		return false
	end

	return not self.isShowTab or self:checkIsLastTab()
end

function ICustomFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
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

	return (FormationFacade.instance:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, self:getCurFormation()))
end

function ICustomFmtMo:isClickCanCloseInFomation()
	return true
end

function ICustomFmtMo:getFailedTips()
	return nil
end

function ICustomFmtMo:getSetSummonPetTips()
	return nil
end

function ICustomFmtMo:getEnemySimpleForm()
	return self.enemySimpleForm
end

function ICustomFmtMo:setEnemySimpleForm(form)
	self.enemySimpleForm = form
end

function ICustomFmtMo:checkBlockClickBtn(buttonName)
	return false
end

function ICustomFmtMo:onFormationChangeFinish()
	return
end

function ICustomFmtMo:beginDragBagPet(petMo)
	return
end

function ICustomFmtMo:endDragBagPet()
	return
end

function ICustomFmtMo:beginDragFormationPet(bagPetMo, startPosIndex)
	return
end

function ICustomFmtMo:endDragFormationPet()
	return
end

function ICustomFmtMo:setValidatorDescYesOrNo(isYes)
	self.isValidatorDescYesOrNo = isYes
end

function ICustomFmtMo:sendVideoMsg()
	return
end

function ICustomFmtMo:getSpeedInRight()
	return nil
end

function ICustomFmtMo:getZdlInRight()
	return nil
end

function ICustomFmtMo:isPetUnableToLeve(oldPetId, newPetId)
	return false
end

function ICustomFmtMo:getUnableLevelPos()
	return nil
end

function ICustomFmtMo:setPetFilterList()
	return
end

function ICustomFmtMo:clearAllFixedEffects()
	self.fixedEffMap = nil
	self.fixedEffMapRight = {}
end

function ICustomFmtMo:setFixedEffect(posId, effpath)
	self.fixedEffMap = self.fixedEffMap or {}
	self.fixedEffMap[posId] = effpath
end

function ICustomFmtMo:setFixedEffectRight(posId, effpath)
	self.fixedEffMapRight = self.fixedEffMapRight or {}
	self.fixedEffMapRight[posId] = effpath
end

function ICustomFmtMo:getFormationMos()
	return {
		self.formationMo
	}
end

function ICustomFmtMo:checkIsCanJumpOut()
	return true
end

function ICustomFmtMo:showIsNotCanJumpOutTip()
	return
end

function ICustomFmtMo:getPsychicsPets()
	return nil
end

function ICustomFmtMo:getHeroSkills()
	return nil
end

function ICustomFmtMo:_OnHeroSkillChanged(id, exParmams)
	return
end

function ICustomFmtMo:openCustomFmtFeatureView(skills, curHeroSkillId, curBonds, petMoMap, formation)
	return
end

function ICustomFmtMo:onClickShowPetTips(petMo)
	return
end

return ICustomFmtMo
