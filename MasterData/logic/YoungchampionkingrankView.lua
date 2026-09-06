-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungchampionkingrankView.lua

module("logic.extensions.youngchampionking.view.YoungchampionkingrankView", package.seeall)

local YoungchampionkingrankView = class("YoungchampionkingrankView", ViewComponent)

YoungchampionkingrankView.TabType = {
	PetWin = 3,
	Person = 1,
	PetUp = 2,
	None = 0
}
YoungchampionkingrankView.TabConfig = {
	{
		leafId = 0,
		name = "战区预选赛",
		rootId = 1,
		tabId = YoungchampionkingrankView.TabType.None
	},
	{
		leafId = 1,
		name = "个人实力榜",
		rootId = 1,
		tabId = YoungchampionkingrankView.TabType.Person
	},
	{
		leafId = 2,
		name = "精灵上阵榜",
		rootId = 1,
		tabId = YoungchampionkingrankView.TabType.PetUp
	},
	{
		leafId = 3,
		name = "精灵胜率榜",
		rootId = 1,
		tabId = YoungchampionkingrankView.TabType.PetWin
	},
	{
		leafId = 0,
		name = "战区积分赛",
		rootId = 2,
		tabId = YoungchampionkingrankView.TabType.None
	},
	{
		leafId = 1,
		name = "个人实力榜",
		rootId = 2,
		tabId = YoungchampionkingrankView.TabType.Person
	},
	{
		leafId = 2,
		name = "精灵上阵榜",
		rootId = 2,
		tabId = YoungchampionkingrankView.TabType.PetUp
	},
	{
		leafId = 3,
		name = "精灵胜率榜",
		rootId = 2,
		tabId = YoungchampionkingrankView.TabType.PetWin
	}
}

function YoungchampionkingrankView:ctor()
	YoungchampionkingrankView.super.ctor(self)
end

