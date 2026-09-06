-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/controller/WeakPathFindingController.lua

module("logic.extensions.weakpathfinding.controller.WeakPathFindingController", package.seeall)

local WeakPathFindingController = class("WeakPathFindingController", BaseController)

function WeakPathFindingController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.startEnterGame, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self.startEnterGame, self)
	GlobalDispatcher:addListener("weak_path_finding_npc", self.gotoFindNPC, self)
end

function WeakPathFindingController:getInfo()
	WeakPathfindingAgent.instance:sendPM_WeakPathfindingInfoReq()
end

function WeakPathFindingController:handleGetInfo(msg)
	WeakPathFindingModel.instance:onGetInfo(msg)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_WEAKPATHFINDING_GOTO, WeakPathFindingModel.instance:getCurState() == 1)
	self:setNpcIsShow(WeakPathFindingModel.instance:getCurState() == 1)
	GlobalDispatcher:dispatch(GlobalNotify.WeakPathFindingUpdateInfo)
end

function WeakPathFindingController:startFinding()
	WeakPathfindingAgent.instance:sendPM_WeakPathFindingStartFindReq()
end

function WeakPathFindingController:handleStartFinding(msg)
	WeakPathFindingModel.instance:onStartFinding(msg)
	self:setNpcIsShow(true)
	GlobalDispatcher:dispatch(GlobalNotify.WeakPathFindingUpdateInfo)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_WEAKPATHFINDING_GOTO, true)
end

function WeakPathFindingController:startGame()
	WeakPathfindingAgent.instance:sendPM_WeakPathFindingStartGameReq()
end

function WeakPathFindingController:handleStartGame(msg)
	WeakPathFindingModel.instance:onStartGame(msg)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_WEAKPATHFINDING_GOTO, false)
	self:setNpcIsShow(false)
	GlobalDispatcher:dispatch(GlobalNotify.WeakPathFindingGameStart)
end

function WeakPathFindingController:endGame(countdownId, isWin)
	WeakPathfindingAgent.instance:sendPM_WeakPathFindingEndGameReq(countdownId, isWin)
end

function WeakPathFindingController:handleEndGame(msg)
	WeakPathFindingModel.instance:onEndGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WeakPathFindingGameEnd)
end

function WeakPathFindingController:gainPrize(prizeId)
	WeakPathfindingAgent.instance:sendPM_WeakPathFindingGainPrizeReq(prizeId)
	WeakPathFindingModel.instance:setCurGainPrizeId(prizeId)
end

function WeakPathFindingController:handleGainPrize(msg)
	WeakPathFindingModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WeakPathFindingUpdateInfo)
end

function WeakPathFindingController:startEnterGame()
	local actTimeCfg = WeakPathFindingModel.instance:getCurActTimeCfg()

	if actTimeCfg then
		local curActId = WeakPathFindingModel.instance:getCurActId()

		if curActId ~= actTimeCfg.activityId then
			WeakPathFindingModel.instance:onReset()
			WeakPathFindingModel.instance:setCurActId(actTimeCfg.activityId)
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_WEAKPATHFINDING_GOTO, false)
			self:getInfo()
		end
	else
		WeakPathFindingModel.instance:onReset()
		self:setNpcIsShow(false)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_WEAKPATHFINDING_GOTO, false)
	end
end

function WeakPathFindingController:gotoFindNPC()
	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前正在护送")

		return
	end

	local targetSceneId = WeakPathFindingModel.instance:getCurSceneId()

	if targetSceneId > 0 then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer and mainPlayer.spine then
			mainPlayer:gotoScene(targetSceneId, function()
				if not ViewMgr.instance:isOpen(ViewName.WeakPathFindingView) then
					UIStateManager.instance:open(ViewName.WeakPathFindingView)
				end
			end)
		end
	end
end

function WeakPathFindingController:setNpcIsShow(isShow)
	local curNpcId = WeakPathFindingModel.instance:getCurNpcId()

	if isShow then
		SceneNpcsMgr.instance:createNpc(curNpcId)
	else
		local cfgs = WeakPathFindingConfig.instance:getNpcCfgs()

		for k, v in pairs(cfgs) do
			if v and v.npcId then
				SceneNpcsMgr.instance:removeNpc(v.npcId)
			end
		end
	end
end

function WeakPathFindingController:getNpcPosXAndY()
	local x, y
	local curNpcId = WeakPathFindingModel.instance:getCurNpcId()
	local scene = SceneMgr.instance:getCurScene()
	local unitNpc = scene.unitFactory:getUnit(UnitTag.Npc, curNpcId)

	if unitNpc then
		x, y = unitNpc.transform:getPos()
	end

	return x, y
end

WeakPathFindingController.instance = WeakPathFindingController.New()

return WeakPathFindingController
