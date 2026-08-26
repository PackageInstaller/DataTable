-- chunkname: @modules/logic/versionactivity1_7/enter/view/VersionActivity1_7EnterViewTabItem1.lua

module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewTabItem1", package.seeall)

local VersionActivity1_7EnterViewTabItem1 = class("VersionActivity1_7EnterViewTabItem1", VersionActivity1_7EnterViewBaseTabItem)

function VersionActivity1_7EnterViewTabItem1:_editableInitView()
	VersionActivity1_7EnterViewTabItem1.super._editableInitView(self)

	self.simageSelectTabImg = gohelper.findChildSingleImage(self.rootGo, "#go_select/#simage_tabimg")
	self.simageUnSelectTabImg = gohelper.findChildSingleImage(self.rootGo, "#go_unselect/#simage_tabimg")

	self.simageSelectTabImg:LoadImage(VersionActivity1_7Enum.ActId2SelectImgPath[self.actId])
	self.simageUnSelectTabImg:LoadImage(VersionActivity1_7Enum.ActId2UnSelectImgPath[self.actId])
end

function VersionActivity1_7EnterViewTabItem1:dispose()
	self.simageSelectTabImg:UnLoadImage()
	self.simageUnSelectTabImg:UnLoadImage()
	VersionActivity1_7EnterViewTabItem1.super.dispose(self)
end

return VersionActivity1_7EnterViewTabItem1
