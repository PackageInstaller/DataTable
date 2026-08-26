-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateView", package.seeall)

local EliminateView = class("EliminateView", BaseView)

function EliminateView:onInitView()
	self._viewGO = self.viewGO
	self.viewGO = gohelper.findChild(self._viewGO, "#go_cameraMain/Middle/#go_eliminatechess")
	self._goChessFrame = gohelper.findChild(self.viewGO, "Middle/#go_ChessFrame")
	self._goTimes = gohelper.findChild(self.viewGO, "Middle/#go_Times")
	self._txtTimes = gohelper.findChildText(self.viewGO, "Middle/#go_Times/#txt_Times")
	self._txtTimeseff = gohelper.findChildText(self.viewGO, "Middle/#go_Times/#txt_Times_eff")
	self._gochessBg = gohelper.findChild(self.viewGO, "Middle/#go_chessBg")
	self._gochessBoard = gohelper.findChild(self.viewGO, "Middle/#go_chessBg/#go_chessBoard")
	self._gochess = gohelper.findChild(self.viewGO, "Middle/#go_chessBg/#go_chess")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#go_chessBg/#go_chess/#btn_click")
	self._goskill = gohelper.findChild(self.viewGO, "Middle/#go_skill")
	self._gomask = gohelper.findChild(self.viewGO, "Middle/#go_mask")
	self._goResourceList = gohelper.findChild(self.viewGO, "Middle/Resource/#go_ResourceList")
	self._goResourceItem = gohelper.findChild(self.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem")
	self._imageResourceQuality = gohelper.findChildImage(self.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem/#image_ResourceQuality")
	self._txtResourceNum = gohelper.findChildText(self.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	self._btnChessBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_ChessBtn")
	self._goPointViewList = gohelper.findChild(self.viewGO, "Right/#go_PointViewList")
	self._goItem = gohelper.findChild(self.viewGO, "Right/#go_PointViewList/#go_Item")
	self._imagePointPic = gohelper.findChildImage(self.viewGO, "Right/#go_PointViewList/#go_Item/#image_PointPic")
	self._txtselfHP = gohelper.findChildText(self.viewGO, "Right/#go_PointViewList/#go_Item/image_SelfHPNumBG/#txt_selfHP")
	self._txtenemyHP = gohelper.findChildText(self.viewGO, "Right/#go_PointViewList/#go_Item/imageEnemyHPNumBG/#txt_enemyHP")
	self._goChessViewTips = gohelper.findChild(self.viewGO, "Right/#go_ChessViewTips")
	self._btncloseChessViewTip = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_ChessViewTips/#btn_closeChessViewTip")
	self._imageTipsBG = gohelper.findChildImage(self.viewGO, "Right/#go_ChessViewTips/#image_TipsBG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnChessBtn:AddClickListener(self._btnChessBtnOnClick, self)
	self._btncloseChessViewTip:AddClickListener(self._btncloseChessViewTipOnClick, self)
end

function EliminateView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnChessBtn:RemoveClickListener()
	self._btncloseChessViewTip:RemoveClickListener()
end

function EliminateView:_btnclickOnClick()
	return
end

function EliminateView:_btncloseChessViewTipOnClick()
	self:hideSoliderChessTip()
end

function EliminateView:_btnChessBtnOnClick()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)

	self._isShowChessViewTips = not self._isShowChessViewTips

	if not self._isShowChessViewTips then
		if self._chessTipsAni then
			self._chessTipsAni:Play("close")
		end

		TaskDispatcher.runDelay(self.setChessViewTipsActive, self, 0.27)
	else
		self:setChessViewTipsActive()
	end
end

function EliminateView:setChessViewTipsActive()
	gohelper.setActive(self._goChessViewTips, self._isShowChessViewTips)

	if self._isShowChessViewTips then
		for _, item in pairs(self._slotList) do
			item:refreshView()
		end
	end
end

local SLFramework_UGUI_UIClickListener = SLFramework.UGUI.UIClickListener

function EliminateView:_editableInitView()
	self._goChessTipViewClick = SLFramework_UGUI_UIClickListener.Get(self._goChessViewTips)

	self._goChessTipViewClick:AddClickListener(self._btnChessBtnOnClick, self)

	self._soliderView = nil
	self._timeAni = self._goTimes:GetComponent(typeof(UnityEngine.Animator))
	self._chessTipsAni = self._goChessViewTips:GetComponent(typeof(UnityEngine.Animator))
	self._eliminateChessViewAni = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._btncloseChessViewTip, false)

	self._goDengKen = gohelper.findChild(self.viewGO, "Middle/#go_skill/skill_dengken")
	self._goLuoPeiLa = gohelper.findChild(self.viewGO, "Middle/#go_skill/skill_luopeila")
	self._goLuoPeiLaLeft = gohelper.findChild(self.viewGO, "Middle/#go_skill/skill_luopeila/left")
	self._goLuoPeiLaRight = gohelper.findChild(self.viewGO, "Middle/#go_skill/skill_luopeila/right")
	self._goLuoPeiLaTop = gohelper.findChild(self.viewGO, "Middle/#go_skill/skill_luopeila/top")
	self._goLuoPeiLaBottom = gohelper.findChild(self.viewGO, "Middle/#go_skill/skill_luopeila/bottom")
	self._goWeierting1 = gohelper.findChild(self.viewGO, "Middle/#go_skill/skill_weierting1")
	self._goWeierting2 = gohelper.findChild(self.viewGO, "Middle/#go_skill/skill_weierting2")
	self._goResource = gohelper.findChild(self.viewGO, "Middle/Resource")

	local initState = EliminateChessItemController.instance:InitCloneGo(self._gochess, self._gochessBoard, self._gochessBg, self._gochessBg)

	if initState then
		EliminateChessItemController.instance:InitChessBoard()
		EliminateChessItemController.instance:InitChess()
	end
end

function EliminateView:onOpen()
	self:maskControl(true)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.OnChessSelect, self.onSelectItem, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.PerformBegin, self.onPerformBegin, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.PerformEnd, self.onPerformEnd, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.ShowChessInfo, self.showSoliderChessTip, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.Match3ChessEndViewOpen, self.match3ChessEndViewOpen, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.Match3ChessBeginViewClose, self.match3ChessBeginViewClose, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffect, self.playResourceFlyEffect, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlayFinish, self.resourceFlyFinish, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.RefreshInitChessShow, self.refreshViewActive, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.PlayEliminateEffect, self.playEliminateEffect, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, self.updateViewStateChangeEnd, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, self.updateViewState, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillViewOpen, self.characterSkillOpen, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillCancel, self.characterSkillClose, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPowerChange, self.updateStrongHoldItemInfo, self)
	self:initView()
	self:hideSoliderChessTip()
end

function EliminateView:onClose()
	return
end

function EliminateView:onSelectItem(x, y, isShowSelect)
	if self._maskState or self:checkSkillRelease(x, y) then
		if self._lastSelectX and self._lastSelectY then
			self:setSelect(false, self._lastSelectX, self._lastSelectY)
			self:recordLastSelect(nil, nil)
		end

		return
	end

	if self._lastSelectX and self._lastSelectY then
		self:setSelect(false, self._lastSelectX, self._lastSelectY)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_move)

		local canChange = EliminateChessController.instance:exchangeCell(self._lastSelectX, self._lastSelectY, x, y)

		if canChange then
			self:onPerformBegin()
			self:recordLastSelect(nil, nil)
		else
			if isShowSelect then
				self:setSelect(true, x, y)
			end

			self:recordLastSelect(x, y)
		end
	else
		if isShowSelect then
			self:setSelect(true, x, y)
		end

		self:recordLastSelect(x, y)
	end
end

function EliminateView:initView()
	gohelper.setActive(self._goChessViewTips, false)

	self._isShowChessViewTips = false

	self:calChessViewPosAndSize()
	self:initSlot()
	self:initResource()
	self:initStrongHoldItem()
end

function EliminateView:initSlot()
	self._slotList = self:getUserDataTb_()

	local slotIds = EliminateTeamChessModel.instance:getSlotIds()
	local path = self.viewContainer:getSetting().otherRes[1]
	local parentGo = self._imageTipsBG.gameObject

	for i, slotId in ipairs(slotIds) do
		local itemGO = self:getResInst(path, parentGo, slotId)
		local slotItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, EliminateTeamChessDetailItem)

		gohelper.setActive(itemGO, true)

		self._slotList[i] = slotItem

		slotItem:setSoliderId(slotId)
	end
end

function EliminateView:initResource()
	local resources = EliminateTeamChessEnum.ResourceType

	self._resourceItem = self:getUserDataTb_()

	for resourceId, _ in pairs(resources) do
		local item = gohelper.clone(self._goResourceItem, self._goResourceList, resourceId)
		local resourceImage = gohelper.findChildImage(item, "#image_ResourceQuality")
		local resourceNumberText = gohelper.findChildText(item, "#image_ResourceQuality/#txt_ResourceNum")
		local number = EliminateTeamChessModel.instance:getResourceNumber(resourceId)
		local ani = item:GetComponent(typeof(UnityEngine.Animator))
		local num = number and number or 0

		UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)
		gohelper.setActive(item, true)

		resourceNumberText.text = num
		self._resourceItem[resourceId] = {
			item = item,
			ani = ani,
			resourceImage = resourceImage,
			resourceNumberText = resourceNumberText
		}
	end
end

function EliminateView:initStrongHoldItem()
	self._strongHoldItem = self:getUserDataTb_()

	local strongholds = EliminateTeamChessModel.instance:getStrongholds()

	for i = 1, #strongholds do
		local stronghold = strongholds[i]
		local strongholdConfig = stronghold:getStrongholdConfig()
		local itemGO = gohelper.clone(self._goItem, self._goPointViewList, stronghold.id)
		local myImage = gohelper.findChildImage(itemGO, "image_SelfHPNumBG")
		local enemyImage = gohelper.findChildImage(itemGO, "imageEnemyHPNumBG")
		local myText = gohelper.findChildText(itemGO, "image_SelfHPNumBG/#txt_selfHP")
		local enemyText = gohelper.findChildText(itemGO, "imageEnemyHPNumBG/#txt_enemyHP")
		local imagePointPic = gohelper.findChildImage(itemGO, "#image_PointPic")
		local selfVx = gohelper.findChild(itemGO, "image_SelfHPNumBG/vx_fire_01")
		local enemyVx = gohelper.findChild(itemGO, "imageEnemyHPNumBG/vx_fire_01")

		myText.text = stronghold.myScore
		enemyText.text = stronghold.enemyScore

		local eliminateBg = strongholdConfig.eliminateBg

		if not string.nilorempty(eliminateBg) then
			UISpriteSetMgr.instance:setV2a2eliminatePointSprite(imagePointPic, eliminateBg, false)
		end

		gohelper.setActive(itemGO, true)

		self._strongHoldItem[i] = {
			item = itemGO,
			myText = myText,
			enemyText = enemyText,
			myImage = myImage,
			enemyImage = enemyImage,
			enemyVx = enemyVx,
			selfVx = selfVx
		}

		self:refreshStateByScore(self._strongHoldItem[i], stronghold.myScore, stronghold.enemyScore)
	end
end

