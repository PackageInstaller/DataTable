-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadCardWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadCardWork", package.seeall)

local FightPreloadCardWork = class("FightPreloadCardWork", BaseWork)
local BattleDialogHeadIconDict = {
	[9120110] = {
		"305613"
	},
	[9120111] = {
		"306011"
	},
	[9121002] = {
		"306110"
	},
	[9120103] = {
		"302310"
	}
}

function FightPreloadCardWork:onStart(context)
	local urlList = {}
	local roundData = FightDataHelper.roundMgr:getRoundData()

	if roundData and roundData.teamACards1 then
		for _, cardInfoMO in ipairs(roundData.teamACards1) do
			local skillCO = lua_skill.configDict[cardInfoMO.skillId]
			local iconUrl = ResUrl.getSkillIcon(skillCO.icon)

			if not tabletool.indexOf(urlList, iconUrl) then
				table.insert(urlList, iconUrl)
			end
		end
	end

	local battleId = FightModel.instance:getFightParam().battleId
	local iconIds = BattleDialogHeadIconDict[battleId]

	if iconIds then
		for _, iconId in ipairs(iconIds) do
			local iconUrl = ResUrl.getHeadIconSmall(iconId)

			table.insert(urlList, iconUrl)
		end
	end

	self._loader = MultiAbLoader.New()

	self._loader:setPathList(urlList)
	self._loader:startLoad(self._onLoadFinish, self)
end

function FightPreloadCardWork:_onLoadFinish(loader)
	local all = loader:getAssetItemDict()

	for _, assetItem in ipairs(all) do
		self.context.callback(self.context.callbackObj, assetItem)
	end

	self:onDone(true)
end

function FightPreloadCardWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightPreloadCardWork
