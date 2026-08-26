-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameView.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameView", package.seeall)

local DianJiShiGameView = class("DianJiShiGameView", BaseView)

function DianJiShiGameView:onInitView()
	self._goWaitArea = gohelper.findChild(self.viewGO, "#go_Root/#go_WaitArea")
	self._scrollWaitBlock = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_WaitArea/#scroll_WaitBlock")
	self._goWaitBlockContent = gohelper.findChild(self.viewGO, "#go_Root/#go_WaitArea/#scroll_WaitBlock/Viewport/Content")
	self._goWaitBlockItem = gohelper.findChild(self.viewGO, "#go_Root/#go_WaitArea/#scroll_WaitBlock/Viewport/Content/#go_WaitBlockItem")
	self._goCommonBlockItem = gohelper.findChild(self.viewGO, "#go_Root/#go_BlockItem")
	self._goScale = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale")
	self._goDragBlockItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_DragArea/#go_DragBlockItem")
	self._goPlaceArea = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_PlaceArea")
	self._goPlaceCubeItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_PlaceArea/#go_PlaceCubeItem")
	self._goRight = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale")
	self._goDragArea = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_DragArea")
	self._goLineArea = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_LineArea")
	self._goLineItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_LineArea/#go_LineItem")
	self._goMapArea = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_MapArea")
	self._goMapAreaItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_MapArea/#go_MapAreaItem")
	self._btnRollback = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/Left/#btn_Rollback")
	self._goNormalRollback = gohelper.findChild(self.viewGO, "#go_Root/Left/#btn_Rollback/#go_NormalRollback")
	self._goNotRollback = gohelper.findChild(self.viewGO, "#go_Root/Left/#btn_Rollback/#go_NotRollback")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/Left/#btn_Reset")
	self._goLightReset = gohelper.findChild(self.viewGO, "#go_Root/Left/#btn_Reset/#go_LightReset")
	self._goNormalReset = gohelper.findChild(self.viewGO, "#go_Root/Left/#btn_Reset/#go_NormalReset")
	self._goNotReset = gohelper.findChild(self.viewGO, "#go_Root/Left/#btn_Reset/#go_NotReset")
	self._goFailed = gohelper.findChild(self.viewGO, "#go_Root/#go_Failed")
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_Root/#go_Success")
	self._btnHelp = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/Left/#btn_Help")
	self._goCanHelp = gohelper.findChild(self.viewGO, "#go_Root/Left/#btn_Help/#go_CanHelp")
	self._goNotHelp = gohelper.findChild(self.viewGO, "#go_Root/Left/#btn_Help/#go_NotHelp")
	self._txtTargetDesc = gohelper.findChildText(self.viewGO, "#go_Root/Left/Target/#txt_TargetDescr")
	self._goTagetStar1 = gohelper.findChild(self.viewGO, "#go_Root/Left/Target/TargetStar/#go_TargetStar1")
	self._goTagetStar2 = gohelper.findChild(self.viewGO, "#go_Root/Left/Target/TargetStar/#go_TargetStar2")
	self._goFinishEffect = gohelper.findChild(self.viewGO, "#go_Root/Left/Target/#saoguang")
	self._simageMap = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#go_Left/#simage_Map")
	self._imageMap = gohelper.findChildImage(self.viewGO, "#go_Root/#go_Left/#simage_Map")
	self._goStart = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#simage_Map/#go_Start")
	self._goHelpArea = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_HelpArea")
	self._goHelpLineItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_HelpArea/#go_HelpLineItem")
	self._goShadowArea = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_ShadowArea")
	self._goShadowItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_ShadowArea/#go_ShadowItem")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_Success/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DianJiShiGameView:addEvents()
	self._btnRollback:AddClickListener(self._btnRollbackOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnHelp:AddClickListener(self._btnHelpOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnPlaceBlockDone, self._onAfterPlaceBlockOp, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnPlaceBlockError, self._onAfterPlaceBlockOp, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnBeginDragBlock, self._onBeginDragBlock, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnDragBlock, self._onDragBlock, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnEndDragBlock, self._onEndDragBlock, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnUpdateGameStatus, self._onUpdateGameStatus, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnHelpPlaceBlock, self._onHelpPlaceBlock, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnMapAreaValueNotFit, self._onMapAreaValueNotFit, self)
end

function DianJiShiGameView:removeEvents()
	self._btnRollback:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function DianJiShiGameView:_btnRollbackOnClick()
	if DianJiShiGameModel.instance:isDraging() then
		return
	end

	DianJiShiGameController.instance:rollBack()
end

function DianJiShiGameView:_btnResetOnClick()
	if DianJiShiGameModel.instance:isDraging() then
		return
	end

	local status = DianJiShiGameModel.instance:getGameStatus()

	if status ~= DianJiShiGameEnum.GameStatus.Failed then
		GameFacade.showMessageBox(MessageBoxIdDefine.DianJiShiGameReset, MsgBoxEnum.BoxType.Yes_No, self._reallyStartReset, nil, nil, self)

		return
	end

	self:_reallyStartReset()
end

function DianJiShiGameView:_reallyStartReset()
	self._curOpBlockInfo = nil
	self._curOpBlockId = nil

	DianJiShiGameController.instance:reset()
end

function DianJiShiGameView:_btnHelpOnClick()
	if DianJiShiGameModel.instance:isDraging() then
		return
	end

	local nextHelpBlock, nextHelpBlockRightPos = DianJiShiGameController.instance:getNextHelpBlockInfo()

	if not nextHelpBlock or not nextHelpBlockRightPos then
		GameFacade.showToast(ToastEnum.DianJiShiNotHelp)

		return
	end

	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnHelpPlaceBlock, nextHelpBlock, nextHelpBlockRightPos)
