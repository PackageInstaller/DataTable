-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpRandomEventView.lua

module("logic.extensions.expedition.view.ExpRandomEventView", package.seeall)

local ExpRandomEventView = class("ExpRandomEventView", ViewComponent)

function ExpRandomEventView:ctor()
	ExpRandomEventView.super.ctor(self)
end

function ExpRandomEventView:destroyUI()
	ExpRandomEventView.super.destroyUI(self)
end

function ExpRandomEventView:onExitFinished()
	ExpRandomEventView.super.onExitFinished(self)
end

function ExpRandomEventView:onEnterFinished()
	ExpRandomEventView.super.onEnterFinished(self)
	self:_stopSelectEffect()
end

function ExpRandomEventView:unbindEvents()
	ExpRandomEventView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnGet:RemoveClickListener()
end

function ExpRandomEventView:bindEvents()
	ExpRandomEventView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
end

function ExpRandomEventView:onExit()
	ExpRandomEventView.super.onExit(self)
end

function ExpRandomEventView:buildUI()
	ExpRandomEventView.super.buildUI(self)

	self._closeButton = self:getBtn("Canvas/btnClose")
	self._btnGet = self:getBtn("btnGet")
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

function ExpRandomEventView:onEnter()
	ExpRandomEventView.super.onEnter(self)

	self._canGet = self._viewPresentor._openParam[2]
	self._gridData = self._viewPresentor._openParam[1]
	self._curSelectIdx = 0
	self._isReqing = false
	self._isDone = false

	self:_setupCards(nil)
	self:_updateBtnState()
end

function ExpRandomEventView:_updateBtnState()
	self._btnGet.gameObject:SetActive(self._curSelectIdx > 0 and self._canGet)
end

function ExpRandomEventView:_setupCards(idList)
	self:_recyleAllGrids()

	if idList then
		if not #idList then
			local len = 3

			for i = 1, len do
				local grid = self:_getOneGrid()
				local index = i

				grid.hideGo:SetActive(idList == nil)

				if idList then
					local cfg = ExpeditionConfig.instance:getRandomCfg(idList[i])

					grid.txtName.text = cfg.name
					grid.txtDesc.text = cfg.desc

					grid.bufIcon:SetImage(GameUrl.getExpEventUrl(cfg.icon))
				end

				grid.goSelect:SetActive(index == self._curSelectIdx or idList ~= nil)

				if index == self._curSelectIdx then
					self:_playSelectEffect(grid.go)
				end

				grid.btn:RemoveClickListener()
				grid.btn:AddClickListener(function()
					if self._isDone or self._isReqing then
						return
					end

					self._curSelectIdx = index

					self:_updateBtnState()
					self:_setupCards()
				end, self)
				GameUtil.setLocalPos(grid.go, (i - 1) * (self._gridWidth + self._gridGap), 0, 0)
			end

			GameUtil.setLocalPos(self._mapRoot, -(len * self._gridWidth + (len - 1) * self._gridGap) * 0.5, 0, 0)
		end
	end
end

function ExpRandomEventView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(100, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(220)

	self._selectEff = eff
end

function ExpRandomEventView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function ExpRandomEventView:_onClickGet()
	if self._isDone or self._isReqing then
		return
	end

	self._isReqing = true

	local selectCard = self._gridList[self._curSelectIdx].go.transform
	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_fanpai.prefab", selectCard)

	eff:setParent(selectCard)
	eff:setLocalPos(96.4, -7, 0)
	eff:setScale(1)
	eff:setEffTime(1)

	function eff.finishHandler()
		self:_requestGetCard()
	end
end

function ExpRandomEventView:_requestGetCard()
	self._btnGet.gameObject:SetActive(false)
	printInfo("_onClickGet")

	local param = ExpeditionExtension_pb.PM_ExpeditionEventParam()

	param.selectedId = 0
	param.replacedId = 0
	param.revertFight = false

	ExpeditionAgent.instance:sendPM_ExpeditionDoGridEventReq(self._gridData.eventIndex, param, function(target, msg)
		local json = require("cjson")
		local data = json.decode(msg.eventRes)

		self:_showAllCards(data)

		self._isReqing = false
		self._isDone = true
	end, self, function()
		self:_updateBtnState()

		self._isReqing = false
	end)
end

function ExpRandomEventView:_showAllCards(data)
	local idList = {}
	local noSelect = {}
	local len = #data.cd

	idList[self._curSelectIdx] = data.ei

	local hasWalkCur = false

	for k, v in ipairs(data.cd) do
		if not hasWalkCur and v == data.ei then
			hasWalkCur = true
		else
			table.insert(noSelect, v)
		end
	end

	local curIdx = 1

	for i = 1, len do
		if i ~= self._curSelectIdx then
			idList[i] = noSelect[curIdx]
			curIdx = curIdx + 1
		end
	end

	self:_setupCards(idList)
end

function ExpRandomEventView:_onClickClose()
	if self._isReqing then
		return
	end

	self:close()
end

function ExpRandomEventView:_getOneGrid()
	local len = #self._gridPool
	local grid

	if len > 0 then
		grid = self._gridPool[len]

		table.remove(self._gridPool, len)
	else
		grid = {}

		local gridGo = goutil.cloneAndSetParent(self._cloneGrid, self._mapRoot.transform)

		grid.go = gridGo
		grid.txtName = goutil.findChildTextComponent(gridGo, "txtName")
		grid.txtDesc = goutil.findChildTextComponent(gridGo, "txtDesc")
		grid.btn = Framework.ButtonAdapter.GetFrom(gridGo, "btn")
		grid.goSelect = goutil.findChild(gridGo, "imgSelect")
		grid.hideGo = goutil.findChild(gridGo, "hide")
		grid.bufIcon = Framework.ImageBigBG.GetFrom(gridGo, "BuffIcon")
	end

	grid.go:SetActive(true)
	table.insert(self._gridList, grid)

	return grid
end

function ExpRandomEventView:_recyleAllGrids()
	for i = 1, #self._gridList do
		local grid = self._gridList[i]

		grid.bufIcon:ClearImage()
		grid.go:SetActive(false)
		table.insert(self._gridPool, grid)
	end

	self._gridList = {}
end

return ExpRandomEventView
