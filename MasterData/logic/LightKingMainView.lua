-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingMainView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingMainView", package.seeall)

local LightKingMainView = class("LightKingMainView", TimeLimitedMainView)

function LightKingMainView:unbindEvents()
	LightKingMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnJob:RemoveClickListener()
	self._btnGoto:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnShop)
end

function LightKingMainView:bindEvents()
	LightKingMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnJob:AddClickListener(self._onClickJob, self)
	self._btnGoto:AddClickListener(self._onClickGoto, self)
	GameUtil.addClickHandler(self.btnShop, self.onClickShop, self)
end

function LightKingMainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "",
			path = "fx_ui_guangmingwangtiaozhan/fx_ui_guangmingwangtiaozhan_01.prefab"
		}
	}
end

function LightKingMainView:_onClickGoto()
	UIStateManager.instance:push(ViewName.ContractEnterView)
end

function LightKingMainView:onExit()
	LightKingMainView.super.onExit(self)

	if self._matPoints then
		for _, v in ipairs(self._matPoints) do
			MaterialMgr.resetAll(v)
		end
	end

	self._matPoints = nil

	GlobalDispatcher:removeListener(GlobalNotify.LightKingGetInfo, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.LightKingGainPrize, self._onGainPrizeRes, self)

	if self._contractCons then
		for _, v in ipairs(self._contractCons) do
			uGuiUtil.clearImage(v)
		end
	end

	self._contractCons = nil

	MaterialMgr.clearIcon(self.head)
end

function LightKingMainView:buildUI()
	LightKingMainView.super.buildUI(self)

	self._challenges = {}

	for _, v in pairs(GameEnum.LightKingChallengeType) do
		self._challenges[v] = self:getGo("challenges/challenge_" .. v)
	end

	self._slider = self:getGo("progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = goutil.findChildComponent(self._slider, "rewards", typeof(UnityEngine.UI.GridLayoutGroup))
	self._challengeId = LightKingModel.instance:getChallengeId()
	self._txtCurScore = goutil.findChildTextComponent(self._slider, "bigReward/txtNum")
	self._imgItem = goutil.findChild(self._slider, "bigReward/item")
	self._btnJob = self:getBtn("btnJob")
	self._btnGoto = self:getBtn("contract/btnGoto")
	self._leftTimeFmt = "剩余：%s"
	self.btnShop = self:getGo("btnShop")
	self.head = self:getGo("btnShop/head")
end

function LightKingMainView:onEnter()
	LightKingMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LightKingGetInfo, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.LightKingGainPrize, self._onGainPrizeRes, self)
	LightKingController.instance:sendGetInfoReq()
	LightKingModel.instance:saveDailyOpenTime()
	self:_updateProgressBar()
	self:updateGoShop()
end

function LightKingMainView:updateGoShop()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	local raceId = self._challengeCfg.raceId

	MaterialMgr.setIcon(self.head, MatType.Pet, raceId)
end

function LightKingMainView:onClickShop()
	local goodsId = LightKingConfig.instance:getConstantValue("GOODS_ID")

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function LightKingMainView:_onGetInfoRes()
	self._matPoints = {}

	self:_updateRankTip(LightKingModel.instance:getPetRankSize())

	for k, v in pairs(self._challenges) do
		self:_updateChallenge(k, v, k)
	end

	self:_updateProgressBar()

	local matType, matId = LightKingModel.instance:getItemTypeAndId()

	self._imgItem:SetActive(false)
	MaterialMgr.setIcon(self._imgItem, matType, matId, function()
		self._imgItem:SetActive(true)
	end)
	LightKingController.instance:showChangeSetId()
end

function LightKingMainView:_onGainPrizeRes()
	self:_updateProgressBar()
end

function LightKingMainView:_updateRankTip(petRankSize)
	local petRankThreshold = 5999
	local petRankPrize = LightKingConfig.instance:getConstantValue("PET_RANK_PRIZE")

	self._tipRank.gameObject:SetActive(petRankSize < petRankThreshold)

	self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)

	MaterialMgr.setCellByCfg(petRankPrize, self._pointRankItem)
end

