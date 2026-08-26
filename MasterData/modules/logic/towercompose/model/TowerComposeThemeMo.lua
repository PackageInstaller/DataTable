-- chunkname: @modules/logic/towercompose/model/TowerComposeThemeMo.lua

module("modules.logic.towercompose.model.TowerComposeThemeMo", package.seeall)

local TowerComposeThemeMo = class("TowerComposeThemeMo", TowerComposeThemeMo)

function TowerComposeThemeMo:ctor(themeId)
	self.themeId = themeId
	self.passLayerId = 0
	self.researchProgress = 0
	self.unlockModIdMap = {}
	self.unlockModIdList = {}
	self.curBossMo = nil
	self.bossRecordInfoData = nil
	self.hasSavedRecord = false
end

function TowerComposeThemeMo:updateInfo(info)
	self.themeId = info.themeId
	self.researchProgress = info.researchProgress

	self:updateUnlockModIds(info.unlockModIds)
	self:updateComposeBossInfo(info.boss)
	self:updateComposeBossRecordInfo(info.currRecord)

	self.hasSavedRecord = info.savedRecord
	self.passLayerId = info.passMaxLayerId
end

function TowerComposeThemeMo:updateUnlockModIds(unlockModIds)
	for index, modId in ipairs(unlockModIds) do
		if not self.unlockModIdMap[modId] then
			self.unlockModIdMap[modId] = modId

			table.insert(self.unlockModIdList, modId)
		end
	end
end

function TowerComposeThemeMo:updateComposeBossInfo(bossInfo)
	self.curBossMo = self.curBossMo or TowerComposeBossMo.New({
		themeId = self.themeId
	})

	self.curBossMo:updateComposeBossInfo(bossInfo)
end

function TowerComposeThemeMo:updateComposeBossRecordInfo(recordInfo)
	if recordInfo and tonumber(recordInfo.createTime) > 0 then
		if not self.bossRecordInfoData then
			self.bossRecordInfoData = {}
			self.bossRecordInfoData.bossMo = TowerComposeBossMo.New({
				themeId = self.themeId
			})
		end

		self.bossRecordInfoData.createTime = tonumber(recordInfo.createTime)

		self.bossRecordInfoData.bossMo:updateComposeBossInfo(recordInfo.boss)
	else
		self.bossRecordInfoData = nil
	end
end

function TowerComposeThemeMo:getBossRecordInfoData()
	return self.bossRecordInfoData
end

function TowerComposeThemeMo:updatePlaneInfoData(planeInfo)
	if self.curBossMo then
		self.curBossMo:updatePlaneInfoData(planeInfo)
	end
end

function TowerComposeThemeMo:updateResearchProgress(progress)
	self.researchProgress = progress
end

function TowerComposeThemeMo:getPlaneMo(planeId)
	return self.curBossMo and self.curBossMo:getPlaneMo(planeId)
end

function TowerComposeThemeMo:setCurBossLevel(level)
	if self.curBossMo then
		self.curBossMo:setBossLevel(level)
	end
end

function TowerComposeThemeMo:getCurBossLevel()
	return self.curBossMo and self.curBossMo.level
end

function TowerComposeThemeMo:getCurBossHighScore()
	return self.curBossMo and self.curBossMo.highScore
end

function TowerComposeThemeMo:getCurBossMo()
	return self.curBossMo
end

function TowerComposeThemeMo:getAllUnlockModIdList()
	return self.unlockModIdList
end

function TowerComposeThemeMo:isModUnlock(modId)
	return self.unlockModIdMap[modId]
end

function TowerComposeThemeMo:getPlaneResultState(planeId)
	local planeMo = self:getPlaneMo(planeId)

	return planeMo and planeMo.fightResult
end

function TowerComposeThemeMo:isAllPlaneSucc(isRecord)
	if isRecord then
		if self.bossRecordInfoData then
			local currentRecordBossMo = self.bossRecordInfoData.bossMo

			if not currentRecordBossMo then
				return false
			end

			local planeInfoMap = currentRecordBossMo:getPlaneInfoMap()

			for planeId, planeMo in pairs(planeInfoMap) do
				if planeMo.fightResult ~= TowerComposeEnum.FightResult.Win then
					return false, planeId
				end
			end

			return true
		end
	else
		local bossSettleMo = TowerComposeModel.instance:getBossSettleInfo()
		local recordInfoData = bossSettleMo and bossSettleMo:getRecordData()

		if recordInfoData then
			local recordBossMo = recordInfoData.bossMo
			local planeInfoMap = recordBossMo:getPlaneInfoMap()

			for planeId, planeMo in pairs(planeInfoMap) do
				if planeMo.fightResult ~= TowerComposeEnum.FightResult.Win then
					return false, planeId
				end
			end

			return true
		else
			return false
		end
	end
end

return TowerComposeThemeMo
