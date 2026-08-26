-- chunkname: @modules/logic/activity/view/V1a4_Role_PanelSignView_Part1.lua

module("modules.logic.activity.view.V1a4_Role_PanelSignView_Part1", package.seeall)

local V1a4_Role_PanelSignView_Part1 = class("V1a4_Role_PanelSignView_Part1", V1a4_Role_PanelSignView)

function V1a4_Role_PanelSignView_Part1:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getV1a4SignSingleBgLang("v1a4_sign_paneltitle1"))
	self._simagePanelBG:LoadImage(ResUrl.getV1a4SignSingleBg("v1a4_role37_sign_panelbg"))
end

return V1a4_Role_PanelSignView_Part1
