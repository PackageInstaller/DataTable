-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/view/V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim", package.seeall)

local V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim = class("V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim", V3a1_GaoSiNiao_LevelViewFlow_WorkBase)

function V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim.s_create(viewObj, viewContainer)
	local res = V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim.New()

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

function V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim:viewObj()
	if self._viewObj then
		return self._viewObj
	end

	return V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim.super.viewObj(self)
end

function V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim:baseViewContainer()
	if self._viewContainer then
		return self._viewContainer
	end

	return V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim.super.baseViewContainer(self)
end

function V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim:onStart()
	self:clearWork()

	local viewObj = self:viewObj()

	if not viewObj then
		self:onFail()

		return
	end

	self._needWaitCount = 0
	self._episodeId = self:currentPassedEpisodeId()

	local disactiveEpisodeInfoDict, isPlayedOnce = self:_getEpisodeCO_disactiveEpisodeInfoDict()

	if not self._episodeId or self._episodeId == 0 then
		self:onSucc()

		return
	end

	local _itemObjList = self:viewObj()._itemObjList

	for _, stageItemObj in ipairs(_itemObjList or {}) do
		local episodeId = stageItemObj:episodeId()
		local goMarkIndex = disactiveEpisodeInfoDict[episodeId]

		if goMarkIndex then
			if isPlayedOnce then
				stageItemObj:playAnim_MarkIdle(goMarkIndex)
			else
				self._needWaitCount = self._needWaitCount + 1

				stageItemObj:playAnim_MarkFinish(goMarkIndex, self._onItemAnimDone, self)
			end
		else
			stageItemObj:setActive_goMark(nil)
		end
	end

	if isPlayedOnce then
		self:onSucc()
	elseif self._needWaitCount == 0 then
		self:saveHasPlayedDisactiveAnimPath(self._episodeId)
		self:onSucc()
	end
end

function V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim:_getEpisodeCO_disactiveEpisodeInfoDict()
	local disactiveEpisodeInfoDict = self:getEpisodeCO_disactiveEpisodeInfoDict(self._episodeId)
	local isPlayedOnce = self:hasPlayedDisactiveAnimPath(self._episodeId)

	if not isPlayedOnce then
		local preEpisodeId = self:getPreEpisodeId(self._episodeId)
		local preDisactiveEpisodeInfoDict = self:getEpisodeCO_disactiveEpisodeInfoDict(preEpisodeId)

		if next(preDisactiveEpisodeInfoDict) then
			isPlayedOnce = true

			for episodeId, goMarkIndex in pairs(disactiveEpisodeInfoDict) do
				if preDisactiveEpisodeInfoDict[episodeId] ~= goMarkIndex then
					isPlayedOnce = false
				end

				preDisactiveEpisodeInfoDict[episodeId] = nil
			end

			if isPlayedOnce then
				isPlayedOnce = next(preDisactiveEpisodeInfoDict) == nil

				self:saveHasPlayedDisactiveAnimPath(self._episodeId)
			end
		end
	end

	return disactiveEpisodeInfoDict, isPlayedOnce
end

function V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim:_onItemAnimDone()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount <= 0 then
		self:saveHasPlayedDisactiveAnimPath(self._episodeId)
		self:onSucc()
	end
end

function V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim:clearWork()
	self._viewObj = nil
	self._viewContainer = nil
	self._needWaitCount = 0

	V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim.super.clearWork(self)
end

return V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim
