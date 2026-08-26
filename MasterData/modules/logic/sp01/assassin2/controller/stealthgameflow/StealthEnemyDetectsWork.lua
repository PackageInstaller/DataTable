-- chunkname: @modules/logic/sp01/assassin2/controller/stealthgameflow/StealthEnemyDetectsWork.lua

module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyDetectsWork", package.seeall)

local StealthEnemyDetectsWork = class("StealthEnemyDetectsWork", BaseWork)

function StealthEnemyDetectsWork:onStart(context)
	local playScanGridIdDict = {}
	local heroUidList = AssassinStealthGameModel.instance:getHeroUidList()

	for _, heroUid in ipairs(heroUidList) do
		local isCanBeScan = AssassinStealthGameHelper.isHeroCanBeScan(heroUid)

		if isCanBeScan then
			local heroGameMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)
			local gridId = heroGameMo:getPos()

			if not playScanGridIdDict[gridId] then
				local enemyWillScan = AssassinStealthGameHelper.isGridEnemyWillScan(gridId)

				if enemyWillScan then
					playScanGridIdDict[gridId] = true
				end
			end
		end
	end

	if next(playScanGridIdDict) then
		for gridId, _ in pairs(playScanGridIdDict) do
			AssassinStealthGameEntityMgr.instance:playGridScanEff(gridId)
		end

		local duration = AssassinConfig.instance:getAssassinEffectDuration(AssassinEnum.EffectId.ScanEffectId)

		TaskDispatcher.cancelTask(self._playScanEffFinished, self)
		TaskDispatcher.runDelay(self._playScanEffFinished, self, duration)
	else
		self:_playScanEffFinished()
	end
end

local OVER_TIME = 3

function StealthEnemyDetectsWork:_playScanEffFinished()
	local exposeHeroUidList = {}
	local enemyOperationData = AssassinStealthGameModel.instance:getEnemyOperationData()
	local exposeHeroList = enemyOperationData and enemyOperationData.hero

	if exposeHeroList then
		AssassinStealthGameController.instance:updateHeroes(exposeHeroList)

		for _, heroUint in ipairs(exposeHeroList) do
			exposeHeroUidList[#exposeHeroUidList + 1] = heroUint.uid
		end
	end

	if #exposeHeroUidList > 0 then
		AssassinStealthGameController.instance:registerCallback(AssassinEvent.PlayExposeTipFinished, self._showExposedTipFinished, self)
		AssassinStealthGameController.instance:heroBeExposed(exposeHeroUidList, self._showExposedTipFinished, self)
		TaskDispatcher.cancelTask(self._showExposedTipFinished, self)
		TaskDispatcher.runDelay(self._showExposedTipFinished, self, OVER_TIME)
	else
		self:_showExposedTipFinished()
	end
end

function StealthEnemyDetectsWork:_showExposedTipFinished()
	AssassinStealthGameController.instance:unregisterCallback(AssassinEvent.PlayExposeTipFinished, self._showExposedTipFinished, self)
	TaskDispatcher.cancelTask(self._showExposedTipFinished, self)
	self:onDone(true)
end

function StealthEnemyDetectsWork:clearWork()
	AssassinStealthGameController.instance:unregisterCallback(AssassinEvent.PlayExposeTipFinished, self._showExposedTipFinished, self)
	TaskDispatcher.cancelTask(self._showExposedTipFinished, self)
	TaskDispatcher.cancelTask(self._playScanEffFinished, self)
end

return StealthEnemyDetectsWork
