-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzlePipes.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzlePipes", package.seeall)

local DungeonPuzzlePipes = class("DungeonPuzzlePipes", BaseView)

function DungeonPuzzlePipes:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._goconnect = gohelper.findChild(self.viewGO, "#go_connect")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzlePipes:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function DungeonPuzzlePipes:removeEvents()
	self._btnreset:RemoveClickListener()
end

function DungeonPuzzlePipes:_editableInitView()
	self:initConst()

	self._touch = TouchEventMgrHepler.getTouchEventMgr(self._gomap)

	self._touch:SetOnlyTouch(true)
	self._touch:SetIgnoreUI(true)
	self._touch:SetOnClickCb(self._onClickContainer, self)

	self._canTouch = true
end

function DungeonPuzzlePipes:initConst()
	self._itemSizeX = 132
	self._itemSizeY = 130
	self._gameWidth, self._gameHeight = DungeonPuzzlePipeModel.instance:getGameSize()
end

function DungeonPuzzlePipes:onUpdateParam()
	return
end

function DungeonPuzzlePipes:onOpen()
	self._gridObjs = {}
	self._connectObjs = {}

	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self._gridObjs[x] = self._gridObjs[x] or {}
			self._connectObjs[x] = self._connectObjs[x] or {}

			self:addNewItem(x, y)
		end
	end

	self:_refreshEntryItem()
	self.addEventCb(self, DungeonPuzzlePipeController.instance, DungeonPuzzleEvent.GuideClickGrid, self._onGuideClickGrid, self)
end

function DungeonPuzzlePipes:_onGuideClickGrid(param)
	local paramList = string.splitToNumber(param, "_")
	local x = paramList[1]
	local y = paramList[2]

	self:_onClickGridItem(x, y)
end

function DungeonPuzzlePipes:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function DungeonPuzzlePipes:_resetGame()
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	DungeonPuzzlePipeController.instance:resetGame()

	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self:initItem(x, y)
			self:_refreshConnectItem(x, y)
		end
	end

	self:_refreshEntryItem()
end

function DungeonPuzzlePipes:addNewItem(x, y)
	self:_newPipeItem(x, y)
	self:initItem(x, y)
	self:_refreshConnectItem(x, y)
end

function DungeonPuzzlePipes:_newPipeItem(x, y)
	local itemPath = self.viewContainer:getSetting().otherRes[1]
	local itemGo = self:getResInst(itemPath, self._gomap, x .. "_" .. y)
	local rectTf = itemGo.transform
	local anchorX, anchorY = DungeonPuzzlePipeModel.instance:getRelativePosition(x, y, self._itemSizeX, self._itemSizeY)

	recthelper.setAnchor(rectTf, anchorX, anchorY)

	local itemObj = self:getUserDataTb_()

	itemObj.go = itemGo
	itemObj.image = gohelper.findChildImage(itemGo, "#image_content")
	itemObj.imageTf = itemObj.image.transform
	itemObj.tf = rectTf
	self._gridObjs[x][y] = itemObj
end

function DungeonPuzzlePipes:initItem(x, y)
	local mo = DungeonPuzzlePipeModel.instance:getData(x, y)
	local resConst = DungeonPuzzleEnum.backgroundRes[mo.value]
	local path, rotation = resConst[1], resConst[2]
	local itemObj = self._gridObjs[x][y]

	UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
	transformhelper.setLocalRotation(itemObj.tf, 0, 0, rotation)
	recthelper.setAnchor(itemObj.imageTf, resConst[3], resConst[4])
end

function DungeonPuzzlePipes:_refreshConnectItem(x, y)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local mo = DungeonPuzzlePipeModel.instance:getData(x, y)
		local connectValue = mo:getConnectValue()
		local itemObj = self._connectObjs[x][y]

		if connectValue ~= 0 then
			itemObj = itemObj or self:_newConnectObj(x, y)

			self:_initConnectObj(itemObj, mo, connectValue)
		else
			self:hideConnectItem(itemObj)
		end
	end
end

