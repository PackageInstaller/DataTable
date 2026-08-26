-- chunkname: @modules/logic/sp01/versionsummon/view/V2a9_VersionSummonPanel_Part1.lua

module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonPanel_Part1", package.seeall)

local V2a9_VersionSummonPanel_Part1 = class("V2a9_VersionSummonPanel_Part1", V2a9_VersionSummonPanel)

function V2a9_VersionSummonPanel_Part1:_editableInitView()
	self._simageRole:LoadImage(ResUrl.getV2a9VersionSummonSingleBg("v2a9_versionsummon_panelrole1"))
	self._simageLogo:LoadImage(ResUrl.getV2a9VersionSummonSingleBgLang("v2a9_versionsummon_logo1"))
	self._simageTitle:LoadImage(ResUrl.getV2a9VersionSummonSingleBgLang("v2a9_versionsummon_title1"))
	self._simageProp:LoadImage(ResUrl.getV2a9VersionSummonSingleBg("v2a9_versionsummon_icon_1"))

	self._txtTips.text = luaLang("v2a9_versionsummon_txt_tips1")
end

return V2a9_VersionSummonPanel_Part1
