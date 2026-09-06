-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/NewYearCollectMainView.lua

module("logic.extensions.birthdaywishes.view.NewYearCollectMainView", package.seeall)

local NewYearCollectMainView = class("NewYearCollectMainView", ViewComponent)
local NEW_YEAR_BIG_PRIZEID = 5

function NewYearCollectMainView:buildUI()
	NewYearCollectMainView.super.buildUI(self)

	self._word = self:getGo("collectword/word")
	self._wordRowList = {}

	for i = 1, 4 do
		local cellList = {}
		local row = goutil.findChild(self._word, "row" .. i)

		for i = 1, 4 do
			local cur = {}
			local curCell = goutil.findChild(row, "cell" .. i)
			local bg = goutil.findChild(curCell, "bg")

			cur.bgChange = bg:GetComponent(ComponentType.UIImageSpriteChange)
			cur.numBgChange = goutil.findChild(curCell, "num/bg"):GetComponent(ComponentType.UIImageSpriteChange)
			cur.txtZeroGo = goutil.findChild(curCell, "num/bg/txtZero")
			cur.txtNumGo = goutil.findChild(curCell, "num/bg/txtNum")
			cur.txtNum = goutil.findChildTextComponent(curCell, "num/bg/txtNum")
			cur.txtWord = goutil.findChildTextComponent(curCell, "txtWord")
			cur.txtWordColorChange = cur.txtWord:GetComponent(ComponentType.UITextColorChange)

			table.insert(cellList, cur)
		end

		table.insert(self._wordRowList, cellList)
	end

	self._reward = self:getGo("collectword/reward")
	self._rewardList = {}

	for i = 1, 4 do
		local cur = {}
		local curCell = goutil.findChild(self._reward, "rewardcell" .. i)

		cur.item = goutil.findChild(curCell, "item")
		cur.getPrize = goutil.findChild(curCell, "getPrize")
		cur.root = goutil.findChild(curCell, "root")
		cur.clipRect = curCell.gameObject:GetComponent(goutil.Type_RectTransform)
		cur.gainPrize = goutil.findChild(curCell, "gainPrize")

		table.insert(self._rewardList, cur)
	end

	self._txtProgress = self:getTxt("progressReward/total/txtProgress")
	self._tableview = self:getGo("progressReward/tableview")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._root = self:getGo("bigPrize/root")
	self._gainPrize = self:getGo("bigPrize/conMask/gainPrize")
	self._itemBigPrize = self:getGo("bigPrize/item")
	self._getPrize = self:getGo("bigPrize/getPrize")
	self._txtBigPrizeNum = self:getTxt("bigPrize/conMask/txtNum")
	self._btnCostWish = self:getGo("btnCostWish")
	self._wishCostCon = self:getGo("btnCostWish/exchangeBubble/txt/item")
	self._txtWishMatNum = self:getTxt("btnCostWish/exchangeBubble/txt")
	self._btnGetMat = self:getGo("btnGetMat")
	self._btnGoto = self:getGo("btnGoto")
	self._btnPet = self:getGo("btnPet")
	self._conPet = self:getGo("btnPet/conMask/con")
	self._txtPetWord = self:getTxt("btnWord/bg/scrollview/Viewport/Content")
	self._btnWord = self:getGo("btnWord/bg/Image/reset")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._clipRect = self:getGo("progressReward/tableview/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._btnTip = self:getGo("leftTop/btnTip")
	self._redPoint = self:getGo("btnGetMat/redPoint")
end

function NewYearCollectMainView:bindEvents()
	NewYearCollectMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCostWish, self._onClickBtnWish, self)
	GameUtil.addClickHandler(self._btnGetMat, self._onClickBtnGetMat, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickBtnGoto, self)
	GameUtil.addClickHandler(self._btnPet, self._onClickBtnPet, self)
	GameUtil.addClickHandler(self._btnWord, self._onClickBtnWord, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._itemBigPrize, self._onClickItemBigPrize, self)
	GameUtil.addClickHandler(self._getPrize, self._onClickeBtnBigPrize, self)
end

function NewYearCollectMainView:unbindEvents()
	NewYearCollectMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCostWish)
	GameUtil.rmClickHandler(self._btnGetMat)
	GameUtil.rmClickHandler(self._btnGoto)
	GameUtil.rmClickHandler(self._btnPet)
	GameUtil.rmClickHandler(self._btnWord)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._itemBigPrize)
	GameUtil.rmClickHandler(self._getPrize)
