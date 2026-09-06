-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampRewardView.lua

module("logic.extensions.funcamp.view.FuncampRewardView", package.seeall)

local FuncampRewardView = class("FuncampRewardView", ViewComponent)

function FuncampRewardView:ctor()
	FuncampRewardView.super.ctor(self)

	self._tabList = {}
end

function FuncampRewardView:unbindEvents()
	FuncampRewardView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FuncampRewardView:bindEvents()
	FuncampRewardView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function FuncampRewardView:onExit()
	FuncampRewardView.super.onExit(self)

	for k, v in pairs(self._tabList) do
		v.btn:RemoveClickListener()
	end

	self._tabList = {}
end

function FuncampRewardView:buildUI()
	FuncampRewardView.super.buildUI(self)

	self._tabGo = self:getGo("Marks")
	self._rewardTab = self:getGo("Pnl_Rank/Scrl")
	self._rewardCell = self:getGo("Pnl_Rank/Cell")
	self._closeBtn = self:getBtn("Btn_Close")
	self._tipTxt = self:getTxt("Pnl_Rank/Img_Tip/Txt_Tip")
	self._rewardList = ScrollerList.create(self._rewardTab, self._rewardCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function FuncampRewardView:onEnter()
	FuncampRewardView.super.onEnter(self)
	self:_initTabList()
	self:_onClickTab(1)
end

function FuncampRewardView:_initTabList()
	self._tabList = {}

	for i = 1, 2 do
		local tab = {}
		local name = "Marks/btn_" .. i
		local go = self:getGo(name)

		tab.btn = self:getBtn(name)

		tab.btn:AddClickListener(function()
			self:_onClickTab(i)
		end, self)

		tab.selected = goutil.findChild(go, "Sel")
		tab.unSelected = goutil.findChild(go, "Txt2")
		self._tabList[i] = tab
	end
end

function FuncampRewardView:_updateTabCell(view, cell, data)
	local txtArea = goutil.findChildTextComponent(cell, "TxtArea")
	local items = goutil.findChild(cell, "medalBg")
	local matArray = string.split(data.prize, "#")

	GameUtil.updateCells(items, matArray, function(go, str)
		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByCfg(str, go)
	end, nil, true)

	txtArea.text = data.rankSection
end

function FuncampRewardView:_clearTabCell(cell)
	return
end

function FuncampRewardView:_onClickTab(index)
	for k, v in pairs(self._tabList) do
		goutil.setActive(v.selected, false)
		goutil.setActive(v.unSelected, true)
	end

	local tab = self._tabList[index]

	goutil.setActive(tab.selected, true)
	goutil.setActive(tab.unSelected, false)

	local cfg = {}

	if index == 1 then
		cfg = CampGameConfig.instance:getFinalPrize()
		self._tipTxt.text = CampGameConfig.instance:getParams("RANK_TEXT1")
	elseif index == 2 then
		cfg = CampGameConfig.instance:getRankRewardList()
		self._tipTxt.text = CampGameConfig.instance:getParams("RANK_TEXT2")
	end

	self._rewardList:reloadData(cfg)
end

return FuncampRewardView
