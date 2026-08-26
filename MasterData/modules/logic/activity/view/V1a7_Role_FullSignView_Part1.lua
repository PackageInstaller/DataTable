-- chunkname: @modules/logic/activity/view/V1a7_Role_FullSignView_Part1.lua

module("modules.logic.activity.view.V1a7_Role_FullSignView_Part1", package.seeall)

local V1a7_Role_FullSignView_Part1 = class("V1a7_Role_FullSignView_Part1", V1a7_Role_FullSignView)

function V1a7_Role_FullSignView_Part1:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getV1a7SignSingleBgLang("v1a7_sign_panel_title1"))
	self._simageTitle_eff:LoadImage(ResUrl.getV1a7SignSingleBgLang("v1a7_sign_panel_title1"))
	self._simageFullBG:LoadImage(ResUrl.getV1a7SignSingleBg("v1a7_role_fullsignview_bg_1"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return V1a7_Role_FullSignView_Part1
