-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/model/ControlActionModel.lua

module("logic.extensions.controlaction.model.ControlActionModel", package.seeall)

local M = class("ControlActionModel", BaseModel)
local ControlAction_Login_LocalKey = "controlaction_login"

function M:ctor()
	M.super.ctor(self)

	self._monitorMoList = false
	self._themePostMoList = false
	self._replyPostMoList = false
	self._battleInfo = false
	self._passTimes = 0
end

function M:onInit()
	return
end

function M:onReset()
	M.super.ctor(self)

	self._monitorMoList = false
	self._themePostMoList = false
	self._replyPostMoList = false
	self._battleInfo = false
	self._passTimes = 0
end

function M:updateMonitor(data)
	self._monitorMoList = {}

	for _, dataNO in ipairs(data) do
		local monitorMo = MonitorMo.New()

		monitorMo:init(dataNO)
		table.insert(self._monitorMoList, monitorMo)
	end
end

function M:getMonitorMoList()
	return self._monitorMoList
end

function M:updateWeekTimes(passTimes)
	self._passTimes = passTimes
end

function M:getWeekPassTimes()
	return self._passTimes
end

function M:getWeekLeftTimes()
	return ControlActionConfig.instance:getConstValue(ControlActionEnum.WeekLimitTime) - self._passTimes
end

function M:updateLeftTimesWhenWin(dungeonId)
	if not ControlActionConfig.instance:isTeachDungeonById(dungeonId) then
		self:updateWeekTimes(self._passTimes - 1)
	end
end

function M:updateWhenDungeonWin(dungeonId)
	self:updateLeftTimesWhenWin(dungeonId)
end

function M:updateThemePost(data)
	self._themePostMoList = {}

	for _, dataNO in ipairs(data) do
		local postMo = ThemePostMo.New()

		postMo:init(dataNO)
		table.insert(self._themePostMoList, postMo)
	end
end

function M:getThemePostMoList()
	return self._themePostMoList
end

function M:getThemePostIsTop(id)
	for i = 1, #self._themePostMoList do
		if id == self._themePostMoList[i]:getId() then
			return self._themePostMoList[i]:isTop()
		end
	end

	return false
end

function M:updateReplyPost(id, data)
	self._replyPostMoList = {}

	for _, dataNO in ipairs(data) do
		local postMo = ReplyPostMo.New()

		postMo:init(dataNO, id)
		table.insert(self._replyPostMoList, postMo)
	end
end

function M:getReplyPostMoList()
	return self._replyPostMoList
end

function M:updatePostLike(isLike, id, floor)
	for _, dataMo in ipairs(self._replyPostMoList) do
		if dataMo:getId() == id and dataMo:getFloor() == floor then
			dataMo:updateLike(isLike)
		end
	end
end

function M:setClickShutDown()
	local keyStr = self:getDailyLoginKey()

	Astral.LocalStorage.Instance:DeleteKey(keyStr)
end

function M:isShowLoginView()
	local keyStr = self:getDailyLoginKey()
	local hasLoginToday = Astral.LocalStorage.Instance:HasKey(keyStr)
	local isShow = self._clickShutDown or not hasLoginToday

	return isShow
end

function M:setDailyLogin()
	local keyStr = self:getDailyLoginKey()

	Astral.LocalStorage.Instance:SetInt(keyStr, 1)
end

function M:getDailyLoginKey()
	local date = ServerTime.nowDateServerLook()

	return ControlAction_Login_LocalKey .. date.day
end

function M:getReward(code)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(code)
	local rewardList = {}

	if not rewardCO then
		return rewardList
	end

	for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
		if not v.pool then
			table.insert(rewardList, v)
		end
	end

	for i, v in ipairs(rewardCO.randomReward1 and rewardCO.randomReward1 or {}) do
		table.insert(rewardList, v)
	end

	for i, v in ipairs(rewardCO.randomReward2 and rewardCO.randomReward2 or {}) do
		table.insert(rewardList, v)
	end

	for i, v in ipairs(rewardCO.randomReward3 and rewardCO.randomReward3 or {}) do
		table.insert(rewardList, v)
	end

	return {}
end

function M:getRewardList(code)
	local rewardItemDataList = {}
	local rewardList = self:getReward(code)

	for i, v in ipairs(rewardList or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP and v.code then
			local itemData = ItemUtil.createItemData({
				itemId = v.code
			})

			itemData:setCount(v.num)

			itemData.count = v.num

			table.insert(rewardItemDataList, itemData)
		end
	end

	return rewardItemDataList
end

function M:getRewardLstNormal(code)
	local rewardItemDataList = {}
	local rewardCodeList = {
		code
	}
	local rewardList = {}

	if rewardCodeList then
		for i, rewardCode in ipairs(rewardCodeList) do
			local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

			if rewardCO and rewardCO.rewardShow then
				for i, v in ipairs(rewardCO.rewardShow[1]) do
					local isFixDrop = self:isFixDrop(v, rewardCO.reward)

					table.insert(rewardList, {
						code = v,
						fixDrop = isFixDrop
					})
				end
			end
		end
	end

	rewardList = DungeonModel.instance:mergeAndSortRewardList(rewardList)

	for _, v in ipairs(rewardList or {}) do
		local itemData = ItemUtil.createItemData({
			itemId = v.code
		})

		if v.fixDrop then
			itemData.itemSign = CommEnum.BackPackItemSignTyp.FixDrop
		else
			itemData.itemSign = CommEnum.BackPackItemSignTyp.SmallProbabilityDrop
		end

		table.insert(rewardItemDataList, itemData)
	end

	return rewardItemDataList
end

function M:getRewardLstRandom(code)
	local rewardItemDataList = {}
	local rewardCodeList = {
		code
	}
	local rewardList = {}

	if rewardCodeList then
		for i, rewardCode in ipairs(rewardCodeList) do
			local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

			if rewardCO and rewardCO.rewardShow then
				for i, v in ipairs(rewardCO.rewardShow[2]) do
					table.insert(rewardList, {
						code = v
					})
				end
			end
		end
	end

	rewardList = DungeonModel.instance:mergeAndSortRewardList(rewardList)

	for _, v in ipairs(rewardList or {}) do
		local itemData = ItemUtil.createItemData({
			itemId = v.code
		})

		table.insert(rewardItemDataList, itemData)
	end

	return rewardItemDataList
end

function M:isFixDrop(itemCode, rewardList)
	if not rewardList then
		return false
	end

	for i, v in ipairs(rewardList) do
		if itemCode == v.code then
			return true
		end
	end

	return false
end

function M:updateManual(data)
	self._unlockProtomerMoList = {}

	for i, v in ipairs(data) do
		local protomerMo = ManualMo.New()

		protomerMo:init(v)
		table.insert(self._unlockProtomerMoList, protomerMo)
	end
end

function M:_getDataFS(id)
	for i, v in ipairs(self._unlockProtomerMoList or {}) do
		if v:getId() == id then
			return v
		end
	end

	return false
end

function M:getProtomerMoList()
	if not self._moList then
		self._moList = {}

		local coList = ControlActionConfig.instance:getManualCfgList()

		for i, v in ipairs(coList) do
			local mo = {}

			mo.co = v
			mo.data = self:_getDataFS(v.code)

			table.insert(self._moList, mo)
		end
	else
		for i, v in ipairs(self._moList) do
			v.data = self:_getDataFS(v.co.code)
		end
	end

	return self._moList
end

function M:updateManualDataState(id)
	for i, v in ipairs(self._moList or {}) do
		if v.data and v.data:getId() == id then
			v.data:setIsHold(true)
		end
	end
end

function M:updateManualDataTaskState(taskId)
	for i, v in ipairs(self._moList or {}) do
		if v.data then
			local taskMoList = v.data:getTasMokList()

			for ii, vv in ipairs(taskMoList) do
				if vv:getTaskId() == taskId then
					vv:updateData(vv:getCurCount(), true)
				end
			end
		end
	end
end

function M:showManualRedPoint(id)
	local isShow = false

	for i, v in ipairs(self._moList or {}) do
		if v.data and v.data:getId() == id then
			local taskMoList = v.data:getTasMokList()

			for ii, vv in ipairs(taskMoList) do
				if vv:canGetReward() and not vv:getIsFinish() then
					isShow = true
				end
			end
		end
	end

	return isShow
end

function M:enterBattle()
	ViewMgr.instance:close(ViewName.ControlActionMonitor, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
end

function M:exitBattle()
	return
end

function M:setBattleInfo(viewId, difficultIndex, dungeonGroupCode)
	if not self._battleInfo then
		self._battleInfo = {}
	end

	self._battleInfo.viewId = viewId
	self._battleInfo.difficultIndex = difficultIndex
	self._battleInfo.dungeonGroupCode = dungeonGroupCode

	if ControlActionUtil.isInGuideSecond() then
		ControlActionUtil.setGuideBattle()
	end
end

function M:getBattleInfo()
	return self._battleInfo
end

function M:resetBattleInfo()
	self._battleInfo = false

	ControlActionUtil.clearGuideBattle()
end

function M:getGuideThemePostList()
	local dataCoList = ControlActionConfig.instance:getGuideThemePostCfgList()
	local DataNoList = {}

	for i, v in ipairs(dataCoList) do
		local DataNo = {}
		local playerCodeList = ControlActionConfig.instance:getPlayerGroupCfg(v.owner)

		if playerCodeList[i] then
			DataNo.author = playerCodeList[i].playerCode
		else
			DataNo.author = 20020001
		end

		DataNo.id = i
		DataNo.contentCode = v.code
		DataNo.time = 0
		DataNo.likesCount = 0
		DataNo.isTop = i == 1 and true or false

		table.insert(DataNoList, DataNo)
	end

	self:updateThemePost(DataNoList)

	return self:getThemePostMoList()
end

function M:getGuideReplyPostList(themePostMo)
	local themePostCode = themePostMo:getCode()
	local dataCoList = ControlActionConfig.instance:getGuideReplayPostCfgList(themePostCode)
	local DataNoList = {}

	for i, v in ipairs(dataCoList) do
		local DataNo = {}
		local playerCodeList = ControlActionConfig.instance:getPlayerGroupCfg(v.owner)

		if playerCodeList[i] then
			DataNo.author = playerCodeList[i].playerCode
		else
			DataNo.author = 20020001
		end

		DataNo.floor = i
		DataNo.contentCode = i == 1 and themePostCode or v.code
		DataNo.time = 0
		DataNo.likesCount = 0
		DataNo.like = false

		table.insert(DataNoList, DataNo)
	end

	self:updateReplyPost(themePostMo:getId(), DataNoList)

	return self:getReplyPostMoList()
end

function M:getGuideMonitorMoList()
	local dataCoList = ControlActionConfig.instance:getGuideThemePostCfgList()
	local area1 = {
		area = -1,
		level = -1,
		postCode = dataCoList[1].code
	}
	local data = {
		area1
	}

	self:updateMonitor(data)

	return self._monitorMoList
end

function M:getMonitorMO(dungeonCode)
	for _, monitorMO in ipairs(self._monitorMoList or {}) do
		local dungeonCodes = monitorMO:getDungeonGroupCo().dungeonCodes

		if TableUtil.contains(dungeonCodes, dungeonCode) then
			return monitorMO
		end
	end

	return nil
end

M.instance = M.New()

return M
