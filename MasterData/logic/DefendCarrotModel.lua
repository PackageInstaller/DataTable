-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotModel.lua

module("logic.extensions.defendcarrot.model.DefendCarrotModel", package.seeall)

local DefendCarrotModel = class("DefendCarrotModel", BaseModel)

function DefendCarrotModel:onInit()
	self:onReset()
end

function DefendCarrotModel:onReset()
	self._baseInfoMap = {}
	self._rankInfoMap = {}
end

function DefendCarrotModel:getBaseInfo(activityId)
	local baseInfo = self._baseInfoMap[activityId]

	if not baseInfo then
		print(string.format("守卫萝卜数据未初始化：%s", activityId))
	end

	return baseInfo
end

function DefendCarrotModel:getRankInfo(activityId)
	local rankInfo = self._rankInfoMap[activityId]

	if not rankInfo then
		print(string.format("守卫萝卜排行榜数据未初始化：%s", activityId))
	end

	return rankInfo
end

function DefendCarrotModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._baseInfoMap[activityId] = info
end

function DefendCarrotModel:onUpgradeWeapon(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		local weaponId = info.weaponId
		local newLevel = info.newLevel

		if not baseInfo.weapons then
			local isExist = false

			for _, weaponInfo in ipairs(baseInfo.weapons) do
				if weaponInfo.weaponId == weaponId then
					weaponInfo.level = newLevel
					isExist = true

					break
				end
			end

			if not isExist then
				local newWeaponInfo = {}

				newWeaponInfo.weaponId = weaponId
				newWeaponInfo.level = newLevel

				table.insert(baseInfo.weapons, newWeaponInfo)

				baseInfo.weapons = baseInfo.weapons
			end
		end
	end
end

function DefendCarrotModel:onStartGame(msg)
	local info = GameUtil.pbToTable(msg)
end

function DefendCarrotModel:onEndGame(msg)
	local info = GameUtil.pbToTable(msg)
end

function DefendCarrotModel:onGainPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		if not baseInfo.gainedPrizeIds then
			table.insert(baseInfo.gainedPrizeIds, info.prizeId)

			baseInfo.gainedPrizeIds = baseInfo.gainedPrizeIds
		end
	end
end

function DefendCarrotModel:onStartMaterialGame(msg)
	local info = GameUtil.pbToTable(msg)
end

function DefendCarrotModel:onEndMaterialGame(msg)
	local info = GameUtil.pbToTable(msg)
end

function DefendCarrotModel:onGetRankInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._rankInfoMap[activityId] = info
end

function DefendCarrotModel:getWeaponLevel(activityId, weaponId)
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		if not baseInfo.weapons then
			for _, weaponInfo in ipairs(baseInfo.weapons) do
				if weaponInfo.weaponId == weaponId then
					return weaponInfo.level
				end
			end
		end
	end

	return 1
end

function DefendCarrotModel:isExtraTaskCompleted(activityId, stageId, taskId)
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		if not baseInfo.stages then
			for _, stageInfo in ipairs(baseInfo.stages) do
				if stageInfo.stageId == stageId then
					if not stageInfo.finishedTaskIds then
						for _, id in ipairs(stageInfo.finishedTaskIds) do
							if id == taskId then
								return true
							end
						end

						break
					end
				end
			end
		end
	end

	return false
end

DefendCarrotModel.instance = DefendCarrotModel.New()

return DefendCarrotModel
