-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongcontrolView.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongcontrolView", package.seeall)

local DivinexuanmingtianlongcontrolView = class("DivinexuanmingtianlongcontrolView", FanRuiChallengeControlView)

function DivinexuanmingtianlongcontrolView:_onClickEnter(index)
	if FanRuiChallengeModel.instance:isControlChildStagePass(self._activityId, index) then
		FloatWordMgr.instance:show("已通过")
	else
		FanRuiChallengeController.instance:openControlMissionView(self._activityId, self._curStageIndex, index, self._viewPresentor.viewName, ViewName.DivinexuanmingtianlongposView)
	end
end

function DivinexuanmingtianlongcontrolView:_onClickBuff(index)
	local creepsMasterId = checknumber(self._cfgStage.creepsMasterIds[index])

	if creepsMasterId > 0 then
		UIStateManager.instance:push(ViewName.DivinexuanmingtianlongforecastView, creepsMasterId)
	end
end

return DivinexuanmingtianlongcontrolView
