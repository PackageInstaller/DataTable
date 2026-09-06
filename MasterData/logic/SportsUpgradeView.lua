-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/SportsUpgradeView.lua

module("logic.extensions.birthdaysportswish.view.SportsUpgradeView", package.seeall)

local SportsUpgradeView = class("SportsUpgradeView", SummarySubTabView)

function SportsUpgradeView:ctor()
	SportsUpgradeView.super.ctor(self)
end

function SportsUpgradeView:unbindEvents()
	SportsUpgradeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJumpToPeak)
end

function SportsUpgradeView:bindEvents()
	SportsUpgradeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJumpToPeak, self._onClickTips, self)
end

function SportsUpgradeView:buildUI()
	SportsUpgradeView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._btnJumpToPeak = self:getBtn("tip/btnGoto")
	self._txtTips = self:getTxt("tip/txtDesc")
	self._goItem = self:getGo("tip/item")
end

function SportsUpgradeView:onExit()
	SportsUpgradeView.super.onExit(self)
	MaterialMgr.resetAll(self._goItem)
end

function SportsUpgradeView:onEnter()
	SportsUpgradeView.super.onEnter(self)

	local cfgs = XiaonuoBirthConfig.instance:getTabList(self:thisActId())

	if cfgs[self:getTabId()] then
		self:_initView(cfgs[self:getTabId()])
	end
end

function SportsUpgradeView:_initView(data)
	self._txtTime.text = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIME_LIMIT")

	if data and not string.nilorempty(data.limitTime) then
		local arr = string.split(data.limitTime, "#")

		if #arr == 2 then
			local startTime = GameUtil.parseToTimeTable(arr[1])
			local endTime = GameUtil.parseToTimeTable(arr[2])
			local content = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIME_LIMIT_EXT")

			self._txtTime.text = langPara(content, startTime.month, startTime.day, startTime.hour, startTime.sec, endTime.month, endTime.day, endTime.hour, endTime.sec)
		end
	end

	local matList = string.split(XiaonuoBirthConfig.instance:getCommonValue("SPORT_SUP_GRADE_ITEM"), ":")
	local matType, matId = matList[1], matList[2]

	self._txtTips.text = XiaonuoBirthConfig.instance:getCommonValue("SPORT_SUP_GRADE_TXT")

	local proxy = MaterialMgr.setCell(matType, matId, self._goItem)
end

function SportsUpgradeView:_onClickTips()
	local jumpto = XiaonuoBirthConfig.instance:getCommonValue("SPORT_SUP_GRADE_JUMP")

	GotoMgr.gotoByString(jumpto)
end

return SportsUpgradeView
