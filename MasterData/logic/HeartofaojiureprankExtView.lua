-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiurep/view/HeartofaojiureprankExtView.lua

module("logic.extensions.heartofaojiurep.view.HeartofaojiureprankExtView", package.seeall)

local HeartofaojiureprankExtView = class("HeartofaojiureprankExtView", ViewComponent)

function HeartofaojiureprankExtView:ctor()
	HeartofaojiureprankExtView.super.ctor(self)
end

function HeartofaojiureprankExtView:unbindEvents()
	HeartofaojiureprankExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._HasGain)
	GameUtil.rmClickHandler(self._btnTip)
end

function HeartofaojiureprankExtView:bindEvents()
	HeartofaojiureprankExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._HasGain, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function HeartofaojiureprankExtView:buildUI()
	HeartofaojiureprankExtView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._empty = self:getGo("empty")
	self._myRank = self:getGo("myRank")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtTip = self:getTxt("myRank/txtTip")
	self._txtDamage = self:getTxt("title/txtDamage")
	self._HasGain = self:getGo("title/HasGain")
	self._checkbox = self:getGo("title/HasGain/checkbox")
	self._btnTip = self:getGo("btnTip")

	local tabcell = self:getGo("tabcell")
	local tabview = self:getGo("tabview")

	self._tabScrollList = ScrollerList.create(tabview, tabcell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self.clearTabCell, self))

	local cell = self:getGo("cell")
	local tableview = self:getGo("tableview")

	self._scrollList = ScrollerList.create(tableview, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._extendCell = self:getGo("extcell")

	GameUtil.SetActive(self._extendCell, true)

	self._Viewport = self:getGo("tableview/Viewport")
	self._scrollerHandlers = {}
	self._txtReward = self:getTxt("title/txtReward")
end

function HeartofaojiureprankExtView:onExit()
	HeartofaojiureprankExtView.super.onExit(self)
	self._scrollList:dispose()
	self._tabScrollList:dispose()
end

function HeartofaojiureprankExtView:onEnter()
	HeartofaojiureprankExtView.super.onEnter(self)

	local param = self:getOpenParam() or {}

	self._activityId1 = checknumber(param[1])
	self._activityId2 = checknumber(param[2])
	self._curIndex = checknumber(param[3])

	if self._curIndex == 0 then
		self._curIndex = 1
	end

	self._isSelect = true

	GameUtil.SetActive(self._checkbox, self._isSelect)

	local list = {}

	table.insert(list, lang("破阵敖九"))
	table.insert(list, lang("Boss敖九"))
	self._tabScrollList:reloadData(list)
	self.addGEvent(self, GlobalNotify.HeartOfAojiuRep0926Rank, self._refreshUI, self)
	self:_refreshUI()
	self:_sendMsg()
end

function HeartofaojiureprankExtView:_sendMsg()
	if self._curIndex == 1 then
		HeartOfAoJiuClgAgent.instance:sendPM_HeartOfAoJiuClgGetRankInfoV0926Req(self._activityId1)
	else
		HeartOfJieShenClgAgent.instance:sendPM_HeartOfJieShenClgGetRankInfoV0926Req(self._activityId2)
	end
end

function HeartofaojiureprankExtView:_onClickFilter()
	self._isSelect = not self._isSelect

	GameUtil.SetActive(self._checkbox, self._isSelect)
	self:_onShowList()
end

function HeartofaojiureprankExtView:_onClickTips()
	TipsFacade.instance:openRulesView("heartofaojiureprankextview_rule")
end

function HeartofaojiureprankExtView:_onShowList()
	if not self._info.rankInfos then
		local list = {}

		if self._isSelect then
			self._scrollList:reloadData(list)
			GameUtil.SetActive(self._empty, #list == 0)
		else
			local tem = {}

			for i, v in ipairs(list) do
				if not v.hasGainRace then
					table.insert(tem, v)
				end
			end

			self._scrollList:reloadData(tem)
			GameUtil.SetActive(self._empty, #tem == 0)
		end

		GameUtil.setHeight(self._Viewport, 470)
		GameUtil.SetActive(self._extendCell, false)

		if self._info.prizeEndUser then
			GameUtil.SetActive(self._extendCell, true)
			GameUtil.setHeight(self._Viewport, 375)
			self:_updateCell(nil, self._extendCell, self._info.prizeEndUser)
		end
	end
end

function HeartofaojiureprankExtView:_refreshUI()
	local activityId = 0

	self._prizeStrList = {}

	if self._curIndex == 1 then
		activityId = self._activityId1
		self._txtTip.text = "1.该榜单为挑战模式排行榜\n2.排行榜每十五分钟更新一次\n3.活动结束后，排行奖励将通过邮件发送"

		local str = HeartofjieshenConfig.instance:getCommonValue(self._activityId2, "rankTips")

		if not string.nilorempty(str) then
			self._txtTip.text = str
		end

		self._txtDamage.text = "击杀数"

		local actCfg = HeartOfAoJiuClgConfig.instance:getActivityData(self._activityId1)

		self._prizeStrList = string.split(actCfg.dailyRankPrize, "#")
	else
		activityId = self._activityId2
		self._txtTip.text = HeartofjieshenConfig.instance:getCommonValue(self._activityId2, "rank")

		local str = HeartofjieshenConfig.instance:getCommonValue(self._activityId2, "rankTips")

		if not string.nilorempty(str) then
			self._txtTip.text = str
		end

		self._txtDamage.text = "伤害"

		local actCfg = HeartofjieshenConfig.instance:getActCfg(self._activityId2)

		self._prizeStrList = string.split(actCfg.dailyRankPrize, "#")
	end

	self._info = HeartOfAoJiuClgModel.instance:get0926RankInfo(activityId) or {}

	if not self._info.rankInfos then
		self:_onShowList()

		self._txtMyRank.text = checknumber(self._info.myRank) > 0 and checknumber(self._info.myRank) or "未上榜"
	end
end

function HeartofaojiureprankExtView:_updateCell(view, cell, data, tag)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local head = goutil.findChild(cell, "head")
	local btnHead = goutil.findChild(cell, "btnHead")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDamage = goutil.findChildTextComponent(cell, "txtDamage")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local imgGain = goutil.findChild(cell.gameObject, "imgGain")
	local scroll = self._scrollerHandlers[cell]
	local prizeStrList

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)
	GameUtil.SetActive(imgGain, data.hasGainRace)

	txtDamage.text = data.value
	txtRank.text = data.rank

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		GameUtil.setUIImageSpriteIdx(imgRank, rank - 1)
	end

	if data.headInfo.userId then
		GameUtil.addClickHandler(btnHead, GameUtil.handler(self.onHeadClick, self, data.headInfo.userId, btnHead))
	end

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)
	txtArea.text = ""

	if not scroll then
		scroll = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

		scroll:setCenterMode(true)

		self._scrollerHandlers[cell] = scroll
	end

	scroll:reloadData(self._prizeStrList)
end

function HeartofaojiureprankExtView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)
end

function HeartofaojiureprankExtView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function HeartofaojiureprankExtView:clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)

	if self._scrollerHandlers[cell] then
		self._scrollerHandlers[cell]:dispose()
	end
end

function HeartofaojiureprankExtView:_updateTabCell(view, cell, data, tag)
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	txtName.text = data

	GameUtil.SetActive(imgSelected, cell.data == self._curIndex)
	GameUtil.setUITextColorIdx(txtName, cell.data == self._curIndex and 0 or 1)
	GameUtil.addClickHandler(cell, function()
		self._curIndex = cell.data
		HeartofjieshenModel.instance.rankIndex = self._curIndex

		self._tabScrollList:refresh()
		self:_sendMsg()
	end)
end

function HeartofaojiureprankExtView:clearTabCell(cell)
	return
end

function HeartofaojiureprankExtView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return HeartofaojiureprankExtView
