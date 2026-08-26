-- chunkname: @modules/logic/sodache/view/inside/SodacheMapView.lua

module("modules.logic.sodache.view.inside.SodacheMapView", package.seeall)

local SodacheMapView = class("SodacheMapView", BaseView)

function SodacheMapView:onInitView()
	self._btnAbort = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_abort")
	self._gobubble = gohelper.findChild(self.viewGO, "Bubble")
	self._gopathcost = gohelper.findChild(self.viewGO, "Bubble/#go_usePreview")
	self._btninteract = gohelper.findChild(self.viewGO, "Right/#go_interact/#btn_interact")
	self._btnstatus = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btns/#btn_person")
	self._btnbag = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btns/#btn_bag")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btns/#btn_skip")
	self._animSkip = gohelper.findChildAnim(self.viewGO, "Right/Btns/#btn_skip")

	self._animSkip:Play("close", 0, 1)

	self._animSkip.keepAnimatorStateOnDisable = true
	self._gouniticonroot = gohelper.findChild(self.viewGO, "Bubble/#go_unitItem")
	self._anim = gohelper.findComponentAnim(self.viewGO)
	self._goleft = gohelper.findChild(self.viewGO, "Left/Card")
	self._goright = gohelper.findChild(self.viewGO, "Right/Btns")
end

function SodacheMapView:addEvents()
	self._btnSkip:AddClickListener(self.onSkipClick, self)
	self._btnstatus:AddClickListener(self.onStatusClick, self)
	self._btnbag:AddClickListener(self._onBagClick, self)
	self._btnAbort:AddClickListener(self._onAbortClick, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClickNode, self._onClickNode, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClickScene, self._onClickScene, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnScenePropUpdate, self._refreshInitOper, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnPlayerMoveEnd, self.showUnits, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUpdateBattleInfo, self.onUpdateBattleInfo, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnOpenPanel, self.onOpenPanel, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClosePanel, self.onClosePanel, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnSetMovePath, self.refreshSkipBtn, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnStepFlowEnd, self.onStepFlowEnd, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function SodacheMapView:removeEvents()
	self._btnSkip:RemoveClickListener()
	self._btnstatus:RemoveClickListener()
	self._btnbag:RemoveClickListener()
	self._btnAbort:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickNode, self._onClickNode, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickScene, self._onClickScene, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnScenePropUpdate, self._refreshInitOper, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnPlayerMoveEnd, self.showUnits, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUpdateBattleInfo, self.onUpdateBattleInfo, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnOpenPanel, self.onOpenPanel, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClosePanel, self.onClosePanel, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnSetMovePath, self.refreshSkipBtn, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnStepFlowEnd, self.onStepFlowEnd, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function SodacheMapView:onOpen()
	gohelper.setActive(self._btnAbort, not SodacheUtil.isRookie())
	self._anim:Play("open")
	self:refreshSkipBtn()

	self.btnDatas = {}

	gohelper.setActive(self._btninteract, false)

	self._pathComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gopathcost, SodachePathCostComp)

	self:_refreshInitOper()
	self:checkOpenPanel()
	self:refreshHelpBtnPos()
end

function SodacheMapView:refreshHelpBtnPos()
	recthelper.setAnchorX(self._btnAbort.transform, 215.1)
end

function SodacheMapView:_refreshInitOper()
	local insideMo = SodacheModel.instance:getInsideMo()

	if insideMo.prop.status == SodacheEnum.InsideSceneStatus.ShopAndOffering then
		local btnDatas = {}

		if SodacheUtil.isOpen(SodacheEnum.OpenId.Offering_Worship) then
			local isGray = #SodacheMapUtil.getWorshipItems() <= 0

			table.insert(btnDatas, {
				iconType = 1,
				desc = luaLang("sodache_map_btn_altar"),
				type = SodacheEnum.MapNodeOperBtnType.Altar,
				isGray = isGray
			})
		end

		table.insert(btnDatas, {
			iconType = 1,
			desc = luaLang("sodache_map_btn_shop"),
			type = SodacheEnum.MapNodeOperBtnType.Shop
		})
		table.insert(btnDatas, {
			iconType = 1,
			desc = luaLang("sodache_map_btn_leave"),
			type = SodacheEnum.MapNodeOperBtnType.Leave
		})
		self:setBtnDatas(btnDatas)
		SodacheController.instance:dispatchEvent(SodacheEvent.GuideWaitSceneBorn)
	else
		self:setBtnDatas()
	end
end

