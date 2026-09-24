-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsMalfunction.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsMalfunction", package.seeall)

local StoryBgEffsMalfunction = class("StoryBgEffsMalfunction", StoryBgEffsBase)

function StoryBgEffsMalfunction:ctor()
	StoryBgEffsMalfunction.super.ctor(self)
end

function StoryBgEffsMalfunction:init(bgCo)
	StoryBgEffsMalfunction.super.init(self, bgCo)
end

function StoryBgEffsMalfunction:onStartEffect()
	self:_apply()
end

function StoryBgEffsMalfunction:_apply()
	self:_clearEffGo()

	if self._bgCo.effDegree == StoryEnum.BgRgbSplitType.Trans then
		self:_showTrans()
	end
end

function StoryBgEffsMalfunction:_showTrans()
	self._prefabPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_changebg_doublerole2")

	table.insert(self._resList, self._prefabPath)
	self:loadRes()
end

function StoryBgEffsMalfunction:onLoadFinished()
	StoryBgEffsMalfunction.super.onLoadFinished(self)

	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	local storyViewGo = StoryViewMgr.instance:getStoryView()

	self._effGo = gohelper.clone(prefAssetItem:GetResource(), storyViewGo)

	self:_setTransEffect()
end

function StoryBgEffsMalfunction:_setTransEffect()
	if not self._effGo then
		return
	end

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

	local canvas = gohelper.onceAddComponent(self._effGo, typeof(UnityEngine.Canvas))

	canvas.overrideSorting = true
	canvas.sortingOrder = 2004

	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if blitEff then
		gohelper.setLayer(blitEff.gameObject, UnityLayer.UISecond, true)
	end

	gohelper.setLayer(self._effGo, UnityLayer.UISecond, true)
	TaskDispatcher.runDelay(self._changeLayer, self, 2.8)
	TaskDispatcher.runDelay(self._onTransFinished, self, 4)
end

function StoryBgEffsMalfunction:_changeLayer()
	if self._effGo then
		gohelper.setLayer(self._effGo, UnityLayer.UITop, true)
	end
end

function StoryBgEffsMalfunction:_onTransFinished()
	self:_clearEffGo()
	self:_restoreLayers()
	self:callFinished()
end

function StoryBgEffsMalfunction:reset(bgCo)
	StoryBgEffsMalfunction.super.reset(self, bgCo)
	self:_apply()
end

function StoryBgEffsMalfunction:_clearEffGo()
	if self._effGo then
		gohelper.destroy(self._effGo)

		self._effGo = nil
	end
end

function StoryBgEffsMalfunction:_restoreLayers()
	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if blitEff then
		gohelper.setLayer(blitEff.gameObject, UnityLayer.UI, true)
	end
end

function StoryBgEffsMalfunction:destroy()
	TaskDispatcher.cancelTask(self._changeLayer, self)
	TaskDispatcher.cancelTask(self._onTransFinished, self)
	self:_clearEffGo()
	self:_restoreLayers()
	StoryBgEffsMalfunction.super.destroy(self)
end

return StoryBgEffsMalfunction
