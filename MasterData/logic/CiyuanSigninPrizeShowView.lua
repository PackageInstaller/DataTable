-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/view/CiyuanSigninPrizeShowView.lua

module("logic.extensions.ciyuansignin.view.CiyuanSigninPrizeShowView", package.seeall)

local CiyuanSigninPrizeShowView = class("CiyuanSigninPrizeShowView", ViewComponent)

function CiyuanSigninPrizeShowView:ctor()
	CiyuanSigninPrizeShowView.super.ctor(self)
end

function CiyuanSigninPrizeShowView:unbindEvents()
	CiyuanSigninPrizeShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CiyuanSigninPrizeShowView:bindEvents()
	CiyuanSigninPrizeShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CiyuanSigninPrizeShowView:buildUI()
	CiyuanSigninPrizeShowView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._itemTablecell = self:getGo("itemTablecell")
	self._rewardView_1 = self:getGo("tablecell_3/rewardView")
	self._rewardView_2 = self:getGo("tablecell_1/rewardView")
	self._rewardView_3 = self:getGo("tablecell_2/rewardView")
	self._rewardTableList_1 = ScrollerList.create(self._rewardView_1, self._itemTablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._rewardTableList_2 = ScrollerList.create(self._rewardView_2, self._itemTablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._rewardTableList_3 = ScrollerList.create(self._rewardView_3, self._itemTablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function CiyuanSigninPrizeShowView:onExit()
	CiyuanSigninPrizeShowView.super.onExit(self)
end

function CiyuanSigninPrizeShowView:onEnter()
	CiyuanSigninPrizeShowView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local firstTypeRewardCfg = CiyuanSigninConfig.instance:getSignRewardCfg(self._activityId, 1, 21)

	if firstTypeRewardCfg then
		local prizeArr = string.split(firstTypeRewardCfg.prize, "#")

		self._rewardTableList_1:reloadData(prizeArr)
	end

	local sceondTypeRewardCfg = CiyuanSigninConfig.instance:getSignRewardCfg(self._activityId, 2, 21)

	if sceondTypeRewardCfg then
		local prizeArr = string.split(sceondTypeRewardCfg.prize, "#")

		self._rewardTableList_2:reloadData(prizeArr)
	end

	local thirdTypeRewardCfg = CiyuanSigninConfig.instance:getSignRewardCfg(self._activityId, 3, 21)

	if thirdTypeRewardCfg then
		local prizeArr = string.split(thirdTypeRewardCfg.prize, "#")

		self._rewardTableList_3:reloadData(prizeArr)
	end
end

function CiyuanSigninPrizeShowView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "prizeCon")

	MaterialMgr.setCellByCfg(data, con)
end

function CiyuanSigninPrizeShowView:_clearRewardCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "prizeCon")

	MaterialMgr.resetAll(con)
end

return CiyuanSigninPrizeShowView
