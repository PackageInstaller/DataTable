-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/tab/FamilyHoudingClgTabPrizeView.lua

module("logic.extensions.familyhoundingclg.view.tab.FamilyHoudingClgTabPrizeView", package.seeall)

local FamilyHoudingClgTabPrizeView = class("FamilyHoudingClgTabPrizeView", ViewComponent)

function FamilyHoudingClgTabPrizeView:buildUI()
	FamilyHoudingClgTabPrizeView.super.buildUI(self)

	local rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	local rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(rankScrollerview, rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function FamilyHoudingClgTabPrizeView:bindEvents()
	FamilyHoudingClgTabPrizeView.super.bindEvents(self)
end

function FamilyHoudingClgTabPrizeView:unbindEvents()
	FamilyHoudingClgTabPrizeView.super.unbindEvents(self)
end

function FamilyHoudingClgTabPrizeView:onEnter()
	FamilyHoudingClgTabPrizeView.super.onEnter(self)

	self._fhId = FamilyHoudingClgController.instance:getCurPlanId()

	local isInTime = FamilyHoudingClgController.instance:isInTime(self._fhId)

	if not isInTime then
		self:close()

		return
	end

	local params = self:getOpenParam() or {}

	self._curRankType = checknumber(params[1])

	if self._curRankType <= 0 then
		printError("缺失传入参数，无法辨认是家族还是个人")
		self:close()

		return
	end

	self:_onUpdateRuleColUI()
end

function FamilyHoudingClgTabPrizeView:onExit()
	FamilyHoudingClgTabPrizeView.super.onExit(self)
	self:_onClearRuleCol()
end

function FamilyHoudingClgTabPrizeView:_onUpdateRuleColUI()
	self._curRankType = self._curRankType or FhcEnum.RankType_Family

	local dataList = {}

	if self._curRankType == FhcEnum.RankType_Family then
		dataList = FamilyHoudingClgConfig.instance:getFhFamilyRankPrizeCfg(self._fhId)
	elseif self._curRankType == FhcEnum.RankType_Persion then
		dataList = FamilyHoudingClgConfig.instance:getFhPersonRankPrizeCfg(self._fhId)
	end

	self._rankScrollList:reloadData(dataList)
end

function FamilyHoudingClgTabPrizeView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function FamilyHoudingClgTabPrizeView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")
	local leftRank = data.rankRange[1]
	local rightRank = data.rankRange[2]

	txtRank.text = leftRank == rightRank and string.format("%s", leftRank) or string.format("%s~%s", leftRank, rightRank)

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function FamilyHoudingClgTabPrizeView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function FamilyHoudingClgTabPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function FamilyHoudingClgTabPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return FamilyHoudingClgTabPrizeView
