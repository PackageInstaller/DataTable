-- chunkname: @modules/logic/activity/view/V2a1_Role_PanelSignView_Part1.lua

module("modules.logic.activity.view.V2a1_Role_PanelSignView_Part1", package.seeall)

local V2a1_Role_PanelSignView_Part1 = class("V2a1_Role_PanelSignView_Part1", V2a1_Role_PanelSignView)

function V2a1_Role_PanelSignView_Part1:_editableInitView()
	self._simagePanelBG:LoadImage(ResUrl.getV2a1SignSingleBg("v2a1_sign_panelbg1"))
	self._simageTitle:LoadImage(ResUrl.getV2a1SignSingleBgLang("v2a1_sign_title1"))
end

return V2a1_Role_PanelSignView_Part1
