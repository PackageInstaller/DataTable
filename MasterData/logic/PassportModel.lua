-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/model/PassportModel.lua

module("logic.extensions.passport.model.PassportModel", package.seeall)

local PassportModel = class("PassportModel", BaseModel)

PassportModel.ID_NewYearInvest = 13
PassportModel.ID_TenSeven = 17
PassportModel.ID_TenSeven_Add = 21
PassportModel.ID_MMTeamPassport = 26
PassportModel.FREE_PRIZE_TYPE = 1
PassportModel.ORDINARY_PAYMENT_PRIZE_TYPE = 2
PassportModel.ADDITIONAL_PAYMENT_PRIZE_TYPE = 3
PassportModel.THIRD_PAYMENT_PRIZE_TYPE = 4

function PassportModel:ctor()
	return
end

function PassportModel:onInit()
	PassportModel.super.onInit(self)
	self:onReset()
end

function PassportModel:onReset()
	self._lastSldValue = nil
	self._lastTaskSwitchId = nil
	self._passActIds = nil
	self._passFuncIds = nil
	self._activityInfoMap = {}
end

function PassportModel:resetPassActIds()
	self._passActIds = nil
	self._passFuncIds = nil
end

function PassportModel:setPassActIds(msg)
	self._passActIds = msg.actIds
	self._passFuncIds = {}

	for i, v in ipairs(self._passActIds) do
		local cfg = PassportConfig.instance:getPermanentActivityCfgById(v)

		if cfg then
			table.insert(self._passFuncIds, cfg.funcId)
		else
			table.insert(self._passFuncIds, 0)
		end
	end
end

function PassportModel:checkIsActiveByFuncId(funcId)
	if self._passFuncIds == nil then
		return false
	end

	funcId = checknumber(funcId)

	return table.indexof(self._passFuncIds, funcId) ~= false
end

function PassportModel:getLastSldValue()
	return self._lastSldValue
end

function PassportModel:setLastSldValue(setValue)
	self._lastSldValue = checknumber(setValue)
end

function PassportModel:updateAfterDoSomething(msg)
	if msg == nil or table.nums(msg) == 0 then
		printError("Get Empty Msg")

		return
	end
end

function PassportModel:updateAfterGetInfo(msg)
	self:updateByActivityInfo(msg.actInfos)
end

function PassportModel:updateByActivityInfo(actInfo)
	local info = PassportActivityInfo.New()
	local data = actInfo

	info.funcId = data.funcId
	info.actId = data.actId
	info.progress = data.progress
	info.endTime = data.endTime
	info.usefulProgress = data.availableProcess
	info.hasPay = false
	info.hasPayAdd = false
	info.hasPayThird = false

	for _, prizeType in ipairs(data.openedPrizeTypes) do
		if prizeType == 2 then
			info.hasPay = true
		end

		if prizeType == 3 then
			info.hasPayAdd = true
		end

		if prizeType == 4 then
			info.hasPayThird = true
		end
	end

	local t = {}

	for _, isGain in ipairs(data.normalPrizeState) do
		table.insert(t, checkbool(isGain))
	end

	info.normalPrizeState = t
	t = {}

	for _, isGain in ipairs(data.superPrizeState) do
		table.insert(t, checkbool(isGain))
	end

	info.superPrizeState = t
	t = {}

	for _, isGain in ipairs(data.additionalPrizeState) do
		table.insert(t, checkbool(isGain))
	end

	info.addPrizeState = t
	t = {}

	for _, isGain in ipairs(data.thirdPrizeState) do
		table.insert(t, checkbool(isGain))
	end

	info.thirdPrizeState = t
	info.gainPayAll = data.gainPayAll
	info.funcCfg = PassportConfig.instance:getPassportBaseCfgById(info.funcId)

	if info.funcCfg.type == 1 then
		info.actCfg = PassportConfig.instance:getPeriodActivityCfgById(info.actId)
		info.prizeCfgs = PassportConfig.instance:getPeriodPrizeCfgsByActId(info.actId)
	elseif info.funcCfg.type == 2 then
		info.actCfg = PassportConfig.instance:getPermanentActivityCfgById(info.actId)
		info.prizeCfgs = PassportConfig.instance:getPermanentPrizeCfgsByActId(info.actId)
	end

	self:updateLockIndex(info)

	self._activityInfoMap[data.funcId] = info
end

