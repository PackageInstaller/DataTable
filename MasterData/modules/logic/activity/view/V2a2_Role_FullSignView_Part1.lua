-- chunkname: @modules/logic/activity/view/V2a2_Role_FullSignView_Part1.lua

module("modules.logic.activity.view.V2a2_Role_FullSignView_Part1", package.seeall)

local V2a2_Role_FullSignView_Part1 = class("V2a2_Role_FullSignView_Part1", V2a2_Role_FullSignView)

function V2a2_Role_FullSignView_Part1:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV2a2SignSingleBg("v2a2_sign_fullbg1"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return V2a2_Role_FullSignView_Part1
