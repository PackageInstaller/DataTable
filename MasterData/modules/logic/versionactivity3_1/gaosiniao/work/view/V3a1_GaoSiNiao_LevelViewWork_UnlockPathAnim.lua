-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/view/V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim", package.seeall)

local V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim = class("V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim", V3a1_GaoSiNiao_LevelViewFlow_WorkBase)

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.s_create(viewObj, viewContainer)
	local res = V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.New()

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

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:viewObj()
	if self._viewObj then
		return self._viewObj
	end

	return V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.super.viewObj(self)
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:baseViewContainer()
	if self._viewContainer then
		return self._viewContainer
	end

	return V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.super.baseViewContainer(self)
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:onStart()
	self:clearWork()

	local viewObj = self:viewObj()

	if not viewObj then
		self:onFail()

		return
	end

	self._needWaitCount = 0
	self._curStageItemObj = self:_getCurStageItemObjToPlayUnlockAnim()

	if not self._curStageItemObj then
		logWarn("can not found current stage Item")
		self:onSucc()

		return
	end

	viewObj:playAnim_PathIdle(self:_animIndex(true))

	if self:hasPlayedUnlockedAnimPath(self:_curEpisodeId()) then
		self._curStageItemObj:playAnim_Idle()
		self:onSucc()

		return
	end

	self:_playAnim_PathUnlock()
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:_playAnim_PathUnlock()
	self._needWaitCount = 2

	self:viewObj():playAnim_PathUnlock(self:_animIndex(), self._onPlayedUnlockDone, self)
	self._curStageItemObj:playAnim_Open(self._onPlayedUnlockDone, self)
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:_getCurStageItemObjToPlayUnlockAnim()
	local _itemObjList = self:viewObj()._itemObjList or {}
	local currentEpisodeIdToPlay = self:currentEpisodeIdToPlay(true)

	for _, stageItemObj in ipairs(_itemObjList) do
		local episodeId = stageItemObj:episodeId()

		if episodeId == currentEpisodeIdToPlay then
			return stageItemObj
		end
	end

	return _itemObjList[#_itemObjList]
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:_onPlayedUnlockDone()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount <= 0 then
		self:saveHasPlayedUnlockedAnimPath(self:_curEpisodeId())
		self:onSucc()
	end
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:_curIndex()
	if not self._curStageItemObj then
		return 0
	end

	return self._curStageItemObj:index() or 0
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:_curEpisodeId()
	if not self._curStageItemObj then
		return nil
	end

	return self._curStageItemObj:episodeId()
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:_animIndex(noClamp)
	local index = self:_curIndex() - 1

	if noClamp then
		return index
	end

	return GameUtil.clamp(index, 0, 7)
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:clearWork()
	self._curStageItemObj = nil
	self._viewObj = nil
	self._viewContainer = nil
	self._needWaitCount = 0

	V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.super.clearWork(self)
end

function V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim:_logCur()
	logError("curIndex:" .. tostring(self:_curIndex()) .. ", curEpisodeId:" .. tostring(self:_curEpisodeId()), "idleIndex:", tostring(self:_animIndex()))
end

return V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim
