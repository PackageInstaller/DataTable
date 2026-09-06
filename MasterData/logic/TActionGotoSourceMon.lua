-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/actions/TActionGotoSourceMon.lua

module("logic.extensions.task.model.actions.TActionGotoSourceMon", package.seeall)

local TActionGotoSourceMon = class("TActionGotoSourceMon", TActionBase)

function TActionGotoSourceMon:ctor(mstId)
	TActionGotoSourceMon.super.ctor(self)

	local mstCo = SceneConfig.instance:getMonsterMaskterCo(mstId)

	self._zoneId = mstCo.sceneZoneId
	self._mstId = mstId
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	self._isFinished = nil
	self._waitingMonsterData = nil
end

function TActionGotoSourceMon:getActionType()
	return TaskConst.GOTOSOURCEMON
end

function TActionGotoSourceMon:runAction()
	if not self.isRunning then
		self.isRunning = true

		local scene = SceneMgr.instance:getCurScene()
		local zoneCo = SceneConfig.instance:getSceneIdBySceneZoneId(self._zoneId)

		if scene:getSceneId() ~= zoneCo.sceneId then
			self._gotoScene = TActionFactory.createTAction(TaskConst.GOTOSCENE, self.target, zoneCo.sceneId)

			self._gotoScene:runAction()
		else
			self:_goToTarget()
		end
	end
end

function TActionGotoSourceMon:tick()
	if self._gotoScene then
		if self._gotoScene:isBreaked() then
			self:breakAction()
		else
			self._gotoScene:tick()

			if self._gotoScene:isFinished() then
				self._gotoScene:stopAction()

				self._gotoScene = nil

				self:_goToTarget()
			end
		end
	end
end

function TActionGotoSourceMon:isFinished()
	return self._isFinished
end

function TActionGotoSourceMon:stopAction()
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

function TActionGotoSourceMon:_goToTarget()
	local mstInsId
	local scene = SceneMgr.instance:getCurScene()

	if scene.monsterMgr then
		mstInsId = scene.monsterMgr:getMonsterInsIds(self._mstId)
	end

	if not mstInsId then
		self._gotoMonster = self._mainPlayer:gotoMonsterZone(self._zoneId, self._onMoveToMonsterFinish, self)

		if self._gotoMonster then
			self._gotoMonster.onStoped = self.breakAction
			self._gotoMonster.onStopedObj = self
		end
	else
		self._gotoMonster = self._mainPlayer:gotoMonster(mstInsId, self._onMoveToMonsterFinish, self)
		self._gotoMonster.onStoped = self.breakAction
		self._gotoMonster.onStopedObj = self
	end
end

function TActionGotoSourceMon:_onMoveToMonsterFinish()
	self._isFinished = true
end

return TActionGotoSourceMon
