-- chunkname: @modules/logic/survival/controller/work/settle/SurvivalSettlePerformanceWork.lua

module("modules.logic.survival.controller.work.settle.SurvivalSettlePerformanceWork", package.seeall)

local SurvivalSettlePerformanceWork = class("SurvivalSettlePerformanceWork", BaseWork)

function SurvivalSettlePerformanceWork:ctor()
	local curScene = GameSceneMgr.instance:getCurScene()

	self.unit = curScene.unit
	self.settleInfo = SurvivalModel.instance:getSurvivalSettleInfo()
end

function SurvivalSettlePerformanceWork:onStart()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock("SurvivalSettlePerformanceWork", 6)
	PopupController.instance:setPause("SurvivalSettlePerformanceWork", true)

	local popLayer = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.setActive(popLayer, false)

	local needShowDestroy, _ = SurvivalShelterModel.instance:getNeedShowFightSuccess()

	if needShowDestroy then
		local entity = self.unit:getShelterMonster()

		if entity then
			entity:playFightEffect()
		end

		TaskDispatcher.runDelay(self.onMonsterAnimFinish, self, 3)
	else
		self:handleEntity()
	end
end

function SurvivalSettlePerformanceWork:onMonsterAnimFinish()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.BossFightSuccessShowFinish)
	self:handleEntity()
end

function SurvivalSettlePerformanceWork:handleEntity()
	SurvivalMapHelper.instance:hideUnitVisible(SurvivalEnum.ShelterUnitType.Npc, false)
	SurvivalMapHelper.instance:hideUnitVisible(SurvivalEnum.ShelterUnitType.Monster, false)
	SurvivalMapHelper.instance:refreshPlayerEntity()
	SurvivalMapHelper.instance:stopShelterPlayerMove()
	TaskDispatcher.runDelay(self.tweenToPlayerPos, self, 0.5)
end

function SurvivalSettlePerformanceWork:tweenToPlayerPos()
	local player = self.unit:getPlayer()

	if not player then
		self:onDone(false)

		return
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale, 1, true)
	player:focusEntity(1, self.playEntityAnim, self)
end

function SurvivalSettlePerformanceWork:playEntityAnim()
	local player = self.unit:getPlayer()

	if not player then
		self:onDone(false)

		return
	end

	if not self.settleInfo.win then
		local isWin = false

		if isWin then
			player:playAnim("jump2")
			TaskDispatcher.runDelay(self.onPlayerAnimFinish, self, 1)
		else
			player:playAnim("die")
			TaskDispatcher.runDelay(self.onPlayerAnimFinish, self, 2)
		end
	end
end

function SurvivalSettlePerformanceWork:onPlayerAnimFinish()
	local player = self.unit:getPlayer()

	if player then
		if not self.settleInfo.win then
			if self.settleInfo.win then
				player:playAnim("idle")
			end
		end
	end

	self:onDone(true)
end

function SurvivalSettlePerformanceWork:clearWork()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockHelper.instance:endBlock("SurvivalSettlePerformanceWork")
	PopupController.instance:setPause("SurvivalSettlePerformanceWork", false)

	local popLayer = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.setActive(popLayer, true)
	SurvivalShelterModel.instance:setNeedShowFightSuccess(nil, nil)
	TaskDispatcher.cancelTask(self.handleEntity, self)
	TaskDispatcher.cancelTask(self.tweenToPlayerPos, self)
	TaskDispatcher.cancelTask(self.onPlayerAnimFinish, self)
end

return SurvivalSettlePerformanceWork
