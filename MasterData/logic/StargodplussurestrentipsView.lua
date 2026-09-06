-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplussurestrentipsView.lua

module("logic.extensions.stargodplus.view.StargodplussurestrentipsView", package.seeall)

local StargodplussurestrentipsView = class("StargodplussurestrentipsView", TableViewComponent)

function StargodplussurestrentipsView:ctor()
	StargodplussurestrentipsView.super.ctor(self)
end

function StargodplussurestrentipsView:buildUI()
	StargodplussurestrentipsView.super.buildUI(self)

	self._cancelBtn = self:getBtn("viewBg/cancelBtn")
	self._sureBtn = self:getBtn("viewBg/sureBtn")
end

function StargodplussurestrentipsView:bindEvents()
	StargodplussurestrentipsView.super.bindEvents(self)
	self._cancelBtn:AddClickListener(self._onClickcancelBtn, self)
	self._sureBtn:AddClickListener(self._onClicksureBtn, self)
end

function StargodplussurestrentipsView:unbindEvents()
	StargodplussurestrentipsView.super.unbindEvents(self)
	self._cancelBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
end

function StargodplussurestrentipsView:destroyUI()
	StargodplussurestrentipsView.super.destroyUI(self)
end

function StargodplussurestrentipsView:onEnter()
	StargodplussurestrentipsView.super.onEnter(self)

	local params = self:getOpenParam()

	self._curViewDatas = params[1]
	self._okFunc = params[2]

	self:reloadData()
end

function StargodplussurestrentipsView:onEnterFinished()
	StargodplussurestrentipsView.super.onEnterFinished(self)
end

function StargodplussurestrentipsView:onExit()
	StargodplussurestrentipsView.super.onExit(self)
end

function StargodplussurestrentipsView:onExitFinished()
	StargodplussurestrentipsView.super.onExitFinished(self)
end

function StargodplussurestrentipsView:_onClickcancelBtn()
	self:close()
end

function StargodplussurestrentipsView:_onClicksureBtn()
	if self._okFunc then
		self._okFunc()
	end

	self:close()
end

function StargodplussurestrentipsView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function StargodplussurestrentipsView:_cellSize(view, index)
	return 100, 100
end

function StargodplussurestrentipsView:_updateCell(view, cell, data)
	local itemcon = goutil.findChild(cell.gameObject, "itemcon")
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local nameTextChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)

	nameText.text = data.mo:getName()

	nameTextChange:SetState(data.mo:getQuality())

	local proxy = MaterialMgr.setCellByMo(data.mo, itemcon)

	proxy.binder:setNum(0)
end

function StargodplussurestrentipsView:_clearTableview(cell)
	local itemcon = goutil.findChild(cell.gameObject, "itemcon")

	MaterialMgr.resetAll(itemcon)
end

return StargodplussurestrentipsView
