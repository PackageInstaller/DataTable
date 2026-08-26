-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsTimeStop.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsTimeStop", package.seeall)

local StoryBgEffsTimeStop = class("StoryBgEffsTimeStop", StoryBgEffsBase)

function StoryBgEffsTimeStop:ctor()
	StoryBgEffsTimeStop.super.ctor(self)
end

function StoryBgEffsTimeStop:init(bgCo)
	StoryBgEffsTimeStop.super.init(self, bgCo)

	self._prefabPath = "ui/viewres/story/bg/v3a7_storybg_timefreeze.prefab"

	table.insert(self._resList, self._prefabPath)

	self._effInTime = 0.5
	self._effOutTime = 1.25
	self._effLoaded = false
	self._cfg = bgCo
end

function StoryBgEffsTimeStop:start(callback, callbackObj)
	StoryBgEffsTimeStop.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsTimeStop:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsTimeStop:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsTimeStop:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsTimeStop:onLoadFinished()
	StoryBgEffsTimeStop.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local frontViewGo = StoryViewMgr.instance:getStoryFrontView()
	local storyBgViewGo = StoryViewMgr.instance:getStoryBackgroundView()

	self._rootGo = self._cfg.effRate > 0 and frontViewGo or storyBgViewGo

	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	self._effectGo = gohelper.clone(prefAssetItem:GetResource(), self._rootGo)
	self._effectImg = self._effectGo:GetComponent(typeof(UnityEngine.UI.Image))

	if self._cfg.effRate > 0 then
		local var_7_0 = StoryViewMgr.instance:getStoryBlitEffSecond()

		if not var_7_0 then
			var_7_0 = StoryViewMgr.instance:getStoryBlitEff()

			local blitEff = var_7_0
			local src = blitEff.capturedTexture

			self._captureSnapshot = UnityEngine.RenderTexture.GetTemporary(src.width, src.height, 0, UnityEngine.RenderTextureFormat.ARGB32)

			UnityEngine.Graphics.CopyTexture(src, self._captureSnapshot)
			self._effectImg.material:SetTexture("_MainTex", self._captureSnapshot)

			self._effectAnimator = self._effectGo:GetComponent(typeof(UnityEngine.Animator))
			self._effectAnimator.enabled = false

			TaskDispatcher.runDelay(self._playEffectAni, self, 0.1)

			self._effLoaded = true
		end
	end
end

function StoryBgEffsTimeStop:_playEffectAni()
	self._effectAnimator.enabled = true

	self._effectAnimator:Play("start", 0, 0)
end

