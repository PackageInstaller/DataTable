-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/view/V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim", package.seeall)

local V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim = class("V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim", V3a1_GaoSiNiao_LevelViewFlow_WorkBase)

function V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim.s_create(viewObj, viewContainer)
	local res = V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim.New()

	if viewObj or viewContainer then
		res._viewObj = viewObj
		res._viewContainer = viewContainer
	else
		local kViewName = ViewName.V3a1_GaoSiNiao_LevelView
		local _viewContainer = ViewMgr.instance:getContainer(kViewName)

		if not _viewContainer then
			return nil
		end

		res._viewContainer = _viewContainer
		res._viewObj = _viewContainer:mainView()
	end

	if not res._viewObj then
		return nil
	end

	return res
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim:viewObj()
	if self._viewObj then
		return self._viewObj
	end

	return V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim.super.viewObj(self)
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim:baseViewContainer()
	if self._viewContainer then
		return self._viewContainer
	end

	return V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim.super.baseViewContainer(self)
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim:onStart()
	self:clearWork()

	local viewObj = self:viewObj()

	if not viewObj then
		self:onFail()

		return
	end

	local isSpEpisodeOpen = self:isSpEpisodeOpen()

	if not isSpEpisodeOpen then
		self:onSucc()

		return
	end

	if self:hasPlayedUnlockedEndless() then
		viewObj:playAnim_EndlessIdle()
		self:onSucc()

		return
	end

	viewObj:playAnim_EndlessUnlock(self._onAnimDone, self)
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim:_onAnimDone()
	self:saveHasPlayedUnlockedEndless()
	self:onSucc()
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim:clearWork()
	self._viewObj = nil
	self._viewContainer = nil
	self._needWaitCount = 0

	V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim.super.clearWork(self)
end

return V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim
