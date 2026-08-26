-- chunkname: @modules/logic/tower/view/TowerStoreView.lua

module("modules.logic.tower.view.TowerStoreView", package.seeall)

local TowerStoreView = class("TowerStoreView", BaseView)

function TowerStoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "mask/#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "mask/#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	self._golimit = gohelper.findChild(self.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem/go_tag/#go_limit")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._gotag = gohelper.findChild(self.viewGO, "Tag3")
	self._gotaglimit = gohelper.findChild(self.viewGO, "Tag3/#go_taglimit")
	self._txtlimit = gohelper.findChildText(self.viewGO, "Tag3/#go_taglimit/#txt_limit")
	self._txtTagName = gohelper.findChildText(self.viewGO, "Tag3/txt_tagName")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._gotaskReddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_taskReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerStoreView:addEvents()
	self._btnTask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStoreContent, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshStoreContent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnHandleInStoreView, self._OnHandleInStoreView, self)
end

function TowerStoreView:removeEvents()
	self._btnTask:RemoveClickListener()
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStoreContent, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshStoreContent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnHandleInStoreView, self._OnHandleInStoreView, self)
end

function TowerStoreView:_btntaskOnClick()
	local curOpenTimeLimitTowerMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local param = {}

	TowerComposeController.instance:openTowerComposeTaskView(param)
end

function TowerStoreView:_btntagOnClick(index)
	local _itemNormalized = self.itemNormalized[index]

	if _itemNormalized and _itemNormalized.centerNormalized then
		self:killTween()

		self.tweenId = ZProj.TweenHelper.DOTweenFloat(self._scrollstore.verticalNormalizedPosition, _itemNormalized.centerNormalized, 0.5, self.tweenFrameCallback, nil, self)
	end
end

function TowerStoreView:_editableInitView()
	gohelper.setActive(self._gostoreItem, false)

	self.storeItemList = self:getUserDataTb_()
	self._tagList = self:getUserDataTb_()
	self.showTagIndex = {
		3
	}

	for i = 1, 3 do
		local go = gohelper.findChild(self.viewGO, "Tag" .. i)

		if go then
			local btn = gohelper.findChildButtonWithAudio(go, "image_tagType/btn_tag")
			local titleTxt = gohelper.findChildText(go, "txt_tagName")
			local limitgo = gohelper.findChild(go, "#go_taglimit")
			local limitTxt = gohelper.findChildText(go, "#go_taglimit/#txt_limit")
			local canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
			local tag = {}

			tag.go = go

			if btn then
				btn:AddClickListener(self._btntagOnClick, self, i)

				tag.btn = btn
			end

			if titleTxt then
				tag.titleTxt = titleTxt
			end

			if limitgo then
				tag.limitgo = limitgo

				if limitTxt then
					tag.limitTxt = limitTxt
				end
			end

			if canvasGroup then
				tag.canvasGroup = canvasGroup
			end

			self._tagList[i] = tag

			gohelper.setActive(go, false)
		end
	end

	local nameCn, nameEn = TowerStoreModel.instance:getStoreGroupName(StoreEnum.TowerStore.NormalStore)

	self._txtTagName.text = nameCn

	gohelper.setActive(self._gotaglimit, false)
end

function TowerStoreView:onUpdateParam()
	return
end

function TowerStoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		for k, v in ipairs(self.storeItemList) do
			if k == 1 then
				v:refreshTagClip(self._scrollstore)
			end
		end
	end

	self:checkEnableTag()
end

function TowerStoreView:onOpen()
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)
	RedDotController.instance:addRedDot(self._gotaskReddot, RedDotEnum.DotNode.TowerTask)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshStoreContent()
	self:refreshTime()
	self:_onScrollValueChanged()

	if not TowerStoreModel.instance:isUpdateStoreEmpty() then
		TowerStoreModel.instance:setNotNewStoreGoods()
	end

	TowerController.instance:dispatchEvent(TowerEvent.OnEnterStoreView)
end

function TowerStoreView:onOpenFinish()
	self._scrollstore.verticalNormalizedPosition = 1

	local storeGroupMo = TowerStoreModel.instance:getStoreGroupMO()
	local updateStoreGroupMo = storeGroupMo and storeGroupMo[StoreEnum.TowerStore.UpdateStore]
	local isNilupdateStoreMo = updateStoreGroupMo and next(updateStoreGroupMo:getGoodsList()) == nil

	if not isNilupdateStoreMo then
		TaskDispatcher.runDelay(self.checkFirstEnterOneDay, self, 0.7)
	end
end

function TowerStoreView:_OnHandleInStoreView()
	self._isHandleInStoreView = true
end

function TowerStoreView:checkFirstEnterOneDay()
	local isFirstEnter = self:getFirstEnterOneDayPref()

	if isFirstEnter == 0 then
		if not self._isHandleInStoreView and self._scrollstore.verticalNormalizedPosition == 1 then
			self:_btntagOnClick(1)
		end

		self:setFirstEnterOneDayPref()
	end
end

