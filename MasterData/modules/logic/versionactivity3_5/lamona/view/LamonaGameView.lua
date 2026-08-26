-- chunkname: @modules/logic/versionactivity3_5/lamona/view/LamonaGameView.lua

module("modules.logic.versionactivity3_5.lamona.view.LamonaGameView", package.seeall)

local LamonaGameView = class("LamonaGameView", BaseView)
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode
local GrayColor = "#A0A0A0"
local LightColor = "#FFFFFF"

function LamonaGameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_back")
	self._imgback = gohelper.findChildImage(self.viewGO, "#go_topright/#btn_back")
	self._txtback = gohelper.findChildText(self.viewGO, "#go_topright/#btn_back/txt_back")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_reset")
	self._txttarget = gohelper.findChildText(self.viewGO, "#go_desc/#txt_target")
	self._txtremainRound = gohelper.findChildText(self.viewGO, "#go_desc/#txt_remainRound")
	self._btnLeft = gohelper.findChildClick(self.viewGO, "#go_joyPoint/#go_joystick/#go_background/btn_left")
	self._btnRight = gohelper.findChildClick(self.viewGO, "#go_joyPoint/#go_joystick/#go_background/btn_right")
	self._btnUp = gohelper.findChildClick(self.viewGO, "#go_joyPoint/#go_joystick/#go_background/btn_up")
	self._btnDown = gohelper.findChildClick(self.viewGO, "#go_joyPoint/#go_joystick/#go_background/btn_down")
	self._btnprop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_prop")
	self._goproplight = gohelper.findChild(self.viewGO, "#btn_prop/#go_light")
	self._imageproplight = gohelper.findChildImage(self.viewGO, "#btn_prop/#go_light/img_icon")
	self._gopropdisable = gohelper.findChild(self.viewGO, "#btn_prop/#go_disable")
	self._imagepropdisable = gohelper.findChildImage(self.viewGO, "#btn_prop/#go_disable/img_icon")
	self._txtprop = gohelper.findChildText(self.viewGO, "#btn_prop/#txt_prop")
	self._txtpropdesc = gohelper.findChildText(self.viewGO, "#btn_prop/Image_Tips/#txt_Descr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LamonaGameView:addEvents()
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnLeft:AddClickListener(self._btnDirectionOnClick, self, LamonaEnum.Direction.Left)
	self._btnRight:AddClickListener(self._btnDirectionOnClick, self, LamonaEnum.Direction.Right)
	self._btnUp:AddClickListener(self._btnDirectionOnClick, self, LamonaEnum.Direction.Up)
	self._btnDown:AddClickListener(self._btnDirectionOnClick, self, LamonaEnum.Direction.Down)
	self._btnprop:AddClickListener(self._btnpropOnClick, self)
	self._dragHandle:AddDragBeginListener(self._onDragBegin, self)
	self._dragHandle:AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.PlayUnitMove, self._onPlayUnitMove, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.PlayGhostShockBeforeMove, self._onPlayGhostShockBeforeMove, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.PlayUnitListMove, self._onPlayUnitListMove, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.OnGhostMoveEnd, self._onGhostMoveEnd, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.CatchGhosts, self._onCatchGhosts, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.OnGhostAddPropEffect, self._onGhostAddPropEffect, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.OnAddRound, self._onAddRound, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.OnUseProp, self._onUseProp, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.AddUnit, self._onAddUnit, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.RemoveUnit, self._onRemoveUnit, self)
	self.addEventCb(self, LamonaGameController.instance, LamonaEvent.RefreshGame, self._onRefreshGame, self)
end

