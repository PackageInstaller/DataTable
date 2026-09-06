-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/ScbonusawardView.lua

module("logic.extensions.scenariocopy.view.ScbonusawardView", package.seeall)

local ScbonusawardView = class("ScbonusawardView", ViewComponent)

function ScbonusawardView:ctor()
	ScbonusawardView.super.ctor(self)
end

function ScbonusawardView:buildUI()
	ScbonusawardView.super.buildUI(self)

	self._tableGo = self:getGo("tableview")
	self._itemGo = self:getGo("tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("btnClose")
end

function ScbonusawardView:bindEvents()
	ScbonusawardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ScbonusawardView:unbindEvents()
	ScbonusawardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ScbonusawardView:destroyUI()
	ScbonusawardView.super.destroyUI(self)
end

function ScbonusawardView:onEnter()
	ScbonusawardView.super.onEnter(self)

	self._buffPlanId = self:getOpenParam()[1]

	local cfgs = ScenariocopyConfig.instance:getBuffCfg(self._buffPlanId)

	if cfgs then
		self._buffList = {}

		for k, v in pairs(cfgs) do
			if checknumber(v.level > 0) then
				table.insert(self._buffList, v)
			end
		end

		table.sort(self._buffList, function(a, b)
			return a.level < b.level
		end)
		self:_refresh()
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("缺buff %s配置, self._buffPlanId"), GameUtil.handler(self.close, self))

		return
	end
end

function ScbonusawardView:onEnterFinished()
	ScbonusawardView.super.onEnterFinished(self)
end

function ScbonusawardView:onExit()
	ScbonusawardView.super.onExit(self)
	self._tableview:dispose()
end

function ScbonusawardView:onExitFinished()
	ScbonusawardView.super.onExitFinished(self)
end

function ScbonusawardView:_refresh()
	self._tableview:reloadData(self._buffList)
end

function ScbonusawardView:_updateCell(view, cell, data)
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtAdd = goutil.findChildTextComponent(cell, "txtAdd")
	local img = goutil.findChildComponent(cell, "bg", "UIImageColorChange")
	local goCur = goutil.findChild(cell, "txtCur")

	txtTime.text = langPara("第%s层", data.level)
	txtAdd.text = string.nilorempty(data.des) and "无" or data.des

	img:SetState(cell.index % 2 == 0 and 1 or 0)
	goutil.setActive(goCur, data.level == ScenariocopyModel.instance:getBuffLevel())
end

function ScbonusawardView:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

return ScbonusawardView
