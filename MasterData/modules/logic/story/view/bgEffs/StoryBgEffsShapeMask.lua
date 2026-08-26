-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsShapeMask.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsShapeMask", package.seeall)

local StoryBgEffsShapeMask = class("StoryBgEffsShapeMask", StoryBgEffsBase)
local MASK_TRANS_PROP = "_TransPos_1"

local function _toNumber(value, defaultValue)
	local num = tonumber(value)

	return num or defaultValue
end

local function _clamp(value, minValue, maxValue)
	if value < minValue then
		return minValue
	end

	if maxValue < value then
		return maxValue
	end

	return value
end

local function _lerp(a, b, t)
	return a + (b - a) * t
end

local function _resolvePrefabPath(path)
	if string.nilorempty(path) then
		return nil
	end

	if string.find(path, ".prefab") then
		return path
	end

	return ResUrl.getStoryBgEffect(path)
end

function StoryBgEffsShapeMask:ctor()
	StoryBgEffsShapeMask.super.ctor(self)
end

function StoryBgEffsShapeMask:init(bgCo)
	StoryBgEffsShapeMask.super.init(self, bgCo)

	self._bgCo = bgCo
	self._shapeMaskCo = nil
	self._prefabPath = nil
	self._createTweenId = nil
	self._moveTweenId = nil
	self._transPosVec = Vector4.New(0, 0, 0, 0)
	self._effLoaded = false

	self:_cacheConfigByBgCo()
end

function StoryBgEffsShapeMask:start(callback, callbackObj)
	StoryBgEffsShapeMask.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:_playOrLoad()
end

function StoryBgEffsShapeMask:_cacheConfigByBgCo()
	self._shapeMaskCo = nil
	self._prefabPath = nil

	if not self._bgCo or self._bgCo.effDegree < 0 then
		return
	end

	if StoryShapeMaskEffectTypeModel and StoryShapeMaskEffectTypeModel.instance then
		self._shapeMaskCo = StoryShapeMaskEffectTypeModel.instance:getStoryShapeMaskEffectByType(self._bgCo.effDegree)
	end

	self._prefabPath = _resolvePrefabPath(self._shapeMaskCo and self._shapeMaskCo.shapePrefabPath)
end

function StoryBgEffsShapeMask:_playOrLoad()
	if not self._shapeMaskCo or string.nilorempty(self._prefabPath) then
		return
	end

	if self._effLoaded and self._effsGo then
		self:_tryResetParent()
		self:_playSequence()

		return
	end

	self._resList = {}

	table.insert(self._resList, self._prefabPath)
	self:loadRes()
end

function StoryBgEffsShapeMask:onLoadFinished()
	StoryBgEffsShapeMask.super.onLoadFinished(self)

	if not self._prefabPath then
		return
	end

	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		logError("ShapeMask prefab load fail: " .. tostring(self._prefabPath))

		return
	end

	local parentGo = self:_getEffectParentByMaskLayer()

	if not parentGo then
		logError("ShapeMask effect parent not found")

		return
	end

	if self._effsGo then
		gohelper.destroy(self._effsGo)

		self._effsGo = nil
	end

	self._effsGo = gohelper.clone(prefAssetItem:GetResource(), parentGo)

	gohelper.setLayer(self._effsGo, UnityLayer.UISecond, true)

	self._canvas = gohelper.onceAddComponent(self._effsGo, typeof(UnityEngine.Canvas))
	self._canvas.overrideSorting = true
	self._canvas.sortingOrder = self._effOrder
	self._maskMat = self:_findMaskMaterial(self._effsGo)
	self._effLoaded = true

	self:_playSequence()
end

function StoryBgEffsShapeMask:_getEffectParentByMaskLayer()
	local maskLayer = _toNumber((self._shapeMaskCo or nil) and self._shapeMaskCo.maskLayer, 9)

	if maskLayer < 4 then
		self._effOrder = 4

		local bgGo = StoryViewMgr.instance:getStoryBackgroundView()

		return bgGo and gohelper.findChild(bgGo, "#go_bottomitem/#go_eff1")
	end

	if maskLayer < 7 then
		self._effOrder = 1000

		local storyViewGo = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

		return storyViewGo and gohelper.findChild(storyViewGo, "#go_middle/#go_eff2")
	end

	if maskLayer < 10 then
		self._effOrder = 2004

		local storyViewGo = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

		return storyViewGo and gohelper.findChild(storyViewGo, "#go_top/#go_eff3")
	end

	self._effOrder = 4

	local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

	return frontGo and gohelper.findChild(frontGo, "#go_frontitem/#go_eff4")
end

function StoryBgEffsShapeMask:_tryResetParent()
	if not self._effsGo then
		return
	end

	local parentGo = self:_getEffectParentByMaskLayer()

	if not parentGo then
		return
	end

	if self._effsGo.transform.parent ~= parentGo.transform then
		self._effsGo.transform:SetParent(parentGo.transform, false)
	end
end

