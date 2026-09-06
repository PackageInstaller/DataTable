-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightMainView.lua

module("logic.extensions.holylight.view.HolyLightMainView", package.seeall)

local HolyLightMainView = class("HolyLightMainView", ViewComponent)

HolyLightMainView.LayerName = {
	Top = 3,
	Middle = 2,
	Bottom = 1,
	TopMost = 4
}

function HolyLightMainView:buildUI()
	HolyLightMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "uiTopCol/leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "uiTopCol/leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "uiTopCol/leftTop/txtTitle")
	self._uiBottomCol = goutil.findChild(self.mainGO, "uiBottomCol")
	self._uiMiddleCol = goutil.findChild(self.mainGO, "uiMiddleCol")
	self._uiTopCol = goutil.findChild(self.mainGO, "uiTopCol")
	self._mapScrollview = {}

	local mainGo = goutil.findChild(self.mainGO, "uiBottomCol/mapScrollview")

	self._mapScrollview._mainGo = mainGo
	self._mapScrollview._viewport = goutil.findChild(mainGo, "Viewport")
	self._mapScrollview._content = goutil.findChild(mainGo, "Viewport/Content")
	self._mapScrollview._bgCol = goutil.findChild(mainGo, "Viewport/Content/bgCol")
	self._mapScrollview._bgCell1 = {}
	self._mapScrollview._bgCell1._mainGo = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell1")
	self._mapScrollview._bgCell1._bgView = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell1/bgView")
	self._mapScrollview._bgCell1._bgEffRoot = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell1/bgEffRoot")
	self._mapScrollview._bgCell2 = {}
	self._mapScrollview._bgCell2._mainGo = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell2")
	self._mapScrollview._bgCell2._bgView = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell2/bgView")
	self._mapScrollview._bgCell2._bgEffRoot = goutil.findChild(mainGo, "Viewport/Content/bgCol/bgCell2/bgEffRoot")
	self._mapScrollview._darkMask = goutil.findChild(mainGo, "Viewport/Content/darkMask")
	self._playerCellGo = goutil.findChild(self._mapScrollview._content, "playerCell")
	self._gridCol = {}

	local mainGo = goutil.findChild(self._mapScrollview._content, "gridCol")

	self._gridCol._mainGo = mainGo
	self._gridCol._view = goutil.findChild(mainGo, "view")
	self._gridCol._cell = goutil.findChild(mainGo, "cell")
	self._masterCol = {}

	local mainGo = goutil.findChild(self._mapScrollview._content, "masterCol")

	self._masterCol._mainGo = mainGo
	self._masterCol._view = goutil.findChild(mainGo, "view")
	self._masterCol._cell = goutil.findChild(mainGo, "cell")
	self._effView = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/effView")

	self._effView._mainGo = mainGo
	self._effView._buffEffRoot = goutil.findChild(mainGo, "buffEffRoot")
	self._effView._buffEffPool = {}
	self._switchCol = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/switchCol")

	self._switchCol._mainGo = mainGo
	self._switchCol._btnLight = goutil.findChild(mainGo, "btnLight")
	self._switchCol._btnDark = goutil.findChild(mainGo, "btnDark")
	self._switchCol._btnSwitch = {}
	self._switchCol._btnSwitch._mainGo = goutil.findChild(mainGo, "btnSwitch")
	self._switchCol._btnSwitch._btn = goutil.findChild(mainGo, "btnSwitch/btn")
	self._lightCol = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/lightCol")

	self._lightCol._mainGo = mainGo
	self._lightCol._btnBuff = {}
	self._lightCol._btnBuff._mainGo = goutil.findChild(mainGo, "btnBuff")
	self._lightCol._btnBuff._flashEffPool = {}
	self._lightCol._btnFunc = {}
	self._lightCol._btnFunc._mainGo = goutil.findChild(mainGo, "btnFunc")
	self._lightCol._btnFunc._btn = goutil.findChild(mainGo, "btnFunc/btn")
	self._lightCol._btnFunc._redpoint = goutil.findChild(mainGo, "btnFunc/btn/redpoint")
	self._lightCol._btnFunc._txtDesc = goutil.findChildTextComponent(mainGo, "btnFunc/desc/txt")
	self._lightCol._btnUniversalDice = {}
	self._lightCol._btnUniversalDice._mainGo = goutil.findChild(mainGo, "btnUniversalDice")
	self._lightCol._btnUniversalDice._btn = goutil.findChild(mainGo, "btnUniversalDice/btn")
	self._lightCol._btnUniversalDice._redpoint = goutil.findChild(mainGo, "btnUniversalDice/btn/redpoint")
	self._lightCol._btnUniversalDice._txtDesc = goutil.findChildTextComponent(mainGo, "btnUniversalDice/desc/txt")
	self._lightCol._btnNormalDice = {}
	self._lightCol._btnNormalDice._mainGo = goutil.findChild(mainGo, "btnNormalDice")
	self._lightCol._btnNormalDice._btn = goutil.findChild(mainGo, "btnNormalDice/btn")
	self._lightCol._btnNormalDice._icon = goutil.findChild(mainGo, "btnNormalDice/btn/icon")
	self._lightCol._btnNormalDice._redpoint = goutil.findChild(mainGo, "btnNormalDice/btn/redpoint")
	self._lightCol._btnNormalDice._txtDesc = goutil.findChildTextComponent(mainGo, "btnNormalDice/desc/txt")
	self._lightCol._btnNormalDice._descIcon = goutil.findChild(mainGo, "btnNormalDice/desc/txt/icon")
	self._lightCol._btnSwitchNormalDice = goutil.findChild(mainGo, "btnSwitchNormalDice")
	self._lightCol._doubleResTips = {}
	self._lightCol._doubleResTips._mainGo = goutil.findChild(mainGo, "doubleResTips")
	self._lightCol._doubleResTips._txt = goutil.findChildTextComponent(mainGo, "doubleResTips/txt")
	self._lightCol._btnDiceAnim = {}
	self._lightCol._btnDiceAnim._mainGo = goutil.findChild(mainGo, "btnDiceAnim")
	self._lightCol._btnDiceAnim._toggle = goutil.findChild(mainGo, "btnDiceAnim/Toggle")
	self._darkCol = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/darkCol")

	self._darkCol._mainGo = mainGo
	self._darkCol._btnReward = goutil.findChild(mainGo, "btnReward")
	self._darkCol._btnShop = {}
	self._darkCol._btnShop._mainGo = goutil.findChild(mainGo, "btnShop")
	self._darkCol._btnShop._redPoint = goutil.findChild(mainGo, "btnShop/redPoint")
	self._darkCol._btnExploration = {}
	self._darkCol._btnExploration._mainGo = goutil.findChild(mainGo, "btnExploration")
	self._darkCol._btnExploration._btn = goutil.findChild(mainGo, "btnExploration/btn")
	self._darkCol._btnExploration._txtDesc = goutil.findChildTextComponent(mainGo, "btnExploration/txtDesc")
	self._commonCol = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/commonCol")

	self._commonCol._btnTask = {}
	self._commonCol._btnTask._mainGo = goutil.findChild(mainGo, "btnTask")
	self._commonCol._btnTask._redPoint = goutil.findChild(mainGo, "btnTask/redPoint")
	self._commonCol._btnPassport = {}
	self._commonCol._btnPassport._mainGo = goutil.findChild(mainGo, "btnPassport")
	self._commonCol._btnPassport._redPoint = goutil.findChild(mainGo, "btnPassport/redPoint")
	self._commonCol._btnRank = {}
	self._commonCol._btnRank._mainGo = goutil.findChild(mainGo, "btnRank")
	self._commonCol._btnRank._redPoint = goutil.findChild(mainGo, "btnRank/redPoint")
	self._diceCol = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/diceCol")

	self._diceCol._mainGo = mainGo
	self._diceCol._diceHandlerList = {}

	for idx = 1, mainGo.transform.childCount do
		local diceView = goutil.findChild(mainGo, string.format("diceView_%s", idx))
		local diceHandler = TRDiceHandler.New()

		diceHandler:initFromGo(diceView, 3)

		self._diceCol._diceHandlerList[idx] = diceHandler
	end

	self._clickMask = goutil.findChild(self.mainGO, "uiTopCol/clickMask")
	self._goldBarCon = goutil.findChild(self.mainGO, "uiTopCol/goldBarCon")
	self._screenEffRoot = goutil.findChild(self.mainGO, "uiMiddleCol/screenEffRoot")
	self._testCol = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/testCol")

	self._testCol._mainGo = goutil.findChild(mainGo, "testCol")
	self._testCol._btnMoveReStart = goutil.findChild(mainGo, "btnMoveReStart")
	self._testCol._txtBtnMoveReStart = goutil.findChildTextComponent(mainGo, "btnMoveReStart/txt")
	self._testCol._btnMoveContinue = goutil.findChild(mainGo, "btnMoveContinue")
	self._testCol._btnMovePause = goutil.findChild(mainGo, "btnMovePause")
	self._testCol._btnRandomLook = goutil.findChild(mainGo, "btnRandomLook")
	self._testCol._btnFollowLook = goutil.findChild(mainGo, "btnFollowLook")
	self._testCol._btnFollowLookStop = goutil.findChild(mainGo, "btnFollowLookStop")
	self._testCol._txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
