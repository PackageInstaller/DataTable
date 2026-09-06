-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRankView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRankView", package.seeall)

local GoddessCompetitionRankView = class("GoddessCompetitionRankView", TabFrameWorkMainView)

function GoddessCompetitionRankView:ctor()
	GoddessCompetitionRankView.super.ctor(self)
end

function GoddessCompetitionRankView:destroyUI()
	GoddessCompetitionRankView.super.destroyUI(self)
end

function GoddessCompetitionRankView:buildUI()
	GoddessCompetitionRankView.super.buildUI(self)

	self._line = self:getGo("tabCol/tabScrollerview/Viewport/line")
	self._Content = self:getGo("tabCol/tabScrollerview/Viewport/Content")
end

function GoddessCompetitionRankView:bindEvents()
	GoddessCompetitionRankView.super.bindEvents(self)
end

function GoddessCompetitionRankView:unbindEvents()
	GoddessCompetitionRankView.super.unbindEvents(self)
end

function GoddessCompetitionRankView:onEnter()
	self._activityId = 453001

	GoddessCompetitionRankView.super.onEnter(self)
end

function GoddessCompetitionRankView:onExit()
	GoddessCompetitionRankView.super.onExit(self)
	removetimer(self._forceUpateLine, self)
end

function GoddessCompetitionRankView:_getFrameId()
	return 9
end

function GoddessCompetitionRankView:_onUpdateContentColUI()
	self:_onClearContentCol()

	local info

	if self._curHeadTabIndex > 0 then
		info = self._curSecTabIndex > 0 and self:_getSecTabViewInfo(self._curHeadTabIndex, self._curSecTabIndex) or self:_getHeadTabViewInfo(self._curHeadTabIndex)
	else
		return
	end

	local viewName = info.data.viewName

	if string.nilorempty(viewName) then
		return
	end

	if self._oldHeadTabIndex and self._oldHeadTabIndex == self._curHeadTabIndex and self._oldSecTabIndex and self._oldSecTabIndex == self._curSecTabIndex then
		return
	else
		self._oldHeadTabIndex = self._curHeadTabIndex
		self._oldSecTabIndex = self._curSecTabIndex
	end

	local params

	if not string.nilorempty(info.data.params) then
		params = string.split(info.data.params, "#")
	end

	if params then
		self:showTabAt(self._contentCol, viewName, self._activityId, unpack(params))
	else
		self:showTabAt(self._contentCol, viewName, self._activityId)
	end

	SurveyController.instance:reportBehavior(checknumber(info.data.reportBehavior))
end

function GoddessCompetitionRankView:_getDefaultHeadTabIdOfJump()
	if self:_getFrameParams().headTabIdOfJump ~= 0 then
		return self:_getFrameParams().headTabIdOfJump
	else
		return 1
	end
end

function GoddessCompetitionRankView:_getDefaultSecTabIdOfJump()
	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()

	if self:_getFrameParams().secTabIdOfJump ~= 0 then
		return self:_getFrameParams().secTabIdOfJump
	elseif baseInfo then
		return baseInfo.curStepId
	else
		return self:_getFrameParams().secTabIdOfJump
	end
end

function GoddessCompetitionRankView:_onUpdateTabColUI()
	GoddessCompetitionRankView.super._onUpdateTabColUI(self)
	settimer(0, self._forceUpateLine, self, false)
end

function GoddessCompetitionRankView:_forceUpateLine()
	local getHeight = GameUtil.getHeight(self._Content)

	GameUtil.setHeight(self._line, getHeight - 60)
	GameUtil.setAnchoredPos(self._line, -64, -getHeight / 2)
end

function GoddessCompetitionRankView:_updateHeadTabCell(mainGo, headTabIndex)
	GoddessCompetitionRankView.super._updateHeadTabCell(self, mainGo, headTabIndex)

	local select = goutil.findChild(mainGo, "select")
	local unSelect = goutil.findChild(mainGo, "unSelect")

	GameUtil.SetActive(select, self._curHeadTabIndex == headTabIndex)
	GameUtil.SetActive(unSelect, self._curHeadTabIndex ~= headTabIndex)
end

function GoddessCompetitionRankView:_updateSecTabCell(mainGo, headTabIndex, secTabIndex)
	GoddessCompetitionRankView.super._updateSecTabCell(self, mainGo, headTabIndex, secTabIndex)

	local onlyselect = goutil.findChild(mainGo, "onlyselect")

	GameUtil.SetActive(onlyselect, self._curHeadTabIndex == headTabIndex and self._curSecTabIndex == secTabIndex)
end

return GoddessCompetitionRankView
