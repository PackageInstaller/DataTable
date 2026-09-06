-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardRank2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardRank2025View", package.seeall)

local YearCardRank2025View = class("YearCardRank2025View", YearCardRank2023View)

function YearCardRank2025View:buildUI()
	YearCardRank2025View.super.buildUI(self)

	self._showTip = {
		lang("仅展示前100名，按全服斐希司精灵战斗力进行排名，需在荣耀战力检测过的精灵才可上榜"),
		lang("仅展示前100名，按本服斐希司精灵战斗力进行排名，需在荣耀战力检测过的精灵才可上榜"),
		lang("仅展示前100名，根据全服激活年费时间先后顺序进行排名"),
		(lang("仅展示前100名，根据本服激活年费时间先后顺序进行排名"))
	}
end

return YearCardRank2025View
