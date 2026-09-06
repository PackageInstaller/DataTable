-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/formation/TongFmtRightView.lua

module("logic.extensions.tongbattle.view.formation.TongFmtRightView", package.seeall)

local TongFmtRightView = class("TongFmtRightView", FormationRightView)

function TongFmtRightView:_setJobLabelStr()
	self._jobLabelStr = nil

	local params = self._viewPresentor:getFirstParam()

	if params == nil then
		return
	end

	local teamCfg = TongBattleConfig.instance:getMasterTeamCfg(params.planId, params.chalType, params.stageId)

	if teamCfg == nil or checknumber(teamCfg.formCondition) <= 0 then
		return
	end

	local condCfg = FormationValidatorConfig.instance:getFormationValidatorCfg(teamCfg.formCondition)

	if condCfg then
		self._jobLabelStr = condCfg.label
	end
end

function TongFmtRightView:setCurViewDatas()
	local params = self._viewPresentor:getFirstParam()

	if params == nil or params.stageId == nil then
		return
	end

	local teamCfg = TongBattleConfig.instance:getMasterTeamCfg(params.planId, params.chalType, params.stageId)

	if teamCfg == nil or teamCfg.formCondition <= 0 then
		TongFmtRightView.super.setCurViewDatas(self)

		return
	end

	self._curViewDatas = {}

	local pets = self:getAllShowPetList()
	local attrType = params.stageId == 1 and "火" or "暗"

	for k, v in pairs(pets) do
		self._curPetMap[v.petId] = v

		if self:onFilter(v) and v:checkHasRace(attrType) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end
end

return TongFmtRightView
