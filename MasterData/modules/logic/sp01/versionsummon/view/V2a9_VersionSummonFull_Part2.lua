-- chunkname: @modules/logic/sp01/versionsummon/view/V2a9_VersionSummonFull_Part2.lua

module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonFull_Part2", package.seeall)

local V2a9_VersionSummonFull_Part2 = class("V2a9_VersionSummonFull_Part2", V2a9_VersionSummonFull)

function V2a9_VersionSummonFull_Part2:_editableInitView()
	self._simageRole:LoadImage(ResUrl.getV2a9VersionSummonSingleBg("v2a9_versionsummon_fullrole2"))
	self._simageLogo:LoadImage(ResUrl.getV2a9VersionSummonSingleBgLang("v2a9_versionsummon_logo2"))
	self._simageTitle:LoadImage(ResUrl.getV2a9VersionSummonSingleBgLang("v2a9_versionsummon_title2"))
	self._simageProp:LoadImage(ResUrl.getV2a9VersionSummonSingleBg("v2a9_versionsummon_icon_2"))

	self._txtTips.text = luaLang("v2a9_versionsummon_txt_tips2")
end

return V2a9_VersionSummonFull_Part2
