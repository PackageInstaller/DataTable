-- chunkname: @modules/logic/activity/view/V1a9_Role_PanelSignView_Part1.lua

module("modules.logic.activity.view.V1a9_Role_PanelSignView_Part1", package.seeall)

local V1a9_Role_PanelSignView_Part1 = class("V1a9_Role_PanelSignView_Part1", V1a9_Role_PanelSignView)

function V1a9_Role_PanelSignView_Part1:_editableInitView()
	self._simagePanelBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_sign_panelbg1"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return V1a9_Role_PanelSignView_Part1
