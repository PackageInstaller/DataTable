-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastGameView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastGameView", package.seeall)

local PanTaoFeastGameView = class("PanTaoFeastGameView", ViewComponent)
local GRID_SIZE = 90
local COOK_GRID_SIZE = 76.5
local COOK_GRID_SPACE = 10
local COOK_GRID_FIXED_COLUMNS = 2

function PanTaoFeastGameView:ctor()
	PanTaoFeastGameView.super.ctor(self)
end

function PanTaoFeastGameView:unbindEvents()
	PanTaoFeastGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnPicRule)
	GameUtil.rmClickHandler(self._btnDeleteDetail)
	GameUtil.rmClickHandler(self._btnShowInfoDetail)
	GameUtil.rmClickHandler(self._btnSwitchNext)
	GameUtil.rmClickHandler(self._btnSwitchPre)
	GameUtil.rmClickHandler(self._btnStartCookCooking)
	GameUtil.rmClickHandler(self._btnFinshCooking)
	GameUtil.rmClickHandler(self._btnGainPrizeOrder)
	BeginDragHandler.Get(self._uiTrigger):RemoveLuaHandler(self._beginDragHandler)
	EndDragHandler.Get(self._uiTrigger):RemoveLuaHandler(self._endDragHandler)
	DragHandler.Get(self._uiTrigger):RemoveLuaHandler(self._dragHandler)
	PointerClickHandler.Get(self._uiTrigger):RemoveLuaHandler(self._pointerClickHandler)
	PointerClickHandler.Get(self._conUseMatsCooking):RemoveLuaHandler(self._pointerClickCookingHandler)
	DropHandler.Get(self._conUseMatsCooking):RemoveLuaHandler(self._dropCookingHandler)
end

function PanTaoFeastGameView:bindEvents()
	PanTaoFeastGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnPicRule, self._onClickBtnPicRule, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickBtnOneKey, self)
	GameUtil.addClickHandler(self._btnDeleteDetail, self._onClickBtnDeleteDetail, self)
	GameUtil.addClickHandler(self._btnShowInfoDetail, self._onClickBtnShowInfoDetail, self)
	GameUtil.addClickHandler(self._btnSwitchNext, self._onClickBtnSwitchNextCooking, self)
	GameUtil.addClickHandler(self._btnSwitchPre, self._onClickBtnSwitchPreCooking, self)
	GameUtil.addClickHandler(self._btnStartCookCooking, self._onClickBtnStartCookCooking, self)
	GameUtil.addClickHandler(self._btnFinshCooking, self._onClickBtnFinshCooking, self)
	GameUtil.addClickHandler(self._btnGainPrizeOrder, self._onClickBtnGainPrizeOrder, self)

	self._beginDragHandler = BeginDragHandler.Get(self._uiTrigger):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragHandler(_go, eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(self._uiTrigger):AddLuaHandler(function(_go, eventData)
		self:_onEndDragHandler(_go, eventData)
	end)
	self._dragHandler = DragHandler.Get(self._uiTrigger):AddLuaHandler(function(_go, eventData)
		self:_onDragHandler(_go, eventData)
	end)
	self._pointerClickHandler = PointerClickHandler.Get(self._uiTrigger):AddLuaHandler(function(_go, eventData)
		self:_onClickHandler(_go, eventData)
	end)
	self._pointerClickCookingHandler = PointerClickHandler.Get(self._conUseMatsCooking):AddLuaHandler(function(_go, eventData)
		self:_onClickHandlerCooking(_go, eventData)
	end)
	self._dropCookingHandler = DropHandler.Get(self._conUseMatsCooking):AddLuaHandler(function(_go, eventData)
		self:_onDropHandlerCooking(_go, eventData)
	end)
end

function PanTaoFeastGameView:buildUI()
	PanTaoFeastGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnPicRule = self:getGo("leftTop/btnPicRule")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnOneKey = self:getGo("btnOneKey")
	self._bgCellBoard = self:getGo("board/bgCell")

	goutil.setActive(self._bgCellBoard, false)

	self._conBgShowBoard = self:getGo("board/conBgShow")
	self._elementCell = self:getGo("board/elementCell")
	self._conElement = self:getGo("board/conElement")
	self._uiTrigger = self:getGo("board/uiTrigger")
	self._dragIcon = self:getGo("dragIcon")
	self._detail = self:getGo("detail")
	self._btnDeleteDetail = self:getGo("detail/btnDelete")
	self._iconDetail = self:getGo("detail/cellbg/icon")
	self._txtDescDetail = self:getTxt("detail/txtDesc")
	self._txtNameDetail = self:getTxt("detail/txtName")
	self._btnShowInfoDetail = self:getGo("detail/btnShowInfo")
	self._conOtherInfo = self:getGo("detail/otherInfo")

	local goTabOther = self:getGo("detail/otherInfo/tableview")
	local goCellOther = self:getGo("detail/otherInfo/tableview/tablecell")

	self._tableViewOtherInfo = ScrollerList.create(goTabOther, goCellOther, GameUtil.handler(self._updateCellOtherInfo, self), GameUtil.handler(self._clearCellOtherInfo, self))
	self._useMatCellCooking = self:getGo("cooking/useMatCell")
	self._conUseMatsCooking = self:getGo("cooking/conUseMats")
	self._txtNameCooking = self:getTxt("cooking/txtName")
	self._btnSwitchNext = self:getGo("cooking/btnSwitchNext")
	self._btnSwitchPre = self:getGo("cooking/btnSwitchPre")
	self._txtlockTipsCooking = self:getTxt("cooking/txtlockTips")
	self._marklLockCooking = self:getGo("cooking/marklLock")
	self._markEmptyCooking = self:getGo("cooking/curDish/markEmpty")
	self._iconCooking = self:getGo("cooking/curDish/icon")
	self._btnStartCookCooking = self:getGo("cooking/btnStartCook")
	self._previewCooking = self:getGo("cooking/preview")
	self._btnFinshCooking = self:getGo("cooking/preview/btnFinsh")
	self._markEmptyCookingPreview = self:getGo("cooking/preview/empty")
	self._iconCookingPreview = self:getGo("cooking/preview/icon")
	self._conOrder = self:getGo("order")
	self._orderInfo = self:getGo("order/orderInfo")
	self._emptyTips = self:getGo("emptyTips")
	self._subCellOrder = self:getGo("order/orderInfo/subCell")

	local goCellOrder = self:getGo("order/orderInfo/cell")
	local goTabOrder = self:getGo("order/orderInfo/tableview")

	self._tableViewOrder = ScrollerList.create(goTabOrder, goCellOrder, GameUtil.handler(self._updateCellOrder, self), GameUtil.handler(self._clearCellOrder, self))
	self._viewportOrder = self:getGo("order/orderInfo/tableview/Viewport")
	self._contentOrder = self:getGo("order/orderInfo/tableview/Viewport/Content")
	self._prizeInfo = self:getGo("order/prizeInfo")

	local goCellPrizeInfo = self:getGo("order/prizeInfo/tableview/tablecell")
	local goTabPrizeInfo = self:getGo("order/prizeInfo/tableview")

	self._tableViewPrizeInfo = ScrollerList.create(goTabPrizeInfo, goCellPrizeInfo, GameUtil.handler(self._updateCellPrizeInfo, self), GameUtil.handler(self._clearCellPrizeInfo, self))
	self._btnGainPrizeOrder = self:getGo("order/prizeInfo/btnGainPrize")
	self._subTabOrderDic = {}
	self._conEff = self:getGo("board/conEff")
end

function PanTaoFeastGameView:onExit()
	PanTaoFeastGameView.super.onExit(self)
	GameUtil.clearCells(self._conBgShowBoard, self._clearCellBgBoard, self)
	GameUtil.clearCells(self._conElement, self._clearCellElement, self)
	GameUtil.clearCells(self._conUseMatsCooking, self._clearCellCooking, self)
	self._tableViewOrder:dispose()
	uGuiUtil.clearImage(self._iconDetail)
	uGuiUtil.clearImage(self._dragIcon)
	PanTaoFeastController.instance:moveElements(self._activityId)
	self:_resetAllEff()
	self._tableViewPrizeInfo:dispose()
	self._tableViewOrder:dispose()
	self._tableViewOtherInfo:dispose()
end

function PanTaoFeastGameView:onEnter()
	PanTaoFeastGameView.super.onEnter(self)
	self:bindEventCallbacks()

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	self:_playDishFinshEffect()
	self:_updateUIByCfg()
	self:_updateUIByInfo()

	self._curSelectGridId = 0

	self:_switchSelectGridElementById(nil)
	self:_switchDragGridElement(nil)
	self:_switchCookingSortId(1)

	local userDataKey = string.format("%s_%s_pantaofeast_pic_rule", self._viewPresentor.viewName, self._activityId)

	GameUtil.doCallbackWhenFirst(userDataKey, function()
		self:_onClickBtnPicRule()
	end)
end

function PanTaoFeastGameView:bindEventCallbacks()
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastNotifyChangeRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PanTaoFeastChangeElementPos, self._refreshGridCellList, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastDeleteGridElementRes, self._handleDeleteGridElement, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastMergeElementsRes, self._handleMergeGridElement, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastProduceElementRes, self._handleProduceElement, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastMoveToStoreRes, self._handleMoveToStore, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastStashToGridRes, self._handleMoveToStore, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastAutoMergeRes, self._handleAutoMerge, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastCookDishRes, self._updateCookingInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastSubmitOrderRes, self._handleSubmitOrder, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastGainRoundPrizeRes, self._handleSubmitOrder, self)
end

