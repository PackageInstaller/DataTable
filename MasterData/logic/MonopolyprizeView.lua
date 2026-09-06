-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monopoly/view/MonopolyprizeView.lua

module("logic.extensions.monopoly.view.MonopolyprizeView", package.seeall)

local MonopolyprizeView = class("MonopolyprizeView", TableViewComponent)

function MonopolyprizeView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "scrollView"
	}
end

function MonopolyprizeView:ctor()
	MonopolyprizeView.super.ctor(self)
end

function MonopolyprizeView:buildUI()
	MonopolyprizeView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
end

function MonopolyprizeView:bindEvents()
	MonopolyprizeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function MonopolyprizeView:unbindEvents()
	MonopolyprizeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function MonopolyprizeView:destroyUI()
	MonopolyprizeView.super.destroyUI(self)
end

function MonopolyprizeView:onEnter()
	MonopolyprizeView.super.onEnter(self)

	local activityId = MonopolyModel.instance:getActivityId()
	local planId = MonopolyConfig.instance:getMonopolyConfigById(activityId).planId

	self._curViewDatas = MonopolyConfig.instance:getExtraBonus(planId)

	self:reloadData()
end

function MonopolyprizeView:onEnterFinished()
	MonopolyprizeView.super.onEnterFinished(self)
end

function MonopolyprizeView:onExit()
	MonopolyprizeView.super.onExit(self)
end

function MonopolyprizeView:onExitFinished()
	MonopolyprizeView.super.onExitFinished(self)
end

function MonopolyprizeView:_updateCell(view, cell, data)
	local reward = string.split(data.reward, "#")

	for i = 1, 5 do
		local itemPoint = goutil.findChild(cell.gameObject, "itemPoint_" .. i)

		if i <= #reward then
			goutil.setActive(itemPoint, true)
			MaterialMgr.setCellByCfg(reward[i], itemPoint)
		else
			goutil.setActive(itemPoint, false)
		end
	end

	local txtRound = goutil.findChildTextComponent(cell.gameObject, "txtRound")

	txtRound.text = string.format("第%s圈", data.round)
end

function MonopolyprizeView:_clearTableview(cell)
	for i = 1, 5 do
		local itemPoint = goutil.findChild(cell.gameObject, "itemPoint_" .. i)

		MaterialMgr.resetAll(itemPoint)
	end
end

return MonopolyprizeView
