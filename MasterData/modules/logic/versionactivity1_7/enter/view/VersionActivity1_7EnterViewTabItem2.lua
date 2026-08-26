-- chunkname: @modules/logic/versionactivity1_7/enter/view/VersionActivity1_7EnterViewTabItem2.lua

module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewTabItem2", package.seeall)

local VersionActivity1_7EnterViewTabItem2 = class("VersionActivity1_7EnterViewTabItem2", VersionActivity1_7EnterViewBaseTabItem)

function VersionActivity1_7EnterViewTabItem2:_editableInitView()
	VersionActivity1_7EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.rootGo, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.rootGo, "#txt_nameen")
	self.txtName.text = self.activityCo.name
	self.txtNameEn.text = self.activityCo.nameEn
end

function VersionActivity1_7EnterViewTabItem2:refreshSelect(actId)
	VersionActivity1_7EnterViewTabItem2.super.refreshSelect(self, actId)

	local select = actId == self.actId

	if select then
		self.txtName.color = VersionActivity1_7Enum.ActivityNameColor.Select or VersionActivity1_7Enum.ActivityNameColor.UnSelect
	end

	if select then
		self.txtName.fontSize = VersionActivity1_7Enum.ActivityNameFontSize.Select or VersionActivity1_7Enum.ActivityNameFontSize.UnSelect
	end

	if select then
		self.txtNameEn.fontSize = VersionActivity1_7Enum.ActivityNameEnFontSize.Select or VersionActivity1_7Enum.ActivityNameEnFontSize.UnSelect
	end
end

return VersionActivity1_7EnterViewTabItem2
