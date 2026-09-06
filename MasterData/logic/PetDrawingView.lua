-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetDrawingView.lua

module("logic.extensions.handbook.view.PetDrawingView", package.seeall)

local PetDrawingView = class("PetDrawingView", ViewComponent)

function PetDrawingView:ctor()
	PetDrawingView.super.ctor(self)
end

function PetDrawingView:destroyUI()
	PetDrawingView.super.destroyUI(self)
end

function PetDrawingView:onExitFinished()
	PetDrawingView.super.onExitFinished(self)
end

function PetDrawingView:onEnterFinished()
	PetDrawingView.super.onEnterFinished(self)
end

function PetDrawingView:unbindEvents()
	PetDrawingView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	self._btnShare:RemoveClickListener()
end

function PetDrawingView:bindEvents()
	PetDrawingView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSwitch:AddClickListener(self._onClickSwitch, self)
	self._btnShare:AddClickListener(self._onClickShare, self)
end

function PetDrawingView:onExit()
	PetDrawingView.super.onExit(self)
	self._dragContent:RemoveDragListener()
	MaterialMgr.resetAll(self._shareProxy)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role2 = RoleObjectPool.instance:removeRole(self._role2)
	self._role3 = RoleObjectPool.instance:removeRole(self._role3)
end

function PetDrawingView:buildUI()
	PetDrawingView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self.topleft = self:getGo("topleft")
	self._rolePoint = self:getGo("centerPoint/rolePoint")
	self._rolePoint2 = self:getGo("centerPoint/rolePoint2")
	self.posterGo = self:getGo("posterGo")
	self._btnSwitch = self:getBtn("btnSwitch")
	self._switchOn = goutil.findChild(self._btnSwitch.gameObject, "on")
	self._switchOff = goutil.findChild(self._btnSwitch.gameObject, "off")
	self._btnShare = self:getBtn("btnShare")
	self._canvas = goutil.findChildComponent(self.mainGO, "canvas", "Canvas")

	local canvas = UGUIToolHelper.FindCanvas(self.mainGO)

	self._canvas.sortingOrder = canvas.sortingOrder - 2
	self._centerPoint = self:getGo("centerPoint")
	self._dragContent = Framework.UIDragTrigger.Get(self._centerPoint)
	self._centerPointGraphic = self:getGo("centerPoint"):GetComponent(typeof(UnityEngine.UI.Graphic))
	self._doubleFinger = goutil.findChildComponent(self.mainGO, "centerPoint", "DoubleFinger")
	self._rectTrans = self._centerPoint:GetComponent("RectTransform")
	self._sizeDelta = self._rectTrans.sizeDelta
end

function PetDrawingView:_onClickSwitch()
	self._isLihui = not self._isLihui

	self:_updateState()
end

function PetDrawingView:_updateState()
	self._showLihui = self._isLihui and self._hasLihui

	goutil.setActive(self._switchOn, self._isLihui)
	goutil.setActive(self._switchOff, not self._isLihui)
	goutil.setActive(self._rolePoint, self._showLihui)
	goutil.setActive(self._rolePoint2, not self._showLihui)
	self:_updateDrawing()
end

function PetDrawingView:_updateDrawing()
	local raceId = checknumber(self.modelId)
	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	if self._showLihui then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._rolePoint, scale, nil, true, x, y)
	else
		self._role2 = RoleObjectPool.instance:addRoleToParent(self._role2, raceId, self._rolePoint2, scale, nil, false, x, y)
	end
end

function PetDrawingView:showPoster()
	goutil.setActive(self._rolePoint, false)
	goutil.setActive(self._rolePoint2, false)

	local posterId = checknumber(self.modelId)
	local isChange = PetskinModel.instance:getIsUnlockDyPoster(posterId)

	self._role3 = RoleObjectPool.instance:addPosterToParent(self._role3, posterId, isChange, self.posterGo)
end

function PetDrawingView:onEnter()
	PetDrawingView.super.onEnter(self)

	local params = self:getOpenParam()

	if params then
		self.modelId = params[1]
		self.isPoster = params[2]
	end

	if not self.isPoster then
		local cfg = CharacterConfig.instance:getModelCo(checknumber(self.modelId))

		self._hasLihui = cfg ~= nil and not string.nilorempty(cfg.bustName)

		goutil.setActive(self._btnSwitch.gameObject, false)

		self._isLihui = true

		self:_updateState()
	else
		goutil.setActive(self._btnSwitch.gameObject, false)
		self:showPoster()
	end

	local prize = ShareController.instance.activeByTimes(1, goutil.findChild(self._btnShare.gameObject, "bubble"))

	self._shareProxy = MaterialMgr.setCellByCfg(prize, goutil.findChild(self._btnShare.gameObject, "bubble/reward"))

	local path = "fx_ui_tujian/fx_ui_tujian_all.prefab"
	local parent = self:getGo("canvas/point_eff")

	self._eff = UIEffectManager.instance:playHUDEffect(path, parent, true, nil, nil, function(finishHandlerTarget, eff)
		GoUtil.SetSortingOrder(eff.effGo, self._canvas.sortingOrder + 1)
	end, nil, false)

	Framework.TransformUtil.SetLocalScale(self._centerPoint.transform, 2, 2, 1)
	Framework.TransformUtil.SetLocalPos(self._centerPoint.transform, 0, 0, 0)
end

function PetDrawingView:_onDragging(delta)
	local curScale, _, _ = Framework.TransformUtil.GetLocalScale(self._centerPoint.transform, 0, 0, 0)

	curScale = math.max(1, curScale)

	local offset = math.abs(self._sizeDelta.y * (curScale - 1) * 0.5)
	local x, y = Framework.TransformUtil.GetAnchoredPos(self._rectTrans, 0, 0)

	x = math.max(-offset, x)
	x = math.min(offset, x)

	Framework.TransformUtil.SetAnchoredPos(self._rectTrans, x, y)
end

function PetDrawingView:_onClickClose()
	self:close()
end

function PetDrawingView:_onClickShare()
	GameUtil.SetActive(self.topleft, false)
	self._dragContent:RemoveDragListener()
	ShareController.instance:share(1, {
		self._btnShare.gameObject
	}, nil, 200292, function()
		GameUtil.SetActive(self.topleft, true)

		if not self.isPoster then
			self._dragContent:AddDragListener(self._onDragging, self)
		end
	end)
end

function PetDrawingView:_setInteractable()
	self._centerPointGraphic.raycastTarget = not PetSkinConfig.instance:isSkinInteractable(self.modelId)
end

return PetDrawingView
