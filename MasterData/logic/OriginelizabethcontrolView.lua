-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethcontrolView.lua

module("logic.extensions.originelizabeth.view.OriginelizabethcontrolView", package.seeall)

local OriginelizabethcontrolView = class("OriginelizabethcontrolView", FanRuiChallengeControlView)

function OriginelizabethcontrolView:_onClickEnter(index)
	if FanRuiChallengeModel.instance:isControlChildStagePass(self._activityId, index) then
		FloatWordMgr.instance:show("已通过")
	else
		FanRuiChallengeController.instance:openControlMissionView(self._activityId, self._curStageIndex, index, self._viewPresentor.viewName, ViewName.OriginelizabethposView)
	end
end

function OriginelizabethcontrolView:_onClickBuff(index)
	local creepsMasterId = checknumber(self._cfgStage.creepsMasterIds[index])

	if creepsMasterId > 0 then
		UIStateManager.instance:push(ViewName.OriginelizabethforecastView, creepsMasterId)
	end
end

return OriginelizabethcontrolView
