-- chunkname: @modules/logic/story/view/bgTrans/StoryBgTransCameraShake.lua

module("modules.logic.story.view.bgTrans.StoryBgTransCameraShake", package.seeall)

local StoryBgTransCameraShake = class("StoryBgTransCameraShake", StoryBgTransBase)

function StoryBgTransCameraShake:ctor()
	StoryBgTransCameraShake.super.ctor(self)
end

function StoryBgTransCameraShake:init(transType)
	StoryBgTransCameraShake.super.init(self)

	self._transInTime = 0.267
	self._transOutTime = 0.267
	self._transType = transType or StoryEnum.BgTransType.ShakeCameraLR
	self._transMo = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(self._transType)
	self._shakeCameraPrefabPath = ResUrl.getStoryBgEffect(self._transMo.prefab)
	self._shakeCameraAnimPath = transType == StoryEnum.BgTransType.ShakeCameraLR and "ui/animations/dynamic/story_avg_shake.controller" or "ui/animations/dynamic/story_avg_shake_2.controller"
	self._shakeCameraMatPath = "ui/materials/dynamic/storybg_edge_stretch.mat"

	table.insert(self._resList, self._shakeCameraPrefabPath)
	table.insert(self._resList, self._shakeCameraAnimPath)
	table.insert(self._resList, self._shakeCameraMatPath)
end

function StoryBgTransCameraShake:start(callback, callbackObj)
	StoryBgTransCameraShake.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:loadRes()
	GameUtil.setActiveUIBlock("bgTrans", true, false)
end

function StoryBgTransCameraShake:onLoadFinished()
	StoryBgTransCameraShake.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	self._rootGo = StoryViewMgr.instance:getStoryFrontBgImgGo()
	self._shakeCameraBgGo = gohelper.cloneInPlace(self._rootGo, "shakeCameraBg")

	gohelper.destroyAllChildren(self._shakeCameraBgGo)
	gohelper.setAsFirstSibling(self._shakeCameraBgGo)

	local img = self._shakeCameraBgGo:GetComponent(gohelper.Type_Image)

	img.material = self._loader:getAssetItem(self._shakeCameraMatPath):GetResource()

	local prefAssetItem = self._loader:getAssetItem(self._shakeCameraPrefabPath)

	self._shakeCameraGo = gohelper.clone(prefAssetItem:GetResource(), self._rootGo)
	self._shakeCameraGo.name = "v3a0_dynamicblur_controller"

	gohelper.setActive(self._shakeCameraGo, true)

	local animator = self._loader:getAssetItem(self._shakeCameraAnimPath):GetResource()

	self._shakeCameraAnim = gohelper.onceAddComponent(self._rootGo, typeof(UnityEngine.Animator))
	self._shakeCameraAnim.runtimeAnimatorController = animator

	self._shakeCameraAnim:Play("shake", 0, 0)
	PostProcessingMgr.instance:setUIPPValue("customPassActive", true)
	PostProcessingMgr.instance:setUIPPValue("CustomPassActive", true)
	PostProcessingMgr.instance:setUIPPValue("customPassIndex", 0)
	PostProcessingMgr.instance:setUIPPValue("CustomPassIndex", 0)
	TaskDispatcher.runDelay(self.onSwitchBg, self, self._transInTime)
end

function StoryBgTransCameraShake:onSwitchBg()
	StoryBgTransCameraShake.super.onSwitchBg(self)
	TaskDispatcher.runDelay(self.onTransFinished, self, self._transOutTime)
end

function StoryBgTransCameraShake:onTransFinished()
	StoryBgTransCameraShake.super.onTransFinished(self)

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)
	end

	self:_clearTrans()
end

function StoryBgTransCameraShake:_clearTrans()
	GameUtil.setActiveUIBlock("bgTrans", false, false)
	gohelper.removeComponent(self._rootGo, typeof(UnityEngine.Animator))
	PostProcessingMgr.instance:setUIPPValue("customPassActive", false)
	PostProcessingMgr.instance:setUIPPValue("CustomPassActive", false)

	if self._shakeCameraGo then
		gohelper.destroy(self._shakeCameraGo)

		self._shakeCameraGo = nil
	end

	if self._shakeCameraBgGo then
		gohelper.destroy(self._shakeCameraBgGo)

		self._shakeCameraBgGo = nil
	end

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

function StoryBgTransCameraShake:destroy()
	StoryBgTransCameraShake.super.destroy(self)
	TaskDispatcher.cancelTask(self.onSwitchBg, self)
	TaskDispatcher.cancelTask(self.onTransFinished, self)
	self:_clearTrans()
end

return StoryBgTransCameraShake
