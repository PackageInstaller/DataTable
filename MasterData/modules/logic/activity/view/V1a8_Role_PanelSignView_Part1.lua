-- chunkname: @modules/logic/activity/view/V1a8_Role_PanelSignView_Part1.lua

module("modules.logic.activity.view.V1a8_Role_PanelSignView_Part1", package.seeall)

local V1a8_Role_PanelSignView_Part1 = class("V1a8_Role_PanelSignView_Part1", V1a8_Role_PanelSignView)

function V1a8_Role_PanelSignView_Part1:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getV1a8SignSingleBgLang("v1a8_sign_panel_title1"))
	self._simageTitle_eff:LoadImage(ResUrl.getV1a8SignSingleBgLang("v1a8_sign_panel_title1"))
	self._simagePanelBG:LoadImage(ResUrl.getV1a8SignSingleBg("v1a8_sign_panel_bg1"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return V1a8_Role_PanelSignView_Part1
