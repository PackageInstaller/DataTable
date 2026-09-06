-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeRewardView.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeRewardView", package.seeall)

local SunWuKongChallengeRewardView = class("SunWuKongChallengeRewardView", ViewComponent)

function SunWuKongChallengeRewardView:ctor()
	SunWuKongChallengeRewardView.super.ctor(self)
end

function SunWuKongChallengeRewardView:buildUI()
	SunWuKongChallengeRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._taskView = self:getGo("taskCol/taskScrollerview")
	self._taskCell = self:getGo("taskCol/taskScrollercell")
	self._itemGo = self:getGo("taskCol/itemScrollercell")
end

function SunWuKongChallengeRewardView:bindEvents()
	SunWuKongChallengeRewardView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function SunWuKongChallengeRewardView:unbindEvents()
	SunWuKongChallengeRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SunWuKongChallengeRewardView:onEnter()
	SunWuKongChallengeRewardView.super.onEnter(self)

	self._prizePlanId = self:getFirstParam()

	local prizeCfg = SunWuKongChallengeConfig.instance:getHiddenPrize(self._prizePlanId)

	self._taskTable = ScrollerList.create(self._taskView, self._taskCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemScrollListDic = {}

	self._taskTable:reloadData(prizeCfg)
end

function SunWuKongChallengeRewardView:onExit()
	SunWuKongChallengeRewardView.super.onExit(self)
	self._taskTable:dispose()
end

function SunWuKongChallengeRewardView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	txtDesc.text = langPara("%d分", data.score)

	if itemScrollerview and self._itemGo then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[go] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemGo, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			self._itemScrollListDic[go]:reloadData(prizeStrArr)
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	end
end

function SunWuKongChallengeRewardView:_clearCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function SunWuKongChallengeRewardView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function SunWuKongChallengeRewardView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return SunWuKongChallengeRewardView
