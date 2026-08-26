-- chunkname: @modules/logic/explore/map/ExploreMapUseItemComp.lua

module("modules.logic.explore.map.ExploreMapUseItemComp", package.seeall)

local ExploreMapUseItemComp = class("ExploreMapUseItemComp", ExploreMapBaseComp)
local occlusionThresholdId = UnityEngine.Shader.PropertyToID("_OcclusionThreshold")

function ExploreMapUseItemComp:onInit()
	self._legalPosDic = {}
	self._pos = Vector2.New()
	self._mo = nil
	self._highLightContainer = UnityEngine.GameObject.New("HighLight")

	gohelper.addChild(self._mapGo, self._highLightContainer)

	self._path = ResUrl.getExploreEffectPath(ExploreConstValue.PlaceEffect)
	self._tempUnitGo = nil
	self._tempUnitLoader = nil
	self._iconLoader = PrefabInstantiate.Create(self._highLightContainer)

	self._iconLoader:startLoad(self._path, self._onAssetLoad, self)
	gohelper.setActive(self._highLightContainer, false)

	self._useList = {}
	self._renderers = {}
end

function ExploreMapUseItemComp:_onAssetLoad()
	local go = self._iconLoader:getInstGO()

	self._goSelect = gohelper.findChild(go, "root/select")

	gohelper.setActive(self._goSelect, false)

	self._diban = {}

	for i = -1, 1 do
		for j = -1, 1 do
			if i ~= 0 or j ~= 0 then
				local key = ExploreHelper.getKeyXY(i, j)

				self._diban[key] = gohelper.findChild(go, "root/diban" .. key)
			end
		end
	end

	if self._mo then
		self:_updateHighLight()
	end
end

function ExploreMapUseItemComp:addEventListeners()
	self.addEventCb(self, ExploreController.instance, ExploreEvent.DragItemBegin, self.changeStatus, self)
end

function ExploreMapUseItemComp:removeEventListeners()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.DragItemBegin, self.changeStatus, self)
end

function ExploreMapUseItemComp:changeStatus(mo)
	if not self:beginStatus(mo) then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end
end

function ExploreMapUseItemComp:_onDragItemBegin(mo)
	if self._mo == mo then
		if self._tempUnitLoader then
			self._tempUnitLoader:dispose()

			self._tempUnitLoader = nil
		end

		gohelper.destroy(self._tempUnitGo)

		self._tempUnitGo = nil

		gohelper.setActive(self._highLightContainer, false)
		self:_resetMat()
		self._map:setMapStatus(ExploreEnum.MapStatus.Normal)
	else
		gohelper.setActive(self._highLightContainer, true)

		self.highLightType = nil
		self._legalPosDic = {}
		self._mo = mo

		local hero = ExploreController.instance:getMap():getHero()
		local heroPos = hero.nodePos

		if hero:isMoving() then
			local key = ExploreHelper.getKey(heroPos)
			local node = ExploreMapModel.instance:getNode(key)

			if ExploreModel.instance:isHeroInControl() and node.nodeType ~= ExploreEnum.NodeType.Ice then
				local pos = hero:stopMoving(false)

				if pos then
					heroPos = pos
				end
			else
				self._map:setMapStatus(ExploreEnum.MapStatus.Normal)
				ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

				return
			end
		end

		if self._tempUnitLoader then
			self._tempUnitLoader:dispose()
		end

		gohelper.destroy(self._tempUnitGo)

		local unitType = tonumber(string.split(mo.config.effect, "#")[2])
		local assetPath = lua_explore_unit.configDict[unitType].asset

		self._tempUnitGo = UnityEngine.GameObject.New("TempUnit")
		self._tempUnitLoader = PrefabInstantiate.Create(self._tempUnitGo)

		self._tempUnitLoader:startLoad(assetPath, self.onUnitLoadEnd, self)
		gohelper.setActive(self._tempUnitGo, false)

		self.highLightType = ExploreEnum.ItemEffectRange.Round

		if self._goSelect then
			self:_updateHighLight(heroPos)
		end
	end
end

function ExploreMapUseItemComp:onUnitLoadEnd()
	local go = self._tempUnitLoader:getInstGO()
	local colliderList = go:GetComponentsInChildren(typeof(UnityEngine.Collider))

	for i = 0, colliderList.Length - 1 do
		colliderList[i].enabled = false
	end
end

function ExploreMapUseItemComp:getCurItemMo()
	return self._mo
end

function ExploreMapUseItemComp:onMapClick(mousePosition)
	local clickComp, pos = self._map:GetTilemapMousePos(mousePosition, true)

	if not self:_setUnit(self._mo.id, pos) then
		self._map:setMapStatus(ExploreEnum.MapStatus.Normal)
	end
end

function ExploreMapUseItemComp:onStatusEnd()
	self:clearDrag()

	if self._confirmView then
		self._confirmView:setTarget()
	end

	if self._tempUnitLoader then
		self._tempUnitLoader:dispose()

		self._tempUnitLoader = nil
	end

	gohelper.destroy(self._tempUnitGo)

	self._tempUnitGo = nil

	gohelper.setActive(self._highLightContainer, false)
	self:_resetMat()
	gohelper.setActive(self._goSelect, false)
end

function ExploreMapUseItemComp:onStatusStart(mo)
	self:_onDragItemBegin(mo)
end

function ExploreMapUseItemComp:clearDrag()
	self.highLightType = nil
	self._mo = nil

	self:_updateHighLight()
end

function ExploreMapUseItemComp:_updateHighLight(heroPos)
	self._useList = {}

	local only4Dir = false

	if self._mo then
		local effect = self._mo.itemEffect

		if effect == ExploreEnum.ItemEffect.CreateUnit2 then
			only4Dir = true
		end
	end

	if self.highLightType == ExploreEnum.ItemEffectRange.Round then
		heroPos = heroPos or self._map:getHeroPos()

		local heroWorldPos = self._map:getHero():getPos()

		transformhelper.setPos(self._highLightContainer.transform, heroWorldPos.x, heroWorldPos.y, heroWorldPos.z)

		for offX = -1, 1 do
			for offY = -1, 1 do
				local nodeKey2 = ExploreHelper.getKeyXY(offX, offY)
				local highLightGo = self._diban[nodeKey2]

				if (offX == 0 and offY == 0) == false and (not only4Dir or offX == 0 or offY == 0) then
					self._pos.x = heroPos.x + offX
					self._pos.y = heroPos.y + offY

					local nodeKey = ExploreHelper.getKey(self._pos)

					self._useList[nodeKey] = highLightGo

					local node = ExploreMapModel.instance:getNode(nodeKey)
					local canPlace = true
					local units = self._map:getUnitByPos(self._pos)

					for _, unit in pairs(units) do
						if unit:isEnter() and not unit.mo.canUseItem then
							canPlace = false

							break
						end
					end

					if canPlace and node and node:isWalkable() then
						local pos = highLightGo.transform.position
						local prePos = pos.y

						pos.y = 10

						local isHit, hitInfo = UnityEngine.Physics.Raycast(pos, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getSceneMask())

						pos.y = isHit and hitInfo.point.y + 0.027 or prePos

						for _, unit in pairs(units) do
							local renderers = unit.go:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

							for i = 0, renderers.Length - 1 do
								local renderer = renderers[i]

								self._renderers[renderer] = self._renderers[renderer] or true

								local material = renderer.material

								material:EnableKeyword("_OCCLUSION_CLIP")
								material:SetFloat(occlusionThresholdId, 0.5)
							end
						end

						gohelper.setActive(highLightGo, true)

						self._legalPosDic[nodeKey] = pos.y
					else
						gohelper.setActive(highLightGo, false)
					end
				else
					gohelper.setActive(highLightGo, false)
				end
			end
		end
	end
end

function ExploreMapUseItemComp:onCancel(pos)
	local nodeKey = ExploreHelper.getKey(pos)

	gohelper.setActive(self._goSelect, false)
	gohelper.setActive(self._useList[nodeKey], true)
	gohelper.setActive(self._tempUnitGo, false)
end

function ExploreMapUseItemComp:_setUnit(id, pos)
	if pos then
		local nodeKey = ExploreHelper.getKey(pos)

		if self._legalPosDic[nodeKey] then
			local audioId = self._mo.config.audioId

			if audioId and audioId > 0 then
				AudioMgr.instance:trigger(audioId)
			end

			local position = self._useList[nodeKey].transform.position

			self._goSelect.transform.position = position
			position.y = self._legalPosDic[nodeKey]
			self._tempUnitGo.transform.position = position

			gohelper.setActive(self._tempUnitGo, true)

			if not self._confirmView then
				self._confirmView = ExploreUseItemConfirmView.New()
			elseif self._confirmView._targetPos then
				local preNodeKey = ExploreHelper.getKey(self._confirmView._targetPos)

				gohelper.setActive(self._useList[preNodeKey], true)
			end

			self._confirmView:setTarget(self._goSelect, pos)
			gohelper.setActive(self._goSelect, true)
			gohelper.setActive(self._useList[nodeKey], false)

			return true
		end
	end
end

function ExploreMapUseItemComp:_resetMat()
	for renderer in pairs(self._renderers) do
		if not tolua.isnull(renderer) then
			local material = renderer.material

			material:DisableKeyword("_OCCLUSION_CLIP")
		end
	end

	self._renderers = {}
end

function ExploreMapUseItemComp:onDestroy()
	if self._confirmView then
		self._confirmView:dispose()

		self._confirmView = nil
	end

	if self._iconLoader then
		self._iconLoader:dispose()

		self._iconLoader = nil
	end

	if self._tempUnitLoader then
		self._tempUnitLoader:dispose()

		self._tempUnitLoader = nil
	end

	self._renderers = {}

	gohelper.destroy(self._tempUnitGo)

	self._tempUnitGo = nil
	self._goSelect = nil
	self._diban = nil
	self._mo = nil

	gohelper.destroy(self._highLightContainer)

	self._highLightContainer = nil

	ExploreMapUseItemComp.super.onDestroy(self)
end

return ExploreMapUseItemComp
