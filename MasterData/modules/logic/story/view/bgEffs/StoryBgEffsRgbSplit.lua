-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsRgbSplit.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsRgbSplit", package.seeall)

local StoryBgEffsRgbSplit = class("StoryBgEffsRgbSplit", StoryBgEffsBase)

function StoryBgEffsRgbSplit:ctor()
	StoryBgEffsRgbSplit.super.ctor(self)
end

function StoryBgEffsRgbSplit:init(bgCo)
	StoryBgEffsRgbSplit.super.init(self, bgCo)
end

function StoryBgEffsRgbSplit:onStartEffect()
	self:_apply()
end

function StoryBgEffsRgbSplit:_apply()
	self:_clearEffGo()

	if self._bgCo.effDegree == StoryEnum.BgRgbSplitType.Trans then
		self:_showTrans()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.Once then
		self:_showOnce()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopWeak then
		self:_showLoopWeak()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopStrong then
		self:_showLoopStrong()
	end
end

function StoryBgEffsRgbSplit:_showTrans()
	self._prefabPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_changebg_doublerole")

	table.insert(self._resList, self._prefabPath)
	self:loadRes()
end

function StoryBgEffsRgbSplit:_onTransLoaded()
	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

	self._effGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._effGo)

	local imgOld = gohelper.findChildImage(self._effGo, "image_old")
	local imgNew = gohelper.findChildImage(self._effGo, "image_new")
	local goAnim = gohelper.findChild(self._effGo, "anim")

	if imgOld then
		gohelper.setActive(imgOld.gameObject, true)
	end

	if imgNew then
		gohelper.setActive(imgNew.gameObject, true)
	end

	if goAnim then
		gohelper.setActive(goAnim, true)
	end

	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if blitEff then
		gohelper.setLayer(blitEff.gameObject, UnityLayer.UISecond, true)
	end

	if imgOld then
		local bgView = StoryViewMgr.instance:getStoryBackgroundView()

		if bgView then
			local lastCapture = bgView:GetComponent(typeof(UnityEngine.UI.Image))
			local blitEffSecond = StoryViewMgr.instance:getStoryBlitEffSecond()

			if blitEffSecond and imgNew then
				imgNew.material:SetTexture("_MainTex", blitEffSecond.capturedTexture)
			end
		end
	end

	TaskDispatcher.runDelay(self._onTransFinished, self, 1.2)
end

function StoryBgEffsRgbSplit:_onTransFinished()
	self:_clearEffGo()
	self:_restoreLayers()
	self:callFinished()
end

function StoryBgEffsRgbSplit:_showOnce()
	self._prefabPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_once")

	table.insert(self._resList, self._prefabPath)
	self:loadRes()
end

function StoryBgEffsRgbSplit:_onOnceLoaded()
	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	local heroGo = StoryViewMgr.instance:getStoryHeroView()

	self._effGo = gohelper.clone(prefAssetItem:GetResource(), heroGo)

	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._effGo)

	self._img = self._effGo:GetComponent(typeof(UnityEngine.UI.Image))

	if self._img then
		gohelper.setActive(self._img.gameObject, true)

		local blitEff = StoryViewMgr.instance:getStoryBlitEff()

		if blitEff then
			self._img.material:SetTexture("_MainTex", blitEff.capturedTexture)
		end
	end

	TaskDispatcher.runDelay(self._onOnceFinished, self, 0.267)
end

function StoryBgEffsRgbSplit:_onOnceFinished()
	self:_clearEffGo()
	self:_restoreLayers()
	self:callFinished()
end

function StoryBgEffsRgbSplit:_showLoopWeak()
	self._prefabPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_loop")

	table.insert(self._resList, self._prefabPath)
	self:loadRes()
end

function StoryBgEffsRgbSplit:_onLoopWeakLoaded()
	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	StoryViewMgr.instance:setStoryHeroViewLayer(UnityLayer.UIThird)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UIThird)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)

	local heroGo = StoryViewMgr.instance:getStoryHeroView()

	self._effGo = gohelper.clone(prefAssetItem:GetResource(), heroGo)

	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._effGo)

	self._img = self._effGo:GetComponent(typeof(UnityEngine.UI.Image))

	if self._img then
		gohelper.setActive(self._img.gameObject, true)

		local blitEff = StoryViewMgr.instance:getStoryBlitEff()

		if blitEff then
			self._img.material:SetTexture("_MainTex", blitEff.capturedTexture)
		end
	end
end

function StoryBgEffsRgbSplit:_showLoopStrong()
	self._prefabPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_loop_strong")

	table.insert(self._resList, self._prefabPath)
	self:loadRes()
end

function StoryBgEffsRgbSplit:_onLoopStrongLoaded()
	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	local heroGo = StoryViewMgr.instance:getStoryHeroView()

	self._effGo = gohelper.clone(prefAssetItem:GetResource(), heroGo)

	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._effGo)

	self._img = self._effGo:GetComponent(typeof(UnityEngine.UI.Image))

	if self._img then
		gohelper.setActive(self._img.gameObject, true)

		local blitEff = StoryViewMgr.instance:getStoryBlitEff()

		if blitEff then
			self._img.material:SetTexture("_MainTex", blitEff.capturedTexture)
		end
	end
end

function StoryBgEffsRgbSplit:onLoadFinished()
	StoryBgEffsRgbSplit.super.onLoadFinished(self)

	if self._bgCo.effDegree == StoryEnum.BgRgbSplitType.Trans then
		self:_onTransLoaded()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.Once then
		self:_onOnceLoaded()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopWeak then
		self:_onLoopWeakLoaded()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopStrong then
		self:_onLoopStrongLoaded()
	end
end

function StoryBgEffsRgbSplit:reset(bgCo)
	StoryBgEffsRgbSplit.super.reset(self, bgCo)
	self:_apply()
end

function StoryBgEffsRgbSplit:_clearEffGo()
	if self._effGo then
		gohelper.destroy(self._effGo)

		self._effGo = nil
	end

	self._img = nil
end

function StoryBgEffsRgbSplit:_restoreLayers()
	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if blitEff then
		gohelper.setLayer(blitEff.gameObject, UnityLayer.UI, true)
	end

	StoryViewMgr.instance:setStoryHeroViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UISecond)
end

function StoryBgEffsRgbSplit:destroy()
	TaskDispatcher.cancelTask(self._onTransFinished, self)
	TaskDispatcher.cancelTask(self._onOnceFinished, self)
	self:_clearEffGo()
	self:_restoreLayers()
	StoryBgEffsRgbSplit.super.destroy(self)
end

return StoryBgEffsRgbSplit