function PassportModel:updateAfterGainPrize(msg)
	local prizeIndex = checkint(msg.prizeIndex)
	local info = self:getInfo(msg.funcId)

	if info == nil then
		return
	end

	if msg.prizeType == 1 then
		info.normalPrizeState[prizeIndex + 1] = true
	elseif msg.prizeType == 2 then
		info.superPrizeState[prizeIndex + 1] = true
	elseif msg.prizeType == 3 then
		info.addPrizeState[prizeIndex + 1] = true
	elseif msg.prizeType == 4 then
		info.thirdPrizeState[prizeIndex + 1] = true
	end
end

function PassportModel:updateAfterOneKeyGainPrize(msg)
	local info = self:getInfo(msg.funcId)

	if info == nil then
		return
	end

	self:updateLockIndex(info)

	for i = 1, info.unlockIndex - 1 do
		info.normalPrizeState[i] = true
	end

	if info.hasPay then
		for i = 1, info.unlockIndex - 1 do
			info.superPrizeState[i] = true
		end
	end

	if info.hasPayAdd then
		for i = 1, info.unlockIndex - 1 do
			info.addPrizeState[i] = true
		end
	end

	if info.hasPayThird then
		for i = 1, info.unlockIndex - 1 do
			info.thirdPrizeState[i] = true
		end
	end
end

function PassportModel:updateAfterBuyProgress(msg)
	local info = self:getInfo(msg.funcId)

	if info == nil then
		return
	end

	info.progress = math.max(info.progress, msg.progress)

	self:updateLockIndex(info)
end

function PassportModel:updateAfterPayBuyCertSuc(msg)
	local info = self:getInfo(msg.funcId)

	if info then
		if msg.prizeType == 2 then
			info.hasPay = true
		end

		if msg.prizeType == 3 then
			info.hasPayAdd = true
		end

		if msg.prizeType == 4 then
			info.hasPayThird = true
		end
	end
end

function PassportModel:updateAfterGainExtraPrize(msg)
	local info = self:getInfo(msg.funcId)

	if info == nil then
		return
	end

	info.usefulProgress = checkint(msg.availableProcess)
end

function PassportModel:handleBuyPassportRes(msg)
	local info = self:getInfo(msg.funcId)

	if info then
		if msg.prizeType == 2 then
			info.hasPay = true
		end

		if msg.prizeType == 3 then
			info.hasPayAdd = true
		end

		if msg.prizeType == 4 then
			info.hasPayThird = true
		end
	end
end

function PassportModel:getSomething()
	return self._something
end

function PassportModel:getInfo(funcId)
	return self._activityInfoMap[funcId]
end

function PassportModel:getCurDataList(isAdd, funcId)
	local dataListNormalNoGet = {}
	local dataListSuperNoGet = {}
	local dataListSuperAll = {}
	local diamondNum = 0
	local id = 0
	local tempNormalNoGetCfgs = {}
	local tempSuperNoGetCfgs = {}
	local tem = {}
	local info = self:getInfo(funcId)

	if info == nil then
		return
	end

	for _, v in ipairs(info.prizeCfgs) do
		id = id + 1

		if id < info.unlockIndex then
			if not info.normalPrizeState[id] then
				table.insert(tempNormalNoGetCfgs, v)
			end

			if isAdd then
				if not info.addPrizeState[id] then
					table.insert(tempSuperNoGetCfgs, v)
				end
			elseif not info.superPrizeState[id] then
				table.insert(tempSuperNoGetCfgs, v)
			end
		end

		table.insert(tem, v)
	end

	ArraySort.sortOn(tem, "itemQuality", ArraySort.DESCENDING)

	for i, v in ipairs(tem) do
		if isAdd then
			table.insert(dataListSuperAll, v.additionalPaymentPrize)
		else
			table.insert(dataListSuperAll, v.payedPrize)
		end
	end

	table.sort(tempNormalNoGetCfgs, function(a, b)
		return checknumber(a.itemQuality) > checknumber(b.itemQuality)
	end)
	table.sort(tempSuperNoGetCfgs, function(a, b)
		return checknumber(a.itemQuality) > checknumber(b.itemQuality)
	end)

	for i, v in ipairs(tempNormalNoGetCfgs) do
		table.insert(dataListNormalNoGet, v.freePrize)
	end

	for i, v in ipairs(tempSuperNoGetCfgs) do
		table.insert(dataListSuperNoGet, v.payedPrize)
	end

	dataListNormalNoGet = string.split(MaterialMgr.combineStrs(unpack(dataListNormalNoGet)), "#")
	dataListSuperNoGet = string.split(MaterialMgr.combineStrs(unpack(dataListSuperNoGet)), "#")
	dataListSuperAll = string.split(MaterialMgr.combineStrs(unpack(dataListSuperAll)), "#")

	for _, v in ipairs(dataListNormalNoGet) do
		if string.find(v, "104:2:") ~= nil then
			diamondNum = diamondNum + checkint(string.sub(v, string.len("104:2:") + 1))
		end
	end

	for _, v in ipairs(dataListSuperNoGet) do
		if string.find(v, "104:2:") ~= nil then
			diamondNum = diamondNum + checkint(string.sub(v, string.len("104:2:") + 1))
		end
	end

	if #dataListNormalNoGet == 1 and GameUtil.isEmptyString(dataListNormalNoGet[1]) then
		dataListNormalNoGet = {}
	end

	if #dataListSuperNoGet == 1 and GameUtil.isEmptyString(dataListSuperNoGet[1]) then
		dataListSuperNoGet = {}
	end

	return dataListNormalNoGet, dataListSuperNoGet, dataListSuperAll, diamondNum
