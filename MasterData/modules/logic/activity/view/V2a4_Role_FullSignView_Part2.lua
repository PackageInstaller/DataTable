-- chunkname: @modules/logic/activity/view/V2a4_Role_FullSignView_Part2.lua

module("modules.logic.activity.view.V2a4_Role_FullSignView_Part2", package.seeall)

local V2a4_Role_FullSignView_Part2 = class("V2a4_Role_FullSignView_Part2", V2a4_Role_FullSignView)

function V2a4_Role_FullSignView_Part2:_editableInitView()
	GameUtil.loadSImage(self._simageFullBG, ResUrl.getV2a4SignSingleBg("v2a4_sign_fullbg2"))

	local titleUrl = ResUrl.getV2a4SignSingleBgLang("v2a4_sign_title_2")

	GameUtil.loadSImage(self._simageTitle, titleUrl)
	GameUtil.loadSImage(self._simageTitle_glow, titleUrl)

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, false)
	gohelper.setActive(go2, true)
end

return V2a4_Role_FullSignView_Part2
