-- chunkname: @modules/logic/activity/view/V1a4_Role_FullSignView_Part1.lua

module("modules.logic.activity.view.V1a4_Role_FullSignView_Part1", package.seeall)

local V1a4_Role_FullSignView_Part1 = class("V1a4_Role_FullSignView_Part1", V1a4_Role_FullSignView)

function V1a4_Role_FullSignView_Part1:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getV1a4SignSingleBgLang("v1a4_sign_fulltitle1"))
	self._simageFullBG:LoadImage(ResUrl.getV1a4SignSingleBg("v1a4_role37_sign_fullbg"))
end

return V1a4_Role_FullSignView_Part1
