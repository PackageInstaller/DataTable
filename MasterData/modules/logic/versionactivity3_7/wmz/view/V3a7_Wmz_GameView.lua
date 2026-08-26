-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameView.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameView", package.seeall)

local V3a7_Wmz_GameView = class("V3a7_Wmz_GameView", BaseView)

function V3a7_Wmz_GameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._simageBG = gohelper.findChildSingleImage(self.viewGO, "#go_map/Viewport/Content/#simage_BG")
	self._goPiece = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_Piece")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_Title")
	self._goSelection = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_Selection")
	self._gocells = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_cells")
	self._gotiles = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_tiles")
	self._goselections = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_selections")
	self._gotitles = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_titles")
	self._goFrame = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_Frame")
	self._goframes = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content/#go_frames")
	self._goTarget = gohelper.findChild(self.viewGO, "#go_Target")
	self._txtRound = gohelper.findChildText(self.viewGO, "#go_Target/#txt_Round")
	self._txtTarget = gohelper.findChildText(self.viewGO, "#go_Target/#txt_Target")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._goPoint = gohelper.findChild(self.viewGO, "Point/#go_Point")
	self._goLight = gohelper.findChild(self.viewGO, "Point/#go_Point/#go_Light")
	self._btnClickPoint = gohelper.findChildButtonWithAudio(self.viewGO, "Point/#go_Point/#btn_ClickPoint")
	self._goComplete = gohelper.findChild(self.viewGO, "#go_Complete")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_back")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameView:addEvents()
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function V3a7_Wmz_GameView:removeEvents()
	self._btnback:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

local math_floor = math.floor
local math_abs = math.abs
local sf = string.format
local string_rep = string.rep
local ti = table.insert
local csTweenHelper = ZProj.TweenHelper

function V3a7_Wmz_GameView:_btnbackOnClick()
	return
end

function V3a7_Wmz_GameView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.WmzRestartZone, MsgBoxEnum.BoxType.Yes_No, self._endYesRestartCallback, nil, nil, self, nil, nil)
end

function V3a7_Wmz_GameView:_endYesRestartCallback()
	self.viewContainer:trackReset(self._ctx._edit_Energy)

	local lastPointItem = self._lastPointItem

	self._ctx:_critical_beforeClear()
	self.viewContainer:restartCurZone()

	local curPlayingZoneIndex = self.viewContainer:curPlayingZoneIndex()

	self:onCompleteZone_Cells(curPlayingZoneIndex, false)
	self:onCompleteZone_Tiles(curPlayingZoneIndex, false)
	self._ctx:reset(self)
	self:_onNewRound()
	self:_onClickPointItem(lastPointItem)
end

function V3a7_Wmz_GameView:gridSizeV2()
	return self._gridSizeV2
end

function V3a7_Wmz_GameView:gridHalfSizeV2()
	return self._gridHalfSizeV2
end

function V3a7_Wmz_GameView:gridSizeAndHalfV2()
	return self._gridSizeV2, self._gridHalfSizeV2
end

function V3a7_Wmz_GameView:contentSizeV2()
	return self._contentSizeV2
end

function V3a7_Wmz_GameView:contentHalfSizeV2()
	return self._contentHalfSizeV2
end

function V3a7_Wmz_GameView:contentSizeAndHalfV2()
	return self._contentSizeV2, self._contentHalfSizeV2
end

function V3a7_Wmz_GameView:viewportSizeV2()
	return self._viewportSizeV2
end

function V3a7_Wmz_GameView:viewportHalfSizeV2()
	return self._viewportHalfSizeV2
end

function V3a7_Wmz_GameView:viewportSizeAndHalfV2()
	return self._viewportSizeV2, self._viewportHalfSizeV2
end

function V3a7_Wmz_GameView:ctor(...)
	V3a7_Wmz_GameView.super.ctor(self, ...)

	self._cellItemList = {}
	self._tileItemList = {}
	self._gridIndexToCellListIndex = {}
	self._pointItemList = {}
	self._titleItemList = {}
	self._selectionItemList = {}
	self._frameItemList = {}
end

local kCachedSelectionCnt = 10

