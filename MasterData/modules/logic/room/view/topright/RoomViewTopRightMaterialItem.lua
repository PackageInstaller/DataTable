-- chunkname: @modules/logic/room/view/topright/RoomViewTopRightMaterialItem.lua

module("modules.logic.room.view.topright.RoomViewTopRightMaterialItem", package.seeall)

local RoomViewTopRightMaterialItem = class("RoomViewTopRightMaterialItem", RoomViewTopRightBaseItem)

function RoomViewTopRightMaterialItem:ctor(param)
	RoomViewTopRightMaterialItem.super.ctor(self, param)
end

function RoomViewTopRightMaterialItem:_customOnInit()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._item = {
		type = self._param.type,
		id = self._param.id
	}
	self._onlyShowEvent = self._param.onlyShowEvent
	self._supportFlyEffect = self._param.supportFlyEffect
	self._listeningItems = self._param.listeningItems

	local icon

	self._resourceItem.simageicon = gohelper.findChildSingleImage(self._resourceItem.go, "icon")
	self._resourceItem.imageicon = gohelper.findChildImage(self._resourceItem.go, "sicon")
	self._resourceItem._animator = self._resourceItem.go:GetComponent(typeof(UnityEngine.Animator))

	if self._param.initAnim then
		self._resourceItem._animator:Play(self._param.initAnim, 0, 0)
	end

	if self._item.type == MaterialEnum.MaterialType.Item then
		local config
		local var_2_0, var_2_1 = ItemModel.instance:getItemConfigAndIcon(self._item.type, self._item.id)

		config = var_2_0

		self._resourceItem.simageicon:LoadImage(var_2_1)
		gohelper.setActive(self._resourceItem.simageicon.gameObject, true)
		gohelper.setActive(self._resourceItem.imageicon.gameObject, false)
	elseif self._item.type == MaterialEnum.MaterialType.Currency then
		local currencyConfig = CurrencyConfig.instance:getCurrencyCo(self._item.id)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._resourceItem.imageicon, currencyConfig.icon .. "_1")
		gohelper.setActive(self._resourceItem.simageicon.gameObject, false)
		gohelper.setActive(self._resourceItem.imageicon.gameObject, true)
	else
		logError("暂不支持显示其他类型")
	end

	self:addEventListeners()
	self:_setShow(not self._onlyShowEvent)
	self:_refreshUI(false)

	if self._onlyShowEvent or self._supportFlyEffect then
		self._tweenEventParamList = {}
	end
end

function RoomViewTopRightMaterialItem:_checkListeningItems(itemType, itemId)
	if self._listeningItems then
		for i, listeningItem in ipairs(self._listeningItems) do
			if listeningItem.type == itemType and listeningItem.id == itemId then
				return true
			end
		end
	end

	return false
end

function RoomViewTopRightMaterialItem:_onClick()
	MaterialTipController.instance:showMaterialInfo(self._item.type, self._item.id)
end

function RoomViewTopRightMaterialItem:addEventListeners()
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._updateItem, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._updateItem, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIFlyEffect, self._uiFlyEffect, self)
end

function RoomViewTopRightMaterialItem:removeEventListeners()
	return
end

function RoomViewTopRightMaterialItem:_uiFlyEffect(param)
	if not self._onlyShowEvent and not self._supportFlyEffect then
		return
	end

	local itemType = param.itemType
	local itemId = param.itemId

	if not self:_checkListeningItems(itemType, itemId) then
		return
	end

	local flySelf = itemType == self._item.type and itemId == self._item.id
	local quantity = ItemModel.instance:getItemQuantity(self._item.type, self._item.id)

	if not self._isCurShow then
		if flySelf then
			self:_setQuantity(param.startQuantity)
		else
			self:_setQuantity(quantity)
		end
	end

	self:_setShow(true)

	local showTime = 3

	TaskDispatcher.cancelTask(self._playCloseAnim, self)
	TaskDispatcher.runDelay(self._playCloseAnim, self, showTime - 0.2)
	TaskDispatcher.cancelTask(self._hideShow, self)
	TaskDispatcher.runDelay(self._hideShow, self, showTime)

	if flySelf then
		UIBlockMgr.instance:endAll()

		local tweenEventParam = self:getUserDataTb_()

		self._startTime = self._supportFlyEffect and 0 or 0.66
		self._duration = 0.4
		self._endTime = 0.93
		self._allTime = self._startTime + self._duration + self._endTime

		TaskDispatcher.cancelTask(self._blockTouch, self)
		TaskDispatcher.runDelay(self._blockTouch, self, self._allTime)

		tweenEventParam.tweenId = self._scene.tween and self._scene.tween:tweenFloat(0, self._allTime, self._allTime, self._tweenEventFrameCallback, self._tweenEventFinishCallback, self, {
			paramIndex = #self._tweenEventParamList + 1,
			startPos = param.startPos,
			startQuantity = param.startQuantity,
			endQuantity = quantity
		}) or ZProj.TweenHelper.DOTweenFloat(0, self._allTime, self._allTime, self._tweenEventFrameCallback, self._tweenEventFinishCallback, self, {
			paramIndex = #self._tweenEventParamList + 1,
			startPos = param.startPos,
			startQuantity = param.startQuantity,
			endQuantity = quantity
		})

		table.insert(self._tweenEventParamList, tweenEventParam)
	end
end

