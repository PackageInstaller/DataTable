-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportTabMainView.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportTabMainView", package.seeall)

local MMTeamPassportTabMainView = class("MMTeamPassportTabMainView", ViewComponent)

MMTeamPassportTabMainView.TabIndex = {
	Team = 2,
	Passport = 1
}

local TabRedPointIds = {
	[MMTeamPassportTabMainView.TabIndex.Passport] = {
		RedPointModel.ID_MMTEAM_PASSPORT
	},
	[MMTeamPassportTabMainView.TabIndex.Team] = {
		RedPointModel.ID_MMTEAM_PASSPORT_APPLY
	}
}

function MMTeamPassportTabMainView:buildUI()
	MMTeamPassportTabMainView.super.buildUI(self)

	self._contentCol = self:getGo("content")

	local scrView = self:getGo("tabCol/scrView")
	local scrCell = self:getGo("tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function MMTeamPassportTabMainView:bindEvents()
	MMTeamPassportTabMainView.super.bindEvents(self)
end

function MMTeamPassportTabMainView:unbindEvents()
	MMTeamPassportTabMainView.super.unbindEvents(self)
end

function MMTeamPassportTabMainView:onEnter()
	MMTeamPassportTabMainView.super.onEnter(self)

	if checknumber(self._curTabIndex) <= 0 then
		self._curTabIndex = MMTeamPassportTabMainView.TabIndex.Passport
	end

	self._pendingTabIndex = nil

	if self._curTabIndex == MMTeamPassportTabMainView.TabIndex.Team and not self:_isPassportInfoReady() then
		self._pendingTabIndex = self._curTabIndex
		self._curTabIndex = MMTeamPassportTabMainView.TabIndex.Passport
	elseif self:_isTeamTabLocked() then
		self._curTabIndex = MMTeamPassportTabMainView.TabIndex.Passport
	end

	self._tabDataList = self:_buildTabDataList()

	self._tabScrollList:reloadData(self._tabDataList)
	self:_showCurTab()
	self.addGEvent(self, GlobalNotify.PassportStateUpdate, self._onPassportStateUpdate, self)
end

function MMTeamPassportTabMainView:onExit()
	MMTeamPassportTabMainView.super.onExit(self)
	self:showTabAt(self._contentCol, "")
	self._tabScrollList:dispose()
end

function MMTeamPassportTabMainView:_buildTabDataList()
	return {
		{
			name = "通行证",
			index = MMTeamPassportTabMainView.TabIndex.Passport,
			viewName = ViewName.MMTeamPassportView,
			redPointIds = TabRedPointIds[MMTeamPassportTabMainView.TabIndex.Passport]
		},
		{
			name = "组队大厅",
			needPay = true,
			index = MMTeamPassportTabMainView.TabIndex.Team,
			viewName = ViewName.MMTeamPassportTeamView,
			redPointIds = TabRedPointIds[MMTeamPassportTabMainView.TabIndex.Team]
		}
	}
end

function MMTeamPassportTabMainView:_updateTabCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local isSelected = self._curTabIndex == data.index
	local isLocked = self:_isTabLocked(data)

	txtName.text = data.name

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.SetActive(redPoint, false)

	if #data.redPointIds > 0 then
		RedPointController.instance:regRedPoint(redPoint, GameUtil.unpack10(data.redPointIds))
	end

	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)
	GameUtil.SetActive(tagLock, isLocked)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data.index))
end

function MMTeamPassportTabMainView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(mainGo)
end

function MMTeamPassportTabMainView:_onClickTab(tabIndex)
	if self._curTabIndex == tabIndex then
		return
	end

	local data = self._tabDataList[tabIndex]

	if self:_isTabLocked(data) then
		if self:_isPassportInfoReady() then
			FloatWordMgr.instance:show("购买通行证后开启")
		else
			FloatWordMgr.instance:show("通行证数据加载中")
		end

		return
	end

	self._curTabIndex = tabIndex

	self._tabScrollList:reloadData(self._tabDataList)
	self:_showCurTab()
end

function MMTeamPassportTabMainView:_showCurTab()
	local data = self._tabDataList[self._curTabIndex]

	if data == nil then
		return
	end

	self._curTabIndex = data.index

	self:showTabAt(self._contentCol, data.viewName)
end

function MMTeamPassportTabMainView:_onPassportStateUpdate()
	if self._pendingTabIndex == MMTeamPassportTabMainView.TabIndex.Team then
		self._pendingTabIndex = nil

		if not self:_isTeamTabLocked() then
			self._curTabIndex = MMTeamPassportTabMainView.TabIndex.Team

			self:_showCurTab()
		end
	end

	if self:_isTeamTabLocked() and self._curTabIndex == MMTeamPassportTabMainView.TabIndex.Team then
		self._curTabIndex = MMTeamPassportTabMainView.TabIndex.Passport

		self:_showCurTab()
	end

	self._tabScrollList:reloadData(self._tabDataList)
end

function MMTeamPassportTabMainView:_isTabLocked(data)
	return data and data.needPay == true and self:_isTeamTabLocked()
end

function MMTeamPassportTabMainView:_isTeamTabLocked()
	local info = PassportModel.instance:getInfo(PassportModel.ID_MMTeamPassport)

	return info == nil or not info.hasPay
end

function MMTeamPassportTabMainView:_isPassportInfoReady()
	return PassportModel.instance:getInfo(PassportModel.ID_MMTeamPassport) ~= nil
end

return MMTeamPassportTabMainView
