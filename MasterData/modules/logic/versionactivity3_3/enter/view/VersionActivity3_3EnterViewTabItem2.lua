-- chunkname: @modules/logic/versionactivity3_3/enter/view/VersionActivity3_3EnterViewTabItem2.lua

module("modules.logic.versionactivity3_3.enter.view.VersionActivity3_3EnterViewTabItem2", package.seeall)

local VersionActivity3_3EnterViewTabItem2 = class("VersionActivity3_3EnterViewTabItem2", VersionActivity3_3EnterViewTabItemBase)

function VersionActivity3_3EnterViewTabItem2:_editableInitView()
	VersionActivity3_3EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity3_3EnterViewTabItem2:afterSetData()
	VersionActivity3_3EnterViewTabItem2.super.afterSetData(self)

	if self.activityCo then
		self.txtName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtNameEn.text = self.activityCo.nameEn or ""
	end

	local width = self.txtName.preferredWidth
	local defaultTextWidth = 132
	local defalutPreferredWidth = 300

	if defaultTextWidth < width then
		local layoutComp = self.go:GetComponent(typeof(UnityEngine.UI.LayoutElement))

		if layoutComp then
			layoutComp.preferredWidth = defalutPreferredWidth + (width - defaultTextWidth)
		end
	end
end

function VersionActivity3_3EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity3_3EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivity3_3Enum.TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivity3_3Enum.TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)

	local enColor = GameUtil.parseColor(tabSetting.enColor)

	enColor.a = tabSetting.enAlpha or 1
	self.txtNameEn.color = enColor
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivity3_3EnterViewTabItem2
