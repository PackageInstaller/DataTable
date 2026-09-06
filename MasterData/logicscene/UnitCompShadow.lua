-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompShadow.lua

module("logicscene.scene.unit.component.UnitCompShadow", package.seeall)

local UnitCompShadow = class("UnitCompShadow", UnitComponentBase)

function UnitCompShadow:ctor(unit)
	UnitCompShadow.super.ctor(self, unit)

	self._shadowObject = nil
end

function UnitCompShadow:onInit()
	self._spine = self._unit.spine

	if self._spine then
		self._spine:addListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
	end
end

function UnitCompShadow:onDestroy()
	if self._shadowObject then
		CommonObjectMgr.instance.shadowPool:returnObject(self._shadowObject)

		self._shadowObject = nil
	end
end

function UnitCompShadow:_onSpineLoaded()
	self._spine:removeListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
	self:_createShadow()
end

function UnitCompShadow:_createShadow()
	self._shadowObject = CommonObjectMgr.instance.shadowPool:fetchObject()

	if not CommonObjectMgr.shadowOrder then
		GoUtil.SetSortingOrder(self._shadowObject, CommonObjectMgr.shadowOrder)
		GoUtil.SetVisible(self._shadowObject, true)
		goutil.addChildToParent(self._shadowObject, self._unit.mountRoot:getEffectRoot())
		Framework.GameObjectUtil.SetLayerRecursively(self._shadowObject, self._unit:getLayer())
		Framework.TransformUtil.SetLocalPos(self._shadowObject.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalRotation(self._shadowObject.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(self._shadowObject.transform, 1, 1, 2)

		if self._unit.modelId then
			local cfg = CharacterConfig.instance:getModelCo(self._unit.modelId)

			if cfg then
				if not cfg.shadowScale then
					printError(string.format(">>>>>>> 通知策划同学，配置 modelId = %d  [m模型配置表]， [shadowScale] 字段", self._unit.modelId))
				end

				local scale = cfg.shadowScale

				Framework.TransformUtil.SetLocalScale(self._shadowObject.transform, scale[1] * 10, scale[2] * 10, 2)
			else
				Framework.TransformUtil.SetLocalScale(self._shadowObject.transform, 0, 0, 2)
			end
		end

		goutil.setActive(self._shadowObject, true)
	end
end

function UnitCompShadow:setActive(visible)
	goutil.setActive(self._shadowObject, visible)
end

return UnitCompShadow
