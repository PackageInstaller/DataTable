-- chunkname: @modules/logic/activity/view/Role_FullSignView_Part1.lua

module("modules.logic.activity.view.Role_FullSignView_Part1", package.seeall)

local Role_FullSignView_Part1 = class("Role_FullSignView_Part1", Role_FullSignView)

function Role_FullSignView_Part1:_editableInitView()
	GameUtil.loadSImage(self._simageFullBG, ResUrl.getRoleSignSingleBg("role_sign_fullbg1"))
	GameUtil.loadSImage(self._simageTitle, ResUrl.getRoleSignSingleBgLang("role_sign_title_1"))

	local go1 = gohelper.findChild(self.viewGO, "Root/vx_effect1")
	local go2 = gohelper.findChild(self.viewGO, "Root/vx_effect2")

	gohelper.setActive(go1, true)
	gohelper.setActive(go2, false)
end

return Role_FullSignView_Part1
