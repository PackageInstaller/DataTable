-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikerankView.lua

module("logic.extensions.roguelike.view.RoguelikerankView", package.seeall)

local RoguelikerankView = class("RoguelikerankView", ViewComponent)

RoguelikerankView.EnumKill = 1
RoguelikerankView.EnumPass = 2

function RoguelikerankView:unbindEvents()
	RoguelikerankView.super.unbindEvents(self)
end

function RoguelikerankView:bindEvents()
	RoguelikerankView.super.bindEvents(self)
end

function RoguelikerankView:buildUI()
	RoguelikerankView.super.buildUI(self)

	self._rankCellGo = self:getGo("right/rankCell")
	self._rankCellGo2 = self:getGo("right/rankCell2")
	self._rankListViewGo = self:getGo("right/rankListView")
	self._goEmptyGo = self:getGo("right/goEmpty")
	self._scrollerList = ScrollerList.create(self._rankListViewGo, {
		self._rankCellGo,
		self._rankCellGo2
	}, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByData, self))

	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._scrollerHandlers = {}
	self._killText = self:getGo("right/myRank/killText")
	self._jiuGo = goutil.findChild(self._killText, "txtJiu")
	self._jieshenGo = goutil.findChild(self._killText, "txtJieshen")
	self._txtJiu = goutil.findChildTextComponent(self._killText, "txtJiu/txtNum")
	self._txtJieshen = goutil.findChildTextComponent(self._killText, "txtJieshen/txtNum")
	self._passText = self:getGo("right/myRank/passText")
	self._txtPassTip = goutil.findChildTextComponent(self._passText, "txt")
	self._txtPassTime = goutil.findChildTextComponent(self._passText, "txtTime")
	self._txtRecord = self:getTxt("right/description/txtRecord")
	self._txtScore = self:getTxt("right/description/txtScore")
	self._description = self:getGo("right/description")
	self._description2 = self:getGo("right/description2")
end

function RoguelikerankView:onExit()
	RoguelikerankView.super.onExit(self)
	self._scrollerList:dispose()
end