end

function DianJiShiGameView:_btnCloseOnClick()
	if self._isSucc then
		DianJiShiStatController.instance:sendGameSettle()
		DianJiShiLevelController.instance:_onGameFinished(self._actId, self._episodeId)

		return
	end

	self:closeThis()
	DianJiShiStatController.instance:sendGameAbort()
end

function DianJiShiGameView:_editableInitView()
	self._tempFilterCellList = {}
	self._tempFilterAreaMap = {}
	self._lightBlockPos = {}
	self._goScrollWaitBlock = self._scrollWaitBlock.gameObject
	self._tranWaitBlockContent = self._scrollWaitBlock.content
	self._failedAnim = ZProj.ProjAnimatorPlayer.Get(self._goFailed)
	self._showPassAreaNum = 0

	gohelper.setActive(self._goDragBlockItem, false)
	gohelper.setActive(self._goLineArea, false)
	recthelper.setAnchor(self._goCommonBlockItem.transform, 0, 0)
	gohelper.setActive(self._goCommonBlockItem, false)
	gohelper.setActive(self._goHelpArea, false)
	gohelper.setActive(self._goHelpLineItem, false)
	gohelper.setActive(self._goShadowArea, false)
	NavigateMgr.instance:addEscape(self.viewName, self._btnCloseOnClick, self)

	if self.viewContainer then
		local navigateButtonView = self.viewContainer:getNavigateButtonView()

		if self.viewContainer then
			self.viewContainer:setOverrideClose(self._btnCloseOnClick, self)
		end
	end
end

function DianJiShiGameView:onOpen()
	self._actId = self.viewParam and self.viewParam.actId
	self._episodeId = self.viewParam and self.viewParam.episodeId
	self._gameId = self.viewParam and self.viewParam.gameId
	self._gameCo = DianJiShiGameConfig.instance:getGameConfig(self._gameId)

	DianJiShiGameModel.instance:initGame(self._gameId)
	self:initMapIconAndPos()
	self:initPlaceAreaPos()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum3_8.DianJiShi.EnterGame)
	DianJiShiStatController.instance:enterGame(self._episodeId)
end

function DianJiShiGameView:initPlaceAreaPos()
	local startPosX, startPosY = recthelper.rectToRelativeAnchorPos2(self._goStart.transform.position, self._goRight.transform)

	recthelper.setAnchor(self._goPlaceArea.transform, startPosX, startPosY)
	recthelper.setAnchor(self._goDragArea.transform, startPosX, startPosY)
	recthelper.setAnchor(self._goLineArea.transform, startPosX, startPosY)
	recthelper.setAnchor(self._goMapArea.transform, startPosX, startPosY)
	recthelper.setAnchor(self._goHelpArea.transform, startPosX, startPosY)
	recthelper.setAnchor(self._goShadowArea.transform, startPosX, startPosY)
end