function DungeonPuzzlePipes:_newConnectObj(x, y)
	local itemPath = self.viewContainer:getSetting().otherRes[2]
	local itemGo = self:getResInst(itemPath, self._goconnect, x .. "_" .. y)
	local rectTf = itemGo.transform
	local anchorX, anchorY = DungeonPuzzlePipeModel.instance:getRelativePosition(x, y, self._itemSizeX, self._itemSizeY)

	recthelper.setAnchor(rectTf, anchorX, anchorY)

	local itemObj = self:getUserDataTb_()

	itemObj.go = itemGo
	itemObj.image = gohelper.findChildImage(itemGo, "#image_content")
	itemObj.imageTf = itemObj.image.transform
	itemObj.tf = rectTf
	self._connectObjs[x][y] = itemObj

	return itemObj
end

function DungeonPuzzlePipes:_initConnectObj(itemObj, mo, connectValue)
	local resConst = mo:isEntry() and DungeonPuzzleEnum.connectRes[0] or DungeonPuzzleEnum.connectRes[connectValue]

	if resConst then
		itemObj.go:SetActive(true)

		local path, rotation = resConst[1], resConst[2]

		UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
		transformhelper.setLocalRotation(itemObj.tf, 0, 0, rotation)
		recthelper.setAnchor(itemObj.imageTf, resConst[3], resConst[4])
	else
		self:hideConnectItem(itemObj)
	end
end

function DungeonPuzzlePipes:hideConnectItem(itemObj)
	if itemObj and itemObj.go ~= nil then
		itemObj.go:SetActive(false)
	end
end

function DungeonPuzzlePipes:_syncRotation(x, y, mo)
	if mo:isEntry() then
		return
	end

	local resConst = DungeonPuzzleEnum.backgroundRes[mo.value]
	local itemObj = self._gridObjs[x][y]
	local rotation = resConst[2]

	transformhelper.setLocalRotation(itemObj.tf, 0, 0, rotation)
end

function DungeonPuzzlePipes:_onClickContainer(position)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local tempPos = recthelper.screenPosToAnchorPos(position, self._gomap.transform)
	local x, y = DungeonPuzzlePipeModel.instance:getIndexByTouchPos(tempPos.x, tempPos.y, self._itemSizeX, self._itemSizeY)

	if x ~= -1 then
		self:_onClickGridItem(x, y)
	end
end

function DungeonPuzzlePipes:_refreshConnection()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self:_refreshConnectItem(x, y)
		end
	end
end

function DungeonPuzzlePipes:_refreshEntryItem()
	local entryList = DungeonPuzzlePipeModel.instance:getEntryList()

	for _, mo in pairs(entryList) do
		local x, y = mo.x, mo.y
		local itemObj = self._gridObjs[x][y]
		local connectObj = self._connectObjs[x][y]
		local isClear = DungeonPuzzlePipeController.instance:getIsEntryClear(mo)

		itemObj.go:SetActive(not isClear)

		if connectObj then
			connectObj.go:SetActive(isClear)

			if isClear then
				DungeonPuzzlePipeModel.instance._connectEntryX = x
				DungeonPuzzlePipeModel.instance._connectEntryY = y

				DungeonPuzzlePipeController.instance:dispatchEvent(DungeonPuzzleEvent.GuideEntryConnectClear)
			end
		end

		local orderGo = self:getOrderGO(x, y)

		if not gohelper.isNil(orderGo) then
			gohelper.setActive(orderGo, not isClear)
		end
	end
end

function DungeonPuzzlePipes:getOrderGO(x, y)
	return (gohelper.findChild(self.viewGO, string.format("indexs/#go_index_%s_%s", x, y)))
end

function DungeonPuzzlePipes:_onClickGridItem(x, y)
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	local mo = DungeonPuzzlePipeModel.instance:getData(x, y)

	if mo:isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	DungeonPuzzlePipeController.instance:changeDirection(x, y, true)
	DungeonPuzzlePipeController.instance:updateConnection()
	self:_syncRotation(x, y, mo)
	self:_refreshConnection()
	self:_refreshEntryItem()

	self._canTouch = not DungeonPuzzlePipeModel.instance:getGameClear()

	DungeonPuzzlePipeController.instance:checkDispatchClear()
end

function DungeonPuzzlePipes:onClose()
	if self._touch then
		TouchEventMgrHepler.remove(self._touch)

		self._touch = nil
	end
end

function DungeonPuzzlePipes:onDestroyView()
	return
end

return DungeonPuzzlePipes
