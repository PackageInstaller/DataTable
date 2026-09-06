-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmankingView.lua

module("logic.extensions.tianmanking.view.TianmankingView", package.seeall)

local TianmankingView = class("TianmankingView", ViewComponent)

function TianmankingView:buildUI()
	TianmankingView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._ruleBtn = self:getBtn("topleft/btnRule")
	self._skillBtn = self:getBtn("btnSkill")
	self._introduceBtn = self:getBtn("btnIntroduce")
	self._rankBtn = self:getBtn("btnRank")
	self._tipRank = self:getGo("tipRank")
	self._txtTipRank = goutil.findChildTextComponent(self._tipRank, "txtTip")
	self._tryBtn = self:getBtn("btnTry")
	self._tipTry = self:getGo("tipTry")
	self._cangBtn = self:getBtn("cangBtn")
	self._cangRed = self:getGo("cangBtn/red")
	self._cangText = self:getTxt("cangBtn/txtProgress")
	self._cangName = self:getTxt("cangBtn/Text")
	self._senBtn = self:getBtn("senBtn")
	self._senRed = self:getGo("senBtn/red")
	self._senLock = self:getGo("senBtn/lock")
	self._senText = self:getTxt("senBtn/txtProgress")
	self._senName = self:getTxt("senBtn/Text")
	self._zhanBtn = self:getBtn("zhanBtn")
	self._zhanRed = self:getGo("zhanBtn/red")
	self._zhanLock = self:getGo("zhanBtn/lock")
	self._zhanText = self:getTxt("zhanBtn/txtProgress")
	self._zhanName = self:getTxt("zhanBtn/Text")
	self._contractBtn = self:getBtn("contractBtn")
	self._contractPet = self:getGo("contractBtn/mask/pet")
	self._contractText = self:getTxt("contractBtn/txtName")
	self._contractLock = self:getGo("contractBtn/lock")
	self._role = self:getGo("con")
	self._rare = self:getGo("petInfo/rare")
	self._timeText = self:getTxt("time/Text")
	self._rewardBubble = self:getGo("rewardBubble/pointItem")
	self._pointRankItem = self:getGo("tipRank/pointItem")
	self._pointTryItem = self:getGo("tipTry/pointItem")
end

function TianmankingView:bindEvents()
	TianmankingView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._ruleBtn:AddClickListener(self._onClickRule, self)
	self._skillBtn:AddClickListener(self._onClickSkill, self)
	self._introduceBtn:AddClickListener(self._onClickIntroduce, self)
	self._rankBtn:AddClickListener(self._onClickRank, self)
	self._tryBtn:AddClickListener(self._onClickTry, self)
	self._cangBtn:AddClickListener(self._onClickCang, self)
	self._senBtn:AddClickListener(self._onClickSen, self)
	self._zhanBtn:AddClickListener(self._onClickZhan, self)
	self._contractBtn:AddClickListener(self._onClickContract, self)
end

function TianmankingView:unbindEvents()
	TianmankingView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._ruleBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._tryBtn:RemoveClickListener()
	self._cangBtn:RemoveClickListener()
	self._senBtn:RemoveClickListener()
	self._zhanBtn:RemoveClickListener()
	self._contractBtn:RemoveClickListener()
end

