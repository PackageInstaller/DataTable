-- chunkname: @modules/logic/activity/view/V2a1_Role_PanelSignView_Part2.lua

module("modules.logic.activity.view.V2a1_Role_PanelSignView_Part2", package.seeall)

local V2a1_Role_PanelSignView_Part2 = class("V2a1_Role_PanelSignView_Part2", V2a1_Role_PanelSignView)

function V2a1_Role_PanelSignView_Part2:_editableInitView()
	self._simagePanelBG:LoadImage(ResUrl.getV2a1SignSingleBg("v2a1_sign_panelbg2"))
	self._simageTitle:LoadImage(ResUrl.getV2a1SignSingleBgLang("v2a1_sign_title2"))
end

return V2a1_Role_PanelSignView_Part2
