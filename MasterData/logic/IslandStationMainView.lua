-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationMainView.lua

module("logic.extensions.islandstation.view.IslandStationMainView", package.seeall)

local IslandStationMainView = class("IslandStationMainView", ViewComponent)

function IslandStationMainView:ctor()
	IslandStationMainView.super.ctor(self)
end

function IslandStationMainView:unbindEvents()
	IslandStationMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReviewPlot)
	GameUtil.rmClickHandler(self._btnGetMaterial)
	GameUtil.rmClickHandler(self._btnMakeFood)
	GameUtil.rmClickHandler(self._btnStore)
	GameUtil.rmClickHandler(self._btnFoodBook)
	GameUtil.rmClickHandler(self._btnPreview)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnChange2)
end

function IslandStationMainView:bindEvents()
	IslandStationMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReviewPlot, self._onClickBtnReviewPlot, self)
	GameUtil.addClickHandler(self._btnGetMaterial, self._onClickBtnGetMaterial, self)
	GameUtil.addClickHandler(self._btnMakeFood, self._onClickBtnMakeFood, self)
	GameUtil.addClickHandler(self._btnStore, self._onClickBtnStore, self)
	GameUtil.addClickHandler(self._btnFoodBook, self._onClickBtnFoodBook, self)
	GameUtil.addClickHandler(self._btnPreview, self._onClickBtnPreview, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnChange, GameUtil.handler(self._onClickStore, self, 1))
	GameUtil.addClickHandler(self._btnChange2, GameUtil.handler(self._onClickStore, self, 2))
end

function IslandStationMainView:buildUI()
	IslandStationMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTime = self:getTxt("bg/time/txt")
	self._btnReviewPlot = self:getGo("btnReviewPlot")
	self._btnGetMaterial = self:getGo("btnGetMaterial")
	self._btnMakeFood = self:getGo("btnMakeFood")
	self._btnStore = self:getGo("btnStore")
	self._btnFoodBook = self:getGo("btnFoodBook")
	self._btnPreview = self:getGo("btnPreview")
	self._item = self:getGo("bubble/item")
	self._girlBubble = self:getGo("girlBubble")
	self._txtBubbleWord = self:getTxt("girlBubble/txtWord")
	self._girl = self:getGo("girl")
	self._girlRoot = self:getGo("girlRoot")
	self._girls = self:getGo("girls")
	self._txtUnLock = self:getTxt("tip/txtUnLock")
	self._txtTotal = self:getTxt("tip/txtTotal")
	self._txtLevel = self:getTxt("tip/txtLevel")
	self._txtLevelTip = self:getTxt("tip/txtLevelTip")
	self._btnReward = self:getGo("bubble/btnReward")
	self._eff = self:getGo("bubble/eff")
	self._getedReward = self:getGo("bubble/geted")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._storetab = self:getGo("storetab")
	self._btnChange = self:getGo("storetab/btnChange")
	self._storetab2 = self:getGo("storetab2")
	self._btnChange2 = self:getGo("storetab2/btnChange")
end

function IslandStationMainView:onExit()
	IslandStationMainView.super.onExit(self)
	self._scrollList:dispose()

	for con, loader in pairs(self._loaderDic) do
		self:_resetRoleModel(con)
	end

	self._loaderDic = nil

	for shopId, girlList in pairs(self._girlDic) do
		for i, girl in pairs(girlList) do
			GameUtil.rmClickHandler(girl.btnChat)
		end
	end

	removetimer(self._showGirlBubble, self)

	for i, tickFunc in ipairs(self._tickFuncList) do
		removetimer(tickFunc, self)
	end

	self._tickFuncList = nil

	for i, girlRootGo in ipairs(self._girlRootGoDic) do
		goutil.destroy(girlRootGo.gameObject)
	end

	self._girlRootGoDic = nil

	MaterialMgr.resetAll(self._item)
	self:stopViewEffectUniGo(self._eff)
end

function IslandStationMainView:onEnter()
	IslandStationMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationPutOrChangeFoodRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.IslandStationGirlAddFetter, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationOneKeyFullFillRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationGainCollectSkinPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.IslandStationGirlChatViewClose, self._onGirlChatViewClose, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 487001
	end

	self._curShopId = 1
	self._curShowGrilBubbleIdx = 1
	self._actCfg = IslandStationConfig.instance:getActCfg(self._activityId)
	self._girlCfg = IslandStationConfig.instance:getGirlCfg(self._activityId)
	self._shopFoodCfg = IslandStationConfig.instance:getFoodCfgByShopId(self._activityId, self._curShopId)
	self._shopCfgs = IslandStationConfig.instance:getShopCfg(self._activityId)
	self._girlDic = {}
	self._girlRootGoDic = {}
	self._loaderDic = {}
	self._grilClickHandlers = {}
	self._storeTabList = {
		self._storetab,
		self._storetab2
	}

	self:_onSetUI()
	self:setTickTimmer()
	IslandStationController.instance:sendPM_IslandStationInfoReq(self._activityId)

	local firstStoryCfgs = IslandStationConfig.instance:getStoryCfgByGroupId(self._activityId, 1)
	local firstStoryCfg = firstStoryCfgs[1]
	local storyId = firstStoryCfg.storyId

	if checknumber(storyId) > 0 then
		local key = string.format("IslandStationMainView%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end
end

function IslandStationMainView:_onSetUI()
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_initGirl()
	self:_showGirlBubble()
	settimer(5, self._showGirlBubble, self)
	MaterialMgr.setCellByCfg(self._actCfg.collectSkinPrize, self._item)
end

function IslandStationMainView:setTickTimmer()
	self._tickFuncList = {}
end

function IslandStationMainView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function IslandStationMainView:_updateData()
	self._info = IslandStationModel.instance:getInfo(self._activityId)
	self._grilInfo = IslandStationModel.instance:getGrilInfo(self._activityId)

	local shopInfos = IslandStationModel.instance:getShopInfo(self._activityId)

	self._curShopInfo = shopInfos[self._curShopId]
	self._curShopLv = IslandStationConfig.instance:getShopLevel(self._activityId, self._curShopId, self._curShopInfo.profit)
	self._unLockShelfNum = IslandStationController.instance:getUnLockShelfNum(self._activityId, self._curShopId, self._curShopLv)
	self._soldNumList = {}
end

function IslandStationMainView:_updateUI()
	local curShopFoodCfg = IslandStationConfig.instance:getFoodCfgByShopId(self._activityId, self._curShopId)
	local curUnlockCookBookNum = IslandStationController.instance:getUnlockFoodBookNum(self._activityId, self._curShopId)

	self._txtUnLock.text = string.format("已解锁食谱：%d/%d", curUnlockCookBookNum, #curShopFoodCfg)
	self._txtLevel.text = string.format("小店等级%d", self._curShopLv)
	self._txtTotal.text = string.format("小店总收益：%d", self._curShopInfo.profit)
	self._txtLevelTip.text = self:_getNextLvDesc()

	local girlList = self._girlDic[self._curShopId]

	for i, girl in ipairs(girlList) do
		local girlId = girl.girlId
		local girlInfo = self._grilInfo[girlId]
		local grilCfg = IslandStationConfig.instance:getGirlCfgByGirlId(self._activityId, girlId)

		girl.txtFetter.text = girlInfo and string.format("%d/%d", girlInfo.fetter, grilCfg.maxFetter) or string.format("%d/%d", 0, grilCfg.maxFetter)
	end

	local shopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, self._curShopId)
	local shopLvPlanId = shopCfg.shopLvPlanId
	local shopShelfs = {}
	local shelfNum = IslandStationConfig.instance:getShelfNum(shopLvPlanId)

	for i = 1, shelfNum do
		table.insert(shopShelfs, i)
	end

	self._scrollList:reloadData(shopShelfs)
	self:_updateStoreTabUI()
	self:_changeShowGirl()

	local firstGirlCfg = IslandStationConfig.instance:getGirlCfgByGirlId(self._activityId, 1)
	local list = PetSkinConfig.instance:getPosterList(firstGirlCfg.collectSkinId)
	local posterCfg = list[1]
	local posterId = posterCfg.posterId
	local cfg = PetSkinConfig.instance:getPosterModelCo(posterId)
	local isHas = PetskinController.instance:getPosterActive(cfg)

	if self._info then
		if not self._info.gainCollectSkinPrize then
			local hasGainCollectSkinPrize = false

			self:stopViewEffectUniGo(self._eff)

			if isHas and not hasGainCollectSkinPrize then
				local eff = self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", self._eff, self.mainGO.transform, true, nil, nil)
			end

			GameUtil.SetActive(self._btnReward, isHas and not hasGainCollectSkinPrize)
			GameUtil.SetActive(self._getedReward, hasGainCollectSkinPrize)
		end
	end
end

function IslandStationMainView:_updateShopScroll()
	local list = self._scrollList:getData()

	if list then
		for i, v in ipairs(list) do
			self._scrollList:updateCellInViewByIndex(i - 1)
		end
	end
end

function IslandStationMainView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "sell/item")
	local lock = goutil.findChild(cell, "lock")
	local imgAdd = goutil.findChild(cell, "imgAdd")
	local imgBg2 = goutil.findChild(cell, "sell/imgBg2")
	local sell = goutil.findChild(cell, "sell")
	local btnClick = goutil.findChild(cell, "btnClick")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtPrice = goutil.findChildTextComponent(cell, "sell/txtPrice")
	local txtNum = goutil.findChildTextComponent(cell, "sell/txtNum")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
	local shelfInfo = IslandStationModel.instance:getShelfInfo(self._activityId, self._curShopId, data)

	if shelfInfo then
		if not shelfInfo.foodId then
			local foodId = 0
			local shopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, self._curShopId)
			local shopLvCfg = IslandStationConfig.instance:getShopLevelCfg(shopCfg.shopLvPlanId)
			local curLevel = IslandStationConfig.instance:getNextUnlockShelfLevel(shopCfg.shopLvPlanId, data)
			local isLock = data > self._unLockShelfNum
			local isEmpty = foodId == 0

			if not isEmpty then
				local shopNextLvCfg = IslandStationConfig.instance:getShopLevelCfgByLevel(shopCfg.shopLvPlanId, self._curShopLv + 1)
				local foodCfg = IslandStationConfig.instance:getFoodCfgByFoodId(self._activityId, foodId)
				local matType, matId, matNum = MaterialMgr.getMatParams(foodCfg.materialStr)
				local nowMs = ServerTime.nowMs()
				local leftSec = Mathf.Max(nowMs - checknumber(shelfInfo.lastRefreshTime), 0) / 1000

				txtPrice.text = string.format("%d奥币/份", foodCfg.price)

				local isCommonFood = IslandStationConfig.instance:isCommonFood(self._activityId, foodId)

				if not isCommonFood then
					txtNum.text = string.format("剩余：%d/%d", shelfInfo.leftNum, shopCfg.shelfPosMaxFoodCount)
				end

				GameUtil.SetActive(imgBg2, not isCommonFood)
				GameUtil.SetActive(txtNum.gameObject, not isCommonFood)
				MaterialMgr.setIcon(item, matType, matId, nil, nil)
			end

			if isLock then
				txtLock.text = string.format("店铺%d级解锁", curLevel)
			end

			GameUtil.SetActive(lock, isLock)
			GameUtil.SetActive(imgAdd, isEmpty and not isLock)
			GameUtil.SetActive(sell, not isEmpty)
			GameUtil.addClickHandler(btnClick, function()
				if isLock then
					FloatWordMgr.instance:show(string.format("该商品栏将在店铺达到%d级后解锁", curLevel))

					return
				end

				if not isLock then
					UIStateManager.instance:push(ViewName.IslandStationFillShopView, self._activityId, self._curShopId)

					return
				end
			end, self)
		end
	end