function V3a7_Wmz_GameView:_editableInitView()
	self._goPieceTrans = self._goPiece.transform

	local pieceW = recthelper.getWidth(self._goPieceTrans)
	local pieceH = recthelper.getHeight(self._goPieceTrans)

	self._gridSizeV2 = Vector2.New(pieceW, pieceH)
	self._gridHalfSizeV2 = self._gridSizeV2 / 2
	self._mapScrollRect = self._gomap:GetComponent(gohelper.Type_ScrollRect)
	self._mapViewportGo = gohelper.findChild(self._gomap, "Viewport")
	self._mapViewportTrans = self._mapViewportGo.transform
	self._mapContentGo = gohelper.findChild(self._mapViewportGo, "Content")
	self._mapContentSingleBg = gohelper.findChildSingleImage(self._mapContentGo, "")
	self._mapContentTrans = self._mapContentGo.transform

	gohelper.setActive(self._goPoint, false)
	self:_editableInitView_layout()
	self:setText_txtTarget("")
	self:setText_txtRound("")
	gohelper.setActive(self._goselections, false)

	for i = 1, kCachedSelectionCnt do
		local item = self:_create_V3a7_Wmz_GameItem_Selection(i)

		ti(self._selectionItemList, item)
	end
end

function V3a7_Wmz_GameView:_editableInitView_layout()
	local mapW, mapH = self.viewContainer:mapSize()
	local gridSizeV2 = self:gridSizeV2()
	local contentW = mapW * gridSizeV2.x
	local contentH = mapH * gridSizeV2.y

	self:_initContentSize(contentW, contentH)
	recthelper.setSize(self._mapContentTrans, contentW, contentH)
end

function V3a7_Wmz_GameView:_initContentSize(w, h)
	self._contentSizeV2 = Vector2.New(w, h)
	self._contentHalfSizeV2 = self._contentSizeV2 / 2

	self:_initViewportSize()
end

function V3a7_Wmz_GameView:_initViewportSize()
	self._viewportSizeV2 = self._mapViewportTrans.rect.size
	self._viewportHalfSizeV2 = self._viewportSizeV2 / 2

	self:_initContentBounds()
end

function V3a7_Wmz_GameView:_initContentBounds()
	local viewportHalfSizeV2 = self:viewportHalfSizeV2()
	local contentHalfSizeV2 = self:contentHalfSizeV2()
	local ofsX = math_abs(viewportHalfSizeV2.x - contentHalfSizeV2.x)
	local ofsY = math_abs(viewportHalfSizeV2.y - contentHalfSizeV2.y)

	self._contentPosMinV2 = Vector2.New(-ofsX, -ofsY)
	self._contentPosMaxV2 = Vector2.New(ofsX, ofsY)
end

function V3a7_Wmz_GameView:onOpen()
	self._lastPointItem = nil
	self._lastTileItem = nil
	self._id2TileItemDict = {}
	self._ctx = self.viewContainer:dragContext()

	self:_onGameStart()
	self.viewContainer:trackMO():onGameStart()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_molu_exit_appear)
end

function V3a7_Wmz_GameView:_onScreenResize()
	self:_initViewportSize()
end

function V3a7_Wmz_GameView:onOpenFinish()
	return
end

function V3a7_Wmz_GameView:onClose()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenFocus_DOAnchorPos")
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	GameUtil.onDestroyViewMember(self, "_gameStartFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")
	self._ctx:_critical_beforeClear()
end

function V3a7_Wmz_GameView:onDestroyView()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenFocus_DOAnchorPos")
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")
	GameUtil.onDestroyViewMember(self, "_gameStartFlow")
	GameUtil.onDestroyViewMemberList(self, "_pointItemList")
	GameUtil.onDestroyViewMemberList(self, "_titleItemList")
	GameUtil.onDestroyViewMemberList(self, "_selectionItemList")
	GameUtil.onDestroyViewMemberList(self, "_frameItemList")
	GameUtil.onDestroyViewMemberList(self, "_tileItemList")
	GameUtil.onDestroyViewMemberList(self, "_cellItemList")
end

function V3a7_Wmz_GameView:onDragBegin(...)
	self._ctx:onDragBegin(...)
end

function V3a7_Wmz_GameView:onDrag(...)
	self._ctx:onDrag(...)
end

function V3a7_Wmz_GameView:onDragEnd(...)
	self._ctx:onDragEnd(...)
end

function V3a7_Wmz_GameView:_onGameStart()
	self._ctx:reset(self)
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")
	GameUtil.onDestroyViewMember(self, "_gameStartFlow")

	self._gameStartFlow = WmzGameStartFlow.New()

	self._gameStartFlow:registerDoneListener(self._onNewRound, self)
	self._gameStartFlow:start(self._ctx)
end

function V3a7_Wmz_GameView:_onNewRound()
	self:_refreshEnergy()
	self:_refreshZoneProgress()
	self:setActive_goComplete(false)
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")

	self._newRoundStartFlow = WmzNewRoundStartFlow.New()

	self._newRoundStartFlow:start(self._ctx)
end

