-- chunkname: @modules/logic/versionactivity2_4/enter/view/VersionActivity2_4EnterViewTabItem1.lua

module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterViewTabItem1", package.seeall)

local VersionActivity2_4EnterViewTabItem1 = class("VersionActivity2_4EnterViewTabItem1", VersionActivity2_4EnterViewTabItemBase)

function VersionActivity2_4EnterViewTabItem1:_editableInitView()
	VersionActivity2_4EnterViewTabItem1.super._editableInitView(self)

	self.simageSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_select/#simage_tabimg")
	self._goUnSelectTab = gohelper.findChild(self.go, "#go_unselect/#simage_tabimg")
	self.simageUnSelectTabImg = self._goUnSelectTab:GetComponent(typeof(SLFramework.UGUI.SingleImage))
end

function VersionActivity2_4EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity2_4EnterViewTabItem1:afterSetData()
	VersionActivity2_4EnterViewTabItem1.super.afterSetData(self)

	if not self.actId then
		return
	end

	local tabSetting = VersionActivity2_4Enum.TabSetting
	local selectImgPath = tabSetting.select.act2TabImg[self.actId]
	local unselectImgPath = tabSetting.unselect.act2TabImg[self.actId]

	self:setTabImg("simageSelectTabImg", selectImgPath)

	if unselectImgPath then
		self:setTabImg("simageUnSelectTabImg", unselectImgPath)
	end
end

function VersionActivity2_4EnterViewTabItem1:setTabImg(comName, path)
	if string.nilorempty(comName) or string.nilorempty(path) or not self[comName] then
		return
	end

	self[comName]:LoadImage(path)
end

function VersionActivity2_4EnterViewTabItem1:dispose()
	if self.simageSelectTabImg then
		self.simageSelectTabImg:UnLoadImage()
	end

	if self.simageUnSelectTabImg then
		self.simageUnSelectTabImg:UnLoadImage()
	end

	VersionActivity2_4EnterViewTabItem1.super.dispose(self)
end

return VersionActivity2_4EnterViewTabItem1
