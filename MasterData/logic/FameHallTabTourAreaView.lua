-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabTourAreaView.lua

module("logic.extensions.famehall.view.tab.FameHallTabTourAreaView", package.seeall)

local FameHallTabTourAreaView = class("FameHallTabTourAreaView", FameHallTabBaseView)
local PERIOD_TYPE_SHENG_RI_HUI = 1
local PERIOD_TYPE_YUAN_DAN = 2
local PERIOD_TYPE_CHUN_JIE = 3
local PERIOD_TYPE_ZHOU_NIAN_QING = 4
local PERIOD_TYPE_SHU_JIA = 5
local PERIOD_TYPE_GUO_QING = 6
local PERIOD_NAME = {
	[PERIOD_TYPE_SHENG_RI_HUI] = lang("生日会"),
	[PERIOD_TYPE_YUAN_DAN] = lang("元旦"),
	[PERIOD_TYPE_CHUN_JIE] = lang("春节"),
	[PERIOD_TYPE_ZHOU_NIAN_QING] = lang("周年庆"),
	[PERIOD_TYPE_SHU_JIA] = lang("暑假"),
	[PERIOD_TYPE_GUO_QING] = lang("国庆")
}

function FameHallTabTourAreaView:buildUI()
	FameHallTabTourAreaView.super.buildUI(self)

	self._txtTotalScore = self:getTxt("score/txtTotalScore")
end

function FameHallTabTourAreaView:_initData()
	self._seasonListData = {}

	local params = self:getFirstParam()

	self._periodType = checknumber(params.param)

	local dataList = TourArenaFightConfig.instance:getTafActDataList()
	local collectActivity = {}
	local normalActivity = {}

	for i, v in ipairs(dataList) do
		if checknumber(v.periodType) == self._periodType then
			if checknumber(v.periodId) ~= 0 then
				collectActivity[v.periodId] = v
			else
				table.insert(normalActivity, v)
			end
		end
	end

	for k, v in pairs(collectActivity) do
		table.insert(normalActivity, v)
	end

	table.sort(normalActivity, function(a, b)
		return a.activityId < b.activityId
	end)

	for i, v in ipairs(normalActivity) do
		local actCfg = ActivityDefineConfig.instance:getCfgByActivitYId(v.activityId)
		local time = GameUtil.string2time(actCfg.endTime)

		if time < ServerTime.now() then
			local date = GameUtil.string2date(actCfg.endTime)

			table.insert(self._seasonListData, {
				activityId = v.periodId,
				index = i,
				year = date.year
			})
		end
	end

	self._isInitData = false

	if #self._seasonListData <= 0 then
		local date = GameUtil.time2date(ServerTime.now())

		table.insert(self._seasonListData, {
			index = 1,
			activityId = dataList[1].periodId,
			year = date.year
		})

		self._isInitData = true
	end

	self._curSelectSeason = #self._seasonListData

	self:_updateData()
end

function FameHallTabTourAreaView:_updateData()
	local params = self:getFirstParam()
	local info = FameHallModel.instance:getInfo(params.typeId, self._seasonListData[self._curSelectSeason].activityId)

	self._titleName = self:getTitleName()
	self._gender = RoleModel.instance:getGender()
	self._clothes = RoleModel.instance:getClothes() or {}
	self._userId = 0
	self._totalScore = 0

	if info and checknumber(info.headInfo.userId) > 0 then
		self._gender = info.gender
		self._clothes = info.clothes or {}
		self._name = info.headInfo.userName
		self._area = info.areaName
		self._family = info.familyName
		self._userId = info.headInfo.userId
		self._totalScore = checknumber(info.extParam)
	elseif not self._isInitData then
		FameHallAgent.instance:sendPM_FameHallGetInfoReq(params.typeId, self._seasonListData[self._curSelectSeason].activityId)
	else
		self._name = lang("虚位以待")
		self._area = lang("无")
		self._family = lang("无")
	end

	self._isInitData = true
end

function FameHallTabTourAreaView:getTitleName()
	local date = self._seasonListData[self._curSelectSeason]

	return langPara("%d年%s竞技王总榜第一", date.year, PERIOD_NAME[self._periodType])
end

function FameHallTabTourAreaView:getCellDesc(index)
	local date = self._seasonListData[index]

	return langPara("%d年", date.year)
end

function FameHallTabTourAreaView:_refreshView()
	FameHallTabTourAreaView.super._refreshView(self)

	self._txtTotalScore.text = self._totalScore == 0 and lang("无数据") or self._totalScore
end

function FameHallTabTourAreaView:_onClickInfo()
	local params = self:getFirstParam()
	local info = FameHallModel.instance:getInfo(params.typeId, self._seasonListData[self._curSelectSeason].activityId)

	if info and checknumber(info.headInfo.userId) > 0 then
		FriendController.instance:showInfoView(checknumber(info.headInfo.userId), self._btnInfo)
	end
end

return FameHallTabTourAreaView
