-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/photo/PhotoEffect.lua

module("logiccommon.common.viewlib.photo.PhotoEffect", package.seeall)

local PhotoEffect = class("PhotoEffect")

function PhotoEffect.Get(go)
	return Framework.LuaComponentContainer.Add(go, PhotoEffect)
end

function PhotoEffect:ctor(container)
	self._go = container.gameObject
	self._transform = self._go.transform
	self._multiLoader = MultiResLoader.New()
	self._photo = Framework.PhotoBase.Add(self._go)
	self._targetGoes = {}
	self._effectLoadedCallback = nil
	self._effectLoadedCallbackObj = nil
end

function PhotoEffect:setCameraPosition(x, y, z)
	self._photo:SetCameraPosition(x, y, z)
end

function PhotoEffect:setCameraRotation(x, y, z)
	self._photo:SetCameraRotation(x, y, z)
end

function PhotoEffect:setCameraSize(size)
	self._photo.producer.rtCamera.orthographicSize = size
end

function PhotoEffect:setEffectLoadedCallback(callback, callbackObj)
	self._effectLoadedCallback = callback
	self._effectLoadedCallbackObj = callbackObj
end

function PhotoEffect:showEffects(...)
	local urls = {
		...
	}

	if not urls then
		return
	end

	PhotoCacheMgr.instance:checkPhotoGo(self._go)
	goutil.setActive(self._go, true)
	self._photo:TurnOn()
	self._photo:SetCameraPosition(0, 0, 0)
	self._photo:SetCameraRotation(0, 0, 0)

	self._photo.producer.rtCamera.orthographicSize = 2

	for k, v in pairs(self._targetGoes) do
		goutil.destroy(v)

		self._targetGoes[k] = nil
	end

	self._multiLoader:clear()

	local len = #urls

	for i = 1, len do
		self._multiLoader:addResPath(urls[i], true)
	end

	self._multiLoader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function PhotoEffect:showEffectWithWH(url, w, h)
	goutil.setActive(self._go, true)
	self._photo:TurnOn(w, h)
	self._photo:SetCameraPosition(0, 0, 0)
	self._photo:SetCameraRotation(0, 0, 0)

	for k, v in pairs(self._targetGoes) do
		goutil.destroy(v)

		self._targetGoes[k] = nil
	end

	self._multiLoader:clear()
	self._multiLoader:addResPath(url, true)
	self._multiLoader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function PhotoEffect:showEffectsFullScreen(urls, x, y)
	if not urls then
		return
	end

	goutil.setActive(self._go, true)

	if x == nil or y == nil then
		x, y = PhotoCacheMgr.instance:getFullScreenTextureSize()
	end

	Framework.PhotoProducerCache.Instance:SetCapacity(x, y, 2)
	self._photo:TurnOn(x, y)
	self._photo:SetCameraPosition(0, 0, 0)
	self._photo:SetCameraRotation(0, 0, 0)
	self:setCameraSize(3)

	for k, v in pairs(self._targetGoes) do
		goutil.destroy(v)

		self._targetGoes[k] = nil
	end

	self._multiLoader:clear()

	local len = #urls

	for i = 1, len do
		self._multiLoader:addResPath(urls[i], true)
	end

	self._multiLoader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function PhotoEffect:_onOneLoaded(res)
	if res.IsSuccess then
		local inst = goutil.clone(res:GetAsset(nil, nil))

		self._photo:ShowTarget(inst, true)

		self._targetGoes[res.ResPath] = inst

		if self._effectLoadedCallback then
			if self._effectLoadedCallbackObj then
				self._effectLoadedCallback(self._effectLoadedCallbackObj, inst, res)
			else
				self._effectLoadedCallback(inst, res)
			end
		end
	end
end

function PhotoEffect:_onAllLoaded(loader)
	return
end

function PhotoEffect:showEffectsFullScreenWithTarget(targetgo, allSameLayer, x, y)
	if not targetgo then
		return
	end

	local isAllSameLayer = true

	if allSameLayer ~= nil then
		isAllSameLayer = allSameLayer
	end

	goutil.setActive(self._go, true)
	goutil.setActive(targetgo, true)
	table.insert(self._targetGoes, targetgo)

	local screenW, screenH = PhotoCacheMgr.instance:getFullScreenTextureSize()
	local imgSizeX = x or screenW
	local imgSizeY = y or screenH

	self._photo:TurnOn(imgSizeX, imgSizeY)
	self._photo:SetCameraPosition(0, 0, 0)
	self._photo:SetCameraRotation(0, 0, 0)

	self._photo.producer.rtCamera.orthographicSize = 3

	self._photo:ShowTarget(targetgo, isAllSameLayer)
end

function PhotoEffect:clear()
	self:_stopTween()
	self._photo:TurnOff()

	for k, v in pairs(self._targetGoes) do
		goutil.destroy(v)

		self._targetGoes[k] = nil
	end

	self._multiLoader:clear()
end

function PhotoEffect:doTargetContainerScaleTween(scale, duration)
	local targetScaleV3

	if type(scale) == "table" then
		targetScaleV3 = Vector3.New(scale.x, scale.y, scale.z)
	else
		scale = scale or 1
		targetScaleV3 = Vector3.New(scale, scale, scale)
	end

	local _targetContainer = self._photo.producer.targetContainer

	if self._tweenScale == nil then
		local cv3 = GameUtil.getLocalScale(_targetContainer)

		self._tweenScale = UnityTweens.TweenScale.Create(_targetContainer, cv3, targetScaleV3, duration)
	else
		self._tweenScale.from = GameUtil.getLocalScale(_targetContainer)
		self._tweenScale.to = targetScaleV3
		self._tweenScale.time = duration
	end

	self._tweenScale:Stop()
	self._tweenScale:Begin()
end

function PhotoEffect:doTargetContainerPosTween(x, y, duration)
	local _targetContainer = self._photo.producer.targetContainer

	if self._tweenPosition == nil then
		local cv3 = GameUtil.getLocalPos(_targetContainer)

		self._tweenPosition = UnityTweens.TweenPosition.Create(_targetContainer, cv3, Vector2.New(x, y), duration)
	else
		self._tweenPosition.from = GameUtil.getLocalPos(_targetContainer)
		self._tweenPosition.to = Vector2.New(x, y)
		self._tweenPosition.time = duration
	end

	self._tweenPosition:Stop()
	self._tweenPosition:Begin()
end

function PhotoEffect:OnDestroy()
	self:clear()

	self._multiLoader = nil
	self._photo = nil
	self._targetGoes = nil
	self._go = nil
	self._transform = nil
end

function PhotoEffect:_stopTween()
	if self._tweenScale then
		self._tweenScale:Stop()

		self._tweenScale = nil
	end

	if self._tweenPosition then
		self._tweenPosition:Stop()

		self._tweenPosition = nil
	end

	if self._photo and self._photo.producer and self._photo.producer.targetContainer then
		local _targetContainer = self._photo.producer.targetContainer

		GameUtil.setLocalScale(_targetContainer, 1)
		GameUtil.setLocalPos(_targetContainer, 0, 0, 0)
	end
end

function PhotoEffect:getGo()
	return self._go
end

return PhotoEffect
