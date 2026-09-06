-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/view/DoDragonChallengeMainView.lua

module("logic.extensions.dodragonchallenge.view.DoDragonChallengeMainView", package.seeall)

local DoDragonChallengeMainView = class("DoDragonChallengeMainView", ViewComponent)

function DoDragonChallengeMainView:buildUI()
	DoDragonChallengeMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txt")
	self._btnCultivate = goutil.findChild(self.mainGO, "jumpButton/btnCultivate")
	self._redBtnCultivate = goutil.findChild(self.mainGO, "jumpButton/btnCultivate/redPoint")
	self._btnRank = goutil.findChild(self.mainGO, "jumpButton/btnRank")
	self._redBtnRank = goutil.findChild(self.mainGO, "jumpButton/btnRank/redPoint")
	self._btnLottery = goutil.findChild(self.mainGO, "jumpButton/btnLottery")
	self._redBtnLottery = goutil.findChild(self.mainGO, "jumpButton/btnLottery/redPoint")
	self._challengeButtom = goutil.findChild(self.mainGO, "challengeButtom")
	self._btnChallenge1 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge1/btn")
	self._redBtnChallenge1 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge1/btn/redPoint")
	self._txtBtnChallenge1 = goutil.findChildTextComponent(self.mainGO, "challengeButtom/btnChallenge1/desc/txt")
	self._huobiInBtnChallenge1 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge1/desc/txt/huobi")
	self._btnChallenge2 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge2/btn")
	self._redBtnChallenge2 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge2/btn/redPoint")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._con = goutil.findChild(self.mainGO, "con")
end

function DoDragonChallengeMainView:bindEvents()
	DoDragonChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnCultivate, self._onClickBtnCultivate, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnChallenge1, self._onClickBtnChallenge1, self)
	GameUtil.addClickHandler(self._btnChallenge2, self._onClickBtnChallenge2, self)
end

function DoDragonChallengeMainView:unbindEvents()
	DoDragonChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnCultivate)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnChallenge1)
	GameUtil.rmClickHandler(self._btnChallenge2)
end

function DoDragonChallengeMainView:onEnter()
	DoDragonChallengeMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DoDragonChallengeController.instance:getActivityId()
	end

	self._activityType = DoDragonChallengeController.instance:getActivityType()

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.DisorderDragonChallengeGetInfoRes, self._onUpdate, self)
	DoDragonChallengeController.instance:sendPM_DisorderDragonChallengeGetInfoReq(self._activityId)
end

function DoDragonChallengeMainView:onExit()
	DoDragonChallengeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DisorderDragonChallengeGetInfoRes, self._onUpdate, self)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	RedPointController.instance:unregRedPoint(self._redBtnRank)
end

function DoDragonChallengeMainView:_onSetUI()
	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	if self._txtOpenTime then
		self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	end

	local redIdRank = DoDragonChallengeConfig.instance:getDdCommonValue("PET_RANK_RED")

	RedPointController.instance:regRedPoint(self._redBtnRank, redIdRank)

	local rewardNum = 0
	local prize = DoDragonChallengeConfig.instance:getAllPrize(self._activityId)

	if not string.nilorempty(prize) then
		local matType, matId, matNum = MaterialMgr.getMatParams(prize)

		rewardNum = matNum
	end

	local effParent = self.mainGO
	local pathName = "20230303/shenglongtiaozhan/fx_ui_sltz_jiemian"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function DoDragonChallengeMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DoDragonChallengeMainView:_onUpdateData()
	return
end

function DoDragonChallengeMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
end

function DoDragonChallengeMainView:_onUpdatePlaneUI()
	return
end

function DoDragonChallengeMainView:_onClickBtnIntroduce()
	local raceId = KdChallengeConfig.instance:getKdCurRaceId()

	PetbookController.instance:openPetinfoView(raceId)
end

function DoDragonChallengeMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DoDragonChallengeMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DoDragonChallengeMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DoDragonChallengeMainView:_getSkinId()
	return DoDragonChallengeConfig.instance:getDdCommonValue("PET_SKINID", true)
end

function DoDragonChallengeMainView:_onClickBtnCultivate()
	local jumpToStr = DoDragonChallengeConfig.instance:getDdCommonValue("JUMP_SHOP_KEY")

	GotoMgr.gotoByString(jumpToStr)
end

function DoDragonChallengeMainView:_onClickBtnRank()
	local jumpToStr = DoDragonChallengeConfig.instance:getDdCommonValue("JUMP_RANK_KEY")

	GotoMgr.gotoByString(jumpToStr)
end

function DoDragonChallengeMainView:_onClickBtnLottery()
	local jumpToStr = DoDragonChallengeConfig.instance:getDdCommonValue("JUMP_LOTTERY_KEY")

	GotoMgr.gotoByString(jumpToStr)
end

function DoDragonChallengeMainView:_onClickBtnChallenge1()
	local result, tips = DoDragonChallengeController.instance:getTryEnteryUnitViewResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.DoDragonChallengeUnitView)
end

function DoDragonChallengeMainView:_onClickBtnChallenge2()
	local result, tips = DoDragonChallengeController.instance:getTryEnteryBossViewResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.DoDragonChallengeBossView)
end

function DoDragonChallengeMainView:_onClickBtnTip()
	local key = DoDragonChallengeConfig.instance:getDdCommonValue("MAIN_VIEW_RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

return DoDragonChallengeMainView
