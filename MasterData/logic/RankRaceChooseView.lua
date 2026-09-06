-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceChooseView.lua

module("logic.extensions.rankrace.view.RankRaceChooseView", package.seeall)

local RankRaceChooseView = class("RankRaceChooseView", ViewComponent)
local Word = {
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"日"
}
local RaceType_Classics = 1
local RaceType_Extreme = 2
local RaceTypeEnum = {
	RaceType_Classics,
	RaceType_Extreme
}

function RankRaceChooseView:ctor()
	RankRaceChooseView.super.ctor(self)
end

function RankRaceChooseView:buildUI()
	RankRaceChooseView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getGo("txtTitle"):GetComponent("Text")
	self._txtTime_1 = self:getGo("txtTime_1"):GetComponent("Text")
	self._txtTime_2 = self:getGo("txtTime_2"):GetComponent("Text")
	self._txtTipsTimeArray = {}
	self._txtTipsTimeArray[RaceType_Classics] = self:getTxt("btnClassics/txtTipsTime")
	self._txtTipsTimeArray[RaceType_Extreme] = self:getTxt("btnLimit/txtTipsTime")
	self._txtLeftTimeArray = {}
	self._txtLeftTimeArray[RaceType_Classics] = self:getTxt("btnClassics/txtLeftTime")
	self._txtLeftTimeArray[RaceType_Extreme] = self:getTxt("btnLimit/txtLeftTime")
	self._openTagArray = {}
	self._openTagArray[RaceType_Classics] = self:getGo("btnClassics/openTag")
	self._openTagArray[RaceType_Extreme] = self:getGo("btnLimit/openTag")
	self._btnClassics = self:getBtn("btnClassics")
	self._btnLimit = self:getBtn("btnLimit")
	self._btnTip = self:getBtn("btnTip")
end

function RankRaceChooseView:bindEvents()
	RankRaceChooseView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnClassics:AddClickListener(self._onClickBtnClassics, self)
	self._btnLimit:AddClickListener(self._onClickBtnLimit, self)
	self._btnTip:AddClickListener(self._onClickBtnTip, self)
end

function RankRaceChooseView:unbindEvents()
	RankRaceChooseView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnClassics:RemoveClickListener()
	self._btnLimit:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function RankRaceChooseView:destroyUI()
	RankRaceChooseView.super.destroyUI(self)
end

function RankRaceChooseView:onEnter()
	RankRaceChooseView.super.onEnter(self)

	self._weekDays = {}

	for raceType, key in ipairs({
		"CLASSIC_OPEN_TIME",
		"EXTREME_OPEN_TIME"
	}) do
		local weekDays = RankRaceConfig.instance:getRankCommonValue(key)

		if not string.nilorempty(weekDays) then
			local arr = string.split(weekDays, ":")

			for k, v in pairs(arr) do
				arr[k] = checknumber(v)
			end

			self._weekDays[raceType] = arr
		else
			self._weekDays[raceType] = {}
		end
	end

	for _, raceType in ipairs(RaceTypeEnum) do
		local str = ""

		for i, v in ipairs(self._weekDays[raceType]) do
			str = str .. Word[v]
		end

		self._txtTipsTimeArray[raceType].text = string.format(RankRaceConfig.instance:getWord(4), str)
	end

	self._openTimeArray = {}

	local nowTimeStamp = ServerTime.now()
	local nowDate = GameUtil.time2date(nowTimeStamp)
	local openTimeStr = RankRaceConfig.instance:getCommonOpenTime()
	local openTimeStrArray = string.split(openTimeStr, "#")

	for i, v in ipairs(openTimeStrArray) do
		self._openTimeArray[i] = {}

		local array = string.split(v, ":")

		for ii, vv in ipairs(array) do
			local hour = checknumber(vv)

			self._openTimeArray[i][ii] = GameUtil.date2time(nowDate.year, nowDate.month, nowDate.day, hour, 0, 0)
		end
	end

	self:_updateBaseInfo()

	self._curOpenTimeIdx = self:_getOpenTimeIdx(nowTimeStamp)

	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function RankRaceChooseView:onEnterFinished()
	RankRaceChooseView.super.onEnterFinished(self)
end

function RankRaceChooseView:onExit()
	RankRaceChooseView.super.onExit(self)
	removetimer(self._onTicking, self)
end

function RankRaceChooseView:onExitFinished()
	RankRaceChooseView.super.onExitFinished(self)
end

function RankRaceChooseView:_onTicking()
	local newOpenTimeIdx = self:_getOpenTimeIdx(ServerTime.now())

	if self._curOpenTimeIdx ~= newOpenTimeIdx then
		self._curOpenTimeIdx = newOpenTimeIdx

		self:_updateBaseInfo()
	end
end

