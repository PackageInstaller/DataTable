-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgLookView.lua

module("logic.extensions.jiuclg.view.JiuClgLookView", package.seeall)

local JiuClgLookView = class("JiuClgLookView", ViewComponent)

function JiuClgLookView:buildUI()
	JiuClgLookView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._emptyGo = self:getGo("empty")
	self._subTitleGo = self:getGo("subTitle2")
	self.scrollerGo1 = self:getGo("tableview1")
	self.cellGo1 = self:getGo("tableview1/tablecell")
	self._scrollList1 = ScrollerList.create(self.scrollerGo1, self.cellGo1, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self._clearCell1, self))
	self.scrollerGo2 = self:getGo("tableview2")
	self.cellGo2 = self:getGo("tableview2/tablecell")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))

	self._scrollList2:setCenterMode(true)
end

function JiuClgLookView:bindEvents()
	JiuClgLookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function JiuClgLookView:unbindEvents()
	JiuClgLookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function JiuClgLookView:onEnter()
	JiuClgLookView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._curPhaseId = JiuClgModel.instance:getCurExtremePhaseId(self._activityId)
	self._curStageId = JiuClgModel.instance:getCurExtremeStageId(self._activityId)

	local isShow = self._curStageId > 1

	goutil.setActive(self.scrollerGo1, isShow)
	goutil.setActive(self.scrollerGo2, isShow)
	goutil.setActive(self._subTitleGo, isShow)
	goutil.setActive(self._emptyGo, not isShow)

	if isShow then
		self:_initList()
	end
end

function JiuClgLookView:onExit()
	JiuClgLookView.super.onExit(self)
	self._scrollList1:dispose()
	self._scrollList2:dispose()
end

function JiuClgLookView:_updateCell1(view, cell, data, tag)
	local btn = goutil.findChild(cell, "btn")
	local txtName = goutil.findChildTextComponent(cell, "btn/txtName")
	local txtNum = goutil.findChildTextComponent(cell, "btn/txtNum")
	local bgSpriteChange = goutil.findChildComponent(cell, "btn/bg", ComponentType.UIImageSpriteChange)

	bgSpriteChange:SetState(self._clickStageIndex == data.stageId and 1 or 0)

	txtName.text = data.name
	txtNum.text = string.format("%02d", data.stageId)

	GameUtil.addClickHandler(btn, function()
		self:_updateStageList(data.stageId)
		self:_updateStageLockPet(data.stageId)
	end)
end

function JiuClgLookView:_clearCell1(cell)
	local btn = goutil.findChild(cell, "btn")

	GameUtil.rmClickHandler(btn)
end

function JiuClgLookView:_updateCell2(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.setCell(MatType.Pet, data, icon)
end

function JiuClgLookView:_clearCell2(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

function JiuClgLookView:_initList()
	self._clickStageIndex = 1

	local cfgStages = JiuClgConfig.instance:getExtremeStageList(self._activityId, self._curPhaseId)
	local list = {}
	local count = self._curStageId - 1

	for i, v in ipairs(cfgStages) do
		if i <= count then
			table.insert(list, v)
		end
	end

	self._scrollList1:reloadData(list)
	self:_updateStageLockPet(self._clickStageIndex)
end

function JiuClgLookView:_updateStageList(stageId)
	self._clickStageIndex = stageId

	self._scrollList1:refresh()
end

function JiuClgLookView:_updateStageLockPet(stageId)
	local raceIdList = JiuClgModel.instance:getCurExtremeLockList(self._activityId, stageId)

	self._scrollList2:reloadData(raceIdList)
end

return JiuClgLookView
