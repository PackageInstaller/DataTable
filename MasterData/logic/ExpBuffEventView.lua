-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpBuffEventView.lua

module("logic.extensions.expedition.view.ExpBuffEventView", package.seeall)

local ExpBuffEventView = class("ExpBuffEventView", ViewComponent)

function ExpBuffEventView:onExitFinished()
	ExpBuffEventView.super.onExitFinished(self)
	self:_recyleAllGrids()
end

function ExpBuffEventView:unbindEvents()
	ExpBuffEventView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._bgBtnClose:RemoveClickListener()
end

function ExpBuffEventView:bindEvents()
	ExpBuffEventView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._bgBtnClose:AddClickListener(self._onClickClose, self)
end

function ExpBuffEventView:onExit()
	ExpBuffEventView.super.onExit(self)

	self._idList = nil
	self._data = nil
	self._selectDatas = nil
	self._currDataIndex = nil
	self._isSweep = nil
	self._curSelectIdx = nil
	self._canGet = nil

	self:_stopSelectEffect()
	GlobalDispatcher:removeListener(GlobalNotify.OnSweepSelEventBack, self._onSweepSelEventBack, self)
	ExpeditionAgent.instance:removeHandler(ExpeditionAgent.PM_ExpeditionDoEventOverRes, self.msgHandler)

	self.msgHandler = nil
end

function ExpBuffEventView:buildUI()
	ExpBuffEventView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._bgBtnClose = Framework.UIClickTrigger.Get(self:getGo("bgBtnClose"))
	self._btnGet = self:getBtn("btnGet")
	self._btnChange = self:getBtn("btnChange")
	self.txtCost = self:getTxt("txtCost")
	self.icon = self:getGo("txtCost/icon")
	self._buffNums = self:getTxt("buffNums")
	self._mapRoot = self:getGo("cellRoot")
	self._cloneGrid = self:getGo("cellRoot/cell")

	self._cloneGrid:SetActive(false)

	self._gridPool = {}
	self._gridList = {}
	self._gridHeight = GameUtil.getHeight(self._cloneGrid)
	self._gridWidth = GameUtil.getWidth(self._cloneGrid)
	self._gridGap = 30

	local bgCanvas = self:getGo("Canvas")

	GameUtil.expandRectTransform(bgCanvas.transform)
end

function ExpBuffEventView:onEnter()
	ExpBuffEventView.super.onEnter(self)

	local originDatas = self._viewPresentor._openParam[1]

	self._selectDatas = table.values(originDatas)
	self._canGet = self._viewPresentor._openParam[2]
	self._isSweep = self._viewPresentor._openParam[3] or false

	self._closeButton.gameObject:SetActive(not self._isSweep)

	self.msgHandler = ExpeditionAgent.instance:addHandler(ExpeditionAgent.PM_ExpeditionDoEventOverRes, self.onExpEvent, self)

	GlobalDispatcher:addListener(GlobalNotify.OnSweepSelEventBack, self._onSweepSelEventBack, self)
	self:_updateDataByIndex(1)
end

function ExpBuffEventView:_updateDataByIndex(index)
	self._currDataIndex = index

	local data = self._selectDatas[index]

	self:updateData(data)

	local cfgStr = ExpeditionConfig.instance:getConst("refreshBuffCost") or "8:1:1000"
	local matType, matId, matNum = MaterialMgr.getMatParams(cfgStr)

	self.txtCost.text = MaterialFacade:getGoodCost(matType, matId, matNum)

	MaterialMgr.setIcon(self.icon, matType, matId)
end

function ExpBuffEventView:onExpEvent(msg)
	local gridData = self._data
	local eventIndex = msg.evetGrid.eventIndex

	if gridData.eventIndex == eventIndex then
		local data = ExpeditionTilingModel.instance:getGridDatasByEventIndex(eventIndex)

		self:updateData(data)
		TipsFacade.instance:openCommonTips(lang("圣器刷新成功~"))
	end
end

function ExpBuffEventView:_onSweepSelEventBack(newGridData)
	local gridData = self._data

	if newGridData.eventId == gridData.eventId and newGridData.eventIndex == gridData.eventIndex then
		if ExpeditionModel.instance:isEventCompeleted(newGridData.eventId, newGridData.progress) then
			local currDataIndex = self._currDataIndex + 1

			if currDataIndex <= #self._selectDatas then
				self:_updateDataByIndex(currDataIndex)
			else
				self:close()
				ExpeditionController.instance:checkSweepEvents()
			end
		else
			self._selectDatas[self._currDataIndex] = newGridData

			self:_updateDataByIndex(self._currDataIndex)
			TipsFacade.instance:openCommonTips(lang("圣器刷新成功~"))
		end
	end
end

function ExpBuffEventView:updateData(data)
	local idList

	if data.eventId == ExpeditionModel.EventType.BUFF then
		idList = data.eventInfo.em
	elseif data.eventId == ExpeditionModel.EventType.FIGHT then
		idList = data.eventInfo.ids
	end

	self._idList = idList
	self._data = data
	self._curSelectIdx = 0

	self:_setupBuffList()
end

function ExpBuffEventView:_setupBuffList()
	self:_stopSelectEffect()
	self:_recyleAllGrids()
	self._btnGet.gameObject:SetActive(self._canGet and self._curSelectIdx > 0)

	for k, v in ipairs(self._idList) do
		local grid = self:_getOneGrid()
		local cfg = ExpeditionConfig.instance:getBuffCfg(v)
		local index = k

		grid.txtName.text = cfg.name
		grid.txtDesc.text = cfg.desc

		grid.btn:RemoveClickListener()
		grid.bufIcon:SetImage(GameUrl.getExpEventUrl(cfg.icon))
		grid.buffLv:SetState(cfg.quality)
		grid.buffLvState:SetState(checknumber(cfg.nature))
		grid.buffLvIcon:SetNativeSize()

		if self._curSelectIdx == index then
			self:_playSelectEffect(grid.go)
		end

		grid.btn:AddClickListener(function()
			self._curSelectIdx = index

			self:_setupBuffList()
		end, self)
		grid.viewClick:RemoveClickListener()
		grid.viewClick:AddClickListener(function()
			self._curSelectIdx = index

			self:_setupBuffList()
		end, self)
		GameUtil.setLocalPos(grid.go, (k - 1) * (self._gridWidth + self._gridGap), 0, 0)
		Framework.TransformUtil.SetLocalPos(grid.content, 0, 0, 0)

		local sizeDelta = grid.content.sizeDelta

		sizeDelta.y = grid.txtDesc.preferredHeight + 8
		grid.content.sizeDelta = sizeDelta

		local preferredHeight = grid.txtName.preferredWidth
		local widthDelta = math.max(0, preferredHeight - 120) * 0.5

		Framework.TransformUtil.SetAnchoredPos(grid.leftSide.transform, -68 - widthDelta, -40)
		Framework.TransformUtil.SetAnchoredPos(grid.rightSide.transform, 72 + widthDelta, -40)
	end

	local len = #self._idList

	GameUtil.setLocalPos(self._mapRoot, -(len * self._gridWidth + (len - 1) * self._gridGap) * 0.5, GameUtil.getLocalPos(self._mapRoot).y, 0)
	self._buffNums.gameObject:SetActive(self._isSweep)

	if self._isSweep then
		self._buffNums.text = string.format("扫荡后圣器选择数量（%d/%d）", self._currDataIndex, #self._selectDatas)
	end
end

function ExpBuffEventView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(118, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(220)

	self._selectEff = eff
end

function ExpBuffEventView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function ExpBuffEventView:_onClickChange()
	local cfgStr = ExpeditionConfig.instance:getConst("refreshBuffCost") or "8:1:1000"
	local matType, matId, matNum = MaterialMgr.getMatParams(cfgStr)
	local cost = MaterialFacade:getGoodCost(matType, matId, matNum)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = langPara("确定要花费%s%s换一批圣器吗？", cost, matName)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		self.selectedId = 0

		self._btnGet.gameObject:SetActive(self._canGet and self._curSelectIdx > 0)
		self:_recyleAllGrids()

		local gridData = self._data

		self:_sendMsg(gridData.eventIndex, -1)
	end)
end

function ExpBuffEventView:_onClickGet()
	local selectedId = self._idList[self._curSelectIdx]
	local gridData = self._data

	if not self._isSweep then
		self:close()
	end

	self:_sendMsg(gridData.eventIndex, selectedId)
end

function ExpBuffEventView:_sendMsg(eventIndex, selectedId)
	local param = ExpeditionExtension_pb.PM_ExpeditionEventParam()

	param.selectedId = selectedId
	param.replacedId = 0
	param.revertFight = false

	if not self._isSweep then
		ExpeditionAgent.instance:sendPM_ExpeditionDoGridEventReq(eventIndex, param)
	else
		ExpeditionAgent.instance:sendPM_ExpeditionDoSweepEventReq(eventIndex, param)
	end
end

function ExpBuffEventView:_onClickClose()
	if not self._isSweep then
		self:close()
	end
end

function ExpBuffEventView:_getOneGrid()
	local len = #self._gridPool
	local grid

	if len > 0 then
		grid = self._gridPool[len]
		self._gridPool[len] = nil
	else
		grid = {}

		local gridGo = goutil.cloneAndSetParent(self._cloneGrid, self._mapRoot.transform)

		grid.go = gridGo
		grid.txtName = goutil.findChildTextComponent(gridGo, "txtName")
		grid.txtDesc = goutil.findChildTextComponent(gridGo, "View/Viewport/Content/txtDesc")
		grid.btn = Framework.ButtonAdapter.GetFrom(gridGo, "btn")
		grid.bufIcon = Framework.ImageBigBG.GetFrom(gridGo, "BuffIcon")
		grid.buffLv = goutil.findChildComponent(gridGo, "level", "UIImageSpriteChange")
		grid.buffLvState = goutil.findChildComponent(gridGo, "icon", "UIImageSpriteChange")
		grid.buffLvIcon = grid.buffLv:GetComponent(typeof(UnityEngine.UI.Image))
		grid.scrollRect = goutil.findChildComponent(gridGo, "View", "ScrollRect")
		grid.content = goutil.findChild(gridGo, "View/Viewport/Content").transform
		grid.viewClick = Framework.UIClickTrigger.Get(grid.scrollRect.gameObject)
		grid.leftSide = goutil.findChild(grid.go, "LeftSide")
		grid.rightSide = goutil.findChild(grid.go, "RightSide")
	end

	grid.go:SetActive(true)
	table.insert(self._gridList, grid)

	return grid
end

function ExpBuffEventView:_recyleAllGrids()
	for i = 1, #self._gridList do
		local grid = self._gridList[i]

		grid.bufIcon:ClearImage()
		grid.go:SetActive(false)
		grid.viewClick:RemoveClickListener()
		table.insert(self._gridPool, grid)
	end

	self._gridList = {}
end

return ExpBuffEventView