function V3a7_Wmz_GameView:_onEndRound()
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")

	self._newRoundEndFlow = WmzNewRoundEndFlow.New()

	self._newRoundEndFlow:start(self._ctx)
end

function V3a7_Wmz_GameView:onCompleteGame()
	self.viewContainer:completeGame(true)
end

function V3a7_Wmz_GameView:viewportToContentLocalPosXY(viewportLocalX, viewportLocalY)
	if not viewportLocalX or not viewportLocalY then
		return -1, -1
	end

	local ofsX, ofsY = recthelper.getAnchor(self._mapContentTrans)
	local contentLocalX = viewportLocalX + ofsX
	local contentLocalY = viewportLocalY + ofsY

	return contentLocalX, contentLocalY
end

function V3a7_Wmz_GameView:screenToContentPosV2(screenPosV2)
	local res = Vector2.New(-1, -1)
	local contentLocalX, contentLocalY = recthelper.screenPosToAnchorPos2(screenPosV2, self._mapContentTrans)

	res:Set(contentLocalX, contentLocalY)

	return res
end

function V3a7_Wmz_GameView:bWithinContentPos(contentLocalX, contentLocalY)
	local contentHalfSizeV2 = self:contentHalfSizeV2()

	if contentLocalX < -contentHalfSizeV2.x or contentLocalX > contentHalfSizeV2.x or contentLocalY < -contentHalfSizeV2.y or contentLocalY > contentHalfSizeV2.y then
		return false
	end

	return true
end

function V3a7_Wmz_GameView:bWithinContentPosByLT(contentLeftTopX, contentLeftTopY)
	local contentSizeV2 = self:contentSizeV2()

	if contentLeftTopX < 0 or contentLeftTopX > contentSizeV2.x or contentLeftTopY < 0 or contentLeftTopY > contentSizeV2.y then
		return false
	end

	return true
end

function V3a7_Wmz_GameView:contentCenterToLeftTopXY(contentLocalV2)
	local contentHalfSizeV2 = self:contentHalfSizeV2()
	local ltx = contentLocalV2.x + contentHalfSizeV2.x
	local lty = contentHalfSizeV2.y - contentLocalV2.y

	return ltx, lty
end

function V3a7_Wmz_GameView:contentToGridCoordXY(contentLocalV2)
	if contentLocalV2.x == -1 or contentLocalV2.y == -1 then
		return -1, -1
	end

	local gridSizeV2 = self:gridSizeV2()
	local ltx, lty = self:contentCenterToLeftTopXY(contentLocalV2)

	if not self:bWithinContentPosByLT(ltx, lty) then
		return -1, -1
	end

	local gridCoordX = math_floor(ltx / gridSizeV2.x)
	local gridCoordY = math_floor(lty / gridSizeV2.y)

	if not self.viewContainer:bValidCoord(gridCoordX, gridCoordY) then
		return -1, -1
	end

	return gridCoordX, gridCoordY
end

function V3a7_Wmz_GameView:contentToGridCoordV2(contentLocalV2)
	local x, y = self:contentToGridCoordXY(contentLocalV2)

	return Vector2.New(x, y)
end

function V3a7_Wmz_GameView:screenToGridCoordXY(screenPosV2)
	local contentLocalV2 = self:screenToContentPosV2(screenPosV2)

	return self:contentToGridCoordXY(contentLocalV2)
end

function V3a7_Wmz_GameView:screenToGridCoordV2(screenPosV2)
	local x, y = self:screenToGridCoordXY(screenPosV2)

	return Vector2.New(x, y)
end

function V3a7_Wmz_GameView:gridXY(gridCoordX, gridCoordY)
	local gridSizeV2 = self:gridSizeV2()
	local gridX = gridCoordX * gridSizeV2.x
	local gridY = gridCoordY * gridSizeV2.y

	return gridX, gridY
end

function V3a7_Wmz_GameView:gridCXCY(gridCoordX, gridCoordY)
	local gridHalfSizeV2 = self:gridHalfSizeV2()
	local gridX, gridY = self:gridXY(gridCoordX, gridCoordY)
	local gridCX = gridX + gridHalfSizeV2.x
	local gridCY = gridY + gridHalfSizeV2.y

	return gridCX, gridCY
end

function V3a7_Wmz_GameView:focusByGridCoordXY(gridCoordX, gridCoordY, bTween)
	if not self.viewContainer:bValidCoord(gridCoordX, gridCoordY) then
		return false
	end

	GameUtil.onDestroyViewMember_TweenId(self, "_tweenFocus_DOAnchorPos")

	local contentLocalX, contentLocalY = self:coordToContentLocalXY(gridCoordX, gridCoordY)
	local clampedAPosX, clampedAPosY = self:clampContentPos(contentLocalX, contentLocalY)
	local focusDurationSec = WmzConfig.instance:focusDurationSec()

	if not bTween or focusDurationSec == 0 then
		self:_setMapContentAPos(clampedAPosX, clampedAPosY)
		self._mapScrollRect:StopMovement()
	else
		self._tweenFocus_DOAnchorPos = csTweenHelper.DOAnchorPos(self._mapContentTrans, clampedAPosX, clampedAPosY, focusDurationSec)
	end

	return true
end

function V3a7_Wmz_GameView:_setMapContentAPos(x, y)
	recthelper.setAnchor(self._mapContentTrans, x, y)
end

function V3a7_Wmz_GameView:coordToContentLocalXY(gridCoordX, gridCoordY)
	local gridCX, gridCY = self:gridCXCY(gridCoordX, gridCoordY)
	local contentHalfSizeV2 = self:contentHalfSizeV2()
	local contentLocalX = contentHalfSizeV2.x - gridCX
	local contentLocalY = -(contentHalfSizeV2.y - gridCY)

	return contentLocalX, contentLocalY
end

function V3a7_Wmz_GameView:clampContentPos(targetContentX, targetContentY)
	local clampedX = GameUtil.clamp(targetContentX, self._contentPosMinV2.x, self._contentPosMaxV2.x)
	local clampedY = GameUtil.clamp(targetContentY, self._contentPosMinV2.y, self._contentPosMaxV2.y)

	return clampedX, clampedY
end

function V3a7_Wmz_GameView:coordToAPosInContentSpace(gridCoordX, gridCoordY)
	local gridX, gridY = self:gridXY(gridCoordX, gridCoordY)
	local contentHalfSizeV2 = self:contentHalfSizeV2()
	local gridAPosX = gridX - contentHalfSizeV2.x
	local gridAPosY = -(gridY - contentHalfSizeV2.y)

	return gridAPosX, gridAPosY
end

function V3a7_Wmz_GameView:_refreshMap()
	self:_refreshItems()
	self:_refreshPoints()
	self:_refreshTitles()
	self:_refreshFrames()
	self:_autoSelectZone()
end

function V3a7_Wmz_GameView:_refreshEnergy(displayEnergy)
	displayEnergy = displayEnergy or self.viewContainer:curEnergy()

	self:setText_txtRound(sf(luaLang("V3a7_Wmz_GameView_txtRound"), displayEnergy))
end

function V3a7_Wmz_GameView:_refreshZoneProgress(displayMin, displayMax)
	if not displayMin then
		displayMin, displayMax = self.viewContainer:zoneClearCurAndMax()
	end

	self:setText_txtTarget(GameUtil.getSubPlaceholderLuaLang(luaLang("V3a7_Wmz_GameView_txtTarget"), {
		displayMin,
		displayMax
	}))
end

function V3a7_Wmz_GameView:getCellItem(x, y)
	local flattenIndex = self.viewContainer:calcCellFlattenIndex(x, y)

	if flattenIndex < 0 then
		return nil
	end

	local cellItemIndex = self._gridIndexToCellListIndex[flattenIndex]

	return self._cellItemList[cellItemIndex]
end

function V3a7_Wmz_GameView:getTileItem(tileId)
	local tileItemIndex = self._tileIdToTileListIndex[tileId]

	return self._tileItemList[tileItemIndex]
end

function V3a7_Wmz_GameView:getTileItemByXY(x, y)
	local cellItem = self:getCellItem(x, y)

	if not cellItem then
		return nil
	end

	return self:getTileItem(cellItem:tileId())
end

function V3a7_Wmz_GameView:getItemByObj(gridObj)
	if gridObj:isTile() then
		local tileId = gridObj:tileId()

		return self:getTileItem(tileId)
	else
		local x, y = gridObj:xy()

		return self:getCellItem(x, y)
	end
end

function V3a7_Wmz_GameView:_refreshCells()
	local validCnt = 0

	self._gridIndexToCellListIndex = {}

	self.viewContainer:foreachCell(function(cellObj, i, x, y)
		if cellObj:isNothing() then
			return
		end

		validCnt = validCnt + 1

		local item

		if validCnt > #self._cellItemList then
			item = self:_create_V3a7_Wmz_CellItem(validCnt, cellObj)

			ti(self._cellItemList, item)
		else
			item = self._cellItemList[validCnt]
		end

		self._gridIndexToCellListIndex[i] = validCnt

		item:onUpdateMO(cellObj)
		item:resetPos()
		item:setActive(true)
		item:playIdleAnim()
	end)

	for i = validCnt + 1, #self._cellItemList do
		local item = self._cellItemList[i]

		item:setActive(false)
	end
