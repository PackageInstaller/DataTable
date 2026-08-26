-- chunkname: @modules/logic/versionactivity2_1/enter/view/VersionActivity2_1EnterViewTabItem2.lua

module("modules.logic.versionactivity2_1.enter.view.VersionActivity2_1EnterViewTabItem2", package.seeall)

local VersionActivity2_1EnterViewTabItem2 = class("VersionActivity2_1EnterViewTabItem2", VersionActivity2_1EnterViewTabItemBase)

function VersionActivity2_1EnterViewTabItem2:_editableInitView()
	VersionActivity2_1EnterViewTabItem2.super._editableInitView(self)

	self.goselect = gohelper.findChild(self.go, "#go_unselect")
	self.gounselect = gohelper.findChild(self.go, "#go_unselect")
	self.txtselectName = gohelper.findChildText(self.go, "#go_select/#txt_name")
	self.txtselectNameEn = gohelper.findChildText(self.go, "#go_select/#txt_nameen")
	self.txtunselectName = gohelper.findChildText(self.go, "#go_unselect/#txt_name")
	self.txtunselectNameEn = gohelper.findChildText(self.go, "#go_unselect/#txt_nameen")
end

function VersionActivity2_1EnterViewTabItem2:afterSetData()
	VersionActivity2_1EnterViewTabItem2.super.afterSetData(self)

	if self.activityCo then
		self.txtselectName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtselectNameEn.text = self.activityCo.nameEn or ""
	end

	if self.activityCo then
		self.txtunselectName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtunselectNameEn.text = self.activityCo.nameEn or ""
	end
end

function VersionActivity2_1EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity2_1EnterViewTabItem2.super.childRefreshSelect(self, actId)
	gohelper.setActive(self.goselect, self.isSelect)
	gohelper.setActive(self.gounselect, not self.isSelect)
end

return VersionActivity2_1EnterViewTabItem2
