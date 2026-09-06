-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower1v1MissionView.lua

module("logic.extensions.mangtower.view.MangTower1v1MissionView", package.seeall)

local MangTower1v1MissionView = class("MangTower1v1MissionView", MissionView)

function MangTower1v1MissionView:onEnter()
	self:onEnterInherit()

	local ruleDesc = "击败对方全体精灵"
	local openParams = self._viewPresentor:getFirstParam()
	local titleStr = openParams.name

	self:_setDescStr(titleStr, nil, ruleDesc)
end

function MangTower1v1MissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	MangTower1v1FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function MangTower1v1MissionView:_onClickClean()
	MangTower1v1FastFormation.instance:clean()
end

function MangTower1v1MissionView:_enterBattle()
	local openParams = self._viewPresentor:getFirstParam()
	local params = {}

	params.buffIdList = MangTowerConfig.instance:getBuffCfg(openParams.buffPlanId)

	function params.selectCallBack(buffId)
		MangTowerController.instance:sendChallenge(buffId, MangTowerModel.TOWER_TYPE_1V1)
	end

	UIStateManager.instance:open(ViewName.SelectBuffView, params)
end

function MangTower1v1MissionView:_saveFormationEx()
	return MangTowerController.instance:saveCurrNormalFormation()
end

function MangTower1v1MissionView:_isCurFormationEmpty()
	local fmt = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_1V1, nil)

	for i = 1, 9 do
		local pos = fmt:GetPosition(i)

		if not pos then
			return true
		end

		if pos > 0 then
			return false
		end
	end

	return true
end

function MangTower1v1MissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	return nil
end

return MangTower1v1MissionView
