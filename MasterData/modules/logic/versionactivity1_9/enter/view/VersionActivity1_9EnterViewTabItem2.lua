-- chunkname: @modules/logic/versionactivity1_9/enter/view/VersionActivity1_9EnterViewTabItem2.lua

module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterViewTabItem2", package.seeall)

local VersionActivity1_9EnterViewTabItem2 = class("VersionActivity1_9EnterViewTabItem2", VersionActivity1_9EnterViewBaseTabItem)

function VersionActivity1_9EnterViewTabItem2:_editableInitView()
	self.txtName = gohelper.findChildText(self.rootGo, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.rootGo, "#txt_nameen")

	VersionActivity1_9EnterViewTabItem2.super._editableInitView(self)
end

function VersionActivity1_9EnterViewTabItem2:refreshData()
	VersionActivity1_9EnterViewTabItem2.super.refreshData(self)

	self.txtName.text = self.activityCo.name
	self.txtNameEn.text = self.activityCo.nameEn
end

function VersionActivity1_9EnterViewTabItem2:refreshSelect(actId)
	VersionActivity1_9EnterViewTabItem2.super.refreshSelect(self, actId)

	local select = actId == self.actId

	if select then
		self.txtName.color = VersionActivity1_9Enum.ActivityNameColor.Select or VersionActivity1_9Enum.ActivityNameColor.UnSelect
	end

	if select then
		self.txtName.fontSize = VersionActivity1_9Enum.ActivityNameFontSize.Select or VersionActivity1_9Enum.ActivityNameFontSize.UnSelect
	end

	if select then
		self.txtNameEn.fontSize = VersionActivity1_9Enum.ActivityNameEnFontSize.Select or VersionActivity1_9Enum.ActivityNameEnFontSize.UnSelect
	end
end

return VersionActivity1_9EnterViewTabItem2
