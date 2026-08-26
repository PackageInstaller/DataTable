-- chunkname: @modules/logic/activity/view/V1a8_Role_PanelSignView_Part2.lua

module("modules.logic.activity.view.V1a8_Role_PanelSignView_Part2", package.seeall)

local V1a8_Role_PanelSignView_Part2 = class("V1a8_Role_PanelSignView_Part2", V1a8_Role_PanelSignView)

function V1a8_Role_PanelSignView_Part2:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getV1a8SignSingleBgLang("v1a8_sign_panel_title2"))
	self._simageTitle_eff:LoadImage(ResUrl.getV1a8SignSingleBgLang("v1a8_sign_panel_title2"))
	self._simagePanelBG:LoadImage(ResUrl.getV1a8SignSingleBg("v1a8_sign_panel_bg2"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, false)
	gohelper.setActive(go2, true)
end

return V1a8_Role_PanelSignView_Part2
