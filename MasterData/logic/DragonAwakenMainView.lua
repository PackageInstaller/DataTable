-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenMainView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenMainView", package.seeall)

local DragonAwakenMainView = class("DragonAwakenMainView", ViewComponent)

function DragonAwakenMainView:ctor()
	DragonAwakenMainView.super.ctor(self)
end

function DragonAwakenMainView:unbindEvents()
	DragonAwakenMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnTrain)

	for i, cell in ipairs(self._challengeList) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function DragonAwakenMainView:bindEvents()
	DragonAwakenMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickBtnInfo, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickBtnTeam, self)
	GameUtil.addClickHandler(self._btnTrain, self._onClickBtnTrain, self)

	for i, cell in ipairs(self._challengeList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickChallenge, self, i))
	end
end

function DragonAwakenMainView:buildUI()
	DragonAwakenMainView.super.buildUI(self)

	self._btnClose = self:getGo("topleft/btnClose")
	self._btnTip = self:getGo("topleft/btnTip")
	self._iconInfo = self:getGo("info/petHead/icon")
	self._txtInfo = self:getTxt("info/txt")
	self._txtTipsInfo = self:getTxt("info/txtTips")
	self._effPosInfo = self:getGo("info/effPos")
	self._btnInfo = self:getGo("info/btn")
	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._btnTeam = self:getGo("btnTeam")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnTrain = self:getGo("train/btn")
	self._txtTimeTrain = self:getTxt("train/txtTime")
	self._challengeList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("challengeList/cell_" .. i)
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.txtName = goutil.findChildTextComponent(cell.btn, "txt")
		cell.time = goutil.findChild(cell.go, "time")
		cell.txtTime = goutil.findChildTextComponent(cell.time, "txt")
		cell.lock = goutil.findChild(cell.go, "lock")
		self._challengeList[i] = cell
	end

	self._card = self:getGo("ani/card")
	self._petCard = self:getGo("ani/card/bg/pet")
	self._rdTrain = self:getGo("train/btn/rd")
	self._redpointTeam = self:getGo("btnTeam/redpoint")
end

function DragonAwakenMainView:onExit()
	DragonAwakenMainView.super.onExit(self)
	MaterialMgr.resetAll(self._iconInfo)

	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)

		self._showEff = nil
	end

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._evoleEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._evoleEff = nil
	end

	uGuiUtil.clearImage(self._petCard)

	if self._tweenMove then
		self._tweenMove:Kill(false)

		self._tweenMove = nil
	end

	if self._tweenRota then
		self._tweenRota:Kill(false)

		self._tweenRota = nil
	end

	removetimer(self._endPlayAni, self)
	RedPointController.instance:unregRedPoint(self._rdTrain)
	RedPointController.instance:unregRedPoint(self._redpointTeam)
end

function DragonAwakenMainView:onEnter()
	DragonAwakenMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateByCfg()
	self.addGEvent(self, GlobalNotify.DragonAwakenGetInfoRes, self._updateByInfo, self)
	DragonAwakenController.instance:getInfo(self._activityId)

	self._playAniIng = false

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self._mainEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO.transform, 0, 0, true, nil, nil, function(view, uiEff)
		uiEff:setParent(self.mainGO.transform)
		uiEff:setLocalPos(0, 0, 0)
		uiEff:setScale(1)
		uiEff:setClipping(self.mainGO.transform)
	end)

	RedPointController.instance:regRedPoint(self._rdTrain, "c36")
	RedPointController.instance:regRedPoint(self._redpointTeam, "o42")
	DragonAwakenController.instance:resetRedPoint(self._activityId)
end