end

function HolyLightMainView:bindEvents()
	HolyLightMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._switchCol._btnLight, self._onClickBtnLightOfSwitch, self)
	GameUtil.addClickHandler(self._switchCol._btnDark, self._onClickBtnDarkOfSwitch, self)
	GameUtil.addClickHandler(self._switchCol._btnSwitch._btn, self._onClickBtnSwitchOfSwitch, self)
	GameUtil.addClickHandler(self._commonCol._btnTask._mainGo, self._onClickBtnTaskOfLight, self)
	GameUtil.addClickHandler(self._commonCol._btnPassport._mainGo, self._onClickBtnPassportOfLight, self)
	GameUtil.addClickHandler(self._commonCol._btnRank._mainGo, self._onClickBtnRankOfLight, self)
	GameUtil.addClickHandler(self._lightCol._btnBuff._mainGo, self._onClickBtnBuffOfLight, self)
	GameUtil.addClickHandler(self._lightCol._btnFunc._btn, self._onClickBtnFuncOfLight, self)
	GameUtil.addClickHandler(self._lightCol._btnUniversalDice._btn, self._onClickBtnUniversalDiceOfLight, self)
	GameUtil.addClickHandler(self._lightCol._btnNormalDice._btn, self._onClickBtnNormalDiceOfLight, self)
	GameUtil.addClickHandler(self._lightCol._btnSwitchNormalDice, self._onClickBtnSwitchNormalDiceOfLight, self)
	GameUtil.addClickHandler(self._lightCol._btnDiceAnim._mainGo, self._onClickBtnDiceAnim, self)
	GameUtil.addClickHandler(self._darkCol._btnReward, self._onClickBtnRewardOfDark, self)
	GameUtil.addClickHandler(self._darkCol._btnShop._mainGo, self._onClickBtnShopOfDark, self)
	GameUtil.addClickHandler(self._darkCol._btnExploration._btn, self._onClickBtnExplorationOfDark, self)
	GameUtil.addClickHandler(self._testCol._btnMoveReStart, self._onClickBtnMoveReStartOfTest, self)
	GameUtil.addClickHandler(self._testCol._btnMoveContinue, self._onClickBtnMoveContinueOfTest, self)
	GameUtil.addClickHandler(self._testCol._btnMovePause, self._onClickBtnMovePauseOfTest, self)
	GameUtil.addClickHandler(self._testCol._btnRandomLook, self._onClickBtnRandomLookOfTest, self)
	GameUtil.addClickHandler(self._testCol._btnFollowLook, self._onClickBtnFollowLookOfTest, self)
	GameUtil.addClickHandler(self._testCol._btnFollowLookStop, self._onClickBtnFollowLookStopOfTest, self)
end

function HolyLightMainView:unbindEvents()
	HolyLightMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._switchCol._btnLight)
	GameUtil.rmClickHandler(self._switchCol._btnDark)
	GameUtil.rmClickHandler(self._switchCol._btnSwitch._btn)
	GameUtil.rmClickHandler(self._commonCol._btnTask._mainGo)
	GameUtil.rmClickHandler(self._commonCol._btnPassport._mainGo)
	GameUtil.rmClickHandler(self._commonCol._btnRank._mainGo)
	GameUtil.rmClickHandler(self._lightCol._btnBuff._mainGo)
	GameUtil.rmClickHandler(self._lightCol._btnFunc._btn)
	GameUtil.rmClickHandler(self._lightCol._btnUniversalDice._btn)
	GameUtil.rmClickHandler(self._lightCol._btnNormalDice._btn)
	GameUtil.rmClickHandler(self._lightCol._btnSwitchNormalDice)
	GameUtil.rmClickHandler(self._lightCol._btnDiceAnim._mainGo)
	GameUtil.rmClickHandler(self._darkCol._btnReward)
	GameUtil.rmClickHandler(self._darkCol._btnShop._mainGo)
	GameUtil.rmClickHandler(self._darkCol._btnExploration._btn)
	GameUtil.rmClickHandler(self._testCol._btnMoveReStart)
	GameUtil.rmClickHandler(self._testCol._btnMoveContinue)
	GameUtil.rmClickHandler(self._testCol._btnMovePause)
	GameUtil.rmClickHandler(self._testCol._btnRandomLook)
	GameUtil.rmClickHandler(self._testCol._btnFollowLook)
	GameUtil.rmClickHandler(self._testCol._btnFollowLookStop)
end

function HolyLightMainView:onEnter()
	HolyLightMainView.super.onEnter(self)

	self._activityId = HolyLightController.instance:getActivityId()
	self._activityType = HolyLightController.instance:getActivityType()

	if self._activityId <= 0 then
		TipsFacade.instance:openTipWindowNoX("提示", "不在活动范围内", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._holyLightMgr = HolyLightController.instance:getHolyLightMgr(self._activityId)

	if self._hLPlayerMgr == nil then
		self._hLPlayerMgr = HLPlayerMgr.New()
	end

	local mapScrollerRect = self._mapScrollview._mainGo:GetComponent(ComponentType.ScrollRect)
	local bgViewRect = self._mapScrollview._bgCell1._bgView:GetComponent(goutil.Type_RectTransform)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(bgViewRect)

	local mapScrollerSize = {
		x = bgViewRect.sizeDelta.x,
		y = bgViewRect.sizeDelta.y
	}

	self._hLPlayerMgr:onEnter(self, mapScrollerRect, mapScrollerSize, self._playerCellGo)
	self:_blockClick(false)
	self:_switchWorldStateOfNoAnim(self._holyLightMgr:getCurWorldState())
	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.HolyLightGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyLightUniversalDiceSure, self._handleUniversalDiceSure, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyLightDiceSelectSure, self._handleDiceSelectSure, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyLightGoRes, self._handleGoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_EventTaskTabUpdate, self._onUpdate, self)
	self:_onUpdate()
	self:_sendInfoReq()
end

function HolyLightMainView:onExit()
	HolyLightMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightUniversalDiceSure, self._handleUniversalDiceSure, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightDiceSelectSure, self._handleDiceSelectSure, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightGoRes, self._handleGoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_EventTaskTabUpdate, self._onUpdate, self)

	if self._hLPlayerMgr then
		self._hLPlayerMgr:onExit()
	end

	self:_clearDice()
	self:_clearEventQueue()
	self:_clearAllFlyBuffAnim()
	self:_onClearGridCol()
	self:_onClearMasterCol()
	self:_clearPathMoveMachine()
	self:_cledarBgEff()
	self:_clearAllMeetBuffEff()
	MaterialMgr.resetAll(self._lightCol._btnNormalDice._descIcon)
end

function HolyLightMainView:destroyUI()
	HolyLightMainView.super.destroyUI(self)
	self:_destoryAllMasterSpine()

	self._hLPlayerMgr = nil
end

function HolyLightMainView:_sendInfoReq()
	HolyLightController.instance:sendPM_HolyLightGetInfoReq(self._activityId)
end

function HolyLightMainView:_handleDiceSelectSure(typeId)
	self:_onUpdatePlaneUI()
end

function HolyLightMainView:_handleGoRes(status, msg)
	self:_onUpdate()

	if status ~= 0 then
		self:_blockClick(false)

		return
	end

	local item = msg.item
	local gridStep = msg.step
	local deceId = msg.deceId

	self._changeSetIdOfGoRes = msg.changeSetId

	local formGridId = self._holyLightMgr:getCurGridId()

	self._holyLightMgr:addGridStep(gridStep)

	local gridIdList = self._holyLightMgr:getGridIdListOfForwardStep(formGridId, gridStep)
	local stepCoinNum = HolyLightConfig.instance:getHlCommonValue("SYS_PET_STEP_TO_COIN", true)

	stepCoinNum = stepCoinNum * gridStep

	local valueList = {}
	local typeList = {}
	local handlerIdxList = {}

	local function _autoHideSelfCallback()
		self:_popStepCoin(stepCoinNum)
		self:_playPathMoveMachine(gridIdList)
	end

	if item == HolyLightMgr.GoItem.NormalDice then
		local diceData = HolyLightConfig.instance:getHlDiceData(self._activityId, deceId)

		table.insert(valueList, (diceData or nil) and table.indexof(diceData.randList, gridStep))
		table.insert(typeList, deceId)
		table.insert(handlerIdxList, 2)
	elseif item == HolyLightMgr.GoItem.UniversalDice then
		local value = gridStep

		table.insert(valueList, value)
		table.insert(typeList, 1)
		table.insert(handlerIdxList, 2)
	elseif item == HolyLightMgr.GoItem.FuncCard then
		for idx, v in ipairs(msg.cardRes) do
			local diceData = HolyLightConfig.instance:getHlDiceData(self._activityId, deceId)

			table.insert(valueList, (diceData or nil) and table.indexof(diceData.randList, v))
			table.insert(typeList, deceId)
			table.insert(handlerIdxList, idx)
		end
	end

	self:_onPlayDice(valueList, typeList, handlerIdxList, _autoHideSelfCallback)
end

function HolyLightMainView:_onSetUI()
	local value = HolyLightConfig.instance:getHlCommonValue("MAIN_VIEW_GOLD_COINS")

	if not string.nilorempty(value) then
		local itemStrList = string.split(value, "#")
		local list = {}

		for _, itemStr in ipairs(itemStrList) do
			local tab = {
				id = itemStr
			}

			table.insert(list, tab)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	self:_loadBgEff()
	self:_regRedIdByKeys(self._commonCol._btnTask._redPoint, {
		"TASK_RED_ID"
	})
	self:_regRedIdByKeys(self._commonCol._btnPassport._redPoint, {
		"PASSPORT_RED_ID"
	})
	RedPointController.instance:regRedPoint(self._darkCol._btnShop._redPoint, RedPointModel.ID_HOLYLIGHT_PET_SHOP_REFRESH_TIMES)
end

function HolyLightMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyLightMainView:_onUpdateData()
	return
end

function HolyLightMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateGridColUI()
	self:_onUpdateMasterColUI()
	self:_onUpdateTestCol()
	self:_onUpdateBtnDiceAnimToggle()
end

function HolyLightMainView:_onUpdatePlaneUI()
	local wordldState = self._holyLightMgr:getCurWorldState()

	if wordldState == HolyLightMgr.WorldState.Light then
		-- block empty
	elseif wordldState == HolyLightMgr.WorldState.Dark then
		-- block empty
	end

	local num = self._holyLightMgr:getNormalDiceNum()

	self._lightCol._btnNormalDice._txtDesc.text = string.format("%s", num)

	local normalDieceId = self._holyLightMgr:getNormalDieceId()

	GameUtil.setUIImageSpriteIdx(self._lightCol._btnNormalDice._icon, normalDieceId - 1)

	local str = HolyLightConfig.instance:getHlCommonValue("DICE")
	local matType, matId, matNum = MaterialMgr.getMatParams(str)

	MaterialMgr.setIcon(self._lightCol._btnNormalDice._descIcon, matType, matId, nil, nil)

	local isNeedRed = self._holyLightMgr:isNeedRedOfNormalDice()

	GameUtil.SetActive(self._lightCol._btnNormalDice._redpoint, isNeedRed)

	local num = self._holyLightMgr:getUniversalDiceNum()

	self._lightCol._btnUniversalDice._txtDesc.text = string.format("数量：%s", num)

	local isNeedRed = self._holyLightMgr:isNeedRedOfUniversalDice()

	GameUtil.SetActive(self._lightCol._btnUniversalDice._redpoint, isNeedRed)

	local num = self._holyLightMgr:getFuncCardNum()

	self._lightCol._btnFunc._txtDesc.text = string.format("数量：%s", num)

	local isNeedRed = self._holyLightMgr:isNeedRedOfFuncCard()

	GameUtil.SetActive(self._lightCol._btnFunc._redpoint, isNeedRed)
	self:_updateDoubleTips(0)

	local num = self._holyLightMgr:getCreepsTimes()

	self._darkCol._btnExploration._txtDesc.text = string.format("当前索敌：%s次", num)
end

function HolyLightMainView:_resetPlayerToCurGrid()
	local curGridId = self._holyLightMgr:getCurGridId()
	local curGridPos = self:_getGridCellLocalPos(curGridId)
	local gridList = self._holyLightMgr:getGridIdListOfForwardStep(curGridId, 1)
	local nextGridId = gridList[1]
	local nextGridPos = self:_getGridCellLocalPos(nextGridId)

	self._hLPlayerMgr:setPlayerLocalPos(curGridPos)
	self._hLPlayerMgr:setToward(nextGridPos)
	self._hLPlayerMgr._scrollerViewCtrl:viewTo(self._hLPlayerMgr:getPlayerLocalPos())
end

function HolyLightMainView:_playEffect(effParent, pathName, layer)
	UIEffectManager.instance:stopEffect(self._bgEffList[effParent])

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true

			self:_setGoSortingOrder(eff.effGo.gameObject, layer)
		end

		local handlerTarget

		self._bgEffList[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function HolyLightMainView:_loadBgEff()
	if self._bgEffList == nil then
		self._bgEffList = {}
	end

	local effParent = self._mapScrollview._bgCell1._bgEffRoot
	local pathName = ""

	self:_playEffect(effParent, pathName, HolyLightMainView.LayerName.Bottom)

	local effParent = self._mapScrollview._bgCell2._bgEffRoot
	local pathName = ""

	self:_playEffect(effParent, pathName, HolyLightMainView.LayerName.Bottom)

	local effParent = self._screenEffRoot
	local pathName = "20230331/shengguangzhaoyao/fx_ui_changjing_3_sgzy"

	self:_playEffect(effParent, pathName, HolyLightMainView.LayerName.Middle)
end

function HolyLightMainView:_cledarBgEff()
	if self._bgEffList == nil then
		return
	end

	for _, eff in pairs(self._bgEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	table.clear(self._bgEffList)

	self._bgEffList = nil
end

function HolyLightMainView:_regRedIdByKeys(redGo, keyList)
	local redIdList = {}

	for _, key in ipairs(keyList) do
		local redId = HolyLightConfig.instance:getHlCommonValue(key)

		if not string.nilorempty(redId) then
			table.insert(redIdList, redId)
		end
	end

	if #redIdList > 0 then
		RedPointController.instance:regRedPoint(redGo, unpack(redIdList))
	end
end

function HolyLightMainView:_onUpdateGridColUI()
	if self._gridCellList == nil then
		self._gridCellList = {}
	end

	local gridIdList = self._holyLightMgr:getGridList()
	local parentView = self._gridCol._view
	local childGo = self._gridCol._cell
	local children = GameUtil.getChildren(parentView)

	GameUtil.SetActive(childGo, false)

	for idx, gridId in ipairs(gridIdList) do
		if not children[idx] then
			local mainGo = goutil.clone(childGo, string.format("%s_%s", childGo.name, gridId))

			goutil.addChildToParent(mainGo, parentView)
		end
	end

	parentView:GetComponent("TestRecordPos"):LoadPlan(0)

	local children = GameUtil.getChildren(parentView)

	for idx, gridId in ipairs(gridIdList) do
		local mainGo = children[idx]
		local cell = {}

		cell._mainGo = mainGo
		cell._btnIcon = goutil.findChild(mainGo, "btnIcon")
		cell._icon = goutil.findChild(mainGo, "btnIcon/icon")
		cell._colliderBox = goutil.findChild(mainGo, "colliderBox")
		self._gridCellList[gridId] = cell
	end

	for idx, cell in ipairs(self._gridCellList) do
		GameUtil.SetActive(cell._mainGo, idx <= #gridIdList)
	end

	for _, gridId in ipairs(gridIdList) do
		self:_updateGridCellUI(gridId)
	end

	self:_startGridTicking()
	self:_resetPlayerToCurGrid()
end

function HolyLightMainView:_onClearGridCol()
	if self._gridCellList then
		for idx, cell in ipairs(self._gridCellList) do
			self:_clearGridCellUI(cell)

			self._gridCellList[idx] = nil
		end

		self._gridCellList = nil
	end

	self:_stopGridTicking()
end

function HolyLightMainView:_getGridCell(gridId)
	if self._gridCellList then
		return self._gridCellList[gridId]
	end
end

function HolyLightMainView:_getGridCellLocalPos(gridId)
	local cell = self:_getGridCell(gridId)

	return GameUtil.getLocalPos(cell._mainGo)
end

function HolyLightMainView:_getGridCellWorldPos(gridId)
	local cell = self:_getGridCell(gridId)

	return GameUtil.getPos(cell._mainGo)
end

function HolyLightMainView:_getGridCellPosList(gridIdList)
	local list = {}

	for _, gridId in ipairs(gridIdList) do
		table.insert(list, self:_getGridCellLocalPos(gridId))
	end

	return list
end

function HolyLightMainView:_updateGridCellUI(gridId)
	local cell = self:_getGridCell(gridId)

	if cell == nil then
		return
	end

	local worldState = self._holyLightMgr:getCurWorldState()
	local gridData = HolyLightConfig.instance:getHlGridData(self._activityId, gridId)
	local pieceData = HolyLightConfig.instance:getHlPieceDataById(self._activityId, gridId)
	local path = pieceData and pieceData.pictureUrl
	local bgGo = cell._icon

	uGuiUtil.clearImage(bgGo)

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	GameUtil.addClickHandler(cell._btnIcon, GameUtil.handler(self._onClickGridCell, self, gridId))
end

function HolyLightMainView:_clearGridCellUI(cell)
	GameUtil.rmClickHandler(cell._btnIcon)
	uGuiUtil.clearImage(cell._icon)
	self:_clearHideAnimOfGrid(cell)
end

function HolyLightMainView:_onClickGridCell(gridId)
	local pieceData = HolyLightConfig.instance:getHlPieceDataById(self._activityId, gridId)

	FloatWordMgr.instance:show(pieceData.name)
end

function HolyLightMainView:_startGridTicking()
	self._boundingBox2D = BoundingBox2D.New()

	settimer(0.1, self._gridTicking, self)
end

function HolyLightMainView:_stopGridTicking()
	removetimer(self._gridTicking, self)

	self._curIntersectCell = nil
end

function HolyLightMainView:_gridTicking()
	for _, cell in ipairs(self._gridCellList) do
		self._cellLocalPosX, self._cellLocalPosY = Framework.TransformUtil.GetLocalPos(cell._mainGo.transform, nil, nil, nil)
		self._colliderLocalPosX, self._colliderLocalPosY = Framework.TransformUtil.GetLocalPos(cell._colliderBox.transform, nil, nil, nil)

		self._boundingBox2D:setSize(cell._colliderBox.transform.sizeDelta.x, cell._colliderBox.transform.sizeDelta.y)
		self._boundingBox2D:setCenter(self._cellLocalPosX + self._colliderLocalPosX, self._cellLocalPosY + self._colliderLocalPosY)

		if self._hLPlayerMgr:isIntersects(self._boundingBox2D) then
			self:_playHideAnimOfGrid(cell, false)
		else
			self:_playHideAnimOfGrid(cell, true)
		end
	end
end

function HolyLightMainView:_playHideAnimOfGrid(cell, isNeedShow)
	if self._gridHideAnimStatePool == nil then
		self._gridHideAnimStatePool = {}
	end

	if self._gridHideAnimStatePool[cell] == nil then
		self._gridHideAnimStatePool[cell] = true
	end

	if self._gridHideAnimStatePool[cell] == isNeedShow then
		return
	end

	local form = cell._mainGo:GetComponent(ComponentType.CanvasGroup).alpha
	local to = 0

	if isNeedShow then
		to = 1
	end

	self._gridHideAnimStatePool[cell] = isNeedShow

	self:_clearHideAnimOfGrid(cell)
	UnityTweens.UITweenFade.StartTween(cell._mainGo, form, to, 0.5, UnityTweens.EaseType.easeInQuad)
end

function HolyLightMainView:_clearHideAnimOfGrid(cell)
	UnityTweens.UITweenFade.StopTween(cell._mainGo)
end

function HolyLightMainView:_onUpdateMasterColUI()
	if self._masterCellPool == nil then
		self._masterCellPool = {}
	end

	for masterId, cell in pairs(self._masterCellPool) do
		GameUtil.SetActive(cell._mainGo, false)
		self:_clearMasterSpine(cell._conRoot)
	end
end

function HolyLightMainView:_onClearMasterCol()
	if self._masterCellPool then
		for masterId, cell in pairs(self._masterCellPool) do
			self:_clearMasterCell(cell)
		end
	end

	self:_clearAllMasterSpine()
end

function HolyLightMainView:_getMasterCell(masterId)
	if self._masterCellPool == nil then
		self._masterCellPool = {}
	end

	if self._masterCellPool[masterId] == nil then
		local parentView = self._masterCol._view
		local childGo = self._masterCol._cell

		GameUtil.SetActive(childGo, false)

		local name = string.format("%s_%s", childGo.name, masterId)
		local mainGo = goutil.findChild(parentView, name) or goutil.cloneAndSetParent(childGo, parentView.transform, name)
		local cell = {}

		cell._mainGo = mainGo
		cell._conRoot = goutil.findChild(mainGo, "conRoot")
		self._masterCellPool[masterId] = cell
	end

	return self._masterCellPool[masterId]
end

function HolyLightMainView:_clearMasterCell(cell)
	self:_clearMasterSpine(cell._conRoot)
end

function HolyLightMainView:_loadMasterSpine(mainGo, masterId)
	if self._masterSpineCtrlPool == nil then
		self._masterSpineCtrlPool = {}
	end

	if not self._masterSpineCtrlPool[mainGo] then
		local ctrl = HLMasterSpineCtrl.New()

		ctrl:onInit(mainGo, self, masterId)

		self._masterSpineCtrlPool[mainGo] = ctrl
	end
end

function HolyLightMainView:_clearMasterSpine(mainGo)
	if self._masterSpineCtrlPool then
		local ctrl = self._masterSpineCtrlPool[mainGo]

		if ctrl then
			ctrl:onClear()
		end
	end
end

function HolyLightMainView:_clearAllMasterSpine()
	if self._masterSpineCtrlPool then
		for mainGo, ctrl in pairs(self._masterSpineCtrlPool) do
			self:_clearMasterSpine(mainGo)
		end
	end
end

function HolyLightMainView:_destoryAllMasterSpine()
	if self._masterSpineCtrlPool then
		for mainGo, ctrl in pairs(self._masterSpineCtrlPool) do
			ctrl:onDestory()

			self._masterSpineCtrlPool[mainGo] = nil
		end
	end

	self._masterSpineCtrlPool = nil
end

function HolyLightMainView:_playExplorationAnim(masterId)
	self:_blockClick(true)

	local masterPos = self._hLPlayerMgr:getPlayerLocalPos()
	local gridIdList = self._holyLightMgr:getGridList()
	local randomGridId = gridIdList[Mathf.Random(1, #gridIdList)]

	if randomGridId > 0 then
		masterPos = self:_getGridCellLocalPos(randomGridId)
	end

	local cell = self:_getMasterCell(masterId)

	GameUtil.SetActive(cell._mainGo, true)
	self:_loadMasterSpine(cell._conRoot, masterId)
	GameUtil.setLocalPos(cell._mainGo, masterPos.x, masterPos.y, 0)

	local function startCallBack()
		return
	end

	local function finishCallBack()
		self:_blockClick(false)
		UIJumper.instance:clear()
		UIJumper.instance:pushOneStack(ViewName.HolyLightMainView)
		HolyLightController.instance:enterBattleAsHolyLight(self._activityId, masterId)
	end

	self._hLPlayerMgr._scrollerViewCtrl:viewTo(masterPos, startCallBack, finishCallBack)
end

function HolyLightMainView:_onClickBtnLightOfSwitch()
	self:_switchWorldState(HolyLightMgr.WorldState.Light)
end

function HolyLightMainView:_onClickBtnDarkOfSwitch()
	self:_switchWorldState(HolyLightMgr.WorldState.Dark)
end

function HolyLightMainView:_onClickBtnSwitchOfSwitch()
	local worldState = self._holyLightMgr:getCurWorldState()

	if worldState == HolyLightMgr.WorldState.Light then
		self:_switchWorldState(HolyLightMgr.WorldState.Dark)
	else
		self:_switchWorldState(HolyLightMgr.WorldState.Light)
	end
end

function HolyLightMainView:_switchWorldState(state)
	local worldState = self._holyLightMgr:getCurWorldState()

	if worldState == state then
		-- block empty
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.HolyLightSwitch)
	self._holyLightMgr:setCurWorldState(state)
	self.mainGO:GetComponent(ComponentType.Animator):SetInteger("WorldState", state)
end

local SmbNameHash_Switch = {
	[HolyLightMgr.WorldState.Light] = UnityEngine.Animator.StringToHash("toLight"),
	[HolyLightMgr.WorldState.Dark] = UnityEngine.Animator.StringToHash("toDark")
}

function HolyLightMainView:_switchWorldStateOfNoAnim(state)
	local name = SmbNameHash_Switch[state]

	self.mainGO:GetComponent(ComponentType.Animator):SetInteger("WorldState", state)
	self.mainGO:GetComponent(ComponentType.Animator):Play(name, 0, 1)
end

function HolyLightMainView:_clearEventQueue()
	if self._eventQueue then
		table.clear(self._eventQueue)
	end

	self._eventQueue = nil
end

function HolyLightMainView:_regEvent(key, totalNum, endCallBack)
	if self._eventQueue == nil then
		self._eventQueue = {}
	end

	self._eventQueue[key] = {
		curNum = 0,
		totalNum = totalNum,
		endCallBack = endCallBack
	}
end

function HolyLightMainView:_endEvent(key, isNeedCallBack)
	local node = self._eventQueue[key]

	if isNeedCallBack then
		GameUtil.callBack(node.endCallBack)
	end

	table.clear(self._eventQueue[key])

	self._eventQueue[key] = nil
end

function HolyLightMainView:_calcNode(key, delta)
	if self._eventQueue[key] == nil then
		return
	end

	local curNum = self._eventQueue[key].curNum

	curNum = curNum + delta

	if curNum >= self._eventQueue[key].totalNum then
		self:_endEvent(key, true)
	else
		self._eventQueue[key].curNum = curNum
	end
end

function HolyLightMainView:_getDiceHandler(handlerIdx)
	return self._diceCol._diceHandlerList[handlerIdx]
end

function HolyLightMainView:_onPlayDice(valueList, typeList, handlerIdxList, autoHideSelfCallback)
	self:_blockClick(true)

	local key = "PlayDice"
	local num = #valueList

	self:_regEvent(key, num, autoHideSelfCallback)

	for idx, val in ipairs(valueList) do
		if typeList then
			if not typeList[idx] then
				local diceType = 1

				if handlerIdxList then
					if not handlerIdxList[idx] then
						local handlerIdx = 2
						local params = {
							autoHideSelfSec = 1,
							value = val,
							useSaiZiId = diceType,
							autoHideSelfCallback = function()
								self:_calcNode(key, 1)
							end,
							thisArg = self,
							bNotPlayAnim = self._holyLightMgr:getDiceAnimToggle()
						}
						local diceHandler = self:_getDiceHandler(handlerIdx)

						if diceHandler then
							diceHandler:play(params)
						else
							printError("缺失")
						end
					end
				end
			end
		end
	end
end

function HolyLightMainView:_clearDice()
	for _, v in ipairs(self._diceCol._diceHandlerList) do
		v:dispose()
	end
end

function HolyLightMainView:_playPathMoveMachine(gridIdList)
	local gridPosList = self:_getGridCellPosList(gridIdList)

	local function startCallback()
		return
	end

	local function finishCallback()
		return
	end

	local function stepStartCallback(stepIdx)
		return
	end

	local function stepFinishCallback(stepIdx)
		local gridId = gridIdList[stepIdx]
		local isFinishStep = stepIdx == #gridIdList

		self:_triggerGrid(gridId, isFinishStep and HolyLightMgr.TriggerMode.StayMode or HolyLightMgr.TriggerMode.MeetMode)

		if isFinishStep then
			self:_endPathMove()
		end
	end

	local speedRatio = HolyLightConfig.instance:getHlCommonValue("PLAYER_MOVE_SPEED_RATIO", true)

	self._hLPlayerMgr:playPathMove(self._playerCellGo, gridPosList, speedRatio, startCallback, finishCallback, stepStartCallback, stepFinishCallback)
end

function HolyLightMainView:_clearPathMoveMachine()
	removetimer(self._onTickingPathMoveMachine, self)

	if self._pathMoveInfo then
		table.clear(self._pathMoveInfo)

		self._pathMoveInfo = nil
	end
end

function HolyLightMainView:_onTickingPathMoveMachine()
	if not self._isCanRunPathMachine or self._pathMoveInfo.nextIdx <= self._pathMoveInfo.curIdx then
		return
	end

	self._pathMoveInfo.curIdx = self._pathMoveInfo.nextIdx
	self._gridIdOfPM = self._pathMoveInfo.gridIdList[self._pathMoveInfo.curIdx]

	if self._gridIdOfPM then
		local nextIdx = self._pathMoveInfo.nextIdx + 1
		local isFinishStep = self._pathMoveInfo.gridIdList[nextIdx] == nil
		local triggerMode = HolyLightMgr.TriggerMode.CloseMode

		triggerMode = isFinishStep and HolyLightMgr.TriggerMode.StayMode or HolyLightMgr.TriggerMode.MeetMode

		local function startHandleOfMove()
			return
		end

		local function finishHandleOfMove()
			self:_triggerGrid(self._gridIdOfPM, triggerMode)

			self._pathMoveInfo.nextIdx = nextIdx

			if isFinishStep then
				self:_endPathMove()
			end
		end

		local speedRatio = HolyLightConfig.instance:getHlCommonValue("PLAYER_MOVE_SPEED_RATIO", true)

		self._hLPlayerMgr:playPathMove(self._playerCellGo, self:_getGridCellPosList({
			self._gridIdOfPM
		}), speedRatio, startHandleOfMove, finishHandleOfMove)
	end
end

function HolyLightMainView:_endPathMove()
	self:_clearPathMoveMachine()
	self:_blockClick(false)
	self:_sendInfoReq()
end

function HolyLightMainView:_triggerGrid(gridId, triggerMode)
	local isCanRunEvent = false
	local gridData = HolyLightConfig.instance:getHlGridData(self._activityId, gridId)

	if gridData.triggerMode == HolyLightMgr.TriggerMode.MeetMode then
		isCanRunEvent = true
	elseif gridData.triggerMode == HolyLightMgr.TriggerMode.StayMode and triggerMode == HolyLightMgr.TriggerMode.StayMode then
		isCanRunEvent = true
	end

	if isCanRunEvent then
		self:_runGridEvent(gridId)
	end
end

function HolyLightMainView:_runGridEvent(gridId)
	self._isCanRunPathMachine = false

	self._hLPlayerMgr:pausePathMoveAnim()

	local gridData = HolyLightConfig.instance:getHlGridData(self._activityId, gridId)
	local eventId = gridData.eventId

	if eventId == HolyLightMgr.GridEvent.Resources then
		self:_doGetResourcesEvent(gridId)
	elseif eventId == HolyLightMgr.GridEvent.Buffs then
		self:_doBuffEvent(gridId)
	elseif eventId == HolyLightMgr.GridEvent.Challenge then
		self:_doMasterEvent(gridId)
	elseif eventId == HolyLightMgr.GridEvent.Double then
		self:_doGetDoubleEvent()
	elseif eventId == HolyLightMgr.GridEvent.Finish then
		self:_doFinishEvent(gridId)
	else
		self:_doTipsEvent(gridId)
	end
end

function HolyLightMainView:_endGridEvent()
	self._hLPlayerMgr:resumePathMoveAnim()

	self._isCanRunPathMachine = true
end

function HolyLightMainView:_doTipsEvent(gridId)
	local gridData = HolyLightConfig.instance:getHlGridData(self._activityId, gridId)
	local eventData = HolyLightConfig.instance:getHlEventData(gridData.eventId)
	local text = eventData and eventData.name

	local function func()
		self:_endGridEvent()
	end

	local btnText = "确定"
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindowNoX("提示", text, func, btnText, alignment)
end

function HolyLightMainView:_popStepCoin(stepCoinNum)
	if stepCoinNum <= 0 then
		return
	end

	local stepCoinStr = HolyLightConfig.instance:getHlCommonValue("SYS_PET_COIN")

	if not string.nilorempty(stepCoinStr) then
		local itemlist = {}
		local matType, matId, matNum = MaterialMgr.getMatParams(stepCoinStr)
		local mo = MaterialModel.instance:createMo(matType, matId, stepCoinNum)

		table.insert(itemlist, mo)

		if #itemlist > 0 then
			local clientChangeSetId = MaterialController.instance:getClientChangeSetId(false)

			MaterialController.instance:showChangeSetItemMo(itemlist, clientChangeSetId)
		end
	end
end

function HolyLightMainView:_doBuffEvent(gridId)
	self:_loadMeetBuffEff(self:_getGridCell(gridId)._mainGo)

	local key = self:_getBuffEffKey(gridId, "Buff")

	local function loadedCallBack(eff, key)
		local formGo = self:_getGridCell(gridId)._mainGo
		local toGo = self._lightCol._btnBuff._mainGo
		local formPos = GameUtil.getPos(formGo)
		local toPos = GameUtil.getPos(toGo)
		local flashParent = self._lightCol._btnBuff._mainGo

		self:_playFlyBuffAnim(formPos, toPos, eff.effGo, flashParent, key)
	end

	self:_loadFlyBuffEff(loadedCallBack, key)
end

function HolyLightMainView:_getBuffEffKey(gridId, name)
	return string.format("%s_%s", gridId, name)
end

function HolyLightMainView:_playFlyBuffAnim(formPos, toPos, mainGo, flashParent, key)
	local function completeFunc()
		self:_clearFlyBuffAnim(key)
		self:_loadBtnBuffFlashEff(flashParent, key, function()
			self:_endGridEvent()
		end)
	end

	GameUtil.setPos(mainGo, formPos.x, formPos.y, formPos.z)

	if self._flyBuffTweenerPool == nil then
		self._flyBuffTweenerPool = {}
	end

	local tweener = mainGo.transform:DOMove(toPos, 1)

	tweener:SetEase(DG.Tweening.Ease.OutSine)
	tweener:OnComplete(completeFunc)

	self._flyBuffTweenerPool[key] = tweener
end

function HolyLightMainView:_clearFlyBuffAnim(key)
	if self._flyBuffTweenerPool then
		self._flyBuffTweenerPool[key]:Kill(false)

		self._flyBuffTweenerPool[key] = nil
	end

	self:_clearFlyBuffEff(key)
end

function HolyLightMainView:_clearAllFlyBuffAnim()
	if self._flyBuffTweenerPool then
		for key, v in pairs(self._flyBuffTweenerPool) do
			self:_clearFlyBuffAnim(key)
		end
	end

	self:_clearAllFlyBuffEff()
	self:_clearAllBtnBuffFlashEff()
end

function HolyLightMainView:_loadFlyBuffEff(loadedCallBack, key)
	local effParent = self._effView._buffEffRoot
	local pathName = "20230303/shenglongtiaozhan/fx_ui_sltz_shouji02"

	self:_clearFlyBuffEff(key)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true

			self:_setGoSortingOrder(eff.effGo.gameObject, HolyLightMainView.LayerName.TopMost)
			GameUtil.callBack(loadedCallBack, eff, key)
		end

		local handlerTarget

		self._effView._buffEffPool[key] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function HolyLightMainView:_clearFlyBuffEff(key)
	UIEffectManager.instance:stopEffect(self._effView._buffEffPool[key])

	self._effView._buffEffPool[key] = nil
end

function HolyLightMainView:_clearAllFlyBuffEff()
	for key, v in pairs(self._effView._buffEffPool) do
		self:_clearFlyBuffEff(key)
	end
end

function HolyLightMainView:_loadBtnBuffFlashEff(effParent, key, loadedCallBack)
	local pathName = "20230303/shenglongtiaozhan/fx_ui_sltz_shouji01"

	self:_clearBtnBuffFlashEff(key)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			self:_clearBtnBuffFlashEff(key)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true

			self:_setGoSortingOrder(eff.effGo.gameObject, HolyLightMainView.LayerName.TopMost)
			GameUtil.callBack(loadedCallBack)
		end

		local handlerTarget

		self._lightCol._btnBuff._flashEffPool[key] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function HolyLightMainView:_clearBtnBuffFlashEff(key)
	UIEffectManager.instance:stopEffect(self._lightCol._btnBuff._flashEffPool[key])

	self._lightCol._btnBuff._flashEffPool[key] = nil
end

function HolyLightMainView:_clearAllBtnBuffFlashEff()
	for key, v in pairs(self._lightCol._btnBuff._flashEffPool) do
		self:_clearBtnBuffFlashEff(key)
	end
end

function HolyLightMainView:_loadMeetBuffEff(effParent)
	if self._meetBuffEffPool == nil then
		self._meetBuffEffPool = {}
	end

	local pathName = "20230331/shengguangzhaoyao/fx_ui_buffup_sgzy"

	self:_clearMeetBuffEff(effParent)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			self:_clearMeetBuffEff(effParent)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true

			self:_setGoSortingOrder(eff.effGo.gameObject, HolyLightMainView.LayerName.Bottom)
		end

		local handlerTarget

		self._meetBuffEffPool[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function HolyLightMainView:_clearMeetBuffEff(effParent)
	if self._meetBuffEffPool then
		UIEffectManager.instance:stopEffect(self._meetBuffEffPool[effParent])
	end
end

function HolyLightMainView:_clearAllMeetBuffEff()
	if self._meetBuffEffPool then
		for k, v in pairs(self._meetBuffEffPool) do
			self:_clearMeetBuffEff(k)
		end
	end
end

function HolyLightMainView:_doMasterEvent(gridId)
	local info = {}

	info.tipsStr = "恶灵来袭！！"

	function info.callBack()
		local formGo = self:_getGridCell(gridId)._mainGo
		local toGo = self._switchCol._btnDark
		local formPos = GameUtil.getPos(formGo)
		local toPos = GameUtil.getPos(toGo)
		local flashParent = self._switchCol._btnDark
		local key = self:_getBuffEffKey(gridId, "Master")

		local function loadedCallBack(eff, key)
			self:_playFlyBuffAnim(formPos, toPos, eff.effGo, flashParent, key)
		end

		self:_loadFlyBuffEff(loadedCallBack, key)
	end

	UIStateManager.instance:push(ViewName.BossTrigger, info)
end

function HolyLightMainView:_doGetResourcesEvent(gridId)
	local doubleTime = self._holyLightMgr:getDoubleTime()
	local isNeedDouble = doubleTime > 0

	if isNeedDouble then
		self:_updateDoubleTips(-1)
	end

	local gridData = HolyLightConfig.instance:getHlGridData(self._activityId, gridId)

	if not string.nilorempty(gridData.params) then
		local strList = string.split(gridData.params, "#")
		local itemlist = {}

		for _, prizeStr in ipairs(strList) do
			local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)

			if matType == 0 or matId == 0 or matNum == 0 then
				printError(string.format("错误,参数中的道具id错误( gridId=%s | ys运营-圣光普照.xlsx | export_格子配置 )", gridId))
			else
				for i = 1, isNeedDouble and 2 or 1 do
					local mo = MaterialModel.instance:createMo(matType, matId, matNum)

					table.insert(itemlist, mo)
				end
			end
		end

		if #itemlist > 0 then
			local clientChangeSetId = MaterialController.instance:getClientChangeSetId(false)

			MaterialController.instance:showChangeSetItemMo(itemlist, clientChangeSetId)
		end
	end

	self:_endGridEvent()
end

function HolyLightMainView:_doGetDoubleEvent()
	FloatWordMgr.instance:show("下次获得资源翻倍")
	self:_updateDoubleTips(1)
	self:_endGridEvent()
end

function HolyLightMainView:_updateDoubleTips(delta)
	local doubleTime = self._holyLightMgr:getDoubleTime()

	doubleTime = doubleTime + delta

	self._holyLightMgr:setDoubleTime(doubleTime)
	GameUtil.SetActive(self._lightCol._doubleResTips._mainGo, doubleTime > 0)

	self._lightCol._doubleResTips._txt.text = string.format("下次资源翻倍：%s", doubleTime)
end

function HolyLightMainView:_doFinishEvent(gridId)
	local finishId = self._holyLightMgr:getCurFinishId()
	local finishData = HolyLightConfig.instance:getHlFinishData(self._activityId, finishId)

	if not string.nilorempty(finishData and finishData.prize) then
		local strList = string.split(finishData.prize, "#")
		local itemlist = {}

		for _, prizeStr in ipairs(strList) do
			local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)

			if matType == 0 or matId == 0 or matNum == 0 then
				printError(string.format("错误,参数中的道具id错误( gridId=%s | ys运营-圣光普照.xlsx | export_格子配置 )", gridId))
			else
				local mo = MaterialModel.instance:createMo(matType, matId, matNum)

				table.insert(itemlist, mo)
			end
		end

		if #itemlist > 0 then
			local clientChangeSetId = MaterialController.instance:getClientChangeSetId(false)

			MaterialController.instance:showChangeSetItemMo(itemlist, clientChangeSetId)
		end
	end

	self:_endGridEvent()
end

function HolyLightMainView:_onClickBtnTaskOfLight()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.HolyLightTask)
	UIStateManager.instance:push(ViewName.HolyLightTaskFrameView, self._activityId)
end

function HolyLightMainView:_onClickBtnPassportOfLight()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.HolyLightPassPort)
	UIStateManager.instance:push(ViewName.PassportHolyLightView)
end

function HolyLightMainView:_onClickBtnRankOfLight()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.HolyLightRank)
	UIStateManager.instance:push(ViewName.HolyLightRankView)
end

function HolyLightMainView:_onClickBtnBuffOfLight()
	UIStateManager.instance:push(ViewName.HolyLightBuffView)
end

function HolyLightMainView:_onClickBtnFuncOfLight()
	local result, tips = self._holyLightMgr:getTryUseFuncCardResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:_blockClick(true)

	local item = HolyLightMgr.GoItem.FuncCard
	local step = 0
	local diceId = self._holyLightMgr:getNormalDieceId()

	HolyLightController.instance:sendPM_HolyLightGoReq(self._activityId, item, step, diceId)
end

function HolyLightMainView:_onClickBtnUniversalDiceOfLight()
	local result, tips = self._holyLightMgr:getTryUseUniversalDicelResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.HolyLightUniversalDiceView)
end

function HolyLightMainView:_handleUniversalDiceSure(diceStep)
	self:_blockClick(true)

	local item = HolyLightMgr.GoItem.UniversalDice
	local step = diceStep
	local diceId = 0

	HolyLightController.instance:sendPM_HolyLightGoReq(self._activityId, item, step, diceId)
end

function HolyLightMainView:_onClickBtnNormalDiceOfLight()
	local diceId = self._holyLightMgr:getNormalDieceId()
	local result, tips = self._holyLightMgr:getTryUseNormalDicelResultAndTips(self._activityId, diceId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:_blockClick(true)

	local item = HolyLightMgr.GoItem.NormalDice
	local step = 0

	HolyLightController.instance:sendPM_HolyLightGoReq(self._activityId, item, step, diceId)
end

function HolyLightMainView:_onClickBtnSwitchNormalDiceOfLight()
	UIStateManager.instance:push(ViewName.HolyLightDiceSelectView)
end

function HolyLightMainView:_onClickBtnDiceAnim()
	local isOn = self._holyLightMgr:getDiceAnimToggle()

	self._holyLightMgr:setDiceAnimToggle(not isOn)
	self:_onUpdateBtnDiceAnimToggle()
end

function HolyLightMainView:_onUpdateBtnDiceAnimToggle()
	local toggle = self._lightCol._btnDiceAnim._toggle:GetComponent("Toggle")

	toggle.isOn = self._holyLightMgr:getDiceAnimToggle()
end

function HolyLightMainView:_onClickBtnRewardOfDark()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.HolyLightPrize)
	UIStateManager.instance:push(ViewName.HolyLightMasterPrizeView)