end

function NewYearCollectMainView:onEnter()
	NewYearCollectMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.UpdataBirthdayWishesInfo, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_BirthadyWishesGainCollectPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_BirthadyWishesGainGivePrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.ItemGetViewDoClosed, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = BirthdayWishesController.instance:getActivityId()
	end

	BirthdayWishesModel.instance:setActivityId(self._activityId)

	self._activityType = BirthdayWishesController.instance:getActivityType()

	local isInTime = BirthdayWishesController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		printError("不在活动时间内")
	end

	self._effWordList = {}
	self._effRewardList = {}
	self._wishesPlanId = BirthdayWishesConfig.instance:getWishesTextPlan(self._activityId)
	self._curWishTextId = GameUtil.getUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY) or 1

	if self._curWishTextId <= 0 then
		self._curWishTextId = 1
	end

	local textPlanDatas = BirthdayWishesConfig.instance:getBirthdayWishesTextPlanCfgs(self._wishesPlanId)

	self._petData = textPlanDatas and textPlanDatas[self._curWishTextId]
	self._actData = BirthdayWishesConfig.instance:getActData(self._activityId)
	self._bigPrizeMatStr = BirthdayWishesConfig.instance:getCollectPrize(self._activityId, NEW_YEAR_BIG_PRIZEID)

	RedPointController.instance:regRedPoint(self._redPoint, 447)
	BirthdayWishesController.instance:csGetBirthdayWishesUserInfoReq(self._activityId)
	self:_onSetUI()
end

function NewYearCollectMainView:onExit()
	NewYearCollectMainView.super.onExit(self)
	self:clearWords()

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self.eff = nil
	end

	MaterialMgr.clearIcon(self._wishCostCon)
	GameUtil.saveUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY, self._curWishTextId)
	RedPointController.instance:unregRedPoint(self._redPoint)
	self._scrollList:dispose()
end

function NewYearCollectMainView:_onSetUI()
	return
end

function NewYearCollectMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function NewYearCollectMainView:_onUpdateData()
	self._curWishTextId = GameUtil.getUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY) or 1

	if self._curWishTextId <= 0 then
		self._curWishTextId = 1
	end

	local textPlanDatas = BirthdayWishesConfig.instance:getBirthdayWishesTextPlanCfgs(self._wishesPlanId)

	self._petData = textPlanDatas and textPlanDatas[self._curWishTextId]
end

function NewYearCollectMainView:_onUpdateUI()
	local canGetBigPrize = BirthdayWishesController.instance:canGetPrize(self._activityId, NEW_YEAR_BIG_PRIZEID)
	local hasGainBigPrize = BirthdayWishesController.instance:hasGainPrize(self._activityId, NEW_YEAR_BIG_PRIZEID)

	if self._actData then
		if not self._actData.costStr then
			local matCostStr = "8:1:1"
			local matBigType, matBigId, matBigNum = MaterialMgr.getMatParams(self._bigPrizeMatStr)
			local arr = string.split(matCostStr, ":")

			MaterialMgr.setIcon(self._wishCostCon, arr[1], arr[2])

			local hasWishMatNum = MaterialModel.instance:getMaterialsNumber(arr[1], arr[2])
			local progressList = BirthdayWishesConfig.instance:getWishGivePrizeData(self._activityId)
			local sendWordsList = BirthdayWishesModel.instance:getWordsList(self._activityId)
			local givePrizes = BirthdayWishesConfig.instance:getGivePrizes(self._activityId)
			local model = BirthdayWishesModel.instance:GetModel(self._activityId)

			GameUtil.SetActive(self._getPrize, canGetBigPrize and not hasGainBigPrize)
			GameUtil.SetActive(self._gainPrize, hasGainBigPrize)
			MaterialMgr.setIcon(self._itemBigPrize, matBigType, matBigId)

			self._txtBigPrizeNum.text = matBigNum

			UIEffectManager.instance:stopEffect(self._eff)

			self.eff = nil

			if canGetBigPrize and not hasGainBigPrize then
				local function loadHandler(target, eff)
					eff.effGo.transform:SetParent(self._root.transform)
					GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
					GameUtil.setLocalScale(eff.effGo.transform, 1.2, 1.2, 1.2)
					eff:setClipping(self.mainGO:GetComponent(goutil.Type_RectTransform))
				end

				self._eff = UIEffectManager.instance:playEffect(self, "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab", self._root.transform, 0, 0, true, false, nil, loadHandler)
			end

			self._txtWishMatNum.text = hasWishMatNum .. "/" .. arr[3]
			self._txtProgress.text = #sendWordsList .. "个"

			self._scrollList:updateUnderSlider(self._progressBar, #sendWordsList, givePrizes)
			self._scrollList:reloadData(progressList)
			self:updatePetUI()
			self:updateWords()
		end
	end
end

function NewYearCollectMainView:updatePetUI()
	if not self._petData.raceId then
		local raceId = -1
		local modelCo = CharacterConfig.instance:getModelCo(raceId)

		if modelCo then
			if not modelCo.headName then
				local petIconName = ""
				local wordStr = self._petData.desc

				uGuiUtil.clearImage(self._conPet.gameObject)
				uGuiUtil.setSpriteToImage(self._conPet.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petIconName))

				self._txtPetWord.text = wordStr
			end
		end
	end