function TianmankingView:onEnter()
	TianmankingView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.AfterRedPointUpdate, self._onAfterRedPointUpdate, self)

	self._challengeId = tonumber(TianmanKingConfig.instance:getCommonValueByKey("CHALLENGE_ID"))

	local cfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	self._startTime, self._endTime = TLChallengeController.instance:getStartAndEndTime(cfg)

	self:_timer()
	settimer(1, self._timer, self, true)

	local contractPets = TianmanKingConfig.instance:getSupportPet()
	local petCo = CharacterConfig.instance:getPetCo(contractPets[1].raceId)

	self._raceId = contractPets[1].raceId

	local displayBagOffset = CharactorFacade.instance:getPetBagModelUIPosAndScale(self._raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._pet = RoleObjectPool.instance:addRoleToParent(self._pet, petCo.faceIds, self._role, scale, nil, true, x, y)

	MaterialMgr.setCell(MatType.Rare, contractPets[1].raceId, self._rare)
	MaterialMgr.setIcon(self._rewardBubble, MatType.Pet, self._raceId)

	self._txtTipRank.text = TianmanKingController.instance:getText("TEXT_3", TianmanKingConfig.instance:getCommonValueByKey("RANK_SIZE"))

	MaterialMgr.setCellByCfg(TianmanKingConfig.instance:getCommonValueByKey("RANK_PRIZE"), self._pointRankItem)

	local collegeId = PetCollegeConfig.instance:raceId2ChallengeId(checknumber(petCo.faceIds))
	local passedStageId = PetCollegeModel.instance:getCurrPassStageId(collegeId)

	goutil.setActive(self._tipTry, passedStageId == 0)

	if checknumber(collegeId) > 0 then
		local stageCfgs = PetCollegeConfig.instance:getStageCfg(collegeId)
		local prizeDic = {}

		for k, v in ipairs(stageCfgs) do
			if passedStageId < k then
				local matType, matId, matNum = unpack(string.splitToNumber(v.firstPassPrize, ":"))
				local key = matType .. ":" .. matId

				prizeDic[key] = checknumber(prizeDic[key]) + matNum
			end
		end

		local matStr = ""

		for k, v in pairs(prizeDic) do
			matStr = k .. ":" .. v
		end

		MaterialMgr.setCellByCfg(matStr, self._pointTryItem)
	end

	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCGetChallengeInfoRes, self._handlePM_TMWCGetChallengeInfoRes, self)
	TianManWangChallengeAgent.instance:sendPM_TMWCGetChallengeInfoReq()

	local path = "fx_ui_tmwtiaozhan/fx_ui_tmwtiaozhan_daiji.prefab"

	self._cangEff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(_, eff)
		eff:setParent(self._cangBtn.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)
	self._senEff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(_, eff)
		eff:setParent(self._senBtn.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)
	self._zhanEff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(_, eff)
		eff:setParent(self._zhanBtn.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)

	RedPointController.instance:regRedPoint(self._cangRed, 143)
	RedPointController.instance:regRedPoint(self._senRed, 144)
	RedPointController.instance:regRedPoint(self._zhanRed, 145)
end

function TianmankingView:onExit()
	TianmankingView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AfterRedPointUpdate, self._onAfterRedPointUpdate, self)
	uGuiUtil.clearImage(self._contractPet)
	removetimer(self._timer, self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCGetChallengeInfoRes, self._handlePM_TMWCGetChallengeInfoRes, self)
	MaterialMgr.resetAll(self._pointTryItem)
	UIEffectManager.instance:stopEffect(self._cangEff)
	UIEffectManager.instance:stopEffect(self._senEff)
	UIEffectManager.instance:stopEffect(self._zhanEff)
	RedPointController.instance:unregRedPoint(self._cangRed, 143)
	RedPointController.instance:unregRedPoint(self._senRed, 144)
	RedPointController.instance:unregRedPoint(self._zhanRed, 145)
end

function TianmankingView:onExitFinished()
	TianmankingView.super.onExitFinished(self)
	MaterialMgr.resetAll(self._pointTryItem)
	MaterialMgr.resetAll(self._pointRankItem)
	MaterialMgr:clearIcon(self._rewardBubble)
	RoleObjectPool.instance:removeRole(self._pet)

	self._pet = nil
end