function PanTaoFeastGameView:_updateUIByCfg()
	self._actCfg = PanTaoFeastConfig.instance:getActivityCfg(self._activityId) or {}
	self._scoreItemId = self._actCfg.scoreId or 0

	if not self._actCfg.energyId then
		local energyId = 0
		local btn_list = {
			{
				showAdd = false,
				id = string.format("%s:%s", MatType.ACTIVITY_ENERGY, energyId)
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)

		self._curEnergyId = energyId

		self:initMapDataByRowCol(self._actCfg.rowCount or 0, self._actCfg.colCount or 0)

		self._dataListShowBg = {}

		for i = 1, self._rowCount do
			for j = 1, self._colCount do
				local posX, posY = self:getGridPosByRowCol(i, j)

				table.insert(self._dataListShowBg, {
					x = posX,
					y = posY
				})
			end
		end

		GameUtil.updateCellsList(self._conBgShowBoard, self._bgCellBoard, self._dataListShowBg, self._updateCellBgBoard, self)

		self._allToolStashCfgs = PanTaoFeastConfig.instance:getToolStashCfgs(self._activityId) or {}
	end
end

function PanTaoFeastGameView:_updateUIByInfo()
	self:_updateBoardAndOrderInfo()
	self:_updateCookingInfo()
end

function PanTaoFeastGameView:_updateBoardAndOrderInfo()
	self:_updateOrderInfo()

	self._curGridDataList = PanTaoFeastGameController.instance:getCurGridDataList(self._activityId) or {}
	self._tweenScaleDic = self._tweenScaleDic or {}

	table.clear(self._tweenScaleDic)
	GameUtil.updateCellsList(self._conElement, self._elementCell, self._curGridDataList, self._updateCellElement, self)

	local curSelectGridId = self._curSelectGridId

	self._curSelectGridId = 0

	self:_switchSelectGridElementById(curSelectGridId)
end

function PanTaoFeastGameView:_refreshGridCellList()
	self._curGridDataList = self._curGridDataList or {}
	self._tweenScaleDic = self._tweenScaleDic or {}

	table.clear(self._tweenScaleDic)
	GameUtil.updateCellsList(self._conElement, self._elementCell, self._curGridDataList, self._updateCellElement, self)
end

function PanTaoFeastGameView:_handleDeleteGridElement()
	self:_playDeleteEffectByGridId(self._curSelectGridId)
	self:_switchSelectGridElementById(nil)
end

function PanTaoFeastGameView:_handleMergeGridElement()
	self:_playMergeEffectByGridId(self._curSelectGridId)
end

function PanTaoFeastGameView:_handleProduceElement()
	self._tweenScaleDic = self._tweenScaleDic or {}

	local tweenScale = self._tweenScaleDic[self._curSelectGridId]

	if tweenScale then
		tweenScale.enabled = true
	end
end

function PanTaoFeastGameView:_handleAutoMerge()
	self:_switchSelectGridElementById(nil)
	TipsFacade.instance:openCommonTips(langPara("已一键合成"))
end

function PanTaoFeastGameView:_handleMoveToStore()
	self:_switchSelectGridElementById(nil)
	self:_updateUIByInfo()
end

function PanTaoFeastGameView:_handleSubmitOrder()
	self:_updateOrderInfo()
	self:_refreshGridCellList()
	self:_updateCookingInfo()
end

function PanTaoFeastGameView:_playDeleteEffectByGridId(gridId)
	if self._playEffId == nil then
		self._playEffId = 0
	end

	self._playEffId = self._playEffId + 1
	self._playEffList = self._playEffList or {}

	local row, col = PanTaoFeastGameController.instance:gridIdToRowCol(gridId)
	local posX, posY = self:getGridPosByRowCol(row, col)
	local effPath = "20250926/baoweiluobo/fx_ui_xiaoshi.prefab"

	local function onComplete()
		self:_resetEff(self._playEffId)
	end

	self._playEffList[self._playEffId] = self:playViewEffect(effPath, self._conEff, nil, false, posX, posY, onComplete)
end

function PanTaoFeastGameView:_playMergeEffectByGridId(gridId)
	if self._playEffId == nil then
		self._playEffId = 0
	end

	self._playEffId = self._playEffId + 1
	self._playEffList = self._playEffList or {}

	local row, col = PanTaoFeastGameController.instance:gridIdToRowCol(gridId)
	local posX, posY = self:getGridPosByRowCol(row, col)
	local effPath = "20250926/baoweiluobo/fx_ui_chuxian.prefab"

	local function onComplete()
		self:_resetEff(self._playEffId)
	end

	self._playEffList[self._playEffId] = self:playViewEffect(effPath, self._conEff, nil, false, posX, posY, onComplete)
end

function PanTaoFeastGameView:_resetEff(effId)
	if self._playEffList then
		if self._playEffList then
			self:stopViewEffect(self._playEffList)

			self._playEffList[effId] = nil
		end
	end
end

function PanTaoFeastGameView:_resetAllEff()
	if self._playEffList then
		for k, v in pairs(self._playEffList) do
			self:stopViewEffect(v)
		end

		self._playEffList = {}
	end
end

function PanTaoFeastGameView:_playDishFinshEffect()
	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function onComplete(target, eff)
		eff:setScale(0.45)
	end

	self:playViewEffect(effPath, self._btnFinshCooking, self.mainGO, true, 0, 0, nil, onComplete)

	local function onComplete1(target, eff)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1.2, 0.45, 0.45)
	end

	self._showTipEff = self:playViewEffect(effPath, self._btnStartCookCooking, self.mainGO, true, 0, 0, nil, onComplete1)
end

function PanTaoFeastGameView:_playCanGainEffect(go, clipGo)
	self._gainEffMap = self._gainEffMap or {}

	local effPath = "20260724/pantaoshengyan/fx_ui_xiaochukuang.prefab"

	local function onComplete(target, eff)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1.14, 1, 1.1)
	end

	self._gainEffMap[go] = self:playViewEffect(effPath, go, clipGo, true, 0, 0, nil, onComplete)
end

function PanTaoFeastGameView:_resetCanGainEffect(go)
	self._gainEffMap = self._gainEffMap or {}

	local eff = self._gainEffMap[go]

	if eff then
		self:stopViewEffect(eff)

		self._gainEffMap[go] = nil
	end
end

function PanTaoFeastGameView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function PanTaoFeastGameView:_onClickBtnPicRule()
	local picRuleKey = "pantaofeast_pic_rule"

	TipsFacade.instance:openImageRuleViewByKey(picRuleKey)
end

function PanTaoFeastGameView:_onClickBtnOneKey()
	if not YearCardModel.instance:isInitInfo() then
		FloatWordMgr.instance:show(lang("正在读取年费特权信息，请稍后再试"))

		return
	end

	local nowActId = YearCardConfig.instance:getNextActId()

	if not YearCardModel.instance:isActiveAnnuity(nowActId) then
		FloatWordMgr.instance:show(lang("当前不是26年年费，无法使用年费特权一键合成"))

		return
	end

	local userDataKey = string.format("%s_%s_yearcard_privilege_is_need_tips", self._viewPresentor.viewName, self._activityId)
	local isNeedTips = checknumber(GameUtil.getUserDayData(userDataKey)) <= 0

	if isNeedTips then
		local tipsContent = lang("是否使用年费特权进行一键合成？")

		local function funcSend()
			PanTaoFeastController.instance:autoMerge(self._activityId)
		end

		local function funcTog()
			GameUtil.saveUserDayData(userDataKey, 1)
		end

		local togText = lang("今日不再提示")

		TipsFacade.instance:openPopupWindowWithTog(lang("tip"), tipsContent, funcSend, nil, funcTog, lang("确定"), lang("取消"), togText, UnityEngine.TextAnchor.MiddleCenter)
	else
		PanTaoFeastController.instance:autoMerge(self._activityId)
	end
end

function PanTaoFeastGameView:_onClickBtnDeleteDetail()
	local curSelectGridId = checknumber(self._curSelectGridId)
	local data = PanTaoFeastGameController.instance:getGridElementByGridId(curSelectGridId)

	if data and data:isDeletable() then
		local tipsContent = langPara("确认要删除[{0}]？\n删除后不可恢复", data:getElementName())

		TipsFacade.instance:openPopupWindow(lang("提示"), tipsContent, GameUtil.handler(function()
			PanTaoFeastController.instance:deleteGridElement(self._activityId, curSelectGridId)
		end, self, true, false))
	end
end

function PanTaoFeastGameView:_onClickBtnShowInfoDetail()
	local elementId = PanTaoFeastGameController.instance:getElementIdByGridId(checknumber(self._curSelectGridId))

	self:_openElementInfoViewById(elementId)
end

function PanTaoFeastGameView:_onBeginDragHandler(_go, eventData)
	local rowId, colId = self:_getRowColByClickData(eventData)
	local gridId = PanTaoFeastGameController.instance:rowColToGridId(rowId, colId)
	local data = PanTaoFeastGameController.instance:getElementDataByRowCol(rowId, colId)

	if not data then
		return
	end

	if data:isEmpty() then
		return
	end

	if data:isLock() then
		return
	end

	self._isDraging = true

	self:_switchDragGridElement(data)

	if self._curSelectGridId == data:getGridId() then
		self._curSelectGridId = 0
	end

	self:_switchSelectGridElementById(gridId)

	self._isDraging = true
end

