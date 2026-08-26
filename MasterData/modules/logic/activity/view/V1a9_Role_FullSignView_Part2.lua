-- chunkname: @modules/logic/activity/view/V1a9_Role_FullSignView_Part2.lua

module("modules.logic.activity.view.V1a9_Role_FullSignView_Part2", package.seeall)

local V1a9_Role_FullSignView_Part2 = class("V1a9_Role_FullSignView_Part2", V1a9_Role_FullSignView)

function V1a9_Role_FullSignView_Part2:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_sign_fullbg2"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, false)
	gohelper.setActive(go2, true)
end

return V1a9_Role_FullSignView_Part2
