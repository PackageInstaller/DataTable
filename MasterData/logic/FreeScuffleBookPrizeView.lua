-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleBookPrizeView.lua

module("logic.extensions.freescuffle.view.FreeScuffleBookPrizeView", package.seeall)

local FreeScuffleBookPrizeView = class("FreeScuffleBookPrizeView", FreeScuffleTaskView)

function FreeScuffleBookPrizeView:buildUI()
	FreeScuffleBookPrizeView.super.buildUI(self)

	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollerClipGo = self:getGo("prizeCol/scrView/Viewport")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = self:getGo("prizeCol/total")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeCol_total_icon = self:getGo("prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function FreeScuffleBookPrizeView:onEnter()
	FreeScuffleBookPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleGainTaskProgressPrizeRes, self._onUpdate, self)
end

function FreeScuffleBookPrizeView:onExit()
	FreeScuffleBookPrizeView.super.onExit(self)
	self:_onClearPrizeCol()
end

function FreeScuffleBookPrizeView:_onUpdate()
	FreeScuffleBookPrizeView.super._onUpdate(self)
	self:_onUpdatePrizeCol()
end

function FreeScuffleBookPrizeView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function FreeScuffleBookPrizeView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function FreeScuffleBookPrizeView:_getProgressDataList()
	return FreeScuffleConfig.instance:getTaskProgressPrizeCfg(self._activityId) or {}
end

function FreeScuffleBookPrizeView:_getSliderComp()
	return self._sliderComp
end

function FreeScuffleBookPrizeView:_getScrollClipGo()
	return self._prizeScrollerClipGo
end

function FreeScuffleBookPrizeView:_getCurProgress()
	return self._subMo:getSumProgress()
end

function FreeScuffleBookPrizeView:_getProgressByData(data)
	return data.progress
end

function FreeScuffleBookPrizeView:_getPrizeIdByData(data)
	return data.progressId
end

function FreeScuffleBookPrizeView:_getPrizeStrByData(data)
	return data.prize
end

function FreeScuffleBookPrizeView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrizeProgress(prizeId)
end

function FreeScuffleBookPrizeView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughPrizeProgress(prizeId)
end

function FreeScuffleBookPrizeView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanPrizeProgress(prizeId)
end

function FreeScuffleBookPrizeView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local clipGo = self:_getScrollClipGo()
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
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, clipGo, true, nil)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function FreeScuffleBookPrizeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function FreeScuffleBookPrizeView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	FreeScuffleController.instance:sendPM_FreeScuffleGainTaskProgressPrizeReq(self._activityId, prizeId)
end

function FreeScuffleBookPrizeView:_updateTaskCell(view, cell, info, tag)
	FreeScuffleBookPrizeView.super._updateTaskCell(self, view, cell, info, tag)

	local data = info.data
	local mainGo = cell.gameObject
	local txtIncreaseProgress = goutil.findChildTextComponent(mainGo, "txtIncreaseProgress")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")

	txtIncreaseProgress.text = string.format("+进度：%s", data.increaseProgress)

	GameUtil.SetActive(txtIncreaseProgress.gameObject, data.increaseProgress > 0 and not GameUtil.GetActive(itemScrView))
end

return FreeScuffleBookPrizeView
