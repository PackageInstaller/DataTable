-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/noah/NoahCopyView.lua

module("logic.extensions.scenariocopy.view.noah.NoahCopyView", package.seeall)

local NoahCopyView = class("NoahCopyView", OnePeopleCopyView)

function NoahCopyView:_isInActivityTime()
	if not ScenariocopyModel.instance:refreshActIdandPlotId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))

		return false
	end

	return true
end

function NoahCopyView:_selectEndChange(index)
	return
end

function NoahCopyView:_playZhuanChangEffect()
	local path = NoahcopyViewPresentor.ZhuanChangEffectPath
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

	uiEffect:setParent(self._bg.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._zhuanchangEffect = uiEffect
end

function NoahCopyView:onExit()
	NoahCopyView.super.onExit(self)

	if self._zhuanchangEffect then
		UIEffectManager.instance:stopEffect(self._zhuanchangEffect)

		self._zhuanchangEffect = nil
	end

	uGuiUtil.clearImage(self._bg)
end

function NoahCopyView:onEnter()
	NoahCopyView.super.onEnter(self)
end

function NoahCopyView:_getChapterMaxNum()
	return 4
end

function NoahCopyView:_getStageMaxNum()
	return 6
end

function NoahCopyView:_getIndexRange()
	return 10, 13
end

function NoahCopyView:_getViewName()
	return ViewName.NoahCopyView
end

function NoahCopyView:_getStageViewName()
	return ViewName.NoahStageView
end

function NoahCopyView:_markRedPoint()
	ScenariocopyController.instance:markNuoYaCopyRedPoint()
end

function NoahCopyView:_getBgEffectPath()
	return NoahcopyViewPresentor.BgEffectPath
end

function NoahCopyView:_getChapterSelectEffectPath()
	return
end

function NoahCopyView:_getLevelSelectEffectPath()
	return NoahcopyViewPresentor.LevelEffectPath
end

function NoahCopyView:_loadMainIconEffect()
	return
end

function NoahCopyView:_removeMainIconEffect()
	return
end

return NoahCopyView
