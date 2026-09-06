-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/actions/TActionGotoMonster.lua

module("logic.extensions.task.model.actions.TActionGotoMonster", package.seeall)

local TActionGotoMonster = class("TActionGotoMonster", TActionBase)

function TActionGotoMonster:ctor(target, mstId)
	TActionGotoMonster.super.ctor(self, target)

	self._mstId = mstId
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	self._isFinished = nil
	self._waitingMonsterData = nil
end

function TActionGotoMonster:getActionType()
	return TaskConst.GOTOMONSTER
end

function TActionGotoMonster:runAction()
	if not self.isRunning then
		self.isRunning = true

		local scene = SceneMgr.instance:getCurScene()
		local mstSceneId = SceneConfig.instance:getMonsterSceneId(self._mstId)

		if scene:getSceneId() ~= mstSceneId then
			self._gotoScene = TActionFactory.createTAction(TaskConst.GOTOSCENE, self.target, mstSceneId)

			self._gotoScene:runAction()
		else
			self:_goToTarget()
		end
	end
end

function TActionGotoMonster:tick()
	if self._gotoScene then
		if self._gotoScene:isBreaked() then
			self:breakAction()
		else
			self._gotoScene:tick()

			if self._gotoScene:isFinished() then
				self._gotoScene:stopAction()

				self._waitingMonsterData = true
				self._gotoScene = nil
			end
		end
	end

	if self._waitingMonsterData then
		local scene = SceneMgr.instance:getCurScene()

		if not scene.monsterMgr or scene.monsterMgr:isReady() then
			self:_goToTarget()

			self._waitingMonsterData = nil
		end
	end
end

function TActionGotoMonster:isFinished()
	return self._isFinished
end

function TActionGotoMonster:stopAction()
	if self.isRunning then
		self.isRunning = nil

		if self._gotoScene then
			self._gotoScene:stopAction()

			self._gotoScene = nil
		end

		self._isFinished = nil
	end

	if self._gotoMonster ~= nil and self._gotoMonster.isRunning then
		self._gotoMonster.onStoped = nil
		self._gotoMonster.onStopedObj = nil

		self._mainPlayer:stopAction(self._gotoMonster)

		self._gotoMonster = nil
	end
end

function TActionGotoMonster:_goToTarget()
	local mstInsId
	local scene = SceneMgr.instance:getCurScene()

	if scene.monsterMgr then
		mstInsId = scene.monsterMgr:getMonsterInsIds(self._mstId)
	end

	if not mstInsId then
		self._isFinished = true
	else
		self._gotoMonster = self._mainPlayer:gotoMonster(mstInsId, self._onMoveToMonsterFinish, self)
		self._gotoMonster.onStoped = self.breakAction
		self._gotoMonster.onStopedObj = self
	end
end

function TActionGotoMonster:_onMoveToMonsterFinish()
	self._isFinished = true
end

return TActionGotoMonster
