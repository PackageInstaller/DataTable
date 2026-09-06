-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionMainView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionMainView", package.seeall)

local GoddessCompetitionMainView = class("GoddessCompetitionMainView", TabFrameWorkMainView)
local StepCompetionHeadId = 1

function GoddessCompetitionMainView:ctor()
	GoddessCompetitionMainView.super.ctor(self)
end

function GoddessCompetitionMainView:unbindEvents()
	GoddessCompetitionMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
end

function GoddessCompetitionMainView:bindEvents()
	GoddessCompetitionMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
end

function GoddessCompetitionMainView:buildUI()
	GoddessCompetitionMainView.super.buildUI(self)

	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._line = self:getGo("tabCol/tabScrollerview/Viewport/line")
	self._Content = self:getGo("tabCol/tabScrollerview/Viewport/Content")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._goldBarCon = self:getGo("goldBarCon")
end

function GoddessCompetitionMainView:onExit()
	GoddessCompetitionMainView.super.onExit(self)
	removetimer(self._forceUpateLine, self)
end

function GoddessCompetitionMainView:onEnter()
	local params = self:getOpenParam()

	self._activityId = checknumber(self:getFirstParam())

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetBaseInfoRes, self._updateUIByInfo, self)
	GoddessCompetitionModel.instance:setCurActId(self._activityId)
	GoddessCompetitionController.instance:getInfo(self._activityId)
	GoddessCompetitionMainView.super.onEnter(self)
end

function GoddessCompetitionMainView:_updateUIByCfg()
	self._actCfg = GoddessCompetitionConfig.instance:getActCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_showGoldBar()
end

function GoddessCompetitionMainView:_updateUIByInfo()
	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()

	self._curStepId = baseInfo.curStepId

	self:_onUpdate()
end

function GoddessCompetitionMainView:_showGoldBar()
	local objList = {
		{
			showAdd = true,
			id = self._actCfg.voteItem
		},
		{
			showAdd = true,
			id = self._actCfg.exchangeItem
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function GoddessCompetitionMainView:_onClickBtnRank()
	GoddessCompetitionController.instance:openCommonTabListRank(self._activityId, nil)
end

function GoddessCompetitionMainView:_onClickBtnShop()
	GotoMgr.gotoByString(self._actCfg.jumpShopStr)
end

function GoddessCompetitionMainView:_getFrameId()
	return self._activityId
end

function GoddessCompetitionMainView:_updateHeadTabCell(mainGo, headTabIndex)
	GoddessCompetitionMainView.super._updateHeadTabCell(self, mainGo, headTabIndex)

	local select = goutil.findChild(mainGo, "select")
	local unSelect = goutil.findChild(mainGo, "unSelect")

	GameUtil.SetActive(select, self._curHeadTabIndex == headTabIndex)
	GameUtil.SetActive(unSelect, self._curHeadTabIndex ~= headTabIndex)
end

function GoddessCompetitionMainView:_updateSecTabCell(mainGo, headTabIndex, secTabIndex)
	GoddessCompetitionMainView.super._updateSecTabCell(self, mainGo, headTabIndex, secTabIndex)

	local onlyselect = goutil.findChild(mainGo, "onlyselect")

	GameUtil.SetActive(onlyselect, self._curHeadTabIndex == headTabIndex and self._curSecTabIndex == secTabIndex)
end

function GoddessCompetitionMainView:_isUnlockByExCondAsSecTab(headTabId, secTabId)
	if StepCompetionHeadId == headTabId then
		local stepId = secTabId

		return stepId <= checknumber(self._curStepId)
	end

	return true
end

function GoddessCompetitionMainView:_onUpdateTabColUI()
	GoddessCompetitionMainView.super._onUpdateTabColUI(self)
	settimer(0, self._forceUpateLine, self, false)
end

function GoddessCompetitionMainView:_forceUpateLine()
	local getHeight = GameUtil.getHeight(self._Content)

	GameUtil.setHeight(self._line, getHeight - 60)
	GameUtil.setAnchoredPos(self._line, -64, -getHeight / 2)
end

function GoddessCompetitionMainView:_getDefaultSecTabIndex(headTabIndex)
	if headTabIndex == StepCompetionHeadId and checknumber(self._curStepId) > 0 then
		return self._curStepId
	end

	return 1
end

function GoddessCompetitionMainView:_clickHeadTabCell(headTabIndex)
	local headInfo = self:_getHeadTabViewInfo(headTabIndex)

	GoddessCompetitionMainView.super._clickHeadTabCell(self, headTabIndex)

	if headInfo.isUnlock and (self._curSecTabIndex ~= 3 or self._curHeadTabIndex ~= 3) then
		self:_showGoldBar()
	end
end

function GoddessCompetitionMainView:_onClickBtnClose()
	GoddessCompetitionModel.instance:resetRandSortMap()
	GoddessCompetitionMainView.super._onClickBtnClose(self)
end

return GoddessCompetitionMainView
