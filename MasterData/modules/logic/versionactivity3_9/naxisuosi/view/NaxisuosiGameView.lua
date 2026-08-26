-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/view/NaxisuosiGameView.lua

module("modules.logic.versionactivity3_9.naxisuosi.view.NaxisuosiGameView", package.seeall)

local NaxisuosiGameView = class("NaxisuosiGameView", BaseView)

function NaxisuosiGameView:onInitView()
	self._simageFullBG1 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG1")
	self._simageFullBG2 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG2")
	self._goMap = gohelper.findChild(self.viewGO, "#go_Map")
	self._goItem = gohelper.findChild(self.viewGO, "#go_Map/#go_Item")
	self._goClickArea = gohelper.findChild(self.viewGO, "#go_Map/#go_Item/#go_ClickArea")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self._txtTips = gohelper.findChildTextMesh(self.viewGO, "Tips/txt_Tips")
	self._animatorFinish = gohelper.findChildComponent(self.viewGO, "#go_finish", gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NaxisuosiGameView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self.addEventCb(self, NaxisuosiController.instance, NaxisuosiPipeEvent.PipeGameClear, self._onGameClear, self)
	self.addEventCb(self, NaxisuosiController.instance, NaxisuosiPipeEvent.ResetGameRefresh, self._onResetGame, self)
end

function NaxisuosiGameView:removeEvents()
	self._btnreset:RemoveClickListener()
	self:removeEventCb(NaxisuosiController.instance, NaxisuosiPipeEvent.PipeGameClear, self._onGameClear)
	self:removeEventCb(NaxisuosiController.instance, NaxisuosiPipeEvent.ResetGameRefresh, self._onResetGame)
end

function NaxisuosiGameView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Va3Act124ResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function NaxisuosiGameView:_editableInitView()
	self._gomapTrs = self._goMap.transform
	self._itemSizeX = 123.3
	self._itemSizeY = 123
	self._gameWidth, self._gameHeight = NaxisuosiPipeModel.instance:getGameSize()
	self._canTouch = true
	self._btnUIClick = SLFramework.UGUI.UIClickListener.Get(self._goMap)

	self._btnUIClick:AddClickListener(self._onbtnUIClick, self)
	gohelper.setActive(self._gofinish, false)
	gohelper.setActive(self._goItem, false)
end

function NaxisuosiGameView:onUpdateParam()
	return
end

function NaxisuosiGameView:onOpen()
	local mapType = NaxisuosiPipeModel.instance:getMapType()

	gohelper.setActive(self._simageFullBG1.gameObject, mapType == NaxisuosiPipeEnum.MapType.Blue)
	gohelper.setActive(self._simageFullBG2.gameObject, mapType == NaxisuosiPipeEnum.MapType.Orange)

	local mapW = self._gameWidth * self._itemSizeX
	local mapH = self._gameHeight * self._itemSizeY

	recthelper.setSize(self._gomapTrs, mapW, mapH)
	NaxisuosiPipeModel.instance:setMapSize(mapW, mapH, self._itemSizeX, self._itemSizeY)

	self._gridItemDict = {}
	self._gridItemList = {}

	for x = 1, self._gameWidth do
		self._gridItemDict[x] = self._gridItemDict[x] or {}

		for y = 1, self._gameHeight do
			self:addNewItem(x, y)
		end
	end

	self:_refreshEntryItem()

	for y = self._gameHeight, 1, -1 do
		for x = 1, self._gameWidth do
			local itemObj = self._gridItemDict[x][y]

			if itemObj and itemObj.viewGO then
				itemObj.viewGO.transform:SetAsLastSibling()
			end
		end
	end

	self:_refreshTitle()
end

function NaxisuosiGameView:_refreshTitle()
	local episodeConfig = NaxisuosiPipeModel.instance:getEpisodeCo()
	local actId = NaxisuosiModel.instance:getActId()
	local mapConfig = NaxisuosiConfig.instance:getMapCo(actId, episodeConfig.episodeId)

	self._txtTips.text = mapConfig.desc
end

function NaxisuosiGameView:_resetGame()
	NaxisuosiController.instance:resetGame()

	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self:initItem(x, y)
			self:_refreshConnectItem(x, y)
		end
	end

	self:_refreshEntryItem()

	self._canTouch = not NaxisuosiPipeModel.instance:getGameClear()
end

function NaxisuosiGameView:_onResetGame()
	gohelper.setActive(self._gofinish, false)
end

function NaxisuosiGameView:_onGameClear()
	gohelper.setActive(self._gofinish, true)
	self._animatorFinish:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_9.Naxisuosi.play_ui_diqiu_complete)

	self._canTouch = false
