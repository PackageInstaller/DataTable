-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyIconView.lua

module("logic.extensions.family.view.FamilyIconView", package.seeall)

local FamilyIconView = class("FamilyIconView", TableViewComponent)

function FamilyIconView:ctor()
	FamilyIconView.super.ctor(self)
end

function FamilyIconView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilyIconView:destroyUI()
	FamilyIconView.super.destroyUI(self)
end

function FamilyIconView:onExitFinished()
	FamilyIconView.super.onExitFinished(self)
end

function FamilyIconView:onEnterFinished()
	FamilyIconView.super.onEnterFinished(self)
end

function FamilyIconView:unbindEvents()
	FamilyIconView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function FamilyIconView:bindEvents()
	FamilyIconView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function FamilyIconView:onExit()
	FamilyIconView.super.onExit(self)
end

function FamilyIconView:buildUI()
	FamilyIconView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
end

function FamilyIconView:onEnter()
	FamilyIconView.super.onEnter(self)

	local params = self:getOpenParam()

	self._settingInfo = params[1]
	self._selectedCall = params[2]
	self._selectedId = self._settingInfo.iconId
	self._curViewDatas = {}

	for i = 0, checknumber(FamilyConfig.instance:getCommonValue("FAMILY_ICON_NUM")) - 1 do
		table.insert(self._curViewDatas, i)
	end

	self:reloadData()
end

function FamilyIconView:_onClickClose()
	self:close()
end

function FamilyIconView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local imgChange = goutil.findChildComponent(container, "headIcon", "UIImageSpriteChange")
	local selected = goutil.findChild(container, "selected")
	local used = goutil.findChild(container, "used")
	local btn = Framework.ButtonAdapter.Get(container)

	btn:AddClickListener(function()
		self:_onClickIcon(data)
	end, self)
	imgChange:SetState(data)
	goutil.setActive(selected, data == self._selectedId)

	local settingInfo = FamilyModel.instance:getMyFamilySettingInfo()

	goutil.setActive(used, settingInfo and settingInfo.iconId == data)
end

function FamilyIconView:_onClickIcon(iconId)
	self._selectedId = iconId

	self:reloadData()
end

function FamilyIconView:_onClickSure()
	self:close()

	if self._selectedCall then
		self._selectedCall(self._selectedId)
	end
end

return FamilyIconView
