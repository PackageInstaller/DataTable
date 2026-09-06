-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameGameViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameGameViewPresentor", package.seeall)

local OriMatGameGameViewPresentor = class("OriMatGameGameViewPresentor", ViewPresentor)

function OriMatGameGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriMatGameGameViewPresentor:dependWhatResources()
	local resList = {}

	table.insert(resList, "ui/views/orimatgame/orimatgamegameview.prefab")

	local params = self:getOpenParam()
	local seasonId = checknumber(params[1])
	local stageId = checknumber(params[2])

	if seasonId > 0 and stageId > 0 then
		local seasonData = OriMatGameConfig.instance:getSeasonData(seasonId)

		if seasonData then
			if not seasonData.stagePlanId then
				local stagePlanId = 0
				local stageCfg = OriMatGameConfig.instance:getStageCfgByStageId(stagePlanId, stageId)

				if stageCfg then
					if not stageCfg.gamePlanId then
						local gamePlanId = 0
						local gameData = OriMatGameConfig.instance:getGamePlanCfg(gamePlanId)

						if gameData and not string.nilorempty(gameData.bgPath) then
							local spriteName = GameUrl.getBigbgPngUrl(gameData.bgPath)

							table.insert(resList, spriteName)
						end
					end
				end
			end
		end
	end

	return resList
end

function OriMatGameGameViewPresentor:buildViews()
	return {
		OriMatGameGameView.New()
	}
end

return OriMatGameGameViewPresentor
