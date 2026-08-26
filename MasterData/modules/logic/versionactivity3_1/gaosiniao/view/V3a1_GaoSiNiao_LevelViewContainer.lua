-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_LevelViewContainer.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_LevelViewContainer", package.seeall)

local V3a1_GaoSiNiao_LevelViewContainer = class("V3a1_GaoSiNiao_LevelViewContainer", Activity210CorvusViewBaseContainer)

function V3a1_GaoSiNiao_LevelViewContainer:buildViews()
	local views = {}

	self._mainView = V3a1_GaoSiNiao_LevelView.New()

	table.insert(views, self._mainView)
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function V3a1_GaoSiNiao_LevelViewContainer:mainView()
	return self._mainView
end

function V3a1_GaoSiNiao_LevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function V3a1_GaoSiNiao_LevelViewContainer:onContainerInit()
	self:_recoverBadPrefsData()
	ActivityEnterMgr.instance:enterActivity(self:actId())
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self:actId()
	})
end

function V3a1_GaoSiNiao_LevelViewContainer:_recoverBadPrefsData()
	local episodeCOList, _SPCOList = self:getEpisodeCOList()

	for _, v in ipairs(episodeCOList) do
		local episodeId = v.episodeId

		if self:hasPlayedUnlockedAnimPath(episodeId) then
			local hasPass = self:hasPassLevelAndStory(episodeId)
			local isOpen = self:isEpisodeOpen(episodeId)

			if not hasPass then
				self:unsaveHasPlayedDisactiveAnimPath(episodeId)
			end

			if not isOpen then
				self:unsaveHasPlayedUnlockedAnimPath(episodeId)
			end
		end
	end

	for _, v in ipairs(_SPCOList) do
		local episodeId = v.episodeId
		local isOpen = self:isEpisodeOpen(episodeId)

		if not isOpen then
			self:unsaveHasPlayedUnlockedEndless()
		end
	end
end

function V3a1_GaoSiNiao_LevelViewContainer:getEpisodeCO_disactiveEpisodeInfoDict(episodeId)
	local disactiveEpisodeInfoList = GaoSiNiaoConfig.instance:getEpisodeCO_disactiveEpisodeInfoList(episodeId)
	local dict = {}

	for _, v in ipairs(disactiveEpisodeInfoList) do
		local _episodeId = v[1]

		if not v[2] then
			dict[_episodeId] = v[2]
		end
	end

	return dict
end

function V3a1_GaoSiNiao_LevelViewContainer:isCurPassedEpisodeHasPlayedUnlockedAnimPath()
	local currentPassedEpisodeId = self:currentPassedEpisodeId()

	if not currentPassedEpisodeId or currentPassedEpisodeId <= 0 then
		return true
	end

	return self:hasPlayedUnlockedAnimPath(currentPassedEpisodeId)
end

function V3a1_GaoSiNiao_LevelViewContainer:_prefKey_HasPlayedUnlockedAnimPath(episodeId)
	return self:getPrefsKeyPrefix_episodeId(episodeId) .. "UnlockedAnimPath"
end

function V3a1_GaoSiNiao_LevelViewContainer:saveHasPlayedUnlockedAnimPath(episodeId)
	local key = self:_prefKey_HasPlayedUnlockedAnimPath(episodeId)

	self:saveInt(key, 1)
end

function V3a1_GaoSiNiao_LevelViewContainer:unsaveHasPlayedUnlockedAnimPath(episodeId)
	local key = self:_prefKey_HasPlayedUnlockedAnimPath(episodeId)

	self:saveInt(key, 0)
end

function V3a1_GaoSiNiao_LevelViewContainer:hasPlayedUnlockedAnimPath(episodeId)
	local key = self:_prefKey_HasPlayedUnlockedAnimPath(episodeId)

	return self:getInt(key, 0) == 1
end

function V3a1_GaoSiNiao_LevelViewContainer:_prefKey_HasPlayedDisactiveAnimPath(episodeId)
	return self:getPrefsKeyPrefix_episodeId(episodeId) .. "HasPlayedDisactiveAnimPath"
end

function V3a1_GaoSiNiao_LevelViewContainer:saveHasPlayedDisactiveAnimPath(episodeId)
	local key = self:_prefKey_HasPlayedDisactiveAnimPath(episodeId)

	self:saveInt(key, 1)
end

function V3a1_GaoSiNiao_LevelViewContainer:unsaveHasPlayedDisactiveAnimPath(episodeId)
	local key = self:_prefKey_HasPlayedDisactiveAnimPath(episodeId)

	self:saveInt(key, 0)
end

function V3a1_GaoSiNiao_LevelViewContainer:hasPlayedDisactiveAnimPath(episodeId)
	local key = self:_prefKey_HasPlayedDisactiveAnimPath(episodeId)

	return self:getInt(key, 0) == 1
end

function V3a1_GaoSiNiao_LevelViewContainer:_prefKey_HasPlayedUnlockedEndless()
	return self:getPrefsKeyPrefix() .. "HasPlayedUnlockedEndless"
end

function V3a1_GaoSiNiao_LevelViewContainer:saveHasPlayedUnlockedEndless()
	local key = self:_prefKey_HasPlayedUnlockedEndless()

	self:saveInt(key, 1)
end

function V3a1_GaoSiNiao_LevelViewContainer:unsaveHasPlayedUnlockedEndless()
	local key = self:_prefKey_HasPlayedUnlockedEndless()

	self:saveInt(key, 0)
end

function V3a1_GaoSiNiao_LevelViewContainer:hasPlayedUnlockedEndless()
	local key = self:_prefKey_HasPlayedUnlockedEndless()

	return self:getInt(key, 0) == 1
end

return V3a1_GaoSiNiao_LevelViewContainer
