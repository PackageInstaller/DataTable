-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamirecommenView.lua

module("logic.extensions.hoshigami.view.HoshigamirecommenView", package.seeall)

local HoshigamirecommenView = class("HoshigamirecommenView", TableViewComponent)

function HoshigamirecommenView:ctor()
	HoshigamirecommenView.super.ctor(self)
end

function HoshigamirecommenView:buildUI()
	HoshigamirecommenView.super.buildUI(self)

	self._nameText = goutil.findChildTextComponent(self.mainGO, "nameText")
	self._typeText = goutil.findChildTextComponent(self.mainGO, "typeText")
	self._TxtC_Test = goutil.findChildTextComponent(self.mainGO, "TxtC_Test")
	self._suitConGo = self:getGo("tableview")
	self._suitCellGo = self:getGo("tablecell")
	self._suitScrollList = ScrollerList.create(self._suitConGo, self._suitCellGo, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))

	self._suitScrollList:regGetCellSize(GameUtil.handler(self._getSuitCellSize, self))

	self._notSourceTipGo = self:getGo("notSourceTip")
	self._sourceRootGo = self:getGo("sourceRoot")
end

function HoshigamirecommenView:bindEvents()
	HoshigamirecommenView.super.bindEvents(self)
end

function HoshigamirecommenView:unbindEvents()
	HoshigamirecommenView.super.unbindEvents(self)
end

function HoshigamirecommenView:destroyUI()
	HoshigamirecommenView.super.destroyUI(self)
end

function HoshigamirecommenView:onEnter()
	HoshigamirecommenView.super.onEnter(self)
	self:_updateView()
end

function HoshigamirecommenView:onEnterFinished()
	HoshigamirecommenView.super.onEnterFinished(self)
end

function HoshigamirecommenView:onExit()
	HoshigamirecommenView.super.onExit(self)
	self._suitScrollList:dispose()
end

function HoshigamirecommenView:onExitFinished()
	HoshigamirecommenView.super.onExitFinished(self)
end

function HoshigamirecommenView:_updateView()
	self._typeId = self:getFirstParam()

	local cfgs = HoshigamiConfig.instance:getSuitCfg(self._typeId)
	local suitInfo = HoshigamiConfig.instance:getSuitInfo(self._typeId)

	self._nameText.text = suitInfo.name
	self._typeText.text = suitInfo.typeDes

	self:_setSuitData()
	self:_setSourceData(suitInfo.source)
end

function HoshigamirecommenView:_getPath()
	return {
		cellPath = "sourceRoot/sourcecell",
		viewPath = "sourceRoot/sourcetableview"
	}
end

function HoshigamirecommenView:_updateCell(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "bg/nameText")
	local btn = GameUtil.asBtn(goutil.findChild(cell.gameObject, "bg"))

	nameText.text = data.name

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_clickItem(data)
	end)
end

function HoshigamirecommenView:_cellSize(view, index)
	return 100, 60
end

function HoshigamirecommenView:_clearTableview(cell)
	return
end

function HoshigamirecommenView:_clickItem(data)
	local isLock = not FuncOpenController.instance:getConditionReached(data.openCondition, data.openTime)

	if not string.nilorempty(data.jumpTo) then
		local list = string.split(data.jumpTo, "#")
		local tag = list[1]

		if tag == "fb" then
			local isOpen = PlotCopyModel.instance:isStageUnlock(checknumber(list[2]), checknumber(list[3]))

			if isOpen then
				isLock = false
			end
		end
	end

	local params = string.split(data.jumpTo, "#")
	local goKey = params[1]

	if goKey == "func" then
		local funcId = params[2]

		isLock = isLock or not FuncOpenController.instance:getOtherReachedById(funcId)
	end

	if isLock then
		FloatWordMgr.instance:show(data.lockedTips)
	else
		self:close()
		ViewAutoShowController.instance:saveCurModalView()
		GotoMgr.gotoByString(data.jumpTo)
	end
end

function HoshigamirecommenView:_updateSuitCell(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local effectText = goutil.findChildTextComponent(cell.gameObject, "effectText")
	local name = HoshigamiConfig.instance:getSuitInfo(data.type).name

	nameText.text = string.format("%s%s件套：", name, data.count)
	effectText.text = data.desc
end

function HoshigamirecommenView:_clearSuitCell(cell)
	return
end

function HoshigamirecommenView:_getSuitCellSize(view, index)
	local data = self._suitDatas[index + 1]

	return 100, self:_getTextHeight(data.desc)
end

function HoshigamirecommenView:_getTextHeight(content)
	self._TxtC_Test.text = content

	return self._TxtC_Test.preferredHeight + 10
end

function HoshigamirecommenView:_setSuitData()
	self._suitDatas = {}

	local cfgs = HoshigamiConfig.instance:getSuitCfg(self._typeId)

	for k, v in pairs(cfgs) do
		table.insert(self._suitDatas, v)
	end

	table.sort(self._suitDatas, function(a, b)
		return a.count < b.count
	end)
	self._suitScrollList:reloadData(self._suitDatas)
end

function HoshigamirecommenView:_setSourceData(source)
	self._curViewDatas = {}

	local infos = string.split(source, ",")

	for k, v in pairs(infos or {}) do
		if checknumber(v) > 0 then
			local cf = ItemConfig.instance:getSourceCfg(v)

			table.insert(self._curViewDatas, cf)
		end
	end

	local len = #self._curViewDatas

	goutil.setActive(self._sourceRootGo, len > 0)
	goutil.setActive(self._notSourceTipGo, len <= 0)

	if len > 0 then
		self:reloadData()
	end
end

return HoshigamirecommenView
