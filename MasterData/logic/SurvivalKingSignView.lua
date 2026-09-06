-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingSignView.lua

module("logic.extensions.survivalking.view.SurvivalKingSignView", package.seeall)

local SurvivalKingSignView = class("SurvivalKingSignView", ViewComponent)

function SurvivalKingSignView:ctor()
	SurvivalKingSignView.super.ctor(self)
end

function SurvivalKingSignView:unbindEvents()
	SurvivalKingSignView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SurvivalKingSignView:bindEvents()
	SurvivalKingSignView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SurvivalKingSignView:buildUI()
	SurvivalKingSignView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtLeftTime = self:getTxt("txtLeftTime")

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SurvivalKingSignView:onExit()
	SurvivalKingSignView.super.onExit(self)
	self._tableView:dispose()
end

function SurvivalKingSignView:onEnter()
	SurvivalKingSignView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGetBaseInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingSignUp, self._updateUIByInfo, self)

	self._activityId = 529001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	SurvivalKingController.instance:getBaseInfo(self._activityId)
end

function SurvivalKingSignView:_updateUIByCfg()
	local cfgs = SurvivalKingConfig.instance:getAllSessionCfg(self._activityId) or {}

	self._curDataList = {}

	for sessionId, cfg in ipairs(cfgs) do
		table.insert(self._curDataList, cfg)
	end

	self._actCfg = SurvivalKingConfig.instance:getActivityCfg(self._activityId)
end

function SurvivalKingSignView:_updateUIByInfo()
	self._hasSignInTime = 0
	self._curSignMap = {}
	self._curSerssionId = 0

	local sessionCfg, isInProgress = SurvivalKingController.instance:getCurSessionCfg(self._activityId)

	if sessionCfg then
		self._curSerssionId = sessionCfg.sessionId or 0

		if not isInProgress then
			self._curSerssionId = self._curSerssionId - 1
		end
	else
		local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

		if timeStatus == SurvivalKingConfig.NotOpen then
			self._curSerssionId = 0
		elseif timeStatus == SurvivalKingConfig.Ended then
			self._curSerssionId = #self._curDataList
		end
	end

	local info = SurvivalKingModel.instance:getBaseInfo(self._activityId)

	if info then
		if not info.signUps then
			for _, signUp in ipairs(info.signUps) do
				self._curSignMap[signUp.sessionId] = signUp.signUp

				if signUp.signUp == true then
					self._hasSignInTime = self._hasSignInTime + 1
				end
			end
		end
	end

	self._tableView:reloadData(self._curDataList)
	self._tableView:MoveCellToBegin(self._curSerssionId)

	self._txtLeftTime.text = string.format("今日奖励次数：<color=#58ff68>%d</color>/%d", Mathf.Max(self._actCfg.prizeTimes - self._hasSignInTime, 0), self._actCfg.prizeTimes)
end

function SurvivalKingSignView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local markFinish = goutil.findChild(go, "markFinish")
	local markTog = goutil.findChild(go, "btnTog/mark")
	local btnTog = goutil.findChild(go, "btnTog")

	txtName.text = data.sessionName or ""

	goutil.setActive(markFinish, data.sessionId <= self._curSerssionId)
	goutil.setActive(btnTog, data.sessionId > self._curSerssionId)
	goutil.setActive(markTog, self._curSignMap[data.sessionId] == true)
	GameUtil.addClickHandler(btnTog, GameUtil.handler(self._onClickTog, self, data.sessionId))
end

function SurvivalKingSignView:_onClickTog(sessionId)
	local isSign = self._curSignMap[sessionId] == true

	self._curSignMap[sessionId] = not isSign

	self._tableView:reloadData(self._curDataList)
end

function SurvivalKingSignView:_clearCell(cell)
	return
end

function SurvivalKingSignView:_onClickSure()
	if SurvivalKingModel.instance:isAllEmptyForm(self._activityId) then
		TipsFacade.instance:openCommonTips("请先预设守阵")

		return
	end

	local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

	if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
		TipsFacade.instance:openCommonTips("当前不在报名时间内")

		return
	end

	local signInfos = self:getCurSignInfos()

	SurvivalKingController.instance:sendSignUpReq(self._activityId, signInfos)
end

function SurvivalKingSignView:getCurSignInfos()
	local signInfos = {}

	for sessionId, value in pairs(self._curDataList) do
		if sessionId > self._curSerssionId then
			local info = {}

			info.sessionId = sessionId
			info.signUp = self._curSignMap[sessionId] or false

			table.insert(signInfos, info)
		end
	end

	return signInfos
end

return SurvivalKingSignView
