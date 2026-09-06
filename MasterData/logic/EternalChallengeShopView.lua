-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/shop/EternalChallengeShopView.lua

module("logic.extensions.eventtasksummary.view.shop.EternalChallengeShopView", package.seeall)

local EternalChallengeShopView = class("EternalChallengeShopView", ViewComponent)

function EternalChallengeShopView:buildUI()
	EternalChallengeShopView.super.buildUI(self)

	local tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	local tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnCloseMask = goutil.findChild(self.mainGO, "btnCloseMask")
end

function EternalChallengeShopView:bindEvents()
	EternalChallengeShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCloseMask, self.close, self)
end

function EternalChallengeShopView:unbindEvents()
	EternalChallengeShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCloseMask)
end

function EternalChallengeShopView:onEnter()
	EternalChallengeShopView.super.onEnter(self)

	self._activityId = EternalChallengeController.instance:getActivityId()
	self._activityType = EternalChallengeController.instance:getActivityType()

	local isInTime = EternalChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._curTabIdx = 1

	self:_onSetUI()
	self:_onUpdate()
end

function EternalChallengeShopView:onExit()
	EternalChallengeShopView.super.onExit(self)
	self:_onClearTabCol()
	self:_onClearTabAt()
end

function EternalChallengeShopView:_onSetUI()
	return
end

function EternalChallengeShopView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EternalChallengeShopView:_onUpdateData()
	self:_onUpdateTabColData()
end

function EternalChallengeShopView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_showTabAt()
end

EternalChallengeShopView.TabInfos = {
	{
		tabName = "招募精灵",
		redId = RedPointModel.ID_ETERNAL_CHALLENGE_PET,
		viewName = ViewName.EternalChallengePetView
	},
	{
		tabName = "升级buff",
		redId = RedPointModel.ID_ETERNAL_CHALLENGE_BUFF,
		viewName = ViewName.EternalChallengeBuffView
	}
}

function EternalChallengeShopView:_onUpdateTabColData()
	self._tabInfoList = EternalChallengeShopView.TabInfos
end

function EternalChallengeShopView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)
end

function EternalChallengeShopView:_onClearTabCol()
	self._tabScrollList:dispose()
end

function EternalChallengeShopView:_updateTabCell(view, cell, info, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local imgSelectDark = goutil.findChild(mainGo, "imgSelectDark")
	local imgSelectLight = goutil.findChild(mainGo, "imgSelectLight")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")

	txtName.text = info.tabName

	local redId = info.redId .. ""

	GameUtil.SetActive(redPoint, false)

	if not string.nilorempty(redId) then
		RedPointController.instance:regRedPoint(redPoint, redId)
	else
		RedPointController.instance:unregRedPoint(redPoint)
	end

	GameUtil.SetActive(imgSelectDark, self._curTabIdx ~= tabIdx)
	GameUtil.SetActive(imgSelectLight, not GameUtil.GetActive(imgSelectDark))
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, info, tabIdx))
end

function EternalChallengeShopView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(mainGo)
end

function EternalChallengeShopView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function EternalChallengeShopView:_showTabAt()
	local info = self._tabInfoList[self._curTabIdx]

	if info == nil then
		return
	end

	if self._oldTabIdx and self._oldTabIdx == self._curTabIdx then
		return
	end

	self:_onClearTabAt()

	self._oldTabIdx = self._curTabIdx

	if info.viewParams then
		self:showTabAt(self._contentCol, info.viewName, info.viewParams)
	else
		self:showTabAt(self._contentCol, info.viewName)
	end
end

function EternalChallengeShopView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

return EternalChallengeShopView
