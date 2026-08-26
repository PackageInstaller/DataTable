-- chunkname: @modules/logic/survival/view/shelter/SurvivalSceneUIItemBase.lua

module("modules.logic.survival.view.shelter.SurvivalSceneUIItemBase", package.seeall)

local SurvivalSceneUIItemBase = class("SurvivalSceneUIItemBase", LuaCompBase)

function SurvivalSceneUIItemBase:init(go)
	self.go = go
	self.goTrs = go.transform
	self._gocontainer = gohelper.findChild(self.go, "go_container")
	self._gocontainerTrs = self._gocontainer.transform
	self._scene = GameSceneMgr.instance:getCurScene()
	self._canvasGroup = self.go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._baseAnimator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._containerCanvasGroup = self._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._click = gohelper.findChildClick(self.go, "go_click")
	self._isShow = true

	if self._customOnInit then
		self:_customOnInit()
	end
end

function SurvivalSceneUIItemBase:addEventListeners()
	if not gohelper.isNil(self._click) then
		self._click:AddClickListener(self._onTouchClick, self)
	end

	if self._customAddEventListeners then
		self:_customAddEventListeners()
	end
end

function SurvivalSceneUIItemBase:removeEventListeners()
	if not gohelper.isNil(self._click) then
		self._click:RemoveClickListener()
	end

	if self._customRemoveEventListeners then
		self:_customRemoveEventListeners()
	end
end

function SurvivalSceneUIItemBase:refreshFollower(transform)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollower))

	self._uiFollower:Set(mainCamera, uiCamera, plane, transform, 0, 0, 0, 0, 0)
end

function SurvivalSceneUIItemBase:_setShow(isShow, immediately)
	if isShow then
		if not self._isShow then
			self._baseAnimator:Play("room_task_in", 0, immediately and 1 or 0)
		end

		self._containerCanvasGroup.blocksRaycasts = true
	else
		if self._isShow then
			self._baseAnimator:Play("room_task_out", 0, immediately and 1 or 0)
		end

		self._containerCanvasGroup.blocksRaycasts = false
	end

	self._isShow = isShow

	self._uiFollower:SetEnable(isShow)
end

function SurvivalSceneUIItemBase:_onTouchClick()
	self:_onClick()
end

function SurvivalSceneUIItemBase:_onClick()
	return
end

function SurvivalSceneUIItemBase:onDestroy()
	if self._customOnDestory then
		self:_customOnDestory()
	end
end

return SurvivalSceneUIItemBase