end

function NewYearCollectMainView:updateWords()
	local wishListPlanId = BirthdayWishesConfig.instance:getWishListPlanId(self._activityId)

	for i, cellList in ipairs(self._wordRowList) do
		for j, cell in ipairs(cellList) do
			local data = BirthdayWishesConfig.instance:getWishListDataById(wishListPlanId, (i - 1) * 4 + j)
			local tokenId = data.tokenId
			local tokenStr = BirthdayWishesConfig.instance:getTokenMatStr(tokenId) or ""
			local matType, matId, matNum = MaterialMgr.getMatParams(tokenStr)
			local curHasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
			local wordStr = data.wishListName

			GameUtil.SetActive(cell.txtZeroGo, curHasNum <= 0)
			GameUtil.SetActive(cell.txtNumGo, curHasNum > 0)

			cell.txtNum.text = curHasNum
			cell.txtWord.text = wordStr

			cell.bgChange:SetState(curHasNum > 0 and 0 or 1)
			cell.numBgChange:SetState(curHasNum > 0 and 0 or 1)
			cell.txtWordColorChange:SetState(curHasNum > 0 and 1 or 0)
		end
	end

	for i, cell in ipairs(self._rewardList) do
		local canGetPrize = BirthdayWishesController.instance:canGetPrize(self._activityId, i)
		local hasGainPrize = BirthdayWishesController.instance:hasGainPrize(self._activityId, i)
		local matStr = BirthdayWishesConfig.instance:getCollectPrize(self._activityId, i)

		GameUtil.SetActive(cell.gainPrize, hasGainPrize)
		GameUtil.SetActive(cell.getPrize, canGetPrize and not hasGainPrize)
		MaterialMgr.setCellByCfg(matStr, cell.item)

		if self._effWordList[cell.root] then
			UIEffectManager.instance:stopEffect(self._effWordList[cell.root])

			self._effWordList[cell.root] = nil
		end

		if canGetPrize and not hasGainPrize then
			local function loadHandler(target, eff)
				eff.effGo.transform:SetParent(cell.root.transform)
				GameUtil.setLocalPos(eff.effGo, 0, 0, 0)
				GameUtil.setLocalScale(eff.effGo, 1, 1, 1)

				if cell.clipRect then
					eff:setClipping(cell.clipRect)
				end
			end

			self._effWordList[cell.root] = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.root.transform, 0, 0, true, false, nil, loadHandler)
		end

		GameUtil.addClickHandler(cell.getPrize.gameObject, function()
			if not canGetPrize then
				FloatWordMgr.instance:show("未满足领取要求")

				return
			end

			if hasGainPrize then
				FloatWordMgr.instance:show("已领取过，无法再次领取")

				return
			end

			BirthdayWishesController.instance:sendPM_BirthadyWishesGainCollectPrizeReq(self._activityId, i)
		end)
	end
end

function NewYearCollectMainView:clearWords()
	for effGo, eff in pairs(self._effWordList) do
		UIEffectManager.instance:stopEffect(eff)

		self._effWordList[effGo] = nil
	end

	for i, cell in ipairs(self._rewardList) do
		MaterialMgr.resetAll(cell.item)
		GameUtil.rmClickHandler(cell.getPrize)
	end
end

