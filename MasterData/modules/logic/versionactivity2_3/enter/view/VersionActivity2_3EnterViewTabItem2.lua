-- chunkname: @modules/logic/versionactivity2_3/enter/view/VersionActivity2_3EnterViewTabItem2.lua

module("modules.logic.versionactivity2_3.enter.view.VersionActivity2_3EnterViewTabItem2", package.seeall)

local VersionActivity2_3EnterViewTabItem2 = class("VersionActivity2_3EnterViewTabItem2", VersionActivity2_3EnterViewTabItemBase)

function VersionActivity2_3EnterViewTabItem2:_editableInitView()
	VersionActivity2_3EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity2_3EnterViewTabItem2:afterSetData()
	VersionActivity2_3EnterViewTabItem2.super.afterSetData(self)

	if self.activityCo then
		self.txtName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtNameEn.text = self.activityCo.nameEn or ""
	end
end

function VersionActivity2_3EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity2_3EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivity2_3Enum.TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivity2_3Enum.TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)
	self.txtNameEn.color = GameUtil.parseColor(tabSetting.enColor)
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivity2_3EnterViewTabItem2
