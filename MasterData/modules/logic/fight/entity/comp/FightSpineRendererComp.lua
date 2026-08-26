-- chunkname: @modules/logic/fight/entity/comp/FightSpineRendererComp.lua

module("modules.logic.fight.entity.comp.FightSpineRendererComp", package.seeall)

local FightSpineRendererComp = class("FightSpineRendererComp", FightBaseClass)
local ShaderColorName = "_ScriptCtrlColor"

function FightSpineRendererComp:onConstructor(entity)
	self._entity = entity
	self._color = nil
	self._unitSpine = nil
	self._alphaTweenId = nil
	self.go = entity.go
	self.waitingReplaceMat = false
end

function FightSpineRendererComp:onDestructor()
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
	self.waitingReplaceMat = nil

	TaskDispatcher.cancelTask(self.resetWaitFlag, self)
end

function FightSpineRendererComp:setSpine(unitSpine)
	self._unitSpine = unitSpine
	self._skeletonAnim = self._unitSpine:getSpineGO():GetComponent(FightSpineComp.TypeSkeletonAnimtion)
	self._spineRenderer = self._unitSpine:getSpineGO():GetComponent(typeof(UnityEngine.MeshRenderer))

	if not gohelper.isNil(unitSpine:getSpineGO()) then
		self._sharedMaterial = self:_getSpinePrimaryMaterial()

		if self._replaceMat then
			self:replaceSpineMat(self._replaceMat)
		end
	end
end

function FightSpineRendererComp:hasSkeletonAnim()
	return not gohelper.isNil(self._skeletonAnim)
end

function FightSpineRendererComp:_getSpinePrimaryMaterial()
	if gohelper.isNil(self._skeletonAnim) then
		return
	end

	return self._skeletonAnim.skeletonDataAsset.atlasAssets[0].PrimaryMaterial
end

function FightSpineRendererComp:getReplaceMat()
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

function FightSpineRendererComp:getCloneOriginMat()
	return self._cloneOriginMat
end

function FightSpineRendererComp:getSpineRenderMat()
	if not self._spineRenderer then
		return
	end

	if self.waitingReplaceMat then
		-- block empty
	end

	return self._spineRenderer.material
end

function FightSpineRendererComp:_setReplaceMat(originMat, replaceMat)
	if gohelper.isNil(originMat) then
		return
	end

	if self._skeletonAnim then
		local dict = self._skeletonAnim.CustomMaterialOverride

		if dict then
			dict:Clear()

			if not gohelper.isNil(replaceMat) then
				dict:Add(originMat, replaceMat)
				self:setWaitFlag()
			end
		end
	end
end

function FightSpineRendererComp:setWaitFlag()
	self.waitingReplaceMat = true

	TaskDispatcher.cancelTask(self.resetWaitFlag, self)
	TaskDispatcher.runDelay(self.resetWaitFlag, self, 0.01)

	if isDebugBuild then
		logNormal(string.format("[%s] set waitingReplaceMat true", Time.frameCount))
		logNormal(debug.traceback())
	end
end

function FightSpineRendererComp:resetWaitFlag()
	self.waitingReplaceMat = false
end

function FightSpineRendererComp:replaceSpineMat(mat)
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

function FightSpineRendererComp:resetSpineMat()
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

function FightSpineRendererComp:setAlpha(alpha, duration)
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

function FightSpineRendererComp:setColor(color)
	local replaceMat = self:getReplaceMat()

	replaceMat:SetColor(ShaderColorName, color)

	if self._cloneOriginMat and self._cloneOriginMat ~= replaceMat then
		self._cloneOriginMat:SetColor(ShaderColorName, color)
	end
end

function FightSpineRendererComp:_frameCallback(alpha)
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

function FightSpineRendererComp:_finishCallback()
	local replaceMat = self:getReplaceMat()
	local color = replaceMat and replaceMat:GetColor(ShaderColorName)

	self:_setRendererEnabled(color and color.a > 0)

	self._color = nil
end

function FightSpineRendererComp:_stopAlphaTween()
	if self._alphaTweenId then
		ZProj.TweenHelper.KillById(self._alphaTweenId)

		self._alphaTweenId = nil
	end
end

function FightSpineRendererComp:_setRendererEnabled(state)
	if self._spineRenderer then
		self._spineRenderer.enabled = state
	end
end

return FightSpineRendererComp
