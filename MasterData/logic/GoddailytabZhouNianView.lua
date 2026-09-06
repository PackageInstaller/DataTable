-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/view/GoddailytabZhouNianView.lua

module("logic.extensions.goddailyrank.view.GoddailytabZhouNianView", package.seeall)

local GoddailytabZhouNianView = class("GoddailytabZhouNianView", GoddailytabView)

function GoddailytabZhouNianView:onEnter()
	GoddailytabZhouNianView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._type = checknumber(params[2])

	self.addGEvent(self, GlobalNotify.GODDAILYRANK_ZHOUNIAN_GODRANKVIEW_INFO, self._onRrefreshUI, self)
	OriginDragonAryaClgAgent.instance:sendPM_OriginDragonAryaClgViewAnnuityGodRankReq(self._activityId)
	self:_onRrefreshUI()
end

function GoddailytabZhouNianView:_onRrefreshUI()
	self._info = OriginLongzhuModel.instance:getGodRankInfo(self._activityId) or {}

	local rankInfoList = {}
	local myRank = -1
	local myScore = 0

	if self._info and not GodDailyRankController.instance:isGodRankClosed(self._activityId) then
		rankInfoList = self._info.rankInfoList or {}
		myRank = checknumber(self._info.myRank)
		myScore = checknumber(self._info.myScore)
	end

	self._scrollList:reloadData(rankInfoList)
	GameUtil.SetActive(self._emptyGo, #rankInfoList == 0)

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
	self._txtMyValue.text = myScore

	local config = OriginLongzhuConfig.instance:getActCfgById(self._activityId) or {}

	self._txtTip.text = config.txtTipsGod
end

return GoddailytabZhouNianView
