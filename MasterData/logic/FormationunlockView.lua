-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/FormationunlockView.lua

module("logic.extensions.nineplace.view.FormationunlockView", package.seeall)

local FormationunlockView = class("FormationunlockView", ViewComponent)

function FormationunlockView:ctor()
	FormationunlockView.super.ctor(self)
end

local effPaths = {
	{
		goPath = "eff1",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_bg.prefab"
	},
	{
		goPath = "eff2",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_texiaochixu.prefab"
	},
	{
		goPath = "eff3",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_texiaoyici.prefab"
	}
}

function FormationunlockView:buildUI()
	FormationunlockView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._icon = self:getGo("icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtName = self:getTxt("txtName")
end

function FormationunlockView:bindEvents()
	FormationunlockView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function FormationunlockView:unbindEvents()
	FormationunlockView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FormationunlockView:destroyUI()
	FormationunlockView.super.destroyUI(self)
end

function FormationunlockView:onEnter()
	FormationunlockView.super.onEnter(self)

	local id = self:getFirstParam() or 1

	self._icon:SetState(id - 1)

	local cfg = NinePlaceConfig.instance:getStageCfgById(id)

	self._txtName.text = cfg.name
	self._effs = {}

	for _, effPath in ipairs(effPaths) do
		local parent = self:getGo(effPath.goPath)
		local eff = UIEffectManager.instance:playEffect(self, effPath.path, parent, 0, 0, true, false, nil, function(self, uiEffect)
			Framework.TransformUtil.SetLocalPos(uiEffect.effGo.transform, 0, 0, 0)
		end, self)

		eff:setParent(parent.transform)
		eff:setScale(1)
		eff:setActive(false)
		table.insert(self._effs, eff)
	end
end

function FormationunlockView:onEnterFinished()
	FormationunlockView.super.onEnterFinished(self)

	for _, eff in ipairs(self._effs) do
		eff:setActive(true)
	end
end

function FormationunlockView:onExit()
	FormationunlockView.super.onExit(self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}
end

function FormationunlockView:onExitFinished()
	FormationunlockView.super.onExitFinished(self)
end

return FormationunlockView
