-- chunkname: @modules/logic/activity/view/VersionSummonFull_Part1.lua

module("modules.logic.activity.view.VersionSummonFull_Part1", package.seeall)

local VersionSummonFull_Part1 = class("VersionSummonFull_Part1", VersionSummonFull)

function VersionSummonFull_Part1:_editableInitView()
	VersionSummonFull_Part1.super._editableInitView(self)
	self._simageRole:LoadImage(ResUrl.getVersionSummonSingleBg("versionsummon_rolefull_1"))

	if self._simageTitle then
		self._simageTitle:LoadImage(ResUrl.getVersionSummonSingleBgLang("versionsummon_txt_1"))
	end

	self._txtTips.text = luaLang("versionsummon_txt_tips1")
end

return VersionSummonFull_Part1
