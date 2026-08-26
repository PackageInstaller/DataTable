-- chunkname: @modules/logic/versionactivity1_8/enter/view/VersionActivity1_8EnterViewTabItem1.lua

module("modules.logic.versionactivity1_8.enter.view.VersionActivity1_8EnterViewTabItem1", package.seeall)

local VersionActivity1_8EnterViewTabItem1 = class("VersionActivity1_8EnterViewTabItem1", VersionActivity1_8EnterViewTabItemBase)

function VersionActivity1_8EnterViewTabItem1:_editableInitView()
	VersionActivity1_8EnterViewTabItem1.super._editableInitView(self)

	self.simageSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_select/#simage_tabimg")
	self.simageUnSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_unselect/#simage_tabimg")
end

function VersionActivity1_8EnterViewTabItem1:afterSetData()
	VersionActivity1_8EnterViewTabItem1.super.afterSetData(self)

	if not self.actId then
		return
	end

	local tabSetting = VersionActivity1_8Enum.TabSetting
	local selectImgPath = tabSetting.select.act2TabImg[self.actId]
	local unselectImgPath = tabSetting.unselect.act2TabImg[self.actId]

	self:setTabImg("simageSelectTabImg", selectImgPath)
	self:setTabImg("simageUnSelectTabImg", unselectImgPath)
end

function VersionActivity1_8EnterViewTabItem1:setTabImg(comName, path)
	if string.nilorempty(comName) or string.nilorempty(path) or not self[comName] then
		return
	end

	self[comName]:LoadImage(path)
end

function VersionActivity1_8EnterViewTabItem1:dispose()
	self.simageSelectTabImg:UnLoadImage()
	self.simageUnSelectTabImg:UnLoadImage()
	VersionActivity1_8EnterViewTabItem1.super.dispose(self)
end

return VersionActivity1_8EnterViewTabItem1
