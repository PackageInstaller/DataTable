-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/moyan/MoYanCopyView.lua

module("logic.extensions.scenariocopy.view.moyan.MoYanCopyView", package.seeall)

local MoYanCopyView = class("MoYanCopyView", OnePeopleCopyView)

function MoYanCopyView:buildUI()
	MoYanCopyView.super.buildUI(self)
end

function MoYanCopyView:_isInActivityTime()
	if not ScenariocopyModel.instance:refreshActIdandPlotId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))

		return false
	end

	return true
end

function MoYanCopyView:_selectEndChange(index)
	self:_loadBgEffect(index)
	self:_setBg(index)
end

function MoYanCopyView:_loadBgEffect(index)
	if index == nil then
		index = 1
	end

	self:_removeBgEffect()

	local path = self:_getBgEffectPath(index)
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

	uiEffect:setParent(self._bg.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._bgUIEffect = uiEffect
end

function MoYanCopyView:_setBg(index)
	if index == nil then
		index = 1
	end

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, MoyancopyViewPresentor.BgPath[index])
end

function MoYanCopyView:onExit()
	MoYanCopyView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)
end

function MoYanCopyView:onEnter()
	MoYanCopyView.super.onEnter(self)
end

function MoYanCopyView:_getChapterMaxNum()
	return 3
end

function MoYanCopyView:_getStageMaxNum()
	return 6
end

function MoYanCopyView:_getIndexRange()
	return 7, 9
end

function MoYanCopyView:_getViewName()
	return ViewName.MoYanCopyView
end

function MoYanCopyView:_getStageViewName()
	return ViewName.MoYanStageView
end

function MoYanCopyView:_markRedPoint()
	ScenariocopyController.instance:markMoYanCopyRedPoint()
end

function MoYanCopyView:_getBgEffectPath(index)
	return MoyancopyViewPresentor.BgEffectPath
end

function MoYanCopyView:_getChapterSelectEffectPath()
	return MoyancopyViewPresentor.ChapterEffectPath
end

function MoYanCopyView:_getLevelSelectEffectPath()
	return MoyancopyViewPresentor.LevelEffectPath
end

function MoYanCopyView:_loadMainIconEffect()
	return
end

function MoYanCopyView:_removeMainIconEffect()
	return
end

return MoYanCopyView
