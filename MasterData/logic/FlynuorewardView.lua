-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuorewardView.lua

module("logic.extensions.flyingnuo.view.FlynuorewardView", package.seeall)

local FlynuorewardView = class("FlynuorewardView", TableViewComponent)

function FlynuorewardView:ctor()
	FlynuorewardView.super.ctor(self)
end

function FlynuorewardView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FlynuorewardView:buildUI()
	FlynuorewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function FlynuorewardView:bindEvents()
	FlynuorewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function FlynuorewardView:unbindEvents()
	FlynuorewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FlynuorewardView:destroyUI()
	FlynuorewardView.super.destroyUI(self)
end

function FlynuorewardView:onEnter()
	FlynuorewardView.super.onEnter(self)
	self:_updateView()
end

function FlynuorewardView:onEnterFinished()
	FlynuorewardView.super.onEnterFinished(self)
end

function FlynuorewardView:onExit()
	FlynuorewardView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)
end

function FlynuorewardView:onExitFinished()
	FlynuorewardView.super.onExitFinished(self)
end

function FlynuorewardView:_updateView()
	self._activityId = self:getFirstParam()

	local cfg = FlyNuoConfig.instance:getActivityCfgById(self._activityId)
	local prizeCfgs = FlyNuoConfig.instance:getPrizeCfg(cfg.prizePlan)

	self._curViewDatas = {}

	for k, v in pairs(prizeCfgs) do
		table.insert(self._curViewDatas, v)
	end

	table.sort(self._curViewDatas, function(a, b)
		return a.leftScore > b.leftScore
	end)
	self:reloadData()
end

function FlynuorewardView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, FlynuorewardItem)
	local nextData = self._curViewDatas[cell.data - 1]

	component:onEnter(data, nextData)
end

function FlynuorewardView:_clearTableview(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, FlynuorewardItem)

	component:onExit()
end

return FlynuorewardView