function DianJiShiGameView:initMapIconAndPos()
	if self._gameCo then
		if not self._gameCo.mapScale then
			local mapScale = 1000

			mapScale = mapScale / 1000

			transformhelper.setLocalScale(self._goScale.transform, mapScale or 1, mapScale or 1, 1)

			if self._gameCo then
				self._simageMap:LoadImage(ResUrl.getV3a8DianJiShiSingleBg(self._gameCo), self._onLoadBgDone, self)

				if self._gameCo then
					local startPosList = string.splitToNumber(self._gameCo, "#") or {}

					recthelper.setAnchor(self._goStart.transform, startPosList[1] or 0, startPosList[2] or 0)
				end
			end
		end
	end
end

function DianJiShiGameView:_onLoadBgDone()
	self._imageMap:SetNativeSize()
	self:initPlaceAreaPos()
	self:refreshUI()
end

function DianJiShiGameView:refreshUI()
	gohelper.setActive(self._goDragBlockItem, false)
	gohelper.setActive(self._goHelpArea, false)
	self:refreshStatusUI()
	self:refreshMapArea()
	self:refreshWaitArea()
	self:refreshPlaceArea()
	self:refreshShadowArea()
end

function DianJiShiGameView:refreshStatusUI()
	self._passAreaNum = DianJiShiGameModel.instance:getPassMapAreaInfoNum()

	self:refreshTargetDesc(self._passAreaNum)

	self._curStatus = DianJiShiGameModel.instance:getGameStatus()

	local isSuccess = self._curStatus == DianJiShiGameEnum.GameStatus.Success
	local isFailed = self._curStatus == DianJiShiGameEnum.GameStatus.Failed

	gohelper.setActive(self._goSuccess, isSuccess)
	gohelper.setActive(self._goFailed, true)

	if isFailed and not self._isFailedTipsVisible then
		self._failedAnim:Play("open", self._onPlayOpenFailedTipsAnimDone, self)
	elseif not isFailed and self._isFailedTipsVisible then
		self._failedAnim:Play("close", self._onPlayCloseFailedTipsAnimDone, self)
	else
		gohelper.setActive(self._goFailed, isFailed)
	end

	gohelper.setActive(self._goTagetStar1, not isSuccess)
	gohelper.setActive(self._goTagetStar2, isSuccess)
	gohelper.setActive(self._goFinishEffect, isSuccess)
	gohelper.setActive(self._goLightReset, isFailed)

	local isCanRollback = DianJiShiGameModel.instance:isCanRollback()

	gohelper.setActive(self._goNormalRollback, isCanRollback)
	gohelper.setActive(self._goNotRollback, not isCanRollback)
	gohelper.setActive(self._goNotReset, not isCanRollback)
	gohelper.setActive(self._goNormalReset, isCanRollback)

	local canHelp = DianJiShiGameController.instance:getNextHelpBlockInfo() ~= nil

	gohelper.setActive(self._goCanHelp, canHelp)
	gohelper.setActive(self._goNotHelp, not canHelp)

	self._isSucc = isSuccess

	GameUtil.setActiveUIBlock(self.viewName, false, true)

	if self._isSucc then
		GameUtil.setActiveUIBlock(self.viewName, true, false)
		AudioMgr.instance:trigger(AudioEnum3_8.DianJiShi.OnGameFinished)
		AudioMgr.instance:trigger(AudioEnum3_8.DianJiShi.OnGameCompleted)
		TaskDispatcher.runDelay(self._playGameSuccEffectDone, self, 1)
	end
end

function DianJiShiGameView:_playGameSuccEffectDone()
	GameUtil.setActiveUIBlock(self.viewName, false, true)
end

function DianJiShiGameView:refreshTargetDesc(passAreaNum)
	local allAreaNum = DianJiShiGameModel.instance:getMapAreaInfoNum()
	local isFinish = allAreaNum <= passAreaNum

	if self._gameCo then
		local targetDesc = self._gameCo.targetDesc

		if isFinish then
			if not DianJiShiGameEnum.FinishCountColor then
				local descColor = DianJiShiGameEnum.UnfinishCountColor

				self._txtTargetDesc.text = GameUtil.getSubPlaceholderLuaLangThreeParam(targetDesc, descColor, passAreaNum, allAreaNum)
				self._showPassAreaNum = passAreaNum
			end
		end
	end
