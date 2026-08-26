-- chunkname: @modules/logic/versionactivity1_9/enter/view/VersionActivity1_9EnterViewTabItem1.lua

module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterViewTabItem1", package.seeall)

local VersionActivity1_9EnterViewTabItem1 = class("VersionActivity1_9EnterViewTabItem1", VersionActivity1_9EnterViewBaseTabItem)

function VersionActivity1_9EnterViewTabItem1:_editableInitView()
	self.simageSelectTabImg = gohelper.findChildSingleImage(self.rootGo, "#go_select/#simage_tabimg")
	self.simageUnSelectTabImg = gohelper.findChildSingleImage(self.rootGo, "#go_unselect/#simage_tabimg")

	VersionActivity1_9EnterViewTabItem1.super._editableInitView(self)
end

function VersionActivity1_9EnterViewTabItem1:refreshData()
	VersionActivity1_9EnterViewTabItem1.super.refreshData(self)
	self.simageSelectTabImg:LoadImage(VersionActivity1_9Enum.ActId2SelectImgPath[self.actId])
	self.simageUnSelectTabImg:LoadImage(VersionActivity1_9Enum.ActId2UnSelectImgPath[self.actId])
end

function VersionActivity1_9EnterViewTabItem1:dispose()
	self.simageSelectTabImg:UnLoadImage()
	self.simageUnSelectTabImg:UnLoadImage()
	VersionActivity1_9EnterViewTabItem1.super.dispose(self)
end

return VersionActivity1_9EnterViewTabItem1
