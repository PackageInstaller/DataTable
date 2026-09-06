-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/view/SeekFoodMainView.lua

module("logic.extensions.seekfood.view.SeekFoodMainView", package.seeall)

local SeekFoodMainView = class("SeekFoodMainView", ViewComponent)

function SeekFoodMainView:buildUI()
	SeekFoodMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._foodScrollercell = goutil.findChild(self.mainGO, "foodCol/foodScrollercell")
	self._foodScrollerview = goutil.findChild(self.mainGO, "foodCol/foodScrollerview")
	self._foodScrollList = ScrollerList.create(self._foodScrollerview, self._foodScrollercell, GameUtil.handler(self._updateFoodCell, self), GameUtil.handler(self._clearFoodCell, self))
	self._itemScrollListDic = {}
	self._petRoot = goutil.findChild(self.mainGO, "petRoot")
	self._btnFood = goutil.findChild(self.mainGO, "btnFood/btn")
	self._redBtnFood = goutil.findChild(self.mainGO, "btnFood/btn/redPoint")
	self._txtBtnFood = goutil.findChildTextComponent(self.mainGO, "btnFood/desc/txt")
	self._btnBuff = goutil.findChild(self.mainGO, "btnBuff/btn")
	self._redBtnBuff = goutil.findChild(self.mainGO, "btnBuff/btn/redPoint")
	self._bubble = goutil.findChild(self.mainGO, "bubble")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "bubble/txtDesc")
	self._customInput = UICustomInput.Get(self._bubble)

	GameUtil.SetActive(self._bubble, false)
end

function SeekFoodMainView:bindEvents()
	SeekFoodMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnFood, self._onClickBtnFood, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function SeekFoodMainView:unbindEvents()
	SeekFoodMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFood)
	GameUtil.rmClickHandler(self._btnBuff)
	self._customInput:RemoveListener()
end

function SeekFoodMainView:onEnter()
	SeekFoodMainView.super.onEnter(self)

	self._activityId = SeekFoodController.instance:getActivityId()
	self._activityType = SeekFoodController.instance:getActivityType()

	local isInTime = SeekFoodController.instance:isInActivityTimeAsSeekFood(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.SeekFoodInfoRes, self._onUpdate, self)
	SeekFoodController.instance:sendPM_SeekFoodInfoReq(self._activityId)
end

function SeekFoodMainView:onExit()
	SeekFoodMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnFood)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	self:_onClearFoodCol()
end

function SeekFoodMainView:_onSetUI()
	local today = SeekFoodController.instance:getToDayByActOpen(self._activityId)
	local buff = SeekFoodConfig.instance:getSfBuffData(self._activityId, today)

	if buff then
		self._txtBubble.text = buff.desc or "今日无Buff"
	end

	local redId = SeekFoodConfig.instance:getRedIdOfCanPrize(self._activityId)

	if not string.nilorempty(redId) then
		RedPointController.instance:regRedPoint(self._redBtnFood, redId)
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, "10335", self._petRoot, 1, nil, true, 0, 0)
end

function SeekFoodMainView:_onUpdate()
	self:_onUpdateFoodColUI()

	local curProgress = SeekFoodController.instance:getCurProgressOfFood(self._activityId)
	local maxProgress = SeekFoodController.instance:getMaxProgressOfFood(self._activityId)

	self._txtBtnFood.text = curProgress < maxProgress and string.format("已收集：%s/%s", curProgress, maxProgress) or "已收集完成"
end

function SeekFoodMainView:_onUpdateFoodColUI()
	local foodInfoList = {}
	local cfg = SeekFoodConfig.instance:getSfFoodCfg(self._activityId)

	for _, data in ipairs(cfg) do
		local info = {}

		info.foodId = data.foodId
		info.data = data
		info.state = SeekFoodController.instance:getFoodState(self._activityId, data.foodId)

		table.insert(foodInfoList, info)
	end

	table.sort(foodInfoList, function(a, b)
		if a.state == b.state then
			return a.foodId < b.foodId
		end

		return a.state < b.state
	end)
	self._foodScrollList:reloadData(foodInfoList)
end

function SeekFoodMainView:_onClearFoodCol()
	self._foodScrollList:dispose()
end

