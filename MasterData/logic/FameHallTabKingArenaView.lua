-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabKingArenaView.lua

module("logic.extensions.famehall.view.tab.FameHallTabKingArenaView", package.seeall)

local FameHallTabKingArenaView = class("FameHallTabKingArenaView", FameHallTabBaseView)

function FameHallTabKingArenaView:buildUI()
	FameHallTabKingArenaView.super.buildUI(self)

	self._txtGainTimes = self:getTxt("gainTimes/txtGainTimes")
end

function FameHallTabKingArenaView:_initData()
	local dataList = KingArenaConfig.instance:getSeasonDataList()

	self._seasonListData = {}

	local index = 1

	for i, v in ipairs(dataList) do
		local endTime = GameUtil.string2time(v.endTime)

		if endTime < ServerTime.now() then
			table.insert(self._seasonListData, {
				activityId = v.seasonId,
				index = index
			})

			index = index + 1
		end
	end

	self._isInitData = false

	if #self._seasonListData <= 0 then
		table.insert(self._seasonListData, {
			index = 1,
			activityId = dataList[1].seasonId
		})

		self._isInitData = true
	end

	self._curSelectSeason = #self._seasonListData

	self:_updateData()
end

function FameHallTabKingArenaView:_updateData()
	local params = self:getFirstParam()
	local info = FameHallModel.instance:getInfo(params.typeId, self._seasonListData[self._curSelectSeason].activityId)

	self._titleName = self:getTitleName()
	self._gender = RoleModel.instance:getGender()
	self._clothes = RoleModel.instance:getClothes() or {}
	self._userId = 0
	self._gainTimes = 0

	if info and checknumber(info.headInfo.userId) > 0 then
		self._gender = info.gender
		self._clothes = info.clothes or {}
		self._name = info.headInfo.userName
		self._area = info.areaName
		self._family = info.familyName
		self._userId = info.headInfo.userId
		self._gainTimes = checknumber(info.extParam)
	elseif not self._isInitData then
		FameHallAgent.instance:sendPM_FameHallGetInfoReq(params.typeId, self._seasonListData[self._curSelectSeason].activityId)
	else
		self._name = lang("虚位以待")
		self._area = lang("无")
		self._family = lang("无")
	end

	self._isInitData = true
end

function FameHallTabKingArenaView:getTitleName()
	return langPara("第%s届王者竞技场战皇次数榜第一名", GameUtil.getChineseNumber(self._curSelectSeason))
end

function FameHallTabKingArenaView:_refreshView()
	FameHallTabKingArenaView.super._refreshView(self)

	self._txtGainTimes.text = self._gainTimes == 0 and lang("无") or self._gainTimes
end

return FameHallTabKingArenaView
