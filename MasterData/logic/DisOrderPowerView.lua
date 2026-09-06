-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/view/DisOrderPowerView.lua

module("logic.extensions.disorderpower.view.DisOrderPowerView", package.seeall)

local DisOrderPowerView = class("DisOrderPowerView", ViewComponent)

function DisOrderPowerView:ctor()
	DisOrderPowerView.super.ctor(self)
end

function DisOrderPowerView:unbindEvents()
	DisOrderPowerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnTask)
end

function DisOrderPowerView:bindEvents()
	DisOrderPowerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function DisOrderPowerView:buildUI()
	DisOrderPowerView.super.buildUI(self)

	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnTask = self:getGo("btnTask")
	self._redPointTask = self:getGo("btnTask/redpoint")
	self._btnLottery = self:getGo("btnLottery")
	self._txtLottery = self:getTxt("btnLottery/Text")
	self._txtCost = self:getTxt("txtCost")
	self._redpoint = self:getGo("btnLottery/redpoint")
	self._goldBarCon = self:getGo("goldBarCon")
	self._progressBar = self:getSlider("lotteryList/tableview/Viewport/Content/progressBar")
	self._txtLotteryNum = self:getTxt("lotteryNum/txt")
	self._tableview = self:getGo("lotteryList/tableview")
	self._cell = self:getGo("lotteryList/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._tableview = self:getGo("scrollview")
	self._cell = self:getGo("cell")
	self._scrollCardList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCardCell, self), GameUtil.handler(self._clearCardCell, self))
	self._roatatSequence = DG.Tweening.DOTween.Sequence()
end

function DisOrderPowerView:onExit()
	DisOrderPowerView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollCardList:dispose()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redPointTask)
	self._roatatSequence:Kill(true)
end

function DisOrderPowerView:onEnter()
	DisOrderPowerView.super.onEnter(self)
	self:_initAnimPre()
	self:_setTimeUI()
	self:_lotteryCost()
	self:_onUpdate()
	self:addGEvent(GlobalNotify.PM_DisorderPowerGetInfoRes, self._onUpdate)
	self:addGEvent(GlobalNotify.PM_DisorderPowerGainPrizeRes, self._onUpdate)
	self:addGEvent(GlobalNotify.PM_DisorderPowerLotteryRes, self._onLottery)
	self:addGEvent(GlobalNotify.ItemGetViewDoClosed, self._onItemGetViewClose)
	RedPointController.instance:regRedPoint(self._redPointTask, 654)
	DisOrderPowerController.instance:sendPM_DisorderPowerGetInfoReq(self._activityId)
end

function DisOrderPowerView:_initAnimPre()
	self._tarotIds = nil
	self._activityId = 422001
	self._activityCfg = DisOrderPowerConfig.instance:getActivityCfgById(self._activityId) or {}
	self._cardCfg = DisOrderPowerConfig.instance:getCardCfg(self._activityId)
	self._popShowId = 0
	self._canPlayAnim = false
	self._model = {}
end

function DisOrderPowerView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function DisOrderPowerView:_updateData()
	self._model = DisOrderPowerModel.instance:GetModel(self._activityId)
end

function DisOrderPowerView:_updateUI()
	if self._model.finishCardIds then
		local finishChallenge = #self._model.finishCardIds == #self._cardCfg

		self._txtLottery.text = finishChallenge and "已试炼完" or "试 炼"

		local matType, matId, costNum = MaterialMgr.getMatParams(self._activityCfg.trainingCost)
		local curCostNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		GameUtil.SetActive(self._redpoint, costNum <= curCostNum and not finishChallenge)
		self:_updateRewardView()
		self:_updateCardView()

		local popShowId = DisOrderPowerModel.instance:popItemStack()

		if popShowId ~= 0 then
			self._popShowId = popShowId

			local list = {}
			local cardStr = DisOrderPowerConfig.instance:GetItemStr(self._activityId, self._popShowId)
			local type, id, num = MaterialMgr.getMatParams(cardStr)

			if type == MatType.Item_Fake then
				local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, id, 1)

				table.insert(list, mo)
			end

			local obj = {}

			obj.items = list
			obj.ci = 0

			MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
			MaterialController.instance:checkAndOpenDisplay()
		end
	end
end