function SeekFoodMainView:_updateFoodCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local foodId = info.foodId
	local state = info.state
	local data = info.data
	local isInTime = SeekFoodController.instance:isInTimeOfFood(self._activityId, foodId)
	local foodIcon = goutil.findChild(mainGo, "foodIcon")
	local prizeIcon = goutil.findChild(mainGo, "prizeIcon")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local redBtnGoto = goutil.findChild(mainGo, "btnGoto/redPoint")
	local txtBtnGoto = goutil.findChildTextComponent(mainGo, "btnGoto/txt")
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local redBtnReceive = goutil.findChild(mainGo, "btnReceive/redPoint")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local itemScrollerview = goutil.findChild(mainGo, "itemCol/itemScrollerview")
	local itemScrollercell = goutil.findChild(mainGo, "itemCol/itemScrollercell")

	if itemScrollerview and itemScrollercell then
		local cfg = SeekFoodConfig.instance:getSfMatCfg(self._activityId, foodId)

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(cfg)
			itemScrollList:dragNotifyParent()
		end
	end

	local path = data.foodPic
	local bgGo = foodIcon

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/items/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, prizeIcon)
	else
		MaterialMgr.resetAll(prizeIcon)
	end

	local redId = SeekFoodController.instance:getRedIdAsFood(self._activityId, foodId)

	RedPointController.instance:regRedPoint(redBtnGoto, redId)
	RedPointController.instance:regRedPoint(redBtnReceive, redId)
	GameUtil.SetActive(btnGoto, state ~= SeekFoodModel.FoodState.CanFightBoss and state ~= SeekFoodModel.FoodState.HasFightBoss)
	GameUtil.SetActive(btnReceive, state == SeekFoodModel.FoodState.CanFightBoss)
	GameUtil.SetActive(receivedGo, state == SeekFoodModel.FoodState.HasFightBoss)

	local btnGoStr

	if isInTime then
		btnGoStr = "收集材料"
	else
		local startDate = SeekFoodConfig.instance:getOpenDateTimeOfFood(self._activityId, foodId)

		btnGoStr = string.format("%s后可收集", GameUtil.getFormatTimeByStamp(GameUtil.string2time(startDate), nil))
	end

	txtBtnGoto.text = btnGoStr

	GameUtil.SetGray(btnGoto, not isInTime)
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickFoodBtnGoto, self, foodId))
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickFoodBtnGoto, self, foodId))
end

function SeekFoodMainView:_clearFoodCell(cell)
	local mainGo = cell.gameObject
	local foodIcon = goutil.findChild(mainGo, "foodIcon")
	local prizeIcon = goutil.findChild(mainGo, "prizeIcon")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local redBtnGoto = goutil.findChild(mainGo, "btnGoto/redPoint")
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local redBtnReceive = goutil.findChild(mainGo, "btnReceive/redPoint")

	RedPointController.instance:unregRedPoint(redBtnGoto)
	RedPointController.instance:unregRedPoint(redBtnReceive)
	uGuiUtil.clearImage(foodIcon)
	MaterialMgr.resetAll(prizeIcon)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnGoto)
	GameUtil.rmClickHandler(btnReceive)
end

function SeekFoodMainView:_onClickFoodBtnGoto(foodId)
	local result, tips = SeekFoodController.instance:getTryGotoCollectResultAndTips(self._activityId, foodId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local saveVewInfoList = {}
	local info = {}

	info.viewName = ViewName.SeekFoodMainView
	info.params = nil

	table.insert(saveVewInfoList, info)
	UIStateManager.instance:push(ViewName.SeekFoodFoodDisView, self._activityId, foodId, saveVewInfoList)
end

function SeekFoodMainView:_updateItemCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local path = data.pic
	local bgGo = goutil.findChild(mainGo, "icon")

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/items/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end
end

function SeekFoodMainView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function SeekFoodMainView:_onClickBtnTip()
	local value = SeekFoodConfig.instance:getSfCommonValue(self._activityId, "SF_MAIN_RULE_KEY", false)

	TipsFacade.instance:openRulesView(value)
end

function SeekFoodMainView:_onClickBtnFood()
	UIStateManager.instance:push(ViewName.SeekFoodBookView)
end

function SeekFoodMainView:_onClickBtnBuff()
	self:_onCustomInputCallback(false)
end

function SeekFoodMainView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._bubble, not GameUtil.GetActive(self._bubble))
	end
end

return SeekFoodMainView