function RankRaceChooseView:_getOpenTimeIdx(nowTimeStamp)
	local result = 0

	for idx, v in ipairs(self._openTimeArray) do
		if nowTimeStamp < v[1] then
			result = idx - 0.5

			break
		elseif nowTimeStamp < v[2] then
			result = idx

			break
		else
			result = idx + 0.5
		end
	end

	return result
end

function RankRaceChooseView:_onClickBtnClose()
	self:close()
end

function RankRaceChooseView:_onClickBtnClassics()
	if not RankRaceController.instance:isSeasonLock() and RankRaceController.instance:IsRankRaceOpenTime("CLASSIC_OPEN_TIME") then
		RankRaceController.instance:setCurViewType(RankRaceController.MatchTypeClassics)
		UIStateManager.instance:push(ViewName.RankRaceClassicsView, RankRaceController.MatchTypeClassics)
	else
		FloatWordMgr.instance:show("未到开放时间")
	end
end

function RankRaceChooseView:_onClickBtnLimit()
	if not RankRaceController.instance:isSeasonLock() and RankRaceController.instance:IsRankRaceOpenTime("EXTREME_OPEN_TIME") then
		RankRaceController.instance:setCurViewType(RankRaceController.MatchTypeLimit)
		UIStateManager.instance:push(ViewName.RankRaceClassicsView, RankRaceController.MatchTypeLimit)
	else
		FloatWordMgr.instance:show("未到开放时间")
	end
end

function RankRaceChooseView:_onClickBtnTip()
	ViewMgr.instance:open(ViewName.RulesView, "rankmatchchoose")
end

function RankRaceChooseView:_updateBaseInfo()
	self:_setSeasonText()

	local _openTime = RankRaceConfig.instance:getCommonOpenTime()
	local _openTimeArea = string.split(_openTime, "#")

	if #_openTimeArea > 1 then
		local targetStringList = {}

		for i, v in ipairs(_openTimeArea) do
			local _openTimeArray = string.split(v, ":")

			table.insert(targetStringList, langPara("%s点到%s点", _openTimeArray[1], _openTimeArray[2]))
		end

		self._txtTime_2.text = langPara("每日%s开放", table.concat(targetStringList, "、"))
	else
		local _openTimeArray = string.split(_openTime, ":")

		self._txtTime_2.text = string.format(RankRaceConfig.instance:getWord(3), _openTimeArray[1], _openTimeArray[2])
	end

	local nowTimeStamp = ServerTime.now()

	for _, raceType in ipairs(RaceTypeEnum) do
		local isOpenToday = self:_isTodayOpen(raceType)

		GameUtil.SetActive(self._txtTipsTimeArray[raceType].gameObject, not isOpenToday)
		GameUtil.SetActive(self._openTagArray[raceType].gameObject, isOpenToday)
		GameUtil.SetActive(self._txtLeftTimeArray[raceType].gameObject, false)

		if isOpenToday then
			local str

			for i, v in ipairs(self._openTimeArray) do
				local openTimeStamp = v[1]

				if openTimeStamp <= nowTimeStamp and nowTimeStamp <= v[2] then
					break
				elseif nowTimeStamp < openTimeStamp then
					str = string.format("%s 后开启", GameUtil.getFormatTimeByStamp(openTimeStamp, nil))

					break
				end
			end

			local txt = self._txtLeftTimeArray[raceType]

			txt.text = str

			GameUtil.SetActive(self._txtLeftTimeArray[raceType].gameObject, not string.nilorempty(str))
		end
	end

	if not RankRaceController.instance:IsRankRaceOpenTime("CLASSIC_OPEN_TIME") then
		uGuiUtil.setImageGrayStateRecursive(self._btnClassics, true)
	end

	if not RankRaceController.instance:IsRankRaceOpenTime("EXTREME_OPEN_TIME") then
		uGuiUtil.setImageGrayStateRecursive(self._btnLimit, true)
	end
end

function RankRaceChooseView:_setSeasonText()
	if RankRaceController.instance:isSeasonLock() then
		local str, seasonNum = RankRaceController.instance:getNextSeasonTimeStr()

		self._txtTitle.text = "S" .. seasonNum .. RankRaceConfig.instance:getWord(16)
		self._txtTime_1.text = str
	else
		local str, seasonNum = RankRaceController.instance:getCurSeasonTimeStr()

		self._txtTitle.text = "S" .. seasonNum .. RankRaceConfig.instance:getWord(16)
		self._txtTime_1.text = str
	end
end

function RankRaceChooseView:_isTodayOpen(raceType)
	local weekDays = self._weekDays[raceType]

	for _, v in ipairs(weekDays) do
		if GameUtil.checkIsOnWeekDay(v) then
			local endTimeStamp = self._openTimeArray[#self._openTimeArray][2]
			local nowTimeStamp = ServerTime.now()

			return nowTimeStamp < endTimeStamp
		end
	end

	return false
end

return RankRaceChooseView
