-- chunkname: @modules/versionactivitybase/fixed/enterview/view/VersionActivityFixedEnterViewTabItem1.lua

module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterViewTabItem1", package.seeall)

local VersionActivityFixedEnterViewTabItem1 = class("VersionActivityFixedEnterViewTabItem1", VersionActivityFixedEnterViewTabItemBase)

function VersionActivityFixedEnterViewTabItem1:_editableInitView()
	VersionActivityFixedEnterViewTabItem1.super._editableInitView(self)

	self.simageSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_select/#simage_tabimg")
	self.simageUnSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_unselect/#simage_tabimg")
end

function VersionActivityFixedEnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivityFixedEnterViewTabItem1:afterSetData()
	VersionActivityFixedEnterViewTabItem1.super.afterSetData(self)

	if not self.actId then
		return
	end

	local tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting
	local selectImgPath = tabSetting.select.act2TabImg[self.actId]
	local unselectImgPath = tabSetting.unselect.act2TabImg[self.actId]

	self:setTabImg("simageSelectTabImg", selectImgPath)
	self:setTabImg("simageUnSelectTabImg", unselectImgPath)
end

function VersionActivityFixedEnterViewTabItem1:setTabImg(comName, path)
	if string.nilorempty(comName) or string.nilorempty(path) or not self[comName] then
		return
	end

	self[comName]:LoadImage(path)
end

function VersionActivityFixedEnterViewTabItem1:dispose()
	if self.simageSelectTabImg then
		self.simageSelectTabImg:UnLoadImage()
	end

	if self.simageUnSelectTabImg then
		self.simageUnSelectTabImg:UnLoadImage()
	end

	VersionActivityFixedEnterViewTabItem1.super.dispose(self)
end

return VersionActivityFixedEnterViewTabItem1
