-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameWaitBlockItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameWaitBlockItem", package.seeall)

local DianJiShiGameWaitBlockItem = class("DianJiShiGameWaitBlockItem", LuaCompBase)

function DianJiShiGameWaitBlockItem:init(go)
	self.go = go
	self._imageItemBG = gohelper.findChildImage(self.go, "image_ItemBG")
	self._goBlock = gohelper.findChild(self.go, "go_Info/go_Block")
	self._goClick = gohelper.findChild(self.go, "go_Info/btn_Click")
	self._goHelp = gohelper.findChild(self.go, "go_Info/go_Help")
	self._dragListener = SLFramework.UGUI.UIDragListener.Get(self._goClick)
	self._tran = self.go.transform
	self._tranBlock = self._goBlock.transform
	self._blockScaleX, self._blockScaleY = transformhelper.getLocalScale(self._tranBlock)
	self._canvasgroup = gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup)
	self._txtNum = gohelper.findChildText(self.go, "go_Info/go_Num/txt_Num")
	self._isCanDrag = true
	self._isDragScroll = false
	self._hasSetScroll = false
	self._animator = gohelper.onceAddComponent(self._goBlock, gohelper.Type_Animator)
	self._layoutElement = gohelper.onceAddComponent(self._imageItemBG.gameObject, typeof(UnityEngine.UI.LayoutElement))

	gohelper.setActive(self._goHelp, false)
end

function DianJiShiGameWaitBlockItem:addEventListeners()
	self._dragListener:AddDragBeginListener(self._onDragBegin, self)
	self._dragListener:AddDragListener(self._onDrag, self)
	self._dragListener:AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnHelpPlaceBlock, self._onHelpPlaceBlock, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.GuideFindShowDragEffect, self._guideFindShowDragEffect, self)
end

function DianJiShiGameWaitBlockItem:removeEventListeners()
	self._dragListener:RemoveDragBeginListener()
	self._dragListener:RemoveDragListener()
	self._dragListener:RemoveDragEndListener()
end

function DianJiShiGameWaitBlockItem:_onDragBegin(param, pointerEventData)
	self._isDragScroll = false
	self._isDraging = false

	if not self:isCanDrag() then
		return
	end

	if self:checkCanScroll() and math.abs(pointerEventData.delta.y) > math.abs(pointerEventData.delta.x) then
		ZProj.UGUIHelper.PassEvent(self._goScrollList, pointerEventData, 4)

		self._isDragScroll = true

		return
	end

	self._isDraging = true

	self:setInteract(false)
	self:_changeNumAndAlpha(self._waitBlockNum - 1)
	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnBeginDragBlock, self._firstWaitBlock)
end

function DianJiShiGameWaitBlockItem:_onDrag(param, pointerEventData)
	if not self:isCanDrag() then
		return
	end

	if self._isDragScroll then
		ZProj.UGUIHelper.PassEvent(self._goScrollList, pointerEventData, 5)

		return
	end

	if not self._isDraging then
		return
	end

	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnDragBlock, self._firstWaitBlock)
end

function DianJiShiGameWaitBlockItem:_onDragEnd(param, pointerEventData)
	if not self:isCanDrag() then
		return
	end

	if self._isDragScroll then
		self._isDragScroll = false

		ZProj.UGUIHelper.PassEvent(self._goScrollList, pointerEventData, 6)

		return
	end

	if not self._isDraging then
		return
	end

	self._isDraging = false

	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnEndDragBlock, self._firstWaitBlock)
end

function DianJiShiGameWaitBlockItem:isCanDrag()
	if DianJiShiGameController.instance:isMultiTouch() then
		return
	end

	local curDragBlock = DianJiShiGameModel.instance:getCurGuideBlock()

	return not curDragBlock or curDragBlock == self._blockInfo
end

function DianJiShiGameWaitBlockItem:initScrollView(goScroll, tranScrollContent)
	self._goScrollList = goScroll
	self._tranScrollContent = tranScrollContent
end

function DianJiShiGameWaitBlockItem:checkCanScroll()
	if gohelper.isNil(self._goScrollList) then
		return
	end

	local tranScrollList = self._goScrollList.transform
	local scrollHeight = recthelper.getHeight(tranScrollList)
	local contentHeight = recthelper.getHeight(self._tranScrollContent)

	return scrollHeight <= contentHeight
end

function DianJiShiGameWaitBlockItem:onUpdateMO(blockInfoList, index, goBlockTemplate, opBlockInfo)
	self._blockInfoList = blockInfoList
	self._blockInfo = blockInfoList and blockInfoList[1]
	self._blockType = self._blockInfo and self._blockInfo.config.type
	self._waitBlockList = self:_getWaitBlockList()

	if self._waitBlockList then
		self._waitBlockNum = #self._waitBlockList or 0
	end

	self._firstWaitBlock = self._waitBlockList and self._waitBlockList[1]
	self._index = index
	self._goBlockTemplate = goBlockTemplate
	self._putAnim = self:_isNeedPlayPutAnim(opBlockInfo)

	self:refreshUI()
end

function DianJiShiGameWaitBlockItem:refreshUI()
	if not self._blockItem then
		local goBlock = gohelper.clone(self._goBlockTemplate, self._goBlock)

		self._blockItem = DianJiShiGameBaseBlockItem.Get(goBlock)

		self._blockItem:keepFrontIconVisible(true)
		self._blockItem:setTagScale(DianJiShiGameEnum.WaitBlockTagScale, DianJiShiGameEnum.WaitBlockTagScale)
	end

	gohelper.setActive(self._goHelp, false)
	self._blockItem:onUpdateMO(self._blockInfo, self._putAnim)
	self:_changeNumAndAlpha(self._waitBlockNum)
	self:setBlockCenter()
	self:refreshBg()
end

function DianJiShiGameWaitBlockItem:_changeNumAndAlpha(waitBlockNum)
	waitBlockNum = waitBlockNum or 0
	self._txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), waitBlockNum)

	local interact = waitBlockNum > 0

	self:setAlpha(interact and 1 or DianJiShiGameEnum.NoneWaitBlockAlpha)
	self:setInteract(interact)
end

function DianJiShiGameWaitBlockItem:_getWaitBlockList()
	local waitBlockList = {}

	if self._blockInfoList then
		for _, blockInfo in ipairs(self._blockInfoList) do
			if blockInfo.status == DianJiShiGameEnum.BlockStatus.Wait then
				table.insert(waitBlockList, blockInfo)
			end
		end
	end

	return waitBlockList
end

function DianJiShiGameWaitBlockItem:setBlockCenter()
	local cellWidth, cellHeight = DianJiShiGameModel.instance:getCellSize()
	local blockWidth, blockHeight = self._blockItem:getBlockSize()
	local resultBlockWidth = blockWidth * cellWidth * self._blockScaleX
	local resultBlockHeight = (blockHeight * cellHeight + DianJiShiGameEnum.WaitBlockFrontHeight) * self._blockScaleY
	local blockPosX = -resultBlockWidth / 2
	local blockPosY = resultBlockHeight / 2

	recthelper.setAnchor(self._tranBlock, blockPosX, blockPosY + 5)
end

function DianJiShiGameWaitBlockItem:refreshBg()
	local cellWidth, cellHeight = DianJiShiGameModel.instance:getCellSize()
	local blockWidth, blockHeight = self._blockItem:getBlockSize()
	local width = blockWidth * cellWidth * self._blockScaleX + DianJiShiGameEnum.WaitBlockSpaceSize[1]

	if blockWidth <= 2 then
		width = DianJiShiGameEnum.MinWaitBlockSize[1]
	end

	if blockHeight <= 2 then
		self._layoutElement.minHeight = DianJiShiGameEnum.MinWaitBlockSize[2]
	end

	self._layoutElement.minWidth = width

	UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageItemBG, "v3a8_dianjishi_game_listbg1")
end

function DianJiShiGameWaitBlockItem:setInteract(isInteract)
	self._canvasgroup.blocksRaycasts = isInteract
	self._canvasgroup.interactable = isInteract
end

function DianJiShiGameWaitBlockItem:setAlpha(alpha)
	self._canvasgroup.alpha = alpha
end

function DianJiShiGameWaitBlockItem:_onHelpPlaceBlock(blockInfo)
	local helpBlockCo = blockInfo and blockInfo.config
	local helpBlockType = helpBlockCo and helpBlockCo.type

	gohelper.setActive(self._goHelp, blockInfo and self._blockType == helpBlockType)
end

function DianJiShiGameWaitBlockItem:_isNeedPlayPutAnim(blockInfo)
	local blockCo = blockInfo and blockInfo.config
	local blockType = blockCo and blockCo.type

	if blockType ~= self._blockType or self._waitBlockNum <= 0 then
		return
	end

	for _, waitBlockInfo in ipairs(self._waitBlockList) do
		if waitBlockInfo.id == blockInfo.id then
			return true
		end
	end
end

function DianJiShiGameWaitBlockItem:_guideFindShowDragEffect(index)
	if self._index ~= tonumber(index) or self._waitBlockNum <= 0 then
		return
	end

	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.GuideStartShowDragEffect, self._tran, self._blockInfo)
end

return DianJiShiGameWaitBlockItem
