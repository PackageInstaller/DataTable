-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsInterfere.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsInterfere", package.seeall)

local StoryBgEffsInterfere = class("StoryBgEffsInterfere", StoryBgEffsBase)

function StoryBgEffsInterfere:ctor()
	StoryBgEffsInterfere.super.ctor(self)
end

function StoryBgEffsInterfere:init(bgCo)
	StoryBgEffsInterfere.super.init(self, bgCo)

	self._prefabPath = ResUrl.getStoryBgEffect("glitch_common")

	table.insert(self._resList, self._prefabPath)
end

function StoryBgEffsInterfere:onLoadFinished()
	StoryBgEffsInterfere.super.onLoadFinished(self)

	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

	self._effGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	self:_applyEffect()
end

function StoryBgEffsInterfere:_applyEffect()
	if not self._effGo then
		return
	end

	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._effGo)

	local img = self._effGo:GetComponent(typeof(UnityEngine.UI.Image))
	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if img and blitEff then
		img.material:SetTexture("_MainTex", blitEff.capturedTexture)
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)

	local gobliteff = StoryViewMgr.instance:getStoryBlitEff()

	if gobliteff then
		gohelper.setLayer(gobliteff.gameObject, UnityLayer.UISecond, true)
	end
end

function StoryBgEffsInterfere:reset(bgCo)
	StoryBgEffsInterfere.super.reset(self, bgCo)

	if self._effGo then
		self:_applyEffect()
	end
end

function StoryBgEffsInterfere:destroy()
	if self._effGo then
		gohelper.destroy(self._effGo)

		self._effGo = nil
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)

	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if blitEff then
		gohelper.setLayer(blitEff.gameObject, UnityLayer.UI, true)
	end

	StoryBgEffsInterfere.super.destroy(self)
end

return StoryBgEffsInterfere
