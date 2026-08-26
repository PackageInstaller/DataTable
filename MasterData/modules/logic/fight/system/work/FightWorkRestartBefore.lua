-- chunkname: @modules/logic/fight/system/work/FightWorkRestartBefore.lua

module("modules.logic.fight.system.work.FightWorkRestartBefore", package.seeall)

local FightWorkRestartBefore = class("FightWorkRestartBefore", FightWorkItem)

function FightWorkRestartBefore:onStart()
	self.work = self:com_registWork(FightWorkClearBeforeRestart)

	self.work:registFinishCallback(self._onWorkFinish, self)
	self:cancelFightWorkSafeTimer()
	self.work:start()
end

function FightWorkRestartBefore:_onWorkFinish()
	if self.context and self.context.noReloadScene then
		self:_correctRootState()
		self:onDone(true)

		return
	end

	local prevSceneLevelId = GameSceneMgr.instance:getCurLevelId()
	local fightParam = FightModel.instance:getFightParam()
	local firstLevelId = fightParam:getSceneLevel(1)

	if prevSceneLevelId ~= firstLevelId then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView)
		GameSceneMgr.instance:showLoading(SceneType.Fight)
		self:com_registSingleTimer(self._delayDone, 5)
		self:com_registTimer(self._startLoadLevel, 0.25)

		self._loadTime = Time.time
	else
		self:_correctRootState()
		self:onDone(true)
	end
end

function FightWorkRestartBefore:_correctRootState()
	local fightScene = GameSceneMgr.instance:getCurScene()
	local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

	gohelper.setActive(sceneObj, true)

	if GameSceneMgr.instance:getCurSceneId() == FightTLEventMarkSceneDefaultRoot.sceneId and GameSceneMgr.instance:getCurLevelId() == FightTLEventMarkSceneDefaultRoot.levelId and fightScene and sceneObj then
		local childCount = sceneObj.transform.childCount

		for i = 0, childCount - 1 do
			local childItem = sceneObj.transform:GetChild(i)

			gohelper.setActive(childItem.gameObject, childItem.name == FightTLEventMarkSceneDefaultRoot.rootName)
		end
	end
end

function FightWorkRestartBefore:_startLoadLevel()
	local key = FightParamData.ParamKey.SceneId

	if FightDataHelper.fieldMgr then
		if FightDataHelper.fieldMgr and FightDataHelper.fieldMgr:getKey(key) then
			FightDataHelper.fieldMgr[key] = nil
		end

		self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded)

		local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)
		local fightParam = FightModel.instance:getFightParam()
		local firstLevelId = fightParam:getSceneLevel(1)

		FightGameMgr.sceneLevelMgr:loadScene(nil, firstLevelId)
	end
end

function FightWorkRestartBefore:_onLevelLoaded()
	local passTime = Time.time - self._loadTime
	local delay = 0.5 - passTime

	if delay <= 0 then
		self:onDone(true)
	else
		self:com_registSingleTimer(self._delayDone, delay)
	end

	GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
end

function FightWorkRestartBefore:_delayDone()
	local cur_scene = GameSceneMgr.instance:getCurScene()

	self:onDone(true)
end

function FightWorkRestartBefore:clearWork()
	GameSceneMgr.instance:hideLoading()

	if self.work then
		self.work:disposeSelf()

		self.work = nil
	end
end

return FightWorkRestartBefore