function DragonAwakenMainView:_updateByCfg()
	self._actCfg = DragonAwakenConfig.instance:getActivityCfg(self._activityId)
	self._phaseCfgs = DragonAwakenConfig.instance:getPhaseCfgs(self._activityId)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local enterKey = ViewName.DragonAwakenMainView .. "_first_enter_" .. self._activityId
	local isFristEnterGame = GameUtil.getUserData(enterKey)

	if not isFristEnterGame then
		local storyId = checknumber(self._actCfg.plotId)

		if storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
			GameUtil.saveUserData(enterKey, true)
		end
	end

	local btn_list = {
		{
			showAdd = false,
			id = self._actCfg.mainCost
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function DragonAwakenMainView:_updateByInfo()
	DragonAwakenModel.instance:setCurActId(self._activityId)

	local baseInfo = DragonAwakenModel.instance:getCurBaseInfo()

	self._txtTimeTrain.text = string.format("剩余%d次", self._actCfg.dailyTrainingTimes - baseInfo.todayTrainingTimes)
	self._curPhaseId = baseInfo.curPhaseId

	for i, cell in ipairs(self._challengeList) do
		local cfg = self._phaseCfgs[i]

		if cfg then
			goutil.setActive(cell.go, true)

			cell.txtName.text = cfg.phaseName

			goutil.setActive(cell.lock, i > self._curPhaseId)

			local isOpen = ServerTime.now() >= GameUtil.string2time(cfg.openTime)

			goutil.setActive(cell.time, not isOpen)

			if not isOpen then
				local openDate = GameUtil.string2date(cfg.openTime)

				cell.txtTime.text = string.format("%d.%02d %02d:00后开启", openDate.month, openDate.day, openDate.hour)
			end
		else
			goutil.setActive(cell.go, false)
		end
	end

	self:_updatePetInfo()
end

function DragonAwakenMainView:_updatePetInfo()
	local evolKey = "Dragon_Awaken_Evol_Key _" .. self._activityId
	local saveEvolLV = checknumber(GameUtil.getUserData(evolKey))

	if self._curPhaseId == 1 then
		GameUtil.saveUserData(evolKey, 1)

		saveEvolLV = 1
	end

	local curCfg = self._phaseCfgs[self._curPhaseId]
	local petCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self._activityId, self._curPhaseId)

	self._isNeedEvol = false

	if self._curPhaseId > #self._phaseCfgs then
		curCfg = self._phaseCfgs[self._curPhaseId - 1]
		petCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self._activityId, self._curPhaseId - 1)
	elseif self._curPhaseId ~= saveEvolLV then
		curCfg = self._phaseCfgs[self._curPhaseId - 1]
		self._isNeedEvol = true
		petCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self._activityId, self._curPhaseId - 1)
	end

	self._txtInfo.text = curCfg and curCfg.showDesc
	self._txtTipsInfo.text = curCfg and curCfg.curPowerStr

	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)

		self._showEff = nil
	end

	if self._isNeedEvol then
		local effPath = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

		self._showEff = UIEffectManager.instance:playEffect(self, effPath, self._effPosInfo.transform, 0, 0, true, nil, nil, function(view, uiEff)
			uiEff:setParent(self._effPosInfo.transform)
			uiEff:setLocalPos(0, 0, 0)
			uiEff:setScale(1)
			uiEff:setClipping(self.mainGO.transform)
		end)
	end

	if petCfg then
		local skinId = checknumber(petCfg.faceId)

		if skinId <= 0 then
			skinId = petCfg.raceId
		end

		local modelCo = CharacterConfig.instance:getModelCo(skinId)

		uGuiUtil.setSpriteToImage(self._petCard, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		MaterialMgr.setIcon(self._iconInfo, MatType.PET_SKIN, skinId)
	end

	goutil.setActive(self._card, false)
end

function DragonAwakenMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DragonAwakenMainView:_onClickBtnInfo()
	if self._isNeedEvol then
		self:_playAni()
	end
end

function DragonAwakenMainView:_playAni()
	if self._playAniIng then
		return
	end

	self._playAniIng = true

	if self._tweenMove then
		self._tweenMove:Kill(false)

		self._tweenMove = nil
	end

	goutil.setActive(self._card, true)
	Framework.TransformUtil.SetLocalScale(self._card.transform, 0.2, 0.2, 0.2)
	Framework.TransformUtil.SetAnchoredPos(self._card.transform, -590, 210)

	self._tweenMove = TweenUtil.ValueTo(0, 1, 1, function(val)
		local curSize = 0.8 * val + 0.2

		Framework.TransformUtil.SetLocalScale(self._card.transform, curSize, curSize, curSize)

		local curPosX = -590 + 590 * val
		local curPosY = 210 - 210 * val

		Framework.TransformUtil.SetAnchoredPos(self._card.transform, curPosX, curPosY)
	end, function()
		self._tweenMove = nil

		self:_playAni2()
	end, self, DG.Tweening.Ease.Linear)
end

function DragonAwakenMainView:_playAni2()
	Framework.TransformUtil.SetLocalScale(self._card.transform, 1, 1, 1)
	Framework.TransformUtil.SetAnchoredPos(self._card.transform, 0, 0)
	Framework.TransformUtil.SetLocalRotation(self._card.transform, 0, 0, 0)

	if self._tweenRota then
		self._tweenRota:Kill(false)

		self._tweenRota = nil
	end

	self._tweenRota = TweenUtil.ValueTo(0, 1, 1, function(val)
		Framework.TransformUtil.SetLocalRotation(self._card.transform, 0, 720 * val, 0)
	end, function()
		self._tweenRota = nil

		if self._evoleEff then
			UIEffectManager.instance:stopEffect(self._mainEff)

			self._evoleEff = nil
		end

		local effPath = "20230825/yonghengguodu/fx_ui_yonghengguodu_shu.prefab"

		self._evoleEff = UIEffectManager.instance:playEffect(self, effPath, self._card.transform, 0, 0, false, nil, function()
			self:_playAni3()
		end, function(view, uiEff)
			uiEff:setParent(self._card.transform)
			uiEff:setLocalPos(320, 0, 0)
			uiEff:setScale(1)
			uiEff:setClipping(self.mainGO.transform)
		end)
	end, self, DG.Tweening.Ease.Linear)
end

function DragonAwakenMainView:_playAni3()
	Framework.TransformUtil.SetLocalScale(self._card.transform, 1, 1, 1)
	Framework.TransformUtil.SetAnchoredPos(self._card.transform, 0, 0)
	Framework.TransformUtil.SetLocalRotation(self._card.transform, 0, 0, 0)
	settimer(1, self._endPlayAni, self, false)

	local petCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self._activityId, self._curPhaseId)

	if petCfg then
		local skinId = checknumber(petCfg.faceId)

		if skinId <= 0 then
			skinId = petCfg.raceId
		end

		local modelCo = CharacterConfig.instance:getModelCo(skinId)

		uGuiUtil.setSpriteToImage(self._petCard, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end
end

function DragonAwakenMainView:_endPlayAni()
	self._playAniIng = false

	local evolKey = "Dragon_Awaken_Evol_Key _" .. self._activityId

	GameUtil.saveUserData(evolKey, self._curPhaseId)
	self:_updatePetInfo()
	UIStateManager.instance:push(ViewName.DragonAwakenEvolView, self._phaseCfgs[self._curPhaseId])
end

function DragonAwakenMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.DragonAwakenRankView, self._activityId)
end

