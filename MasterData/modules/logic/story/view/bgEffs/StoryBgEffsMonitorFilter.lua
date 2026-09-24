-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsMonitorFilter.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsMonitorFilter", package.seeall)

local StoryBgEffsMonitorFilter = class("StoryBgEffsMonitorFilter", StoryBgEffsBase)

function StoryBgEffsMonitorFilter:ctor()
	StoryBgEffsMonitorFilter.super.ctor(self)
end

function StoryBgEffsMonitorFilter:init(bgCo)
	StoryBgEffsMonitorFilter.super.init(self, bgCo)
	table.insert(self._resList, "ui/viewres/story/bg/v4a0_storybg_timefreeze_low.prefab")
	table.insert(self._resList, "ui/viewres/story/bg/v4a0_storybg_timefreeze_middle.prefab")
	table.insert(self._resList, "ui/viewres/story/bg/v4a0_storybg_timefreeze_high.prefab")

	self._effOutTime = 1
	self._effLoaded = false
	self._cfg = bgCo
end

function StoryBgEffsMonitorFilter:onStartEffect()
	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function StoryBgEffsMonitorFilter:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsMonitorFilter:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsMonitorFilter:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsMonitorFilter:onLoadFinished()
	StoryBgEffsMonitorFilter.super.onLoadFinished(self)

	self._effLoaded = true

	self:playBgEffect()
end

function StoryBgEffsMonitorFilter:playBgEffect()
	if not self._effLoaded then
		return
	end

	StoryTool.enablePostProcess(true)
	TaskDispatcher.runDelay(self._playEffectAni, self, 0.1)
end

function StoryBgEffsMonitorFilter:playInEffect()
	local frontViewGo = StoryViewMgr.instance:getStoryFrontView()
	local storyBgViewGo = StoryViewMgr.instance:getStoryBackgroundView()

	self._rootGo = self._cfg.effRate > 0 and frontViewGo or storyBgViewGo

	local prefabPath = self._resList[self._cfg.materialId + 1]

	if self._prefabPath and prefabPath ~= self._prefabPath then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end

	self:ceateBgImage()

	if gohelper.isNil(self._effectGo) then
		local prefAssetItem = self._loader:getAssetItem(prefabPath)

		self._effectGo = gohelper.clone(prefAssetItem:GetResource(), self.imgBgGO)
	else
		gohelper.addChild(self.imgBgGO, self._effectGo)
	end

	self._effectImg = self._effectGo:GetComponent(typeof(UnityEngine.UI.Image))

	if self._cfg.effRate > 0 then
		local var_9_0 = StoryViewMgr.instance:getStoryBlitEffSecond()

		if not var_9_0 then
			var_9_0 = StoryViewMgr.instance:getStoryBlitEff()

			local blitEff = var_9_0
			local src = blitEff.capturedTexture

			self._captureSnapshot = UnityEngine.RenderTexture.GetTemporary(src.width, src.height, 0, UnityEngine.RenderTextureFormat.ARGB32)

			UnityEngine.Graphics.CopyTexture(src, self._captureSnapshot)
			self._effectImg.material:SetTexture("_MainTex", self._captureSnapshot)

			self._effectAnimator = self._effectGo:GetComponent(typeof(UnityEngine.Animator))
			self._effectAnimator.enabled = false
		end
	end
end

function StoryBgEffsMonitorFilter:ceateBgImage()
	if gohelper.isNil(self.imgBgGO) then
		self.imgBgGO = gohelper.create2d(self._rootGo, "MonitorFilterImage")
		self.imgBg = gohelper.onceAddComponent(self.imgBgGO, typeof(UnityEngine.UI.Image))
		self.imgBg.raycastTarget = false
		self.simage = gohelper.getSingleImage(self.imgBgGO)
	end

	gohelper.addChild(self._rootGo, self.imgBgGO)

	if string.nilorempty(self._cfg.effParam) then
		self.simage:UnLoadImage()
	else
		self.simage:LoadImage(ResUrl.getStoryRes(self._cfg.effParam), self.onImageLoadFinished, self)
	end
end

function StoryBgEffsMonitorFilter:onImageLoadFinished()
	ZProj.UGUIHelper.SetImageSize(self.imgBgGO)
end

function StoryBgEffsMonitorFilter:_playEffectAni()
	local effDegree = self._cfg.effDegree

	if effDegree == 0 then
		self:playInEffect()

		if self._effectAnimator then
			self._effectAnimator.enabled = true

			self._effectAnimator:Play("start", 0, 0)
		end

		return
	end

	if effDegree == 1 then
		if self._effectAnimator then
			self._effectAnimator.enabled = true

			self._effectAnimator:Play("end", 0, 0)
			self._effectAnimator:SetBool("isEnd", true)
		end

		TaskDispatcher.cancelTask(self._onEffFinished, self)
		TaskDispatcher.runDelay(self._onEffFinished, self, self._effOutTime)

		return
	end
end

function StoryBgEffsMonitorFilter:reset(bgCo)
	self._cfg = bgCo

	self:playBgEffect()
end

function StoryBgEffsMonitorFilter:_onEffFinished()
	self:callFinished()
end

function StoryBgEffsMonitorFilter:_clearEffs()
	if self._effectGo then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end

	if self.imgBgGO then
		gohelper.destroy(self.imgBgGO)

		self.imgBgGO = nil
	end

	if self.simage then
		self.simage:UnLoadImage()
	end
end

function StoryBgEffsMonitorFilter:destroy()
	StoryBgEffsMonitorFilter.super.destroy(self)
	self:_clearEffs()
end

return StoryBgEffsMonitorFilter
