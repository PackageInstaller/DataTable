-- chunkname: @modules/logic/versionactivity1_6/v1a6_panelsign/view/V1a6_Role_PanelSignView_Part1.lua

module("modules.logic.versionactivity1_6.v1a6_panelsign.view.V1a6_Role_PanelSignView_Part1", package.seeall)

local V1a6_Role_PanelSignView_Part1 = class("V1a6_Role_PanelSignView_Part1", V1a6_Role_PanelSignView)

function V1a6_Role_PanelSignView_Part1:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getV1a6SignSingleBg("v1a6_sign_logo"))
	self._simagePanelBG:LoadImage(ResUrl.getV1a6SignSingleBg("v1a6_quniang_sign_panelbg"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return V1a6_Role_PanelSignView_Part1
