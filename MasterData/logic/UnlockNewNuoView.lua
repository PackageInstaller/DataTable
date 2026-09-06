-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/UnlockNewNuoView.lua

module("logic.extensions.idlegame.view.UnlockNewNuoView", package.seeall)

local UnlockNewNuoView = class("UnlockNewNuoView", ViewComponent)

function UnlockNewNuoView:ctor()
	UnlockNewNuoView.super.ctor(self)
end

function UnlockNewNuoView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function UnlockNewNuoView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function UnlockNewNuoView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")
	self._ImgC_Icon = goutil.findChildComponent(self.mainGO, "Nego_Center/ani/scale_mid_02/Image", "Image")
	self._TxtC_FuncName = goutil.findChildComponent(self.mainGO, "Nego_Center/TxtC_FuncName", "Text")
	self._effRoot = self:getGo("Nego_Center/ani")
	self._animator = goutil.findChildComponent(self.mainGO, "Nego_Center", "Animator")
	self._animator.enabled = false
	self._Nego_Center = self:getGo("Nego_Center")

	goutil.setActive(self._Nego_Center, false)
end

function UnlockNewNuoView:destroyUI()
	return
end

function UnlockNewNuoView:onEnter()
	local params = self:getOpenParam()

	self._level = params[1]
	self._showTimes = checknumber(params[2])
	self._eff1Loaded = false
	self._eff2Loaded = false
	self._animator.enabled = true
	self._eff1 = UIEffectManager.instance:playHUDEffect("fx_ui_xingongneng/fx.prefab", self._effRoot, true, nil, nil, function(finishHandlerTarget, eff)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self._effRoot) + 1)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

		self._eff1Loaded = true

		self:startPlay()
	end, nil, false)
	self._eff2 = UIEffectManager.instance:playHUDEffect("fx_ui_xingongneng/fx_ui_jiesuoxiaonuo.prefab", self._effRoot, true, nil, nil, function(finishHandlerTarget, eff)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self._effRoot) + 1)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 234, 0)

		self._eff2Loaded = true

		self:startPlay()
	end, nil, false)
end

function UnlockNewNuoView:startPlay()
	if self._eff1Loaded and self._eff2Loaded then
		local cfg = IdleGameConfig.instance:getXiaoNuoPlaceCfg(self._level)

		if cfg ~= nil then
			self._TxtC_FuncName.text = cfg.name
		end

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(cfg.modelId))

		if modelCo ~= nil then
			uGuiUtil.setSpriteToImage(self._ImgC_Icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end

		self._eff1:setActive(false)
		self._eff1:setActive(true)
		self._eff2:setActive(false)
		self._eff2:setActive(false)
		self._animator:Rebind()
		goutil.setActive(self._Nego_Center, false)
		goutil.setActive(self._Nego_Center, true)
	end
end

function UnlockNewNuoView:onEnterFinished()
	return
end

function UnlockNewNuoView:onExit()
	UIEffectManager.instance:stopEffect(self._eff1)
	UIEffectManager.instance:stopEffect(self._eff2)
end

function UnlockNewNuoView:onExitFinished()
	return
end

function UnlockNewNuoView:_onClickClose()
	self._showTimes = self._showTimes - 1
	self._level = self._level + 1

	if self._showTimes >= 0 then
		self:startPlay()
	else
		self:close()
	end
end

return UnlockNewNuoView
