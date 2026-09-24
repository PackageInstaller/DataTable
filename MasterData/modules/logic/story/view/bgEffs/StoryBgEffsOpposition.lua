-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsOpposition.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsOpposition", package.seeall)

local StoryBgEffsOpposition = class("StoryBgEffsOpposition", StoryBgEffsBase)
local OPPOSITION_DEGREES = {
	1,
	0.4,
	0.2,
	0
}

function StoryBgEffsOpposition:ctor()
	StoryBgEffsOpposition.super.ctor(self)
end

function StoryBgEffsOpposition:init(bgCo)
	StoryBgEffsOpposition.super.init(self, bgCo)

	self._prefabPath = ResUrl.getStoryBgEffect("storybg_colorinverse")

	table.insert(self._resList, self._prefabPath)
end

function StoryBgEffsOpposition:start(callback, callbackObj)
	if self._bgCo.effDegree == 0 and not self._effGo then
		return
	end

	StoryBgEffsOpposition.super.start(self, callback, callbackObj)
end

function StoryBgEffsOpposition:onLoadFinished()
	StoryBgEffsOpposition.super.onLoadFinished(self)

	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

	self._effGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	self:_applyEffect()
end

function StoryBgEffsOpposition:_applyEffect()
	if not self._effGo then
		return
	end

	self:_killTween()
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._effGo)

	self._imgOpposition = self._effGo:GetComponent(typeof(UnityEngine.UI.Image))

	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if self._imgOpposition and blitEff then
		self._imgOpposition.material:SetTexture("_MainTex", blitEff.capturedTexture)
	end

	if not OPPOSITION_DEGREES[self._bgCo.effDegree + 1] then
		local targetValue = 0

		if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_tweenUpdate(targetValue)
		else
			local var_5_1 = self._bgCo.effDegree > 0 and 1 or self._imgOpposition and self._imgOpposition.material:GetFloat("_ColorInverseFactor") or 0
		end

		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)

		local storyLeadRoleViewGo = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO

		if storyLeadRoleViewGo then
			local maskGo = gohelper.findChild(storyLeadRoleViewGo, "#go_spineroot")

			gohelper.setLayer(maskGo, UnityLayer.UITop, true)
		end

		local blitGo = StoryViewMgr.instance:getStoryBlitEff()

		if blitGo then
			gohelper.setLayer(blitGo.gameObject, UnityLayer.UISecond, true)
		end
	end
end

function StoryBgEffsOpposition:_tweenUpdate(value)
	if self._imgOpposition then
		self._imgOpposition.material:SetFloat("_ColorInverseFactor", value)
	end
end

function StoryBgEffsOpposition:_tweenFinished()
	self:_killTween()
end

function StoryBgEffsOpposition:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function StoryBgEffsOpposition:reset(bgCo)
	StoryBgEffsOpposition.super.reset(self, bgCo)
	self:_killTween()

	if self._effGo then
		self:_applyEffect()
	end
end

function StoryBgEffsOpposition:destroy()
	self:_killTween()

	if self._effGo then
		gohelper.destroy(self._effGo)

		self._effGo = nil
	end

	self._imgOpposition = nil

	local storyViewGo = StoryViewMgr.instance:getStoryView()

	if storyViewGo then
		gohelper.setLayer(storyViewGo, UnityLayer.UISecond, true)
	end

	local storyLeadRoleViewGo = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO

	if storyLeadRoleViewGo then
		local maskGo = gohelper.findChild(storyLeadRoleViewGo, "#go_spineroot")

		gohelper.setLayer(maskGo, UnityLayer.UIThird, true)
	end

	local blitGo = StoryViewMgr.instance:getStoryBlitEff()

	if blitGo then
		gohelper.setLayer(blitGo.gameObject, UnityLayer.UI, true)
	end

	StoryBgEffsOpposition.super.destroy(self)
end

return StoryBgEffsOpposition