end

function V3a7_Wmz_GameView:_refreshTiles()
	local validCnt = 0

	self._tileIdToTileListIndex = {}

	self.viewContainer:foreachTile(function(tileObj, tileId, x, y)
		validCnt = validCnt + 1

		local item

		if validCnt > #self._tileItemList then
			item = self:_create_V3a7_Wmz_GameItem_Tile(validCnt, tileObj)

			ti(self._tileItemList, item)
		else
			item = self._tileItemList[validCnt]
		end

		self._tileIdToTileListIndex[tileId] = validCnt
		item._tmpbWelded = nil

		item:onUpdateMO(tileObj)
		item:resetPos()
		item:setActive(true)
		item:playIdleAnim()
	end)

	for i = validCnt + 1, #self._tileItemList do
		local item = self._tileItemList[i]

		item:setActive(false)
	end
end

function V3a7_Wmz_GameView:_refreshItems()
	self:_refreshCells()
	self:_refreshTiles()
end

function V3a7_Wmz_GameView:_refreshPoints()
	local zoneCOList = self.viewContainer:getZoneCOList()
	local curSelectedZoneIdx = self:getSelectedZoneIdx()

	for i, zoneCO in ipairs(zoneCOList) do
		local item

		if i > #self._pointItemList then
			item = self:_create_V3a7_Wmz_GameItem_Point(i)

			ti(self._pointItemList, item)
		else
			item = self._pointItemList[i]
		end

		item:onUpdateMO(zoneCO)
		item:setActive(true)
		item:setSelected(i == curSelectedZoneIdx)
	end

	for i = #zoneCOList + 1, #self._pointItemList do
		local item = self._pointItemList[i]

		item:setActive(false)
	end
end

function V3a7_Wmz_GameView:onClickPointItem(item)
	if self._lastPointItem == item then
		return
	end

	if item then
		if self._lastPointItem and self._lastPointItem:index() == item:index() then
			return
		end

		if not item:bZoneUnlocked() then
			GameFacade.showToast(ToastEnum.WmzClickLockedZone)

			return
		end
	end

	self:_onClickPointItem(item)
end

function V3a7_Wmz_GameView:_onClickPointItem(item)
	local selectedZoneIndex = -1

	if self._lastPointItem then
		self._lastPointItem:setSelected(false)
	end

	self._lastPointItem = item

	if item then
		selectedZoneIndex = item:index()

		item:setSelected(true)

		local gridCoordX, gridCoordY = item:focusCoordXY()

		self:focusByGridCoordXY(gridCoordX, gridCoordY, true)
		GameUtil.loadSImage(self._simageFullBG, item:getZoneBgResUrl())
	end

	for _, frameItem in ipairs(self._frameItemList) do
		local bSelected = frameItem:zoneIndex() == selectedZoneIndex

		frameItem:setGrayScale(bSelected)
	end

	for _, cellItem in ipairs(self._cellItemList) do
		local bSelected = cellItem:zoneIndex() == selectedZoneIndex

		cellItem:setGrayScale(bSelected)

		local tileItem = cellItem:getTileItem()

		if tileItem then
			tileItem:setGrayScale(bSelected)
		end
	end
end

function V3a7_Wmz_GameView:selectZone(zoneIndex)
	local item = self._pointItemList[zoneIndex]

	self:_onClickPointItem(item)
end

