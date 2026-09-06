-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronerewardView.lua

module("logic.extensions.throne.view.ThronerewardView", package.seeall)

local ThronerewardView = class("ThronerewardView", TableViewComponent)

function ThronerewardView:ctor()
	ThronerewardView.super.ctor(self)
end

function ThronerewardView:buildUI()
	ThronerewardView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
end

function ThronerewardView:bindEvents()
	ThronerewardView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
end

function ThronerewardView:unbindEvents()
	ThronerewardView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ThronerewardView:destroyUI()
	ThronerewardView.super.destroyUI(self)
end

function ThronerewardView:onEnter()
	ThronerewardView.super.onEnter(self)
	GlobalDispatcher:addListener(ThroneController.PM_GetThronePanelOtherInfoRes, self._updateView, self)
	GlobalDispatcher:addListener(ThroneController.PM_GainThroneAchievementPrizeRes, self._updateView, self)
	self:_updateView()
end

function ThronerewardView:onEnterFinished()
	ThronerewardView.super.onEnterFinished(self)
end

function ThronerewardView:onExit()
	ThronerewardView.super.onExit(self)
	GlobalDispatcher:removeListener(ThroneController.PM_GetThronePanelOtherInfoRes, self._updateView, self)
	GlobalDispatcher:removeListener(ThroneController.PM_GainThroneAchievementPrizeRes, self._updateView, self)
end

function ThronerewardView:onExitFinished()
	ThronerewardView.super.onExitFinished(self)
end

function ThronerewardView:_onClickcloseBtn()
	self:close()
end

function ThronerewardView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function ThronerewardView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, ThronerewardItem)

	component:onEnter(data, self._getIdKeyList[data.id])
end

function ThronerewardView:_clearTableview(cell)
	return
end

function ThronerewardView:_updateView()
	self._getIdKeyList = ThroneModel.instance:getAchievementPrizeArr()

	local list = ThroneConfig.instance:getAchievementCfgs()
	local firstList = {}
	local lastList = {}

	for i, v in ipairs(list) do
		if self._getIdKeyList[v.id] then
			table.insert(lastList, v)
		else
			table.insert(firstList, v)
		end
	end

	for i, v in ipairs(lastList) do
		table.insert(firstList, v)
	end

	self._curViewDatas = firstList

	self:reloadData()
end

return ThronerewardView
