-- chunkname: @modules/logic/versionactivity3_3/enter/view/VersionActivity3_3EnterViewTabItem1.lua

module("modules.logic.versionactivity3_3.enter.view.VersionActivity3_3EnterViewTabItem1", package.seeall)

local VersionActivity3_3EnterViewTabItem1 = class("VersionActivity3_3EnterViewTabItem1", VersionActivity3_3EnterViewTabItemBase)

function VersionActivity3_3EnterViewTabItem1:_editableInitView()
	VersionActivity3_3EnterViewTabItem1.super._editableInitView(self)

	self.simageSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_select/#simage_tabimg")
	self.simageUnSelectTabImg = gohelper.findChildSingleImage(self.go, "#go_unselect/#simage_tabimg")
end

function VersionActivity3_3EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity3_3EnterViewTabItem1:afterSetData()
	VersionActivity3_3EnterViewTabItem1.super.afterSetData(self)

	if not self.actId then
		return
	end

	local tabSetting = VersionActivity3_3Enum.TabSetting
	local selectImgPath = tabSetting.select.act2TabImg[self.actId]
	local unselectImgPath = tabSetting.unselect.act2TabImg[self.actId]

	self:setTabImg("simageSelectTabImg", selectImgPath)
	self:setTabImg("simageUnSelectTabImg", unselectImgPath)
end

function VersionActivity3_3EnterViewTabItem1:setTabImg(comName, path)
	if string.nilorempty(comName) or string.nilorempty(path) or not self[comName] then
		return
	end

	self[comName]:LoadImage(path)
end

function VersionActivity3_3EnterViewTabItem1:dispose()
	self.simageSelectTabImg:UnLoadImage()
	self.simageUnSelectTabImg:UnLoadImage()
	VersionActivity3_3EnterViewTabItem1.super.dispose(self)
end

return VersionActivity3_3EnterViewTabItem1
