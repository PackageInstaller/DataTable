-- chunkname: @modules/logic/ressplit/work/ResSplitWeekWalkWork.lua

module("modules.logic.ressplit.work.ResSplitWeekWalkWork", package.seeall)

local ResSplitWeekWalkWork = class("ResSplitWeekWalkWork", BaseWork)

function ResSplitWeekWalkWork:onStart(context)
	local dic = ResSplitConfig.instance:getAppIncludeConfig()
	local maxLayer = 0

	for i, v in pairs(dic) do
		maxLayer = math.max(maxLayer, v.maxWeekWalk)
	end

	for i, v in pairs(lua_weekwalk.configDict) do
		if maxLayer >= v.layer then
			local mapId = lua_weekwalk_scene.configDict[v.sceneId].mapId
			local path = string.format("Assets/ZProj/Editor/WeekWalk/Map/%s.txt", mapId)
			local cfgTxt = SLFramework.FileHelper.ReadText(path)
			local data = cjson.decode(cfgTxt)
			local nodeList = data.nodeList

			for n, m in ipairs(nodeList) do
				local mo = WeekwalkElementInfoMO.New()

				mo:init({
					elementId = m.configId
				})

				if mo.config then
					local battleId = mo:getConfigBattleId()

					if battleId then
						local battleCo = lua_battle.configDict[battleId]

						ResSplitHelper.addBattleMonsterSkins(battleCo)
					end
				end
			end
		end
	end

	self:onDone(true)
end

return ResSplitWeekWalkWork