function RoguelikerankView:onEnter()
	RoguelikerankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RoguelikeGetPassRankRes, self._onRoguelikeGetPassRankRes, self)
	self.addGEvent(self, GlobalNotify.RoguelikeGetKillRankRes, self._onRoguelikeGetKillRankRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._params = params[2]
	self._phaseId = self._params.phaseId
	self._rankType = self._params.rankType

	local cfg = RoguelikeConfig.instance:getActivityCfg(self._activityId)

	self._txtTip.text = cfg.rankTip

	local cfgPhase = RoguelikeConfig.instance:getPhaseCfg(self._activityId, self._phaseId)
	local startTimestamp = GameUtil.string2time(cfgPhase.releaseTime)
	local isOpen = not string.nilorempty(cfgPhase.releaseTime) and startTimestamp < ServerTime.now()

	if isOpen then
		if self._rankType == RoguelikerankView.EnumKill then
			RoguelikeAgent.instance:sendPM_RoguelikeGetKillRankReq(self._activityId, self._phaseId)
		else
			RoguelikeAgent.instance:sendPM_RoguelikeGetPassRankReq(self._activityId, self._phaseId)
		end
	else
		local date = GameUtil.time2date(startTimestamp)

		FloatWordMgr.instance:show(string.format("排行榜将在%d月%d日%d:%02d后随关卡开启", date.month, date.day, date.hour, date.min))
		self:_updateRankInfo()
		self:_updateRankView()
	end
end

function RoguelikerankView:_getTagByData(data, idx)
	return self._rankType
end

function RoguelikerankView:_updateCell(view, cell, data, tag)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtProgress = goutil.findChildTextComponent(cell.gameObject, "txtProgress")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local isTop3 = data.rank <= 3
	local scroll = self._scrollerHandlers[cell]
	local prizeCfg = self:_getRankPrizeCfg(data.rank)
	local prizeStrList

	if prizeCfg then
		prizeStrList = string.split(prizeCfg.prize, "#")
	end

	MaterialMgr.resetAll(goHeadIcon)
	HeadItemController.instance:resetHeadCell(goHeadIcon)
	HeadItemController.instance:setHeadCellByInfo(goHeadIcon, data.headInfo, true)
	goutil.setActive(imgChangeImgRank.gameObject, isTop3)

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
	end

	goutil.setActive(txtRank.gameObject, not isTop3)

	txtRank.text = data.rank
	txtName.text = data.headInfo.userName

	if self._rankType == RoguelikerankView.EnumKill then
		txtProgress.text = data.headInfo.areaName
		txtScore.text = data.value
	else
		local date = GameUtil.time2date(Mathf.Round(checknumber(data.time) / 1000))

		txtProgress.text = string.format("%04d.%02d.%02d %02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	end

	if not scroll then
		scroll = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollerHandlers[cell] = scroll
	end

	scroll:reloadData(prizeStrList)
end

function RoguelikerankView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)
end

function RoguelikerankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function RoguelikerankView:_clearCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")

	HeadItemController.instance:resetHeadCell(goHeadIcon)

	if self._scrollerHandlers[cell] then
		self._scrollerHandlers[cell]:dispose()
	end
end

function RoguelikerankView:_onRoguelikeGetPassRankRes()
	local info = RoguelikeModel.instance:getPassRankInfo()

	self:_updateRankInfo(info)
	self:_updateRankView()
end

function RoguelikerankView:_onRoguelikeGetKillRankRes()
	local info = RoguelikeModel.instance:getKillRankInfo()

	self:_updateRankInfo(info)
	self:_updateRankView()
end

function RoguelikerankView:_updateRankInfo(info)
	self._myRank = -1
	self._rankInfos = nil

	if info then
		self._myRank = checknumber(info.myRank)
		self._rankInfos = info.rankInfos
	end

	self:_updateKillText()
	self:_updatePassText()
	self:_updateTitle()
end

function RoguelikerankView:_updateRankView()
	self._scrollerList:reloadData(self._rankInfos)
	goutil.setActive(self._goEmptyGo, not self._rankInfos or #self._rankInfos <= 0)

	self._txtMyRank.text = self._myRank <= 0 and "未上榜" or string.format("第%s名", self._myRank)

	GameUtil.SetActive(self._description, self._rankType == RoguelikerankView.EnumKill)
	GameUtil.SetActive(self._description2, self._rankType == RoguelikerankView.EnumPass)
end

function RoguelikerankView:_getRankPrizeCfg(rank)
	local cfgs = RoguelikeConfig.instance:getRankPrizeList(self._activityId, self._phaseId, self._rankType)

	for i, v in ipairs(cfgs) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			return v
		end
	end

	return nil
end

function RoguelikerankView:_updateKillText()
	if self._rankType == RoguelikerankView.EnumKill then
		goutil.setActive(self._killText, true)

		if self._phaseId == RoguelikeModel.Challenge1 then
			goutil.setActive(self._jiuGo, false)
			goutil.setActive(self._jieshenGo, true)

			self._txtJieshen.text = RoguelikeModel.instance:getMaxKillNum(self._activityId, RoguelikeModel.Challenge1)
		else
			goutil.setActive(self._jiuGo, true)
			goutil.setActive(self._jieshenGo, false)

			self._txtJiu.text = RoguelikeModel.instance:getMaxKillNum(self._activityId, RoguelikeModel.Challenge2)
		end
	else
		goutil.setActive(self._killText, false)
	end
end

function RoguelikerankView:_updatePassText()
	if self._rankType == RoguelikerankView.EnumPass then
		goutil.setActive(self._passText, true)

		local passTime = RoguelikeModel.instance:getPassTime(self._activityId, self._phaseId)

		printInfo("test RoguelikerankView:_updatePassText", self._phaseId, passTime)

		if passTime > 0 then
			goutil.setActive(self._txtPassTime.gameObject, true)

			self._txtPassTip.text = "我的通关时间："

			local date = GameUtil.time2date(passTime)

			self._txtPassTime.text = string.format("%d月%d日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
		else
			goutil.setActive(self._txtPassTime.gameObject, false)

			self._txtPassTip.text = "当前暂无通关时间"
		end
	else
		goutil.setActive(self._passText, false)
	end
end

function RoguelikerankView:_updateTitle()
	if self._rankType == RoguelikerankView.EnumKill then
		self._txtRecord.text = "区服"
		self._txtScore.text = "击杀数量"
	else
		self._txtRecord.text = "通关达成时间"
		self._txtScore.text = "通关层数"
	end
end

return RoguelikerankView
