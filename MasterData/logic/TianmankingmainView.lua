-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmankingmainView.lua

module("logic.extensions.tianmanking.view.TianmankingmainView", package.seeall)

local TianmankingmainView = class("TianmankingmainView", ViewComponent)

function TianmankingmainView:buildUI()
	TianmankingmainView.super.buildUI(self)

	self._challengeId = tonumber(TianmanKingConfig.instance:getCommonValueByKey("CHALLENGE_ID"))
	self._closeBtn = self:getBtn("topleft/btnClose")
	self._ruleBtn = self:getBtn("topleft/btnRule")
	self._skillBtn = self:getBtn("btnSkill")
	self._introduceBtn = self:getBtn("btnIntroduce")
	self._challengeBtn = self:getBtn("challengeBtn")
	self._challengeRed = self:getGo("challengeBtn/red")
	self._role = self:getGo("con")
	self._rare = self:getGo("petInfo/rare")
	self._contractPet = {}

	for i = 1, 4 do
		local path = "contractPet_" .. i

		self._contractPet[i] = {
			icon = goutil.findChild(self.mainGO, path .. "/mask/pet")
		}
		self._contractPet[i].name = goutil.findChildTextComponent(self.mainGO, path .. "/name")
		self._contractPet[i].lock = goutil.findChild(self.mainGO, path .. "/lock")
	end

	self._timeText = self:getTxt("time/Text")
	self.btnShop = self:getGo("btnShop")
	self.head = self:getGo("btnShop/head")
end

function TianmankingmainView:bindEvents()
	TianmankingmainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._ruleBtn:AddClickListener(self._onClickRule, self)
	self._skillBtn:AddClickListener(self._onClickSkill, self)
	self._introduceBtn:AddClickListener(self._onClickIntroduce, self)
	self._challengeBtn:AddClickListener(self._onClickChallenge, self)
	GameUtil.addClickHandler(self.btnShop, self.onClickShop, self)
end

function TianmankingmainView:unbindEvents()
	TianmankingmainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._ruleBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	self._challengeBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnShop)
end

function TianmankingmainView:onClickShop()
	local goodsId = TianmanKingConfig.instance:getCommonValueByKey("GOODS_ID")

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function TianmankingmainView:onEnter()
	TianmankingmainView.super.onEnter(self)

	local cfg = TimeLimitedConfig.instance:getCfgById(tonumber(TianmanKingConfig.instance:getCommonValueByKey("CHALLENGE_ID")))

	self._startTime, self._endTime = TLChallengeController.instance:getStartAndEndTime(cfg)

	self:_timer()
	settimer(1, self._timer, self, true)

	local contractPets = TianmanKingConfig.instance:getSupportPet()
	local petCo = CharacterConfig.instance:getPetCo(contractPets[1].raceId)
	local displayBagOffset = CharactorFacade.instance:getPetBagModelUIPosAndScale(contractPets[1].raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._pet = RoleObjectPool.instance:addRoleToParent(self._pet, petCo.faceIds, self._role, scale, nil, true, x, y)

	MaterialMgr.setCell(MatType.Rare, contractPets[1].raceId, self._rare)
	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCGetSummonsInfoRes, self._handlePM_TMWCGetSummonsInfoRes, self)
	TianManWangChallengeAgent.instance:sendPM_TMWCGetSummonsInfoReq()

	self._viewEff = UIEffectManager.instance:playEffect(self, "fx_ui_tmwtiaozhan/fx_ui_tmwtiaozhan_fenwei.prefab", nil, 0, 0, true, nil, nil, function(_, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)
	self._challengeEff = UIEffectManager.instance:playEffect(self, "fx_ui_tmwtiaozhan/fx_ui_tmwtiaozhan_jintutiaozhan.prefab", nil, 0, 0, true, nil, nil, function(_, eff)
		eff:setParent(self._challengeBtn.transform)
		eff:setScale(1)
		eff:setLocalPos(-4.83, -1.46)
	end)

	RedPointController.instance:regRedPoint(self._challengeRed, RedPointModel.ID_TIANMANKINGCHALLENGE)
	self:updateGoShop()
end

function TianmankingmainView:updateGoShop()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	local raceId = self._challengeCfg.raceId

	MaterialMgr.setIcon(self.head, MatType.Pet, raceId)
end

function TianmankingmainView:onExit()
	TianmankingmainView.super.onExit(self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCGetSummonsInfoRes, self._handlePM_TMWCGetSummonsInfoRes, self)
	MaterialMgr.resetAll(self._rare)

	for i, v in ipairs(self._contractPet) do
		uGuiUtil.clearImage(v.icon)
	end

	removetimer(self._timer, self)
	UIEffectManager.instance:stopEffect(self._viewEff)
	UIEffectManager.instance:stopEffect(self._challengeEff)
	RedPointController.instance:unregRedPoint(self._challengeRed, RedPointModel.ID_TIANMANKINGCHALLENGE)
end

function TianmankingmainView:onExitFinished()
	TianmankingmainView.super.onExitFinished(self)
	RoleObjectPool.instance:removeRole(self._pet)

	self._pet = nil
end

function TianmankingmainView:_handlePM_TMWCGetSummonsInfoRes(msg)
	local contractPets = TianmanKingConfig.instance:getSupportPet()
	local timeOpenPassedStage = TianmanKingModel.instance:getTimeOpenPassedStage()

	for i, v in ipairs(self._contractPet) do
		local contractPetCo = CharacterConfig.instance:getPetCo(contractPets[i + 1].raceId)

		if timeOpenPassedStage[i] then
			goutil.setActive(v.lock, false)
		else
			goutil.setActive(v.lock, true)
		end

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(contractPetCo.raceId))

		uGuiUtil.setSpriteToImage(v.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

		v.name.text = contractPetCo.name
	end
end

function TianmankingmainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "tianmankingchallenge")
end

function TianmankingmainView:_onClickSkill()
	PetbookController.instance:previewBattle(10099)
end

function TianmankingmainView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(10099)
end

function TianmankingmainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.TianmankingView)
end

function TianmankingmainView:_timer()
	self._timeText.text = ServerTime.now() - self._endTime > 0 and TianmanKingController.instance:getText("TEXT_2") or TianmanKingController.instance:getText("TEXT_1", GameUtil.FormatTimeSymbol(self._endTime - ServerTime.now()))
end

return TianmankingmainView
