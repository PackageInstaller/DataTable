-- chunkname: @modules/logic/activity/view/V2a3_Role_FullSignView_Part2.lua

module("modules.logic.activity.view.V2a3_Role_FullSignView_Part2", package.seeall)

local V2a3_Role_FullSignView_Part2 = class("V2a3_Role_FullSignView_Part2", V2a3_Role_FullSignView)

function V2a3_Role_FullSignView_Part2:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV2a3SignSingleBg("v2a3_sign_fullbg2"))
	self._simageTitle:LoadImage(ResUrl.getV2a3SignSingleBgLang("v2a3_sign_titie_2"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, false)
	gohelper.setActive(go2, true)
end

return V2a3_Role_FullSignView_Part2
