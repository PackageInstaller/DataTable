-- chunkname: @modules/logic/activity/view/V1a5_Role_PanelSignView_Part2.lua

module("modules.logic.activity.view.V1a5_Role_PanelSignView_Part2", package.seeall)

local V1a5_Role_PanelSignView_Part2 = class("V1a5_Role_PanelSignView_Part2", V1a5_Role_PanelSignView)

function V1a5_Role_PanelSignView_Part2:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_aizila_title"))
	self._simagePanelBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_aizila_sign_panelbg"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, false)
	gohelper.setActive(go2, true)
end

return V1a5_Role_PanelSignView_Part2