function DragonAwakenMainView:_onClickBtnShop()
	local jumpToStr = self._actCfg.shopGotoStr

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function DragonAwakenMainView:_onClickBtnTeam()
	if self._isNeedEvol then
		TipsFacade.instance:openCommonTips("请先进化当前精灵")

		return
	end

	UIStateManager.instance:push(ViewName.DragonAwakenPetView, self._activityId)
end

function DragonAwakenMainView:_onClickBtnTrain()
	if self._isNeedEvol then
		TipsFacade.instance:openCommonTips("请先进化当前精灵")

		return
	end

	UIStateManager.instance:push(ViewName.DragonAwakenTrainView, self._activityId)
end

function DragonAwakenMainView:_onClickChallenge(challengeId)
	local cfg = self._phaseCfgs[challengeId]
	local isOpen = ServerTime.now() >= GameUtil.string2time(cfg.openTime)

	if not isOpen then
		local openDate = GameUtil.string2date(cfg.openTime)
		local tips = string.format("%d.%02d %02d:00后开启", openDate.month, openDate.day, openDate.hour)

		TipsFacade.instance:openCommonTips(tips)

		return
	end

	if challengeId == self._curPhaseId then
		if self._isNeedEvol then
			TipsFacade.instance:openCommonTips("请先进化当前精灵")

			return
		end

		if self._curPhaseId < #self._phaseCfgs then
			UIStateManager.instance:push(ViewName.DragonAwakenStageView, self._activityId, self._curPhaseId)
		else
			UIStateManager.instance:push(ViewName.DragonAwakenFinalChallengeView, self._activityId, self._curPhaseId)
		end
	elseif challengeId > self._curPhaseId then
		TipsFacade.instance:openCommonTips("请通关前面章节")
	else
		TipsFacade.instance:openCommonTips("已通关")
	end
end

return DragonAwakenMainView
