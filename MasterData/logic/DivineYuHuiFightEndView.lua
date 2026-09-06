-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuiFightEndView.lua

module("logic.extensions.divineyuhui.view.DivineYuHuiFightEndView", package.seeall)

local DivineYuHuiFightEndView = class("DivineYuHuiFightEndView", ViewComponent)

function DivineYuHuiFightEndView:ctor()
	DivineYuHuiFightEndView.super.ctor(self)
end

function DivineYuHuiFightEndView:unbindEvents()
	DivineYuHuiFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineYuHuiFightEndView:bindEvents()
	DivineYuHuiFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DivineYuHuiFightEndView:buildUI()
	DivineYuHuiFightEndView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineYuHuiFightEndView:onExit()
	DivineYuHuiFightEndView.super.onExit(self)
	self._scrollList:dispose()
end

function DivineYuHuiFightEndView:onEnter()
	DivineYuHuiFightEndView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._raceIds = params[2]

	self._scrollList:reloadData(self._raceIds)
end

function DivineYuHuiFightEndView:_updateCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local state = goutil.findChild(cell, "state")
	local stageIdList = DivineYuHuiModel.instance:getStageIdListByRaceId(self._activityId, data)

	if stageIdList and #stageIdList > 0 then
		for id = 1, 7 do
			local stateGo = goutil.findChild(state, "imgState" .. id)

			if table.indexof(stageIdList, id) then
				local stateComp = stateGo:GetComponent(ComponentType.UIImageSpriteChange)

				stateComp:SetState(id - 1)
				GameUtil.SetActive(stateGo, true)
			else
				GameUtil.SetActive(stateGo, false)
			end
		end
	end

	MaterialMgr.setCell(MatType.Pet, data, pet)
end

function DivineYuHuiFightEndView:_clearCell(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

function DivineYuHuiFightEndView:_onClickBtnSure()
	BattleController.instance:endBattle()
	self:close()
end

return DivineYuHuiFightEndView
