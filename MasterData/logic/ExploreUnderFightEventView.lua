-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderFightEventView.lua

module("logic.extensions.exploreunder.view.ExploreUnderFightEventView", package.seeall)

local ExploreUnderFightEventView = class("ExploreUnderFightEventView", ViewComponent)

function ExploreUnderFightEventView:buildUI()
	ExploreUnderFightEventView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnGoto = self:getGo("btnGoto")
	self._choseCells = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("choseCells/cell_" .. i)
		cell.item = goutil.findChild(cell.go, "item")
		cell.select = goutil.findChild(cell.go, "select")
		cell.parm = 0
		self._choseCells[i] = cell
	end
end

function ExploreUnderFightEventView:bindEvents()
	ExploreUnderFightEventView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)

	for i = 1, 4 do
		GameUtil.addClickHandler(self._choseCells[i].go, GameUtil.handler(self._onClickChoseCell, self, i))
	end
end

function ExploreUnderFightEventView:unbindEvents()
	ExploreUnderFightEventView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)

	for i = 1, 4 do
		GameUtil.rmClickHandler(self._choseCells[i].go)
	end
end

function ExploreUnderFightEventView:onEnter()
	ExploreUnderFightEventView.super.onEnter(self)

	self._curSelectId = 0

	local curActId = ExploreUnderModel.instance:getActId()
	local curActCfg = ExploreUnderConfig.instance:getActfg(curActId)
	local curLevel = ExploreUnderModel.instance:getCurLevel()
	local curLevelCfg = ExploreUnderConfig.instance:getLevelCfg(curActCfg.levelPlanId, curLevel)
	local fightCfgs = ExploreUnderConfig.instance:getFightEventCfgs(curLevelCfg.event_plan_5)

	self._isOnlyShow = checkbool(self:getFirstParam())

	goutil.setActive(self._btnGoto, not self._isOnlyShow)
	self:_onClickChoseCell(1)

	for i = 1, 4 do
		local arr = string.split(fightCfgs[i].prize, "#")
		local prize = arr[1]

		MaterialMgr.setCellByCfg(prize, self._choseCells[i].item)
	end

	if not self._isOnlyShow then
		self._curEventInfo = ExploreUnderModel.instance:getCurGridInfo()

		local curEventState = ExploreUnderModel.instance:getCurEventState()

		if self._curEventInfo.eventType ~= 5 or curEventState ~= 0 then
			self:close()

			return
		end

		local parms = string.split(self._curEventInfo.eventParm, "#")

		for k, v in pairs(parms) do
			local temParms = string.split(v, "=")
			local id = checkint(temParms[1])
			local parm = checkint(temParms[2])

			if id * parm ~= 0 then
				self._choseCells[id].parm = parm
			end
		end
	end
end

function ExploreUnderFightEventView:onExit()
	ExploreUnderFightEventView.super.onExit(self)

	for i = 1, 4 do
		MaterialMgr.resetAll(self._choseCells[i].item)
	end
end

function ExploreUnderFightEventView:_onClickGoto()
	self._curEventInfo = ExploreUnderModel.instance:getCurGridInfo()

	local curEventState = ExploreUnderModel.instance:getCurEventState()

	if self._curEventInfo.eventType ~= 5 or curEventState ~= 0 then
		self:close()

		return
	end

	local mo = ExploreUnderModel.instance:getCustomFmtMo()

	mo:initParams(self._curSelectId, self._choseCells[self._curSelectId].parm)
	CustomFmtController.instance:showMissionView(mo)
	self:close()
end

function ExploreUnderFightEventView:_onClickChoseCell(id)
	self._curSelectId = id

	for i = 1, 4 do
		goutil.setActive(self._choseCells[i].select, self._curSelectId == i)
	end
end

return ExploreUnderFightEventView
