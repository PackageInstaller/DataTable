-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/StrengthenTipsView.lua

module("logic.extensions.equipment.view.StrengthenTipsView", package.seeall)

local StrengthenTipsView = class("StrengthenTipsView", TableViewComponent)

function StrengthenTipsView:ctor()
	StrengthenTipsView.super.ctor(self)

	self.callBack = nil
end

function StrengthenTipsView:bindEvents()
	StrengthenTipsView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):AddClickListener(self.close, self)
	self.quxiaoBtn:AddClickListener(self.close, self)
	self.quedingBtn:AddClickListener(function()
		if self.callBack then
			self.callBack()
		end

		self:close()
	end, self)
end

function StrengthenTipsView:unbindEvents()
	StrengthenTipsView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):RemoveClickListener()
	GameUtil.asBtn(self.viewBoxGo):RemoveClickListener()
	self.quxiaoBtn:RemoveClickListener()
	self.quedingBtn:RemoveClickListener()
end

function StrengthenTipsView:buildUI()
	StrengthenTipsView.super.buildUI(self)

	self.viewBoxGo = self:getGo("viewBox")

	local bigViewGo = self:getGo("bigViewGo")

	self.quxiaoBtn = Framework.ButtonAdapter.GetFrom(bigViewGo, "quxiaoBtn")
	self.quedingBtn = Framework.ButtonAdapter.GetFrom(bigViewGo, "quedingBtn")
	self._txtTitle = self:getTxt("txtTitle")
end

function StrengthenTipsView:destroyUI()
	StrengthenTipsView.super.destroyUI(self)

	self._curViewDatas = nil
	self.callBack = nil
end

function StrengthenTipsView:onEnter()
	StrengthenTipsView.super.onEnter(self)

	if self._viewPresentor._openParam == nil then
		return
	end

	local title = self._viewPresentor._openParam[3]

	title = string.nilorempty(title) and lang("text_equip_desc_87") or title
	self._txtTitle.text = title
	self._curViewDatas = self._viewPresentor._openParam[1]

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		return
	end

	self.callBack = self._viewPresentor._openParam[2]

	self._tableview:ReloadData()
end

function StrengthenTipsView:_getPath()
	return {
		cellPath = "bigViewGo/itemGo",
		viewPath = "bigViewGo/itemListSR"
	}
end

function StrengthenTipsView:_cellSize()
	return 50, 50
end

function StrengthenTipsView:_updateCell(view, cell, data)
	local infoMo = PetEquipModel.instance:GetInfoMoByOnlyId(data.onlyId, data.matType)

	if infoMo == nil then
		return
	end

	local subLua = MaterialMgr.setCellByData(infoMo.matType, infoMo, cell)

	subLua.binder:setNum(data.useCount)
	subLua.binder:setAutoTips(true)
	subLua.binder:setSelected(false)
end

function StrengthenTipsView:OnClickCustomInput(hover)
	if not hover then
		self:close()
	end
end

return StrengthenTipsView
