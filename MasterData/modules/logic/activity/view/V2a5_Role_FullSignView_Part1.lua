-- chunkname: @modules/logic/activity/view/V2a5_Role_FullSignView_Part1.lua

module("modules.logic.activity.view.V2a5_Role_FullSignView_Part1", package.seeall)

local V2a5_Role_FullSignView_Part1 = class("V2a5_Role_FullSignView_Part1", V2a5_Role_FullSignView)

function V2a5_Role_FullSignView_Part1:_editableInitView()
	GameUtil.loadSImage(self._simageFullBG, ResUrl.getV2a5SignSingleBg("v2a5_sign_fullbg1"))
	GameUtil.loadSImage(self._simageTitle, ResUrl.getV2a5SignSingleBgLang("v2a5_sign_title_1"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return V2a5_Role_FullSignView_Part1
