-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMainCampLvUpView.lua

module("logic.extensions.season.view.SeasonMainCampLvUpView", package.seeall)

local SeasonMainCampLvUpView = class("SeasonMainCampLvUpView", ViewComponent)

function SeasonMainCampLvUpView:ctor()
	SeasonMainCampLvUpView.super.ctor(self)
end

function SeasonMainCampLvUpView:unbindEvents()
	SeasonMainCampLvUpView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function SeasonMainCampLvUpView:bindEvents()
	SeasonMainCampLvUpView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function SeasonMainCampLvUpView:buildUI()
	SeasonMainCampLvUpView.super.buildUI(self)

	self._closeButton = self:getBtn("img_bg")
	self._txtTips = self:getTxt("image/txtTips")
	self._iconItem = self:getGo("scale_mid_02/Image"):GetComponent("UIImageSpriteChange")
	self._goFuncCell = self:getGo("vlayout/cell")

	self._goFuncCell:SetActive(false)
end

function SeasonMainCampLvUpView:onExit()
	SeasonMainCampLvUpView.super.onExit(self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}
	self._isLockClose = false
end

function SeasonMainCampLvUpView:onEnter()
	SeasonMainCampLvUpView.super.onEnter(self)
	self:_createEffects()

	local params = self:getOpenParam()

	if params[1] then
		self._iconItem:ChangeSprite(params[1].unlockIcon)

		self._txtTips.text = params[1].unlockInfo or ""
	end

	self._isLockClose = false

	for _, eff in ipairs(self._effs) do
		eff:setActive(true)
	end
end

local effPaths = {
	{
		goPath = "point_bg",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_bg.prefab"
	},
	{
		goPath = "point_tisheng",
		path = "fx_ui_xunlianshidengji/fx_ui_xunlianshi_tisheng.prefab"
	},
	{
		goPath = "point_chixu",
		path = "fx_ui_xunlianshidengji/fx_ui_xunlianshi_texiaochixu.prefab"
	},
	{
		goPath = "point_yici",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_texiaoyici.prefab"
	}
}

function SeasonMainCampLvUpView:_createEffects()
	self._effs = {}

	for _, effPath in ipairs(effPaths) do
		local parent = self:getGo(effPath.goPath)
		local eff = UIEffectManager.instance:playHUDEffect(effPath.path, parent, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		end, nil, false)

		eff:setActive(false)
		table.insert(self._effs, eff)
	end
end

function SeasonMainCampLvUpView:_onClickClose()
	if self._isLockClose then
		return
	end

	self:close()
end

return SeasonMainCampLvUpView
