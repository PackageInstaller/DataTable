-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdLongYanView.lua

module("logic.extensions.activitypopup.view.HdLongYanView", package.seeall)

local HdLongYanView = class("HdLongYanView", ActivityPopupBase)

function HdLongYanView:onEnter()
	HdLongYanView.super.onEnter(self)
	self:_loadTextEffect()
end

function HdLongYanView:buildUI()
	HdLongYanView.super.buildUI(self)

	self._btnGo = self:getBtn("btnGo")
end

function HdLongYanView:bindEvents()
	HdLongYanView.super.bindEvents(self)
	self._btnGo:AddClickListener(self._onClickGo, self)
end

function HdLongYanView:unbindEvents()
	HdLongYanView.super.unbindEvents(self)
	self._btnGo:RemoveClickListener()
end

function HdLongYanView:_loadTextEffect()
	local parentGo = self.mainGO
	local path = "fx_ui_mangmianban/new/fx_ui_chuanshuo_daizi.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, parentGo.transform, 0, 0, true, false)

	effect:setParent(parentGo.transform)
	effect:setScale(0.72)
	effect:setLocalPos(-373.4, 169.4, 0)
end

function HdLongYanView:_onClickGo()
	local cfg = self:getActivityPopupCfg()

	if cfg then
		if not ActivityPopupModel.instance:isHaveNextActivityViewId() then
			UIStateManager.instance:clear()
		end

		GotoMgr.gotoByString(cfg.jumpTo)
	end
end

return HdLongYanView
