-- chunkname: @modules/logic/versionactivity2_1/enter/view/VersionActivity2_1EnterViewTabItem1.lua

module("modules.logic.versionactivity2_1.enter.view.VersionActivity2_1EnterViewTabItem1", package.seeall)

local VersionActivity2_1EnterViewTabItem1 = class("VersionActivity2_1EnterViewTabItem1", VersionActivity2_1EnterViewTabItemBase)

function VersionActivity2_1EnterViewTabItem1:_editableInitView()
	VersionActivity2_1EnterViewTabItem1.super._editableInitView(self)

	self.simageSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_select/#simage_tabimg")
	self.simageUnSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_unselect/#simage_tabimg")
end

function VersionActivity2_1EnterViewTabItem1:afterSetData()
	VersionActivity2_1EnterViewTabItem1.super.afterSetData(self)

	if not self.actId then
		return
	end

	local tabSetting = VersionActivity2_1Enum.TabSetting
	local selectImgPath = tabSetting.select.act2TabImg[self.actId]
	local unselectImgPath = tabSetting.unselect.act2TabImg[self.actId]

	self:setTabImg("simageSelectTabImg", selectImgPath)
	self:setTabImg("simageUnSelectTabImg", unselectImgPath)
end

function VersionActivity2_1EnterViewTabItem1:setTabImg(comName, path)
	if string.nilorempty(comName) or string.nilorempty(path) or not self[comName] then
		return
	end

	self[comName]:LoadImage(path)
end

function VersionActivity2_1EnterViewTabItem1:dispose()
	self.simageSelectTabImg:UnLoadImage()
	self.simageUnSelectTabImg:UnLoadImage()
	VersionActivity2_1EnterViewTabItem1.super.dispose(self)
end

return VersionActivity2_1EnterViewTabItem1