end

function NaxisuosiGameView:addNewItem(x, y)
	self:_newPipeItem(x, y)
	self:initItem(x, y)
	self:_refreshConnectItem(x, y)
end

function NaxisuosiGameView:_newPipeItem(x, y)
	local itemGo = gohelper.clone(self._goItem, self._goMap, x .. "_" .. y)

	gohelper.setActive(itemGo, true)

	local rectTf = itemGo.transform
	local anchorX, anchorY = NaxisuosiPipeModel.instance:getRelativePosition(x, y)

	recthelper.setAnchor(rectTf, anchorX, anchorY)

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, NaxisuosiPipeItem)

	table.insert(self._gridItemList, comp)

	self._gridItemDict[x][y] = comp
end

function NaxisuosiGameView:initItem(x, y)
	local mo = NaxisuosiPipeModel.instance:getData(x, y)
	local itemObj = self._gridItemDict[x][y]

	itemObj:initItem(mo)
end

function NaxisuosiGameView:_syncRotation(x, y, mo)
	if mo:isEntry() then
		return
	end

	local itemObj = self._gridItemDict[x][y]

	itemObj:syncRotation(mo)
end

function NaxisuosiGameView:_refreshConnectItem(x, y)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local mo = NaxisuosiPipeModel.instance:getData(x, y)
		local itemObj = self._gridItemDict[x][y]

		itemObj:initConnectObj(mo)
	end
end

function NaxisuosiGameView:_refreshConnection()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			self:_refreshConnectItem(x, y)
		end
	end
end

function NaxisuosiGameView:_refreshEntryItem()
	local entryList = NaxisuosiPipeModel.instance:getEntryList()

	for _, mo in pairs(entryList) do
		local x, y = mo.x, mo.y
		local itemObj = self._gridItemDict[x][y]

		itemObj:initItem(mo)
		itemObj:initConnectObj(mo)
	end
end

function NaxisuosiGameView:_onbtnUIClick()
	local pos = GamepadController.instance:getMousePosition()

	self:_onClickContainer(pos)
end

function NaxisuosiGameView:_onClickContainer(position)
	local tempPos = recthelper.screenPosToAnchorPos(position, self._gomapTrs)
	local x, y = NaxisuosiPipeModel.instance:getIndexByTouchPos(tempPos.x, tempPos.y)

	if x ~= -1 then
		self:_onClickGridItem(x, y)
	end
end

function NaxisuosiGameView:_onClickGridItem(x, y)
	if not self._canTouch then
		return
	end

	local mo = NaxisuosiPipeModel.instance:getData(x, y)

	if mo:isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	NaxisuosiController.instance:changeDirection(x, y, true)
	NaxisuosiController.instance:updateConnection()
	self:_syncRotation(x, y, mo)
	self:_refreshConnection()
	self:_refreshEntryItem()

	self._canTouch = not NaxisuosiPipeModel.instance:getGameClear()

	NaxisuosiController.instance:checkDispatchClear()
end

function NaxisuosiGameView:onClose()
	if self._btnUIClick then
		self._btnUIClick:RemoveClickListener()

		self._btnUIClick = nil
	end
end

function NaxisuosiGameView:onDestroyView()
	if self._gridItemList then
		for i = 1, #self._gridItemList do
			local item = self._gridItemList[i]

			if item and item.viewGO then
				gohelper.destroy(item.viewGO)
			end
		end
	end

	self._gridItemList = nil
	self._gridItemDict = nil
end

return NaxisuosiGameView