function LamonaGameView:removeEvents()
	self._btnback:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnUp:RemoveClickListener()
	self._btnDown:RemoveClickListener()
	self._btnprop:RemoveClickListener()
	self._dragHandle:RemoveDragBeginListener()
	self._dragHandle:RemoveDragEndListener()
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.PlayUnitMove, self._onPlayUnitMove, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.PlayGhostShockBeforeMove, self._onPlayGhostShockBeforeMove, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.PlayUnitListMove, self._onPlayUnitListMove, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.OnGhostMoveEnd, self._onGhostMoveEnd, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.CatchGhosts, self._onCatchGhosts, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.OnGhostAddPropEffect, self._onGhostAddPropEffect, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.OnAddRound, self._onAddRound, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.OnUseProp, self._onUseProp, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.AddUnit, self._onAddUnit, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.RemoveUnit, self._onRemoveUnit, self)
	self.removeEventCb(self, LamonaGameController.instance, LamonaEvent.RefreshGame, self._onRefreshGame, self)
end

function LamonaGameView:_btnbackOnClick()
	LamonaGameController.instance:rollbackGame()
end

function LamonaGameView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Va3Act124ResetGame, MsgBoxEnum.BoxType.Yes_No, self._confirmReset, nil, nil, self)
end

function LamonaGameView:_confirmReset()
	LamonaStatHelper.instance:sendOperationInfo(LamonaStatHelper.OperationType.gameReset)
	LamonaGameController.instance:resetGame()
	self._animMask:Play("out", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_lusongshi_lmn_exit)
	TaskDispatcher.runDelay(self._playMaskIn, self, TimeUtil.OneSecond / 2)
end

function LamonaGameView:_playMaskIn()
	self._animMask:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_lusongshi_lmn_enter)
end

function LamonaGameView:_btnDirectionOnClick(direction)
	LamonaGameController.instance:playerMove(direction)
end

function LamonaGameView:_btnpropOnClick()
	LamonaGameController.instance:playerUseProp()
end

function LamonaGameView:_onDragBegin(param, pointerEventData)
	self._startPosition = pointerEventData.position
end

local DRAG_OFFSET = 10

function LamonaGameView:_onDragEnd(param, pointerEventData)
	if not self._startPosition then
		return
	end

	local direction
	local x = pointerEventData.position.x - self._startPosition.x
	local y = pointerEventData.position.y - self._startPosition.y
	local absX = math.abs(x)
	local absY = math.abs(y)

	if absY < absX then
		if x < -DRAG_OFFSET then
			direction = LamonaEnum.Direction.Left
		end

		if x > DRAG_OFFSET then
			direction = LamonaEnum.Direction.Right
		end
	else
		if y < -DRAG_OFFSET then
			direction = LamonaEnum.Direction.Down
		end

		if y > DRAG_OFFSET then
			direction = LamonaEnum.Direction.Up
		end
	end

	self:_btnDirectionOnClick(direction)

	self._startPosition = nil
end

function LamonaGameView:_onPlayUnitMove(uid, cb, cbObj)
	local unitItem = self:getUnitItem(uid)

	if not unitItem then
		return
	end

	unitItem:playMove(cb, cbObj)
end

function LamonaGameView:_onPlayGhostShockBeforeMove()
	local isGhostMoveTurn = LamonaGameModel.instance:getIsGhostMoveTurn()

	if not isGhostMoveTurn then
		return
	end

	local ghostMODict = LamonaGameModel.instance:getUnitDictByType(LamonaEnum.UnitType.Ghost) or {}

	for uid, mo in pairs(ghostMODict) do
		local isMoving = mo:getIsMoving()

		if isMoving then
			self:_setGhostEmoji(uid, LamonaEnum.GhostEmoji.Shocked, true, true)
			AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_lusongshi_lmn_move2)
		end
	end

	LamonaGameController.instance:beginGhostMove()
end

function LamonaGameView:_onPlayUnitListMove(uidList, cb, cbObj)
	if not uidList or #uidList <= 0 then
		return
	end

	self._allUnitMoveEndCb = cb
	self._allUnitMoveEndCbObj = cbObj
	self._allMoveUnitDict = {}

	for _, uid in pairs(uidList) do
		local unitItem = self:getUnitItem(uid)

		if unitItem then
			self._allMoveUnitDict[uid] = true

			unitItem:playMove(self._onOneUnitMoveEnd, self, uid)
		end
	end