function EliminateView:updateStrongHoldItemInfo()
	if self._strongHoldItem == nil or #self._strongHoldItem == 0 then
		return
	end

	local strongholds = EliminateTeamChessModel.instance:getStrongholds()

	for i = 1, #strongholds do
		local strongHoldItem = self._strongHoldItem[i]

		strongHoldItem.myText.text = strongholds[i].myScore
		strongHoldItem.enemyText.text = strongholds[i].enemyScore

		self:refreshStateByScore(strongHoldItem, strongholds[i].myScore, strongholds[i].enemyScore)
	end
end

function EliminateView:refreshStateByScore(strongHoldItem, myScore, enemySocre)
	local myText = strongHoldItem.myText
	local enemyText = strongHoldItem.enemyText
	local myImage = strongHoldItem.myImage
	local enemyImage = strongHoldItem.enemyImage
	local selfVx = strongHoldItem.selfVx
	local enemyVx = strongHoldItem.enemyVx

	if enemySocre < myScore then
		myText.color = EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	end

	if myScore < enemySocre then
		enemyText.color = EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	end

	if enemySocre < myScore then
		if not EliminateLevelEnum.winImageName1 then
			local myImageName = EliminateLevelEnum.loserImageName1

			if myScore < enemySocre then
				if not EliminateLevelEnum.winImageName1 then
					local enemyImageName = EliminateLevelEnum.loserImageName1

					UISpriteSetMgr.instance:setV2a2EliminateSprite(myImage, myImageName, true)
					UISpriteSetMgr.instance:setV2a2EliminateSprite(enemyImage, enemyImageName, true)
					gohelper.setActive(enemyVx, myScore < enemySocre)
					gohelper.setActive(selfVx, enemySocre < myScore)
				end
			end
		end
	end
end

function EliminateView:setTextColorAndSize(text, color, size)
	text.color = color
	text.fontSize = size
end

function EliminateView:updateMovePoint()
	local movePoint = EliminateChessModel.instance:getMovePoint()

	if self._lastMovePoint and self._lastMovePoint == movePoint then
		return
	end

	if self._lastMovePoint ~= nil and self._timeAni then
		self._timeAni:Play("refresh")
	end

	local content = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_movePoint_txt"), movePoint)

	self._txtTimes.text = content
	self._txtTimeseff.text = content
	self._lastMovePoint = movePoint
end

function EliminateView:updateResource()
	for resourceId, _ in pairs(self._resourceItem) do
		self:updateResourceDataChange(resourceId, false)
	end
end

function EliminateView:updateResourceDataChange(resourceId, needPlayAni)
	if string.nilorempty(resourceId) then
		return
	end

	local number = EliminateTeamChessModel.instance:getResourceNumber(resourceId)
	local item = self._resourceItem[resourceId]

	if item.resourceNumberText then
		item.resourceNumberText.text = number

		local ani = item.ani

		if needPlayAni and ani then
			ani:Play("add")
		end
	end
end

function EliminateView:setSelect(isSelect, x, y)
	local item = x and y and EliminateChessItemController.instance:getChessItem(x, y) or EliminateChessItemController.instance:getChessItem(self._lastSelectX, self._lastSelectY)

	if item ~= nil then
		item:setSelect(isSelect)
	end
end

function EliminateView:recordLastSelect(x, y)
	self._lastSelectX = x
	self._lastSelectY = y

	self:updateTipTime()
	self:tip(false)
end

function EliminateView:updateTipTime()
	self._lastClickTime = os.time()
end

function EliminateView:checkTip()
	if self._lastClickTime == nil then
		self._lastClickTime = os.time()
	end

	if os.time() - self._lastClickTime >= EliminateEnum.DotMoveTipInterval then
		self:tip(true)
	end
end

function EliminateView:tip(active)
	if self._lastTipActive ~= nil and self._lastTipActive == active then
		return
	end

	if active and not self.canTip then
		return
	end

	local tipInfo = EliminateChessModel.instance:getTipInfo()

	if tipInfo and tipInfo.from ~= nil then
		local eliminate = tipInfo.eliminate

		for i = 1, #eliminate, 2 do
			local x = eliminate[i]
			local y = eliminate[i + 1]
			local item = EliminateChessItemController.instance:getChessItem(x, y)

			item:toTip(active)
		end
	end

	self._lastTipActive = active
