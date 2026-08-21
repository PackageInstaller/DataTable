-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\FigureGuess\\ActivityFigureGuessTools.lua

local ActivityFigureGuessTools = {}

function ActivityFigureGuessTools.refreshCareerShow(career, imgCareer, txtCareer)
	local careerPath = UIConst.getHeroCareerIconPath(career)

	if imgCareer then
		imgCareer:setImage(careerPath[1], careerPath[2])
	end

	if txtCareer then
		txtCareer:setText(Const.CAREER_CONFIG[career].name)
	end
end

function ActivityFigureGuessTools.refreshGroupShow(camp, imgGroup, txtGroup)
	local groupPath = UIConst.getHeroCampLargeIconPath(camp)

	if imgGroup then
		imgGroup:setImage(groupPath[1], groupPath[2])
	end

	if txtGroup then
		txtGroup:setText(Const.CAMP_CONFIG[camp].name)
	end
end

function ActivityFigureGuessTools.refreshTeamShow(team, imgTeam, txtTeam)
	local groupTeamPath = UIConst.getLargeTeamIconPath(team)

	if imgTeam then
		imgTeam:setImage(groupTeamPath[1], groupTeamPath[2])
	end

	if txtTeam then
		txtTeam:setText(Const.HERO_TEAM_CONFIG[team].name)
	end
end

function ActivityFigureGuessTools.checkActivityOpen(actId)
	local checkOpen = CurAvatar:isActivityOpen(actId)

	if not checkOpen then
		MsgManager.notice(Lang.get(32785))
	end

	return checkOpen
end

return ActivityFigureGuessTools
