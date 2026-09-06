-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/view/FuncOpenView.lua

module("logic.extensions.funcopen.view.FuncOpenView", package.seeall)

local FuncOpenView = class("FuncOpenView", ViewComponent)

function FuncOpenView:ctor()
	FuncOpenView.super.ctor(self)
end

function FuncOpenView:bindEvents()
	self._Btn_Close:AddClickListener(self._onClickClose, self)
end

function FuncOpenView:unbindEvents()
	self._Btn_Close:RemoveClickListener()
end

local effPaths = {
	{
		goPath = "point_bg",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_bg.prefab"
	},
	{
		goPath = "ani/point_chixu",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_texiaochixu.prefab"
	},
	{
		goPath = "ani/point_yici",
		path = "fx_ui_xingongneng/new/fx_ui_xingongneng_texiaoyici.prefab"
	}
}

function FuncOpenView:buildUI()
	self._Btn_Close = self:getBtn("btnClose")
	self._effRoot = self:getGo("ani/scale_mid_01/image")
	self._Nego_Center = self:getGo("ani")
	self._ImgC_Icon2 = goutil.findChildComponent(self.mainGO, "ani/scale_mid_02/Image", "Image")
	self._ImgSpriteChange2 = self._ImgC_Icon2:GetComponent("UIImageSpriteChange")
	self._ImgC_Icon = goutil.findChildComponent(self.mainGO, "imgIcon", "Image")
	self._ImgSpriteChange = self._ImgC_Icon:GetComponent("UIImageSpriteChange")
	self._TxtC_FuncName = goutil.findChildComponent(self.mainGO, "ani/txtName", "Text")
	self._initX, self._initY, self._initZ = Framework.TransformUtil.GetPos(self._ImgC_Icon.transform, 0, 0, 0)
	self._animator = self.mainGO:GetComponent("Animator")
	self._animator.enabled = false

	goutil.setActive(self._ImgC_Icon2.gameObject, false)
end

function FuncOpenView:destroyUI()
	return
end

function FuncOpenView:_prepareFuncOpen()
	self._flying = false

	self._Nego_Center:SetActive(true)

	self._animator.enabled = false

	Framework.TransformUtil.SetPos(self._ImgC_Icon.transform, self._initX, self._initY, self._initZ)
	Framework.TransformUtil.SetLocalScale(self._ImgC_Icon.transform, 1, 1, 1)
	self._ImgC_Icon.gameObject:SetActive(false)
end

function FuncOpenView:_createEffects()
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

function FuncOpenView:onEnterFinished()
	self._isFirst = false

	self:_checkFuncOpen()
end

function FuncOpenView:onEnter()
	FuncOpenView.super.onEnter(self)
	FuncOpenController.instance:registerLocalNotify("FuncOpenShowByHigherPriority", self._onShowByHigherPriority, self)
	FuncOpenController.instance:registerLocalNotify("FuncOpenHideByLowerPriority", self._onHideByLowerPriority, self)
	self:_createEffects()
end

function FuncOpenView:_onShowByHigherPriority()
	self:_checkFuncOpen()
end

function FuncOpenView:_onHideByLowerPriority()
	removetimer(self._update, self)
	removetimer(self._flyFinished, self)
end

function FuncOpenView:_checkFuncOpen()
	self:_prepareFuncOpen()

	local funcId = FuncOpenModel.instance:getNeedShowFuncId()

	print("open func id = " .. tostring(funcId))

	if not funcId then
		self:close()

		return
	end

	self._funcId = funcId

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

	if not cfg or cfg.tipsType ~= 1 then
		self:_onCurrFuncOpenFinish()

		return
	end

	self._TxtC_FuncName.text = cfg.name

	self._ImgSpriteChange:ChangeSprite(cfg.tipsIcon)
	self._ImgC_Icon:SetNativeSize()
	self._ImgSpriteChange2:ChangeSprite(cfg.tipsIcon)
	goutil.setActive(self._ImgC_Icon2.gameObject, true)
	self._ImgC_Icon2:SetNativeSize()

	self._animator.enabled = true

	AudioPlayerEx.instance:playEffect(30220)

	for _, eff in ipairs(self._effs) do
		eff:setActive(true)
	end
end

function FuncOpenView:onExit()
	self:_onCurrFuncOpenFinish()

	self._funcId = nil

	goutil.setActive(self._ImgC_Icon2.gameObject, false)
	FuncOpenController.instance:unregisterLocalNotify("FuncOpenShowByHigherPriority", self._onShowByHigherPriority, self)
	FuncOpenController.instance:unregisterLocalNotify("FuncOpenHideByLowerPriority", self._onHideByLowerPriority, self)
end

function FuncOpenView:_onClickClose()
	if not ViewMgr.instance:isOpen(ViewName.MainUI) then
		self:close()
	elseif self._flying then
		-- block empty
	else
		self._flying = true

		self._ImgC_Icon.gameObject:SetActive(true)
		self._Nego_Center:SetActive(false)
		GlobalDispatcher:addListener(GlobalNotify.GetFuncBtnPosRes, self._onGetFuncBtnPos, self)
		GlobalDispatcher:dispatch(GlobalNotify.GetFuncBtnPosReq, self._funcId)
	end
end

function FuncOpenView:_onGetFuncBtnPos(pos)
	pos = pos or Vector3.New(0, 0, 0)

	GlobalDispatcher:removeListener(GlobalNotify.GetFuncBtnPosRes, self._onGetFuncBtnPos, self)
	self._ImgC_Icon.transform:DOMove(pos, 1)
	self._ImgC_Icon.transform:DOScale(Vector3.New(0, 0, 0), 1)

	self._eff = UIEffectManager.instance:playEffect(self, "fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing.prefab", self._ImgC_Icon.gameObject, 0, 0, false, nil, nil, nil, self)

	settimer(0, self._update, self)
	settimer(1.2, self._flyFinished, self, false)
end

function FuncOpenView:_update()
	if not self._eff then
		return nil
	end

	UIEffectManager.instance:updateEffectPosition(self._eff)
end

function FuncOpenView:_flyFinished()
	self:_onCurrFuncOpenFinish()
end

function FuncOpenView:_onCurrFuncOpenFinish()
	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	self._animator.enabled = false

	if self._funcId then
		self._funcId = nil

		local funcId = FuncOpenModel.instance:dequeueNeedShowFunc()

		GlobalDispatcher:dispatch(GlobalNotify.FuncOpenFinished, funcId)
	end

	removetimer(self._update, self)
	removetimer(self._flyFinished, self)
	self:_checkFuncOpen()
end

return FuncOpenView
