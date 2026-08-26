-- chunkname: @modules/logic/activity/view/V2a0_Role_PanelSignView_Part2.lua

module("modules.logic.activity.view.V2a0_Role_PanelSignView_Part2", package.seeall)

local V2a0_Role_PanelSignView_Part2 = class("V2a0_Role_PanelSignView_Part2", V2a0_Role_PanelSignView)

function V2a0_Role_PanelSignView_Part2:_editableInitView()
	self._simagePanelBG:LoadImage(ResUrl.getV2a0SignSingleBg("v2a0_sign_panelbg2"))
	self._simageTitle:LoadImage(ResUrl.getV2a0SignSingleBgLang("v2a0_sign_title2"))
end

return V2a0_Role_PanelSignView_Part2
