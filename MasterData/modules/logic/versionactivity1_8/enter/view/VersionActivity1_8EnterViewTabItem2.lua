-- chunkname: @modules/logic/versionactivity1_8/enter/view/VersionActivity1_8EnterViewTabItem2.lua

module("modules.logic.versionactivity1_8.enter.view.VersionActivity1_8EnterViewTabItem2", package.seeall)

local VersionActivity1_8EnterViewTabItem2 = class("VersionActivity1_8EnterViewTabItem2", VersionActivity1_8EnterViewTabItemBase)

function VersionActivity1_8EnterViewTabItem2:_editableInitView()
	VersionActivity1_8EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_nameen")
end

function VersionActivity1_8EnterViewTabItem2:afterSetData()
	VersionActivity1_8EnterViewTabItem2.super.afterSetData(self)

	if self.activityCo then
		self.txtName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtNameEn.text = self.activityCo.nameEn or ""
	end
end

function VersionActivity1_8EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity1_8EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivity1_8Enum.TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivity1_8Enum.TabSetting.select
	end

	self.txtName.color = tabSetting.color
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivity1_8EnterViewTabItem2
