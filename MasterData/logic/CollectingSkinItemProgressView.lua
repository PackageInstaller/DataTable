-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingSkinItemProgressView.lua

module("logic.extensions.collectingskin.view.CollectingSkinItemProgressView", package.seeall)

local CollectingSkinItemProgressView = class("CollectingSkinItemProgressView", ViewComponent)

function CollectingSkinItemProgressView:buildUI()
	CollectingSkinItemProgressView.super.buildUI(self)

	local itemScrView = self:getGo("itemCol/scrView")
	local itemScrCell = self:getGo("itemCol/scrCell")

	self._itemScrollerList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemScrCell, self), GameUtil.handler(self._clearItemScrCell, self))
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/scrView")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/scrCell")
	self._progressBar = goutil.findChild(self.mainGO, "prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = goutil.findChild(self.mainGO, "prizeCol/total")
	self._prizeCol_total_txtNum = goutil.findChildTextComponent(self.mainGO, "prizeCol/total/txtNum")
	self._prizeCol_total_icon = goutil.findChild(self.mainGO, "prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnJump = self:getGo("btnJump")
	self._btnRank = self:getGo("btnRank")
	self._txtOpenTime = self:getTxt("openTime/txt")
end

function CollectingSkinItemProgressView:bindEvents()
	CollectingSkinItemProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function CollectingSkinItemProgressView:unbindEvents()
	CollectingSkinItemProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(self._btnRank)
end

function CollectingSkinItemProgressView:onEnter()
	CollectingSkinItemProgressView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = CollectingSkinController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = CollectingSkinController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.CollectingSkinGainItemPrize, self._onUpdate, self)

	local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(activityType, self._activityId)

	self:_onUpdate()
end

function CollectingSkinItemProgressView:onExit()
	CollectingSkinItemProgressView.super.onExit(self)
	self:_onClearItemCol()
	self:_onClearPrizeCol()
end

function CollectingSkinItemProgressView:_onUpdate()
	self:_onUpdateItemCol()
	self:_onUpdatePrizeCol()
end

function CollectingSkinItemProgressView:_onUpdateItemCol()
	local cfg = CollectingSkinConfig.instance:getItemCfg(self._activityId) or {}

	self._itemScrollerList:reloadData(cfg)
end

function CollectingSkinItemProgressView:_onClearItemCol()
	self._itemScrollerList:dispose()
end

function CollectingSkinItemProgressView:_updateItemScrCell(view, cell, data, tag)
	local id = data.id
	local matMo = self._subMo:getItemMatMo(id)
	local isHasCollect = self._subMo:isHasCollectItem(id)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local item = goutil.findChild(mainGo, "item")
	local tagFinish = goutil.findChild(mainGo, "tagFinish")

	txtName.text = data.name

	GameUtil.SetActive(tagFinish, isHasCollect)

	local matStr, matType, matId, matNum

	if matMo.matType == MatType.Cloth then
		matStr = MaterialMgr.changeClothStrGender(matMo.matStr)
		matType, matId, matNum = MaterialMgr.getMatParams(matStr)
	else
		matNum = matMo.matNum
		matId = matMo.matId
		matType = matMo.matType
		matStr = matMo.matStr
	end

	local proxy = MaterialMgr.setCell(matType, matId, item)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			local matCfg = MaterialMgr.getMatCfg(matType, matId)

			if matCfg and not string.nilorempty(matCfg.source) then
				TipsFacade.instance:openItemSourceView(matStr)
			else
				CommonTipsMgr.instance:openTipsByConfStr(item, matStr)
			end
		end)
	end
end

function CollectingSkinItemProgressView:_clearItemScrCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function CollectingSkinItemProgressView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = -1

	for idx, data in ipairs(dataList) do
		if not self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function CollectingSkinItemProgressView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function CollectingSkinItemProgressView:_getProgressDataList()
	return CollectingSkinConfig.instance:getItemProgressCfg(self._activityId) or {}
end

function CollectingSkinItemProgressView:_getSliderComp()
	return self._sliderComp
end

function CollectingSkinItemProgressView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function CollectingSkinItemProgressView:_getCurProgress()
	return self._subMo:getCurItemProgress()
end

function CollectingSkinItemProgressView:_getProgressByData(data)
	return data.progress
end

function CollectingSkinItemProgressView:_getPrizeIdByData(data)
	return data.dataBitId
end

function CollectingSkinItemProgressView:_getPrizeStrByData(data)
	return data.prize
end

function CollectingSkinItemProgressView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrizeInItem(prizeId)
end

function CollectingSkinItemProgressView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrizeInItem(prizeId)
end

function CollectingSkinItemProgressView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrizeInItem(prizeId)
end

function CollectingSkinItemProgressView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function CollectingSkinItemProgressView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function CollectingSkinItemProgressView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	CollectingSkinController.instance:gainItemPrize(self._activityId, prizeId)
end

function CollectingSkinItemProgressView:_onClickJump()
	GotoMgr.gotoByString("func#1314")
end

function CollectingSkinItemProgressView:_onClickRank()
	UIStateManager.instance:push(ViewName.CollectingSkinItemProgressRankView, self._activityId)
end

return CollectingSkinItemProgressView
