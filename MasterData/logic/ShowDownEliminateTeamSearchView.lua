-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateTeamSearchView.lua

module("logic.extensions.showdown.view.ShowDownEliminateTeamSearchView", package.seeall)

local ShowDownEliminateTeamSearchView = class("ShowDownEliminateTeamSearchView", ViewComponent)

function ShowDownEliminateTeamSearchView:ctor()
	ShowDownEliminateTeamSearchView.super.ctor(self)
end

function ShowDownEliminateTeamSearchView:bindEvents()
	ShowDownEliminateTeamSearchView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnLeft:AddClickListener(self._onClickLeft, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
	self._btnInput:AddClickListener(self._onClickInput, self)
	self._btnJump:AddClickListener(self._onClickJump, self)
	self._btnSearch:AddClickListener(self._onClickSearch, self)
end

function ShowDownEliminateTeamSearchView:unbindEvents()
	ShowDownEliminateTeamSearchView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnInput:RemoveClickListener()
	self._btnJump:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
end

function ShowDownEliminateTeamSearchView:buildUI()
	ShowDownEliminateTeamSearchView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._colSearch = self:getGo("colSearch")
	self._input = self:getInput("colSearch/InputField")
	self._btnCancel = self:getBtn("colSearch/InputField/btnCancel")
	self._btnSearch = self:getBtn("colSearch/btnSearch")
	self._colResult = self:getGo("colResult")
	self._btnLeft = self:getBtn("colResult/btnLeft")
	self._btnRight = self:getBtn("colResult/btnRight")
	self._btnInput = self:getBtn("colResult/btnInput")
	self._btnJump = self:getBtn("colResult/btnJump")
	self._groupCell = self:getGo("colResult/groupCell")
	self._teamIcon = goutil.findChild(self._groupCell, "teamIcon")
	self._iconLeader = goutil.findChild(self._teamIcon, "icon")
	self._txtName = goutil.findChildTextComponent(self._groupCell, "txtName")
	self._txtScore = goutil.findChildTextComponent(self._groupCell, "txtScore")
	self._txtCount = goutil.findChildTextComponent(self._groupCell, "txtCount")
	self._iconHeat = goutil.findChild(self._groupCell, "icon")
end

function ShowDownEliminateTeamSearchView:onEnter()
	ShowDownEliminateTeamSearchView.super.onEnter(self)

	self._activityId = checkint(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_SearchTeamRes, self._onGetSearchResults, self)

	self._mo = ShowDownController.instance:getShowDownMo(self._activityId)

	local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
	local spriteName = string.format("%s.png", heatIconPath)

	uGuiUtil.setSpriteToImage(self._iconHeat, uGuiUtil.SpriteType.BigBg, spriteName)
	self:_onClickInput()
end

function ShowDownEliminateTeamSearchView:onExit()
	ShowDownEliminateTeamSearchView.super.onExit(self)
	uGuiUtil.clearImage(self._teamIcon)
	HeadItemController.instance:resetHeadCell(self._iconLeader)
	uGuiUtil.clearImage(self._iconHeat)
end

function ShowDownEliminateTeamSearchView:_onClickCancel()
	self._input:SetText("")
end

function ShowDownEliminateTeamSearchView:_onClickLeft()
	self._showId = self._showId - 1

	goutil.setActive(self._btnLeft.gameObject, self._showId > 1)
	goutil.setActive(self._btnRight.gameObject, self._showId + 1 <= #self._searchResults)
	self:_updateGroupCell(self._searchResults[self._showId])
end

function ShowDownEliminateTeamSearchView:_onClickRight()
	self._showId = self._showId + 1

	goutil.setActive(self._btnRight.gameObject, self._showId + 1 <= #self._searchResults)
	goutil.setActive(self._btnLeft.gameObject, self._showId > 1)

	if self._showId >= #self._searchResults and not self._isGetAllSearchResult then
		local keyWord = self._input:GetText()

		ShowDownController.instance:sendPM_ShowDownTeam_SearchTeamReq(self._activityId, keyWord, self._searchStartId, self._searchEndId)
	end

	self:_updateGroupCell(self._searchResults[self._showId])
end

function ShowDownEliminateTeamSearchView:_onClickInput()
	self._input:SetText("")
	self._mo:resetSearchResultParams()

	self._showId = 1

	goutil.setActive(self._colResult, false)
	goutil.setActive(self._colSearch, true)
	goutil.setActive(self._btnLeft.gameObject, false)

	self._showInfo = nil
end

function ShowDownEliminateTeamSearchView:_onClickJump()
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.ShowDownEliminateJumpGroup, self._showInfo.groupId)
end

function ShowDownEliminateTeamSearchView:_updateGroupCell(info)
	if info and info ~= self._showInfo then
		self._showInfo = info
		self._txtScore.text = info.heatValue
		self._txtName.text = info.teamInfo.teamName
		self._txtCount.text = string.format("%s/%s", info.memberCount, 5)

		uGuiUtil.clearImage(self._teamIcon)
		HeadItemController.instance:resetHeadCell(self._iconLeader)

		local iconData = ShowDownConfig.instance:getTeamIconData(self._activityId, info.teamInfo.teamLogo)

		if iconData then
			local path = GameUrl.getItemIconUrl(iconData.iconPath)

			if not GameUtil.isEmptyString(path) then
				uGuiUtil.setSpriteToImage(self._teamIcon, uGuiUtil.SpriteType.BigBg, path)
			end
		end

		HeadItemController.instance:setHeadCellByInfo(self._iconLeader, info.leaderHeadInfo)
	end
end

function ShowDownEliminateTeamSearchView:_onGetSearchResults()
	self._searchResults, self._searchStartId, self._searchEndId, self._isGetAllSearchResult = self._mo:getSearchResultParams()

	if self._searchResults and #self._searchResults > 0 then
		goutil.setActive(self._colResult, true)
		goutil.setActive(self._colSearch, false)
		goutil.setActive(self._btnRight.gameObject, #self._searchResults > self._showId)
		self:_updateGroupCell(self._searchResults[self._showId])
	else
		FloatWordMgr.instance:show("未找到匹配对象")
	end
end

function ShowDownEliminateTeamSearchView:_onClickSearch()
	local keyWord = self._input:GetText()

	if GameUtil.isEmptyString(keyWord) then
		FloatWordMgr.instance:show("不可为空")

		return
	end

	ShowDownController.instance:sendPM_ShowDownTeam_SearchTeamReq(self._activityId, keyWord, -1, -1)
end

return ShowDownEliminateTeamSearchView
