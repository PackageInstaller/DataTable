-- chunkname: @modules/logic/activity/view/V2a0_Role_FullSignView_Part1.lua

module("modules.logic.activity.view.V2a0_Role_FullSignView_Part1", package.seeall)

local V2a0_Role_FullSignView_Part1 = class("V2a0_Role_FullSignView_Part1", V2a0_Role_FullSignView)

function V2a0_Role_FullSignView_Part1:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV2a0SignSingleBg("v2a0_sign_fullbg1"))
	self._simageTitle:LoadImage(ResUrl.getV2a0SignSingleBgLang("v2a0_sign_title1"))
end

return V2a0_Role_FullSignView_Part1
