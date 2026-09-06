-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/mission/LongnvFmtRightView.lua

module("logic.extensions.mangtower.view.LongnvFmtRightView", package.seeall)

local LongnvFmtRightView = class("LongnvFmtRightView", FormationRightView)

function LongnvFmtRightView:createFilterList()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local type = params.type

		if type == LongnvModel.TYPE_3 then
			local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_FMT_RIGHT)

			PetFilterMgr.instance:resetData(data)

			local stageId = params.stageId
			local rId = GameEnum.RaceType.Shui

			if stageId == 2 then
				rId = GameEnum.RaceType.An
			end

			if rId ~= 0 then
				for i = 1, 8 do
					data.raceSelectList[i] = rId == i
					data.raceActiveList[i] = true
					data.raceClickAble[i] = false
				end
			end
		end
	end
end

return LongnvFmtRightView