end

function IslandStationMainView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnClick = goutil.findChild(cell, "btnClick")

	MaterialMgr.clearIcon(item)
	GameUtil.rmClickHandler(btnClick)
end

function IslandStationMainView:_onClickStore(idx)
	local isLock = self:_isLock(idx)

	if isLock then
		local curShopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, idx)
		local timeArr = string.split(curShopCfg.startTime, "T")

		FloatWordMgr.instance:show(string.format("该店铺于%s %s后解锁", timeArr[1], timeArr[2]))

		return
	end

	self._curShopId = idx

	self:_onUpdate()
	removetimer(self._showGirlBubble, self)
	self:_showGirlBubble()
	settimer(5, self._showGirlBubble, self)
end

function IslandStationMainView:_updateStoreTabUI()
	for i, storeTabGo in ipairs(self._storeTabList) do
		local txtName = goutil.findChildTextComponent(storeTabGo, "txtName")
		local imgLock = goutil.findChild(storeTabGo, "imgLock")
		local changeGroupComp = storeTabGo:GetComponent(ComponentType.UIChangeGroup)
		local curShopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, i)
		local isLock = self:_isLock(i)

		txtName.text = curShopCfg.shopName

		changeGroupComp:SetState(self._curShopId == i and 0 or 1)
		GameUtil.SetActive(imgLock, isLock)
	end
