-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveResultView.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveResultView", package.seeall)

local ImmortalMoveResultView = class("ImmortalMoveResultView", ViewComponent)

function ImmortalMoveResultView:ctor()
	ImmortalMoveResultView.super.ctor(self)
end

function ImmortalMoveResultView:unbindEvents()
	ImmortalMoveResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function ImmortalMoveResultView:bindEvents()
	ImmortalMoveResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function ImmortalMoveResultView:buildUI()
	ImmortalMoveResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._cellGoNote = self:getGo("note/tableview/tablecell")
	self._tableviewGoNote = self:getGo("note/tableview")
	self._emptyNote = self:getGo("note/empty")
	self._tableviewNote = ScrollerList.create(self._tableviewGoNote, self._cellGoNote, GameUtil.handler(self._updatCellNote, self), GameUtil.handler(self._clearCellNote, self))

	self._tableviewNote:setCenterMode(true)

	self._cellGoSettle = self:getGo("settle/tableview/tablecell")
	self._tableviewGoSettle = self:getGo("settle/tableview")
	self._tableviewSettle = ScrollerList.create(self._tableviewGoSettle, self._cellGoSettle, GameUtil.handler(self._updatCellSettle, self), GameUtil.handler(self._clearCellSettle, self))
end

function ImmortalMoveResultView:onExit()
	ImmortalMoveResultView.super.onExit(self)
	self._tableviewNote:dispose()
	self._tableviewSettle:dispose()
end

function ImmortalMoveResultView:onEnter()
	ImmortalMoveResultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._lastResult = params[1]

	if not self._lastResult then
		self:_onClickSure()

		return
	end

	local activityId = checknumber(self._lastResult.activityId)
	local stageId = checknumber(self._lastResult.stageId)
	local isWin = self._lastResult.isWin

	if not self._lastResult.killRound then
		local killRounds = {}

		if not self._lastResult.gainNote then
			local gainNote = {}
			local day = ImmortalMovementController.instance:getCurDay(activityId)
			local stageCfgs = ImmortalMovementConfig.instance:getStageCfgs(activityId, day)
			local stageCfg = stageCfgs[stageId]

			if not stageCfg.notePosition then
				local notePositions = {}

				if not stageCfg.killRound then
					local killRoundTargets = {}
					local creepsMasterId = stageCfg.creepsMasterId
					local creepCfgs = ImmortalMovementConfig.instance:getCreepCfgs(creepsMasterId) or {}

					self._tableviewNote:reloadData(gainNote)
					goutil.setActive(self._emptyNote, #gainNote == 0)

					local settleDataList = {}

					if isWin then
						for i, killRound in ipairs(killRounds) do
							if not notePositions[i] then
								local creepId = 0
								local creepCfg = creepCfgs[creepId]

								if not killRoundTargets[i] then
									local target = 0
									local num = killRound

									if creepCfg then
										local txtSettle = string.format("%s回合内击杀敌阵%s精灵", target, creepCfg.creepsName or "")
										local isMatch = num <= target

										table.insert(settleDataList, {
											txtShow = txtSettle,
											isMatch = isMatch
										})
									end
								end
							end
						end
					end

					table.insert(settleDataList, {
						txtShow = "击败敌阵所有精灵",
						isMatch = isWin
					})
					self._tableviewSettle:reloadData(settleDataList)
				end
			end
		end
	end
end

function ImmortalMoveResultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

function ImmortalMoveResultView:_updatCellNote(view, cell, data)
	local noteChange = goutil.findChildComponent(cell.gameObject, "note", "UIImageSpriteChange")
	local noteId = checknumber(data) % 4

	if noteId == 0 then
		noteId = 4
	end

	noteChange:SetState(noteId - 1)
end

function ImmortalMoveResultView:_clearCellNote(cell)
	return
end

function ImmortalMoveResultView:_updatCellSettle(view, cell, data)
	local mark = goutil.findChildComponent(cell.gameObject, "mark", "UIImageSpriteChange")
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")

	mark:SetState(data.isMatch and 0 or 1)

	txt.text = data.txtShow
end

function ImmortalMoveResultView:_clearCellSettle(cell)
	return
end

return ImmortalMoveResultView
