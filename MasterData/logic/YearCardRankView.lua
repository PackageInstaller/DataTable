-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardRankView.lua

module("logic.extensions.yearcard.view.2022.YearCardRankView", package.seeall)

local YearCardRankView = class("YearCardRankView", ViewComponent)

function YearCardRankView:buildUI()
	YearCardRankView.super.buildUI(self)

	self._txtFamily = self:getTxt("right/subTitle/txtFamily")
	self._txtZdl = self:getTxt("right/subTitle/txtZdl")
	self._txtTime = self:getTxt("right/subTitle/txtTime")
	self._goCell = self:getGo("right/cell")
	self._goTable = self:getGo("right/rankScrollRect")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._goEmpty = self:getGo("right/goEmpty")
	self._tip = self:getTxt("right/myRank/tip/txtTip")
	self._btnCheck = self:getBtn("right/myRank/tip/btnCheck")
	self._showTip = {
		lang("仅展示前100名，按全服解神意志精灵战斗力进行排名，需在荣耀战力检测过的精灵才可上榜"),
		lang("仅展示前100名，按本服解神意志精灵战斗力进行排名，需在荣耀战力检测过的精灵才可上榜"),
		lang("仅展示前100名，根据全服激活年费时间先后顺序进行排名"),
		(lang("仅展示前100名，根据本服激活年费时间先后顺序进行排名"))
	}
end

function YearCardRankView:bindEvents()
	YearCardRankView.super.bindEvents(self)
	self._btnCheck:AddClickListener(self._onClickCheck, self)
end

function YearCardRankView:unbindEvents()
	YearCardRankView.super.unbindEvents(self)
	self._btnCheck:RemoveClickListener()
end

function YearCardRankView:onEnter()
	YearCardRankView.super.onEnter(self)

	self._curActId = YearCardModel.instance:getCurAnnuityId()

	self._tableView:reloadData({})

	local params = self:getOpenParam() or {}
	local raceId = checkint(params[2])
	local type = checkint(params[1])

	self._isPowerType = raceId > 0

	if type == 1 or type == 2 then
		self._txtZdl.text = lang("最高战斗力")
		self._txtTime.text = lang("上榜时间")

		goutil.setActive(self._btnCheck.gameObject, true)

		self._isPowerType = true
		self._txtFamily.text = type == 2 and lang("channel_league_shortcut") or lang("aceteamrankview__3")

		goutil.setActive(self._btnCheck.gameObject, true)

		if raceId > 0 then
			PetRankModel.instance:queryRank(type, raceId, 100, false)

			self._isNilPet = false
		else
			self._isNilPet = true

			self:_refreshView()
		end
	else
		self._isPowerType = false
		self._txtFamily.text = lang("channel_league_shortcut")
		self._txtZdl.text = lang("aceteamrankview__3")
		self._txtTime.text = lang("激活年费时间")

		goutil.setActive(self._btnCheck.gameObject, false)

		if type == 3 then
			YearCardController.instance:sendRankReq(self._curActId, true)
		else
			YearCardController.instance:sendRankReq(self._curActId, false)
		end
	end

	self._tip.text = self._showTip[type]

	GlobalDispatcher:addListener(GlobalNotify.HandBookPowerCheckRank, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
end

function YearCardRankView:onExit()
	YearCardRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookPowerCheckRank, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
end

function YearCardRankView:_updateCell(view, goCell, data)
	local go = goCell.gameObject
	local imgRank = goutil.findChildComponent(go, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtFamily = goutil.findChildTextComponent(go, "txtFamily")
	local txtDesc = goutil.findChildTextComponent(go, "txtTime")
	local txtZdl = goutil.findChildTextComponent(go, "txtZdl")
	local btnHead = goutil.findChild(go, "btnHead")

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtRank.text = data.rank

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	if data.headInfo.userId then
		GameUtil.addClickHandler(btnHead, GameUtil.handler(self.onHeadClick, self, data.headInfo.userId, btnHead))
	end

	if self._isPowerType then
		txtFamily.text = not string.nilorempty(data.param) and data.param or lang("text_nofamily")
		txtZdl.text = data.zdl

		local time = GameUtil.time2date(checknumber(data.time) / 1000)

		txtDesc.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)
	else
		txtFamily.text = not string.nilorempty(data.familyName) and data.familyName or lang("text_nofamily")
		txtZdl.text = data.areaName

		local time = GameUtil.time2date(checknumber(data.activeTime) / 1000)

		txtDesc.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)
	end
end

function YearCardRankView:_clearCell(goCell)
	return
end

function YearCardRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function YearCardRankView:_refreshView()
	local actInfo = YearCardModel.instance:getAnnuityRankInfo(self._curActId)
	local myRank = 0

	if self._isPowerType then
		if not self._isNilPet then
			self._curDataList = PowerCheckModel.instance.rankList or {}
			myRank = checknumber(PowerCheckModel.instance.myRank)
		else
			self._curDataList = {}
			myRank = -1
		end
	else
		self._curDataList = actInfo.rankList or {}
		myRank = checknumber(actInfo.myRank)
	end

	self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")

	self._tableView:reloadData(self._curDataList)
	self._goEmpty:SetActive(#self._curDataList == 0)
end

function YearCardRankView:_onClickCheck()
	local params = self:getOpenParam() or {}
	local raceId = checkint(params[2])
	local type = checkint(params[1])

	UIStateManager.instance:push(ViewName.PetRankView, type, raceId)
end

return YearCardRankView
