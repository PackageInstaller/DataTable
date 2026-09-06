-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardRank2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardRank2023View", package.seeall)

local YearCardRank2023View = class("YearCardRank2023View", YearCardRankView)

function YearCardRank2023View:buildUI()
	YearCardRank2023View.super.buildUI(self)

	self._showTip = {
		lang("仅展示前100名，按全服离阳龙脉精灵战斗力进行排名，需在荣耀战力检测过的精灵才可上榜"),
		lang("仅展示前100名，按本服离阳龙脉精灵战斗力进行排名，需在荣耀战力检测过的精灵才可上榜"),
		lang("仅展示前100名，根据全服激活年费时间先后顺序进行排名"),
		(lang("仅展示前100名，根据本服激活年费时间先后顺序进行排名"))
	}
end

return YearCardRank2023View
