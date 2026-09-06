-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/view/SeekFoodBookView.lua

module("logic.extensions.seekfood.view.SeekFoodBookView", package.seeall)

local SeekFoodBookView = class("SeekFoodBookView", ViewComponent)

function SeekFoodBookView:buildUI()
	SeekFoodBookView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._foodScrollercell = goutil.findChild(self.mainGO, "foodCol/foodScrollercell")
	self._foodScrollerview = goutil.findChild(self.mainGO, "foodCol/foodScrollerview")
	self._foodScrollList = ScrollerList.create(self._foodScrollerview, self._foodScrollercell, GameUtil.handler(self._updateFoodCell, self), GameUtil.handler(self._clearFoodCell, self))
	self._ScrollRect = goutil.findChild(self.mainGO, "sliderCol/ScrollRect")
	self._progressBar = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/progressBar")
	self._content = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content")
	self._gridView = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridView")
	self._gridCell = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridCell")
	self._txtNumOfPro = goutil.findChildTextComponent(self.mainGO, "sliderCol/total/txtNum")

	local exParams = {
		Content = self._content,
		cellGroup = self._gridView,
		progressBar = self._progressBar
	}

	self._progressList = ProgressList.create(self._ScrollRect, self._gridCell, GameUtil.handler(self._updateProgressGrid, self), GameUtil.handler(self._clearProgressCell, self), exParams)
	self._uiCustonInput = UICustomInput.Get(self.mainGO)
end

function SeekFoodBookView:bindEvents()
	SeekFoodBookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._uiCustonInput:AddListener(self._onCustomInputCallback, self)
end

function SeekFoodBookView:unbindEvents()
	SeekFoodBookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._uiCustonInput:RemoveListener()
end

function SeekFoodBookView:onEnter()
	SeekFoodBookView.super.onEnter(self)

	self._activityId = SeekFoodController.instance:getActivityId()
	self._activityType = SeekFoodController.instance:getActivityType()

	local isInTime = SeekFoodController.instance:isInActivityTimeAsSeekFood(self._activityId)

	if not isInTime then
		printError(string.format("活动不在开启期限内( activityId = %d, foodId = %s )", self._activityId, self._foodId))
		self:close()
	end

	self.addGEvent(self, GlobalNotify.SeekFoodInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SeekFoodGainPrizeRes, self._handleGainPrizeRes, self)
	self:_sendInfoReq()
end

function SeekFoodBookView:onExit()
	SeekFoodBookView.super.onExit(self)
	self:_onClearFoodCol()
	self:_onClearSliderColUI()
end

function SeekFoodBookView:_sendInfoReq()
	SeekFoodController.instance:sendPM_SeekFoodInfoReq(self._activityId)
end

function SeekFoodBookView:_handleGainPrizeRes()
	self:_sendInfoReq()
end

function SeekFoodBookView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SeekFoodBookView:_onUpdateData()
	return
end

function SeekFoodBookView:_onUpdateUI()
	self:_onUpdateFoodColUI()
	self:_onUpdateSliderColUI()
end

function SeekFoodBookView:_onUpdateFoodColUI()
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

		return a.state > b.state
	end)
	self._foodScrollList:reloadData(foodInfoList)
end

function SeekFoodBookView:_onClearFoodCol()
	self._foodScrollList:dispose()
end

function SeekFoodBookView:_updateFoodCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local state = info.state
	local data = info.data
	local foodIcon = goutil.findChild(mainGo, "foodIcon")
	local lock = goutil.findChild(mainGo, "lock")
	local descCol = goutil.findChild(mainGo, "txtDesc")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc/Viewport/Content")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
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

	txtDesc.text = data.des
	txtName.text = data.name

	GameUtil.SetActive(lock, state ~= SeekFoodModel.FoodState.HasFightBoss)
	GameUtil.SetActive(descCol, state == SeekFoodModel.FoodState.HasFightBoss)
end

function SeekFoodBookView:_clearFoodCell(cell)
	local mainGo = cell.gameObject
	local foodIcon = goutil.findChild(mainGo, "foodIcon")

	uGuiUtil.clearImage(foodIcon)
end

function SeekFoodBookView:_onClickFoodBtnGoto(foodId)
	local result, tips = SeekFoodController.instance:getTryGotoCollectResultAndTips(self._activityId, foodId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local saveVewInfoList = {}
	local info = {}

	info.viewName = ViewName.SeekFoodBookView
	info.params = nil

	table.insert(saveVewInfoList, info)
	UIStateManager.instance:push(ViewName.SeekFoodFoodDisView, self._activityId, foodId, saveVewInfoList)
end

function SeekFoodBookView:_onUpdateSliderColUI()
	local prizeCfg = SeekFoodConfig.instance:getSfPrizeCfg(self._activityId)
	local curProgress = SeekFoodController.instance:getCurProgressOfFood(self._activityId)
	local maxProgress = SeekFoodController.instance:getMaxProgressOfFood(self._activityId)

	self._txtNumOfPro.text = maxProgress <= curProgress and "已满" or curProgress

	self._progressList:reloadDataList(prizeCfg)
	self._progressList:updateCell()

	local proList = {}

	for _, data in ipairs(prizeCfg) do
		table.insert(proList, data.seekNum)
	end

	self._progressList:updateProgressByList(proList, curProgress)

	local index = 0

	for idx, data in ipairs(prizeCfg) do
		if SeekFoodModel.instance:isHasGainPrize(data.prizeId) then
			index = idx

			break
		end
	end

	if index ~= 0 then
		self._progressList:rollToIdx(index)
	else
		self._progressList:rollToIdxNewest(proList, curProgress)
	end
end

function SeekFoodBookView:_onClearSliderColUI()
	self._progressList:dispose()
end

function SeekFoodBookView:_updateProgressGrid(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local effectParent = goutil.findChild(mainGo, "effect")
	local isHasGain = SeekFoodModel.instance:isHasGainPrize(data.prizeId)
	local isCanGet = SeekFoodController.instance:isCanGetPrizeInProgress(self._activityId, data.prizeId)

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtNum then
		txtNum.text = data.seekNum
	end

	GameUtil.SetActive(receivedGo, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	self._gridEffList = self._gridEffList or {}

	UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

	self._gridEffList[mainGo] = nil

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._ScrollRect:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._gridEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGridCell, self, data))
end

function SeekFoodBookView:_clearProgressCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._gridEffList[mainGo] then
		UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

		self._gridEffList[mainGo] = nil
	end
end

function SeekFoodBookView:_onClickGridCell(data)
	local result, tips = SeekFoodController.instance:getTryGainPrizeOfProResultAndTips(self._activityId, data.prizeId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	SeekFoodController.instance:sendPM_SeekFoodGainPrizeReq(self._activityId, data.prizeId)
end

function SeekFoodBookView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return SeekFoodBookView
