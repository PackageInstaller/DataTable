-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplancaipiaoeventView.lua

module("logic.extensions.richmanxplan.view.RmxplancaipiaoeventView", package.seeall)

local RmxplancaipiaoeventView = class("RmxplancaipiaoeventView", ViewComponent)

function RmxplancaipiaoeventView:ctor()
	RmxplancaipiaoeventView.super.ctor(self)
end

function RmxplancaipiaoeventView:unbindEvents()
	RmxplancaipiaoeventView.super.unbindEvents(self)
	self._btnReset:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnRewardTip:RemoveClickListener()
end

function RmxplancaipiaoeventView:bindEvents()
	RmxplancaipiaoeventView.super.bindEvents(self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnRewardTip:AddClickListener(self._onClickbtnRewardTip, self)
end

function RmxplancaipiaoeventView:buildUI()
	RmxplancaipiaoeventView.super.buildUI(self)

	self._btnReset = self:getBtn("btnReset")
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._txtLimit = self:getTxt("txtLimit")
	self._txtTotalCost = self:getTxt("txtTotalCost")
	self._txtRoundTip = self:getTxt("txtRoundTip")
	self._gridGo = self:getGo("grid")
	self._gridsGo = self:getGo("grids")
	self._itemGroup = ItemGroup.New(self._gridsGo, self._gridGo, nil, nil, true, self._clearGroupItem, self)
	self._txtMat = self:getTxt("matCell/txtMat")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnRewardTip = self:getBtn("left/btnRewardTip")
end

function RmxplancaipiaoeventView:onExit()
	RmxplancaipiaoeventView.super.onExit(self)
	self._itemGroup:dispose()
	self._scrollerList:dispose()
end

function RmxplancaipiaoeventView:onEnter()
	RmxplancaipiaoeventView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._score = RichmanxplanModel.instance:getScore(self._activityId)
	self._selectNums = {}
	self._eventCfg = RichmanxplanConfig.instance:getCaipiaoEventCfg(self._activityId, self._event.eventId)
	self._prizeNum = self._eventCfg.prizeNum

	self:_updateUI()
end

function RmxplancaipiaoeventView:_onClickbtnReset()
	self._selectNums = {}

	self:_updateGrids()
	self:_updateSelectState()
end

function RmxplancaipiaoeventView:_onClickbtnClose()
	local text = "退出后将无法购买彩票，是否确认？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, true)
		self:close()
	end)
end

function RmxplancaipiaoeventView:_onClickbtnSure()
	if self._score < self._eventCfg.cost * table.nums(self._selectNums) then
		FloatWordMgr.instance:show("消耗货币不足")

		return
	end

	if table.nums(self._selectNums) <= 0 then
		FloatWordMgr.instance:show("最少选1个")

		return
	end

	local t = {
		selectNumber = table.values(self._selectNums)
	}

	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, GameUtil.jsonToString(t))
	self:close()
end

function RmxplancaipiaoeventView:_updateUI()
	self:_updateGrids()
	self:_updateDesc()
	self:_updateSelectState()
	self:_updateMat()
end

function RmxplancaipiaoeventView:_updateGrids()
	local numIds = {}

	for i = 1, self._eventCfg.numberMax do
		table.insert(numIds, i)
	end

	self._itemGroup:updateWithMoArray(numIds, function(item, num)
		local xIdx = item.index % 5

		if xIdx == 0 then
			xIdx = 5
		end

		local yIdex = math.ceil(item.index / 5)
		local x = (xIdx - 1) * 185 - 50
		local y = -(yIdex - 1) * 129 + 50

		Framework.TransformUtil.SetLocalPos(item.mainGO.transform, x, y, 0)

		local btnBg = Framework.ButtonAdapter.GetFrom(item.mainGO, "btn")
		local goSelect = goutil.findChild(item.mainGO, "select")
		local txtNum = goutil.findChild(item.mainGO, "txtNum"):GetComponent(ComponentType.UIImgNumeralText)

		txtNum:SetNum(num)
		goutil.setActive(goSelect, self._selectNums[num])
		btnBg:AddClickListener(function()
			if self._selectNums[num] then
				self._selectNums[num] = nil
			else
				if table.nums(self._selectNums) >= self._prizeNum then
					FloatWordMgr.instance:show(string.format("最多可投注%s个", self._prizeNum))

					return
				end

				self._selectNums[num] = num
			end

			self:_updateGrids()
			self:_updateSelectState()
		end)
	end)
	self:_updateDesc()
end

function RmxplancaipiaoeventView:_clearGroupItem(item)
	return
end

function RmxplancaipiaoeventView:_updateDesc()
	self._txtTotalCost.text = self._eventCfg.cost * table.nums(self._selectNums)
	self._txtRoundTip.text = string.format("%s次投骰子后开奖！", self._eventCfg.diceTimes)

	self._scrollerList:reloadData({
		1
	})
end

function RmxplancaipiaoeventView:_updateSelectState()
	self._txtLimit.text = string.format("当前可投注%s/%s", self._prizeNum - table.nums(self._selectNums), self._prizeNum)
end

function RmxplancaipiaoeventView:_updateMat()
	self._txtMat.text = self._score
end

function RmxplancaipiaoeventView:_updateCell(view, cell, index, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local cfg = RichmanxplanConfig.instance:getCaipiaoEventCfg(self._activityId, self._event.eventId)

	txtDesc.text = string.format("命中%s次\n获得资金：\n%s", 1, cfg.prize)
end

function RmxplancaipiaoeventView:_clearCell(cell)
	return
end

function RmxplancaipiaoeventView:_onClickbtnRewardTip()
	TipsFacade.instance:openRulesView("rmxplancaipiaoeventview")
end

return RmxplancaipiaoeventView
