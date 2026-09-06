-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityChallengeRewardView.lua

module("logic.extensions.guardcity.view.GuardCityChallengeRewardView", package.seeall)

local GuardCityChallengeRewardView = class("GuardCityChallengeRewardView", ViewComponent)

function GuardCityChallengeRewardView:ctor()
	GuardCityChallengeRewardView.super.ctor(self)
end

function GuardCityChallengeRewardView:buildUI()
	GuardCityChallengeRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._taskView = self:getGo("taskCol/taskScrollerview")
	self._taskCell = self:getGo("taskCol/taskScrollercell")
	self._itemGo = self:getGo("taskCol/itemScrollercell")
end

function GuardCityChallengeRewardView:bindEvents()
	GuardCityChallengeRewardView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function GuardCityChallengeRewardView:unbindEvents()
	GuardCityChallengeRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GuardCityChallengeRewardView:onEnter()
	GuardCityChallengeRewardView.super.onEnter(self)

	self._taskTable = ScrollerList.create(self._taskView, self._taskCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._damagePrizePlanId = self:getFirstParam()
	self._itemScrollListDic = {}

	self:_refreshView()
end

function GuardCityChallengeRewardView:onExit()
	GuardCityChallengeRewardView.super.onExit(self)
	self._taskTable:dispose()
end

function GuardCityChallengeRewardView:_refreshView()
	self._taskTable:reloadData(GuardCityConfig.instance:getDamagePrizeCfgs(self._damagePrizePlanId))
end

function GuardCityChallengeRewardView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")
	local txtDamage = goutil.findChildTextComponent(go, "txtDesc")

	txtDamage.text = langPara("伤害达到%d点", data.damage)

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

function GuardCityChallengeRewardView:_clearCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function GuardCityChallengeRewardView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function GuardCityChallengeRewardView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function GuardCityChallengeRewardView:_onClickClose()
	self:close()
end

return GuardCityChallengeRewardView
