-- chunkname: @modules/logic/versionactivity3_5/schoolstart/model/V3a5_SchoolStartModel.lua

module("modules.logic.versionactivity3_5.schoolstart.model.V3a5_SchoolStartModel", package.seeall)

local V3a5_SchoolStartModel = class("V3a5_SchoolStartModel", BaseModel)

function V3a5_SchoolStartModel:onInit()
	self:reInit()
end

function V3a5_SchoolStartModel:reInit()
	self._actInfo = {}
	self._rewardIdsList = {}
	self._row = 6
	self._col = 6
end

function V3a5_SchoolStartModel:setAct228Info(msg)
	self.activityId = msg.activityId
	self._config = V3a5_SchoolStartConfig.instance:get228ConfigById(self.activityId)
	self._actInfo = self._actInfo or {}

	if msg and msg.info then
		self._actInfo[self.activityId] = msg.info
		self._stateList = msg.info.gridStates
		self._rewardIdsList = msg.info.rewardIds
	end
end

function V3a5_SchoolStartModel:getCurrentActId()
	return self.activityId
end

function V3a5_SchoolStartModel:getActInfo(actId)
	if not string.nilorempty(actId) then
		return self._actInfo[actId]
	elseif string.nilorempty(actId) then
		return self._actInfo[self.activityId]
	end

	return nil
end

function V3a5_SchoolStartModel:getStateByPos(row, col)
	local info = self:getActInfo()

	if not info then
		return
	end

	return info[row - 1][col - 1]
end

function V3a5_SchoolStartModel:updatePosState(msg)
	if not msg or not msg.gridStates then
		return
	end

	self._indexList = self:calStateIndex(msg.gridStates)
	self._stateList = msg.gridStates
end

function V3a5_SchoolStartModel:getChangeIndexList()
	return self._indexList
end

function V3a5_SchoolStartModel:clearChangeIndexList()
	self._indexList = nil
end

function V3a5_SchoolStartModel:calStateIndex(newStateList)
	local indexList = {}

	for index, newstate in ipairs(newStateList) do
		local oldstate = self._stateList[index]

		if newstate ~= oldstate then
			table.insert(indexList, index)
		end
	end

	return indexList
end

function V3a5_SchoolStartModel:indexToPos(index)
	local r = math.floor(index / self._col) + 1
	local c = index % self._col + 1

	return r, c
end

function V3a5_SchoolStartModel:posToIndex(row, col)
	return (row - 1) * self._col + (col - 1)
end

function V3a5_SchoolStartModel:getNormalFlipCount()
	local info = self:getActInfo()

	if not info then
		return 0
	end

	return info.normalFlipCount or 0
end

function V3a5_SchoolStartModel:getFinalBonus()
	local info = self:getActInfo()

	if not info then
		return false
	end

	return info.getFinalBonus
end

function V3a5_SchoolStartModel:getRewardList()
	local rewardList = {}

	if not self._config or not self._stateList or not self._rewardIdsList then
		return rewardList
	end

	for index, state in ipairs(self._stateList) do
		local rewardId = self._rewardIdsList[index]
		local rewardConfig = V3a5_SchoolStartConfig.instance:getRewardConfigById(rewardId)

		if rewardConfig and not string.nilorempty(rewardConfig.reward) then
			local co = string.splitToNumber(rewardConfig.reward, "#")
			local mo = {}

			mo.type, mo.id, mo.num, mo.state, mo.stateIndex = co[1], co[2], co[3], state == V3a5_SchoolStartEnum.GridState.HasGet, state

			table.insert(rewardList, mo)
		end
	end

	table.sort(rewardList, V3a5_SchoolStartModel.sortFunc)

	local bigRewardCo = {}

	if not string.nilorempty(self._config.finalReward) then
		bigRewardCo = string.splitToNumber(self._config.finalReward, "#")
	end

	local actInfoMo = self:getActInfo()
	local bigMO = {
		type = bigRewardCo[1],
		id = bigRewardCo[2],
		num = bigRewardCo[3],
		state = actInfoMo.getFinalBonus
	}
	local finalrewardList = {
		bigMO
	}

	tabletool.addValues(finalrewardList, rewardList)

	return finalrewardList
end

function V3a5_SchoolStartModel.sortFunc(a, b)
	local aCo = ItemConfig.instance:getItemConfig(a.type, a.id)
	local bCo = ItemConfig.instance:getItemConfig(b.type, b.id)

	if a.stateIndex ~= b.stateIndex then
		return a.stateIndex > b.stateIndex
	else
		if aCo.type == bCo.type then
			if aCo.rare == bCo.rare then
				if aCo.id == bCo.id then
					return a.num > b.num
				end

				return aCo.id < bCo.id
			end

			return aCo.rare > bCo.rare
		end

		return aCo.type > bCo.type
	end
end

function V3a5_SchoolStartModel:updateFinalState()
	local info = self:getActInfo()

	info.getFinalBonus = true
end

function V3a5_SchoolStartModel:checkAllReceive()
	if not self._stateList then
		return false
	end

	for index, state in ipairs(self._stateList) do
		if state == V3a5_SchoolStartEnum.GridState.NotGet then
			return false
		end
	end

	return true
end

V3a5_SchoolStartModel.instance = V3a5_SchoolStartModel.New()

return V3a5_SchoolStartModel
