-- chunkname: @modules/logic/activity/view/V2a4_Role_PanelSignView_Part1.lua

module("modules.logic.activity.view.V2a4_Role_PanelSignView_Part1", package.seeall)

local V2a4_Role_PanelSignView_Part1 = class("V2a4_Role_PanelSignView_Part1", V2a4_Role_PanelSignView)

function V2a4_Role_PanelSignView_Part1:_editableInitView()
	GameUtil.loadSImage(self._simagePanelBG, ResUrl.getV2a4SignSingleBg("v2a4_sign_panelbg1"))

	local titleUrl = ResUrl.getV2a4SignSingleBgLang("v2a4_sign_title_1")

	GameUtil.loadSImage(self._simageTitle, titleUrl)
	GameUtil.loadSImage(self._simageTitle_glow, titleUrl)

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return V2a4_Role_PanelSignView_Part1
