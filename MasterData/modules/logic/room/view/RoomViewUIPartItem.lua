-- chunkname: @modules/logic/room/view/RoomViewUIPartItem.lua

module("modules.logic.room.view.RoomViewUIPartItem", package.seeall)

local RoomViewUIPartItem = class("RoomViewUIPartItem", RoomViewUIBaseItem)

function RoomViewUIPartItem:ctor(partId)
	RoomViewUIPartItem.super.ctor(self)

	self._partId = partId
end

function RoomViewUIPartItem:_customOnInit()
	self._txtbuildingname = gohelper.findChildText(self._gocontainer, "bottom/txt_buildingName")
	self._goskinreddot = gohelper.findChild(self._gocontainer, "bottom/#go_reddot")
	self._gobubbleContent = gohelper.findChild(self._gocontainer, "#go_bubbleContent")
	self._goawarn = gohelper.findChild(self._gocontainer, "state/#go_warn")
	self._gostop = gohelper.findChild(self._gocontainer, "state/#go_stop")
	self._goadd = gohelper.findChild(self._gocontainer, "state/#go_add")
	self._txtcount = gohelper.findChildText(self._gocontainer, "count/txt_count")
	self._gotxtcount = gohelper.findChild(self._gocontainer, "count")
	self._txtper = gohelper.findChildText(self._gocontainer, "count/txt_count/txt")
	self._simagegathericon = gohelper.findChildSingleImage(self._gocontainer, "simage_gathericon")
	self._simagebuildingicon = gohelper.findChildSingleImage(self._gocontainer, "simage_buildingicon")
	self._goroomgifticon = gohelper.findChild(self._gocontainer, "simage_actroomicon")
	self._goreddot = gohelper.findChild(self._gocontainer, "count/txt_count/go_reddot")
	self._goupgrade = gohelper.findChild(self._gocontainer, "#go_upgrade")
	self._gobg = gohelper.findChild(self._gocontainer, "count/bg")
	self._gobg1 = gohelper.findChild(self._gocontainer, "count/bg1")
	self._gobubbleitem = gohelper.findChild(self._gocontainer, "bubbleContent/#go_bubbleitem")

	gohelper.setActive(self._gobubbleitem, false)

	self._bubbleGOList = self:getUserDataTb_()
	self._isPlayAnimation = false
	self._animator = self._gocontainer:GetComponent(typeof(UnityEngine.Animator))

	local newSkinReddot = RoomInitBuildingEnum.InitBuildingSkinReddot[self._partId]

	if newSkinReddot then
		RedDotController.instance:addRedDot(self._goskinreddot, newSkinReddot)
	end
end

function RoomViewUIPartItem:_customAddEventListeners()
	self:refreshUI(true)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, self.refreshUI, self)
	RoomController.instance:registerCallback(RoomEvent.ProduceLineLevelUp, self._refreshUpgradeUI, self)
	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, self._updateProduceLineData, self)
	RoomController.instance:registerCallback(RoomEvent.GainProductionLineReply, self._gainProductionLineCallback, self)
	RoomMapController.instance:registerCallback(RoomEvent.GuideTouchUIPart, self._onGuideTouchUIPart, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshRelateDot, self)
end

function RoomViewUIPartItem:_customRemoveEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, self.refreshUI, self)
	RoomController.instance:unregisterCallback(RoomEvent.ProduceLineLevelUp, self._refreshUpgradeUI, self)
	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, self._updateProduceLineData, self)
	RoomController.instance:unregisterCallback(RoomEvent.GainProductionLineReply, self._gainProductionLineCallback, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.GuideTouchUIPart, self._onGuideTouchUIPart, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshRelateDot, self)
end

function RoomViewUIPartItem:refreshRelateDot(dict)
	for id, _ in pairs(dict) do
		if id == RedDotEnum.DotNode.RoomProductionFull or id == RedDotEnum.DotNode.RoomProductionLevel then
			self:_refreshReddot()

			break
		end
	end

	for id, _ in pairs(dict) do
		if id == RedDotEnum.DotNode.RoomProductionLevel then
			self:_refreshUpgradeUI()

			break
		end
	end
