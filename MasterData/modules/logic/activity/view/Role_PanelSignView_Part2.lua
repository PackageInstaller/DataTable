-- chunkname: @modules/logic/activity/view/Role_PanelSignView_Part2.lua

module("modules.logic.activity.view.Role_PanelSignView_Part2", package.seeall)

local Role_PanelSignView_Part2 = class("Role_PanelSignView_Part2", Role_PanelSignView)

function Role_PanelSignView_Part2:_editableInitView()
	GameUtil.loadSImage(self._simagePanelBG, ResUrl.getRoleSignSingleBg("role_sign_panelbg2"))
	GameUtil.loadSImage(self._simageTitle, ResUrl.getRoleSignSingleBgLang("role_sign_title_2"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, false)
	gohelper.setActive(go2, true)
end

return Role_PanelSignView_Part2
