-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/repairgame/VersionActivity1_8FactoryRepairGameMap.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairGameMap", package.seeall)

local VersionActivity1_8FactoryRepairGameMap = class("VersionActivity1_8FactoryRepairGameMap", BaseView)
local ITEM_SIZE_X = 123
local ITEM_SIZE_Y = 123

function VersionActivity1_8FactoryRepairGameMap:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._gomapTrs = self._gomap.transform
	self._btnMapClick = SLFramework.UGUI.UIClickListener.Get(self._gomap)
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8FactoryRepairGameMap:addEvents()
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.GuideClickGrid, self._onGuideClickGrid, self)
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, self._onPlaceRefreshPipesGrid, self)
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
	self._btnMapClick:AddClickListener(self._btnMapOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function VersionActivity1_8FactoryRepairGameMap:removeEvents()
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.GuideClickGrid, self._onGuideClickGrid, self)
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, self._onPlaceRefreshPipesGrid, self)
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
	self._btnMapClick:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function VersionActivity1_8FactoryRepairGameMap:_onGuideClickGrid(param)
	local paramList = string.splitToNumber(param, "_")
	local x = paramList[1]
	local y = paramList[2]

	self:_onClickGridItem(x, y)
end

function VersionActivity1_8FactoryRepairGameMap:_onPlaceRefreshPipesGrid(x, y)
	local mo = Activity157RepairGameModel.instance:getData(x, y)

	if not mo then
		return
	end

	Activity157Controller.instance:refreshConnection(mo)
	Activity157Controller.instance:updateConnection()
	self:initItem(x, y)
	self:_refreshConnection()
	self:_refreshEntryItem()

	self._canTouch = not Activity157RepairGameModel.instance:getGameClear()

	Activity157Controller.instance:checkDispatchClear()
end

function VersionActivity1_8FactoryRepairGameMap:_onGameClear()
	VersionActivity1_8StatController.instance:statSuccess()
end

function VersionActivity1_8FactoryRepairGameMap:_btnMapOnClick()
	local pos = GamepadController.instance:getMousePosition()

	self:_onClickContainer(pos)
end

function VersionActivity1_8FactoryRepairGameMap:_onClickContainer(position)
	local tempPos = recthelper.screenPosToAnchorPos(position, self._gomapTrs)
	local x, y = Activity157RepairGameModel.instance:getIndexByTouchPos(tempPos.x, tempPos.y, ITEM_SIZE_X, ITEM_SIZE_Y)

	if x ~= -1 then
		self:_onClickGridItem(x, y)
	end
end

function VersionActivity1_8FactoryRepairGameMap:_onClickGridItem(x, y)
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	local mo = Activity157RepairGameModel.instance:getData(x, y)

	if mo:isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity157Controller.instance:changeDirection(x, y, true)
	Activity157Controller.instance:updateConnection()
	self:_syncRotation(x, y, mo)
	self:_refreshConnection()
	self:_refreshEntryItem()

	self._canTouch = not Activity157RepairGameModel.instance:getGameClear()

	Activity157Controller.instance:checkDispatchClear()
end

function VersionActivity1_8FactoryRepairGameMap:_syncRotation(x, y, mo)
	if mo:isEntry() then
		return
	end

	local itemObj = self._gridItemDict[x][y]

	itemObj:syncRotation(mo)
end

function VersionActivity1_8FactoryRepairGameMap:_btnresetOnClick()
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.v1a8Activity157RestTip, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function VersionActivity1_8FactoryRepairGameMap:_resetGame()
	VersionActivity1_8StatController.instance:statReset()
	Activity157Controller.instance:resetGame()

	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self:initItem(x, y)
			self:_refreshConnectItem(x, y)
		end
	end

	self:_refreshEntryItem()

	self._canTouch = not Activity157RepairGameModel.instance:getGameClear()
end

function VersionActivity1_8FactoryRepairGameMap:_editableInitView()
	self._canTouch = true
	self._gameWidth, self._gameHeight = Activity157RepairGameModel.instance:getGameSize()
end

function VersionActivity1_8FactoryRepairGameMap:onUpdateParam()
	return
end

function VersionActivity1_8FactoryRepairGameMap:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	self._gridItemDict = {}
	self._gridItemList = {}

	for x = 1, self._gameWidth do
		self._gridItemDict[x] = self._gridItemDict[x] or {}

		for y = 1, self._gameHeight do
			self:addNewItem(x, y)
		end
	end

	self:_refreshEntryItem()
end

function VersionActivity1_8FactoryRepairGameMap:addNewItem(x, y)
	self:_newPipeItem(x, y)
	self:initItem(x, y)
	self:_refreshConnectItem(x, y)
end

function VersionActivity1_8FactoryRepairGameMap:_newPipeItem(x, y)
	local itemPath = self.viewContainer._viewSetting.otherRes[1]
	local itemGo = self:getResInst(itemPath, self._gomap, x .. "_" .. y)
	local rectTf = itemGo.transform
	local anchorX, anchorY = Activity157RepairGameModel.instance:getRelativePosition(x, y, ITEM_SIZE_X, ITEM_SIZE_Y)

	recthelper.setAnchor(rectTf, anchorX, anchorY)

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, VersionActivity1_8FactoryRepairGameMapItem)

	table.insert(self._gridItemList, comp)

	self._gridItemDict[x][y] = comp
end

function VersionActivity1_8FactoryRepairGameMap:initItem(x, y)
	local mo = Activity157RepairGameModel.instance:getData(x, y)
	local itemObj = self._gridItemDict[x][y]

	itemObj:initItem(mo)
end

function VersionActivity1_8FactoryRepairGameMap:_refreshConnection()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self:_refreshConnectItem(x, y)
		end
	end
end

function VersionActivity1_8FactoryRepairGameMap:_refreshConnectItem(x, y)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local mo = Activity157RepairGameModel.instance:getData(x, y)
		local itemObj = self._gridItemDict[x][y]

		itemObj:initConnectObj(mo)
	end
end

function VersionActivity1_8FactoryRepairGameMap:_refreshEntryItem()
	local entryList = Activity157RepairGameModel.instance:getEntryList()

	for _, mo in pairs(entryList) do
		local x, y = mo.x, mo.y
		local itemObj = self._gridItemDict[x][y]

		itemObj:initItem(mo)
		itemObj:initConnectObj(mo)
	end
end

function VersionActivity1_8FactoryRepairGameMap:getXYByPosition(position)
	local tempPos = recthelper.screenPosToAnchorPos(position, self._gomapTrs)
	local x, y = Activity157RepairGameModel.instance:getIndexByTouchPos(tempPos.x, tempPos.y, ITEM_SIZE_X, ITEM_SIZE_Y)

	if x ~= -1 then
		return x, y
	end
end

function VersionActivity1_8FactoryRepairGameMap:onClose()
	return
end

function VersionActivity1_8FactoryRepairGameMap:onDestroyView()
	return
end

return VersionActivity1_8FactoryRepairGameMap
