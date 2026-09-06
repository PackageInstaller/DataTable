-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabTutorSystemView.lua

module("logic.extensions.famehall.view.tab.FameHallTabTutorSystemView", package.seeall)

local FameHallTabTutorSystemView = class("FameHallTabTutorSystemView", FameHallTabBaseView)

function FameHallTabTutorSystemView:buildUI()
	FameHallTabTutorSystemView.super.buildUI(self)

	self._txtTutorCount = self:getTxt("tutorCount/txt")
end

function FameHallTabTutorSystemView:_initData()
	local value = TutorSystemConfig.instance:getTsCommonValue("FAME_HALL_START_DAY")
	local array = string.split(value, "#")
	local startYear, startMoon = checknumber(array[1]), checknumber(array[2])
	local now = ServerTime.now() - GameUtil.SERVER_TICK_DAILYR_EFRESH * 3600
	local endDate = GameUtil.time2date(now)
	local endYear, endMonth = endDate.year, endDate.month - 1
	local index = 0

	self._seasonListData = {}

	for year = startYear, endYear do
		local sMoon, eMonth = 1, 12

		if year == startYear then
			sMoon = startMoon
		end

		for month = sMoon, (year == endYear or nil) and endMonth do
			index = index + 1

			local timeStamp = GameUtil.date2time(year, month, 1, GameUtil.SERVER_TICK_DAILYR_EFRESH, 0, 0)
			local date = GameUtil.time2date(timeStamp)
			local data = {}

			data.periodId = checknumber(string.format("%02d%02d%02d", date.year, date.month, date.day))
			data.date = date
			data.index = index

			table.insert(self._seasonListData, data)
		end
	end

	self._isInitData = false

	if #self._seasonListData <= 0 then
		local data = {}

		data.periodId = checknumber(string.format("%02d%02d%02d", endDate.year, endDate.month, 1))
		data.date = endDate
		data.index = 1

		table.insert(self._seasonListData, data)

		self._isInitData = true
	end

	self._curSelectSeason = #self._seasonListData

	self:_updateData()
end

function FameHallTabTutorSystemView:_updateData()
	local params = self:getFirstParam()
	local info = FameHallModel.instance:getInfo(params.typeId, self._seasonListData[self._curSelectSeason].periodId)

	self._titleName = self:getTitleName()
	self._gender = RoleModel.instance:getGender()
	self._clothes = RoleModel.instance:getClothes() or {}
	self._userId = 0
	self._extParam = 0

	if info and checknumber(info.headInfo.userId) > 0 then
		self._gender = info.gender
		self._clothes = info.clothes or {}
		self._name = info.headInfo.userName
		self._area = info.areaName
		self._family = info.familyName
		self._userId = info.headInfo.userId
		self._extParam = checknumber(info.extParam)
	elseif not self._isInitData then
		FameHallAgent.instance:sendPM_FameHallGetInfoReq(params.typeId, self._seasonListData[self._curSelectSeason].periodId)
	else
		self._name = lang("虚位以待")
		self._area = lang("无")
		self._family = lang("无")
	end

	self._isInitData = true
end

function FameHallTabTutorSystemView:getTitleName()
	local date = self._seasonListData[self._curSelectSeason].date

	return langPara("%02d年%02d月出师榜第一名", date.year, date.month)
end

function FameHallTabTutorSystemView:getCellDesc(index)
	local data = self._seasonListData[index]
	local date = data.date

	return langPara("%02d年%02d月", date.year, date.month)
end

function FameHallTabTutorSystemView:_refreshView()
	FameHallTabTutorSystemView.super._refreshView(self)

	self._txtTutorCount.text = self._extParam <= 0 and lang("无") or self._extParam
end

function FameHallTabTutorSystemView:_onClickInfo()
	local params = self:getFirstParam()
	local info = FameHallModel.instance:getInfo(params.tabId, self._seasonListData[self._curSelectSeason].periodId)

	if info and checknumber(info.headInfo.userId) > 0 then
		FriendController.instance:showInfoView(checknumber(info.headInfo.userId), self._btnInfo)
	end
end

return FameHallTabTutorSystemView