function StoryBgEffsShapeMask:_findMaskMaterial(rootGo)
	if gohelper.isNil(rootGo) then
		return nil
	end

	local img = rootGo:GetComponent(gohelper.Type_Image)

	if img and img.material then
		return img.material
	end

	local images = rootGo:GetComponentsInChildren(typeof(UnityEngine.UI.Image), true)

	if images and images.Length and images.Length > 0 then
		for i = 0, images.Length - 1 do
			local image = images[i]

			if image and image.material then
				return image.material
			end
		end
	end

	local renderer = rootGo:GetComponent(typeof(UnityEngine.Renderer))

	if renderer and renderer.material then
		return renderer.material
	end

	local renderers = rootGo:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	if renderers and renderers.Length and renderers.Length > 0 then
		for i = 0, renderers.Length - 1 do
			local childRenderer = renderers[i]

			if childRenderer and childRenderer.material then
				return childRenderer.material
			end
		end
	end

	return nil
end

function StoryBgEffsShapeMask:_setMaskTransPos(x, y, z)
	if not self._maskMat or not self._maskMat:HasProperty(MASK_TRANS_PROP) then
		return
	end

	self._transPosVec.x = x
	self._transPosVec.y = y
	self._transPosVec.z = z

	self._maskMat:SetVector(MASK_TRANS_PROP, self._transPosVec)
end

function StoryBgEffsShapeMask:_playSequence()
	self:_killTweens()
	TaskDispatcher.cancelTask(self._playMoveTween, self)

	if not self._shapeMaskCo then
		return
	end

	self._startPosX = _toNumber(self._shapeMaskCo.startPosX, 0)
	self._startPosY = _toNumber(self._shapeMaskCo.startPosY, 0)
	self._targetPosX = _toNumber(self._shapeMaskCo.targetPosX, self._startPosX)
	self._targetPosY = _toNumber(self._shapeMaskCo.targetPosY, self._startPosY)
	self._holeSize = _clamp(_toNumber(self._shapeMaskCo.holeSize, 1), -100, 100)
	self._createTime = math.max(0, _toNumber(self._shapeMaskCo.createTime, 0))
	self._moveStartTime = math.max(0, _toNumber(self._shapeMaskCo.moveStartTime, 0))
	self._moveDuration = math.max(0, _toNumber(self._shapeMaskCo.moveDuration, 0))
	self._moveEase = _toNumber(self._shapeMaskCo.moveEase, EaseType.Linear)

	self:_setMaskTransPos(self._startPosX, self._startPosY, 0)

	if self._createTime > 0.01 then
		self._createTweenId = ZProj.TweenHelper.DOTweenFloat(-100, self._holeSize, self._createTime, self._onCreateUpdate, self._onCreateFinished, self, nil, EaseType.Linear)
	else
		self:_setMaskTransPos(self._startPosX, self._startPosY, self._holeSize)
		self:_onCreateFinished()
	end
end

function StoryBgEffsShapeMask:_onCreateUpdate(value)
	self:_setMaskTransPos(self._startPosX, self._startPosY, value)
end

function StoryBgEffsShapeMask:_onCreateFinished()
	if self._createTweenId then
		ZProj.TweenHelper.KillById(self._createTweenId)

		self._createTweenId = nil
	end

	if self._moveStartTime > 0.01 then
		TaskDispatcher.runDelay(self._playMoveTween, self, self._moveStartTime)
	else
		self:_playMoveTween()
	end
end

function StoryBgEffsShapeMask:_playMoveTween()
	if self._moveDuration <= 0.01 then
		self:_setMaskTransPos(self._targetPosX, self._targetPosY, self._holeSize)

		return
	end

	self._moveTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._moveDuration, self._onMoveUpdate, self._onMoveFinished, self, nil, self._moveEase)
end

function StoryBgEffsShapeMask:_onMoveUpdate(value)
	local x = _lerp(self._startPosX, self._targetPosX, value)
	local y = _lerp(self._startPosY, self._targetPosY, value)

	self:_setMaskTransPos(x, y, self._holeSize)
end

function StoryBgEffsShapeMask:_onMoveFinished()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

function StoryBgEffsShapeMask:reset(bgCo)
	StoryBgEffsShapeMask.super.reset(self, bgCo)

	self._bgCo = bgCo

	local oldPrefabPath = self._prefabPath

	self:_cacheConfigByBgCo()

	if string.nilorempty(self._prefabPath) then
		if self._effsGo then
			gohelper.destroy(self._effsGo)

			self._effsGo = nil
			self._maskMat = nil
		end

		self._effLoaded = false

		self:_killTweens()
		TaskDispatcher.cancelTask(self._playMoveTween, self)

		return
	end

	if self._effLoaded and self._effsGo and oldPrefabPath == self._prefabPath then
		self:_tryResetParent()
		self:_playSequence()

		return
	end

	self._effLoaded = false

	if self._effsGo then
		gohelper.destroy(self._effsGo)

		self._effsGo = nil
		self._maskMat = nil
	end

	self:_playOrLoad()
end

function StoryBgEffsShapeMask:_killTweens()
	if self._createTweenId then
		ZProj.TweenHelper.KillById(self._createTweenId)

		self._createTweenId = nil
	end

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

function StoryBgEffsShapeMask:destroy()
	StoryBgEffsShapeMask.super.destroy(self)
	self:_killTweens()
	TaskDispatcher.cancelTask(self._playMoveTween, self)

	if self._effsGo then
		gohelper.destroy(self._effsGo)

		self._effsGo = nil
	end

	self._maskMat = nil
	self._shapeMaskCo = nil
	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsShapeMask
