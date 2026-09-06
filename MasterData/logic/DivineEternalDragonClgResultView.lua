-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/view/DivineEternalDragonClgResultView.lua

module("logic.extensions.divineeternaldragonclg.view.DivineEternalDragonClgResultView", package.seeall)

local DivineEternalDragonClgResultView = class("DivineEternalDragonClgResultView", ViewComponent)

function DivineEternalDragonClgResultView:ctor()
	DivineEternalDragonClgResultView.super.ctor(self)
end

function DivineEternalDragonClgResultView:unbindEvents()
	DivineEternalDragonClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineEternalDragonClgResultView:bindEvents()
	DivineEternalDragonClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function DivineEternalDragonClgResultView:buildUI()
	DivineEternalDragonClgResultView.super.buildUI(self)

	self._txtResult = self:getTxt("txtResult")
	self._btnClose = self:getGo("btnClose")
	self._require_1 = self:getGo("require_1")
	self._require_2 = self:getGo("require_2")
	self._requireCellList = {}

	for i = 1, 8 do
		local parentId = math.floor((i - 1) / 4) + 1
		local childId = (i - 1) % 4 + 1
		local cell = {}
		local path = string.format("require_%s/list/cell_%s", parentId, childId)

		cell.go = self:getGo(path)
		cell.attr = goutil.findChildComponent(cell.go, "attr", "UIImageSpriteChange")
		cell.result = goutil.findChildComponent(cell.go, "result", "UIImageSpriteChange")
		cell.arrow = goutil.findChild(cell.go, "arrow")
		self._requireCellList[i] = cell
	end
end

function DivineEternalDragonClgResultView:onExit()
	DivineEternalDragonClgResultView.super.onExit(self)
end

function DivineEternalDragonClgResultView:onEnter()
	DivineEternalDragonClgResultView.super.onEnter(self)

	local lastFightInfo = DivineEternalDragonClgModel.instance:getLastFightResultInfo()
	local curActId = lastFightInfo.activityId
	local curStageId = lastFightInfo.stageId
	local passTeam = lastFightInfo.passTeam
	local maxMatchSeq = passTeam and {} or lastFightInfo.maxMatchSeq.list

	self._curStageCfg = DivineEternalDragonClgConfig.instance:getStageCfgByStageId(curActId, curStageId)
	self._txtResult.text = passTeam and "符合条件" or "不符合条件"

	for i, cell in ipairs(self._requireCellList) do
		goutil.setActive(cell.go, false)
		goutil.setActive(cell.arrow, true)
	end

	if self._curStageCfg then
		if not self._curStageCfg.raceTypeSeq then
			local raceTypeSeq = {}

			for i, data in ipairs(raceTypeSeq) do
				local cell = self._requireCellList[i]

				goutil.setActive(cell.go, true)

				if i == #raceTypeSeq then
					goutil.setActive(cell.arrow, false)
				end

				local race = checknumber(GameEnum.Races[data])

				race = race % 10

				cell.attr:SetState(race - 1)

				local isMatch = passTeam and 1 or checknumber(maxMatchSeq[i])

				cell.result:SetState(isMatch)
			end

			goutil.setActive(self._require_2, #raceTypeSeq > 4)
		end
	end
end

function DivineEternalDragonClgResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

return DivineEternalDragonClgResultView