end

function LamonaGameView:_onOneUnitMoveEnd(uid)
	local mo = LamonaGameModel.instance:getUnitByUid(uid)
	local isMoving = mo and mo:getIsMoving()

	if not isMoving then
		self:_onGhostMoveEnd(uid)
	end

	if self._allMoveUnitDict then
		self._allMoveUnitDict[uid] = nil
	end

	if not self._allMoveUnitDict or not next(self._allMoveUnitDict) then
		local cb = self._allUnitMoveEndCb
		local cbObj = self._allUnitMoveEndCbObj

		self._allUnitMoveEndCb = nil
		self._allUnitMoveEndCbObj = nil

		ArcadeGameHelper.callCallbackFunc(cb, cbObj)
	end
end

function LamonaGameView:_onGhostMoveEnd(ghostUid)
	local mo = LamonaGameModel.instance:getUnitByUid(ghostUid)

	if not mo then
		return
	end

	local gridX, gridY = mo:getGridXY()
	local ghostUidsInGrid = LamonaGameModel.instance:getUnitUidsInGrid(gridX, gridY, LamonaEnum.UnitType.Ghost)

	for _, uid in ipairs(ghostUidsInGrid) do
		local ghostMO = LamonaGameModel.instance:getUnitByUid(uid)
		local unitItem = self:getUnitItem(uid)

		if ghostMO and unitItem then
			local isMoving = ghostMO:getIsMoving()
			local isTweenMoving = unitItem:getIsTweenMoving()

			if not isMoving and not isTweenMoving then
				unitItem:refresh(true)
			end
		end
	end

	LamonaGameController.instance:dispatchEvent(LamonaEvent.GuideOnGhostMoveEnd, ghostUid)
end

function LamonaGameView:_onCatchGhosts(ghostList)
	if ghostList then
		for _, uid in ipairs(ghostList) do
			local unitItem = self:getUnitItem(uid)

			if unitItem then
				unitItem:refresh(true)
			else
				LamonaGameController.instance:removeUnit(uid)
			end
		end
	end

	self:refreshTarget()
end

function LamonaGameView:_onGhostAddPropEffect(ghostUid, propId)
	local unitItem = self:getUnitItem(ghostUid)

	if not unitItem then
		return
	end

	if propId == LamonaEnum.Const.FogPropId then
		self:_setGhostEmoji(ghostUid, LamonaEnum.GhostEmoji.Fog, true, true)
	elseif propId == LamonaEnum.Const.TrapPropId then
		unitItem:refresh(true)
	end
end

function LamonaGameView:_onAddRound()
	self:refreshRound()
	self:refreshBackBtn()
end

function LamonaGameView:_onUseProp()
	self:refreshProp()
end

function LamonaGameView:_onAddUnit(uid)
	self:addUnit(uid)
end

function LamonaGameView:_onRemoveUnit(uid)
	self:removeUnit(uid)
end

function LamonaGameView:_onRefreshGame()
	self:refresh()
end

function LamonaGameView:_editableInitView()
	self._type2UnitItemDict = {}
	self._uid2RangeGODict = self:getUserDataTb_()
	self._dragHandle = SLFramework.UGUI.UIDragListener.Get(self._gomap)
	self._animMask = gohelper.findChildComponent(self.viewGO, "node_mask", typeof(UnityEngine.Animator))
	self._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()

	if not self._isRunning then
		self._isRunning = true

		LateUpdateBeat:Add(self._onLateUpdate, self)
	end

	AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_lusongshi_lmn_enter)
end

function LamonaGameView:onUpdateParam()
	return
end

function LamonaGameView:onOpen()
	local gameId = LamonaGameModel.instance:getGameId()
	local propId = LamonaConfig.instance:getLamonaPropId(gameId)

	if not propId or propId == 0 then
		gohelper.setActive(self._btnprop, false)
	else
		local desc = LamonaConfig.instance:getLamonaUnitDesc(propId)

		self._txtpropdesc.text = desc or ""

		local icon = LamonaConfig.instance:getLamonaUnitIcon(propId)

		UISpriteSetMgr.instance:setV3a5LamonaSprite(self._imageproplight, icon, true)
		UISpriteSetMgr.instance:setV3a5LamonaSprite(self._imagepropdisable, icon, true)
		gohelper.setActive(self._btnprop, true)
	end

	local mapId = LamonaGameModel.instance:getMapId()
	local bg = LamonaConfig.instance:getLamonaMapBg(mapId)

	self._simageFullBG:LoadImage(ResUrl.getV3a5LamonaSingleBg(bg))
	self:initMapYLevel()
	self:refresh()
end

function LamonaGameView:initMapYLevel()
	local unitTypeList = LamonaConfig.instance:getLamonaUnitTypeListInOrder()

	self._yLevelDict = self:getUserDataTb_()

	local _, mapHeight = LamonaGameModel.instance:getMapSize()

	if not mapHeight then
		return
	end

	for y = mapHeight, 1, -1 do
		local yLevelItem = self:getUserDataTb_()
		local yGO = gohelper.create2d(self._gomap, y)

		yLevelItem.go = yGO
		yLevelItem.typeGODict = self:getUserDataTb_()

		for _, typeId in ipairs(unitTypeList) do
			yLevelItem.typeGODict[typeId] = gohelper.create2d(yGO, string.format("type-%s", typeId))
		end

		self._yLevelDict[y] = yLevelItem
	end
end

function LamonaGameView:getLevelGO(gridY, type)
	local levelGO

	if self._yLevelDict then
		if self._yLevelDict then
			levelGO = self._yLevelDict.typeGODict[type]

			if gohelper.isNil(self._yLevelDict.typeGODict[type]) then
				levelGO = self._yLevelDict.go
			end
		end

		if gohelper.isNil(levelGO) then
			logError(string.format("LamonaGameView:getLevelGO error, no go, y:%s type:%s", gridY, type))
		end

		return levelGO
	end
end

function LamonaGameView:_onLateUpdate()
	local inGuiding = LamonaHelper.checkInGuiding()

	if inGuiding then
		return
	end

	if not self._isMobilePlayer then
		local direction

		if Input.GetKeyDown(KeyCode.D) or Input.GetKeyDown(KeyCode.RightArrow) then
			direction = LamonaEnum.Direction.Right
		elseif Input.GetKeyDown(KeyCode.A) or Input.GetKeyDown(KeyCode.LeftArrow) then
			direction = LamonaEnum.Direction.Left
		elseif Input.GetKeyDown(KeyCode.W) or Input.GetKeyDown(KeyCode.UpArrow) then
			direction = LamonaEnum.Direction.Up
		elseif Input.GetKeyDown(KeyCode.S) or Input.GetKeyDown(KeyCode.DownArrow) then
			direction = LamonaEnum.Direction.Down
		end

		self:_btnDirectionOnClick(direction)
	end
end

function LamonaGameView:refresh()
	self:refreshTarget()
	self:refreshRound()
	self:refreshProp()
	self:refreshBackBtn()
	self:refreshAllUnit()
end

function LamonaGameView:refreshTarget()
	local gameId = LamonaGameModel.instance:getGameId()
	local targetDesc = LamonaConfig.instance:getLamonaTargetDesc(gameId)
	local caughtCount = LamonaGameModel.instance:getCaughtGhostCount()
	local targetCount = LamonaGameModel.instance:getTargetGhostCount()

	self._txttarget.text = GameUtil.getSubPlaceholderLuaLangTwoParam(targetDesc, caughtCount, targetCount)
end

