-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/view/HitbossrankView.lua

module("logic.extensions.hitboss.view.HitbossrankView", package.seeall)

local HitbossrankView = class("HitbossrankView", ViewComponent)
local RankTags_Normal = 1
local RankTags_NoPrize = 2

function HitbossrankView:ctor()
	HitbossrankView.super.ctor(self)

	self._scrollMap = {}
	self._rankTag = RankTags_Normal
end

function HitbossrankView:unbindEvents()
	HitbossrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function HitbossrankView:bindEvents()
	HitbossrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function HitbossrankView:buildUI()
	HitbossrankView.super.buildUI(self)

	self._txtTip = self:getTxt("myRank/txtTip")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._emptyGo = self:getGo("empty")
	self.btnClose = self:getGo("btnClose")
	self._reward = self:getGo("reward")
	self._title_normal = self:getGo("title_normal")
	self._title_noPrize = self:getGo("title_noPrize")

	local cell1 = self:getGo("cell1")
	local cell2 = self:getGo("cell2")
	local tableviewGo = self:getGo("tableview")
	local tagGoList = {
		cell1,
		cell2
	}

	self._sizeList = {}

	for tag, tagGo in ipairs(tagGoList) do
		local width, height = GameUtil.getWidth(tagGo), GameUtil.getHeight(tagGo)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._scrollerList = ScrollerList.create(tableviewGo, tagGoList, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regGetTagByIdx(function(data, idx)
		return data.tag
	end)
	self._scrollerList:regGetCellSize(function(view, idx)
		local list = self._scrollerList:getData()
		local data = list[idx + 1]

		return self._sizeList[data.tag][1], self._sizeList[data.tag][2]
	end)
end

function HitbossrankView:onExit()
	HitbossrankView.super.onExit(self)
	self._scrollerList:dispose()
end

function HitbossrankView:onEnter()
	HitbossrankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local prizeCfg = HitbossConfig.instance:getBossRankPrizeCfg(self._activityId)

	self._rankTag = prizeCfg and RankTags_Normal or RankTags_NoPrize

	self.addGEvent(self, HitBossAgent.HitBossGetRankInfoRes, self._updateUI, self)
	self:_updateUI()
	HitBossAgent.instance:sendPM_HitBossGetRankInfoReq(self._activityId)
end

function HitbossrankView:_updateUI()
	local info = HitbossModel.instance:getRankInfo()

	if not info then
		return
	end

	self:_setMyRank(info.myRank)
	self:_updateRanks(info.rankInfos)
end

function HitbossrankView:_setMyRank(myRank)
	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
end

function HitbossrankView:_updateRanks(rankInfos)
	local list = {}

	for i, v in ipairs(rankInfos) do
		local mo = {}

		mo.tag = self._rankTag
		mo.data = v

		table.insert(list, mo)
	end

	self._scrollerList:reloadData(list)
	goutil.setActive(self._emptyGo, #list <= 0)
	goutil.setActive(self._title_normal, self._rankTag == RankTags_Normal)
	goutil.setActive(self._title_noPrize, self._rankTag == RankTags_NoPrize)
end

function HitbossrankView:_updateCell(view, cell, mo, tag)
	local tag = mo.tag
	local data = mo.data

	if tag == 1 then
		self:_updateCellNormal(view, cell, data, tag)
	else
		self:_updateCellNoPrize(view, cell, data, tag)
	end
end

function HitbossrankView:_updateCellNormal(view, cell, data, tag)
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")
	local goHead = goutil.findChild(cell.gameObject, "head")
	local isTop3 = data.rank <= 3

	goutil.setActive(imgChangeImgRank.gameObject, isTop3)
	goutil.setActive(txtRank.gameObject, not isTop3)

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
	end

	txtRank.text = data.rank
	txtScore.text = HitbossController.instance:getDamageStr(data.value)

	local time = math.floor(checknumber(data.time) / 1000)
	local date = GameUtil.time2date(time)

	txtTime.text = string.format("%s.%s.%s\n%s:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	txtName.text = data.headInfo.userName

	HeadItemController.instance:resetHeadCell(goHead)
	HeadItemController.instance:setHeadCellByInfo(goHead, data.headInfo, true)

	local rewardViewGo = goutil.findChild(cell, "rewardView")
	local rewardView = self._scrollMap[cell]

	if rewardView == nil then
		rewardView = ScrollerList.create(rewardViewGo, self._reward, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollMap[cell] = rewardView
	end

	local list = HitbossConfig.instance:getPrizeList(self._activityId, data.rank)

	rewardView:reloadData(list or {})
end

function HitbossrankView:_updateCellNoPrize(view, cell, data, tag)
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")
	local goHead = goutil.findChild(cell.gameObject, "head")
	local isTop3 = data.rank <= 3

	goutil.setActive(imgChangeImgRank.gameObject, isTop3)
	goutil.setActive(txtRank.gameObject, not isTop3)

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
	end

	txtRank.text = data.rank
	txtScore.text = HitbossController.instance:getDamageStr(data.value)

	local time = math.floor(checknumber(data.time) / 1000)
	local date = GameUtil.time2date(time)

	txtTime.text = string.format("%s.%s.%s\n%s:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	txtName.text = data.headInfo.userName

	HeadItemController.instance:resetHeadCell(goHead)
	HeadItemController.instance:setHeadCellByInfo(goHead, data.headInfo, true)
end

function HitbossrankView:_clearCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHead)

	local rewardView = self._scrollMap[cell]

	if rewardView then
		rewardView:dispose()
	end
end

function HitbossrankView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function HitbossrankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

return HitbossrankView
