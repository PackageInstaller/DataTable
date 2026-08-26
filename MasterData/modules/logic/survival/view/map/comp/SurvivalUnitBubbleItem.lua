-- chunkname: @modules/logic/survival/view/map/comp/SurvivalUnitBubbleItem.lua

module("modules.logic.survival.view.map.comp.SurvivalUnitBubbleItem", package.seeall)

local SurvivalUnitBubbleItem = class("SurvivalUnitBubbleItem", LuaCompBase)

function SurvivalUnitBubbleItem:ctor(params)
	self._params = params
end

function SurvivalUnitBubbleItem:init(go)
	self.go = go
	self._anim = SLFramework.AnimatorPlayer.Get(go)
	self._icon = gohelper.findChildImage(go, "icon")

	UISpriteSetMgr.instance:setSurvivalSprite(self._icon, "survival_map_emoji_" .. self._params.type)

	if self._params.time > 0 then
		TaskDispatcher.runDelay(self._delayDestroy, self, self._params.time)
	end

	self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollower))

	local entity = SurvivalMapHelper.instance:getEntity(self._params.unitId)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, entity.go.transform, 0, 0.4, 0, 0, 0)
	self._uiFollower:SetEnable(true)
end

function SurvivalUnitBubbleItem:updateParam(params)
	self._params = params

	UISpriteSetMgr.instance:setSurvivalSprite(self._icon, "survival_map_emoji_" .. self._params.type)
	TaskDispatcher.cancelTask(self._delayDestroy, self)

	if self._params.time > 0 then
		TaskDispatcher.runDelay(self._delayDestroy, self, self._params.time)
	end
end

function SurvivalUnitBubbleItem:_delayDestroy()
	self._params.callback(self._params.callobj, self._params.unitId)
end

function SurvivalUnitBubbleItem:tryDestroy()
	TaskDispatcher.cancelTask(self._delayDestroy, self)
	self._anim:Play("close", self._destroySelf, self)
end

function SurvivalUnitBubbleItem:_destroySelf()
	gohelper.destroy(self.go)
end

return SurvivalUnitBubbleItem
