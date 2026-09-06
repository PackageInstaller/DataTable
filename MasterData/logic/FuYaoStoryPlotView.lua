-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyaostory/view/FuYaoStoryPlotView.lua

module("logic.extensions.fuyaostory.view.FuYaoStoryPlotView", package.seeall)

local FuYaoStoryPlotView = class("FuYaoStoryPlotView", ViewComponent)

function FuYaoStoryPlotView:buildUI()
	FuYaoStoryPlotView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnReset = self:getGo("btnReset")

	local poltScrView = self:getGo("poltCol/scrView")
	local poltScrCell = self:getGo("poltCol/scrCell")

	self._poltScrollerList = ScrollerList.create(poltScrView, poltScrCell, GameUtil.handler(self._updatePoltCell, self), GameUtil.handler(self._clearPoltCell, self))
	self._unitScrollerListDic = {}
end

function FuYaoStoryPlotView:bindEvents()
	FuYaoStoryPlotView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FuYaoStoryPlotView:unbindEvents()
	FuYaoStoryPlotView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FuYaoStoryPlotView:onEnter()
	FuYaoStoryPlotView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._basePlanId = checknumber(params[1])

	local isInTime = FuYaoStoryController.instance:isInTimeOfPlan(self._basePlanId)

	if not isInTime then
		self:close()

		return
	end

	self:_onUpdate()
end

function FuYaoStoryPlotView:onExit()
	FuYaoStoryPlotView.super.onExit(self)
	self._poltScrollerList:dispose()
end

function FuYaoStoryPlotView:_onUpdate()
	local stepIds = {}
	local stepIdList = {}
	local cfg = FuYaoStoryConfig.instance:getStoryCfg(self._basePlanId) or {}

	for _, data in ipairs(cfg) do
		local stepId = data.stepId

		if not stepIds[stepId] then
			stepIds[stepId] = true

			table.insert(stepIdList, stepId)
		end
	end

	self._poltScrollerList:reloadData(stepIdList)
end

function FuYaoStoryPlotView:_updatePoltCell(view, cell, stepId, tag)
	local cfg = FuYaoStoryConfig.instance:getStoryCfgByStep(self._basePlanId, stepId) or {}
	local mainGo = cell.gameObject
	local txtStep = goutil.findChildTextComponent(mainGo, "txtStep")
	local unitScrView = goutil.findChild(mainGo, "unitScrView")
	local unitScrCell = goutil.findChild(mainGo, "unitScrCell")

	txtStep.text = string.format("第%s章", stepId)

	if not self._unitScrollerListDic[mainGo] then
		local scrollList = ScrollerList.create(unitScrView, unitScrCell, GameUtil.handler(self._updateUnitCell, self), GameUtil.handler(self._clearUnitCell, self))

		self._unitScrollerListDic[mainGo] = self._unitScrollerListDic[mainGo]

		self._unitScrollerListDic[mainGo]:dragNotifyParent()
		self._unitScrollerListDic[mainGo]:reloadData(cfg)
	end
end

function FuYaoStoryPlotView:_clearPoltCell(cell)
	local mainGo = cell.gameObject
	local scrollList = self._unitScrollerListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._unitScrollerListDic[mainGo] = nil
	end
end

function FuYaoStoryPlotView:_updateUnitCell(view, cell, data, tag)
	local isUnlock = FuYaoStoryController.instance:isHasWatchPlot(self._basePlanId, data.plotId)
	local mainGo = cell.gameObject
	local btnVideo = goutil.findChild(mainGo, "btnVideo")
	local tagLock = goutil.findChild(mainGo, "btnVideo/tagLock")
	local txtName = goutil.findChildTextComponent(mainGo, "btnVideo/txtName")

	GameUtil.SetActive(tagLock, not isUnlock)

	txtName.text = data.name

	GameUtil.addClickHandler(btnVideo, function()
		if not isUnlock then
			FloatWordMgr.instance:show("未解锁")

			return
		end

		FuYaoStoryController.instance:playPlot(self._basePlanId, data.plotId)
	end)
end

function FuYaoStoryPlotView:_clearUnitCell(cell)
	local mainGo = cell.gameObject
	local btnVideo = goutil.findChild(mainGo, "btnVideo")

	GameUtil.rmClickHandler(btnVideo)
end

return FuYaoStoryPlotView