end

function RoomViewUIPartItem:refreshUI(isInit)
	self:_refreshBubble()
	self:_refreshShow(isInit)
	self:_refreshPosition()
	self:_refreshUpgradeUI()
end

function RoomViewUIPartItem:_refreshUpgradeUI()
	local canLevelUp = self:_canLeveUP()

	gohelper.setActive(self._goupgrade, canLevelUp)
end

function RoomViewUIPartItem:_canLeveUP()
	local partConfig = RoomConfig.instance:getProductionPartConfig(self._partId)

	if partConfig then
		for i, proLineId in ipairs(partConfig.productionLines) do
			if self:_checkProductionLineLeveUP(proLineId) then
				return true
			end
		end
	end

	return false
end

function RoomViewUIPartItem:_checkProductionLineLeveUP(proLineId)
	local mo = RoomProductionModel.instance:getLineMO(proLineId)

	if not mo or mo:isLock() or mo.level >= mo.maxLevel or mo.level >= mo.maxConfigLevel then
		return false
	end

	local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(mo.config.levelGroup, mo.level + 1)

	if levelGroupConfig == nil then
		return false
	end

	if not string.nilorempty(levelGroupConfig.cost) then
		local costParam = GameUtil.splitString2(levelGroupConfig.cost, true)

		for i, param in ipairs(costParam) do
			local costType = param[1]
			local costId = param[2]
			local costNum = param[3]
			local hasQuantity = ItemModel.instance:getItemQuantity(costType, costId)

			if hasQuantity < costNum then
				return false
			end
		end
	end

	return true
end

function RoomViewUIPartItem:_updateProduceLineData()
	if self._isPlayAnimation then
		return
	end

	self:_refreshBubble()
end

function RoomViewUIPartItem:_refreshPartInfo()
	local partConfig = RoomConfig.instance:getProductionPartConfig(self._partId)

	self._lineMOList = {}

	for i, v in ipairs(partConfig.productionLines) do
		local lineMO = RoomProductionModel.instance:getLineMO(v)

		if lineMO:isLock() == false then
			table.insert(self._lineMOList, lineMO)
		end
	end

	self._txtbuildingname.text = partConfig.name
end

