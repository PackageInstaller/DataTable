-- chunkname: @modules/logic/versionactivity3_2/enter/view/VersionActivity3_2EnterViewTabItem2.lua

module("modules.logic.versionactivity3_2.enter.view.VersionActivity3_2EnterViewTabItem2", package.seeall)

local VersionActivity3_2EnterViewTabItem2 = class("VersionActivity3_2EnterViewTabItem2", VersionActivityFixedEnterViewTabItemBase)

function VersionActivity3_2EnterViewTabItem2:_editableInitView()
	VersionActivity3_2EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity3_2EnterViewTabItem2:_getTagPath()
	return "#go_tag"
end

function VersionActivity3_2EnterViewTabItem2:afterSetData()
	VersionActivity3_2EnterViewTabItem2.super.afterSetData(self)

	self.redDotIcon = RedDotController.instance:addRedDot(self.goRedDot, self.activityCo.redDotId, (VersionActivity3_2Enum.CharacterActId[self.actId] or nil) and (self.actId or self.redDotUid))

	if self.activityCo then
		self.txtName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtNameEn.text = self.activityCo.nameEn or ""
	end
end

function VersionActivity3_2EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity3_2EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)
	self.txtNameEn.color = GameUtil.parseColor(tabSetting.enColor)
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivity3_2EnterViewTabItem2