function PanTaoFeastGameView:_onDragHandler(_go, eventData)
	if not self._isDraging then
		return
	end

	self:_updateDragGridElementPos(eventData)
end

function PanTaoFeastGameView:_onEndDragHandler(_go, eventData)
	if not self._isDraging then
		return
	end

	self._isDraging = false

	local rowId, colId = self:_getRowColByClickData(eventData)

	self:_switchDragGridElement(nil)

	if PanTaoFeastGameController.instance:isGridMovableToRowCol(self._curSelectGridId, rowId, colId) then
		PanTaoFeastGameController.instance:moveGridIdToRowCol(self._curSelectGridId, rowId, colId)

		local gridId = PanTaoFeastGameController.instance:rowColToGridId(rowId, colId)

		self:_switchSelectGridElementById(gridId)
	else
		self:_refreshGridCellList()
	end
end

function PanTaoFeastGameView:_switchDragGridElement(gridData)
	local isShow = false

	if gridData then
		self._curDragGridElementData = gridData
		isShow = not gridData:isEmpty() and not gridData:isLock()
	else
		self._curDragGridElementData = nil
	end

	if isShow then
		local elementId = self._curDragGridElementData:getElementId()
		local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

		if not GameUtil.isEmptyString(iconPath) then
			local spriteName = GameUrl.getItemIconUrl(iconPath)

			uGuiUtil.setSpriteToImage(self._dragIcon, uGuiUtil.SpriteType.BigBg, spriteName)
		end
	else
		uGuiUtil.clearImage(self._dragIcon)
	end

	goutil.setActive(self._dragIcon, isShow)
end

function PanTaoFeastGameView:_updateDragGridElementPos(eventData)
	local trans = self.mainGO.transform
	local vec = goutil.screenToLocalPos(eventData.position, trans)
	local pos = trans:TransformPoint(vec)
	local localPos = trans:InverseTransformPoint(pos) or Vector3.zero

	GameUtil.setAnchoredPos(self._dragIcon, localPos.x, localPos.y)
end

function PanTaoFeastGameView:_onClickHandler(_go, eventData)
	if self._isDraging then
		return
	end

	local rowId, colId = self:_getRowColByClickData(eventData)
	local isEmpty = PanTaoFeastGameController.instance:isEmptyGridByRowCol(rowId, colId)

	if isEmpty then
		self:_switchSelectGridElementById(nil)
	else
		local gridId = PanTaoFeastGameController.instance:rowColToGridId(rowId, colId)

		if self._curSelectGridId ~= gridId then
			self:_switchSelectGridElementById(gridId)
		else
			PanTaoFeastGameController.instance:onDoubleClickGridElement(gridId)
		end
	end
end

function PanTaoFeastGameView:_switchSelectGridElementById(gridId)
	if self._curSelectGridId == gridId then
		return
	end

	self._curSelectGridId = checknumber(gridId)

	self:_refreshGridCellList()

	local elementId = PanTaoFeastGameController.instance:getElementIdByGridId(self._curSelectGridId)

	if elementId and elementId > 0 then
		local elementNode = PanTaoFeastConfig.instance:getElementChainNodeByElementId(self._activityId, elementId) or {}

		if not elementNode.cfg then
			local cfg = {}

			if not cfg.name then
				self._txtNameDetail.text = ""
			end

			self._txtDescDetail.text = cfg.showDesc or ""

			local data = PanTaoFeastGameController.instance:getGridElementByGridId(self._curSelectGridId)

			goutil.setActive(self._btnDeleteDetail, data and data:isDeletable())
			uGuiUtil.clearImage(self._iconDetail)

			local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

			if not GameUtil.isEmptyString(iconPath) then
				local spriteName = GameUrl.getItemIconUrl(iconPath)

				uGuiUtil.setSpriteToImage(self._iconDetail, uGuiUtil.SpriteType.BigBg, spriteName)
			end

			goutil.setActive(self._detail, true)

			local type = PanTaoFeastGameController.instance:getElementClientTypeById(elementId)

			if type == PanTaoFeastEnum.ElementClientType.Workshop then
				local produceElementMap = PanTaoFeastConfig.instance:getProduceDropCfgsByWorkshop(self._activityId, elementId) or {}
				local produceElementList = {}

				for _, dropCfg in pairs(produceElementMap) do
					table.insert(produceElementList, dropCfg)
				end

				table.sort(produceElementList, function(a, b)
					return a.dropElementId < b.dropElementId
				end)
				self._tableViewOtherInfo:reloadData(produceElementList)
				goutil.setActive(self._conOtherInfo, true)
			else
				goutil.setActive(self._conOtherInfo, false)
			end
		end
	else
		goutil.setActive(self._detail, false)
	end
end

function PanTaoFeastGameView:_updateCellOtherInfo(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local elementId = checknumber(data.dropElementId)
	local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

	uGuiUtil.clearImage(icon)

	if not GameUtil.isEmptyString(iconPath) then
		local spriteName = GameUrl.getItemIconUrl(iconPath)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
	end
end

function PanTaoFeastGameView:_clearCellOtherInfo(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
end

function PanTaoFeastGameView:_getRowColByClickData(eventData)
	local vec = goutil.screenToLocalPos(eventData.position, self._uiTrigger.transform)
	local pos = self._uiTrigger.transform:TransformPoint(vec)
	local localPos = self._uiTrigger.transform:InverseTransformPoint(pos)
	local rowId = math.floor((self._totalHeight / 2 - localPos.y) / GRID_SIZE) + 1
	local colId = math.floor((localPos.x + self._totalWidth / 2) / GRID_SIZE) + 1

	return rowId, colId
end

function PanTaoFeastGameView:initMapDataByRowCol(rowCount, colCount)
	self._rowCount = rowCount
	self._colCount = colCount
	self._totalWidth = colCount * GRID_SIZE
	self._totalHeight = rowCount * GRID_SIZE
	self._startPosX = -self._totalWidth / 2 + GRID_SIZE / 2
	self._startPosY = self._totalHeight / 2 - GRID_SIZE / 2

	GameUtil.setWidth(self._uiTrigger, self._totalWidth)
	GameUtil.setHeight(self._uiTrigger, self._totalHeight)
	GameUtil.setAnchoredPos(self._uiTrigger, 0, 0)
	GameUtil.setAnchoredPos(self._conBgShowBoard, 0, 0)
end

function PanTaoFeastGameView:getGridPosByRowCol(rowId, colId)
	local posX = self._startPosX + (colId - 1) * GRID_SIZE
	local posY = self._startPosY - (rowId - 1) * GRID_SIZE

	return posX, posY
end

function PanTaoFeastGameView:_updateCellBgBoard(cellGo, data, tabIdx)
	local go = cellGo.gameObject

	GameUtil.setAnchoredPos(go, data.x, data.y)
end

function PanTaoFeastGameView:_clearCellBgBoard(cell)
	return
end

function PanTaoFeastGameView:_updateCellElement(cellGo, data, tabIdx)
	local go = cellGo.gameObject
	local con = goutil.findChild(go, "con")
	local isEmpty = data:isEmpty()
	local isDragData = data == self._curDragGridElementData

	goutil.setActive(con, not isEmpty and not isDragData)

	if isEmpty or isDragData then
		return
	end

	local rowId, colId = data:getRowId(), data:getColId()
	local elementId = data:getElementId()
	local posX, posY = self:getGridPosByRowCol(rowId, colId)

	GameUtil.setAnchoredPos(go, posX, posY)

	local icon = goutil.findChild(con, "icon")

	uGuiUtil.clearImage(icon)

	local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

	if not GameUtil.isEmptyString(iconPath) then
		local spriteName = GameUrl.getItemIconUrl(iconPath)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
	end

	local isLock = data:isLock()
	local markLock = goutil.findChild(con, "markLock")

	goutil.setActive(markLock, isLock)

	local gridId = data:getGridId()
	local isSelect = gridId == self._curSelectGridId
	local markSelect = goutil.findChild(con, "markSelect")

	goutil.setActive(markSelect, isSelect)

	local highLight = goutil.findChild(con, "highlight")

	goutil.setActive(highLight, false)

	local iconEnery = goutil.findChild(con, "iconEnery")
	local type = data:getElementType()

	goutil.setActive(iconEnery, type == PanTaoFeastEnum.ElementClientType.Workshop)
	MaterialMgr.resetAll(iconEnery)

	if type == PanTaoFeastEnum.ElementClientType.Workshop then
		MaterialMgr.setIcon(iconEnery, MatType.ACTIVITY_ENERGY, self._curEnergyId)
	end

	self._tweenScaleDic = self._tweenScaleDic or {}
	self._tweenScaleDic[gridId] = goutil.findChild(con, "icon"):GetComponent("TweenScale")

	local highLight = goutil.findChild(con, "highLight")

	self._orderNeedElementDic = self._orderNeedElementDic or {}

	if not self._orderNeedElementDic[elementId] then
		local isNeed = false

		goutil.setActive(highLight, isNeed)
	end
end

function PanTaoFeastGameView:_clearCellElement(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local icon = goutil.findChild(con, "icon")

	uGuiUtil.clearImage(icon)

	local iconEnery = goutil.findChild(con, "iconEnery")

	MaterialMgr.resetAll(iconEnery)
end

function PanTaoFeastGameView:_switchCookingSortId(sortId)
	if self._curCookingSortId == sortId then
		return
	end

	self._curCookingSortId = sortId

	if not self._allToolStashCfgs[sortId] then
		if not self._allToolStashCfgs[sortId].stashId then
			self._curCookingStashId = 0

			self:_initCookingMapDataByGridCount(self._allToolStashCfgs[sortId].capacity or 0)

			self._txtNameCooking.text = self._allToolStashCfgs[sortId].stashName or ""

			self:_updateCookingInfo()
		end
	end
end

function PanTaoFeastGameView:_initCookingMapDataByGridCount(gridCount)
	self._curGridCountCooking = gridCount
	self._curGridRowCountCooking = math.ceil(self._curGridCountCooking / COOK_GRID_FIXED_COLUMNS)
	self._curGridTotalHeightCooking = self._curGridRowCountCooking * COOK_GRID_SIZE + (self._curGridRowCountCooking - 1) * COOK_GRID_SPACE
	self._curGridStartPosYCooking = self._curGridTotalHeightCooking / 2 - COOK_GRID_SIZE / 2
	self._curGridTotalWidthCooking = COOK_GRID_FIXED_COLUMNS * COOK_GRID_SIZE + (COOK_GRID_FIXED_COLUMNS - 1) * COOK_GRID_SPACE
	self._curGridStartPosXCooking = -self._curGridTotalWidthCooking / 2 + COOK_GRID_SIZE / 2

	GameUtil.setWidth(self._conUseMatsCooking, self._curGridTotalWidthCooking)
	GameUtil.setHeight(self._conUseMatsCooking, self._curGridTotalHeightCooking)

	self._dataListPosCooking = {}

	for i = 1, self._curGridCountCooking do
		local rowId = math.floor((i - 1) / COOK_GRID_FIXED_COLUMNS) + 1
		local colId = (i - 1) % COOK_GRID_FIXED_COLUMNS + 1
		local posX = self._curGridStartPosXCooking + (colId - 1) * (COOK_GRID_SIZE + COOK_GRID_SPACE)
		local posY = self._curGridStartPosYCooking - (rowId - 1) * (COOK_GRID_SIZE + COOK_GRID_SPACE)

		table.insert(self._dataListPosCooking, {
			x = posX,
			y = posY,
			sortId = i
		})
	end

	GameUtil.updateCellsList(self._conUseMatsCooking, self._useMatCellCooking, self._dataListPosCooking, self._updateCellCookingPos, self)
end

function PanTaoFeastGameView:_updateCellCookingPos(cellGo, data, tabIdx)
	local go = cellGo.gameObject

	GameUtil.setAnchoredPos(go, data.x, data.y)
end

function PanTaoFeastGameView:_updateCellCookingInfo(cellGo, data, tabIdx)
	local go = cellGo.gameObject

	if not data.sortId then
		if not self._curStashIdsCooking[data.sortId] then
			local elementId = 0
			local icon = goutil.findChild(go, "icon")
			local markEmpty = goutil.findChild(go, "markEmpty")

			uGuiUtil.clearImage(icon)

			if elementId == 0 then
				goutil.setActive(markEmpty, true)
				goutil.setActive(icon, false)
			else
				goutil.setActive(markEmpty, false)
				goutil.setActive(icon, true)

				local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

				if not GameUtil.isEmptyString(iconPath) then
					local spriteName = GameUrl.getItemIconUrl(iconPath)

					uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
				end
			end
		end
	end
end

function PanTaoFeastGameView:_clearCellCooking(cell)
	return
end

function PanTaoFeastGameView:_updateCookingInfo()
	goutil.setActive(self._marklLockCooking, false)
	goutil.setActive(self._btnStartCookCooking, false)
	goutil.setActive(self._btnFinshCooking, false)
	goutil.setActive(self._previewCooking, false)

	if self._showTipEff then
		self._showTipEff:setActive(false)
	end

	self._txtlockTipsCooking.text = ""
	self._curCookingState = PanTaoFeastGameController.instance:getCookAreaStateById(self._curCookingStashId)
	self._curStashIdsCooking = {}
	self._curDishIdCooking = 0
	self._curStashId = 0

	local storeIdsInfo = {}
	local stashInfo = PanTaoFeastModel.instance:getStoreElementInfo(self._activityId, self._curCookingStashId)

	if stashInfo then
		storeIdsInfo = stashInfo.elementIds or {}
	end

	if self._curCookingState == PanTaoFeastEnum.CookingState.Locked then
		local stashCfg = PanTaoFeastConfig.instance:getStashCfg(self._activityId, self._curCookingStashId)

		self._txtlockTipsCooking.text = langPara("第{0}轮订单后解锁", stashCfg.unlockRound)

		goutil.setActive(self._marklLockCooking, true)
	elseif self._curCookingState == PanTaoFeastEnum.CookingState.Waiting then
		self._curStashId = self._curCookingStashId
		self._curStashIdsCooking = storeIdsInfo

		local recipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByCombination(self._activityId, storeIdsInfo)

		if recipeCfg then
			if not recipeCfg.dishElementId then
				local curdishId = 0

				if self._curOrderDishMap then
					if not self._curOrderDishMap[self._curStashId] then
						local orderDishId = 0

						if curdishId == orderDishId and curdishId > 0 and self._showTipEff then
							self._showTipEff:setActive(true)
						end

						if orderDishId > 0 then
							local orderRecipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByDishId(self._activityId, orderDishId)

							if orderRecipeCfg then
								if not orderRecipeCfg.materialElementIds then
									local needMatIds = {}
									local checkElementIDMap = {}

									for _, elementId in ipairs(needMatIds) do
										checkElementIDMap[elementId] = true
									end

									local isMatch = true

									for _, elementId in ipairs(storeIdsInfo) do
										if not checkElementIDMap[elementId] then
											isMatch = false

											break
										end
									end

									self._curDishIdCooking = isMatch and PanTaoFeastGameController.instance:getNextShowElementIdByRecipeId(orderDishId) or 0
								end
							end
						end

						goutil.setActive(self._btnStartCookCooking, true)
						goutil.setActive(self._previewCooking, true)
					end
				end
			end
		end
	elseif self._curCookingState == PanTaoFeastEnum.CookingState.Finished then
		self._curDishIdCooking = storeIdsInfo[1] or 0

		goutil.setActive(self._btnFinshCooking, true)
		goutil.setActive(self._previewCooking, true)

		self._curStashId = self._curCookingStashId
	end

	self:_switchCookingDishInfo()

	self._dataListPosCooking = self._dataListPosCooking or {}

	GameUtil.updateCellsList(self._conUseMatsCooking, self._useMatCellCooking, self._dataListPosCooking, self._updateCellCookingInfo, self)
end

function PanTaoFeastGameView:_switchCookingDishInfo()
	if not self._curDishIdCooking then
		local dishElementId = 0
		local elementCfg = PanTaoFeastConfig.instance:getElementCfgByElementId(self._activityId, dishElementId)

		uGuiUtil.clearImage(self._iconCookingPreview)

		if not elementCfg then
			goutil.setActive(self._markEmptyCookingPreview, true)
			goutil.setActive(self._iconCookingPreview, false)
			goutil.setActive(self._previewCooking, false)
		else
			goutil.setActive(self._markEmptyCookingPreview, false)
			goutil.setActive(self._iconCookingPreview, true)
			goutil.setActive(self._previewCooking, true)

			local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, dishElementId)

			if not GameUtil.isEmptyString(iconPath) then
				local spriteName = GameUrl.getItemIconUrl(iconPath)

				uGuiUtil.setSpriteToImage(self._iconCookingPreview, uGuiUtil.SpriteType.BigBg, spriteName)
			end
		end

		if not self._curCookingStashId then
			local curStashId = 0

			uGuiUtil.clearImage(self._iconCooking)

			if curStashId > 0 then
				local iconPath = PanTaoFeastController.instance:getToolIconPathById(self._activityId, curStashId)

				if not GameUtil.isEmptyString(iconPath) then
					local spriteName = GameUrl.getItemIconUrl(iconPath)

					uGuiUtil.setSpriteToImage(self._iconCooking, uGuiUtil.SpriteType.BigBg, spriteName)
				end

				goutil.setActive(self._iconCooking, true)
				goutil.setActive(self._markEmptyCooking, false)
			else
				goutil.setActive(self._iconCooking, false)
				goutil.setActive(self._markEmptyCooking, true)
			end
		end
	end
end

function PanTaoFeastGameView:_onClickHandlerCooking(_go, eventData)
	if self._curCookingState ~= PanTaoFeastEnum.CookingState.Waiting then
		return
	end

	local vec = goutil.screenToLocalPos(eventData.position, self._conUseMatsCooking.transform)
	local pos = self._conUseMatsCooking.transform:TransformPoint(vec)
	local localPos = self._conUseMatsCooking.transform:InverseTransformPoint(pos)
	local rowId = math.floor((self._curGridTotalHeightCooking / 2 - localPos.y) / (COOK_GRID_SIZE + COOK_GRID_SPACE)) + 1
	local colId = math.floor((localPos.x + self._curGridTotalWidthCooking / 2) / (COOK_GRID_SIZE + COOK_GRID_SPACE)) + 1
	local sortId = (rowId - 1) * COOK_GRID_FIXED_COLUMNS + colId

	if sortId < 1 or sortId > self._curGridCountCooking then
		return
	end

	if not self._curStashIdsCooking[sortId] then
		local elementId = 0

		if elementId == 0 then
			return
		end

		PanTaoFeastController.instance:stashToGrid(self._activityId, self._curCookingStashId, elementId)
	end
end

function PanTaoFeastGameView:_onDropHandlerCooking(_go, eventData)
	if not self._isDraging then
		return
	end

	local data = self._curDragGridElementData

	if not data or data:isEmpty() then
		return
	end

	local isCanMoveToStore, tips = PanTaoFeastGameController.instance:isCanMoveToStore(data:getGridId(), self._curCookingStashId)

	if not isCanMoveToStore then
		FloatWordMgr.instance:show(tips)

		return
	end

	PanTaoFeastController.instance:moveToStore(self._activityId, data:getGridId(), self._curCookingStashId)
end

function PanTaoFeastGameView:_onClickBtnSwitchNextCooking()
	local nextSortId = self._curCookingSortId + 1

	if nextSortId > #self._allToolStashCfgs then
		nextSortId = 1
	end

	self:_switchCookingSortId(nextSortId)
end

function PanTaoFeastGameView:_onClickBtnSwitchPreCooking()
	local preSortId = self._curCookingSortId - 1

	if preSortId < 1 then
		preSortId = #self._allToolStashCfgs
	end

	self:_switchCookingSortId(preSortId)
end

function PanTaoFeastGameView:_onClickBtnStartCookCooking()
	if self._curCookingState ~= PanTaoFeastEnum.CookingState.Waiting then
		return
	end

	local stashInfo = PanTaoFeastModel.instance:getStoreElementInfo(self._activityId, self._curCookingStashId)
	local recipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByCombination(self._activityId, (stashInfo or nil) and (stashInfo.elementIds or {}))

	if not recipeCfg then
		FloatWordMgr.instance:show(lang("当前组合无法制作菜品，请检查食材是否正确"))

		return
	end

	PanTaoFeastController.instance:cookDish(self._activityId, self._curCookingStashId)
end

function PanTaoFeastGameView:_onClickBtnFinshCooking()
	if self._curCookingState ~= PanTaoFeastEnum.CookingState.Finished then
		return
	end

	local hasEmptyGrid = PanTaoFeastGameController.instance:hasEmptyGrid(self._activityId)

	if not hasEmptyGrid then
		FloatWordMgr.instance:show(lang("仓库已满，请先整理仓库后取出"))

		return
	end

	PanTaoFeastController.instance:stashToGrid(self._activityId, self._curCookingStashId, self._curDishIdCooking)
	PanTaoFeastGameController.instance:tryPopElementCI(self._curDishIdCooking)
end

function PanTaoFeastGameView:_updateOrderInfo()
	self._orderNeedElementDic = self._orderNeedElementDic or {}
	self._curOrderDishMap = self._curOrderDishMap or {}

	table.clear(self._orderNeedElementDic)
	table.clear(self._curOrderDishMap)

	local isGainAll = PanTaoFeastGameController.instance:hasAllRoundPrizesGain()

	if isGainAll then
		goutil.setActive(self._conOrder, false)
		goutil.setActive(self._emptyTips, true)

		return
	end

	goutil.setActive(self._conOrder, true)
	goutil.setActive(self._emptyTips, false)

	local orderDataList = PanTaoFeastGameController.instance:getCurRoundRemainOrders() or {}

	table.sort(orderDataList, function(a, b)
		local matchGridIdsA = PanTaoFeastGameController.instance:getGridIdsForOrder(a.orderId)
		local matchGridIdsB = PanTaoFeastGameController.instance:getGridIdsForOrder(b.orderId)

		if matchGridIdsA and matchGridIdsB then
			return (b.orderId or 0) < (a.orderId or 0)
		elseif matchGridIdsA then
			return true
		elseif matchGridIdsB then
			return false
		else
			return (b.orderId or 0) < (a.orderId or 0)
		end
	end)
	self._tableViewOrder:reloadData(orderDataList)
	self._tableViewOrder:MoveCellToBegin(0)

	local curRoundId = PanTaoFeastModel.instance:getCurRoundId(self._activityId)
	local roundCfg = PanTaoFeastConfig.instance:getRoundPrizeCfg(self._activityId, curRoundId)

	if roundCfg then
		if not roundCfg.gridElementPrize then
			local gridElementPrize = {}

			self._tableViewPrizeInfo:reloadData(gridElementPrize)

			if #orderDataList > 0 then
				goutil.setActive(self._orderInfo, true)
				goutil.setActive(self._prizeInfo, false)

				for _, orderData in ipairs(orderDataList) do
					if not orderData.needElementIds then
						for _, elementId in ipairs(orderData.needElementIds) do
							self._orderNeedElementDic[elementId] = true

							local type = PanTaoFeastGameController.instance:getElementClientTypeById(elementId)

							if type == PanTaoFeastEnum.ElementClientType.Dish or type == PanTaoFeastEnum.ElementClientType.GreatDish then
								local recipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByDishId(self._activityId, elementId)

								if recipeCfg then
									local cookToolId = recipeCfg.cookToolId

									self._curOrderDishMap[cookToolId] = elementId
								end
							end
						end
					end
				end
			else
				goutil.setActive(self._orderInfo, false)
				goutil.setActive(self._prizeInfo, true)
			end
		end
	end
end

function PanTaoFeastGameView:_updateCellOrder(view, cell, data)
	local go = cell.gameObject
	local subTableview = self._subTabOrderDic[go]

	if not data.needElementIds then
		if not subTableview then
			local subCell = self._subCellOrder
			local subTab = goutil.findChild(go, "subTabview")

			subTableview = ScrollerList.create(subTab, subCell, GameUtil.handler(self._updateCellOrderItem, self), GameUtil.handler(self._clearCellOrderItem, self))

			subTableview:dragNotifyParent()

			self._subTabOrderDic[go] = subTableview
		end

		subTableview:reloadData(data.needElementIds)

		local txtScore = goutil.findChildTextComponent(go, "txtScore")

		txtScore.text = data.rewardScore or 0

		local markMatch = goutil.findChild(go, "markMatch")
		local btnFinish = goutil.findChild(go, "btnFinish")
		local matchGridIds = PanTaoFeastGameController.instance:getGridIdsForOrder(data.orderId)
		local isMatch = matchGridIds ~= nil and #matchGridIds > 0

		goutil.setActive(markMatch, isMatch)
		goutil.setActive(btnFinish, isMatch)
		GameUtil.rmClickHandler(btnFinish)
		GameUtil.addClickHandler(btnFinish, GameUtil.handler(function()
			local curMatchGridIds = PanTaoFeastGameController.instance:getGridIdsForOrder(data.orderId)
			local isMatch = curMatchGridIds ~= nil and #curMatchGridIds > 0

			if not isMatch then
				FloatWordMgr.instance:show(lang("当前订单不满足要求，无法完成"))
				self:_updateOrderInfo()

				return
			end

			PanTaoFeastController.instance:submitOrder(self._activityId, data.orderId, curMatchGridIds)
		end, self))

		local iconScore = goutil.findChild(go, "iconScore")

		MaterialMgr.resetAll(iconScore)
		MaterialMgr.setIcon(iconScore, MatType.Item_Fake, self._scoreItemId)

		local iconPet = goutil.findChild(go, "pet/iconPet")
		local skinId = data.skinId

		MaterialMgr.setIcon(iconPet, MatType.PET_SKIN, skinId)
		self:_resetCanGainEffect(btnFinish)

		if isMatch then
			self:_playCanGainEffect(btnFinish, self._viewportOrder)
		end
	end
end

function PanTaoFeastGameView:_clearCellOrder(cell)
	local go = cell.gameObject
	local subTableview = self._subTabOrderDic[go]

	if subTableview then
		subTableview:dispose()

		self._subTabOrderDic[go] = nil
	end

	local btnFinish = goutil.findChild(go, "btnFinish")

	GameUtil.rmClickHandler(btnFinish)

	local iconScore = goutil.findChild(go, "iconScore")

	MaterialMgr.resetAll(iconScore)

	local iconPet = goutil.findChild(go, "pet/iconPet")

	MaterialMgr.resetAll(iconPet)
	self:_resetCanGainEffect(btnFinish)
end

function PanTaoFeastGameView:_updateCellOrderItem(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)

	local elementCellId = checknumber(data)
	local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementCellId)

	if not GameUtil.isEmptyString(iconPath) then
		local spriteName = GameUrl.getItemIconUrl(iconPath)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName, function()
			local pos = GameUtil.getAnchoredPos(self._contentOrder) or Vector2.zero

			GameUtil.setAnchoredPos(self._contentOrder, pos.x, pos.y + 1)
		end)
	end

	GameUtil.addClickHandler(icon, GameUtil.handler(function()
		self:_openElementInfoViewById(elementCellId)
	end, self))

	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local isExist = PanTaoFeastGameController.instance:hasElement(elementCellId)

	txtNum.text = isExist and "<color=#20b376>1/1</color>" or "0/1"

	local markExist = goutil.findChild(go, "markExist")

	goutil.setActive(markExist, isExist)

	local tips = goutil.findChild(go, "tips")
	local iconTips = goutil.findChild(go, "tips/icon")
	local showElementId = PanTaoFeastGameController.instance:getNextShowElementIdByRecipeId(elementCellId)

	if showElementId and showElementId > 0 then
		goutil.setActive(tips, true)

		local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, showElementId)

		if not GameUtil.isEmptyString(iconPath) then
			local spriteName = GameUrl.getItemIconUrl(iconPath)

			uGuiUtil.setSpriteToImage(iconTips, uGuiUtil.SpriteType.BigBg, spriteName)
		end
	else
		goutil.setActive(tips, false)
	end
