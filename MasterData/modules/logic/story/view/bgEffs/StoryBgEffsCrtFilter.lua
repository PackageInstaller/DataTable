-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsCrtFilter.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsCrtFilter", package.seeall)

local StoryBgEffsCrtFilter = class("StoryBgEffsCrtFilter", StoryBgEffsBase)

function StoryBgEffsCrtFilter:ctor()
	StoryBgEffsCrtFilter.super.ctor(self)
end

function StoryBgEffsCrtFilter:init(bgCo)
	StoryBgEffsCrtFilter.super.init(self, bgCo)

	self._filterPrefabPath = "ui/viewres/story/bg/storybg_crt.prefab"

	table.insert(self._resList, self._filterPrefabPath)

	self._effLoaded = false
end

function StoryBgEffsCrtFilter:start()
	StoryBgEffsCrtFilter.super.start(self)
	self:loadRes()
end

function StoryBgEffsCrtFilter:onLoadFinished()
	StoryBgEffsCrtFilter.super.onLoadFinished(self)

	self._effLoaded = true

	local prefAssetItem = self._loader:getAssetItem(self._filterPrefabPath)
	local parentGO = StoryViewMgr.instance:getStoryLeadRoleSpineView()

	self._filterGo = gohelper.clone(prefAssetItem:GetResource(), parentGO)
	self._img = self._filterGo:GetComponent(gohelper.Type_Image)
	self._mat = self._img.material

	self:playEffect()
end

function StoryBgEffsCrtFilter:reset(bgCo)
	StoryBgEffsCrtFilter.super.reset(self, bgCo)
	self:playEffect()
end

function StoryBgEffsCrtFilter:playEffect()
	if not self._effLoaded then
		return
	end

	self:setBg()
	self:_killTween()

	if self._bgCo.effRate == 0 then
		self:fadeIn()
	else
		self:fadeOut()
	end
end

function StoryBgEffsCrtFilter:setBg()
	local isOnHero = self._bgCo.effDegree == 0

	if isOnHero then
		local var_7_0 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")

		if not var_7_0 then
			var_7_0 = StoryViewMgr.instance:getStoryView()

			local parentGO = var_7_0

			gohelper.addChild(parentGO, self._filterGo)
			gohelper.setAsFirstSibling(self._filterGo)
			StoryTool.applyMaterialScheme(self._mat, self._bgCo.materialId)

			if isOnHero then
				local blitEffSecond = StoryViewMgr.instance:getStoryBlitEffSecond()

				self._mat:SetTexture("_MainTex", blitEffSecond.capturedTexture)
				self:_setViewTop(true)
			else
				local blitEff = StoryViewMgr.instance:getStoryBlitEff()

				self._mat:SetTexture("_MainTex", blitEff.capturedTexture)
				self:_setViewTop(false)
			end
		end
	end
end

function StoryBgEffsCrtFilter:fadeIn()
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if transTime and transTime > 0.1 then
		self._filterTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, transTime, self._setColorVal, self.onFadeInFinish, self)
	else
		self:onFadeInFinish()
	end
end

function StoryBgEffsCrtFilter:onFadeInFinish()
	self:_setColorVal(1)
end

function StoryBgEffsCrtFilter:fadeOut()
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if transTime and transTime > 0.1 then
		self._filterTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, transTime, self._setColorVal, self.onFadeOutFinish, self)
	else
		self:onFadeOutFinish()
	end
end

function StoryBgEffsCrtFilter:onFadeOutFinish()
	self:_setColorVal(0)
end

function StoryBgEffsCrtFilter:_setColorVal(val)
	if not self._mat then
		return
	end

	self._color = self._color or Color(1, 1, 1, 1)
	self._color.a = val

	self._mat:SetColor("_MainColor", self._color)
end

function StoryBgEffsCrtFilter:_killTween()
	if self._filterTweenId then
		ZProj.TweenHelper.KillById(self._filterTweenId)

		self._filterTweenId = nil
	end
end

function StoryBgEffsCrtFilter:_setViewTop(set)
	if not self.hasSetViewTop then
		if self.hasSetViewTop == set then
			return
		end

		self.hasSetViewTop = set

		local storyViewGo = StoryViewMgr.instance:getStoryView()
		local conGo = gohelper.findChild(storyViewGo, "#go_contentroot")
		local topGo = gohelper.findChild(storyViewGo, "#go_middle")

		if set then
			if not UnityLayer.UIThird then
				local layer = UnityLayer.UISecond

				gohelper.setLayer(conGo, layer, true)
				gohelper.setLayer(topGo, layer, true)
			end
		end
	end
end

function StoryBgEffsCrtFilter:destroy()
	StoryBgEffsCrtFilter.super.destroy(self)
	self:_killTween()
	self:_setViewTop(false)

	if self._filterGo then
		gohelper.destroy(self._filterGo)

		self._filterGo = nil
	end
end

return StoryBgEffsCrtFilter
