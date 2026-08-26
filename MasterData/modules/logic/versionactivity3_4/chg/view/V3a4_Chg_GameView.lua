-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameView.lua

local ti = table.insert

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameView", package.seeall)

local V3a4_Chg_GameView = class("V3a4_Chg_GameView", BaseView)

function V3a4_Chg_GameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Tips")
	self._goVictory = gohelper.findChild(self.viewGO, "Panel/Image_Role1/#go_Victory")
	self._goglobalDrag = gohelper.findChild(self.viewGO, "Panel/#go_globalDrag")
	self._goContainers = gohelper.findChild(self.viewGO, "Panel/#go_Containers")
	self._txtCount = gohelper.findChildText(self.viewGO, "Panel/Slider/#txt_Count")
	self._txtNum = gohelper.findChildText(self.viewGO, "Round/#txt_Num")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reset")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameView:addEvents()
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._bgClick:AddClickListener(self._onBgClick, self)
end

function V3a4_Chg_GameView:removeEvents()
	self._btnReset:RemoveClickListener()
	self._bgClick:RemoveClickListener()
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V3a4_Chg_GameView:ctor(...)
	V3a4_Chg_GameView.super.ctor(self, ...)

	self._drag = UIGlobalDragHelper.New()
	self._redIDleList = {}
	self._blueIdleList = {}
	self._usingUIFlyingList = {}
end

function V3a4_Chg_GameView:_btnResetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeResetGame, MsgBoxEnum.BoxType.Yes_No, self._restartYesCallback, nil, nil, self, nil, nil)
end

function V3a4_Chg_GameView:_restartYesCallback()
	self:doRestart()
	self.viewContainer:trackReset()
end

function V3a4_Chg_GameView:_restartDelayRefresh()
	self:_onNewRound()
end

function V3a4_Chg_GameView:_onResetAnimDone()
	self.viewContainer:endBlockSlient()
end

function V3a4_Chg_GameView:_dragContext()
	return self.viewContainer:dragContext()
end

function V3a4_Chg_GameView:getItemByKey(key)
	self._cacheItemDict = self._cacheItemDict or {}

	if self._cacheItemDict[key] then
		return self._cacheItemDict[key]
	end

	local res = self._verts:getItemByKey(key) or self._linesH:getItemByKey(key) or self._linesV:getItemByKey(key)

	self._cacheItemDict[key] = res

	return res
end

function V3a4_Chg_GameView:getObjByKey(key)
	return self.viewContainer:getObj(key)
end

function V3a4_Chg_GameView:getLineItemAPosByKey(key)
	self._cacheAPosDict = self._cacheAPosDict or {}

	if self._cacheAPosDict[key] then
		local v2 = self._cacheAPosDict[key]

		return v2.x, v2.y
	end

	local function _cache(ax, ay)
		self._cacheAPosDict[key] = {
			x = ax,
			y = ay
		}

		return ax, ay
	end

	local ax, ay = self._verts:getLineItemAPosByKey(key)

	if ax then
		return _cache(ax, ay)
	end

	ax, ay = self._linesH:getLineItemAPosByKey(key)

	if ax then
		return _cache(ax, ay)
	end

	return _cache(self._linesV:getLineItemAPosByKey(key))
end

function V3a4_Chg_GameView:distBetweenVertV2()
	return self._distBetweenVertV2
end

function V3a4_Chg_GameView:_editableInitView()
	self._Settings = gohelper.findChild(self.viewGO, "###__Settings__###")
	self._Line_HorizontalGo = gohelper.findChild(self.viewGO, "Panel/Line_Horizontal")
	self._Line_VerticalGo = gohelper.findChild(self.viewGO, "Panel/Line_Vertical")
	self._Line_HorizontalTrans = self._Line_HorizontalGo.transform
	self._Line_VerticalTrans = self._Line_VerticalGo.transform
	self._Line_HorizontalLayoutCmp = self._Line_HorizontalGo:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self._Line_VerticalGoLayoutCmp = self._Line_VerticalGo:GetComponent(gohelper.Type_VerticalLayoutGroup)
	self._transList_Line_Horizontal = self:getUserDataTb_()
	self._transList_Line_Vertical = self:getUserDataTb_()

	local function _findLineChildsImpl(refList, tr)
		local childCount = tr.childCount

		for i = 0, childCount - 1 do
			local childTr = tr:GetChild(i)

			ti(refList, childTr)
		end
	end

	_findLineChildsImpl(self._transList_Line_Horizontal, self._Line_HorizontalTrans)
	_findLineChildsImpl(self._transList_Line_Vertical, self._Line_VerticalTrans)

	self._verts = self:_create_V3a4_Chg_GameView_VertItemList(gohelper.findChild(self._goContainers, "Verts"))
	self._linesH = self:_create_V3a4_Chg_GameView_HLineItemList(gohelper.findChild(self._goContainers, "LinesH"))
	self._linesV = self:_create_V3a4_Chg_GameView_VLineItemList(gohelper.findChild(self._goContainers, "LinesV"))
	self._Line_itemGo = gohelper.findChild(self.viewGO, "Panel/Line_item")

	gohelper.setActive(self._Line_itemGo, false)

	self._lineSegmentList = self:_create_V3a4_Chg_GameView_LineSegmentList(gohelper.findChild(self._goContainers, "LineSegments"))
	self._Image_SliderFG = gohelper.findChildImage(self.viewGO, "Panel/Slider/Image_SliderFG")
	self._Image_SliderFGTran = self._Image_SliderFG.transform
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_Tips/txt_Tips")
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._fight_myslfGo = gohelper.findChild(self.viewGO, "fight_myslf")
	self._fight_enemyGo = gohelper.findChild(self.viewGO, "fight_enemy")
	self._Image_Role2 = gohelper.findChildImage(self.viewGO, "Panel/Image_Role2")

	self._drag:create(self._goglobalDrag)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDrag, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)

	self._goBgClick = gohelper.findChild(self.viewGO, "#go_BgClick")
	self._bgClick = gohelper.getClick(self._goBgClick)

	self:setActive_goBgClick(false)
