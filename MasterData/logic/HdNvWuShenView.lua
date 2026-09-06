-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdNvWuShenView.lua

module("logic.extensions.activitypopup.view.HdNvWuShenView", package.seeall)

local HdNvWuShenView = class("HdNvWuShenView", ActivityPopupBase)

function HdNvWuShenView:onEnter()
	HdNvWuShenView.super.onEnter(self)
	self:_loadTextEffect()
end

function HdNvWuShenView:_loadTextEffect()
	local parentGo = self.mainGO
	local path = "fx_ui_mangmianban/new/fx_ui_chuanshuo_daizi.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, parentGo.transform, 0, 0, true, false)

	effect:setParent(parentGo.transform)
	effect:setScale(0.8)
	effect:setLocalPos(-403.6, 194.5, 0)
end

return HdNvWuShenView