function V3a7_Wmz_GameView:getSelectedZoneIdx()
	local res = -1

	res = self._lastPointItem and self._lastPointItem:index() or self.viewContainer:curPlayingZoneIndex()

	local zoneCOList = self.viewContainer:getZoneCOList()

	return GameUtil.clamp(res, 1, #zoneCOList)
end

function V3a7_Wmz_GameView:_autoSelectZone()
	local curSelectedZoneIdx = self:getSelectedZoneIdx()
	local item = self._pointItemList[curSelectedZoneIdx]

	self:onClickPointItem(item)
end

function V3a7_Wmz_GameView:_refreshTitles()
	local zoneCOList = self.viewContainer:getZoneCOList()

	for i, zoneCO in ipairs(zoneCOList) do
		local item

		if i > #self._titleItemList then
			item = self:_create_V3a7_Wmz_GameItem_Title(i)

			ti(self._titleItemList, item)
		else
			item = self._titleItemList[i]
		end

		item:onUpdateMO(zoneCO)
		item:setActive(true)
		item:playIdleAnim()
	end

	for i = #zoneCOList + 1, #self._titleItemList do
		local item = self._titleItemList[i]

		item:setActive(false)
	end
end

function V3a7_Wmz_GameView:_refreshFrames()
	local zoneCOList = self.viewContainer:getZoneCOList()

	for i, zoneCO in ipairs(zoneCOList) do
		local item

		if i > #self._frameItemList then
			item = self:_create_V3a7_Wmz_GameItem_Frame(i)

			ti(self._frameItemList, item)
		else
			item = self._frameItemList[i]
		end

		item:onUpdateMO(zoneCO)
		item:setActive(true)
	end

	for i = #zoneCOList + 1, #self._frameItemList do
		local item = self._frameItemList[i]

		item:setActive(false)
	end
end

function V3a7_Wmz_GameView:_create_V3a7_Wmz_CellItem(index, gridObj)
	local go = gohelper.clone(self._goPiece, self._gocells)
	local item
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}

	item = gridObj:isStart() and V3a7_Wmz_GameItem_Start.New(ctroParams) or V3a7_Wmz_GameItem_Cell.New(ctroParams)

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a7_Wmz_GameView:_create_V3a7_Wmz_GameItem_Tile(index, gridObj)
	local go = gohelper.clone(self._goPiece, self._gotiles)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a7_Wmz_GameItem_Tile.New(ctroParams)

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a7_Wmz_GameView:_create_V3a7_Wmz_GameItem_Point(index)
	local go = gohelper.cloneInPlace(self._goPoint)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a7_Wmz_GameItem_Point.New(ctroParams)

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a7_Wmz_GameView:_create_V3a7_Wmz_GameItem_Title(index)
	local go = gohelper.clone(self._goTitle, self._gotitles)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a7_Wmz_GameItem_Title.New(ctroParams)

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a7_Wmz_GameView:_create_V3a7_Wmz_GameItem_Frame(index)
	local go = gohelper.clone(self._goFrame, self._goframes)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a7_Wmz_GameItem_Frame.New(ctroParams)

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a7_Wmz_GameView:_create_V3a7_Wmz_GameItem_Selection(index)
	local go = gohelper.clone(self._goSelection, self._goselections)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a7_Wmz_GameItem_Selection.New(ctroParams)

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a7_Wmz_GameView:setActive_goComplete(bActive)
	if bActive then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_diqiu_complete)
	end

	gohelper.setActive(self._goComplete, bActive)
end

function V3a7_Wmz_GameView:setText_txtTarget(str)
	self._txtTarget.text = str
end

function V3a7_Wmz_GameView:setText_txtRound(str)
	self._txtRound.text = str
end

function V3a7_Wmz_GameView:_clearCache()
	self._lastPointItem = nil
	self._lastTileItem = nil
	self._id2TileItemDict = {}
end

