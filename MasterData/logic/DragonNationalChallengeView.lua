-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonNationalChallengeView.lua

module("logic.extensions.dragonlords.view.DragonNationalChallengeView", package.seeall)

local DragonNationalChallengeView = class("DragonNationalChallengeView", ViewComponent)

function DragonNationalChallengeView:ctor()
	DragonNationalChallengeView.super.ctor(self)
end

function DragonNationalChallengeView:unbindEvents()
	DragonNationalChallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnFuse:RemoveClickListener()
	self._JackpotBtn:RemoveClickListener()
end

function DragonNationalChallengeView:bindEvents()
	DragonNationalChallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(function()
		self:close()
	end)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "dragonnationalchallengeview_rule")
	end)
	self._JackpotBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "dragonnationalchallengeview_jackpotbtn")
	end)
	self._btnFuse:AddClickListener(self._fuseOnClick, self)
end

function DragonNationalChallengeView:onExit()
	DragonNationalChallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DragonNationalChallenge, self._updateLuckyList, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataDragonLotteryInfo, self._openLotteryEffect, self)
	RedPointController.instance:unregRedPoint(self._fuseRedPoint)
	UIEffectManager.instance:stopEffect(self._fuseEff)

	self._fuseEff = nil
end

function DragonNationalChallengeView:buildUI()
	DragonNationalChallengeView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnFuse = self:getBtn("btnFuse")
	self._btnClose = self:getBtn("btnClose")
	self._JackpotBtn = self:getBtn("JackpotBtn")
	self._nobodyTxt = self:getGo("luckyRankGo/nobodyTxt")
	self._luckyItem = self:getGo("luckyRankGo/luckyItem")
	self._luckyListSR = self:getGo("luckyRankGo/luckyListSR")
	self._fuseRedPoint = self:getGo("btnFuse/redPoint")
	self._effectObj = self:getGo("con")
	self._fuseTxt = self:getTxt("btnFuse/txtReward")
	self._btnChallenges = {}

	for i = 1, 3 do
		local cls = {}

		cls.go = self:getGo("btnChallenge" .. i)
		cls.btn = self:getBtn("btnChallenge" .. i)
		cls.txt = goutil.findChildTextComponent(cls.go, "txtReward")

		table.insert(self._btnChallenges, cls)
	end

	self._luckyRank = ScrollerList.create(self._luckyListSR, self._luckyItem, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._luckyRank:regGetCellSize(function()
		return 224, 32
	end)
end

function DragonNationalChallengeView:onEnter()
	DragonNationalChallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DragonNationalChallenge, self._updateLuckyList, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataDragonLotteryInfo, self._openLotteryEffect, self)

	self._actId = DrogonLordsModel.instance:getActivityId()

	if self._actId <= 0 then
		UIStateManager.instance:clear()
		FloatWordMgr.instance:show("活动已经结束")

		return
	end

	DragonRespectChallengeAgent.instance:sendPM_UniversalChallengeInfoReq(self._actId)
	RedPointController.instance:regRedPoint(self._fuseRedPoint, RedPointModel.ID_LONGZUN_CHALLENGE)
end

function DragonNationalChallengeView:_btnChallengesOnClick()
	local info = DrogonLordsModel.instance:getNormalInfo()
	local cfg = DragonLordsConfig.instance:getAllPeopleChallengeInfo()
	local maxFuseTime = DragonLordsConfig.instance:getCommonCfg("FUSION_DAILY_TIMES")

	for i, v in ipairs(info.infos) do
		if self._btnChallenges[v.challengeId] then
			self._btnChallenges[v.challengeId].challengeId = v.challengeId
			self._btnChallenges[v.challengeId].dailyMaxSocre = v.dailyMaxSocre
		end
	end

	for i, v in ipairs(self._btnChallenges) do
		v.btn:RemoveClickListener()
		v.btn:AddClickListener(function()
			if cfg[v.challengeId].scoreLimit > v.dailyMaxSocre then
				UIStateManager.instance:push(ViewName.DragonChallengeView, v.challengeId, v.dailyMaxSocre)
			else
				FloatWordMgr.instance:show("该关卡今日已经达到最高分数")
			end
		end)

		v.txt.text = string.format("今日获得:%s/%s", v.dailyMaxSocre, cfg[v.challengeId].scoreLimit)
	end

	self._fuseTxt.text = string.format("今日融合:%s/%s", maxFuseTime - info.fusionTimes, maxFuseTime)
end

function DragonNationalChallengeView:_updateTabCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local img = cell.gameObject:GetComponent("UIImageColorChange")
	local parity = DragonLordsController.instance:jugdeParity(cell.index)

	img:SetState(parity)

	nameTxt.text = data
end

function DragonNationalChallengeView:_clearTabCell(cell)
	return
end

function DragonNationalChallengeView:_updateLuckyList()
	local info = DrogonLordsModel.instance:getNormalInfo()
	local limitCount = checknumber(DragonLordsConfig.instance:getCommonCfg("SHOW_RANK_NUM"))
	local list = {}

	for i, v in ipairs(info.userNamesOfRank) do
		if limitCount < i then
			break
		end

		table.insert(list, v)
	end

	self._luckyRank:reloadData(list)
	goutil.setActive(self._nobodyTxt, #info.userNamesOfRank <= 0)
	self:_btnChallengesOnClick()
end

function DragonNationalChallengeView:_fuseOnClick()
	local info = DrogonLordsModel.instance:getNormalInfo()
	local limitTimes = DragonLordsConfig.instance:getCommonCfg("FUSION_DAILY_TIMES")

	for k, v in pairs(info.infos) do
		if v.dailyMaxSocre and v.dailyMaxSocre <= 0 then
			FloatWordMgr.instance:show("需要进行3种挑战并产生积分才可以开始融合")

			return
		end
	end

	if info and info.fusionTimes < checknumber(limitTimes) then
		DragonLordsController.instance:sendPM_UniversalChallengeFusionReq(self._actId)
	else
		FloatWordMgr.instance:show("融合次数用尽")
	end
end

function DragonNationalChallengeView:_openLotteryEffect()
	local function finishFunc()
		changeSetId = DrogonLordsModel.instance:getChangeSetId()
		itemData = DrogonLordsModel.instance:getLastDrawItems()

		if itemData and #itemData > 0 then
			UIStateManager.instance:push(ViewName.DragonBallView, function()
				MaterialController.instance:showChangeSetItemMo(itemData, changeSetId)
			end)
		end

		goutil.setActive(self._effectObj, false)
	end

	goutil.setActive(self._effectObj, true)

	self._fuseEff = UIEffectManager.instance:playEffect(self, "20220930/longzuntiaozhan/fx_longzuntiaozhan_ronghe.prefab", self._effectObj.transform, 0, 0, false, false, finishFunc)

	self._fuseEff:setParent(self._effectObj.transform)
	self._fuseEff:setScale(1)
	self._fuseEff:setLocalPos(0, 0, 0)
end

return DragonNationalChallengeView