function NewYearCollectMainView:_updateRewardCell(view, cell, data)
	local matStr = data.prize
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
	local canGet = BirthdayWishesController.instance:canGetWishGivePrize(self._activityId, data.prizeId)
	local hasReceive = BirthdayWishesController.instance:hasGainWishGivePrize(self._activityId, data.prizeId)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local clipRect = cell.gameObject:GetComponent(goutil.Type_RectTransform)

	txtScore.text = data.times

	GameUtil.SetActive(btnGet, canGet and not hasReceive)
	GameUtil.SetActive(received, canGet and hasReceive)
	MaterialMgr.setCellByCfg(matStr, item)

	if self._effRewardList[effect] then
		UIEffectManager.instance:stopEffect(self._effRewardList[effect])

		self._effRewardList[effect] = nil
	end

	if canGet and not hasReceive then
		local function loadHandler(target, eff)
			eff.effGo.transform:SetParent(effect.transform)
			GameUtil.setLocalPos(eff.effGo, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo, 1, 1, 1)

			if self._clipRect then
				eff:setClipping(self._clipRect)
			end
		end

		self._effRewardList[effect] = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effect.transform, 0, 0, true, false, nil, loadHandler)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickBtnGet, self, data), self)
end

function NewYearCollectMainView:_onClickBtnGet(data)
	local canGet = BirthdayWishesController.instance:canGetWishGivePrize(self._activityId, data.prizeId)
	local hasReceive = BirthdayWishesController.instance:hasGainWishGivePrize(self._activityId, data.prizeId)

	if canGet and not hasReceive then
		BirthdayWishesController.instance:sendPM_BirthadyWishesGainGivePrizeReq(self._activityId, data.prizeId)
	end
end

function NewYearCollectMainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)

	if self._effRewardList and self._effRewardList[effect] then
		UIEffectManager.instance:stopEffect(self._effRewardList[effect])

		self._effRewardList[effect] = nil
	end
end

function NewYearCollectMainView:_onClickeBtnBigPrize()
	local canGetBigPrize = BirthdayWishesController.instance:canGetPrize(self._activityId, NEW_YEAR_BIG_PRIZEID)
	local hasGainBigPrize = BirthdayWishesController.instance:hasGainPrize(self._activityId, NEW_YEAR_BIG_PRIZEID)

	if not canGetBigPrize then
		FloatWordMgr.instance:show("尚未达到领取条件")

		return
	end

	if hasGainBigPrize then
		FloatWordMgr.instance:show("已获得奖励，无法再次领取")

		return
	end

	BirthdayWishesController:sendPM_BirthadyWishesGainCollectPrizeReq(self._activityId, NEW_YEAR_BIG_PRIZEID)
end

function NewYearCollectMainView:_onClickBtnWish()
	if self._actData then
		if not self._actData.costStr then
			local matCostStr = "8:1:1"
			local matType, matId, matNum = MaterialMgr.getMatParams(matCostStr)
			local needCostNum = matNum
			local matName = MaterialMgr.getMaterialsNameByCfg(matCostStr)
			local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if hasNum < needCostNum then
				FloatWordMgr.instance:show(matName .. "不足，点击\"完成任务\"或\"换字大厅\"看看吧")

				return
			end

			MaterialFacade.instance:useItem(matType, matId, needCostNum, nil, nil, MaterialController.CI_SHOW_TYPE_FLY)
			UIStateManager.instance:push(ViewName.NewYearFlyWishView, self._activityId, self._wishesPlanId, self._curWishTextId)
		end
	end
end

function NewYearCollectMainView:_onClickBtnGetMat()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function NewYearCollectMainView:_onClickBtnGoto()
	UIStateManager.instance:push(ViewName.CollectBlessingGiveView, self._activityId)
end

function NewYearCollectMainView:_onClickBtnPet()
	UIStateManager.instance:push(ViewName.NewYearCollectSelectView, self._activityId, self._wishesPlanId, self._curWishTextId)
end

function NewYearCollectMainView:_onClickBtnWord()
	UIStateManager.instance:push(ViewName.NewYearCollectView, self._activityId, self._wishesPlanId, self._curWishTextId)
end

function NewYearCollectMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("newyearcollect_rule")
end

function NewYearCollectMainView:_onClickItemBigPrize()
	TipsFacade.instance:openItemSourceView(self._bigPrizeMatStr)
end

return NewYearCollectMainView
