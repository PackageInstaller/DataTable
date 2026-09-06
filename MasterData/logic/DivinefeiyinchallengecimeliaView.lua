-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengecimeliaView.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengecimeliaView", package.seeall)

local DivinefeiyinchallengecimeliaView = class("DivinefeiyinchallengecimeliaView", SunWuKongChallengeCimeliaView)

function DivinefeiyinchallengecimeliaView:buildUI()
	DivinefeiyinchallengecimeliaView.super.buildUI(self)

	self._petCon = self:getGo("petCon")
end

function DivinefeiyinchallengecimeliaView:onExit()
	DivinefeiyinchallengecimeliaView.super.onExit(self)

	if self._petRole then
		RoleObjectPool:removeRole(self._petRole)
	end
end

function DivinefeiyinchallengecimeliaView:onEnter()
	DivinefeiyinchallengecimeliaView.super.onEnter(self)

	self._petRole = RoleObjectPool.instance:addRoleToParent(self._petRole, self._actCfg.raceId, self._petCon)
end

function DivinefeiyinchallengecimeliaView:_onClickCell(data, curPassStage, redPoint, isCanLevelUp)
	if curPassStage >= data.unlockStageId then
		GameUtil.SetActive(redPoint, isCanLevelUp)
		UIStateManager.instance:push(ViewName.DivinefeiyinchallengecimeliainfoView, self._activityId, data.cimeliaId)
	else
		FloatWordMgr.instance:show(lang("请先通关前面关卡"))
	end
end

return DivinefeiyinchallengecimeliaView