function YoungchampionkingrankView:bindEvents()
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function YoungchampionkingrankView:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function YoungchampionkingrankView:buildUI()
	YoungchampionkingrankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtMyTip = self:getTxt("right/myRank/txtTip")
	self._goEmpty = self:getGo("right/goEmpty")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._rankListViewGo = self:getGo("right/rankListView")
	self._rankCellGo = self:getGo("right/rankCell")
	self._tabScrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._rankScrollerList = ScrollerList.create(self._rankListViewGo, self._rankCellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myRankGo = self:getGo("right/myRank")
	self._txtName = self:getTxt("right/description/txtName")
	self._txtArea = self:getTxt("right/description/txtArea")
	self._txtScore = self:getTxt("right/description/txtScore")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
end

function YoungchampionkingrankView:onExit()
	self._tabScrollerList:dispose()
	self._rankScrollerList:dispose()
end

function YoungchampionkingrankView:onEnter()
	YoungchampionkingrankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_YCKQualifierRankRes, self._onPM_YCKQualifierRankRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._enterStepId = checknumber(params[2])
	self._curRootId = nil
	self._curLeafId = nil
	self._unFold = true

	self:_updateUI()
end

function YoungchampionkingrankView:_onClickbtnClose()
	self:close()
end

function YoungchampionkingrankView:_updateUI()
	self:_updateTab()
end

function YoungchampionkingrankView:_updateTab()
	if self._enterStepId == YoungChampionKingEnum.Qualify_Step_Id then
		self:_onClickTabCell(1, 1)
	elseif self._enterStepId == YoungChampionKingEnum.Score_Match_Step_Id then
		self:_onClickTabCell(2, 1)
	else
		self:_onClickTabCell(1, 1)
	end
end

function YoungchampionkingrankView:_updateTabCell(view, cell, data, tag)
	local root = goutil.findChild(cell, "root")
	local txtRoot = goutil.findChildTextComponent(root, "txt")
	local changeRoot = root:GetComponent(ComponentType.UIChangeGroup)
	local leaf = goutil.findChild(cell, "leaf")
	local txtLeaf = goutil.findChildTextComponent(leaf, "txt")
	local changeLeaf = leaf:GetComponent(ComponentType.UIChangeGroup)

	txtRoot.text = data.name
	txtLeaf.text = data.name

	if data.leafId == 0 then
		changeRoot:SetState(data.rootId == self._curRootId and 0 or 1)
		goutil.setActive(root, true)
		goutil.setActive(leaf, false)
	else
		changeLeaf:SetState(data.leafId == self._curLeafId and 0 or 1)
		goutil.setActive(root, false)
		goutil.setActive(leaf, true)
	end

	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:AddClickListener(function()
		self:_onClickTabCell(data.rootId, data.leafId)
	end)
end

function YoungchampionkingrankView:_clearTabCell(cell)
	return
end

function YoungchampionkingrankView:_updateRankCell(view, cell, data, tag)
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

	if self._curLeafId == YoungchampionkingrankView.TabType.Person then
		namtStr = data.headInfo.userName
		scoreStr = data.value
		passTimeStr = data.headInfo.areaName

		HeadItemController.instance:setHeadCellByInfo(goHeadIcon, data.headInfo, true)
	else
		namtStr = PetSkinConfig.instance:getPetSkinName(data.raceId)

		if self._curLeafId == YoungchampionkingrankView.TabType.PetUp then
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

function YoungchampionkingrankView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")

	MaterialMgr.resetAll(goHeadIcon)
	HeadItemController.instance:resetHeadCell(goHeadIcon)
end

function YoungchampionkingrankView:_onClickTabCell(rootId, leafId)
	if rootId == self._curRootId then
		if leafId == 0 then
			self._unFold = not self._unFold
		elseif leafId == self._curLeafId then
			return
		else
			self._curLeafId = leafId
		end
	else
		self._curRootId = rootId
		self._curLeafId = YoungchampionkingrankView.TabType.Person
		self._unFold = true
	end

	self:_updateTabList()

	local enterStepId = self._curRootId

	if self._curLeafId == YoungchampionkingrankView.TabType.Person then
		local zoneId = YoungChampionKingController.instance:getCurZoneId()

		YoungChampionKingController.instance:sendPM_YCKQualifierRankInfoReq(self._activityId, zoneId, enterStepId)

		self._txtName.text = lang("奥奇名称")
		self._txtArea.text = lang("区服")
		self._txtScore.text = lang("积分")
	elseif self._curLeafId == YoungchampionkingrankView.TabType.PetUp then
		YoungChampionKingController.instance:sendPM_YCKQualifierPetRaceRankReq(self._activityId, enterStepId, false)

		self._txtName.text = lang("精灵名称")
		self._txtArea.text = ""
		self._txtScore.text = lang("上场次数")
	elseif self._curLeafId == YoungchampionkingrankView.TabType.PetWin then
		YoungChampionKingController.instance:sendPM_YCKQualifierPetRaceRankReq(self._activityId, enterStepId, true)

		self._txtName.text = lang("精灵名称")
		self._txtArea.text = lang("胜率")
		self._txtScore.text = lang("上场次数")
	end

	local startTime, endTime

	if self._curRootId == 1 then
		startTime, endTime = YoungChampionKingController.instance:getStartTimeAndEndTimeByStepId(YoungChampionKingEnum.Qualify_Step_Id)
		self._txtTip.text = "1.比赛时间剩余10分钟时锁定排行榜，不能进行挑战。\n2.战区预选赛前320名进入积分赛。\n3.排行榜每15分钟更新1次数据。"
	else
		startTime, endTime = YoungChampionKingController.instance:getStartTimeAndEndTimeByStepId(YoungChampionKingEnum.Score_Match_Step_Id)
		self._txtTip.text = "1、比赛时间剩余10分钟时锁定排行榜，不能进行挑战。\n2.战区积分赛前16名进入全服小组赛。\n3.排行榜每15分钟更新1次数据。"
	end

	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtOpenTime.text = string.format("比赛时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function YoungchampionkingrankView:_updateTabList()
	local tabList = {}

	for i, tabData in ipairs(YoungchampionkingrankView.TabConfig) do
		if tabData.leafId == 0 then
			table.insert(tabList, tabData)
		elseif self._unFold and self._curRootId == tabData.rootId then
			table.insert(tabList, tabData)
		end
	end

	self._tabScrollerList:reloadData(tabList)
end

function YoungchampionkingrankView:_onPM_YCKQualifierRankRes()
	self:_updateRankView()
end

function YoungchampionkingrankView:_updateRankView()
	local info
	local enterStepId = self._curRootId

	if self._curLeafId == YoungchampionkingrankView.TabType.Person then
		local zoneId = YoungChampionKingController.instance:getCurZoneId()

		info = YoungChampionKingModel.instance:getQualifierRankInfo(self._activityId, enterStepId, zoneId)

		local myRank = info.myRank

		self._txtMyRank.text = myRank <= 0 and "未上榜" or string.format("第%s名", myRank)
	elseif self._curLeafId == YoungchampionkingrankView.TabType.PetUp then
		info = YoungChampionKingModel.instance:getQualifierPetRankInfo(self._activityId, enterStepId, false)
	elseif self._curLeafId == YoungchampionkingrankView.TabType.PetWin then
		info = YoungChampionKingModel.instance:getQualifierPetRankInfo(self._activityId, enterStepId, true)
	end

	if info then
		if not info.rankList then
			local rankList = {}

			self._rankScrollerList:reloadData(rankList)
			goutil.setActive(self._myRankGo, self._curLeafId == YoungchampionkingrankView.TabType.Person)
			goutil.setActive(self._goEmpty, #rankList <= 0)
		end
	end
end

return YoungchampionkingrankView
