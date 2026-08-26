-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameGuideView.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameGuideView", package.seeall)

local DianJiShiGameGuideView = class("DianJiShiGameGuideView", BaseView)

function DianJiShiGameGuideView:onInitView()
	self._goGuide = gohelper.findChild(self.viewGO, "#go_Root/#go_Guide")
	self._goGuideBlock = gohelper.findChild(self.viewGO, "#go_Root/#go_GuideBlock")
	self._goGuideStart = gohelper.findChild(self.viewGO, "#go_Root/#go_Guide/guide2/#go_GuideStart")
	self._goGuideEnd = gohelper.findChild(self.viewGO, "#go_Root/#go_Guide/guide2/#go_GuideEnd")
	self._goMapArea = gohelper.findChild(self.viewGO, "#go_Root/#go_Left/#go_Scale/#go_MapArea")
	self._goGuideHand = gohelper.findChild(self.viewGO, "#go_Root/#go_Guide/guide2/shouzhi")
	self._goLeft = gohelper.findChild(self.viewGO, "#go_Root/#go_Left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DianJiShiGameGuideView:addEvents()
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.GuideStartShowDragEffect, self._guideStartShowDragEffect, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnPlaceBlockDone, self._onPlaceBlockDone, self, LuaEventSystem.Low)
end

function DianJiShiGameGuideView:removeEvents()
	return
end

function DianJiShiGameGuideView:_editableInitView()
	gohelper.setActive(self._goGuide, false)
	gohelper.setActive(self._goGuideBlock, false)

	self._tranGuide = self._goGuide.transform
	self._tranGuideStart = self._goGuideStart.transform
	self._tranGuideEnd = self._goGuideEnd.transform
	self._tranMapArea = self._goMapArea.transform
	self._tranGuideHand = self._goGuideHand.transform
	self._leftCanvasGroup = gohelper.onceAddComponent(self._goLeft, gohelper.Type_CanvasGroup)
	self._leftCanvasGroup.blocksRaycasts = true
end

function DianJiShiGameGuideView:onOpen()
	self._actId = self.viewParam and self.viewParam.actId
	self._episodeId = self.viewParam and self.viewParam.episodeId
	self._gameId = self.viewParam and self.viewParam.gameId
end

function DianJiShiGameGuideView:onOpenFinish()
	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.GuideOnEnterEpisode, self._gameId)
end

function DianJiShiGameGuideView:_guideStartShowDragEffect(tranBlock, blockInfo)
	if not tranBlock or not blockInfo then
		return
	end

	self._guideBlockInfo = blockInfo

	self:_setStartDragHole(tranBlock)
	self:_setEndDragHole(blockInfo)
	self:_reaptMoveGuideHand()
	DianJiShiGameModel.instance:recordCurGuideBlock(blockInfo)
end

function DianJiShiGameGuideView:_setStartDragHole(tranBlock)
	self._blockPosX, self._blockPosY = recthelper.rectToRelativeAnchorPos2(tranBlock.position, self._tranGuide)

	local blockWidth = recthelper.getWidth(tranBlock) + DianJiShiGameEnum.GuideHoleSpace[1]
	local blockHeight = recthelper.getHeight(tranBlock) + DianJiShiGameEnum.GuideHoleSpace[2]

	recthelper.setAnchor(self._tranGuideStart, self._blockPosX, self._blockPosY)
	recthelper.setSize(self._tranGuideStart, blockWidth, blockHeight)
end

function DianJiShiGameGuideView:_setEndDragHole(blockInfo)
	local _, rightPos = DianJiShiGameController.instance:checkAndGetBlockRightPos(self._gameId, blockInfo)

	if not rightPos then
		return
	end

	self._cellStartPosX, self._cellStartPosY = DianJiShiGameController.instance:posIndex2Pos(rightPos[1], rightPos[2], true)

	local mapStartPosX, mapStartPosY = recthelper.rectToRelativeAnchorPos2(self._tranMapArea.position, self._tranGuide)

	self._cellStartPosX = self._cellStartPosX + mapStartPosX
	self._cellStartPosY = self._cellStartPosY + mapStartPosY

	recthelper.setAnchor(self._tranGuideEnd, self._cellStartPosX, self._cellStartPosY)

	local cellWidth, cellHeight = DianJiShiGameModel.instance:getCellSize()
	local blockSize = DianJiShiGameConfig.instance:getBlockSize(self._gameId, blockInfo.id)

	if blockSize then
		local blockWidth = cellWidth * (blockSize[1] or 0)

		if blockSize then
			local blockHeight = cellHeight * (blockSize[2] or 0)

			recthelper.setSize(self._tranGuideEnd, blockWidth, blockHeight)

			self._cellCenterPosX = self._cellStartPosX + blockWidth / 2
			self._cellCenterPosY = self._cellStartPosY - cellHeight / 2
		end
	end
end

function DianJiShiGameGuideView:_reaptMoveGuideHand()
	self:cancelGuideHandTask()

	self._leftCanvasGroup.blocksRaycasts = false

	gohelper.setActive(self._goGuideBlock, true)
	gohelper.setActive(self._goGuide, true)
	self:_moveGuideHand()
	TaskDispatcher.runRepeat(self._moveGuideHand, self, DianJiShiGameEnum.GuideHandMoveDuration)
end

function DianJiShiGameGuideView:_moveGuideHand()
	if not self._blockPosX or not self._blockPosY or not self._cellCenterPosX or not self._cellCenterPosY then
		return
	end

	self:killGuideHandTween()
	recthelper.setAnchor(self._tranGuideHand, self._blockPosX, self._blockPosY)

	self._tweenId = ZProj.TweenHelper.DOAnchorPos(self._tranGuideHand, self._cellCenterPosX, self._cellCenterPosY, DianJiShiGameEnum.GuideHandMoveDuration)
end

function DianJiShiGameGuideView:_onPlaceBlockDone(blockInfo)
	if not blockInfo or self._guideBlockInfo ~= blockInfo then
		return
	end

	self:cancelGuideHandTask()

	self._leftCanvasGroup.blocksRaycasts = true

	gohelper.setActive(self._goGuide, false)
	gohelper.setActive(self._goGuideBlock, false)
	DianJiShiGameModel.instance:recordCurGuideBlock()
	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.GuideShowDragEffectDone)
end

function DianJiShiGameGuideView:killGuideHandTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function DianJiShiGameGuideView:cancelGuideHandTask()
	TaskDispatcher.cancelTask(self._moveGuideHand, self)
	self:killGuideHandTween()
end

function DianJiShiGameGuideView:onClose()
	self:cancelGuideHandTask()
end

function DianJiShiGameGuideView:onDestroyView()
	return
end

return DianJiShiGameGuideView
