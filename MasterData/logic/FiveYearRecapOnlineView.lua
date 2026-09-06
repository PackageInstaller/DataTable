-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapOnlineView.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapOnlineView", package.seeall)

local FiveYearRecapOnlineView = class("FiveYearRecapOnlineView", ViewComponent)

function FiveYearRecapOnlineView:ctor()
	FiveYearRecapOnlineView.super.ctor(self)
end

function FiveYearRecapOnlineView:buildUI()
	FiveYearRecapOnlineView.super.buildUI(self)

	self._progressCol = self:getGo("progressCol")
	self._progressScrView = self:getGo("progressCol/scrView")
	self._progressScrCell = self:getGo("progressCol/scrCell")
	self._progressBar = self:getGo("progressCol/scrView/Viewport/Content/progressBar")
	self._progressSliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._progressScrollerList = ScrollerList.create(self._progressScrView, self._progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._txtScore = self:getTxt("score/txt")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._itemScrollerLists = {}
	self._prizeInfoLists = {}
end

function FiveYearRecapOnlineView:bindEvents()
	FiveYearRecapOnlineView.super.bindEvents(self)
end

function FiveYearRecapOnlineView:unbindEvents()
	FiveYearRecapOnlineView.super.unbindEvents(self)
end

function FiveYearRecapOnlineView:onEnter()
	FiveYearRecapOnlineView.super.onEnter(self)

	self._activityId = FiveYearRecapController.instance:getActivityId()
	self._subMo = FiveYearRecapController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_FiveYearRecapGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FiveYearRecapGainLoginPrizeRes, self._onUpdate, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_onUpdate()
end

function FiveYearRecapOnlineView:onExit()
	FiveYearRecapOnlineView.super.onExit(self)
	self:_onClearProgressCol()
end

function FiveYearRecapOnlineView:_onUpdate()
	self:_onUpdateProgressCol()
end

function FiveYearRecapOnlineView:_onUpdateProgressCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()

	self._prizeInfoLists = {}

	local scoreList = {}
	local index = -1

	for idx, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))

		local prizeId = self:_getPrizeIdByData(data)
		local isHasGain = self:_isHasGainPrize(data)
		local infoList = {}
		local prizeStrArr = string.split(data.prize, "#")

		for _, v in ipairs(prizeStrArr) do
			table.insert(infoList, {
				prizeStr = v,
				isHasGain = isHasGain
			})
		end

		self._prizeInfoLists[prizeId] = infoList

		if index == -1 and not isHasGain then
			index = idx
		end
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._txtScore.text = string.format("%s天", curProgress)
end

function FiveYearRecapOnlineView:_onClearProgressCol()
	self._progressScrollerList:dispose()
end

function FiveYearRecapOnlineView:_getProgressDataList()
	local dataList = FiveYearRecapConfig.instance:getLoginDaysPrizeDatas(self._activityId)

	return dataList or {}
end

function FiveYearRecapOnlineView:_getSliderComp()
	return self._progressSliderComp
end

function FiveYearRecapOnlineView:_getScrollRect()
	return self._progressScrView:GetComponent(ComponentType.ScrollRect)
end

function FiveYearRecapOnlineView:_getCurProgress()
	return self._subMo:getLoginDays()
end

function FiveYearRecapOnlineView:_getProgressByData(data)
	return data.loginDays
end

function FiveYearRecapOnlineView:_getPrizeIdByData(data)
	return data.prizeId
end

function FiveYearRecapOnlineView:_getPrizeStrByData(data)
	return data.prize
end

function FiveYearRecapOnlineView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainedLoginPrize(prizeId)
end

function FiveYearRecapOnlineView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughToGainLoginPrize(prizeId)
end

function FiveYearRecapOnlineView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGainLoginPrize(prizeId)
end

function FiveYearRecapOnlineView:_updateProgressCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isEnough = self:_isEnoughGetPrize(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local tagPoint = goutil.findChild(mainGo, "tagPoint")
	local actContentGo = goutil.findChild(mainGo, "actContent")
	local txtNameContent = goutil.findChildTextComponent(mainGo, "actContent/txtName")
	local conContent = goutil.findChild(mainGo, "actContent/mask/con")
	local scrView = goutil.findChild(mainGo, "prize/scrView")
	local scrCell = goutil.findChild(mainGo, "prize/scrCell")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	txtScore.text = tostring(progress)

	GameUtil.SetActive(btnGet, isCanGet)
	GameUtil.SetActive(tagPoint, isEnough)
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickProgressGet, self, data))

	local isNeedActContent = not string.nilorempty(data.actName)

	GameUtil.SetActive(actContentGo, isNeedActContent)

	txtNameContent.text = data.actName

	local skinId = checknumber(data.skinId)

	if skinId > 0 then
		local modelCo = CharacterConfig.instance:getModelCo(skinId)

		uGuiUtil.setSpriteToImage(conContent, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	else
		uGuiUtil.clearImage(conContent)
	end

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	if not self._prizeInfoLists[prizeId] then
		local infoList = {}

		if not self._itemScrollerLists[mainGo] then
			local scrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollerLists[mainGo] = scrollerList

			scrollerList:reloadData(infoList)
			scrollerList:dragNotifyParent()
		end
	end
end

function FiveYearRecapOnlineView:_updateItemCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")

	GameUtil.SetActive(received, info.isHasGain)
	MaterialMgr.setCellByCfg(info.prizeStr, item)
end

function FiveYearRecapOnlineView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function FiveYearRecapOnlineView:_clearProgressCell(cell)
	local mainGo = cell.gameObject
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local conContent = goutil.findChild(mainGo, "actContent/mask/con")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")
	local scrollerList = self._itemScrollerLists[mainGo]

	if scrollerList then
		scrollerList:dispose()

		self._itemScrollerLists[mainGo] = nil
	end

	self:stopViewEffectUniGo(effectRoot)
	GameUtil.rmClickHandler(btnGet)
	uGuiUtil.clearImage(conContent)
end

function FiveYearRecapOnlineView:_onClickProgressGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	FiveYearRecapController.instance:sendPM_FiveYearRecapGainLoginPrizeReq(self._activityId)
end

return FiveYearRecapOnlineView
