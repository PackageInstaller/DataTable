-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/view/MiyaChallengeRewardView.lua

module("logic.extensions.miyachallenge.view.MiyaChallengeRewardView", package.seeall)

local MiyaChallengeRewardView = class("MiyaChallengeRewardView", ViewComponent)

function MiyaChallengeRewardView:ctor()
	MiyaChallengeRewardView.super.ctor(self)
end

function MiyaChallengeRewardView:buildUI()
	MiyaChallengeRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._taskView = self:getGo("taskCol/taskScrollerview")
	self._taskCell = self:getGo("taskCol/taskScrollercell")
	self._itemGo = self:getGo("taskCol/itemScrollercell")
end

function MiyaChallengeRewardView:bindEvents()
	MiyaChallengeRewardView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function MiyaChallengeRewardView:unbindEvents()
	MiyaChallengeRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MiyaChallengeRewardView:onEnter()
	MiyaChallengeRewardView.super.onEnter(self)

	self._taskTable = ScrollerList.create(self._taskView, self._taskCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._taskTable:regReloadFinish(GameUtil.handler(self._reloadFinished, self))

	self._damage = MiyaChallengeModel.instance:getDamage(MiyaChallengeModel.instance:getShowStageId())
	self._itemScrollListDic = {}

	self:_refreshView()
end

function MiyaChallengeRewardView:onExit()
	MiyaChallengeRewardView.super.onExit(self)
	self._taskTable:dispose()
end

function MiyaChallengeRewardView:_refreshView()
	local activityCfg = MiyaChallengeConfig.instance:getActivityCfg(MiyaChallengeModel.instance:getActivityId())
	local tierCfg = MiyaChallengeConfig.instance:getTierStageCfg(activityCfg.tierPlanId, MiyaChallengeModel.instance:getTierId())
	local prizeList = MiyaChallengeConfig.instance:getBossPrizesCfg(activityCfg.activityId, tierCfg.firstPlanId, MiyaChallengeModel.instance:getShowStageId())

	self._reachIndex = 1

	for i, v in ipairs(prizeList) do
		if self._damage >= v.damage then
			self._reachIndex = i
		end
	end

	self._taskTable:reloadData(prizeList)
end

function MiyaChallengeRewardView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")
	local txtDamage = goutil.findChildTextComponent(go, "txtDesc")
	local noFinishGo = goutil.findChild(go, "noFinishGo")
	local receivedGo = goutil.findChild(go, "receivedGo")

	GameUtil.SetActive(noFinishGo, self._damage < data.damage)
	GameUtil.SetActive(receivedGo, self._damage >= data.damage)

	txtDamage.text = langPara("本关卡累计最高伤害达到%d点", data.damage)

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

function MiyaChallengeRewardView:_clearCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function MiyaChallengeRewardView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function MiyaChallengeRewardView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function MiyaChallengeRewardView:_reloadFinished()
	self._taskTable:MoveCellToCenter(self._reachIndex)
end

function MiyaChallengeRewardView:_onClickClose()
	self:close()
end

return MiyaChallengeRewardView
