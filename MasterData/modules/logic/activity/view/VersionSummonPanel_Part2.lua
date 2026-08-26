-- chunkname: @modules/logic/activity/view/VersionSummonPanel_Part2.lua

module("modules.logic.activity.view.VersionSummonPanel_Part2", package.seeall)

local VersionSummonPanel_Part2 = class("VersionSummonPanel_Part2", VersionSummonPanel)

function VersionSummonPanel_Part2:_editableInitView()
	VersionSummonPanel_Part2.super._editableInitView(self)
	self._simageRole:LoadImage(ResUrl.getVersionSummonSingleBg("versionsummon_rolepanel_2"))

	if self._simageTitle then
		self._simageTitle:LoadImage(ResUrl.getVersionSummonSingleBgLang("versionsummon_txt_2"))
	end

	self._txtTips.text = luaLang("versionsummon_txt_tips2")
end

return VersionSummonPanel_Part2
