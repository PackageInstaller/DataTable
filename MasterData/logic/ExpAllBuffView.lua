-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpAllBuffView.lua

module("logic.extensions.expedition.view.ExpAllBuffView", package.seeall)

local ExpAllBuffView = class("ExpAllBuffView", TableViewComponent)

function ExpAllBuffView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "ScrollView"
	}
end

function ExpAllBuffView:ctor()
	ExpAllBuffView.super.ctor(self)

	self._curViewDatas = {}
end

function ExpAllBuffView:onExitFinished()
	ExpAllBuffView.super.onExitFinished(self)
	self._tableview:Travel(function(cell)
		local comp = BuffCard.AddOnce(cell)

		comp:clearImage()
	end, nil, true)
end

function ExpAllBuffView:unbindEvents()
	ExpAllBuffView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ExpAllBuffView:bindEvents()
	ExpAllBuffView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ExpAllBuffView:buildUI()
	ExpAllBuffView.super.buildUI(self)

	self._closeButton = self:getBtn("title/btnRtn")
	self._detailCard = self:getGo("detail")

	self._detailCard:SetActive(false)
end

function ExpAllBuffView:onEnter()
	ExpAllBuffView.super.onEnter(self)
	self:_RefreshList()
end

function ExpAllBuffView:_onClickClose()
	self:close()
end

function ExpAllBuffView:_RefreshList()
	self._curViewDatas = {}
	self._curViewDatas = ExpeditionModel.instance:getBuffIds() or {}

	table.sort(self._curViewDatas, function(x, y)
		local cfgX = ExpeditionConfig.instance:getBuffCfg(x)
		local cfgY = ExpeditionConfig.instance:getBuffCfg(y)

		return cfgX.quality > cfgY.quality
	end)
	self._tableview:ReloadData()
end

function ExpAllBuffView:_updateCell(view, cell, data)
	local comp = BuffCard.AddOnce(cell)

	comp:setId(data)
	comp:setClickCallBack(function()
		return
	end)
end

function ExpAllBuffView:_showDetailCard(id)
	local comp = BuffCard.AddOnce(self._detailCard)

	comp:setId(id)
	comp:setClickCallBack(function()
		comp:clearImage()
		self._detailCard:SetActive(false)
	end)
	self._detailCard:SetActive(true)
end

return ExpAllBuffView
