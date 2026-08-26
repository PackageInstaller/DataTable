-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationDestinyItem_DescItem2.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDestinyItem_DescItem2", package.seeall)

local VersionActivity2_3NewCultivationDestinyItem_DescItem2 = class("VersionActivity2_3NewCultivationDestinyItem_DescItem2", VersionActivity2_3NewCultivationDestinyItem_DescItem_Base)

function VersionActivity2_3NewCultivationDestinyItem_DescItem2:onInitView()
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationDestinyItem_DescItem2:addEvents()
	return
end

function VersionActivity2_3NewCultivationDestinyItem_DescItem2:removeEvents()
	return
end

function VersionActivity2_3NewCultivationDestinyItem_DescItem2:ctor(ctorParam)
	self:__onInit()
	VersionActivity2_3NewCultivationDestinyItem_DescItem2.super.ctor(self, ctorParam)
end

function VersionActivity2_3NewCultivationDestinyItem_DescItem2:onDestroyView()
	VersionActivity2_3NewCultivationDestinyItem_DescItem2.super.onDestroyView(self)
	self:__onDispose()
end

return VersionActivity2_3NewCultivationDestinyItem_DescItem2
