-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyscene/controller/FamilySceneController.lua

module("logic.extensions.familyscene.controller.FamilySceneController", package.seeall)

local FamilySceneController = class("FamilySceneController", BaseController)

function FamilySceneController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneClickWelfare, self._onClickWelfare, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneClickActivities, self._onClickActivities, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneClickTransaction, self._onClickTransaction, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneNotifyVariablesUpdateRes, self._onNotifyVariablesUpdateRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneJoinRes, self._onFamilySceneJoinRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneNotifyJoinResultRes, self._onNotifyJoinResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneExitRes, self._onFamilySceneExitRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneSelectOtherPlayer, self._onFamilySelectOtherPlayer, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneSelectMainPlayer, self._onFamilySelectMainPlayer, self)
	self:onReset()
end

function FamilySceneController:onReset()
	return
end

function FamilySceneController:enterScene(...)
	if FamilyModel.instance:isInFamily() then
		if not FamilySceneModel.instance:isInSceneChannel() then
			self:setOpenViewParam(...)

			local x, z = self:getRandomPos()

			FamilySceneAgent.instance:sendPM_Cube_JoinReq(FamilySceneCubeType.Family, nil, x, 0, z)
		else
			FloatWordMgr.instance:show("已进入家族场景")
		end
	else
		FloatWordMgr.instance:show("请先加入家族")
		FamilyController.instance:openFamilyListView()
	end
end

function FamilySceneController:getRandomPos()
	local x = Mathf.Random(FamilyScene.PlayerBornLimitStartPos.x, FamilyScene.PlayerBornLimitEndPos.x)
	local z = Mathf.Random(FamilyScene.PlayerBornLimitStartPos.z, FamilyScene.PlayerBornLimitEndPos.z)

	return x, z
end

function FamilySceneController:leaveScene()
	if self._sceneId ~= 0 then
		FamilySceneAgent.instance:sendPM_Cube_ExitReq()
		SceneStatusMgr.instance:popStatus(ViewName.MainUI)
		self:setSceneId(0)
	end
end

function FamilySceneController:forceLeaveScene()
	SceneStatusMgr.instance:popStatus(ViewName.MainUI)
	self:setSceneId(0)
end

function FamilySceneController:setOpenViewParam(...)
	self._params = {
		...
	}
end

function FamilySceneController:getOpenViewParam()
	self._params = nil

	return self._params
end

function FamilySceneController:setSceneId(id)
	self._sceneId = id

	if self._sceneId == 0 then
		-- block empty
	end
end

function FamilySceneController:_onClickWelfare()
	if FamilyModel.instance:isInFamily() then
		FamilyController.instance:setFamilyViewTab(5)
		UIStateManager.instance:push(ViewName.Family)
	end
end

function FamilySceneController:_onClickActivities()
	if FamilyModel.instance:isInFamily() then
		FamilyController.instance:setFamilyViewTab(3)
		UIStateManager.instance:push(ViewName.Family)
	end
end

function FamilySceneController:_onClickTransaction()
	if FamilyModel.instance:isInFamily() then
		FamilyController.instance:setFamilyViewTab(4)
		UIStateManager.instance:push(ViewName.Family)
	end
end

function FamilySceneController:openInfoView()
	if FamilyModel.instance:isInFamily() then
		UIStateManager.instance:push(ViewName.Family)
	end
end

function FamilySceneController:openChannelsView()
	if FamilyModel.instance:isInFamily() and FamilySceneModel.instance:isInSceneChannel() then
		UIStateManager.instance:push(ViewName.FamilySceneChannelsView)
	end
end

function FamilySceneController:_onNotifyVariablesUpdateRes(userId, variables)
	local selfUserId = RoleModel.instance:getUserId()

	if selfUserId == checknumber(userId) then
		FamilySceneMainPlayer.instance:updateVariables(variables)
	end

	GlobalDispatcher:dispatch(GlobalNotify.FamilySceneNotifyVariablesUpdateRes, userId)
end

function FamilySceneController:_onFamilySceneJoinRes()
	UIStateManager.instance:clear(false)
end

function FamilySceneController:_onNotifyJoinResultRes()
	local curScene = SceneMgr.instance:getCurScene()

	if curScene:getSceneType() ~= SceneType.Family then
		SceneStatusMgr.instance:saveStatus()
		UIJumper.instance:saveCurStack()

		local bornX, bornZ = FamilySceneModel.instance:getMyPlayerPos()

		SceneMgr.instance:enter(SceneType.Family, 100, bornX, bornZ)
		self:setSceneId(100)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneNotifySwitchChannel)
	end
end

function FamilySceneController:_onFamilySceneExitRes()
	return
end

function FamilySceneController:_onFamilySelectOtherPlayer(playerId)
	local viewName = UIStateManager.instance:getTopName()

	FriendController.instance:showInfoView(playerId)
end

function FamilySceneController:_onFamilySelectMainPlayer()
	return
end

FamilySceneController.instance = FamilySceneController.New()

return FamilySceneController