function LamonaGameView:refreshRound()
	local round = LamonaGameModel.instance:getRound()
	local maxRound = LamonaConfig.instance:getLamonaConst(LamonaEnum.ConstId.MaxRound, false, true)
	local remainRound = math.max(0, maxRound - round)

	self._txtremainRound.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v3a5_lamona_remain_round"), remainRound)
end

function LamonaGameView:refreshProp()
	local propCount = LamonaGameModel.instance:getPropCount()
	local canUse = propCount > 0

	gohelper.setActive(self._goproplight, canUse)
	gohelper.setActive(self._gopropdisable, not canUse)

	self._txtprop.text = luaLang("multiple") .. tostring(propCount)

	if canUse then
		if not LightColor then
			local color = GrayColor

			SLFramework.UGUI.GuiHelper.SetColor(self._txtprop, color)
		end
	end
end

function LamonaGameView:refreshBackBtn()
	local canRollback = LamonaGameModel.instance:isHasSaveGameInfo()

	if canRollback then
		if not LightColor then
			local color = GrayColor

			SLFramework.UGUI.GuiHelper.SetColor(self._imgback, color)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtback, color)
		end
	end
end

function LamonaGameView:addUnit(uid)
	if not self._type2UnitItemDict then
		return
	end

	local mo = LamonaGameModel.instance:getUnitByUid(uid)

	if not mo then
		return
	end

	local unitType = mo:getType()
	local typeDict = GameUtil.tabletool_checkDictTable(self._type2UnitItemDict, unitType)

	if typeDict[uid] then
		return
	end

	local resPath = LamonaHelper.getUnitTypeResPath(unitType)

	if not resPath then
		return
	end

	local unitGo = self:getResInst(resPath, self._gomap, string.format("%s-%s", unitType, uid))

	if not unitGo then
		return
	end

	local unitItem = unitType == LamonaEnum.UnitType.Ghost and MonoHelper.addLuaComOnceToGo(unitGo, LamonaGhostUnit, {
		uid = uid,
		view = self
	}) or MonoHelper.addLuaComOnceToGo(unitGo, LamonaBaseUnit, {
		uid = uid,
		view = self
	})
	local id = mo:getId()
	local rangeUnitId = LamonaConfig.instance:getLamonaEffectRangeUnitId(id)
	local effectRange = mo:getAttrValue(LamonaEnum.UnitAttrKey.EffectRange)

	if effectRange > 0 and rangeUnitId and rangeUnitId ~= 0 then
		local x, y = mo:getGridXY()

		self:addEffectRangeGO(uid, rangeUnitId, x, y, effectRange)
	end

	typeDict[uid] = unitItem

	return unitItem
end

function LamonaGameView:addEffectRangeGO(linkedUid, id, x, y, range)
	if not self._uid2RangeGODict or not linkedUid then
		return
	end

	local type = LamonaConfig.instance:getLamonaUnitType(id)
	local resPath = LamonaHelper.getUnitTypeResPath(type)

	if not resPath then
		return
	end

	local mapWidth, mapHeight = LamonaGameModel.instance:getMapSize()

	for dx = -range, range do
		for dy = -range, range do
			if range >= math.abs(dx) + math.abs(dy) then
				local gridX = x + dx
				local gridY = y + dy
				local parentGO = self:_getRangeItemParentGO(type, gridX, gridY, mapWidth, mapHeight)

				if parentGO then
					self:_createRangeGO(type, linkedUid, gridX, gridY, mapWidth, parentGO, resPath)
				end
			end
		end
	end
end

function LamonaGameView:_getRangeItemParentGO(type, gridX, gridY, mapWidth, mapHeight)
	if LamonaHelper.isOutsizeMap(gridX, gridY, mapWidth, mapHeight) then
		return
	end

	if LamonaGameModel.instance:getHasUnityTypeInGrid(gridX, gridY, LamonaEnum.UnitType.Obstacle) then
		return
	end

	return (self:getLevelGO(gridY, type))