end

function DianJiShiGameView:_onPlayOpenFailedTipsAnimDone()
	self._isFailedTipsVisible = true
end

function DianJiShiGameView:_onPlayCloseFailedTipsAnimDone()
	gohelper.setActive(self._goFailed, false)

	self._isFailedTipsVisible = false
end

function DianJiShiGameView:refreshMapArea()
	local areaInfoList = DianJiShiGameModel.instance:getMapAreaInfoList()

	gohelper.CreateObjList(self, self._refreshMapAreaItem, areaInfoList, self._goMapArea, self._goMapAreaItem, DianJiShiGameMapAreaItem)
end

function DianJiShiGameView:_refreshMapAreaItem(areaItem, areaInfo, index)
	areaItem:onUpdateMO(areaInfo, index)
end

function DianJiShiGameView:refreshPlaceArea()
	local tempPlaceCubeInfo = DianJiShiGameModel.instance:getPlaceCubeInfoList()
	local placeInfoList = {}

	tabletool.addValues(placeInfoList, tempPlaceCubeInfo)

	local hasPlaceCube = placeInfoList and #placeInfoList > 0

	gohelper.setActive(self._goPlaceArea, hasPlaceCube)

	if not hasPlaceCube then
		return
	end

	table.sort(placeInfoList, self._placeCubeInfoSortFunc)
	gohelper.CreateObjList(self, self._refreshPlaceCubeItem, placeInfoList, self._goPlaceArea, self._goPlaceCubeItem, DianJiShiGamePlaceCubeItem)
end

function DianJiShiGameView:_refreshPlaceCubeItem(placeCubeItem, cubeInfo, index)
	local putAnim = cubeInfo.blockId == self._curOpBlockId

	placeCubeItem:onUpdateMO(cubeInfo, index, putAnim)
end

function DianJiShiGameView._placeCubeInfoSortFunc(aCubeInfo, bCubeInfo)
	if aCubeInfo.posIndex[1] ~= bCubeInfo.posIndex[1] then
		return aCubeInfo.posIndex[1] < bCubeInfo.posIndex[1]
	end

	if aCubeInfo.posIndex[2] ~= bCubeInfo.posIndex[2] then
		return aCubeInfo.posIndex[2] < bCubeInfo.posIndex[2]
	end

	return aCubeInfo.blockId < bCubeInfo.blockId
end

function DianJiShiGameView:refreshWaitArea()
	local typeBlockList = DianJiShiGameModel.instance:getAllTypeBlockList()
	local hasTypeBlock = typeBlockList and #typeBlockList > 0

	gohelper.setActive(self._goWaitArea, hasTypeBlock)

	if not hasTypeBlock then
		return
	end

	gohelper.CreateObjList(self, self._refreshWaitBlockItem, typeBlockList, self._goWaitBlockContent, self._goWaitBlockItem, DianJiShiGameWaitBlockItem)
end

function DianJiShiGameView:_refreshWaitBlockItem(waitBlockItem, blockInfoList, index)
	waitBlockItem:initScrollView(self._goScrollWaitBlock, self._tranWaitBlockContent)
	waitBlockItem:onUpdateMO(blockInfoList, index, self._goCommonBlockItem, self._curOpBlockInfo)
end

function DianJiShiGameView:_onAfterPlaceBlockOp(blockInfo)
	self._curOpBlockInfo = blockInfo
	self._curOpBlockId = blockInfo and blockInfo.id

	self:refreshUI()
end

function DianJiShiGameView:_onBeginDragBlock(blockInfo)
	AudioMgr.instance:trigger(AudioEnum3_8.DianJiShi.BeginDragGameBlock)

	local dragItem = self:_getOrCreateDragBlockItem()

	dragItem:onUpdateMO(blockInfo)
	self:refreshShadowArea(blockInfo)
	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnHelpPlaceBlock)
end

function DianJiShiGameView:_onDragBlock(blockInfo)
	local dragItem = self:_getOrCreateDragBlockItem()
	local posXIndex, posYIndex = dragItem:refreshPosition()

	self:showLightLineArea(blockInfo, posXIndex, posYIndex)
end

function DianJiShiGameView:_onEndDragBlock(blockInfo)
	AudioMgr.instance:trigger(AudioEnum3_8.DianJiShi.EndDragGameBlock)

	local dragItem = self:_getOrCreateDragBlockItem()
	local posXIndex, posYIndex = dragItem:refreshPosition()

	dragItem:setVisible(false)
	gohelper.setActive(self._goLineArea, false)
	gohelper.setActive(self._goHelpArea, false)
	DianJiShiGameController.instance:tryPlaceCube2Map(posXIndex, posYIndex, blockInfo)
end

function DianJiShiGameView:_getOrCreateDragBlockItem()
	if not self._dragBlockItem then
		self._dragBlockItem = DianJiShiGameDragBlockItem.Get(self._goDragBlockItem)

		self._dragBlockItem:addBlockGo(self._goCommonBlockItem)
	end

	return self._dragBlockItem
end

function DianJiShiGameView:showLightLineArea(blockInfo, posXIndex, posYIndex)
	self._lightBlockInfo = blockInfo

	if not blockInfo or not posXIndex or not posYIndex then
		return
	end

	local filterCellList, filterAreaDict = DianJiShiGameController.instance:getBlockFilterCellList(blockInfo, posXIndex, posYIndex, self._tempFilterCellList, self._tempFilterAreaMap)
	local hasFilterCell = filterCellList and #filterCellList > 0

	gohelper.setActive(self._goLineArea, hasFilterCell)

	self._canPlace = DianJiShiGameModel.instance:checkCanPlaceBlock(posXIndex, posYIndex, blockInfo)

	if self._canPlace then
		DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnLightAreaValue, self._canPlace)

		if not hasFilterCell then
			return
		end

		self._lightBlockPos[1] = posXIndex
		self._lightBlockPos[2] = posYIndex

		gohelper.CreateObjList(self, self._refreshLightLine, filterCellList, self._goLineArea, self._goLineItem, DianJiShiGameLightLineItem)
	end
end

function DianJiShiGameView:_refreshLightLine(lineItem, cellInfo, index)
	lineItem:onUpdateMO(cellInfo, self._lightBlockInfo.cubeMap, self._lightBlockPos, self._canPlace, index)
end

function DianJiShiGameView:_onUpdateGameStatus()
	self:refreshUI()
end

function DianJiShiGameView:_onHelpPlaceBlock(blockInfo, helpRightPos)
	self._helpBlockInfo = blockInfo
	self._helpBlockRightPos = helpRightPos

	local show = blockInfo ~= nil and helpRightPos ~= nil

	gohelper.setActive(self._goHelpArea, show)

	if not show then
		return
	end

	DianJiShiStatController.instance:addHelpTimes()

	local filterCellList = DianJiShiGameController.instance:getBlockFilterCellList(blockInfo, self._helpBlockRightPos[1], self._helpBlockRightPos[2]) or {}

	gohelper.CreateObjList(self, self._refreshHelpLine, filterCellList, self._goHelpArea, self._goHelpLineItem, DianJiShiGameHelpLineItem)
end

function DianJiShiGameView:_onMapAreaValueNotFit()
	self:refreshTargetDesc(self._showPassAreaNum - 1)
end

function DianJiShiGameView:_refreshHelpLine(lineItem, cellInfo, index)
	lineItem:onUpdateMO(cellInfo, self._helpBlockInfo.cubeMap, self._helpBlockRightPos, index)
end

function DianJiShiGameView:refreshShadowArea(ignoreBlockInfo)
	local ignoreBlockId = ignoreBlockInfo and ignoreBlockInfo.id
	local shadowList = DianJiShiGameController.instance:calcMapShadowInfoList(ignoreBlockId)
	local hasShadow = shadowList and #shadowList > 0

	gohelper.setActive(self._goShadowArea, hasShadow)

	if not hasShadow then
		return
	end

	gohelper.CreateObjList(self, self._refreshShadowItem, shadowList, self._goShadowArea, self._goShadowItem, DianJiShiGameShadowItem)
end

function DianJiShiGameView:_refreshShadowItem(shadowItem, shadowInfo, index)
	shadowItem:onUpdateMO(shadowInfo, index)
end

function DianJiShiGameView:onClose()
	GameUtil.setActiveUIBlock(self.viewName, false, true)
	TaskDispatcher.cancelTask(self._playGameSuccEffectDone, self)
end

function DianJiShiGameView:onDestroyView()
	self._simageMap:UnLoadImage()
end

return DianJiShiGameView