end

function IslandStationMainView:_isLock(shopId)
	local curShopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, shopId)
	local startTimeStr = curShopCfg.startTime
	local timeStamp = GameUtil.string2time(startTimeStr)

	return timeStamp > ServerTime.now()
end

function IslandStationMainView:_showRoleModel(skinId, con)
	local curFaceId = skinId
	local offset = CharactorFacade.instance:getFormationModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel(con)

	local loader

	loader = RoleObjectPool.instance:addRoleToParent(loader, curFaceId, con, scale, nil, false, x, y)

	return loader
end

function IslandStationMainView:_resetRoleModel(con)
	local loader = self._loaderDic[con]

	loader = RoleObjectPool.instance:removeRole(loader)
end

function IslandStationMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function IslandStationMainView:_onClickBtnReviewPlot()
	UIStateManager.instance:push(ViewName.IslandStationPlotView, self._activityId)
end

function IslandStationMainView:_onClickBtnGetMaterial()
	UIStateManager.instance:push(ViewName.IslandStationGetMaterialView, self._activityId)
end

function IslandStationMainView:_onClickBtnMakeFood()
	UIStateManager.instance:push(ViewName.IslandStationMakeFoodView, self._activityId, self._curShopId)
end

function IslandStationMainView:_onClickBtnStore()
	GotoMgr.gotoByString("func#191#487#487001")
end

function IslandStationMainView:_onClickBtnFoodBook()
	UIStateManager.instance:push(ViewName.IslandStationFoodBookView, self._activityId)
end

function IslandStationMainView:_onClickBtnPreview()
	if self._actCfg then
		local skinId = self._actCfg.skinId
		local list = PetSkinConfig.instance:getPosterList(skinId)
		local posterList = {}

		table.insert(posterList, 1034)

		local posterCfg = PetskinController.instance:getPosterCfg(skinId)

		UIStateManager.instance:push(ViewName.PetskinposterView, posterList[1], posterList, skinId)
	end
end

function IslandStationMainView:_onClickBtnReward()
	local firstGirlCfg = IslandStationConfig.instance:getGirlCfgByGirlId(self._activityId, 1)
	local list = PetSkinConfig.instance:getPosterList(firstGirlCfg.collectSkinId)
	local posterCfg = list[1]
	local posterId = posterCfg.posterId
	local cfg = PetSkinConfig.instance:getPosterModelCo(posterId)
	local isHasPoster = PetskinController.instance:getPosterActive(cfg)

	if isHasPoster then
		IslandStationController.instance:sendPM_IslandStationGainCollectSkinPrizeReq(self._activityId)
	else
		FloatWordMgr.instance:show("尚未收集全海报")

		return
	end