function SodacheMapView:checkOpenPanel()
	local insideMo = SodacheModel.instance:getInsideMo()

	if insideMo.prop.status == SodacheEnum.InsideSceneStatus.SelectTime then
		ViewMgr.instance:openView(ViewName.SodacheMapSelectTimeView)

		return
	elseif insideMo.prop.status == SodacheEnum.InsideSceneStatus.SelectCard then
		ViewMgr.instance:openView(ViewName.SodacheTakeView)

		return
	elseif insideMo.prop.status ~= SodacheEnum.InsideSceneStatus.Normal then
		return
	end

	local battleInfo = insideMo.prop.battleInfo

	if battleInfo.status == SodacheEnum.FightStatus.ShowPanel then
		local unitMo = battleInfo:getUnitMo()

		if not unitMo then
			logError("有战斗信息，没有战斗事件？？？" .. battleInfo.enemyUid)
		else
			self:setBtnDatas({
				{
					iconType = 1,
					desc = unitMo.eventCo.name,
					type = SodacheEnum.MapNodeOperBtnType.Fight,
					unitMo = unitMo
				}
			})
		end
	elseif battleInfo.status == SodacheEnum.FightStatus.Win or battleInfo.status == SodacheEnum.FightStatus.Lose then
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.FightEnd, "")
	elseif insideMo.panelBox.currPanel.type ~= 0 then
		local unitMo = insideMo.panelBox.currPanel:getUnitMo()

		if not unitMo then
			logError("有面板信息，没有面板事件？？？" .. insideMo.panelBox.currPanel.unitUid)
		else
			self:setBtnDatas({
				{
					iconType = 1,
					desc = unitMo.eventCo.name,
					type = SodacheEnum.MapNodeOperBtnType.StrongEvent,
					unitMo = unitMo
				}
			})
		end
	else
		self:showUnits()
	end
end

function SodacheMapView:onStatusClick()
	ViewMgr.instance:openView(ViewName.SodacheStatusView)
end

function SodacheMapView:_onBagClick()
	ViewMgr.instance:openView(ViewName.SodacheBagView)
end

function SodacheMapView:_onAbortClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.SodacheMessageId373003, MsgBoxEnum.BoxType.Yes_No, self._onAbortMap, nil, nil, self)
end

function SodacheMapView:_onAbortMap()
	SodacheInsideRpc.instance:sendSodacheInsideAbandonScene()
end

function SodacheMapView:_onClickNode(nodeGo, nodeCo)
	if self.btnDatas and self.btnDatas[1] then
		GameFacade.showToast(ToastEnum.SodacheToastId373003)

		return
	end

	local pathInfo = SodacheMapUtil.getOperPath(nodeCo.id)

	if nodeCo == self._pathComp.nodeCo then
		self._pathComp:setTargetGo()

		if not pathInfo then
			logError("目标不可达？？？？？")

			return
		end

		SodacheMapUtil.instance:setMovePaths(pathInfo)
		SodacheMapUtil.instance:tryMoveNextPath(true)
		self:setBtnDatas()

		return
	end

	if not pathInfo then
		GameFacade.showToast(ToastEnum.SodacheToastId373019)

		return
	end

	if pathInfo.dis == 0 then
		self:showUnits()
		self._pathComp:setTargetGo()

		return
	end

	self._pathComp:setTargetGo(nodeGo, nodeCo, pathInfo)
end

function SodacheMapView:showUnits()
	local insideMo = SodacheModel.instance:getInsideMo()
	local unitList = insideMo:getUnitsByNodeId(insideMo.player.locationId)
	local btnDatas = {}

	for k, v in pairs(unitList) do
		if v:canTrigger() then
			local data = {
				iconType = 2,
				desc = v.eventCo.name,
				type = SodacheEnum.MapNodeOperBtnType.Event,
				unitMo = v
			}

			table.insert(btnDatas, data)
		end
	end

	if btnDatas[1] then
		table.insert(btnDatas, {
			iconType = 3,
			desc = luaLang("sodache_map_btn_leave"),
			type = SodacheEnum.MapNodeOperBtnType.LeaveEvent
		})
	end

	self:setBtnDatas(btnDatas)
end

function SodacheMapView:setBtnDatas(datas)
	self.btnDatas = datas or {}

	if not self._interactBtns then
		self._interactBtns = {}

		gohelper.setActive(self._btninteract, true)

		for i = 1, 4 do
			local btnData = self:getUserDataTb_()
			local posRoot = gohelper.findChild(self.viewGO, "Right/#go_interact/pos" .. i)
			local newGo = gohelper.clone(self._btninteract, posRoot)

			btnData.go = newGo
			btnData.types = {}

			for j = 1, 3 do
				local typeData = self:getUserDataTb_()
				local typeGo = gohelper.findChild(newGo, "go_type" .. j)
				local desc = gohelper.findChildTextMesh(typeGo, "#txt_desc")

				typeData.typeGo = typeGo
				typeData.desc = desc
				typeData.bg = gohelper.findChild(typeGo, "bg")
				typeData.icon = gohelper.findChild(typeGo, "icon")
				btnData.types[j] = typeData
			end

			self._interactBtns[i] = btnData

			local btn = gohelper.findChildButtonWithAudio(newGo, "")

			self.addClickCb(self, btn, self._onClickBtn, self, i)
		end

		gohelper.setActive(self._btninteract, false)
	end

	for i = 1, 4 do
		local btnData = self._interactBtns[i]

		if self.btnDatas[4] then
			if not self.btnDatas[i] then
				local data = self.btnDatas[i - 1]

				gohelper.setActive(btnData.go, data)

				if data then
					for j = 1, 3 do
						gohelper.setActive(btnData.types[j].typeGo, j == data.iconType)

						btnData.types[j].desc.text = data.desc

						ZProj.UGUIHelper.SetGrayscale(btnData.types[j].bg, data.isGray or false)
						ZProj.UGUIHelper.SetGrayscale(btnData.types[j].icon, data.isGray or false)
					end
				end
			end
		end
	end

	local hasBtn = #self.btnDatas > 0

	if hasBtn then
		SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode)
	end

	gohelper.setActive(self._gouniticonroot, not hasBtn)
	self.viewContainer:dispatchEvent(SodacheEvent.OnMapShowBtnsChange, hasBtn)
	self:_refreshLeftRightBtnShow()

	for i, v in ipairs(self.btnDatas) do
		local unitMo = v.unitMo

		if unitMo then
			SodacheController.instance:dispatchEvent(SodacheEvent.OnEventChoiceShow, tostring(unitMo.configId))
		end
	end
end

function SodacheMapView:_onClickBtn(index)
	if #self.btnDatas < 4 then
		index = index - 1
	end

	if self.btnDatas then
		local data = self.btnDatas[index]

		if not data then
			return
		end

		if data.unitMo and data.unitMo.locationNo ~= 0 and not string.nilorempty(data.unitMo.prefabPath) then
			self:setBtnDatas()

			self._curFocusData = data
			self._isFocusItem = true

			self.viewContainer:dispatchEvent(SodacheEvent.OnMapFocusEventChange, true)
			UIBlockHelper.instance:startBlock("SodacheMapView_FocusUnit", 0.6)
			SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode, data.unitMo.locationId, data.unitMo.locationNo, self._triggerType, self)

			return
		end

		self:_triggerType(data)
	end
end

function SodacheMapView:_triggerType(data)
	data = data or self._curFocusData
	self._isFocusItem = false

	if not data then
		return
	end

	local func = self["_onTriggerType_" .. SodacheEnum.MapNodeOperBtnName[data.type]]

	if func then
		func(self, data)
	end
end

function SodacheMapView:_onTriggerType_Event(data)
	SodacheMapUtil.instance:tryTriggerUnit(data.unitMo)
	self:setBtnDatas()
end

function SodacheMapView:_onTriggerType_LeaveEvent(data)
	self:setBtnDatas()
end

function SodacheMapView:_onTriggerType_Shop(data)
	local insideMo = SodacheModel.instance:getInsideMo()
	local unitMos = insideMo:getUnitsByType(nil, SodacheEnum.UnitType.Shop)
	local unitInfos = {}

	for i, v in ipairs(unitMos) do
		local shopType = v.shop:getShopType()

		if shopType == SodacheEnum.ShopType.Normal or shopType == SodacheEnum.ShopType.BlackMarket then
			unitInfos[shopType] = v
		end
	end

	ViewMgr.instance:openView(ViewName.SodacheShopView, unitInfos)
end

function SodacheMapView:_onTriggerType_Altar(data)
	local insideMo = SodacheModel.instance:getInsideMo()
	local unitMo = insideMo:getUnitByType(nil, SodacheEnum.UnitType.Worship)

	if unitMo then
		ViewMgr.instance:openView(ViewName.SodacheWorshipView, {
			unitMo = unitMo
		})
	end
end

function SodacheMapView:_onTriggerType_Leave(data)
	local isOpered = SodacheModel.instance:getInsideMo().prop.hotfix[1] == "1"

	if isOpered then
		self:_realLeaveBorn()
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.SodacheMessageId373004, MsgBoxEnum.BoxType.Yes_No, self._realLeaveBorn, nil, nil, self)
	end
end

function SodacheMapView:_onTriggerType_Fight(data)
	SodacheMapUtil.enterFight()
end

function SodacheMapView:_onTriggerType_StrongEvent(data)
	self:onTriggerOpenPanel()
end

function SodacheMapView:_realLeaveBorn()
	SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.LeaveBorn, "")
end

function SodacheMapView:onOpenPanel()
	local panelMo = SodacheModel.instance:getInsideMo().panelBox.currPanel
	local unitMo = panelMo:getUnitMo()

	if not unitMo then
		return
	end

	UIBlockHelper.instance:startBlock("SodacheMapView_FocusUnit", 0.6)
	SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode, unitMo.locationId, unitMo.locationNo, self.onTriggerOpenPanel, self)
end

function SodacheMapView:_onViewOpen(viewName)
	self:_refreshLeftRightBtnShow()
end

function SodacheMapView:_onViewClose(viewName)
	if self._isFocusItem then
		return
	end

	self:_refreshLeftRightBtnShow()

	if not self:isTopView() then
		return
	end

	if #self.btnDatas == 0 and self._curFocusData then
		self._curFocusData = nil

		self.viewContainer:dispatchEvent(SodacheEvent.OnMapFocusEventChange, false)
		SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode)
	end
end

function SodacheMapView:isTopView()
	return ViewHelper.instance:checkViewOnTheTop(self.viewName, {
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.SodacheToastView,
		ViewName.SodacheCardToastView
	})
end

function SodacheMapView:_refreshLeftRightBtnShow()
	local isShow = not (self.btnDatas and #self.btnDatas > 0)

	if not self:isTopView() then
		isShow = false
	end

	gohelper.setActive(self._goleft, isShow)
	gohelper.setActive(self._goright, isShow)
end

function SodacheMapView:onUpdateBattleInfo()
	if SodacheMapUtil.enterFight() then
		return
	end

	self:onTriggerOpenPanel(true)
end

function SodacheMapView:onTriggerOpenPanel(isNotError)
	local panelMo = SodacheModel.instance:getInsideMo().panelBox.currPanel
	local unitMo = panelMo:getUnitMo()

	if not unitMo then
		if not isNotError then
			logError("面板对应的事件不存在！！")
		end

		return
	end

	local viewName = SodacheEnum.PanelViewName[unitMo.type]

	if not viewName then
		logError("未处理面板类型！！" .. unitMo.type)

		return
	end

	ViewMgr.instance:openView(viewName)
	self:setBtnDatas()
end

function SodacheMapView:onClosePanel()
	self:setBtnDatas()
end

function SodacheMapView:_onClickScene()
	if self.btnDatas and self.btnDatas[1] then
		GameFacade.showToast(ToastEnum.SodacheToastId373003)

		return
	end

	if not self._pathComp.nodeCo then
		GameFacade.showToast(ToastEnum.SodacheToastId373006)

		return
	end

	self._pathComp:setTargetGo()
end

function SodacheMapView:onSkipClick()
	SodacheMapUtil.instance:setMovePaths()
end

function SodacheMapView:refreshSkipBtn()
	self._animSkip:Play(SodacheMapUtil.instance:isPlayerMove() and "open" or "close")
end

function SodacheMapView:onStepFlowEnd(context)
	if not context or not context.isEventEnd then
		return
	end

	local insideMo = SodacheModel.instance:getInsideMo()

	if insideMo.prop.status ~= SodacheEnum.InsideSceneStatus.Normal then
		return
	end

	local battleInfo = insideMo.prop.battleInfo

	if battleInfo.status ~= SodacheEnum.FightStatus.None then
		return
	end

	if insideMo.panelBox.currPanel.type > 0 then
		return
	end

	self:showUnits()

	if #self.btnDatas == 0 and self._curFocusData then
		self._curFocusData = nil

		self.viewContainer:dispatchEvent(SodacheEvent.OnMapFocusEventChange, false)
		SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode)
	end
end

function SodacheMapView:onClose()
	gohelper.setActive(self._gobubble, false)
end

function SodacheMapView:onDestroyView()
	ViewMgr.instance:closeView(ViewName.SodacheCardToastView)
	SodacheMapUtil.instance:clear()
end

return SodacheMapView
