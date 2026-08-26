-- chunkname: @modules/logic/versionactivity2_5/enter/view/VersionActivity2_5EnterViewTabItem2.lua

module("modules.logic.versionactivity2_5.enter.view.VersionActivity2_5EnterViewTabItem2", package.seeall)

local VersionActivity2_5EnterViewTabItem2 = class("VersionActivity2_5EnterViewTabItem2", VersionActivity2_5EnterViewTabItemBase)

function VersionActivity2_5EnterViewTabItem2:_editableInitView()
	VersionActivity2_5EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity2_5EnterViewTabItem2:afterSetData()
	VersionActivity2_5EnterViewTabItem2.super.afterSetData(self)

	if self.activityCo then
		self.txtName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtNameEn.text = self.activityCo.nameEn or ""
	end
end

function VersionActivity2_5EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity2_5EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivity2_5Enum.TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivity2_5Enum.TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)
	self.txtNameEn.color = GameUtil.parseColor(tabSetting.enColor)
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivity2_5EnterViewTabItem2