function LightKingMainView:_updateChallenge(challengeType, go, idx)
	local txtCurNum = goutil.findChildTextComponent(go, "txtCurNum")
	local imgIcon = goutil.findChild(go, "txtCurNum/imgIcon")
	local btnStart = Framework.ButtonAdapter.GetFrom(go, "btnStart")
	local lock = goutil.findChild(btnStart.gameObject, "lock")
	local finished = goutil.findChild(btnStart.gameObject, "finished")
	local matType, matId = LightKingModel.instance:getItemTypeAndId()

	imgIcon:SetActive(false)
	MaterialMgr.setIcon(imgIcon, matType, matId, function()
		imgIcon:SetActive(true)
	end)

	local curStage = LightKingModel.instance:getCurStage(challengeType)
	local baseCfg = LightKingConfig.instance:getBaseDefineCfg(challengeType)
	local locked = false

	for _, v in ipairs(baseCfg.condition) do
		if not LightKingModel.instance:getChallengeFinished(v) then
			locked = true

			break
		end
	end

	lock:SetActive(locked)
	btnStart:AddClickListener(function()
		self:_onClickStart(challengeType, locked)
	end)

	local cur, total = LightKingConfig.instance:getCurAndTotalScore(challengeType, curStage)

	txtCurNum.text = string.format("<color=#F7E973FF>%d/</color>%d", cur, total)

	local isFinished = LightKingModel.instance:getChallengeFinished(challengeType)

	finished:SetActive(isFinished)

	if not isFinished and not locked then
		self:_playEffect((idx == 3 or nil) and "fx_ui_guangmingwangtiaozhan/fx_ui_guangmingwangtiaozhan_anniu02.prefab", btnStart.gameObject)
	end
end

function LightKingMainView:_updateProgressBar(value)
	local prizeCfgs = LightKingConfig.instance:getPrizeCfgs()
	local prizeNum = #prizeCfgs
	local cellWidth = self._gridLayout.cellSize.x
	local spacingX = self._gridLayout.spacing.x
	local sliderRectTrans = self._slider:GetComponent(typeof(UnityEngine.RectTransform))
	local gridRectTrans = self._gridLayout:GetComponent(typeof(UnityEngine.RectTransform))
	local sizeDelta = sliderRectTrans.sizeDelta
	local barWidth = cellWidth * (prizeNum - 1) + spacingX * prizeNum

	sizeDelta.x = barWidth
	sliderRectTrans.sizeDelta = sizeDelta

	Framework.TransformUtil.SetAnchoredPos(gridRectTrans, spacingX, 0)
	GameUtil.updateCellsWithCreate(self._gridLayout, prizeCfgs, self._updateOnePrize, self)

	local curScore = LightKingModel.instance:getCurScore()
	local progressVal = 0

	for k, v in ipairs(prizeCfgs) do
		local score = v.score

		if curScore < score then
			local preCfg = prizeCfgs[k - 1]
			local preScore = 0

			if preCfg then
				preScore = preCfg.score
			end

			progressVal = progressVal + (curScore - preScore) / (score - preScore) * spacingX / barWidth

			break
		else
			progressVal = progressVal + (cellWidth + spacingX) / barWidth
		end
	end

	print("updateVal = " .. progressVal)

	self._slider.value = progressVal
	self._txtCurScore.text = string.format("光之力：%d", curScore)
end

function LightKingMainView:_playEffect(url, parent, scale)
	local eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(parent:GetComponent(goutil.Type_RectTransform))
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end)

	table.insert(self._effs, eff)
end

function LightKingMainView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "items")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "recieve")

	MaterialMgr.setCellByCfg(cfg.gain, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.score

	local gained = LightKingModel.instance:isGainedById(cfg.id)

	received:SetActive(gained)

	local canGain = cfg.score <= LightKingModel.instance:getCurScore()

	if canGain and not gained then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"

		self:_playEffect(url, go, 0.61)
		btn.gameObject:SetActive(true)
		btn:AddClickListener(function()
			self:_onClickPrize(cfg)
		end)
	else
		btn.gameObject:SetActive(false)
	end
end

function LightKingMainView:_onClickStart(challengeType, locked)
	if LightKingModel.instance:getChallengeFinished(challengeType) then
		FloatWordMgr.instance:show("已通关")
	elseif locked then
		FloatWordMgr.instance:show("请先通过前两关挑战！")
	else
		LightKingModel.instance:setCurChallengeType(challengeType)
		UIStateManager.instance:push(ViewName.LightKingChallengeView)
	end
end

function LightKingMainView:_onClickJob()
	UIStateManager.instance:push(ViewName.LightKingCareerView)
end

function LightKingMainView:_onClickPrize(cfg)
	LightKingController.instance:sendGainPrize(cfg.id)
end

function LightKingMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LightKingRankView)
end

return LightKingMainView
