-- chunkname: @modules/spine/UnitSpineRenderer.lua

module("modules.spine.UnitSpineRenderer", package.seeall)

local UnitSpineRenderer = class("UnitSpineRenderer", LuaCompBase)
local ShaderColorName = "_ScriptCtrlColor"

function UnitSpineRenderer:ctor(entity)
	self._entity = entity
	self._color = nil
	self._unitSpine = nil
	self._alphaTweenId = nil
end

function UnitSpineRenderer:init(go)
	self.go = go
end

function UnitSpineRenderer:onDestroy()
	self:_stopAlphaTween()
	gohelper.destroy(self._replaceMat)
	gohelper.destroy(self._cloneOriginMat)

	self._color = nil
	self._unitSpine = nil
	self._skeletonAnim = nil
	self._spineRenderer = nil
	self._replaceMat = nil
	self._sharedMaterial = nil
	self._cloneOriginMat = nil
end

function UnitSpineRenderer:setSpine(unitSpine)
	self._unitSpine = unitSpine
	self._skeletonAnim = self._unitSpine:getSpineGO():GetComponent(UnitSpine.TypeSkeletonAnimtion)
	self._spineRenderer = self._unitSpine:getSpineGO():GetComponent(typeof(UnityEngine.MeshRenderer))

	if not gohelper.isNil(unitSpine:getSpineGO()) then
		self._sharedMaterial = self:_getSpinePrimaryMaterial()

		if self._replaceMat then
			self:replaceSpineMat(self._replaceMat)
		end
	end
end

function UnitSpineRenderer:hasSkeletonAnim()
	return gohelper.isNil(self._skeletonAnim) ~= nil
end

function UnitSpineRenderer:_getSpinePrimaryMaterial()
	if gohelper.isNil(self._skeletonAnim) then
		return
	end

	return self._skeletonAnim.skeletonDataAsset.atlasAssets[0].PrimaryMaterial
end

function UnitSpineRenderer:getReplaceMat()
	if not self._replaceMat then
		local mat = self:_getSpinePrimaryMaterial()

		if not mat then
			return
		end

		self._replaceMat = UnityEngine.Material.New(mat)
		self._cloneOriginMat = self._replaceMat

		if self._sharedMaterial and self._replaceMat then
			self:_setReplaceMat(self._sharedMaterial, self._replaceMat)
		end
	end

	return self._replaceMat
end

function UnitSpineRenderer:getCloneOriginMat()
	return self._cloneOriginMat
end

function UnitSpineRenderer:getSpineRenderMat()
	return self._spineRenderer and self._spineRenderer.material
end

function UnitSpineRenderer:_setReplaceMat(originMat, replaceMat)
	if gohelper.isNil(originMat) then
		return
	end

	if self._skeletonAnim then
		local dict = self._skeletonAnim.CustomMaterialOverride

		if dict then
			dict:Clear()

			if not gohelper.isNil(replaceMat) then
				dict:Add(originMat, replaceMat)
			end
		end
	end
end

function UnitSpineRenderer:replaceSpineMat(mat)
	if mat then
		self._replaceMat = mat

		if self._skeletonAnim then
			local curMat = self:getSpineRenderMat()

			FightSpineMatPool.returnMat(curMat)
			self:_setReplaceMat(self._sharedMaterial, self._replaceMat)
			self._replaceMat:SetTexture("_MainTex", curMat:GetTexture("_MainTex"))
			self._replaceMat:SetTexture("_NormalMap", curMat:GetTexture("_NormalMap"))
			self._replaceMat:SetVector("_RoleST", curMat:GetVector("_RoleST"))
			self._replaceMat:SetVector("_RoleSheet", curMat:GetVector("_RoleSheet"))
		end
	else
		logError("replaceSpineMat fail, mat = nil")
	end
end

function UnitSpineRenderer:resetSpineMat()
	if self._replaceMat then
		if self._cloneOriginMat then
			if self._replaceMat ~= self._cloneOriginMat then
				FightSpineMatPool.returnMat(self._replaceMat)

				self._replaceMat = self._cloneOriginMat

				self:_setReplaceMat(self._sharedMaterial, self._cloneOriginMat)
			end
		else
			FightSpineMatPool.returnMat(self._replaceMat)

			self._replaceMat = nil

			self:getReplaceMat()
		end
	end
end

function UnitSpineRenderer:setAlpha(alpha, duration)
	if not self._unitSpine then
		return
	end

	local sharedMaterial = self._sharedMaterial

	if gohelper.isNil(sharedMaterial) or not sharedMaterial:HasProperty(ShaderColorName) then
		return
	end

	self:_stopAlphaTween()

	local replaceMat = self:getReplaceMat()

	self._color = self._color or replaceMat:GetColor(ShaderColorName)

	if self._color.a == alpha then
		self:setColor(self._color)
		self:_setRendererEnabled(alpha > 0)

		return
	end

	if not duration or duration <= 0 then
		self._color.a = alpha

		self:setColor(self._color)
		self:_setRendererEnabled(alpha > 0)

		return
	end

	self:_setRendererEnabled(true)

	self._alphaTweenId = ZProj.TweenHelper.DOTweenFloat(self._color.a, alpha, duration, self._frameCallback, self._finishCallback, self)
end

function UnitSpineRenderer:setColor(color)
	local replaceMat = self:getReplaceMat()

	replaceMat:SetColor(ShaderColorName, color)

	if self._cloneOriginMat and self._cloneOriginMat ~= replaceMat then
		self._cloneOriginMat:SetColor(ShaderColorName, color)
	end
end

function UnitSpineRenderer:_frameCallback(alpha)
	if not self._unitSpine then
		return
	end

	local replaceMat = self:getReplaceMat()

	self._color = self._color or replaceMat:GetColor(ShaderColorName)

	if self._color.a == alpha then
		self:setColor(self._color)
		self:_setRendererEnabled(alpha > 0)

		return
	end

	self._color.a = alpha

	self:setColor(self._color)
	self:_setRendererEnabled(alpha > 0)
end

function UnitSpineRenderer:_finishCallback()
	local replaceMat = self:getReplaceMat()
	local color = replaceMat and replaceMat:GetColor(ShaderColorName)

	self:_setRendererEnabled(color and color.a > 0)

	self._color = nil
end

function UnitSpineRenderer:_stopAlphaTween()
	if self._alphaTweenId then
		ZProj.TweenHelper.KillById(self._alphaTweenId)

		self._alphaTweenId = nil
	end
end

function UnitSpineRenderer:_setRendererEnabled(state)
	if self._spineRenderer then
		self._spineRenderer.enabled = state
	end
end

return UnitSpineRenderer
