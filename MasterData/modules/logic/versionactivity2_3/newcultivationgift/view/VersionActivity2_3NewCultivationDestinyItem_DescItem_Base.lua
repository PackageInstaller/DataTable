-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationDestinyItem_DescItem_Base.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDestinyItem_DescItem_Base", package.seeall)

local VersionActivity2_3NewCultivationDestinyItem_DescItem_Base = class("VersionActivity2_3NewCultivationDestinyItem_DescItem_Base", RougeSimpleItemBase)

function VersionActivity2_3NewCultivationDestinyItem_DescItem_Base:_editableInitView()
	self._descComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtdesc.gameObject, SkillDescComp)
end

function VersionActivity2_3NewCultivationDestinyItem_DescItem_Base:setTipParam(...)
	self._descComp:setTipParam(...)
end

function VersionActivity2_3NewCultivationDestinyItem_DescItem_Base:updateInfo(...)
	self._descComp:updateInfo(self._txtdesc, ...)
end

return VersionActivity2_3NewCultivationDestinyItem_DescItem_Base
