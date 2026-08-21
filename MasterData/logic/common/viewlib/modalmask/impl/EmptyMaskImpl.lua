-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/modalmask/impl/EmptyMaskImpl.lua

module("logic.common.viewlib.modalmask.impl.EmptyMaskImpl", package.seeall)

local M = class("EmptyMaskImpl", AbstractGlobalReusable, IModelMask)

function M:ctor()
	self.mainGO = goutil.create("EmptyMask", true)

	goutil.addChildToParent(self.mainGO, ModalMask.maskRoot)
	goutil.addComponentOnce(self.mainGO, UIComponentType.EmptyRaycast)
	ModalMask.internal_setFullScreen(self.mainGO)
	self:buildUI()
end

function M:reset()
	self:resetUI()
	goutil.addChildToParent(self.mainGO, ModalMask.maskRoot)
end

function M:destroy()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self.mainGO = false
end

function M:buildUI()
	self._btnClick = Astral.UIClickTrigger.Get(self.mainGO)

	self._btnClick:AddClickListener(self._onClick, self)

	self._handler = Handler.New()
end

function M:resetUI()
	self._handler:clear()
end

function M:destroyUI()
	self._btnClick:RemoveClickListener()

	self._btnClick = false
end

function M:setBackgroundMask(targetGO)
	GameObjectUtils.SetABehindB(self.mainGO, targetGO)
end

function M:setClickListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function M:_onClick()
	self._handler:call()
end

return M
