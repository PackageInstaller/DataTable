-- chunkname: @modules/logic/activity/view/V1a5_Role_FullSignView_Part1.lua

module("modules.logic.activity.view.V1a5_Role_FullSignView_Part1", package.seeall)

local V1a5_Role_FullSignView_Part1 = class("V1a5_Role_FullSignView_Part1", V1a5_Role_FullSignView)

function V1a5_Role_FullSignView_Part1:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_kerandian_title"))
	self._simageFullBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_kerandian_sign_fullbg"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return V1a5_Role_FullSignView_Part1
