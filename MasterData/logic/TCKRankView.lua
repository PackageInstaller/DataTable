-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKRankView.lua

module("logic.extensions.teenchampionking.view.TCKRankView", package.seeall)

local TCKRankView = class("TCKRankView", ViewComponent)

function TCKRankView:ctor()
	TCKRankView.super.ctor(self)
end

function TCKRankView:unbindEvents()
	TCKRankView.super.unbindEvents(self)
end

function TCKRankView:bindEvents()
	TCKRankView.super.bindEvents(self)
end

function TCKRankView:buildUI()
	TCKRankView.super.buildUI(self)

	self._myRankGo = self:getGo("right/myRank")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtName = self:getTxt("right/description/txtName")
	self._txtArea = self:getTxt("right/description/txtArea")
	self._txtScore = self:getTxt("right/description/txtScore")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtMyRankTitle = self:getTxt("right/myRank/txtMyRankTitle")
	self._txtMyTip = self:getTxt("right/myRank/txtTip")
	self._rankListViewGo = self:getGo("right/rankListView")
	self._rankCellGo = self:getGo("right/rankCell")
	self._rankScrollerList = ScrollerList.create(self._rankListViewGo, self._rankCellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function TCKRankView:onExit()
	TCKRankView.super.onExit(self)
	self._rankScrollerList:dispose()
end

function TCKRankView:onEnter()
	TCKRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TCKUpdateRank, self._handleUpdateRank, self)

	local params = self:getOpenParam()

	self._activityId = params and checknumber(params[1]) or 501001
	self._enterStepId = params and checknumber(params[2]) or 1
	self._subTypeId = params and checknumber(params[3]) or 0

	local curZoneCfg = TeenChampionKingController.instance:getZoneCfgByActId(self._activityId)

	if curZoneCfg then
		self._curZoneId = curZoneCfg.zoneId or 1
	end

	if self._subTypeId == 1 then
		TeenChampionKingController.instance:updateRankView(self._activityId, self._curZoneId, self._enterStepId)
	elseif self._subTypeId == 2 then
		TeenChampionKingController.instance:updatePetRankView(self._activityId, self._enterStepId, false)
	elseif self._subTypeId == 3 then
		TeenChampionKingController.instance:updatePetRankView(self._activityId, self._enterStepId, true)
	else
		printError("未定义处理方式：" .. self._subTypeId)

		return
	end

	if self._subTypeId == 1 then
		self._txtName.text = lang("奥奇名称")
		self._txtArea.text = lang("区服")
		self._txtScore.text = lang("积分")
	elseif self._subTypeId == 2 then
		self._txtName.text = lang("精灵名称")
		self._txtArea.text = ""
		self._txtScore.text = lang("上场次数")
	elseif self._subTypeId == 3 then
		self._txtName.text = lang("精灵名称")
		self._txtArea.text = lang("胜率")
		self._txtScore.text = lang("上场次数")
	end

	local startTime, endTime = 0, 0

	if self._enterStepId == 1 then
		startTime, endTime = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, self._enterStepId)
		self._txtTip.text = "1.比赛时间剩余10分钟时锁定排行榜，不能进行挑战。\n2.战区预选赛前320名进入积分赛。\n3.排行榜每15分钟更新1次数据。"
	else
		startTime, endTime = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, self._enterStepId)
		self._txtTip.text = "1、比赛时间剩余10分钟时锁定排行榜，不能进行挑战。\n2.战区积分赛前16名进入全服小组赛。\n3.排行榜每15分钟更新1次数据。"
	end

	if self._subTypeId ~= 1 then
		self._txtTip.text = "胜场数大于等于30的精灵才上榜"
	end

	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtOpenTime.text = string.format("比赛时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function TCKRankView:_handleUpdateRank()
	local info
	local rankList = {}

	if self._subTypeId == 1 then
		info = TeenChampionKingModel.instance:getRankInfo(self._activityId, self._enterStepId, self._curZoneId)

		local myRank = info.myRank

		self._txtMyRank.text = myRank <= 0 and "未上榜" or string.format("第%s名", myRank)
		rankList = info.rankList or {}
	elseif self._subTypeId == 2 then
		info = TeenChampionKingModel.instance:getPetRankInfo(self._activityId, self._enterStepId, false)
		rankList = info.infoList or {}
	elseif self._subTypeId == 3 then
		info = TeenChampionKingModel.instance:getPetRankInfo(self._activityId, self._enterStepId, true)
		rankList = info.infoList or {}
	end

	self._rankScrollerList:reloadData(rankList)
	goutil.setActive(self._txtMyRank.gameObject, self._subTypeId == 1)
	goutil.setActive(self._txtMyRankTitle.gameObject, self._subTypeId == 1)
	goutil.setActive(self._goEmpty, #rankList <= 0)
end

function TCKRankView:_updateRankCell(view, cell, data, tag)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtPassTime = goutil.findChildTextComponent(cell.gameObject, "txtPassTime")
	local txtRankGo = goutil.findChild(cell.gameObject, "txtRank")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local namtStr = ""
	local scoreStr = ""
	local passTimeStr = ""

	MaterialMgr.resetAll(goHeadIcon)
	HeadItemController.instance:resetHeadCell(goHeadIcon)

	if self._subTypeId == 1 then
		namtStr = data.headInfo.userName
		scoreStr = data.value
		passTimeStr = data.headInfo.areaName

		HeadItemController.instance:setHeadCellByInfo(goHeadIcon, data.headInfo, true)
	elseif self._subTypeId == 2 or self._subTypeId == 3 then
		namtStr = PetSkinConfig.instance:getPetSkinName(data.raceId)

		if self._subTypeId == 2 then
			scoreStr = data.fightTimes
			passTimeStr = ""
		else
			scoreStr = data.fightTimes
			passTimeStr = string.format("%s%%", data.winRate)
		end

		MaterialMgr.setCell(MatType.Pet, data.raceId, goHeadIcon)
	end

	local isTop3 = data.rank <= 3

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
		goutil.setActive(imgChangeImgRank.gameObject, true)
		goutil.setActive(txtRankGo, false)
	else
		goutil.setActive(txtRankGo, true)
		goutil.setActive(imgChangeImgRank.gameObject, false)

		txtRank.text = data.rank
	end

	txtName.text = namtStr
	txtScore.text = scoreStr
	txtPassTime.text = passTimeStr
end

function TCKRankView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")

	MaterialMgr.resetAll(goHeadIcon)
	HeadItemController.instance:resetHeadCell(goHeadIcon)
end

return TCKRankView