end

function IslandStationMainView:_onClickBtnGril(girlId)
	UIStateManager.instance:push(ViewName.IslandStationChatView, self._activityId, girlId)
end

function IslandStationMainView:_showGirlBubble()
	local preGrilBubbleIdx = self._curShowGrilBubbleIdx
	local leftNum, rightNum = IslandStationConfig.instance:getGirlShopAreaNum(self._activityId, self._curShopId)

	self._curShowGrilBubbleIdx = math.random(leftNum, rightNum)

	while preGrilBubbleIdx == self._curShowGrilBubbleIdx do
		self._curShowGrilBubbleIdx = math.random(leftNum, rightNum)
	end

	local curGrilCfg = self._girlCfg[self._curShowGrilBubbleIdx]
	local bubbleWordCfg = IslandStationConfig.instance:getWordsCfgByBubbleId(self._activityId, self._curShowGrilBubbleIdx)
	local bubblePos = curGrilCfg.bubblePos

	self._txtBubbleWord.text = bubbleWordCfg.bubbleWord

	GameUtil.setLocalPos(self._girlBubble, bubblePos[1], bubblePos[2], 0)
end

function IslandStationMainView:_getNextLvDesc()
	local curShopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, self._curShopId)
	local shopLvPlanId = curShopCfg.shopLvPlanId
	local shopNextLvCfg = IslandStationConfig.instance:getShopLevelCfgByLevel(shopLvPlanId, self._curShopLv + 1)

	if shopNextLvCfg then
		return string.format("达到%d升至%d级", shopNextLvCfg.progress, shopNextLvCfg.level)
	else
		return "已升至满级"
	end
end

function IslandStationMainView:_initGirl()
	for shopId, v in ipairs(self._shopCfgs) do
		local girlCfgList = IslandStationConfig.instance:getGirlCfgsByShopId(self._activityId, shopId)
		local girlList = {}
		local curGirlRootGo = goutil.cloneAndSetParent(self._girlRoot, self._girls.transform, "girlRoot" .. shopId)

		self._girlRootGoDic[shopId] = curGirlRootGo

		for i, cfg in ipairs(girlCfgList) do
			local curGirl = {}
			local girlId = cfg.girlId
			local cell = goutil.cloneAndSetParent(self._girl, curGirlRootGo.transform, "girl" .. girlId)
			local btnChat = goutil.findChild(cell, "btnChat")
			local con = goutil.findChild(cell, "con")
			local txtFetter = goutil.findChildTextComponent(cell, "fetter/txtFetter")

			curGirl.girlId = girlId
			curGirl.con = con
			curGirl.loader = self:_showRoleModel(cfg.collectSkinId, con)
			curGirl.btnChat = btnChat
			curGirl.txtFetter = txtFetter
			self._loaderDic[con] = curGirl.loader

			GameUtil.addClickHandler(btnChat, GameUtil.handler(self._onClickBtnGril, self, girlId), self)
			GameUtil.setLocalPos(cell, cfg.posAndScale[1], cfg.posAndScale[2], 0)
			GameUtil.setLocalScale(cell, cfg.posAndScale[3], cfg.posAndScale[3], cfg.posAndScale[3])
			GameUtil.SetActive(cell, true)
			table.insert(girlList, curGirl)
		end

		self._girlDic[shopId] = girlList
	end

	GameUtil.SetActive(self._girl, false)
end

function IslandStationMainView:_changeShowGirl()
	for shopId, v in ipairs(self._shopCfgs) do
		local curRootGo = self._girlRootGoDic[shopId]

		GameUtil.SetActive(curRootGo, shopId == self._curShopId)
	end
end

function IslandStationMainView:_onGirlChatViewClose()
	IslandStationController.instance:tryPlayEndStory(self._activityId)
end

return IslandStationMainView