function DisOrderPowerView:_updateRewardView(msg)
	if not self._model.gainPrizeIds then
		if not self._model.finishCardIds then
			local finishCardIds = {}
			local list = DisOrderPowerConfig.instance:getProgressCfg(self._activityId)

			self._scrollList:reloadData(list)

			self._txtLotteryNum.text = "累计收集\n<color=#6bff6b>" .. #finishCardIds .. "</color>张龙卡牌"

			local scoreList = {}

			for i, v in ipairs(list) do
				table.insert(scoreList, v.progress)
			end

			self._scrollList:updateUnderSlider(self._progressBar, #finishCardIds, scoreList)
		end
	end
end

function DisOrderPowerView:_updateCardView()
	self._scrollCardList:reloadData(self._cardCfg)
end

function DisOrderPowerView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = false

	if not self._model.finishCardIds then
		local finishCardIds = {}
		local isCanGet = #finishCardIds >= data.progress

		if not self._model.gainPrizeIds then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false
			txtNum.text = data.progress

			MaterialMgr.setCellByCfg(data.prize, item)
			GameUtil.SetActive(geted, hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			self:_clearCellEffect(effect)

			if isCanGet and not hasGet then
				self:_playCellEffect(effect)
			end

			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
		end
	end
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function DisOrderPowerView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("lotteryList/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function DisOrderPowerView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function DisOrderPowerView:_onClickGetPrize(data)
	if not self._model.gainPrizeIds then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

		if not hasGet then
			if not self._model.finishCardIds then
				local finishCardIds = {}
				local isCanGet = #finishCardIds >= data.progress

				if isCanGet then
					DisOrderPowerController.instance:sendPM_DisorderPowerGainPrizeReq(self._activityId, data.prizeId)
				else
					TipsFacade.instance:openCommonTips("还没达到条件哦~")
				end
			end
		end
	end
end

function DisOrderPowerView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
end

function DisOrderPowerView:_updateCardCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local reward = goutil.findChild(cell, "reward")
	local rewardIcon = goutil.findChild(cell, "reward/icon")

	if self._model.finishCardIds then
		local canShowReward = table.indexof(self._model.finishCardIds, data.cardId)

		uGuiUtil.clearImage(reward.gameObject)
		GameUtil.SetActive(reward, canShowReward)
		GameUtil.SetActive(icon, not canShowReward)

		if canShowReward and data.cardId ~= self._popShowId then
			local cardRewardName = DisOrderPowerConfig.instance:GetCardRewardName(self._activityId, data.cardId)
			local path = string.format("ui/bigbg/pet/%s.png", cardRewardName)

			uGuiUtil.setSpriteToImage(rewardIcon, uGuiUtil.SpriteType.BigBg, path)
		elseif canShowReward and data.cardId == self._popShowId and self._canPlayAnim == true then
			local rotatTween = cell.gameObject.transform:DORotate(Vector3.New(0, 2880, 0), 3, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.InOutQuad):OnStart(function()
				local cardRewardName = data.rewardPath

				uGuiUtil.setSpriteToImage(rewardIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/pet/%s.png", cardRewardName))
				GameUtil.SetActive(rewardIcon, false)

				self._popShowId = 0
				self._canPlayAnim = false
			end):OnComplete(function()
				GameUtil.SetActive(rewardIcon, true)
				GameUtil.SetActive(reward, canShowReward)
				GameUtil.SetActive(icon, not canShowReward)
			end)

			self._roatatSequence:Append(rotatTween)
			self._roatatSequence:OnStart(function()
				self._scrollCardList:MoveCellToCenter(self._popShowId)
				ViewBlockMgr.instance:blockClick(true, self)
			end)
			self._roatatSequence:OnComplete(function()
				ViewBlockMgr.instance:blockClick(false, self)
			end)
		end

		GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCard, self, data), self)
	end
end

function DisOrderPowerView:_clearCardCell(cell)
	local rewardIcon = goutil.findChild(cell, "reward")

	uGuiUtil.clearImage(rewardIcon.gameObject)
	GameUtil.rmClickHandler(cell)
	cell:DOKill(true)
end

function DisOrderPowerView:_onClickCard(data)
	if not table.indexof(self._model.finishCardIds, data.cardId) then
		FloatWordMgr.instance:show("通关试炼获得")

		return
	end

	PetbookController.instance:openPetinfoView(data.raceId)
end

function DisOrderPowerView:_setTimeUI()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self._activityCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
end

function DisOrderPowerView:_onClickTip()
	local key = self._activityCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DisOrderPowerView:_onClickLottery()
	if self._model.finishCardIds and #self._model.finishCardIds == #self._cardCfg then
		FloatWordMgr.instance:show("已经全部试炼完成")

		return
	end

	local costStr = self._activityCfg.trainingCost
	local matType, matId, num = MaterialMgr.getMatParams(costStr)
	local curNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if curNum < num then
		FloatWordMgr.instance:show("代币数量不足，请先获取代币")

		return
	end

	DisOrderPowerController.instance:sendPM_DisorderPowerLotteryReq(self._activityId)
end

function DisOrderPowerView:_onItemGetViewClose()
	self._canPlayAnim = true

	self._scrollCardList:reloadData(self._cardCfg)
end

function DisOrderPowerView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.DisOrderPowerTaskView, self._activityId)
end

function DisOrderPowerView:_onLottery()
	UIStateManager.instance:push(ViewName.DisOrderPowerLotteryView, self._activityId)
end

function DisOrderPowerView:_lotteryCost()
	local costStr = self._activityCfg.trainingCost
	local objList = {}
	local matType, matId, num = MaterialMgr.getMatParams(costStr)
	local matName = MaterialMgr.getMaterialsNameByCfg(costStr)
	local content = "每次消耗：" .. num .. "个" .. matName
	local obj = {
		showAdd = false,
		id = costStr
	}

	table.insert(objList, obj)

	self._txtCost.text = content

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

return DisOrderPowerView
