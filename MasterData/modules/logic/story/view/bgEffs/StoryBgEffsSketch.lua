-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsSketch.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsSketch", package.seeall)

local StoryBgEffsSketch = class("StoryBgEffsSketch", StoryBgEffsBase)
local SKETCH_DEGREES = {
	1,
	0.4,
	0.2,
	0
}

function StoryBgEffsSketch:ctor()
	StoryBgEffsSketch.super.ctor(self)
end

function StoryBgEffsSketch:init(bgCo)
	StoryBgEffsSketch.super.init(self, bgCo)

	self._prefabPath = ResUrl.getStoryBgEffect("storybg_sketch")

	table.insert(self._resList, self._prefabPath)
end

function StoryBgEffsSketch:start(callback, callbackObj)
	if self._bgCo.effDegree == 0 and not self._effGo then
		return
	end

	StoryBgEffsSketch.super.start(self, callback, callbackObj)
end

function StoryBgEffsSketch:onLoadFinished()
	StoryBgEffsSketch.super.onLoadFinished(self)

	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

	self._effGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	self:_applyEffect()
end

function StoryBgEffsSketch:_applyEffect()
	if not self._effGo then
		return
	end

	self:_killTween()
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._effGo)

	self._imgSketch = self._effGo:GetComponent(typeof(UnityEngine.UI.Image))

	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if self._imgSketch and blitEff then
		self._imgSketch.material:SetTexture("_MainTex", blitEff.capturedTexture)
	end

	if not SKETCH_DEGREES[self._bgCo.effDegree + 1] then
		local targetValue = 0

		if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_tweenUpdate(targetValue)
		else
			local var_5_1 = self._bgCo.effDegree > 0 and 1 or self._imgSketch and self._imgSketch.material:GetFloat("_SourceColLerp") or 0
		end

		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)

		local blitGo = StoryViewMgr.instance:getStoryBlitEff()

		if blitGo then
			gohelper.setLayer(blitGo.gameObject, UnityLayer.UISecond, true)
		end
	end
end

function StoryBgEffsSketch:_tweenUpdate(value)
	if self._imgSketch then
		self._imgSketch.material:SetFloat("_SourceColLerp", value)
	end
end

function StoryBgEffsSketch:_tweenFinished()
	self:_killTween()
end

function StoryBgEffsSketch:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function StoryBgEffsSketch:reset(bgCo)
	StoryBgEffsSketch.super.reset(self, bgCo)
	self:_killTween()

	if self._bgCo.effDegree == 0 and not self._effGo then
		return
	end

	if self._effGo then
		self:_applyEffect()
	else
		self:loadRes()
	end
end

function StoryBgEffsSketch:destroy()
	self:_killTween()

	if self._effGo then
		gohelper.destroy(self._effGo)

		self._effGo = nil
	end

	self._imgSketch = nil

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)

	local blitGo = StoryViewMgr.instance:getStoryBlitEff()

	if blitGo then
		gohelper.setLayer(blitGo.gameObject, UnityLayer.UI, true)
	end

	StoryBgEffsSketch.super.destroy(self)
end

return StoryBgEffsSketch