function StoryBgEffsTimeStop:reset(bgCo)
	self._cfg = bgCo

	logNormal("StoryBgEffsTimeStop reset, degree:", bgCo.effDegree)

	if not self._effLoaded then
		return
	end

	StoryBgEffsTimeStop.super.reset(self, bgCo)
	StoryTool.enablePostProcess(true)
	self:_setViewTop(true)

	if bgCo.effDegree == 0 then
		if self._cfg.effRate > 0 then
			local var_9_0 = StoryViewMgr.instance:getStoryBlitEffSecond()

			if not var_9_0 then
				var_9_0 = StoryViewMgr.instance:getStoryBlitEff()

				do
					local blitEff = var_9_0
					local src = blitEff.capturedTexture

					UnityEngine.Graphics.CopyTexture(src, self._captureSnapshot)

					return
				end

				local frontViewGo = StoryViewMgr.instance:getStoryFrontView()
				local storybgViewGo = StoryViewMgr.instance:getStoryBackgroundView()

				self._rootGo = frontViewGo

				gohelper.setLayer(self._effectGo, (self._cfg.effRate > 0 or nil) and (UnityLayer.UITop or UnityLayer.UISecond), true)
				gohelper.setParent(self._effectGo, self._rootGo)

				local canvas = gohelper.onceAddComponent(self._effectGo, typeof(UnityEngine.Canvas))

				canvas.overrideSorting = true
				canvas.sortingOrder = self._cfg.effRate > 0 and 1 or 0

				if bgCo.effDegree == 1 then
					local blitEff = StoryViewMgr.instance:getStoryBlitEff()
					local src = blitEff.capturedTexture

					self._effectImg.material:SetTexture("_MainTex", src)

					if self._captureSnapshot then
						UnityEngine.RenderTexture.ReleaseTemporary(self._captureSnapshot)
					end

					gohelper.setActive(self._effectGo, false)

					local src = blitEff.capturedTexture

					self._captureSnapshot = UnityEngine.RenderTexture.GetTemporary(src.width, src.height, 0, UnityEngine.RenderTextureFormat.ARGB32)

					UnityEngine.Graphics.CopyTexture(src, self._captureSnapshot)
					self._effectImg.material:SetTexture("_MainTex", self._captureSnapshot)
					gohelper.setActive(self._effectGo, false)
					gohelper.setActive(self._effectGo, true)

					if self._effectAnimator then
						self._effectAnimator.enabled = true

						self._effectAnimator:Play("end", 0, 0)
						self._effectAnimator:SetBool("isEnd", true)
					end

					TaskDispatcher.cancelTask(self._onEffFinished, self)
					TaskDispatcher.runDelay(self._onEffFinished, self, self._effOutTime)
				elseif bgCo.effDegree == 2 then
					if self._effectAnimator then
						self._effectAnimator.enabled = true

						self._effectAnimator:Play("start", 0, 0)

						self._effectAnimator.enabled = false
					end

					gohelper.setActive(self._effectGo, true)

					if self._cfg.effRate > 0 then
						local var_9_1 = StoryViewMgr.instance:getStoryBlitEffSecond()

						if not var_9_1 then
							var_9_1 = StoryViewMgr.instance:getStoryBlitEff()

							local blitEff = var_9_1
							local onlyBg = self._cfg.effRate == 0

							if onlyBg then
								blitEff:SetKeepCapture(false)
							end

							local src = blitEff.capturedTexture

							self._effectImg.material:SetTexture("_MainTex", src)
							gohelper.setActive(self._effectGo, false)
							gohelper.setActive(self._effectGo, true)

							if not onlyBg then
								TaskDispatcher.runDelay(self._delayCaptureSnapshot, self, 1)
							end
						end
					end
				elseif bgCo.effDegree == 3 then
					if self._effectAnimator then
						self._effectAnimator.enabled = true

						self._effectAnimator:SetBool("isEnd", true)
						self._effectAnimator:Play("end", 0, 1)

						self._effectAnimator.enabled = false
					end

					gohelper.setActive(self._effectGo, false)
				end
			end
		end
	end
end

function StoryBgEffsTimeStop:_delayCaptureSnapshot()
	if self._cfg.effRate > 0 then
		local var_10_0 = StoryViewMgr.instance:getStoryBlitEffSecond()

		if not var_10_0 then
			var_10_0 = StoryViewMgr.instance:getStoryBlitEff()

			local blitEff = var_10_0

			if self._captureSnapshot then
				UnityEngine.RenderTexture.ReleaseTemporary(self._captureSnapshot)
			end

			gohelper.setActive(self._effectGo, false)

			local src = blitEff.capturedTexture

			self._captureSnapshot = UnityEngine.RenderTexture.GetTemporary(src.width, src.height, 0, UnityEngine.RenderTextureFormat.ARGB32)

			UnityEngine.Graphics.CopyTexture(src, self._captureSnapshot)
			self._effectImg.material:SetTexture("_MainTex", self._captureSnapshot)
			gohelper.setActive(self._effectGo, true)
		end
	end
end

function StoryBgEffsTimeStop:_onEffFinished()
	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsTimeStop:_clearEffs()
	if self._captureSnapshot then
		UnityEngine.RenderTexture.ReleaseTemporary(self._captureSnapshot)

		self._captureSnapshot = nil
	end

	if self._effectGo then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

function StoryBgEffsTimeStop:destroy()
	StoryBgEffsTimeStop.super.destroy(self)
	self:_clearEffs()
end

return StoryBgEffsTimeStop