function RoomViewUIPartItem:_refreshBubble(aim)
	gohelper.setActive(self._goroomgifticon, false)
	self:_refreshPartInfo()

	if not self._isPlayAnimation then
		TaskDispatcher.cancelTask(self._newBubble, self)
		TaskDispatcher.cancelTask(self._refreshNewData, self)
		TaskDispatcher.cancelTask(self._animationDone, self)
		self._animator:Play("idel", 0, 0)
	end

	table.sort(self._lineMOList, function(a, b)
		local perA = a:getReservePer()
		local perB = b:getReservePer()

		if perA ~= perB then
			return perA < perB
		end

		return a.id > b.id
	end)

	local lineMO = self._lineMOList[#self._lineMOList]

	if lineMO then
		local per, per100 = lineMO:getReservePer()

		self._txtcount.text = per100

		local isFull = lineMO:isFull()
		local isProduct = lineMO.config.logic == RoomProductLineEnum.ProductType.Product
		local isChange = lineMO.config.logic == RoomProductLineEnum.ProductType.Change

		gohelper.setActive(self._goawarn, false)
		gohelper.setActive(self._gostop, false)
		gohelper.setActive(self._simagebuildingicon.gameObject, isChange)
		gohelper.setActive(self._simagegathericon.gameObject, isProduct)

		if isChange then
			gohelper.setActive(self._gobg, false)
			gohelper.setActive(self._gobg1, false)

			self._txtcount.text = ""
			self._txtper.text = ""

			self._simagebuildingicon:LoadImage(ResUrl.getRoomImage("productline/icon_2"))
		else
			self._txtper.text = "%"

			local formulaId = lineMO.formulaId
			local formulaConfig = RoomConfig.instance:getFormulaConfig(formulaId)
			local produceItemParams = formulaConfig and RoomProductionHelper.getFormulaItemParamList(formulaConfig.produce)
			local produceItemParam = produceItemParams and produceItemParams[1]
			local icon

			if produceItemParam then
				local config

				config, icon = ItemModel.instance:getItemConfigAndIcon(produceItemParam.type, produceItemParam.id)
			end

			if icon then
				self._simagegathericon:LoadImage(icon)
			end
		end
	end

	self:_refreshReddot()

	if not self._isPlayAnimation then
		for i = 1, #self._lineMOList - 1 do
			local bubbleGO = self._bubbleGOList[i]

			if not bubbleGO then
				bubbleGO = gohelper.cloneInPlace(self._gobubbleitem, "item" .. i)

				table.insert(self._bubbleGOList, bubbleGO)
			end

			gohelper.setActive(bubbleGO, true)

			local animator = bubbleGO:GetComponent(typeof(UnityEngine.Animator))

			animator:Play(UIAnimationName.Idle, 0, 0)
		end

		for i = #self._lineMOList, #self._bubbleGOList do
			local bubbleGO = self._bubbleGOList[i]

			if bubbleGO then
				gohelper.setActive(bubbleGO, false)
			end
		end
	end
end

function RoomViewUIPartItem:_refreshReddot()
	local partConfig = RoomConfig.instance:getProductionPartConfig(self._partId)
	local lineIdList = partConfig.productionLines
	local fullRedDotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomProductionFull)
	local show = false

	for i, lineId in ipairs(lineIdList) do
		if fullRedDotInfo and fullRedDotInfo.infos and fullRedDotInfo.infos[lineId] and fullRedDotInfo.infos[lineId].value > 0 then
			show = true

			break
		end
	end

	gohelper.setActive(self._goreddot, show)
end

function RoomViewUIPartItem:_refreshShow(isInit)
	if not RoomProductionHelper.hasUnlockLine(self._partId) then
		self:_setShow(false, true)

		return
	end

	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		self:_setShow(false, isInit)

		return
	end

	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Overlook and cameraState ~= RoomEnum.CameraState.OverlookAll then
		self:_setShow(false, isInit)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		self:_setShow(false, isInit)

		return
	end

	self:_setShow(true, isInit)
end

function RoomViewUIPartItem:getUI3DPos()
	local partContainerGO = self._scene.buildingmgr:getPartContainerGO(self._partId)
	local position = RoomBuildingHelper.getCenterPosition(partContainerGO)
	local worldPos = Vector3(position.x, 0.5, position.z)

	return (RoomBendingHelper.worldToBendingSimple(worldPos))
end

function RoomViewUIPartItem:_onGuideTouchUIPart(partId)
	if tonumber(partId) == self._partId then
		self:_onClick()
	end
end

function RoomViewUIPartItem:_onClick(go, param)
	if self._isPlayAnimation then
		return
	end

	local getReward = self:_getReward()

	if getReward then
		RoomSceneTaskController.instance:showHideRoomTopTaskUI(true)

		return
	end

	RoomMapController.instance:openRoomInitBuildingView(0.2, {
		partId = self._partId
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_admission_open)
end

function RoomViewUIPartItem:_getReward()
	if self._iscustomDestory then
		return false
	end

	local lineIdList, formulaId

	for i = #self._lineMOList, 1, -1 do
		local lineMO = self._lineMOList[i]

		if lineMO:isCanGain() then
			lineIdList = lineIdList or {}

			table.insert(lineIdList, lineMO.id)

			formulaId = lineMO.formulaId
			self._isPlayAnimation = true
			self._curGainLineMOId = lineMO.id
		end
	end

	if lineIdList then
		self._flyEffectRewardInfo = RoomProductionHelper.getFormulaRewardInfo(formulaId)

		RoomRpc.instance:sendGainProductionLineRequest(lineIdList, true)

		return true
	end

	return false
end

function RoomViewUIPartItem:_gainProductionLineCallback(resultCode, lineIds)
	if self._iscustomDestory or not self._flyEffectRewardInfo or not self._curGainLineMOId then
		return
	end

	if not lineIds or not tabletool.indexOf(lineIds, self._curGainLineMOId) then
		return
	end

	self._curGainLineMOId = nil

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_collect_bubble)
	TaskDispatcher.cancelTask(self._newBubble, self)
	TaskDispatcher.cancelTask(self._refreshNewData, self)
	TaskDispatcher.cancelTask(self._animationDone, self)
	TaskDispatcher.cancelTask(RoomSceneTaskController.instance.showHideRoomTopTaskUI, RoomSceneTaskController.instance)
	TaskDispatcher.runDelay(RoomSceneTaskController.instance.showHideRoomTopTaskUI, RoomSceneTaskController.instance, 3.5)

	if resultCode ~= 0 then
		self:_animationDone(true)

		return
	end

	self._animator:Play(UIAnimationName.Switch, 0, 0)

	local firstBubbleGO = self._bubbleGOList[1]

	if firstBubbleGO and firstBubbleGO.activeSelf then
		local animator = firstBubbleGO:GetComponent(typeof(UnityEngine.Animator))

		animator:Play(UIAnimationName.Switch, 0, 0)
		TaskDispatcher.runDelay(self._newBubble, self, 1.2)
	end

	self:_flyEffect()
	RoomSceneTaskController.instance:showHideRoomTopTaskUI(true)
	TaskDispatcher.runDelay(self._refreshNewData, self, 0.95)
	TaskDispatcher.runDelay(self._animationDone, self, 1.5)
end

function RoomViewUIPartItem:_flyEffect()
	if not self._flyEffectRewardInfo then
		return
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UIFlyEffect, {
		startPos = self._simagegathericon.gameObject.transform.position,
		itemType = self._flyEffectRewardInfo.type,
		itemId = self._flyEffectRewardInfo.id,
		startQuantity = self._flyEffectRewardInfo.quantity
	})

	self._flyEffectRewardInfo = nil
end

function RoomViewUIPartItem:_newBubble()
	local count = #self._lineMOList - 1
	local newBubbleGO = self._bubbleGOList[count + 1]

	if not newBubbleGO then
		newBubbleGO = gohelper.cloneInPlace(self._gobubbleitem, "item" .. count + 1)

		table.insert(self._bubbleGOList, newBubbleGO)
	end

	gohelper.setActive(newBubbleGO, true)

	local animator = newBubbleGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play(UIAnimationName.Open, 0, 0)
end

function RoomViewUIPartItem:_refreshNewData()
	self:_refreshBubble()
end

function RoomViewUIPartItem:_animationDone(onlyOnce)
	TaskDispatcher.cancelTask(self._newBubble, self)
	TaskDispatcher.cancelTask(self._refreshNewData, self)
	TaskDispatcher.cancelTask(self._animationDone, self)

	self._isPlayAnimation = false

	self:_refreshBubble()

	if not onlyOnce then
		self:_getReward()
	end
end

function RoomViewUIPartItem:_showTopTaskUI()
	RoomSceneTaskController.instance:showHideRoomTopTaskUI(false)
end

function RoomViewUIPartItem:_customOnDestory()
	self._iscustomDestory = true

	TaskDispatcher.cancelTask(self._newBubble, self)
	TaskDispatcher.cancelTask(self._refreshNewData, self)
	TaskDispatcher.cancelTask(self._animationDone, self)

	if self._simagegathericon then
		self._simagegathericon:UnLoadImage()

		self._simagegathericon = nil
	end

	if self._simagebuildingicon then
		self._simagebuildingicon:UnLoadImage()

		self._simagebuildingicon = nil
	end

	if self._bubbleGOList then
		for i, bubbleGO in ipairs(self._bubbleGOList) do
			gohelper.destroy(bubbleGO)
		end

		self._bubbleGOList = nil
	end
end

return RoomViewUIPartItem