function TowerStoreView:refreshStoreContent()
	local storeGroupMoList = TowerStoreModel.instance:getStoreGroupMO()
	local storeIdList = TowerStoreModel.instance:getStore()

	for index, storeId in pairs(storeIdList) do
		local groupMo = storeGroupMoList[storeId]

		if groupMo.goodsInfos and #groupMo:getGoodsList() > 0 then
			local storeItem = self.storeItemList[storeId]

			if not storeItem then
				storeItem = TowerStoreItem.New()

				local go = gohelper.cloneInPlace(self._gostoreItem, storeId)

				storeItem:onInitView(go)

				self.storeItemList[storeId] = storeItem
			end

			storeItem:updateInfo(index, groupMo)
		elseif self.storeItemList[storeId] then
			self.storeItemList[storeId]:hideStoreItem()
			self.storeItemList[storeId]:onClose()
			self.storeItemList[storeId]:onDestroy()

			self.storeItemList[storeId] = nil
		end
	end

	for i, item in pairs(self.storeItemList) do
		gohelper.setSibling(item.go, item.groupId or i)
	end

	self:refreshItemNormalized()
end

function TowerStoreView:onClose()
	self._scrollstore:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	TaskDispatcher.cancelTask(self.checkFirstEnterOneDay, self)
	self:killTween()

	if self._tagList then
		for _, tag in pairs(self._tagList) do
			if tag.btn then
				tag.btn:RemoveClickListener()
			end
		end
	end

	if self.storeItemList then
		for _, item in pairs(self.storeItemList) do
			item:onClose()
		end
	end

	TowerStoreModel.instance:saveAllStoreGroupNewData()
end

function TowerStoreView:onDestroyView()
	for _, storeItem in pairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

function TowerStoreView:refreshTime()
	for _, storeItem in pairs(self.storeItemList) do
		storeItem:refreshTime()
	end
end

function TowerStoreView:refreshItemNormalized()
	if self.storeItemList then
		ZProj.UGUIHelper.RebuildLayout(self._goContent.transform)

		local contentHeight = recthelper.getHeight(self._goContent.transform)

		self.itemNormalized = {}

		local scrollHeigth = recthelper.getHeight(self._scrollstore.transform)
		local itemList = {}

		for _, item in pairs(self.storeItemList) do
			table.insert(itemList, item)
		end

		table.sort(itemList, function(a, b)
			return a.groupId < b.groupId
		end)

		if contentHeight > 0 then
			local endPosY = 0
			local preHeight = 0
			local spacing = 90

			contentHeight = contentHeight - scrollHeigth

			for _, item in ipairs(itemList) do
				local _height = item:getHeight()
				local _normalized = {}
				local _startPosY = endPosY == 0 and 0 or endPosY
				local _endPosY = preHeight + (_height - scrollHeigth)
				local _preHeight = preHeight

				endPosY = _endPosY + spacing
				preHeight = _preHeight + _height + spacing
				_normalized.startNormalized = 1 - _startPosY / contentHeight
				_normalized.endNormalized = 1 - endPosY / contentHeight
				_normalized.centerNormalized = 1 - _preHeight / contentHeight

				table.insert(self.itemNormalized, _normalized)
			end
		end

		self:checkEnableTag()
	end
end

function TowerStoreView:checkEnableTag()
	if not self.itemNormalized then
		for _, v in ipairs(self._tagList) do
			gohelper.setActive(v.go, false)
		end

		return
	end

	for index, v in pairs(self._tagList) do
		gohelper.setActive(v.go, self.itemNormalized[index])
	end

	for _, v in ipairs(self.showTagIndex) do
		if not self.itemNormalized[v] then
			return
		end

		local startNormal = self.itemNormalized[v].startNormalized - 0.05
		local verticalNormalizedPosition = self._scrollstore.verticalNormalizedPosition
		local tag = self._tagList[v]

		if tag and startNormal then
			local offset = verticalNormalizedPosition - startNormal
			local aphla = 0

			gohelper.setActive(tag.go, true)

			aphla = 1 - (0.05 - offset) / 0.05
			tag.canvasGroup.alpha = 1 - (0.05 - offset) / 0.05

			transformhelper.setLocalPosXY(self._gotag.transform, self._gotag.transform.localPosition.x, -455 + Mathf.Clamp01(1 - (0.05 - offset) / 0.05) * 83)
		end
	end

	local storeGroupMo = TowerStoreModel.instance:getStoreGroupMO()
	local updateStoreGroupMo = storeGroupMo and storeGroupMo[StoreEnum.TowerStore.UpdateStore]
	local isNilupdateStoreMo = updateStoreGroupMo and next(updateStoreGroupMo:getGoodsList()) == nil

	if isNilupdateStoreMo then
		for _, v in ipairs(self._tagList) do
			gohelper.setActive(v.go, false)
		end
	end
end

function TowerStoreView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function TowerStoreView:tweenFrameCallback(value)
	self._scrollstore.verticalNormalizedPosition = value
end

function TowerStoreView:getFirstEnterOneDayPref()
	local key = self:getFirstEnterOneDayPrefKey()

	return (PlayerPrefsHelper.getNumber(key, 0))
end

function TowerStoreView:setFirstEnterOneDayPref()
	local key = self:getFirstEnterOneDayPrefKey()

	PlayerPrefsHelper.setNumber(key, 1)
end

function TowerStoreView:getFirstEnterOneDayPrefKey()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if playerInfo then
		if not playerInfo.userId then
			local playerId = 1999

			return "TowerStoreView_FirstEnterOneDay_" .. playerId
		end
	end
end

return TowerStoreView
