-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengehidenView.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengehidenView", package.seeall)

local DivinefeiyinchallengehidenView = class("DivinefeiyinchallengehidenView", SunWuKongChallengeHidenView)

function DivinefeiyinchallengehidenView:_onClickBalloonGame()
	UIStateManager.instance:push(ViewName.DivinefeiyinchallengeballoonView, self._activityId, self._stageId)
	self:close()
end

function DivinefeiyinchallengehidenView:_onClickFlipGame()
	UIStateManager.instance:push(ViewName.DivinefeiyinchallengeflipgameView, self._activityId, self._stageId)
	self:close()
end

function DivinefeiyinchallengehidenView:_onClickDetail()
	local hiddentTaskCfg = SunWuKongChallengeConfig.instance:getHiddendTaskInfo(self._stageCfg.hiddenTaskId)

	UIStateManager.instance:push(ViewName.DivinefeiyinchallengerewardView, hiddentTaskCfg.prizePlanId)
end

return DivinefeiyinchallengehidenView
