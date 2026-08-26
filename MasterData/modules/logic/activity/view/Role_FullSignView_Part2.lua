-- chunkname: @modules/logic/activity/view/Role_FullSignView_Part2.lua

module("modules.logic.activity.view.Role_FullSignView_Part2", package.seeall)

local Role_FullSignView_Part2 = class("Role_FullSignView_Part2", Role_FullSignView)

function Role_FullSignView_Part2:_editableInitView()
	GameUtil.loadSImage(self._simageFullBG, ResUrl.getRoleSignSingleBg("role_sign_fullbg2"))
	GameUtil.loadSImage(self._simageTitle, ResUrl.getRoleSignSingleBgLang("role_sign_title_2"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, false)
	gohelper.setActive(go2, true)
end

return Role_FullSignView_Part2