function RoomViewTopRightMaterialItem:_tweenEventFrameCallback(value, param)
	local tweenEventParam = self._tweenEventParamList[param.paramIndex]

	if value <= self._startTime then
		return
	end

	if value < self._allTime then
		if not tweenEventParam.effect then
			tweenEventParam.effect = true

			gohelper.setActive(self._resourceItem.goeffect, false)
			gohelper.setActive(self._resourceItem.goeffect, true)
		end

		tweenEventParam.flyGO = tweenEventParam.flyGO or self:_getFlyGO()

		local endPos = self._resourceItem.goflypos.transform.position
		local flyGO = tweenEventParam.flyGO
		local lerp = Mathf.Clamp((value - self._startTime) / self._duration, 0, 1)
		local posX = Mathf.Lerp(param.startPos.x, endPos.x, lerp)
		local posY = Mathf.Lerp(param.startPos.y, endPos.y, lerp)
		local posZ = Mathf.Lerp(param.startPos.z, endPos.z, lerp)

		transformhelper.setPos(flyGO.transform, posX, posY, posZ)
	end

	if value > self._startTime + self._duration and not tweenEventParam.hasStartedQuantity then
		if self._tweenId then
			if self._scene.tween then
				self._scene.tween:killById(self._tweenId)
			else
				ZProj.TweenHelper.KillById(self._tweenId)
			end

			self._tweenId = nil
		end

		self._tweenId = self._scene.tween and self._scene.tween:tweenFloat(0, 2, 2, self._tweenFrameCallback, self._tweenFinishCallback, self, {
			startQuantity = param.startQuantity,
			endQuantity = param.endQuantity
		}) or ZProj.TweenHelper.DOTweenFloat(0, 2, 2, self._tweenFrameCallback, self._tweenFinishCallback, self, {
			startQuantity = param.startQuantity,
			endQuantity = param.endQuantity
		})
		tweenEventParam.hasStartedQuantity = true
	end

	if value >= self._allTime then
		gohelper.setActive(self._resourceItem.goeffect, false)

		if tweenEventParam.flyGO then
			self:_returnFlyGO(tweenEventParam.flyGO)

			tweenEventParam.flyGO = nil
		end
	end
end

function RoomViewTopRightMaterialItem:_tweenEventFinishCallback(param)
	self:_tweenEventFrameCallback(2, param)
end

function RoomViewTopRightMaterialItem:_playCloseAnim()
	if not self._supportFlyEffect then
		self._resourceItem._animator:Play("close", 0, 0)
	end
end

function RoomViewTopRightMaterialItem:_hideShow()
	self:_setShow(self._supportFlyEffect)
end

function RoomViewTopRightMaterialItem:_setShow(isShow)
	self._isCurShow = isShow

	RoomViewTopRightMaterialItem.super._setShow(self, isShow)
end

function RoomViewTopRightMaterialItem:_blockTouch()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("roomProductionBubbleGetReward")
end

function RoomViewTopRightMaterialItem:_updateItem()
	if self._onlyShowEvent then
		return
	end

	self:_refreshUI(true)
end

function RoomViewTopRightMaterialItem:_refreshUI(tween)
	if self._tweenId then
		if self._scene.tween then
			self._scene.tween:killById(self._tweenId)
		else
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		self._tweenId = nil
	end

	local quantity = ItemModel.instance:getItemQuantity(self._item.type, self._item.id)

	if tween then
		self._tweenId = self._scene.tween and self._scene.tween:tweenFloat(0, 2, 2, self._tweenFrameCallback, self._tweenFinishCallback, self, {
			startQuantity = self._quantity,
			endQuantity = quantity
		}) or ZProj.TweenHelper.DOTweenFloat(0, 2, 2, self._tweenFrameCallback, self._tweenFinishCallback, self, {
			startQuantity = self._quantity,
			endQuantity = quantity
		})
	else
		self:_setQuantity(quantity)
	end
end

function RoomViewTopRightMaterialItem:_tweenFrameCallback(value, param)
	self:_setQuantity((value >= 1 or nil) and param.endQuantity)
end

function RoomViewTopRightMaterialItem:_setQuantity(quantity)
	quantity = math.floor(quantity)
	self._resourceItem.txtquantity.text = GameUtil.numberDisplay(quantity)
	self._quantity = quantity
end

function RoomViewTopRightMaterialItem:_tweenFinishCallback()
	local quantity = ItemModel.instance:getItemQuantity(self._item.type, self._item.id)

	self._resourceItem.txtquantity.text = GameUtil.numberDisplay(quantity)
	self._quantity = quantity
end

function RoomViewTopRightMaterialItem:_customOnDestory()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("roomProductionBubbleGetReward")
	TaskDispatcher.cancelTask(self._blockTouch, self)
	self._resourceItem.simageicon:UnLoadImage()

	if self._tweenId then
		if self._scene.tween then
			self._scene.tween:killById(self._tweenId)
		else
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		self._tweenId = nil
	end

	if self._tweenEventParamList then
		for i, tweenEventParam in ipairs(self._tweenEventParamList) do
			if self._scene.tween then
				self._scene.tween:killById(tweenEventParam.tweenId)
			else
				ZProj.TweenHelper.KillById(tweenEventParam.tweenId)
			end

			if tweenEventParam.flyGO then
				self:_returnFlyGO(tweenEventParam.flyGO)

				tweenEventParam = nil
			end
		end
	end

	TaskDispatcher.cancelTask(self._playCloseAnim, self)
	TaskDispatcher.cancelTask(self._hideShow, self)
end

function RoomViewTopRightMaterialItem:_getFlyGO()
	return self._parent:getFlyGO()
end

function RoomViewTopRightMaterialItem:_returnFlyGO(flyGO)
	self._parent:returnFlyGO(flyGO)
end

return RoomViewTopRightMaterialItem
