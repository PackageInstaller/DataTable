-- chunkname: @modules/versionactivitybase/fixed/enterview/view/VersionActivityFixedEnterViewTabItem2.lua

module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterViewTabItem2", package.seeall)

local VersionActivityFixedEnterViewTabItem2 = class("VersionActivityFixedEnterViewTabItem2", VersionActivityFixedEnterViewTabItemBase)

function VersionActivityFixedEnterViewTabItem2:_editableInitView()
	VersionActivityFixedEnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivityFixedEnterViewTabItem2:afterSetData()
	VersionActivityFixedEnterViewTabItem2.super.afterSetData(self)

	local singleLineHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self.txtName, " ")

	if self.activityCo then
		self.txtName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtNameEn.text = self.activityCo.nameEn or ""
	end

	ZProj.UGUIHelper.RebuildLayout(self.txtName.transform)

	local nameheight = self.txtName.preferredHeight
	local layoutElement = self.go:GetComponent(typeof(UnityEngine.UI.LayoutElement))

	layoutElement.minHeight = layoutElement.minHeight + nameheight - singleLineHeight
end

function VersionActivityFixedEnterViewTabItem2:childRefreshSelect(actId)
	VersionActivityFixedEnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)

	local enColor = GameUtil.parseColor(tabSetting.enColor)

	enColor.a = tabSetting.enAlpha or 1
	self.txtNameEn.color = enColor
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivityFixedEnterViewTabItem2
