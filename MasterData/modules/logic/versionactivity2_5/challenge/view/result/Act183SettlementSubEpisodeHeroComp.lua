-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183SettlementSubEpisodeHeroComp.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementSubEpisodeHeroComp", package.seeall)

local Act183SettlementSubEpisodeHeroComp = class("Act183SettlementSubEpisodeHeroComp", LuaCompBase)

Act183SettlementSubEpisodeHeroComp.HeroIconPosition = {
	{
		{
			0,
			0,
			1
		}
	},
	{
		{
			-61,
			0,
			1
		},
		{
			61,
			0,
			1
		}
	},
	{
		{
			0,
			38,
			1
		},
		{
			-61,
			-82,
			1
		},
		{
			61,
			-82,
			1
		}
	},
	{
		{
			-61,
			38,
			1
		},
		{
			61,
			38,
			1
		},
		{
			-61,
			-82,
			1
		},
		{
			61,
			-82,
			1
		}
	},
	{
		{
			-3,
			80,
			0.74
		},
		{
			84,
			80,
			0.74
		},
		{
			-87,
			-5,
			0.74
		},
		{
			-87,
			-89,
			0.74
		},
		{
			39,
			-46,
			1.58
		}
	}
}
Act183SettlementSubEpisodeHeroComp.TeamLeaderPosition = {
	1,
	2,
	3,
	4,
	5
}

local TeamLeaderIconPosition = {
	[Act183Enum.EpisodeType.Boss] = {
		-52,
		-52
	},
	[Act183Enum.EpisodeType.Sub] = {
		-52,
		-52
	}
}

function Act183SettlementSubEpisodeHeroComp:init(go)
	self.go = go
	self._gosimulate = gohelper.findChild(go, "go_simulate")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183SettlementSubEpisodeHeroComp:addEvents()
	return
end

function Act183SettlementSubEpisodeHeroComp:removeEvents()
	return
end

function Act183SettlementSubEpisodeHeroComp:_editableInitView()
	self._heroIconTab = self:getUserDataTb_()
end

function Act183SettlementSubEpisodeHeroComp:setHeroTemplate(templateGo)
	self._goherotemplate = templateGo
end

function Act183SettlementSubEpisodeHeroComp:onUpdateMO(episodeRecordMo)
	self:refreshHeroGroup(episodeRecordMo)
end

function Act183SettlementSubEpisodeHeroComp:refreshHeroGroup(episodeRecordMo)
	if not episodeRecordMo then
		return
	end

	local simulate = episodeRecordMo:isSimulate()

	gohelper.setActive(self._gosimulate, simulate)

	if simulate then
		return
	end

	local episodeId = episodeRecordMo:getEpisodeId()

	self._episodeType = episodeRecordMo:getEpisodeType()
	self._hasTeamLeader = Act183Helper.isEpisodeHasTeamLeader(episodeId)

	local heroMos = self:_setTeamLeaderPosition(episodeRecordMo)

	if heroMos then
		if not #heroMos then
			local heroCount = 0
			local positionList = self.HeroIconPosition[heroCount]

			for index, heroMo in ipairs(heroMos) do
				local heroItem = gohelper.clone(self._goherotemplate, self.go, "hero_" .. index)
				local positionParams = positionList and positionList[index]

				self:refreshSingleHeroItem(heroItem, heroMo, index, positionParams)
			end
		end
	end
end

function Act183SettlementSubEpisodeHeroComp:_setTeamLeaderPosition(episodeRecordMo)
	local heroMos = episodeRecordMo:getHeroMos()
	local resultMoList = {}
	local teamLeaders = {}

	if heroMos then
		if not #heroMos then
			local heroCount = 0

			for _, heroMo in ipairs(heroMos) do
				if self._hasTeamLeader and heroMo:isTeamLeader() then
					table.insert(teamLeaders, heroMo)
				else
					table.insert(resultMoList, heroMo)
				end
			end

			local teamLeaderPosition = self.TeamLeaderPosition[heroCount]

			if not teamLeaderPosition then
				teamLeaderPosition = heroCount

				logWarn(string.format("未配置队长显示位置(TeamLeaderPosition)!!!默认放队尾  episodeId = %s, heroCount = %s", episodeRecordMo:getEpisodeId(), heroCount))
			end

			for _, teamLeader in ipairs(teamLeaders) do
				table.insert(resultMoList, teamLeaderPosition, teamLeader)
			end

			return resultMoList
		end
	end
end

function Act183SettlementSubEpisodeHeroComp:refreshSingleHeroItem(heroItem, heroMo, index, positionParams)
	gohelper.setActive(heroItem, true)

	local simageheroicon = gohelper.findChildSingleImage(heroItem, "simage_heroicon")
	local iconUrl = heroMo:getHeroIconUrl()

	simageheroicon:LoadImage(iconUrl)

	self._heroIconTab[simageheroicon] = true

	self:refreshHeroPosition(heroItem, positionParams)

	local goleaderflag = gohelper.findChild(heroItem, "#go_LeaderFrame")

	if self._hasTeamLeader then
		local isTeamLeader = heroMo:isTeamLeader()

		gohelper.setActive(goleaderflag, self._hasTeamLeader)

		if self._hasTeamLeader then
			self:onRefreshTeamLeaderHero(heroItem)
		end
	end
end

function Act183SettlementSubEpisodeHeroComp:refreshHeroPosition(heroItem, positionParams)
	local posX = positionParams and positionParams[1]
	local posY = positionParams and positionParams[2]
	local scale = positionParams and positionParams[3]

	transformhelper.setLocalScale(heroItem.transform, scale or 1, scale or 1, scale or 1)
	recthelper.setAnchor(heroItem.transform, posX or 0, posY or 0)
end

function Act183SettlementSubEpisodeHeroComp:onRefreshTeamLeaderHero(heroItem)
	local goleadericon = gohelper.findChild(heroItem, "#go_LeaderFrame/image_LeaderIcon")
	local leaderIconPosition = TeamLeaderIconPosition[self._episodeType]
	local leaderIconPositionX = leaderIconPosition and leaderIconPosition[1]
	local leaderIconPositionY = leaderIconPosition and leaderIconPosition[2]

	recthelper.setAnchor(goleadericon.transform, leaderIconPositionX or 0, leaderIconPositionY or 0)
end

function Act183SettlementSubEpisodeHeroComp:releaseAllSingleImage()
	if self._heroIconTab then
		for simagecomp, _ in pairs(self._heroIconTab) do
			simagecomp:UnLoadImage()
		end
	end
end

function Act183SettlementSubEpisodeHeroComp:onDestroy()
	self:releaseAllSingleImage()
end

return Act183SettlementSubEpisodeHeroComp
