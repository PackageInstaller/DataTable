-- chunkname: @modules/logic/summon/pool/SummonEffectWrap.lua

module("modules.logic.summon.pool.SummonEffectWrap", package.seeall)

local SummonEffectWrap = class("SummonEffectWrap", LuaCompBase)

function SummonEffectWrap:ctor()
	self.uniqueId = nil
	self.path = nil
	self.containerGO = nil
	self.containerTr = nil
	self.effectGO = nil
	self.hangPointGO = nil
	self._canDestroy = false
	self._animator = nil
	self._animationName = nil
	self._headLoader = nil
	self._frameLoader = nil
	self._active = true
end

function SummonEffectWrap:init(go)
	self.containerGO = go
	self.containerTr = go.transform
end

function SummonEffectWrap:setAnimationName(animationName)
	self._animationName = animationName
end

function SummonEffectWrap:play()
	if self.effectGO then
		self:setActive(true)
	end

	if self._animator and not string.nilorempty(self._animationName) then
		self._animator.enabled = true

		self._animator:Play(self._animationName, 0, 0)
		self._animator:Update(0)

		self._animator.speed = 1
	end
end

function SummonEffectWrap:stop()
	if self._animator and not string.nilorempty(self._animationName) then
		self._animator.enabled = true

		self._animator:Play(self._animationName, 0, 0)
		self._animator:Update(0)

		self._animator.speed = 0
	end

	if self.effectGO then
		self:setActive(false)
	end
end

function SummonEffectWrap:setUniqueId(uniqueId)
	self.uniqueId = uniqueId
end

function SummonEffectWrap:setPath(path)
	self.path = path
end

function SummonEffectWrap:setEffectGO(effectGO)
	self.effectGO = effectGO
	self._animator = effectGO:GetComponentInChildren(typeof(UnityEngine.Animator))
	self._timeScaleComp = nil
	self._particleList = nil
end

function SummonEffectWrap:setHangPointGO(hangPointGO)
	if self.hangPointGO ~= hangPointGO then
		self.hangPointGO = hangPointGO

		self.containerGO.transform:SetParent(self.hangPointGO.transform, true)
		transformhelper.setLocalPos(self.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalRotation(self.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(self.containerGO.transform, 1, 1, 1)
	end
end

function SummonEffectWrap:setActive(isActive)
	self._active = isActive

	if self.containerGO then
		gohelper.setActive(self.containerGO, isActive)
	else
		logError("Effect container is nil, setActive fail: " .. self.path)
	end
end

function SummonEffectWrap:loadHeroIcon(heroId)
	local materialGOPaths = SummonEnum.UIMaterialPath[self.path]

	if not materialGOPaths or #materialGOPaths <= 0 then
		return
	end

	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local skinId = heroConfig.skinId

	if skinId then
		::label_11_0::

		local skinConfig = SkinConfig.instance:getSkinCo(skinId)

		if not skinConfig then
			return
		end

		local url = ResUrl.getHeadIconSmall(skinConfig.headIcon)

		self:loadHeadTex(url)
	end
end

function SummonEffectWrap:loadEquipIcon(equipId)
	local equipCo = EquipConfig.instance:getEquipCo(equipId)

	if not equipCo then
		return
	end

	local url = ResUrl.getEquipIconSmall(equipCo.icon)

	self:loadHeadTex(url)
end

function SummonEffectWrap:setEquipFrame(isOpen)
	if isOpen then
		if not SummonEnum.EquipFloatIconFrameOpened then
			local url = SummonEnum.EquipFloatIconFrameBeforeOpen

			self:_loadFrameTex(url)
		end
	end
end

function SummonEffectWrap:loadEquipWaitingClick()
	local url = SummonEnum.EquipDefaultIconPath

	self:loadHeadTex(url)
end

function SummonEffectWrap:loadHeadTex(url)
	if self._headLoader then
		self._headLoader:dispose()

		self._headLoader = nil
		self._urlHead = nil
	end

	self._urlHead = url
	self._headLoader = MultiAbLoader.New()

	self._headLoader:addPath(url)
	self._headLoader:startLoad(self._onHeadIconLoaded, self)
end

function SummonEffectWrap:_onHeadIconLoaded(multiAbLoader)
	local assetItem = self._headLoader:getAssetItem(self._urlHead)

	if not assetItem then
		return
	end

	local texture = assetItem:GetResource(self._urlHead)
	local materialGOPaths = SummonEnum.UIMaterialPath[self.path]

	for i, materialGOPath in ipairs(materialGOPaths) do
		local materialGO = gohelper.findChild(self.effectGO, materialGOPath)

		if materialGO then
			local renderer = materialGO:GetComponent(typeof(UnityEngine.MeshRenderer))

			if renderer then
				renderer.material:SetTexture("_MainTex", texture)
			end
		end
	end
end

function SummonEffectWrap:_loadFrameTex(url)
	if self._frameLoader then
		self._frameLoader:dispose()

		self._frameLoader = nil
		self._urlFrame = nil
	end

	self._urlFrame = url
	self._frameLoader = MultiAbLoader.New()

	self._frameLoader:addPath(url)
	self._frameLoader:startLoad(self._onFrameTexLoaded, self)
end

function SummonEffectWrap:_onFrameTexLoaded(multiAbLoader)
	local assetItem = self._frameLoader:getAssetItem(self._urlFrame)

	if not assetItem then
		return
	end

	local texture = assetItem:GetResource(self._urlFrame)
	local materialGOPath = SummonEnum.EquipFloatIconFrameNode
	local materialGO = gohelper.findChild(self.effectGO, materialGOPath)

	if materialGO then
		local renderer = materialGO:GetComponent(typeof(UnityEngine.MeshRenderer))

		if renderer then
			renderer.material:SetTexture("_MainTex", texture)
		end
	end
end

function SummonEffectWrap:unloadIcon()
	if self._headLoader then
		self._headLoader:dispose()

		self._headLoader = nil
	end

	local materialGOPaths = SummonEnum.UIMaterialPath[self.path]

	if not materialGOPaths or #materialGOPaths <= 0 then
		return
	end

	for i, materialGOPath in ipairs(materialGOPaths) do
		local materialGO = gohelper.findChild(self.effectGO, materialGOPath)

		if materialGO then
			local renderer = materialGO:GetComponent(typeof(UnityEngine.MeshRenderer))

			if renderer then
				renderer.material:SetTexture("_MainTex", nil)
			end
		end
	end
end

function SummonEffectWrap:setSpeed(value)
	self:checkInitSpeedComponents()
	self._timeScaleComp:SetTimeScale(value)
end

function SummonEffectWrap:checkInitSpeedComponents()
	if gohelper.isNil(self._timeScaleComp) then
		self._timeScaleComp = gohelper.onceAddComponent(self.effectGO, typeof(ZProj.EffectTimeScale))
	end
end

function SummonEffectWrap:markCanDestroy()
	self._canDestroy = true
end

function SummonEffectWrap:getIsActive()
	return self._active == true
end

function SummonEffectWrap:startParticle()
	self:checkInitParticle()

	for _, ps in ipairs(self._particleList) do
		ps:Play()
	end
end

function SummonEffectWrap:stopParticle()
	self:checkInitParticle()

	for _, ps in ipairs(self._particleList) do
		ps:Stop()
	end
end

function SummonEffectWrap:checkInitParticle()
	if not self._particleList then
		self._particleList = self:getUserDataTb_()

		if not gohelper.isNil(self.effectGO) then
			local particles = self.effectGO:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true)
			local iter = particles:GetEnumerator()

			while iter:MoveNext() do
				table.insert(self._particleList, iter.Current)
			end
		end
	end
end

function SummonEffectWrap:onDestroy()
	if not self._canDestroy then
		logError("Effect destroy unexpected: " .. self.path)
	end

	self.containerGO = nil
	self.effectGO = nil
	self.hangPointGO = nil
	self._particleList = nil

	if self._headLoader then
		self._headLoader:dispose()

		self._headLoader = nil
	end

	if self._frameLoader then
		self._frameLoader:dispose()

		self._frameLoader = nil
	end
end

return SummonEffectWrap
