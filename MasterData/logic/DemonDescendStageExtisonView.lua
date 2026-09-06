-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/view/DemonDescendStageExtisonView.lua

module("logic.extensions.demondescend.view.DemonDescendStageExtisonView", package.seeall)

local DemonDescendStageExtisonView = class("DemonDescendStageExtisonView", ViewComponent)

function DemonDescendStageExtisonView:buildUI()
	DemonDescendStageExtisonView.super.buildUI(self)

	self._cond = goutil.findChild(self.mainGO, "cond")
	self._txtCond = goutil.findChildTextComponent(self.mainGO, "cond/txt")
	self._tagView = self:getGo("tagView")
	self._tagCell = self:getGo("tagCell")

	GameUtil.SetActive(self._tagCell, false)
end

function DemonDescendStageExtisonView:bindEvents()
	DemonDescendStageExtisonView.super.bindEvents(self)
end

function DemonDescendStageExtisonView:unbindEvents()
	DemonDescendStageExtisonView.super.unbindEvents(self)
end

function DemonDescendStageExtisonView:onEnter()
	DemonDescendStageExtisonView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._stageId = self._customFmtMo:getStageId()
	self._creepsMasterId = self._customFmtMo:getCreepsMasterId()

	local stageData = DemonDescendConfig.instance:getStageData(self._activityId, self._stageId)

	if not stageData.killOrder then
		self._posList = {}

		for _, creepsId in ipairs(stageData.killOrder) do
			local data = DemonDescendConfig.instance:getCreepsData(self._creepsMasterId, creepsId)

			table.insert(self._posList, data.posId)
		end

		self:_onUpdate()
	end
end

function DemonDescendStageExtisonView:onExit()
	DemonDescendStageExtisonView.super.onExit(self)
	GameUtil.clearCells(self._tagView, self._clearTagCell, self, false)
end

function DemonDescendStageExtisonView:_onUpdate()
	local posList = {}

	for posId = 1, 9 do
		table.insert(posList, posId)
	end

	GameUtil.updateCellsList(self._tagView, self._tagCell, posList, function(mainGo, posId, index)
		return
	end, self)

	local recordPos = self._tagView:GetComponent(ComponentType.TestRecordPos)

	recordPos:LoadPlan(0)
	GameUtil.updateCellsList(self._tagView, self._tagCell, posList, self._updateTagCell, self)
end

function DemonDescendStageExtisonView:_updateTagCell(mainGo, posId, index)
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local killIndex = table.indexof(self._posList, posId)

	txtNum.text = killIndex and killIndex or 0

	GameUtil.SetActive(mainGo, killIndex ~= false)
end

function DemonDescendStageExtisonView:_clearTagCell(mainGo)
	return
end

return DemonDescendStageExtisonView
