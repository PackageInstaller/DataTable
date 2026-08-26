-- chunkname: @modules/logic/activity/view/V2a0_Role_PanelSignView_Part1.lua

module("modules.logic.activity.view.V2a0_Role_PanelSignView_Part1", package.seeall)

local V2a0_Role_PanelSignView_Part1 = class("V2a0_Role_PanelSignView_Part1", V2a0_Role_PanelSignView)

function V2a0_Role_PanelSignView_Part1:_editableInitView()
	self._simagePanelBG:LoadImage(ResUrl.getV2a0SignSingleBg("v2a0_sign_panelbg1"))
	self._simageTitle:LoadImage(ResUrl.getV2a0SignSingleBgLang("v2a0_sign_title1"))
end

return V2a0_Role_PanelSignView_Part1