end

function HolyLightMainView:_onClickBtnShopOfDark()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.HolyLightPetShop)
	UIStateManager.instance:push(ViewName.HolyLightPetShopView)
end

function HolyLightMainView:_onClickBtnExplorationOfDark()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.HolyLightExploration)

	local masterId = self._holyLightMgr:getNextMasterId()
	local result, tips = self._holyLightMgr:getTryFightMasterResultAndTips(self._activityId, masterId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:_playExplorationAnim(masterId)
end

function HolyLightMainView:_blockClick(isNeedBlock)
	GameUtil.SetActive(self._clickMask, isNeedBlock)
end

function HolyLightMainView:_setGoSortingOrder(mainGo, layerName)
	GoUtil.SetSortingOrder(mainGo, layerName == HolyLightMainView.LayerName.Bottom and self._uiBottomCol:GetComponent("Canvas").sortingOrder or layerName == HolyLightMainView.LayerName.Middle and self._uiMiddleCol:GetComponent("Canvas").sortingOrder or layerName == HolyLightMainView.LayerName.Top and self._uiTopCol:GetComponent("Canvas").sortingOrder or layerName == HolyLightMainView.LayerName.TopMost and self._uiTopCol:GetComponent("Canvas").sortingOrder + 1 or UGUIToolHelper.GetNodeCanvansSortingOrder(mainGo))
end

function HolyLightMainView:_onClickBtnTip()
	local worldState = self._holyLightMgr:getCurWorldState()
	local ruleKey = HolyLightConfig.instance:getHlCommonValue(worldState == HolyLightMgr.WorldState.Light and "MAIN_RULE_KEY" or "MAIN_RULE2_KEY")

	TipsFacade.instance:openRulesView(ruleKey)
end

function HolyLightMainView:_onUpdateTestCol()
	local str1 = ""
	local circleId = self._holyLightMgr:getCurCircleId()

	str1 = str1 .. string.format("当前回合：%s", circleId)

	local str2 = ""
	local gridId = self._holyLightMgr:getCurGridId()

	str2 = str2 .. string.format("当前格子：%s", gridId)

	local str3 = ""
	local progress = self._holyLightMgr:getCreepsProgress()

	str3 = str3 .. string.format("当前击杀怪数量：%s", progress)
	self._testCol._txtDesc.text = string.format("%s\n%s\n%s", str1, str2, str3)
end

function HolyLightMainView:_onClickBtnMoveReStartOfTest()
	return
end

function HolyLightMainView:_onClickBtnMoveContinueOfTest()
	return
end

function HolyLightMainView:_onClickBtnMovePauseOfTest()
	return
end

function HolyLightMainView:_onClickBtnRandomLookOfTest()
	return
end

function HolyLightMainView:_onClickBtnFollowLookOfTest()
	return
end

function HolyLightMainView:_onClickBtnFollowLookStopOfTest()
	return
end

return HolyLightMainView