end

function LamonaGameView:_createRangeGO(type, linkedUid, gridX, gridY, mapWidth, yLevelGo, resPath)
	local gridId = LamonaHelper.getGridId(gridX, gridY, mapWidth)
	local dict = GameUtil.tabletool_checkDictTable(self._uid2RangeGODict, linkedUid)

	if dict[gridId] then
		return
	end

	local go = resPath and self:getResInst(resPath, yLevelGo, string.format("%s-%s", type, linkedUid))

	if go then
		dict[gridId] = go

		local x, y = LamonaHelper.getGridPos(gridX, gridY)

		transformhelper.setLocalPos(go.transform, x, y, 0)
	end
end

function LamonaGameView:removeUnit(uid)
	if not uid or not self._type2UnitItemDict then
		return
	end

	for _, dict in pairs(self._type2UnitItemDict) do
		local unitItem = dict[uid]

		if unitItem then
			unitItem:destroy()

			dict[uid] = nil
		end
	end

	self:removeEffectRangeGO(uid)
end

function LamonaGameView:removeEffectRangeGO(linkedUid)
	if not self._uid2RangeGODict then
		return
	end

	local dict = self._uid2RangeGODict[linkedUid]

	if dict then
		for gridId, go in pairs(dict) do
			gohelper.destroy(go)

			dict[gridId] = nil
		end
	end

	self._uid2RangeGODict[linkedUid] = nil
end

function LamonaGameView:getUnitItem(uid)
	if not self._type2UnitItemDict then
		return
	end

	local mo = LamonaGameModel.instance:getUnitByUid(uid)

	if not mo then
		return
	end

	local unitType = mo:getType()
	local typeDict = self._type2UnitItemDict[unitType]

	return typeDict and typeDict[uid]
end

function LamonaGameView:refreshAllUnit(unitType)
	if not self._type2UnitItemDict then
		return
	end

	local sourceDict = unitType and (LamonaGameModel.instance:getUnitDictByType(unitType) or {}) or LamonaGameModel.instance:getUnitDict() or {}

	for uid, _ in pairs(sourceDict) do
		local unitItem = self:getUnitItem(uid)

		if unitItem then
			if unitItem.stopAllAnim then
				unitItem:stopAllAnim()
			end

			unitItem:refresh()
		else
			self:addUnit(uid)
		end
	end

	if unitType then
		if not self._type2UnitItemDict[unitType] then
			for uid in pairs(self._type2UnitItemDict[unitType]) do
				if not sourceDict[uid] then
					self:removeUnit(uid)
				end
			end
		end
	else
		for _, itemDict in pairs(self._type2UnitItemDict) do
			for uid in pairs(itemDict) do
				if not sourceDict[uid] then
					self:removeUnit(uid)
				end
			end
		end
	end
end

function LamonaGameView:getUnitParentGO(uid)
	local mo = LamonaGameModel.instance:getUnitByUid(uid)

	if not mo then
		return
	end

	local _, gridY = mo:getGridXY()
	local type = mo:getType()

	return (self:getLevelGO(gridY, type))
end

function LamonaGameView:_setGhostEmoji(ghostUid, emojiName, isActive, isPlay)
	local unitItem = self:getUnitItem(ghostUid)

	if unitItem then
		unitItem:setEmojiActive(emojiName, isActive, isPlay)
	end
end

function LamonaGameView:onClose()
	self._allUnitMoveEndCb = nil
	self._allUnitMoveEndCbObj = nil

	TaskDispatcher.cancelTask(self._playMaskIn, self)

	if self._isRunning then
		self._isRunning = false

		LateUpdateBeat:Remove(self._onLateUpdate, self)
	end

	LamonaGameController.instance:exitGame()
	self._animMask:Play("out", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_lusongshi_lmn_exit)
end

function LamonaGameView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return LamonaGameView
