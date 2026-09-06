-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveFmtExView.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveFmtExView", package.seeall)

local ImmortalMoveFmtExView = class("ImmortalMoveFmtExView", ViewComponent)

function ImmortalMoveFmtExView:ctor()
	ImmortalMoveFmtExView.super.ctor(self)
end

function ImmortalMoveFmtExView:unbindEvents()
	ImmortalMoveFmtExView.super.unbindEvents(self)
end

function ImmortalMoveFmtExView:bindEvents()
	ImmortalMoveFmtExView.super.bindEvents(self)
end

function ImmortalMoveFmtExView:buildUI()
	ImmortalMoveFmtExView.super.buildUI(self)

	self._emptyNoteList = {}

	for i = 1, 9 do
		self._emptyNoteList[i] = self:getGo("emptyNotes/note" .. i)
	end
end

function ImmortalMoveFmtExView:onExit()
	ImmortalMoveFmtExView.super.onExit(self)
end

function ImmortalMoveFmtExView:onEnter()
	ImmortalMoveFmtExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]

	for i, note in ipairs(self._emptyNoteList) do
		goutil.setActive(note, false)
	end

	self.activityId = self.customFmtMo.activityId
	self.stageId = self.customFmtMo.stageId

	local day = ImmortalMovementController.instance:getCurDay(self.activityId)

	self._stageCfgs = ImmortalMovementConfig.instance:getStageCfgs(self.activityId, day)

	local stageCfg = self._stageCfgs[self.stageId]
	local creepsMasterId = stageCfg.creepsMasterId

	if not stageCfg.notePosition then
		local notePositions = {}
		local creepCfgs = ImmortalMovementConfig.instance:getCreepCfgs(creepsMasterId) or {}

		for _, cfg in pairs(creepCfgs) do
			local posId = cfg.posId
			local creepsId = cfg.creepsId
			local isNote = table.indexof(notePositions, creepsId)

			if (posId >= 1 or posId <= 9) and isNote then
				goutil.setActive(self._emptyNoteList[posId], true)
			end
		end
	end
end

return ImmortalMoveFmtExView
