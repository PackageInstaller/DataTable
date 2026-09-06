-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemixixi/view/DivineMiXiXiLevelView.lua

module("logic.extensions.divinemixixi.view.DivineMiXiXiLevelView", package.seeall)

local DivineMiXiXiLevelView = class("DivineMiXiXiLevelView", FireDimensionLevelView)

function DivineMiXiXiLevelView:ctor()
	DivineMiXiXiLevelView.super.ctor(self)
end

function DivineMiXiXiLevelView:unbindEvents()
	DivineMiXiXiLevelView.super.unbindEvents(self)
end

function DivineMiXiXiLevelView:bindEvents()
	DivineMiXiXiLevelView.super.bindEvents(self)
end

function DivineMiXiXiLevelView:buildUI()
	DivineMiXiXiLevelView.super.buildUI(self)
end

function DivineMiXiXiLevelView:onExit()
	DivineMiXiXiLevelView.super.onExit(self)
end

function DivineMiXiXiLevelView:onEnter()
	DivineMiXiXiLevelView.super.onEnter(self)
end

function DivineMiXiXiLevelView:_playEffect(stageId)
	return
end

function DivineMiXiXiLevelView:_updateTxtLevel()
	local isBaned = FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId)
	local matType, id, num = MaterialMgr.getMatParams(self._cfgStage.prize)

	self._txtLevel.text = isBaned and string.format("击败剩余阵容即可通关。\n通过可获得：%d <quad name=%d:%d|icon size=28 width=1 offsetY=-8/>", num, matType, id) or langPara("蜜西西使用了八卦信息，随意吸引下列%d个阵容，令其无法出战。", self._maxBanNum)
end

function DivineMiXiXiLevelView:_onClickCommit()
	if FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId) then
		FloatWordMgr.instance:show("已经禁用过了")

		return
	end

	if #self._curBanedTeamIdList < self._maxBanNum then
		FloatWordMgr.instance:show(string.format("请禁用%d个关卡", self._maxBanNum))

		return
	end

	if #self._curBanedTeamIdList > self._maxBanNum then
		FloatWordMgr.instance:show(string.format("最多禁用%d关", self._maxBanNum))

		return
	end

	local text = string.format("是否确定吸引%d个阵容，对应阵容不需要挑战，击败剩余阵容则通过考验", #self._curBanedTeamIdList)

	local function okFunc()
		FireDimensionChallengeAgent.instance:sendPM_FireDimensionClgBanReq(self._activityId, self._stageId, self._curBanedTeamIdList)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

return DivineMiXiXiLevelView