end

function EliminateView:updateViewState()
	local roundType = EliminateLevelModel.instance:getCurRoundType()
	local isMath3Chess = roundType == EliminateEnum.RoundType.Match3Chess

	self:clearSelect()
	self:maskControl(not isMath3Chess)
	self:setSendCheck(true)
end

function EliminateView:updateViewStateChangeEnd()
	local roundType = EliminateLevelModel.instance:getCurRoundType()
	local isMath3Chess = roundType == EliminateEnum.RoundType.Match3Chess

	if isMath3Chess and self._eliminateChessViewAni then
		self._eliminateChessViewAni:Play("open")
		TaskDispatcher.runDelay(self.refreshViewActive, self, 0.33)
	end

	if isMath3Chess then
		EliminateChessController.instance:createInitMoveStepAndUpdatePos()
		self:updateMovePoint()
		self:updateResource()
	end

	self:changeTipState(isMath3Chess, false, true)
end

function EliminateView:refreshViewActive(needCreateStart)
	local roundType = EliminateLevelModel.instance:getCurRoundType()
	local isMath3Chess = roundType == EliminateEnum.RoundType.Match3Chess

	if needCreateStart == nil then
		needCreateStart = true
	end

	if isMath3Chess then
		if needCreateStart then
			local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.StartShowView, EliminateEnum.ShowStartTime)
			local needStart = EliminateChessController.instance:buildSeqFlow(step)

			if needStart then
				EliminateChessController.instance:startSeqStepFlow()
			end
		end

		local needStart, _ = EliminateChessController.instance:createInitMoveStep()

		if needStart then
			EliminateChessController.instance:startSeqStepFlow()
		end

		local handleDataStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData)

		EliminateChessController.instance:buildSeqFlow(handleDataStep)

		self._roundBeginPerform = true
	end
end

function EliminateView:onPerformBegin()
	self:maskControl(true)
	self:changeTipState(false, true, false)
end

function EliminateView:onPerformEnd()
	self:changeTipState(true, false, true)
	self:updateTipTime()
	self:updateMovePoint()

	if self._roundBeginPerform then
		local roundNum = EliminateLevelModel.instance:getRoundNumber()
		local levelId = EliminateLevelModel.instance:getLevelId()

		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.Match3RoundBegin, string.format("%s_%s", levelId, roundNum))

		self._roundBeginPerform = false
	end

	local needMask = false
	local switchState = false

	if self.check then
		switchState = EliminateChessController.instance:checkState()
		needMask = switchState
	else
		needMask = true
	end

	if switchState then
		self:setSendCheck(false)
	end

	self:maskControl(needMask)
end

function EliminateView:setSendCheck(state)
	self.check = state
end

function EliminateView:maskControl(maskState)
	self._maskState = maskState

	gohelper.setActive(self._gomask, maskState)
end

function EliminateView:showSoliderChessTip(soliderId)
	if self._soliderView == nil then
		local tipPath = self.viewContainer:getSetting().otherRes[6]
		local playerItemGO = self:getResInst(tipPath, self._goChessViewTips)

		self._soliderView = MonoHelper.addNoUpdateLuaComOnceToGo(playerItemGO, EliminateChessTipView)

		local imageTr = self._imageTipsBG.gameObject.transform
		local x = recthelper.getAnchorX(imageTr)
		local width = recthelper.getWidth(imageTr)
		local anchorX = x - width + EliminateEnum.teamChessDescTipOffsetX

		if anchorX < EliminateEnum.teamChessDescMinAnchorX then
			anchorX = EliminateEnum.teamChessDescMinAnchorX
		end

		recthelper.setAnchorX(playerItemGO.transform, anchorX)
		recthelper.setAnchorY(playerItemGO.transform, EliminateEnum.teamChessDescTipOffsetY)
	end

	self._soliderView:setSoliderIdAndShowType(soliderId, EliminateTeamChessEnum.ChessTipType.showDesc)
	gohelper.setActive(self._btncloseChessViewTip, true)
	self._btncloseChessViewTip:AddClickListener(self._btncloseChessViewTipOnClick, self)
end

function EliminateView:hideSoliderChessTip()
	if self._soliderView then
		self._soliderView:hideView(function()
			gohelper.setActive(self._btncloseChessViewTip, false)
		end, nil)
	end

	self._btncloseChessViewTip:RemoveClickListener()
end

function EliminateView:onUpdateParam()
	return
end

function EliminateView:calChessViewPosAndSize()
	local goChessBgTr = self._gochessBg.transform
	local wight, height = EliminateChessItemController.instance:getMaxWidthAndHeight()

	recthelper.setSize(goChessBgTr, wight, height)

	local line, row = EliminateChessItemController.instance:getMaxLineAndRow()
	local diffPosX, diffPosY = 0, 0
	local x, y = recthelper.getAnchor(goChessBgTr)

	recthelper.setAnchor(goChessBgTr, x + (EliminateEnum.ChessMaxRowValue - row) * EliminateEnum.ChessWidth * 0.5, y + (EliminateEnum.ChessMaxLineValue - line) * EliminateEnum.ChessHeight * 0.5)

	local _, y = recthelper.getAnchor(self._goResource.transform)

	recthelper.setAnchorY(self._goResource.transform, y + (EliminateEnum.ChessMaxLineValue - line) * EliminateEnum.ChessHeight * 0.5)

	local wight = EliminateEnum.chessFrameBgMaxWidth * row / EliminateEnum.ChessMaxRowValue
	local height = EliminateEnum.chessFrameBgMaxHeight * line / EliminateEnum.ChessMaxLineValue

	recthelper.setSize(self._goChessFrame.transform, wight, height)
end

function EliminateView:match3ChessEndViewOpen()
	self:changeTipState(false, true, false)
end

function EliminateView:match3ChessBeginViewClose()
	self:changeTipState(true, false, true)
end

function EliminateView:changeTipState(canTip, stopTip, needReset)
	self.canTip = canTip

	if stopTip then
		self._lastClickTime = nil

		self:tip(false)
		TaskDispatcher.cancelTask(self.checkTip, self)
	end

	if needReset then
		self._lastClickTime = nil

		TaskDispatcher.cancelTask(self.checkTip, self)
		TaskDispatcher.runRepeat(self.checkTip, self, 1)
	end
end

function EliminateView:onDestroyView()
	TaskDispatcher.cancelTask(self.checkTip, self)
	TaskDispatcher.cancelTask(self.setChessViewTipsActive, self)
	TaskDispatcher.cancelTask(self.refreshViewActive, self)

	if self._soliderView then
		self._soliderView:onDestroy()

		self._soliderView = nil
	end

	if self._goChessTipViewClick then
		self._goChessTipViewClick:RemoveClickListener()

		self._goChessTipViewClick = nil
	end

	if self.flyItemPool then
		self.flyItemPool:dispose()

		self.flyItemPool = nil
	end

	self._timeAni = nil
	self._lastSelectX = nil
	self._lastSelectY = nil
end

function EliminateView:checkSkillRelease(x, y)
	if not EliminateLevelController.instance:canReleaseByRound() then
		return false
	end

	if EliminateLevelController.instance:getCurSelectSkill() ~= nil then
		if self.cacheTemp ~= nil then
			for i = 1, #self.cacheTemp do
				if self.cacheTemp[i].x == x and self.cacheTemp[i].y == y then
					return false
				end
			end
		end

		EliminateLevelController.instance:setSkillDataParams(x, y)
		self:setSelect(true, x, y)

		if self.cacheTemp == nil then
			self.cacheTemp = {}
		end

		table.insert(self.cacheTemp, {
			x = x,
			y = y
		})

		if EliminateLevelController.instance:canRelease() then
			self:maskControl(true)
			EliminateLevelController.instance:releaseSkill(self.releaseSkillSuccess, self)

			return true
		end
	end

	return false
end

function EliminateView:clearSelect()
	if self.cacheTemp == nil then
		return
	end

	for i = 1, #self.cacheTemp do
		self:setSelect(false, self.cacheTemp[i].x, self.cacheTemp[i].y)
	end

	self.cacheTemp = nil
end

function EliminateView:releaseSkillSuccess()
	self:characterSkillClose(false)
end

function EliminateView:characterSkillOpen()
	self:clearSelect()

	if self._lastSelectX ~= nil and self._lastSelectY ~= nil then
		self:setSelect(false, self._lastSelectX, self._lastSelectY)
		self:recordLastSelect(nil, nil)
	end

	self:changeTipState(false, true, false)
end

function EliminateView:characterSkillClose(needClearMask)
	if needClearMask then
		self:maskControl(false)
	end

	self:clearSelect()
	self:changeTipState(true, false, true)
end

function EliminateView:playResourceFlyEffect(resourceIds, startPosX, startPosY)
	local endPosX, endPosY, endPosZ = transformhelper.getPos(self._goResourceList.transform)

	for i = 1, #resourceIds do
		local resourceId = resourceIds[i]

		if self._resourceItem and self._resourceItem[resourceId] then
			endPosX, endPosY, endPosZ = transformhelper.getPos(self._resourceItem[resourceId].item.transform)
		end

		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffectPlay, resourceId, startPosX, startPosY, endPosX, endPosY)
	end
end

function EliminateView:resourceFlyFinish(resourceId)
	self:updateResourceDataChange(resourceId, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_lit)
end

function EliminateView:playEliminateEffect(effectType, x, y, worldX, worldY, active, cb, cbTarget)
	local delayTime = 0

	if effectType == EliminateEnum.EffectType.crossEliminate then
		if active then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_luopeila_skill)
			transformhelper.setPos(self._goLuoPeiLa.transform, worldX, worldY, 0)

			delayTime = 0.8

			gohelper.setActive(self._goLuoPeiLaLeft, x ~= 1)
			gohelper.setActive(self._goLuoPeiLaRight, x ~= EliminateEnum.ChessMaxRowValue)
			gohelper.setActive(self._goLuoPeiLaTop, y ~= EliminateEnum.ChessMaxLineValue)
			gohelper.setActive(self._goLuoPeiLaBottom, y ~= 1)
		end

		gohelper.setActive(self._goLuoPeiLa, active)
	end

	if effectType == EliminateEnum.EffectType.blockEliminate then
		if active then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_dengken_skill)
			transformhelper.setPos(self._goDengKen.transform, worldX, worldY, 0)
			gohelper.setActive(self._goDengKen, active)

			delayTime = 0.8
		end

		gohelper.setActive(self._goDengKen, active)
	end

	if effectType == EliminateEnum.EffectType.exchange_1 then
		if active then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_weierting_skill)
			transformhelper.setPos(self._goWeierting1.transform, worldX, worldY, 0)

			delayTime = 0.6
		end

		gohelper.setActive(self._goWeierting1, active)
	end

	if effectType == EliminateEnum.EffectType.exchange_2 then
		if active then
			transformhelper.setPos(self._goWeierting2.transform, worldX, worldY, 0)

			delayTime = 0.6
		end

		gohelper.setActive(self._goWeierting2, active)
	end

	if cb then
		TaskDispatcher.runDelay(function()
			if cb then
				cb(cbTarget)
			end
		end, self, delayTime)
	end
end

return EliminateView
