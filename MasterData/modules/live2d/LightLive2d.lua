-- chunkname: @modules/live2d/LightLive2d.lua

module("modules.live2d.LightLive2d", package.seeall)

local LightLive2d = class("LightLive2d", BaseLive2d)
local CubismSortingMode = Live2D.Cubism.Rendering.CubismSortingMode

function LightLive2d.Create(gameObj, isStory)
	local ret = MonoHelper.addNoUpdateLuaComOnceToGo(gameObj, LightLive2d)

	ret._isStory = isStory

	return ret
end

function LightLive2d:_onResLoaded()
	self._recalcBounds = true
	self._sharedMaterials = nil

	LightLive2d.super._onResLoaded(self)
	self:_initSkinUiEffect()
end

function LightLive2d:_clear()
	LightLive2d.super._clear(self)

	self._sharedMaterials = nil
end

function LightLive2d:_initSkinUiEffect()
	self._uiEffectList = nil
	self._uiEffectConfig = nil

	for i, v in ipairs(lua_skin_ui_effect.configList) do
		if string.find(self._resPath, v.id) then
			self._uiEffectConfig = v
			self._uiEffectList = string.split(v.effect, "|")

			break
		end
	end

	self._effectMainFrameList = nil

	for i, v in ipairs(lua_skin_effect_mainframe.configList) do
		if string.find(self._resPath, v.id) then
			self._effectMainFrameList = string.split(v.effect, "|")

			break
		end
	end

	self:_fakeUIEffect()
end

function LightLive2d:_fakeUIEffect()
	local config, effectList = Live2dSpecialLogic.getFakeUIEffect(self._resPath)

	if not config or not effectList then
		return
	end

	self._uiEffectConfig = config
	self._uiEffectList = effectList
end

function LightLive2d:processModelEffect()
	if self._uiEffectList and self._uiEffectConfig.changeVisible == 1 then
		for i, v in ipairs(self._uiEffectList) do
			local root = gohelper.findChild(self._spineGo, v)

			gohelper.setActive(root.gameObject, false)
			gohelper.setActive(root.gameObject, true)
		end
	end
end

function LightLive2d:setEffectVisible(value)
	if self._uiEffectList and self._uiEffectConfig.delayVisible == 1 then
		for i, v in ipairs(self._uiEffectList) do
			local root = gohelper.findChild(self._spineGo, v)

			gohelper.setActive(root, value)
		end
	end
end

function LightLive2d:setEffectFrameVisible(value)
	self:showEverNodes(value)

	if self._uiEffectList and self._uiEffectConfig.frameVisible == 1 then
		for i, v in ipairs(self._uiEffectList) do
			local root = gohelper.findChild(self._spineGo, v)

			gohelper.setActive(root, value)
		end
	end

	if self._effectMainFrameList then
		local recordMap = {}

		for i, v in ipairs(self._effectMainFrameList) do
			local root = gohelper.findChild(self._spineGo, v)

			gohelper.setActive(root, value)

			if not recordMap[v] then
				recordMap[v] = true

				if root then
					local parent = root.transform.parent

					if parent and parent.name ~= "Drawables" then
						gohelper.setActive(parent, value)
					end

					if value then
						transformhelper.setLocalScale(root.transform, 1, 1, 1)
					else
						local x, y, z = transformhelper.getLocalScale(root.transform)

						if x ~= 1 or y ~= 1 or z ~= 1 then
							logError("LightLive2d:setEffectFrameVisible scale is not 1,1,1 value:", tostring(x), tostring(y), tostring(z), v)
						end

						transformhelper.setLocalScale(root.transform, 0, 0, 0)
					end
				else
					logError("LightLive2d:setEffectFrameVisible can not find child:", self._resPath, v)
				end
			else
				logError("LightLive2d:setEffectFrameVisible repeat:", self._resPath, v)
			end
		end
	end
end

function LightLive2d:getBoundsMinMaxPos()
	if not self._recalcBounds then
		return self._boundsMin, self._boundsMax
	end

	self._recalcBounds = true
	self._boundsMin = nil
	self._boundsMax = nil

	local list = self._spineGo:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	for i = 0, list.Length - 1 do
		local meshRenderer = list[i]
		local bounds = meshRenderer.bounds
		local min = bounds.min
		local max = bounds.max

		self._boundsMin = Vector3.Min(min, self._boundsMin or min)
		self._boundsMax = Vector3.Max(max, self._boundsMax or max)
	end

	return self._boundsMin, self._boundsMax
end

function LightLive2d:setStencilRef(iValue)
	if gohelper.isNil(self._spineGo) then
		return
	end

	local mats = self:getSharedMaterials()

	for _, v in ipairs(mats) do
		v:SetFloat(ShaderPropertyId.Stencil, iValue)
	end
end

function LightLive2d:setStencilValues(ref, comp, op)
	if gohelper.isNil(self._spineGo) then
		return
	end

	local mats = self:getSharedMaterials()

	for _, v in ipairs(mats) do
		v:SetFloat(ShaderPropertyId.Stencil, ref)
		v:SetFloat(ShaderPropertyId.StencilComp, comp)
		v:SetFloat(ShaderPropertyId.StencilOp, op)
	end
end

function LightLive2d:changeRenderQueue(value)
	local mats = self:getSharedMaterials()

	for i, v in ipairs(mats) do
		v.renderQueue = value
	end

	if not self._cubismController then
		return
	end

	if value == -1 then
		self._cubismController:SetSortingMode(CubismSortingMode.BackToFrontZ)
	else
		self._cubismController:SetSortingMode(CubismSortingMode.BackToFrontOrder)
	end
end

function LightLive2d:changeSortingMode(mode)
	if not self._cubismController then
		return
	end

	self._cubismController:SetSortingMode(mode)
end

function LightLive2d:getSharedMaterials()
	if not self._sharedMaterials then
		self._sharedMaterials = {}

		local list = self._spineGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, list.Length - 1 do
			local meshRenderer = list[i]
			local mat = meshRenderer.sharedMaterial

			table.insert(self._sharedMaterials, mat)
		end
	end

	return self._sharedMaterials
end

function LightLive2d:clearSharedMaterials()
	self._sharedMaterials = nil
end

function LightLive2d:setMainColor(color)
	if self._cubismController then
		self._cubismController:SetMainColor(color)
	end
end

function LightLive2d:setLumFactor(value)
	if self._cubismController then
		self._cubismController:SetLumFactor(value)
	end
end

function LightLive2d:setEmissionColor(color)
	if self._cubismController then
		self._cubismController:SetEmissionColor(color)
	end
end

return LightLive2d