end

function V3a4_Chg_GameView:_onBgClick()
	self:doRestart(false, true)
end

function V3a4_Chg_GameView:onOpen()
	local spriteName = self.viewContainer:v3a4_spriteName()

	if not string.nilorempty(spriteName) then
		self.viewContainer:setSprite(self._Image_Role2, spriteName, true)
	end

	self:_onNewRound()
	self:setText_txtTips(self.viewContainer:gameStartDesc())
	self.viewContainer:trackMO():onGameStart()
end

function V3a4_Chg_GameView:onClose()
	self:recycleAllUIFlying()
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")
	GameUtil.onDestroyViewMember(self, "_drag")
	self:_dragContext():_critical_beforeClear()
end

function V3a4_Chg_GameView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_redIDleList")
	GameUtil.onDestroyViewMemberList(self, "_blueIdleList")
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")
	GameUtil.onDestroyViewMember(self, "_drag")
	GameUtil.onDestroyViewMemberList(self, "_verts")
	GameUtil.onDestroyViewMemberList(self, "_linesH")
	GameUtil.onDestroyViewMemberList(self, "_linesV")
	GameUtil.onDestroyViewMemberList(self, "_lineSegmentList")
end

function V3a4_Chg_GameView:_onDragBegin(...)
	self:_dragContext():onDragBegin(...)
end

function V3a4_Chg_GameView:_onDrag(...)
	self:_dragContext():onDrag(...)
end

function V3a4_Chg_GameView:_onDragEnd(...)
	self:_dragContext():onDragEnd(...)
end

function V3a4_Chg_GameView:_refreshMap()
	local row, col = self.viewContainer:vertexRowCol()

	for i, tr in ipairs(self._transList_Line_Horizontal) do
		gohelper.setActive(tr.gameObject, i <= col)
	end

	for i, tr in ipairs(self._transList_Line_Vertical) do
		gohelper.setActive(tr.gameObject, i <= row)
	end

	local cx, _, _ = transformhelper.getLocalPos(self._Line_HorizontalTrans)
	local _, cy, _ = transformhelper.getLocalPos(self._Line_VerticalTrans)

	self._verts:setLocalPosXY(cx, cy)
	self._linesH:setLocalPosXY(cx, cy)
	self._linesV:setLocalPosXY(cx, cy)
	self._verts:setCol(col)
	self._linesH:setCol(col - 1)
	self._linesV:setCol(col)

	local gridSpacingX = self._Line_HorizontalLayoutCmp.spacing
	local gridSpadingY = self._Line_VerticalGoLayoutCmp.spacing

	self._verts:setSpacing(gridSpacingX, gridSpadingY)
	self._linesH:setSpacing(gridSpacingX, gridSpadingY)
	self._linesV:setSpacing(gridSpacingX, gridSpadingY)

	local mapW, mapH = self.viewContainer:mapSize()
	local cellSize = self._verts:cellSize()
	local lineThickness = cellSize.x
	local containerWidth = lineThickness + (gridSpacingX + lineThickness) * mapW
	local containerHeight = lineThickness + (gridSpadingY + lineThickness) * mapH
	local marginX = cellSize.x * 0.5
	local marginY = cellSize.y * 0.5
	local displayW = containerWidth + marginX
	local displayH = containerHeight + marginY

	self._verts:setWH(displayW, displayH)
	self._linesH:setWH(displayW, displayH)
	self._linesV:setWH(displayW, displayH)

	self._distBetweenVertV2 = {
		x = gridSpacingX + lineThickness,
		y = gridSpadingY + lineThickness
	}

	self._linesH:setPadding((gridSpacingX + marginX) * 0.5, 0, 0, 0)
	self._linesV:setPadding(0, 0, (gridSpadingY + marginY) * 0.5, 0)
end

function V3a4_Chg_GameView:_clearCache()
	self._cacheAPosDict = {}
	self._cacheItemDict = {}
