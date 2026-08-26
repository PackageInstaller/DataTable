-- chunkname: @modules/spine/UnitSpine.lua

module("modules.spine.UnitSpine", package.seeall)

local UnitSpine = class("UnitSpine", LuaCompBase)

UnitSpine.TypeSkeletonAnimtion = typeof(Spine.Unity.SkeletonAnimation)
UnitSpine.TypeSpineAnimationEvent = typeof(ZProj.SpineAnimationEvent)
UnitSpine.Evt_OnLoaded = 100001

function UnitSpine.Create(gameObj)
	return MonoHelper.addNoUpdateLuaComOnceToGo(gameObj, UnitSpine)
end

function UnitSpine:ctor(unitSpawn)
	self.unitSpawn = unitSpawn

	LuaEventSystem.addEventMechanism(self)
end

function UnitSpine:init(go)
	self._gameObj = go
	self._gameTr = go.transform
	self._resLoader = nil
	self._resPath = nil
	self._skeletonAnim = nil
	self._spineRenderer = nil
	self._ppEffectMask = nil
	self._spineGo = nil
	self._spineTr = nil
	self._curAnimState = nil
	self._defaultAnimState = SpineAnimState.idle1
	self._isLoop = false
	self._lookDir = SpineLookDir.Left
	self._timeScale = 1
	self._bFreeze = false
	self._layer = UnityLayer.Unit
	self._actionCbList = {}
	self._resLoadedCb = nil
	self._resLoadedCbObj = nil
end

function UnitSpine:setResPath(resPath, loadedCb, loadedCbObj)
	if not resPath then
		return
	end

	if self.resPath == resPath then
		return
	end

	self:_clear()

	self._resPath = resPath
	self._resLoadedCb = loadedCb
	self._resLoadedCbObj = loadedCbObj

	local spineFromPool = FightSpinePool.getSpine(self._resPath)

	if spineFromPool then
		if gohelper.isNil(self._gameObj) then
			logError("try move spine, but parent is nil, spine name : " .. tostring(spineFromPool.name))
		end

		gohelper.addChild(self._gameObj, spineFromPool)
		transformhelper.setLocalPos(spineFromPool.transform, 0, 0, 0)
		self:_initSpine(spineFromPool)
	else
		self._resLoader = MultiAbLoader.New()

		self._resLoader:addPath(self._resPath)
		self._resLoader:startLoad(self._onResLoaded, self)
	end
end

function UnitSpine:setFreeze(isFreeze)
	self._bFreeze = isFreeze

	if self._skeletonAnim then
		self._skeletonAnim.freeze = self._bFreeze
	end
end

function UnitSpine:setTimeScale(timeScale)
	self._timeScale = timeScale

	if self._skeletonAnim then
		self._skeletonAnim.timeScale = self._timeScale
	end
end

function UnitSpine:_clear()
	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	if self._csSpineEvt then
		self._csSpineEvt:RemoveAnimEventCallback()
	end

	self._skeletonAnim = nil
	self._resPath = nil
	self._spineGo = nil
	self._spineTr = nil
	self._bFreeze = false
	self._isActive = true
	self._renderOrder = nil
end

function UnitSpine:_onResLoaded(loader)
	if gohelper.isNil(self._gameObj) then
		return
	end

	local assetItem = loader:getFirstAssetItem()

	if assetItem then
		local prefab = assetItem:GetResource()
		local spineGO = gohelper.clone(prefab, self._gameObj)

		self:_initSpine(spineGO)
	end
end

function UnitSpine:_initSpine(spineGO)
	self._spineGo = spineGO
	self._spineTr = self._spineGo.transform

	self:setLayer(self._layer, true)

	self._skeletonAnim = self._spineGo:GetComponent(UnitSpine.TypeSkeletonAnimtion)

	if self._lookDir == SpineLookDir.Right then
		self._skeletonAnim.initialFlipX = true

		self._skeletonAnim:Initialize(true)
	else
		self._skeletonAnim:Initialize(false)
	end

	self._skeletonAnim.freeze = self._bFreeze
	self._skeletonAnim.timeScale = self._timeScale
	self._spineRenderer = self._spineGo:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._ppEffectMask = self._spineGo:GetComponent(typeof(UrpCustom.PPEffectMask))
	self._csSpineEvt = gohelper.onceAddComponent(self._spineGo, UnitSpine.TypeSpineAnimationEvent)

	self._csSpineEvt:SetAnimEventCallback(self._onAnimCallback, self)
	self:setActive(self._isActive)

	if self._curAnimState then
		local animState = self._curAnimState

		self._curAnimState = nil

		self:play(animState, self._isLoop)
	elseif self._defaultAnimState and self._skeletonAnim:HasAnimation(self._defaultAnimState) then
		self._isLoop = true

		self:play(self._defaultAnimState, self._isLoop, true)
	end

	self:setRenderOrder(self._renderOrder, true)

	if self._resLoadedCb and self._resLoadedCbObj then
		self._resLoadedCb(self._resLoadedCbObj, self)
	end

	self._resLoadedCb = nil
	self._resLoadedCbObj = nil

	self:dispatchEvent(UnitSpine.Evt_OnLoaded)
