-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilChallengeRewardView.lua

module("logic.extensions.destroyevil.view.DestroyEvilChallengeRewardView", package.seeall)

local DestroyEvilChallengeRewardView = class("DestroyEvilChallengeRewardView", ViewComponent)

function DestroyEvilChallengeRewardView:buildUI()
	DestroyEvilChallengeRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._taskView = self:getGo("taskCol/taskScrollerview")
	self._taskCell = self:getGo("taskCol/taskScrollercell")
	self._itemGo = self:getGo("taskCol/itemScrollercell")
end

function DestroyEvilChallengeRewardView:bindEvents()
	DestroyEvilChallengeRewardView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function DestroyEvilChallengeRewardView:unbindEvents()
	DestroyEvilChallengeRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DestroyEvilChallengeRewardView:onEnter()
	DestroyEvilChallengeRewardView.super.onEnter(self)

	self._taskTable = ScrollerList.create(self._taskView, self._taskCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scorePlanId = self:getFirstParam()
	self._itemScrollListDic = {}

	self:_refreshView()
end

function DestroyEvilChallengeRewardView:onExit()
	DestroyEvilChallengeRewardView.super.onExit(self)
	self._taskTable:dispose()
end

function DestroyEvilChallengeRewardView:_refreshView()
	local cfgs = DestroyEvilConfig.instance:getScoreList(self._scorePlanId)

	self._taskTable:reloadData(cfgs)
end

function DestroyEvilChallengeRewardView:_updateCell(view, cell, data, tag)
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

function DestroyEvilChallengeRewardView:_clearCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function DestroyEvilChallengeRewardView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function DestroyEvilChallengeRewardView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function DestroyEvilChallengeRewardView:_onClickClose()
	self:close()
end

return DestroyEvilChallengeRewardView
