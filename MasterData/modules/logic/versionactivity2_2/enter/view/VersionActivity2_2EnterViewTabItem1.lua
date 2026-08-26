-- chunkname: @modules/logic/versionactivity2_2/enter/view/VersionActivity2_2EnterViewTabItem1.lua

module("modules.logic.versionactivity2_2.enter.view.VersionActivity2_2EnterViewTabItem1", package.seeall)

local VersionActivity2_2EnterViewTabItem1 = class("VersionActivity2_2EnterViewTabItem1", VersionActivity2_2EnterViewTabItemBase)

function VersionActivity2_2EnterViewTabItem1:_editableInitView()
	VersionActivity2_2EnterViewTabItem1.super._editableInitView(self)

	self.simageSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_select/#simage_tabimg")
	self.simageUnSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_unselect/#simage_tabimg")
end

function VersionActivity2_2EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity2_2EnterViewTabItem1:afterSetData()
	VersionActivity2_2EnterViewTabItem1.super.afterSetData(self)

	if not self.actId then
		return
	end

	local tabSetting = VersionActivity2_2Enum.TabSetting
	local selectImgPath = tabSetting.select.act2TabImg[self.actId]
	local unselectImgPath = tabSetting.unselect.act2TabImg[self.actId]

	self:setTabImg("simageSelectTabImg", selectImgPath)
	self:setTabImg("simageUnSelectTabImg", unselectImgPath)
end

function VersionActivity2_2EnterViewTabItem1:setTabImg(comName, path)
	if string.nilorempty(comName) or string.nilorempty(path) or not self[comName] then
		return
	end

	self[comName]:LoadImage(path)
end

function VersionActivity2_2EnterViewTabItem1:dispose()
	self.simageSelectTabImg:UnLoadImage()
	self.simageUnSelectTabImg:UnLoadImage()
	VersionActivity2_2EnterViewTabItem1.super.dispose(self)
end

return VersionActivity2_2EnterViewTabItem1
