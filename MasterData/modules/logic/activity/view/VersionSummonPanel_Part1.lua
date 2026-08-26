-- chunkname: @modules/logic/activity/view/VersionSummonPanel_Part1.lua

module("modules.logic.activity.view.VersionSummonPanel_Part1", package.seeall)

local VersionSummonPanel_Part1 = class("VersionSummonPanel_Part1", VersionSummonPanel)

function VersionSummonPanel_Part1:_editableInitView()
	VersionSummonPanel_Part1.super._editableInitView(self)
	self._simageRole:LoadImage(ResUrl.getVersionSummonSingleBg("versionsummon_rolepanel_1"))

	if self._simageTitle then
		self._simageTitle:LoadImage(ResUrl.getVersionSummonSingleBgLang("versionsummon_txt_1"))
	end

	self._txtTips.text = luaLang("versionsummon_txt_tips1")
end

return VersionSummonPanel_Part1
