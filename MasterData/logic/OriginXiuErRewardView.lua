-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErRewardView.lua

module("logic.extensions.originxiuer.view.OriginXiuErRewardView", package.seeall)

local OriginXiuErRewardView = class("OriginXiuErRewardView", ViewComponent)

function OriginXiuErRewardView:ctor()
	OriginXiuErRewardView.super.ctor(self)
end

function OriginXiuErRewardView:unbindEvents()
	OriginXiuErRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginXiuErRewardView:bindEvents()
	OriginXiuErRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginXiuErRewardView:buildUI()
	OriginXiuErRewardView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtCurStage = self:getTxt("txtCurStage")
	self._txtTip = self:getTxt("txtTip")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginXiuErRewardView:onExit()
	OriginXiuErRewardView.super.onExit(self)
	self._scrollList:dispose()

	for cell, scroll in pairs(self._scrollMap) do
		scroll:dispose()

		self._scrollMap[cell] = nil
	end
end

function OriginXiuErRewardView:onEnter()
	OriginXiuErRewardView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 537001
	end

	self._stageCfgs = OriginXiuErConfig.instance:getStageCfgs(self._activityId)
	self._info = OriginXiuErModel.instance:getInfo(self._activityId)
	self._scrollMap = {}
	self._txtCurStage.text = string.format("当前关卡：%d/%d", self._info.maxPassStageId, #self._stageCfgs)

	self._scrollList:reloadData(self._stageCfgs)
end

function OriginXiuErRewardView:_updateCell(view, cell, data)
	local tableviewReward = goutil.findChild(cell, "tableviewReward")
	local tablecell = goutil.findChild(cell, "tableviewReward/tablecell")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local rewardScroll = self._scrollMap[cell]

	if rewardScroll == nil then
		rewardScroll = ScrollerList.create(tableviewReward, tablecell, GameUtil.handler(self._updateCellReward, self), GameUtil.handler(self._clearCellReward, self))
		self._scrollMap[cell] = rewardScroll
	end

	local rewardDataList = {}
	local rewardArr = string.split(data.prize, "#")
	local hasGain = table.indexof(self._info.hasGainPrize, data.stageId)

	txtName.text = string.format("第%d关", data.stageId)

	for _, reward in ipairs(rewardArr) do
		local rewardData = {}

		rewardData.reward = reward
		rewardData.hasGain = hasGain

		table.insert(rewardDataList, rewardData)
	end

	rewardScroll:reloadData(rewardDataList)
end

function OriginXiuErRewardView:_clearCell(cell)
	local rewardScroll = self._scrollMap[cell]

	rewardScroll:dispose()

	self._scrollMap[cell] = nil
end

function OriginXiuErRewardView:_updateCellReward(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")

	MaterialMgr.setCellByCfg(data.reward, item)
	GameUtil.SetActive(geted, data.hasGain)
end

function OriginXiuErRewardView:_clearCellReward(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

return OriginXiuErRewardView
