-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/ZxldaywishView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.ZxldaywishView", package.seeall)

local ZxldaywishView = class("ZxldaywishView", ViewComponent)

function ZxldaywishView:ctor()
	ZxldaywishView.super.ctor(self)
end

function ZxldaywishView:unbindEvents()
	ZxldaywishView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZxldaywishView:bindEvents()
	ZxldaywishView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZxldaywishView:buildUI()
	ZxldaywishView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._scrollObj = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
end

function ZxldaywishView:onExit()
	ZxldaywishView.super.onExit(self)
	self._tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)
end

function ZxldaywishView:onEnter()
	ZxldaywishView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)

	self.activityId = ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.ZxlChallenge)

	local baseData = ShikongshenglongConfig.instance:getActivityCfg(self.activityId)
	local dailySignPlanId = baseData.dailySignPlanId

	self.signCfgs = ShikongshenglongConfig.instance:getSignCfgs(dailySignPlanId)

	self:_onRefreshUI()
end

function ZxldaywishView:_onRefreshUI()
	self._tableview:reloadData(self.signCfgs)
	self._tableview:refresh()
end

function ZxldaywishView:_updateCell(index, cell, data)
	local todayIndex = ShikongshenglongModel.instance.curDailySignId + 1
	local canGet = todayIndex == data.dailySignId and not ShikongshenglongModel.instance.isSignToday
	local haveGet = ShikongshenglongModel.instance.curDailySignId >= data.dailySignId
	local btnObj = goutil.findChild(cell, "btnAchieve")
	local getObj = goutil.findChild(cell, "receive")
	local btn = GameUtil.asBtn(btnObj)

	goutil.findChildTextComponent(cell, "txtDay").text = string.format("第%d天", data.dailySignId)

	getObj:SetActive(haveGet)
	btnObj:SetActive(canGet)
	btn:AddClickListener(function()
		ShikongshenglongController.instance:sendToSign(self.activityId)
	end, self)

	local awards = string.split(data.prize, "#")
	local itemNum = #awards
	local transform = goutil.findChild(cell, "reward").transform
	local childCount = transform.childCount

	while childCount < itemNum do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, itemNum do
		local go = transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByCfg(awards[i], go)
		go:SetActive(true)
	end

	for i = itemNum + 1, childCount do
		transform:GetChild(i - 1).gameObject:SetActive(false)
	end
end

function ZxldaywishView:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnAchieve"))

	local transform = goutil.findChild(cell, "reward").transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end
end

return ZxldaywishView
