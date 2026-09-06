-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhurankView.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhurankView", package.seeall)

local ShenyaolongzunshengzhurankView = class("ShenyaolongzunshengzhurankView", ViewComponent)
local tab_1 = 1
local tab_2 = 2
local TabCfg = {
	{
		tabIndex = tab_1,
		tabName = lang("大神排行")
	},
	{
		tabIndex = tab_2,
		tabName = lang("每日排行")
	}
}

function ShenyaolongzunshengzhurankView:unbindEvents()
	ShenyaolongzunshengzhurankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ShenyaolongzunshengzhurankView:bindEvents()
	ShenyaolongzunshengzhurankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function ShenyaolongzunshengzhurankView:onExit()
	ShenyaolongzunshengzhurankView.super.onExit(self)
	self._scrollList:dispose()
	self._rightScrollList:dispose()
end

function ShenyaolongzunshengzhurankView:buildUI()
	ShenyaolongzunshengzhurankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._goEmpty = self:getGo("right/goEmpty")
	self.txtMyRankTitle = self:getTxt("right/myRank/txtMyRankTitle")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtSubTitle = self:getTxt("right/subTitle/txtTime")
	self._txtTitleName = self:getTxt("right/subTitle/txtName")
	self._txtTitleNum = self:getTxt("right/subTitle/txtFamily")
	self.scrollerGo = self:getGo("tabList")
	self.cellGo = self:getGo("tabCell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._scrollList:regGetCellSize(function()
		return 100, 70
	end)

	local rankScrollRect = self:getGo("right/rankScrollRect")
	local cell = self:getGo("right/cell")

	self._rightScrollList = ScrollerList.create(rankScrollRect, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ShenyaolongzunshengzhurankView:_updateTabCell(view, cell, data, tag)
	local change = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "nameTxt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txtName.text = data.tabName

	change:SetState(data.tabIndex == self._tabIndex and 1 or 0)
	btn:AddClickListener(function()
		self:_switchTab(data.tabIndex)
	end)
end

function ShenyaolongzunshengzhurankView:_clearTabCell(cell)
	return
end

function ShenyaolongzunshengzhurankView:clearCell(cell)
	return
end

function ShenyaolongzunshengzhurankView:onEnter()
	ShenyaolongzunshengzhurankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local index = checknumber(params[2])

	if index == 0 then
		index = tab_1
	end

	self.addGEvent(self, GlobalNotify.ShenyaolongzunshengzhuRankUpdate, self.onRefreshUI, self)

	local cfg = ShenyaolongzunshengzhuConfig.instance:getActivityCfgById(self._activityId) or {}
	local isOpen = string.nilorempty(cfg.dailyRankStartTime) or string.nilorempty(cfg.dailyRankEndTime) or GameUtil.checkIsInTimePeriod(cfg.dailyRankStartTime, cfg.dailyRankEndTime)

	self._tabList = {}

	for i, v in ipairs(TabCfg) do
		if v.tabIndex == tab_2 then
			if isOpen then
				table.insert(self._tabList, v)
			end
		else
			table.insert(self._tabList, v)
		end
	end

	self:_switchTab(index, true)
end

function ShenyaolongzunshengzhurankView:_switchTab(index, force)
	if self._tabIndex == index and not force then
		return
	end

	self._tabIndex = index

	self._scrollList:reloadData(self._tabList)

	self._txtTip.text = index == tab_1 and ShenyaolongzunshengzhuConfig.instance:getCommonValue("DESC_RANK_GOD") or ShenyaolongzunshengzhuConfig.instance:getCommonValue("DESC_RANK_DAILY")

	if index == tab_1 then
		ShenyaolongzunshengzhuController.instance:sendGetGodRank(self._activityId)
	else
		ShenyaolongzunshengzhuController.instance:sendGetDayRank(self._activityId)
	end
end

function ShenyaolongzunshengzhurankView:onRefreshUI()
	local list = {}

	if self._tabIndex == tab_1 then
		list = ShenyaolongzunshengzhuModel.instance.godRankInfos or {}

		local myRank = checknumber(ShenyaolongzunshengzhuModel.instance.godMyRank)

		self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")
	else
		list = ShenyaolongzunshengzhuModel.instance.dayRankInfos or {}

		local myRank = checknumber(ShenyaolongzunshengzhuModel.instance.dayMyRank)

		self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")
	end

	self._goEmpty:SetActive(not list or #list == 0)
	self._rightScrollList:reloadData(list)
end

function ShenyaolongzunshengzhurankView:_updateCell(view, cell, data, tag)
	self:_updateGodCell(view, cell, data)
end

function ShenyaolongzunshengzhurankView:_updateGodCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "rankIma", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "headGo")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local petHead = goutil.findChild(go, "petHead")

	GameUtil.SetActive(petHead, false)

	if data.headInfo then
		txtName.text = data.headInfo.userName or ""
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo, true)

	txtRank.text = data.rank
	txtScore.text = data.value

	local endDate = GameUtil.time2date(checknumber(data.time) / 1000)

	txtArea.text = langPara("%02d.%02d %02d:%02d ", endDate.month, endDate.day, endDate.hour, endDate.min)

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end
end

function ShenyaolongzunshengzhurankView:_clearTableview(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "headGo")
	local petHead = goutil.findChild(go, "petHead")

	HeadItemController.instance:resetHeadCell(imgIcon)
	MaterialMgr.clearIcon(petHead)
end

return ShenyaolongzunshengzhurankView