function TianmankingView:_handlePM_TMWCGetChallengeInfoRes(msg)
	self._timeOpenPassedStage = TianmanKingModel.instance:getTimeOpenPassedStage()

	goutil.setActive(self._contractLock, msg.curSummon < 1)
	goutil.setActive(self._senLock, msg.curSummon < 1)
	self:_setSenRed()
	goutil.setActive(self._senName.gameObject, msg.curSummon >= 1)

	self._cangText.text = TianmanKingController.instance:getText("TEXT_8", self._timeOpenPassedStage.num, 4)
	self._linearPassedStage = msg.linearPassedStage

	TianmanKingModel.instance:setLinearPassedStage(self._linearPassedStage)
	goutil.setActive(self._zhanLock, self._linearPassedStage < 10)
	goutil.setActive(self._zhanName.gameObject, self._linearPassedStage >= 10)

	local typeCfg = TianmanKingConfig.instance:getTypeByType(2)
	local num = 0

	for i = 1, 4 do
		if self._timeOpenPassedStage[i] then
			num = num + 1
		end
	end

	if num >= 1 then
		local stageCfg = TianmanKingConfig.instance:getStage()

		self._senText.text = TianmanKingController.instance:getText("TEXT_9", self._linearPassedStage, #stageCfg[2])
	else
		self._senText.text = TianmanKingController.instance:getText("TEXT_4", ConstString.ChineseNumber[1])
	end

	typeCfg = TianmanKingConfig.instance:getTypeByType(3)
	self._zhanText.text = self._linearPassedStage < typeCfg.unlockCondition[2] and TianmanKingController.instance:getText("TEXT_5", ConstString.ChineseNumber[typeCfg.unlockCondition[2]]) or msg.bossPassedStage == 4 and TianmanKingController.instance:getText("TEXT_38") or ""
	self._curSummon = msg.curSummon

	if self._curSummon <= 0 then
		self._contractText.text = TianmanKingController.instance:getText("TEXT_7")
	else
		local contractPet = TianmanKingConfig.instance:getSupportPetById(self._curSummon)
		local contractPetCo = CharacterConfig.instance:getPetCo(contractPet.raceId)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(contractPetCo.raceId))

		uGuiUtil.setSpriteToImage(self._contractPet, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

		self._contractText.text = contractPetCo.name
	end
end

function TianmankingView:_onAfterRedPointUpdate()
	self:_setSenRed()
end

function TianmankingView:_setSenRed()
	local curSummon = TianmanKingModel.instance:getCurSummon()
	local isActive = self._senRed.activeSelf
	local isLock = curSummon < 1

	if isLock then
		goutil.setActive(self._senRed, false)
	else
		goutil.setActive(self._senRed, isActive)
	end
end

function TianmankingView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "tianmankingchallenge")
end

function TianmankingView:_onClickSkill()
	PetbookController.instance:previewBattle(10099)
end

function TianmankingView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(10099)
end

function TianmankingView:_onClickRank()
	UIStateManager.instance:push(ViewName.TianmankingrankView, self._challengeId)
end

function TianmankingView:_onClickTry()
	FuncOpenController.instance:openFunc(149, self._raceId)
end

function TianmankingView:_onClickCang()
	SurveyController.instance:reportBehavior(200465, 1)
	UIStateManager.instance:push(ViewName.CangmuqianyeView)
end

function TianmankingView:_onClickSen()
	local typeCfg = TianmanKingConfig.instance:getTypeByType(2)
	local num = 0

	for i = 1, 4 do
		if self._timeOpenPassedStage[i] then
			num = num + 1
		end
	end

	if num >= 1 then
		SurveyController.instance:reportBehavior(200465, 2)
		UIStateManager.instance:push(ViewName.SenluowanxiangView)
	else
		FloatWordMgr.instance:show(TianmanKingController.instance:getText("TEXT_4"), 1)
	end
end

function TianmankingView:_onClickZhan()
	if self._linearPassedStage >= 10 then
		SurveyController.instance:reportBehavior(200465, 3)
		UIStateManager.instance:push(ViewName.ZhanjuebahuangView)
	else
		FloatWordMgr.instance:show(TianmanKingController.instance:getText("TEXT_5", ConstString.ChineseNumber[10]))
	end
end

function TianmankingView:_onClickContract()
	UIStateManager.instance:push(ViewName.TianmankingcontractView)
end

function TianmankingView:_timer()
	self._timeText.text = ServerTime.now() - self._endTime > 0 and TianmanKingController.instance:getText("TEXT_2") or TianmanKingController.instance:getText("TEXT_1", GameUtil.FormatTimeSymbol(self._endTime - ServerTime.now()))
end

return TianmankingView