end

function PassportModel:setSomething()
	return self._something
end

function PassportModel:updateLockIndex(info)
	if info.funcId == 1 or info.funcId == 6 or info.funcId == 8 or info.funcId == 9 or info.funcId == 11 or info.funcId == 12 or info.funcId == 14 or info.funcId == 15 or info.funcId == 18 or info.funcId == 19 or info.funcId == 22 or info.funcId == 25 or info.funcId == PassportModel.ID_MMTeamPassport then
		local id = 0
		local isAllPass = true
		local lastProgress = 0
		local curPorgress = 0
		local sldValue = 0

		for _, v in ipairs(info.prizeCfgs) do
			id = id + 1

			if isAllPass and info.progress < checkint(v.thresholdParam) then
				info.unlockIndex = id
				curPorgress = checkint(v.thresholdParam)
				isAllPass = false
			end

			lastProgress = checkint(v.thresholdParam)
		end

		if isAllPass then
			info.unlockIndex = id + 1
			curPorgress = lastProgress
			sldValue = 1
		end

		local progressCellCount = #info.prizeCfgs

		if progressCellCount <= 1 then
			local firstProgress = info.prizeCfgs[1] and checkint(info.prizeCfgs[1].thresholdParam) or 0

			sldValue = firstProgress <= info.progress and 1 or 0
		elseif not isAllPass then
			local firstProgress = checkint(info.prizeCfgs[1].thresholdParam)
			local lastCellProgress = checkint(info.prizeCfgs[progressCellCount].thresholdParam)

			if firstProgress >= info.progress then
				sldValue = 0
			elseif lastCellProgress <= info.progress then
				sldValue = 1
			else
				for i = 2, progressCellCount do
					local prevProgress = checkint(info.prizeCfgs[i - 1].thresholdParam)
					local nextProgress = checkint(info.prizeCfgs[i].thresholdParam)

					if nextProgress >= info.progress then
						local range = nextProgress - prevProgress
						local offset = range > 0 and checknumber(info.progress - prevProgress) / checknumber(range) or 0

						sldValue = checknumber(i - 2 + offset) / checknumber(progressCellCount - 1)

						break
					end
				end
			end
		end

		info.progressTxt = string.format("%s/%s", math.min(info.progress, curPorgress), curPorgress)
		info.sldValue = Mathf.Clamp(sldValue, 0, 1)
		info.progressAbletToBuy = checknumber(lastProgress) - checknumber(info.progress)
	elseif info.funcId == 2 then
		local id = 0
		local isAllPass = true
		local lastProgress = 0
		local curPorgress = 0

		for _, v in ipairs(info.prizeCfgs) do
			id = id + 1

			if isAllPass and info.progress < checkint(v.thresholdParam) then
				info.unlockIndex = id
				curPorgress = checkint(v.thresholdParam)
				isAllPass = false
			end

			lastProgress = checkint(v.thresholdParam)
		end

		if isAllPass then
			curPorgress = lastProgress
			info.unlockIndex = id + 1
		end

		info.progressTxt = string.format("%s/%s", info.progress, curPorgress)
		info.sldValue = checknumber(info.progress) / checknumber(lastProgress)
		info.progressAbletToBuy = checknumber(lastProgress) - checknumber(info.progress)
	elseif info.funcId == 3 or info.funcId == 23 then
		local level = WTowerModel.instance:getMaxReachLevel(1)

		info.progressTxt = WTowerModel.instance:passedAllLevel(1) and "已全通" or string.format("第%s层", level)

		local id = 0
		local isAllPass = true
		local lastLevel

		for _, v in ipairs(info.prizeCfgs) do
			id = id + 1

			if isAllPass and level < checkint(v.thresholdParam) then
				info.unlockIndex = id
				isAllPass = false
			end

			lastLevel = checkint(v.thresholdParam)
		end

		if isAllPass then
			info.unlockIndex = id + 1
		end

		info.sldValue = checknumber(level) / checknumber(lastLevel)
	elseif info.funcId == 4 or info.funcId == 24 then
		local id = 0
		local isAllPass = true

		for _, v in ipairs(info.prizeCfgs) do
			id = id + 1

			local params = string.split(v.thresholdParam, "-")

			if not PlotCopyModel.instance:isStagePassed(checkint(params[1]), checkint(params[2])) then
				info.progressTxt = string.format("第%s章", checkint(params[1]) - 1000)
				info.unlockIndex = id
				isAllPass = false

				break
			end
		end

		if isAllPass then
			info.unlockIndex = id + 1
			info.progressTxt = "已全通"
		end

		info.sldValue = checknumber(info.unlockIndex - 1) / checknumber(table.nums(info.prizeCfgs))
	elseif info.funcId == 5 or info.funcId == PassportModel.ID_NewYearInvest or info.funcId == PassportModel.ID_TenSeven or info.funcId == PassportModel.ID_TenSeven_Add then
		local id = 0
		local isAllPass = true
		local lastProgress = 0
		local curPorgress = 0

		for _, v in ipairs(info.prizeCfgs) do
			id = id + 1

			if isAllPass and info.progress < checkint(v.thresholdParam) then
				info.unlockIndex = id
				curPorgress = checkint(v.thresholdParam)
				isAllPass = false
			end

			lastProgress = checkint(v.thresholdParam)
		end

		if isAllPass then
			info.unlockIndex = id + 1
			curPorgress = lastProgress
		end
	elseif info.funcId == 7 or info.funcId == 16 then
		local curCellIdx = 0
		local totalCellIdx = #info.prizeCfgs
		local curPercentage = 0
		local cellPercentage = 1 / totalCellIdx
		local curPorgress = 0
		local lastMaxProgress = checkint(info.prizeCfgs[totalCellIdx].thresholdParam)
		local isAllPass = true

		for idx, v in ipairs(info.prizeCfgs) do
			if info.progress >= checkint(v.thresholdParam) then
				curPorgress = checkint(info.progress)
				curCellIdx = idx
			else
				isAllPass = false

				break
			end
		end

		curCellIdx = Mathf.Clamp(curCellIdx, 0, totalCellIdx)

		local nextCellIdx = Mathf.Clamp(curCellIdx + 1, 0, totalCellIdx)
		local curCellProgress = checkint((info.prizeCfgs[curCellIdx] or nil) and info.prizeCfgs[curCellIdx].thresholdParam)
		local nextCellProgress = checkint((info.prizeCfgs[nextCellIdx] or nil) and info.prizeCfgs[nextCellIdx].thresholdParam)
		local curCellPercentage = 0

		if nextCellProgress - curCellProgress ~= 0 then
			curCellPercentage = (curPorgress - curCellProgress) / (nextCellProgress - curCellProgress) * cellPercentage
		end

		curPercentage = 0

		if curCellIdx - 1 >= 0 then
			curPercentage = (curCellIdx - 1) / (totalCellIdx - 1) + curCellPercentage
		end

		info.progressTxt = string.format("%s/%s", math.min(info.progress, nextCellProgress), nextCellProgress)
		info.sldValue = curPercentage
		info.progressAbletToBuy = checknumber(lastMaxProgress) - checknumber(info.progress)
		info.unlockIndex = isAllPass and curCellIdx + 2 or curCellIdx + 1
	end
end

function PassportModel:_getLastSwitchId()
	return self._lastTaskSwitchId
end

function PassportModel:_setLastSwitchId(switchId)
	self._lastTaskSwitchId = switchId
end

PassportModel.instance = PassportModel.New()

return PassportModel
