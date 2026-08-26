-- chunkname: @modules/logic/activity/view/Role_PanelSignView_Part1.lua

module("modules.logic.activity.view.Role_PanelSignView_Part1", package.seeall)

local Role_PanelSignView_Part1 = class("Role_PanelSignView_Part1", Role_PanelSignView)

function Role_PanelSignView_Part1:_editableInitView()
	GameUtil.loadSImage(self._simagePanelBG, ResUrl.getRoleSignSingleBg("role_sign_panelbg1"))
	GameUtil.loadSImage(self._simageTitle, ResUrl.getRoleSignSingleBgLang("role_sign_title_1"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return Role_PanelSignView_Part1