end

function UnitSpine:setLayer(layer, recursive)
	self._layer = layer

	if not gohelper.isNil(self._spineGo) then
		gohelper.setLayer(self._spineGo, self._layer, recursive)
	end
end

function UnitSpine:getSpineGO()
	return self._spineGo
end

function UnitSpine:getSpineTr()
	return self._spineTr
end

function UnitSpine:getSkeletonAnim()
	return self._skeletonAnim
end

function UnitSpine:getAnimState()
	return self._curAnimState or self._defaultAnimState
end

function UnitSpine:getPPEffectMask()
	return self._ppEffectMask
end

function UnitSpine:setRenderOrder(order, force)
	if not order then
		return
	end

	local oldOrder = self._renderOrder

	self._renderOrder = order

	if not force and order == oldOrder then
		return
	end

	if not gohelper.isNil(self._spineRenderer) then
		self._spineRenderer.sortingOrder = order
	end
end

function UnitSpine:changeLookDir(dir)
	if dir == self._lookDir then
		return
	end

	self._lookDir = dir

	self:_changeLookDir()
end

function UnitSpine:_changeLookDir()
	if self._skeletonAnim then
		self._skeletonAnim:SetScaleX(self._lookDir)
	end
end

function UnitSpine:getLookDir()
	return self._lookDir
end

function UnitSpine:setActive(isActive)
	if self._spineGo then
		gohelper.setActive(self._spineGo, isActive)
	else
		self._isActive = isActive
	end
end

function UnitSpine:play(animState, loop, reStart)
	if not animState then
		return
	end

	local needPlay = reStart or animState ~= self._curAnimState or loop ~= self._isLoop

	self._curAnimState = animState
	self._isLoop = loop or false
	reStart = reStart or false

	if self._skeletonAnim and needPlay then
		if self._skeletonAnim:HasAnimation(animState) then
			self:playAnim(animState, self._isLoop, reStart)
		else
			if isDebugBuild then
				if not gohelper.isNil(self._spineGo) then
					if not self._spineGo.name then
						local cloneName = "spine_nil"
						local begin = string.find(cloneName, "(Clone)", 1)
						local spineName = begin and string.sub(cloneName, 1, begin - 2) or cloneName

						if animState ~= "posture" then
							logError(string.format("%s 缺少动作: %s", spineName, animState))
						end
					end
				end
			end

			self:playAnim(SpineAnimState.idle1, true, true)
		end
	end
end

function UnitSpine:hasAnimation(animState)
	if self._skeletonAnim then
		return self._skeletonAnim:HasAnimation(animState)
	end

	return false
end

function UnitSpine:playAnim(animState, loop, reStart)
	self._skeletonAnim:PlayAnim(animState, loop, reStart)
end

function UnitSpine:setAnimation(animState, loop, mixTime)
	if self._skeletonAnim then
		self._curAnimState = animState
		self._isLoop = loop or false

		self._skeletonAnim:SetAnimation(0, animState, loop, mixTime or 0)
	end
end

function UnitSpine:addAnimEventCallback(animEvtCb, animEvtCbObj, param)
	if not animEvtCb then
		return
	end

	for i, cbTable in ipairs(self._actionCbList) do
		local callback = cbTable[1]
		local callbackObj = cbTable[2]

		if callback == animEvtCb and callbackObj == animEvtCbObj then
			cbTable[3] = param

			return
		end
	end

	table.insert(self._actionCbList, {
		animEvtCb,
		animEvtCbObj,
		param
	})
end

function UnitSpine:removeAnimEventCallback(animEvtCb, animEvtCbObj)
	for i, cbTable in ipairs(self._actionCbList) do
		local callback = cbTable[1]
		local callbackObj = cbTable[2]

		if callback == animEvtCb and callbackObj == animEvtCbObj then
			table.remove(self._actionCbList, i)

			break
		end
	end
end

function UnitSpine:removeAllAnimEventCallback()
	self._actionCbList = {}
end

function UnitSpine:_onAnimCallback(actionName, eventName, eventArgs)
	for i, cbTable in ipairs(self._actionCbList) do
		local callback = cbTable[1]
		local callbackObj = cbTable[2]
		local param = cbTable[3]

		if callbackObj then
			callback(callbackObj, actionName, eventName, eventArgs, param)
		else
			callback(actionName, eventName, eventArgs, param)
		end
	end
end

function UnitSpine:logNilGameObj()
	return
end

function UnitSpine:onDestroy()
	self:_clear()

	self._resLoader = nil
	self._csSpineEvt = nil
end

return UnitSpine