function V3a7_Wmz_GameView:_refreshSelections(refSelectedXYDict)
	if isDebugBuild then
		assert(type(refSelectedXYDict) == "table")
	end

	gohelper.setActive(self._goselections, false)

	local function _bSelected(x, y)
		if not refSelectedXYDict[x] then
			return false
		end

		return not not refSelectedXYDict[x][y]
	end

	local function _bSelectedV2(v2)
		return _bSelected(v2.x, v2.y)
	end

	local function _bConvex(adj1Bool, adj2Bool, diagBool)
		return adj1Bool and adj2Bool and not diagBool
	end

	local function _bConcave(adj1Bool, adj2Bool, diagBool)
		return not adj1Bool and not adj2Bool and diagBool
	end

	local function _bCorner(adj1Bool, adj2Bool, diagBool)
		return not adj1Bool and not adj2Bool and not diagBool
	end

	local validCnt = 0

	for tileId, tileItem in pairs(self._id2TileItemDict) do
		validCnt = validCnt + 1

		local item

		if validCnt > #self._selectionItemList then
			item = self:_create_V3a7_Wmz_GameItem_Selection(validCnt)

			ti(self._selectionItemList, item)
		else
			item = self._selectionItemList[validCnt]
		end

		item:onUpdateMO(tileItem)

		local tileV2 = tileItem._mo.index
		local uV2 = tileV2 + WmzEnum.DirV2[WmzEnum.Dir.Up]
		local rV2 = tileV2 + WmzEnum.DirV2[WmzEnum.Dir.Right]
		local dV2 = tileV2 + WmzEnum.DirV2[WmzEnum.Dir.Down]
		local lV2 = tileV2 + WmzEnum.DirV2[WmzEnum.Dir.Left]
		local ltV2 = tileV2 + WmzEnum.DirV2[WmzEnum.Corner.LT]
		local rtV2 = tileV2 + WmzEnum.DirV2[WmzEnum.Corner.RT]
		local lbV2 = tileV2 + WmzEnum.DirV2[WmzEnum.Corner.LB]
		local rbV2 = tileV2 + WmzEnum.DirV2[WmzEnum.Corner.RB]
		local ubSelected = _bSelectedV2(uV2)
		local rbSelected = _bSelectedV2(rV2)
		local dbSelected = _bSelectedV2(dV2)
		local lbSelected = _bSelectedV2(lV2)
		local ltbSelected = _bSelectedV2(ltV2)
		local rtbSelected = _bSelectedV2(rtV2)
		local lbbSelected = _bSelectedV2(lbV2)
		local rbbSelected = _bSelectedV2(rbV2)
		local ubShowEdge = not ubSelected
		local rbShowEdge = not rbSelected
		local dbShowEdge = not dbSelected
		local lbShowEdge = not lbSelected

		item:setActive_Edge(WmzEnum.Dir.Up, ubShowEdge)
		item:setActive_Edge(WmzEnum.Dir.Right, rbShowEdge)
		item:setActive_Edge(WmzEnum.Dir.Down, dbShowEdge)
		item:setActive_Edge(WmzEnum.Dir.Left, lbShowEdge)

		local bConnerLT = _bCorner(lbSelected, ubSelected, ltbSelected)
		local bConnerRT = _bCorner(rbSelected, ubSelected, rtbSelected)
		local bConnerLB = _bCorner(lbSelected, dbSelected, lbbSelected)
		local bConnerRB = _bCorner(rbSelected, dbSelected, rbbSelected)
		local bConcaveLT = _bConcave(lbSelected, ubSelected, ltbSelected)
		local bConcaveRT = _bConcave(rbSelected, ubSelected, rtbSelected)
		local bConcaveLB = _bConcave(lbSelected, dbSelected, lbbSelected)
		local bConcaveRB = _bConcave(rbSelected, dbSelected, rbbSelected)
		local bConvexLT = _bConvex(lbSelected, ubSelected, ltbSelected)
		local bConvexRT = _bConvex(rbSelected, ubSelected, rtbSelected)
		local bConvexLB = _bConvex(lbSelected, dbSelected, lbbSelected)
		local bConvexRB = _bConvex(rbSelected, dbSelected, rbbSelected)
		local bShowCornerLT = bConcaveLT or bConvexLT or bConnerLT
		local bShowCornerRT = bConcaveRT or bConvexRT or bConnerRT
		local bShowCornerLB = bConcaveLB or bConvexLB or bConnerLB
		local bShowCornerRB = bConcaveRB or bConvexRB or bConnerRB

		item:setActive_Corner(WmzEnum.Corner.LT, bShowCornerLT)
		item:setActive_Corner(WmzEnum.Corner.RT, bShowCornerRT)
		item:setActive_Corner(WmzEnum.Corner.LB, bShowCornerLB)
		item:setActive_Corner(WmzEnum.Corner.RB, bShowCornerRB)

		if bShowCornerLT then
			local eCorner = WmzEnum.Corner.LT

			if bConnerLT then
				local var_80_0 = 0
			elseif bConcaveLT then
				var_80_0 = WmzEnum.ConcaveZRot[eCorner]

				if not WmzEnum.ConcaveZRot[eCorner] then
					local zDegree = WmzEnum.ConvexZRot[eCorner]

					item:rotateCorner(eCorner, zDegree)
				end
			end
		end

		if bShowCornerRT then
			local eCorner = WmzEnum.Corner.RT

			if bConnerRT then
				local var_80_1 = 0
			elseif bConcaveRT then
				var_80_1 = WmzEnum.ConcaveZRot[eCorner]

				if not WmzEnum.ConcaveZRot[eCorner] then
					local zDegree = WmzEnum.ConvexZRot[eCorner]

					item:rotateCorner(eCorner, zDegree)
				end
			end
		end

		if bShowCornerLB then
			local eCorner = WmzEnum.Corner.LB

			if bConnerLB then
				local var_80_2 = 0
			elseif bConcaveLB then
				var_80_2 = WmzEnum.ConcaveZRot[eCorner]

				if not WmzEnum.ConcaveZRot[eCorner] then
					local zDegree = WmzEnum.ConvexZRot[eCorner]

					item:rotateCorner(eCorner, zDegree)
				end
			end
		end

		if bShowCornerRB then
			local eCorner = WmzEnum.Corner.RB

			if bConnerRB then
				local var_80_3 = 0
			elseif bConcaveRB then
				var_80_3 = WmzEnum.ConcaveZRot[eCorner]

				if not WmzEnum.ConcaveZRot[eCorner] then
					local zDegree = WmzEnum.ConvexZRot[eCorner]

					item:rotateCorner(eCorner, zDegree)
				end
			end
		end

		item:setActive(true)
	end

	for i = validCnt + 1, #self._selectionItemList do
		local item = self._selectionItemList[i]

		item:setActive(false)
	end

	gohelper.setActive(self._goselections, true)