end

function V3a4_Chg_GameView:_onNewRound()
	self:setActive_goVictory(false)
	self:_dragContext():reset(self)
	self.viewContainer:trackMO():onRoundStart()
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")

	self._newRoundStartFlow = ChgNewRoundStartFlow.New()

	self._newRoundStartFlow:start(self:_dragContext())
end

function V3a4_Chg_GameView:_onEndRound()
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")

	self._newRoundEndFlow = ChgNewRoundEndFlow.New()

	self._newRoundEndFlow:start(self:_dragContext())
end

function V3a4_Chg_GameView:_refreshItems()
	self._verts:_refresh()
	self._linesH:_refresh()
	self._linesV:_refresh()
end

function V3a4_Chg_GameView:_create_V3a4_Chg_GameView_HLineItemList(go)
	local item = V3a4_Chg_GameView_HLineItemList.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:init(go)

	return item
end

function V3a4_Chg_GameView:_create_V3a4_Chg_GameView_VLineItemList(go)
	local item = V3a4_Chg_GameView_VLineItemList.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:init(go)

	return item
end

function V3a4_Chg_GameView:_create_V3a4_Chg_GameView_VertItemList(go)
	local item = V3a4_Chg_GameView_VertItemList.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:init(go)

	return item
end

function V3a4_Chg_GameView:_create_V3a4_Chg_GameView_LineSegmentList(go)
	local item = V3a4_Chg_GameView_LineSegmentList.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:init(go)

	return item
end

function V3a4_Chg_GameView:_create_V3a4_Chg_UIFlying(bRed)
	if bRed then
		if not self._fight_myslfGo then
			local go = self._fight_enemyGo
			local item = V3a4_Chg_UIFlying.New({
				parent = self,
				baseViewContainer = self.viewContainer,
				bRed = bRed
			})

			item:init(gohelper.cloneInPlace(go))
			item:onUpdateMO(bRed)

			return item
		end
	end
end

function V3a4_Chg_GameView:getOrCreateUIFlying(bRed)
	local item = #self._redIDleList > 0 and table.remove(self._redIDleList) or self:_create_V3a4_Chg_UIFlying(bRed)

	table.insert(self._usingUIFlyingList, item)

	return item
end

function V3a4_Chg_GameView:recycleAllUIFlying()
	for _, item in ipairs(self._usingUIFlyingList) do
		item:clear()

		local bRed = item._mo

		if bRed then
			table.insert(self._redIDleList, item)
		else
			table.insert(self._blueIdleList, item)
		end
	end

	self._usingUIFlyingList = {}
end

function V3a4_Chg_GameView:_simpleTweenFillAmount(imageCmp, toFillAmount)
	local kTimeSec = 1
	local value01 = GameUtil.saturate(toFillAmount)

	ZProj.TweenHelper.KillByObj(imageCmp)
	ZProj.TweenHelper.DOFillAmount(imageCmp, value01, kTimeSec, nil, nil, nil, EaseType.Linear)
end

function V3a4_Chg_GameView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a4_Chg_GameView:_playAnim_reset(cb, cbObj)
	self:_playAnim(UIAnimationName.Reset, cb, cbObj)
end

function V3a4_Chg_GameView:Line_itemGo()
	return self._Line_itemGo
end

function V3a4_Chg_GameView:setText_txtCount(num)
	self._txtCount.text = string.format(luaLang("V3a4_Chg_GameView_txtCount"), num)
end

function V3a4_Chg_GameView:setText_txtNum(tmp)
	self._txtNum.text = tmp
end

function V3a4_Chg_GameView:setText_txtTips(tmp)
	self._txtTips.text = tmp
end

function V3a4_Chg_GameView:setActive_goVictory(isActive)
	gohelper.setActive(self._goVictory, isActive)

	if isActive then
		AudioMgr.instance:trigger(AudioEnum3_4.Chg.play_ui_bulaochun_cheng_success)
	end
end

function V3a4_Chg_GameView:completeRound()
	self:_onEndRound()
end

function V3a4_Chg_GameView:doRestart(bToGameStart, bToNewRound)
	self:setActive_goBgClick(false)
	GameUtil.onDestroyViewMember(self, "_newRoundEndFlow")
	GameUtil.onDestroyViewMember(self, "_newRoundStartFlow")
	self.viewContainer:startBlockSlient()
	self:_dragContext():_critical_beforeClear()

	if bToGameStart then
		self.viewContainer:restart()
	else
		self.viewContainer:restartRound(bToNewRound)
	end

	TaskDispatcher.cancelTask(self._restartDelayRefresh, self)
	TaskDispatcher.runDelay(self._restartDelayRefresh, self, 0.33)
	self._playAnim_reset(self, self._onResetAnimDone, self)
end

function V3a4_Chg_GameView:setActive_goBgClick(isActive)
	gohelper.setActive(self._goBgClick, isActive)
end

return V3a4_Chg_GameView
