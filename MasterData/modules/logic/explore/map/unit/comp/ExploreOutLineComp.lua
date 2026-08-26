-- chunkname: @modules/logic/explore/map/unit/comp/ExploreOutLineComp.lua

module("modules.logic.explore.map.unit.comp.ExploreOutLineComp", package.seeall)

local ExploreOutLineComp = class("ExploreOutLineComp", LuaCompBase)
local strongColor = Color(0.7529, 0.6831, 0.1721, 1)
local normalColor = Color.white
local blackColor = Color.black
local tweenInTime = 0.5
local tweenOutTime = 0.3
local OutlineLayerIndex = 3

function ExploreOutLineComp:ctor(unit)
	self.unit = unit
end

function ExploreOutLineComp:setup(go)
	self.go = go
	self._renderers = go:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)
	self._iconHangPoint = gohelper.findChild(go, "msts_icon")

	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, self.setCameraPos, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, self.setCameraPos, self)

	local co = lua_explore_unit.configDict[self.unit:getUnitType()]

	if not co then
		return
	end

	if self.unit.mo.isStrong then
		if not co.icon2 then
			local icon = co.icon

			if not string.nilorempty(icon) then
				self._iconPath = "modules/explore/common/sprite/prefabs/" .. icon .. ".prefab"
			end
		end
	end
end

function ExploreOutLineComp:setCameraPos()
	if not self.go or self._renderers.Length <= 0 then
		return
	end

	if self._isOutLight then
		local isVisible = self._renderers[0].isVisible

		if isVisible ~= self._isMarkOutLight then
			if isVisible then
				self._isMarkOutLight = true

				ExploreMapModel.instance:changeOutlineNum(1)

				for i = 0, self._renderers.Length - 1 do
					self._renderers[i].renderingLayerMask = ExploreHelper.setBit(self._renderers[i].renderingLayerMask, OutlineLayerIndex, true)
				end
			else
				self._isMarkOutLight = false

				ExploreMapModel.instance:changeOutlineNum(-1)

				for i = 0, self._renderers.Length - 1 do
					self._renderers[i].renderingLayerMask = ExploreHelper.setBit(self._renderers[i].renderingLayerMask, OutlineLayerIndex, false)
				end
			end
		end
	elseif not self._isOutLight and self._tweenId then
		local isVisible = self._renderers[0].isVisible

		if not isVisible then
			ZProj.TweenHelper.KillById(self._tweenId, true)

			self._tweenId = nil

			TaskDispatcher.cancelTask(self._delayTweenClear, self)
		end
	end
end

function ExploreOutLineComp:setOutLight(isOutLight)
	local _, customShowIcon = self.unit:isCustomShowOutLine()

	if (customShowIcon or isOutLight and self._iconPath) and self._iconHangPoint then
		self._iconLoader = self._iconLoader or PrefabInstantiate.Create(self._iconHangPoint)

		local path = customShowIcon or self._iconPath

		if path ~= self._iconLoader:getPath() then
			self._iconLoader:dispose()
			self._iconLoader:startLoad(path)
		end
	elseif self._iconLoader then
		self._iconLoader:dispose()

		self._iconLoader = nil
	end

	if not self._isOutLight == not isOutLight then
		return
	end

	self._isOutLight = isOutLight

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId, true)
	end

	if not ((self._renderers.Length > 0 or nil) and (ExploreHelper.getDistance(self.unit.nodePos, ExploreController.instance:getMap():getHeroPos()) <= 3 and true or self._renderers[0].isVisible)) then
		if self._isMarkOutLight then
			self._isMarkOutLight = false

			ExploreMapModel.instance:changeOutlineNum(-1)

			for i = 0, self._renderers.Length - 1 do
				self._renderers[i].renderingLayerMask = ExploreHelper.setBit(self._renderers[i].renderingLayerMask, OutlineLayerIndex, false)
			end
		end

		self._isOutLight = false

		return
	end

	for i = 0, self._renderers.Length - 1 do
		self._renderers[i].renderingLayerMask = ExploreHelper.setBit(self._renderers[i].renderingLayerMask, OutlineLayerIndex, true)
	end

	if not self._isMarkOutLight then
		self._isMarkOutLight = true

		ExploreMapModel.instance:changeOutlineNum(1)
	end

	TaskDispatcher.cancelTask(self._delayTweenClear, self)

	if isOutLight then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._nowLerpValue or 0, 1, tweenInTime, self.tweenColor, nil, self)
	else
		TaskDispatcher.runDelay(self._delayTweenClear, self, 0.05)
	end
end

function ExploreOutLineComp:_delayTweenClear()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._nowLerpValue or 1, 0, tweenOutTime, self.tweenColor, self.outLineEnd, self)
end

function ExploreOutLineComp:tweenColor(v)
	if self.unit.mo.isStrong then
		if not strongColor then
			local color = normalColor

			for i = 0, self._renderers.Length - 1 do
				local renderer = self._renderers[i]

				if not tolua.isnull(renderer) then
					self._reuseValue = MaterialUtil.getLerpValue("Color", blackColor, color, v, self._reuseValue)

					MaterialUtil.setPropValue(renderer.material, "_OutlineColor", "Color", self._reuseValue)
				end
			end

			self._nowLerpValue = v
		end
	end
end

function ExploreOutLineComp:outLineEnd()
	for i = 0, self._renderers.Length - 1 do
		local renderer = self._renderers[i]

		if not tolua.isnull(renderer) then
			renderer.renderingLayerMask = ExploreHelper.setBit(renderer.renderingLayerMask, OutlineLayerIndex, false)
		end
	end

	if self._isMarkOutLight then
		self._isMarkOutLight = false

		ExploreMapModel.instance:changeOutlineNum(-1)
	end
end

function ExploreOutLineComp:clear()
	TaskDispatcher.cancelTask(self._delayTweenClear, self)

	self._nowLerpValue = 0

	if self._isMarkOutLight then
		ExploreMapModel.instance:changeOutlineNum(-1)

		self._isMarkOutLight = false
	end

	if self._iconLoader then
		self._iconLoader:dispose()

		self._iconLoader = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._renderers = nil
	self._iconHangPoint = nil
	self._iconPath = nil
	self._isOutLight = false

	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, self.setCameraPos, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, self.setCameraPos, self)
end

function ExploreOutLineComp:onDestroy()
	self:clear()
end

return ExploreOutLineComp