end

function V3a7_Wmz_GameView:selectTile(tileItem)
	if self._lastTileItem == tileItem then
		return
	end

	if self._lastTileItem then
		self:_doUnSelectedTiles()
	end

	self._lastTileItem = tileItem
	self._id2TileItemDict = {}

	if not tileItem then
		return
	end

	if tileItem:bHasGroup() then
		local tileIdList = tileItem:getTileIdListByGroup()

		if isDebugBuild then
			assert(tileIdList and #tileIdList > 0, "invalid group id" .. tostring(tileItem:groupId()))
		end

		for _, tileId in ipairs(tileIdList) do
			self._id2TileItemDict[tileId] = self:getTileItem(tileId)
		end
	else
		self._id2TileItemDict[tileItem:tileId()] = tileItem
	end

	self:_doSelectedTiles()
end

function V3a7_Wmz_GameView:_doUnSelectedTiles()
	for _, item in pairs(self._id2TileItemDict) do
		item:setSelected(false)
	end

	gohelper.setActive(self._goselections, false)
end

function V3a7_Wmz_GameView:_doSelectedTiles()
	local refSelectedXYDict = {}

	for _, item in pairs(self._id2TileItemDict) do
		local x, y = item:xy()

		item:setSelected(true)

		refSelectedXYDict[x] = refSelectedXYDict[x] or {}
		refSelectedXYDict[x][y] = true
	end

	self:_refreshSelections(refSelectedXYDict)
end

function V3a7_Wmz_GameView:onTileItemClick(tileItem)
	self:selectTile(tileItem)
end

function V3a7_Wmz_GameView:curSelectedTileItem()
	return self._lastTileItem
end

function V3a7_Wmz_GameView:curSelectedId2TileItemDict()
	return self._id2TileItemDict
end

function V3a7_Wmz_GameView:onCompleteZone()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)
	self:_onEndRound()
end

function V3a7_Wmz_GameView:onFailed()
	self.viewContainer:onFailed()
end

function V3a7_Wmz_GameView:_onCompleteZoneImpl(list, optZoneIndex, bCompleted)
	for i, item in ipairs(list) do
		local zoneIndex = item:zoneIndex()

		if not optZoneIndex then
			item:onCompleteZone(bCompleted)
		elseif zoneIndex == optZoneIndex then
			item:onCompleteZone(bCompleted)
		end
	end
end

function V3a7_Wmz_GameView:onCompleteZone_Titles(optZoneIndex, bCompleted)
	self:_onCompleteZoneImpl(self._titleItemList, optZoneIndex, bCompleted)
end

function V3a7_Wmz_GameView:onCompleteZone_Points(optZoneIndex, bCompleted)
	self:_onCompleteZoneImpl(self._pointItemList, optZoneIndex, bCompleted)
end

function V3a7_Wmz_GameView:onCompleteZone_Cells(optZoneIndex, bCompleted)
	self:_onCompleteZoneImpl(self._cellItemList, optZoneIndex, bCompleted)
end

function V3a7_Wmz_GameView:onCompleteZone_Tiles(optZoneIndex, bCompleted)
	self:_onCompleteZoneImpl(self._tileItemList, optZoneIndex, bCompleted)
end

function V3a7_Wmz_GameView:setEnableDragTiles(optZoneIndex, bEnabled)
	for i, item in ipairs(self._tileItemList) do
		local zoneIndex = item:zoneIndex()

		if not optZoneIndex then
			item:setActive_godragArea(bEnabled)
		elseif zoneIndex == optZoneIndex then
			item:setActive_godragArea(bEnabled)
		end
	end
end

function V3a7_Wmz_GameView:dump(refStrBuf, depth)
	depth = depth or 0

	local tab = string_rep("\t", depth)

	ti(refStrBuf, tab .. sf("Content Bounds: X[%.2f, %.2f] Y[%.2f, %.2f]", self._contentPosMinV2.x, self._contentPosMaxV2.x, self._contentPosMinV2.y, self._contentPosMaxV2.y))
end

return V3a7_Wmz_GameView
