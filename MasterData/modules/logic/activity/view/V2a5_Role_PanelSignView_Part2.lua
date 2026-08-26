-- chunkname: @modules/logic/activity/view/V2a5_Role_PanelSignView_Part2.lua

module("modules.logic.activity.view.V2a5_Role_PanelSignView_Part2", package.seeall)

local V2a5_Role_PanelSignView_Part2 = class("V2a5_Role_PanelSignView_Part2", V2a5_Role_PanelSignView)

function V2a5_Role_PanelSignView_Part2:_editableInitView()
	GameUtil.loadSImage(self._simagePanelBG, ResUrl.getV2a5SignSingleBg("v2a5_sign_panelbg2"))
	GameUtil.loadSImage(self._simageTitle, ResUrl.getV2a5SignSingleBgLang("v2a5_sign_titie_2"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, false)
	gohelper.setActive(go2, true)
end

return V2a5_Role_PanelSignView_Part2
