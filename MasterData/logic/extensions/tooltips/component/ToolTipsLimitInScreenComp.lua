-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsLimitInScreenComp.lua

module("logic.extensions.tooltips.component.ToolTipsLimitInScreenComp", package.seeall)

local M = class("ToolTipsLimitInScreenComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._uiScreenLimit = UIScreenLimit.Get(self.mainGO)

	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	self._uiScreenLimit:SetUICamera(uiCamera)

	local uiRoot = ViewMgr.instance:getUIRoot()

	self._uiScreenLimit:SetCanvasScaler(uiRoot)
end

function M:destroyUI()
	self._uiScreenLimit:Destroy(self.mainGO)
end

function M:setPos()
	if self._uiScreenLimit ~= nil then
		self._uiScreenLimit:SetUIPos()
	end
end

function M:updateViewComponent(finish)
	GlobalDispatcher:dispatchEvent(EventType.TIPS_CHANGE_ENABLE_EVENT, finish, self._viewPresentor:getViewName())
end

function M:onEnterFinished()
	local param = self:getFirstParam()

	if param.popType == CommEnum.TipsPopType.Top or param.popType == CommEnum.TipsPopType.Bottom then
		return
	end

	self:updateViewComponent(false)

	if param.obj == nil then
		self:setPos()
	elseif self._uiScreenLimit ~= nil and self.mainGO and not goutil.isNil(param.obj) then
		self._uiScreenLimit:ShowWithTargetLeft(self.mainGO.transform, 1, param.obj.transform, 3)
	end

	local mainRectTr = self.mainGO:GetComponent(UIComponentType.RectTransform)

	self:updateViewComponent(true)
end

return M
