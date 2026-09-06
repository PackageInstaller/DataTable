-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/mission/WaterDarkTowerFmtRightView.lua

module("logic.extensions.waterdraktower.view.mission.WaterDarkTowerFmtRightView", package.seeall)

local WaterDarkTowerFmtRightView = class("WaterDarkTowerFmtRightView", FormationRightView)

function WaterDarkTowerFmtRightView:_getCurFormation()
	return WaterdraktowerModel.instance:getCurFormation()
end

function WaterDarkTowerFmtRightView:createFilterList()
	local challengeCfg = self:getOpenParam()[2]
	local cCfg

	if challengeCfg.formCondition > 0 then
		local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_FMT_RIGHT)

		PetFilterMgr.instance:resetData(data)

		local rId = 0

		if rId ~= 0 then
			for i = 1, 8 do
				data.raceSelectList[i] = rId == i
				data.raceActiveList[i] = true
				data.raceClickAble[i] = false
			end
		end
	end
end

function WaterDarkTowerFmtRightView:_setJobLabelStr()
	self._jobLabelStr = nil

	local formCondition = self:getOpenParam()[2].formCondition
	local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(formCondition)

	if cfg then
		local str = string.split(cfg.validator, "$")

		if str[1] and str[1] == "All" and str[2] then
			local acfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(checknumber(str[2]))

			if acfg then
				self._jobLabelStr = acfg.label
			end
		end
	end
end

return WaterDarkTowerFmtRightView
