-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmPuzzlePipes.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipes", package.seeall)

local ArmPuzzlePipes = class("ArmPuzzlePipes", BaseView)

function ArmPuzzlePipes:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArmPuzzlePipes:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function ArmPuzzlePipes:removeEvents()
	self._btnreset:RemoveClickListener()
end

function ArmPuzzlePipes:_editableInitView()
	self._gomapTrs = self._gomap.transform

	self:initConst()

	self._canTouch = true
	self._btnUIClick = SLFramework.UGUI.UIClickListener.Get(self._gomap)

	self._btnUIClick:AddClickListener(self._onbtnUIClick, self)
end

function ArmPuzzlePipes:initConst()
	self._itemSizeX = 123
	self._itemSizeY = 123
	self._gameWidth, self._gameHeight = ArmPuzzlePipeModel.instance:getGameSize()
end

function ArmPuzzlePipes:onUpdateParam()
	return
end

function ArmPuzzlePipes:onOpen()
	self._gridItemDict = {}
	self._gridItemList = {}

	for x = 1, self._gameWidth do
		self._gridItemDict[x] = self._gridItemDict[x] or {}

		for y = 1, self._gameHeight do
			self:addNewItem(x, y)
		end
	end

	self:_refreshEntryItem()
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.GuideClickGrid, self._onGuideClickGrid, self)
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, self._onPlaceRefreshPipesGrid, self)
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
end

function ArmPuzzlePipes:_onGuideClickGrid(param)
	local paramList = string.splitToNumber(param, "_")
	local x = paramList[1]
	local y = paramList[2]

	self:_onClickGridItem(x, y)
end

function ArmPuzzlePipes:_onPlaceRefreshPipesGrid(x, y)
	local mo = ArmPuzzlePipeModel.instance:getData(x, y)

	if not mo then
		return
	end

	ArmPuzzlePipeController.instance:refreshConnection(mo)
	ArmPuzzlePipeController.instance:updateConnection()
	self:initItem(x, y)
	self:_refreshConnection()
	self:_refreshEntryItem()

	self._canTouch = not ArmPuzzlePipeModel.instance:getGameClear()

	ArmPuzzlePipeController.instance:checkDispatchClear()
end

function ArmPuzzlePipes:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Va3Act124ResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function ArmPuzzlePipes:_resetGame()
	Stat1_3Controller.instance:puzzleStatReset()
	ArmPuzzlePipeController.instance:resetGame()

	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self:initItem(x, y)
			self:_refreshConnectItem(x, y)
		end
	end

	self:_refreshEntryItem()

	self._canTouch = not ArmPuzzlePipeModel.instance:getGameClear()
end

function ArmPuzzlePipes:addNewItem(x, y)
	self:_newPipeItem(x, y)
	self:initItem(x, y)
	self:_refreshConnectItem(x, y)
end

function ArmPuzzlePipes:_newPipeItem(x, y)
	local itemPath = ArmPuzzlePipeItem.prefabPath
	local itemGo = self:getResInst(itemPath, self._gomap, x .. "_" .. y)
	local rectTf = itemGo.transform
	local anchorX, anchorY = ArmPuzzlePipeModel.instance:getRelativePosition(x, y, self._itemSizeX, self._itemSizeY)

	recthelper.setAnchor(rectTf, anchorX, anchorY)

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, ArmPuzzlePipeItem)

	table.insert(self._gridItemList, comp)

	self._gridItemDict[x][y] = comp
end

function ArmPuzzlePipes:initItem(x, y)
	local mo = ArmPuzzlePipeModel.instance:getData(x, y)
	local itemObj = self._gridItemDict[x][y]

	itemObj:initItem(mo)
end

function ArmPuzzlePipes:_refreshConnectItem(x, y)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local mo = ArmPuzzlePipeModel.instance:getData(x, y)
		local itemObj = self._gridItemDict[x][y]

		itemObj:initConnectObj(mo)
	end
end

function ArmPuzzlePipes:_syncRotation(x, y, mo)
	if mo:isEntry() then
		return
	end

	local itemObj = self._gridItemDict[x][y]

	itemObj:syncRotation(mo)
end

function ArmPuzzlePipes:_onbtnUIClick()
	local pos = GamepadController.instance:getMousePosition()

	self:_onClickContainer(pos)
end

function ArmPuzzlePipes:_onClickContainer(position)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local tempPos = recthelper.screenPosToAnchorPos(position, self._gomapTrs)
	local x, y = ArmPuzzlePipeModel.instance:getIndexByTouchPos(tempPos.x, tempPos.y, self._itemSizeX, self._itemSizeY)

	if x ~= -1 then
		self:_onClickGridItem(x, y)
	end
end

function ArmPuzzlePipes:getXYByPostion(position)
	local tempPos = recthelper.screenPosToAnchorPos(position, self._gomapTrs)
	local x, y = ArmPuzzlePipeModel.instance:getIndexByTouchPos(tempPos.x, tempPos.y, self._itemSizeX, self._itemSizeY)

	if x ~= -1 then
		return x, y
	end
end

function ArmPuzzlePipes:_refreshConnection()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self:_refreshConnectItem(x, y)
		end
	end
end

function ArmPuzzlePipes:_refreshEntryItem()
	local entryList = ArmPuzzlePipeModel.instance:getEntryList()

	for _, mo in pairs(entryList) do
		local x, y = mo.x, mo.y
		local itemObj = self._gridItemDict[x][y]

		itemObj:initItem(mo)
		itemObj:initConnectObj(mo)
	end
end

function ArmPuzzlePipes:_onClickGridItem(x, y)
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.Va3Act124GameFinish)

		return
	end

	local mo = ArmPuzzlePipeModel.instance:getData(x, y)

	if mo:isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	ArmPuzzlePipeController.instance:changeDirection(x, y, true)
	ArmPuzzlePipeController.instance:updateConnection()
	self:_syncRotation(x, y, mo)
	self:_refreshConnection()
	self:_refreshEntryItem()

	self._canTouch = not ArmPuzzlePipeModel.instance:getGameClear()

	ArmPuzzlePipeController.instance:checkDispatchClear()
end

function ArmPuzzlePipes:onClose()
	if self._btnUIClick then
		self._btnUIClick:RemoveClickListener()

		self._btnUIClick = nil
	end
end

function ArmPuzzlePipes:_onGameClear()
	Stat1_3Controller.instance:puzzleStatSuccess()
end

function ArmPuzzlePipes:onDestroyView()
	return
end

return ArmPuzzlePipes