end

function PanTaoFeastGameView:_clearCellOrderItem(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local iconTips = goutil.findChild(go, "tips/icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(icon)
	uGuiUtil.clearImage(iconTips)
end

function PanTaoFeastGameView:_onClickBtnGainPrizeOrder()
	local curRoundId = PanTaoFeastModel.instance:getCurRoundId(self._activityId)
	local isGain = PanTaoFeastModel.instance:hasGainRoundPrize(self._activityId, curRoundId)

	if isGain then
		FloatWordMgr.instance:show(lang("当前轮次奖励已领取"))

		return
	end

	local orderDataList = PanTaoFeastGameController.instance:getCurRoundRemainOrders() or {}

	if #orderDataList > 0 then
		FloatWordMgr.instance:show(lang("当前轮次还有未完成的订单，无法领取奖励"))

		return
	end

	local roundPrizeCfg = PanTaoFeastConfig.instance:getRoundPrizeCfg(self._activityId, curRoundId)

	if roundPrizeCfg then
		if not roundPrizeCfg.gridElementPrize then
			local gridElementPrize = {}
			local hasEmptyGrid = PanTaoFeastGameController.instance:hasEnoughEmptyGrid(#gridElementPrize)

			if not hasEmptyGrid then
				FloatWordMgr.instance:show(lang("棋盘没有足够空间，请先整理后再领取奖励"))

				return
			end

			PanTaoFeastController.instance:gainRoundPrize(self._activityId, curRoundId)
			PanTaoFeastGameController.instance:tryPopElementCI(unpack(gridElementPrize))
		end
	end
end

function PanTaoFeastGameView:_updateCellPrizeInfo(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)

	local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, data)

	GameUtil.rmClickHandler(icon)

	if not GameUtil.isEmptyString(iconPath) then
		local spriteName = GameUrl.getItemIconUrl(iconPath)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
	end

	GameUtil.addClickHandler(icon, GameUtil.handler(function()
		self:_openElementInfoViewById(data)
	end, self))
end

function PanTaoFeastGameView:_clearCellPrizeInfo(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(icon)
end

function PanTaoFeastGameView:_openElementInfoViewById(elementId)
	local type = PanTaoFeastGameController.instance:getElementClientTypeById(elementId)

	if type == PanTaoFeastEnum.ElementClientType.RawMat then
		UIStateManager.instance:push(ViewName.PanTaoFeastMatInfoView, self._activityId, elementId)
	elseif type == PanTaoFeastEnum.ElementClientType.Dish or type == PanTaoFeastEnum.ElementClientType.GreatDish then
		UIStateManager.instance:push(ViewName.PanTaoFeastRecipeInfoView, self._activityId, elementId)
	elseif type == PanTaoFeastEnum.ElementClientType.Workshop then
		UIStateManager.instance:push(ViewName.PanTaoFeastToolInfoView, self._activityId, elementId)
	elseif type == PanTaoFeastEnum.ElementClientType.EnergyItem then
		UIStateManager.instance:push(ViewName.PanTaoFeastItemInfoView, self._activityId, elementId)
	elseif type == PanTaoFeastEnum.ElementClientType.Backpack then
		UIStateManager.instance:push(ViewName.PanTaoFeastBackpackView, self._activityId, elementId)
	else
		return
	end
end

return PanTaoFeastGameView
