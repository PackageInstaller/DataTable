-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyCallOrderView.lua

module("logic.extensions.newfamily.view.FamilyCallOrderView", package.seeall)

local FamilyCallOrderView = class("FamilyCallOrderView", ViewComponent)

function FamilyCallOrderView:ctor()
	FamilyCallOrderView.super.ctor(self)

	self._playerItemList = {}
	self._gainedProgressPrizeIds = {}
end

function FamilyCallOrderView:unbindEvents()
	FamilyCallOrderView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._btnRules:RemoveClickListener()
	self._previewBtn:RemoveClickListener()
	self._rankingListBtn:RemoveClickListener()
end

function FamilyCallOrderView:bindEvents()
	FamilyCallOrderView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._btnRules:AddClickListener(self._onClickbtnRule, self)
	self._previewBtn:AddClickListener(self._openRewardPreview, self)
	self._rankingListBtn:AddClickListener(self._openRankingList, self)
end

function FamilyCallOrderView:onExit()
	FamilyCallOrderView.super.onExit(self)
	self:_clearRewardList()

	self._gainedProgressPrizeIds = {}

	GlobalDispatcher:removeListener(GlobalNotify.FamilyCallOrder, self._updateRankData, self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilyRankData, self._updateTopThreeFamily, self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilyCallOrderPrize, self._updtaeProgressPrize, self)
	FamilyCallOrderModel.instance:clearAllInfo()
	self:_clearAllInfo()
end

function FamilyCallOrderView:buildUI()
	FamilyCallOrderView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btn_close")
	self._btnRules = self:getBtn("topleft/btnRules")
	self._previewBtn = self:getBtn("bottomleft/previewBtn")
	self._rankingListBtn = self:getBtn("bottomleft/rankingListBtn")
	self._familySilder = self:getSlider("bottom/playerReward/tableview/viewport/content/progressSlider")
	self._tableView = self:getGo("bottom/playerReward/tableview"):GetComponent(goutil.Type_RectTransform)
	self._playercell = self:getGo("bottom/playerReward/playercell")
	self._rankingScroeTxt = self:getTxt("left/ranking")
	self._familyScoreTxt = self:getTxt("left/familyScore")
	self._highsetScoreTxt = self:getTxt("center/allScore/highsetScore")
	self._currentScoreTxt = self:getTxt("center/allScore/currentScore")
	self._personalScoreTxt = self:getTxt("center/allScore/personalScore")
	self._activityTime = self:getTxt("topRight/activityTimeBG/activityTime")
	self._txtfamilyScore = self:getTxt("bottom/txt/txtNumber")
	self._first = self:getGo("left/first")
	self._second = self:getGo("left/second")
	self._third = self:getGo("left/third")
	self._playerContentRectTrans = self:getGo("bottom/playerReward/tableview/viewport/content"):GetComponent(goutil.Type_RectTransform)
	self._playerSliderRectTrans = self._familySilder.gameObject:GetComponent(goutil.Type_RectTransform)

	local px, py = Framework.TransformUtil.GetAnchoredPos(self._playerSliderRectTrans, 0, 0)

	self._playerSliderStartOffset = py
	self._playerSliderEndOffset = 50
	self._playerWidthSpace = 135
end

function FamilyCallOrderView:onEnter()
	FamilyCallOrderView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyCallOrder, self._updateRankData, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyRankData, self._updateTopThreeFamily, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyCallOrderPrize, self._updtaeProgressPrize, self)
	self:_initPlayerReward()
	self:_sendAllReq()
	self:_redPointState()

	self._activityTime.text = "活动时间: 04月29日5:00-06月02日5:00"
end

function FamilyCallOrderView:_redPointState()
	if GameUtil.getUserDayData("ID_FAMILYCALLORDER") == nil then
		GameUtil.saveUserDayData("ID_FAMILYCALLORDER", 1)
	end
end

function FamilyCallOrderView:_onClickClose()
	self:close()
end

function FamilyCallOrderView:_openRewardPreview()
	UIStateManager.instance:push(ViewName.FamilyRankRewardView)
end

function FamilyCallOrderView:_openRankingList()
	if FamilyController.instance:isHasFamily() then
		UIStateManager.instance:push(ViewName.FamilyRankView)
	else
		TipsFacade.instance:openTipWindow(lang("tip"), "请先加入一个家族", function()
			return
		end, "确定")
	end
end

function FamilyCallOrderView:_onClickbtnRule()
	TipsFacade.instance:openRulesView("familycallorderview")
end

function FamilyCallOrderView:_setPlayerContentLength(rewardCount)
	local sliderLength = rewardCount * self._playerWidthSpace
	local contentTotalLength = self._playerSliderStartOffset + sliderLength + self._playerSliderEndOffset

	goutil.setWidth(self._playerContentRectTrans, contentTotalLength)
	goutil.setWidth(self._playerSliderRectTrans, sliderLength)
end

function FamilyCallOrderView:_setPlayerScore(Score)
	local maxScore = FamilyCallOrderConfig.instance:getPrizeMaxScore(self._progressPrizePlanId)
	local curScore = Score or 0
	local cfgs = FamilyCallOrderConfig.instance:getProgressCfgById(self._progressPrizePlanId)
	local progress = self:_getSilderValue(curScore, cfgs)

	self._familySilder:SetValue(progress)

	self._txtfamilyScore.text = curScore
end

function FamilyCallOrderView:_getSilderValue(curScore, progressPrizeDatas)
	if progressPrizeDatas then
		if not #progressPrizeDatas then
			local count = 0

			if count == 0 or curScore <= 0 then
				return 0
			end

			local once = 1 / count
			local value = 0

			for i = 1, count do
				if progressPrizeDatas[i] then
					if curScore >= progressPrizeDatas[i].score then
						value = value + once
					else
						local syc = 0

						if progressPrizeDatas[i - 1] and progressPrizeDatas[i - 1].score > 0 then
							syc = progressPrizeDatas[i - 1].score
						end

						local temp = (curScore - syc) * once / (progressPrizeDatas[i].score - syc)

						value = value + temp

						break
					end
				end
			end

			return value
		end
	end
end

function FamilyCallOrderView:_initPlayerReward()
	table.clear(self._playerItemList)

	local activityInfo = FamilyCallOrderConfig.instance:getPlanIdInfo()

	if activityInfo then
		self._progressPrizePlanId = activityInfo.progressPrizePlanId or 1
	end

	local cfgs = FamilyCallOrderConfig.instance:getProgressCfgById(self._progressPrizePlanId)
	local count = #cfgs

	self:_setPlayerContentLength(count)

	local posY = 0
	local posX = self._playerSliderStartOffset

	for i, v in ipairs(cfgs) do
		posX = posX + self._playerWidthSpace

		local go = self:_getPlayerRewardGo(v)

		go.name = "playercell" .. i

		goutil.addChildToParent(go, self._playerContentRectTrans.transform)
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)
		table.insert(self._playerItemList, go)
	end
end

function FamilyCallOrderView:_getPlayerRewardGo(data)
	local go = goutil.clone(self._playercell)
	local item = goutil.findChild(go, "item")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	MaterialMgr.resetAll(item)

	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.score

	goutil.setActive(go, true)

	return go
end

function FamilyCallOrderView:_updatePlayerRewardGo(data)
	local activityInfo = FamilyCallOrderConfig.instance:getPlanIdInfo()

	if activityInfo then
		local cfgs = FamilyCallOrderConfig.instance:getProgressCfgById(activityInfo.progressPrizePlanId or 1)
		local count = #cfgs

		for i = 1, count do
			local cell = goutil.findChild(self._playerContentRectTrans, "playercell" .. i)
			local geted = goutil.findChild(cell, "geted")
			local canGet = goutil.findChild(cell, "canGet")
			local prize = i

			if table.indexof(self._gainedProgressPrizeIds, i) ~= false then
				goutil.setActive(geted, true)
				goutil.setActive(canGet, false)
			elseif data.familyHistoryMaxScore >= checknumber(FamilyCallOrderConfig.instance:getProgressPrizeCfgById(activityInfo.progressPrizePlanId, prize)) then
				goutil.setActive(canGet, true)

				local effect = FamilyCallOrderController.instance:playEffect(canGet, self, self._tableView)

				GameUtil.asBtn(canGet):RemoveClickListener()
				GameUtil.asBtn(canGet):AddClickListener(function()
					FamilyCallOrderController.instance:sendPM_FamilySummonCommandGainPrizeReq(prize)
					goutil.setActive(canGet, false)
					FamilyCallOrderController.instance:clearEffect(effect)
				end, self)
			else
				goutil.setActive(canGet, false)
			end
		end
	end
end

function FamilyCallOrderView:_updtaeProgressPrize()
	FamilyCallOrderController.instance:sendPM_FamilySummonCommandGetInfoReq()
end

function FamilyCallOrderView:_clearRewardList()
	local activityInfo = FamilyCallOrderConfig.instance:getPlanIdInfo()

	if activityInfo then
		local cfgs = FamilyCallOrderConfig.instance:getProgressCfgById(activityInfo.progressPrizePlanId or 1)
		local count = #cfgs

		for i = 1, count do
			local cell = goutil.findChild(self._playerContentRectTrans, "playercell" .. i)

			goutil.destroy(cell)
		end

		self._playerItemList = {}
	end
end

function FamilyCallOrderView:_updateRankData()
	self._gainedProgressPrizeIds = FamilyCallOrderModel.instance:getFamilGainedProgressPrizeIds()

	local cfgs = FamilyCallOrderModel.instance:getFamilSummonCommandGetInfo()

	self._highsetScoreTxt.text = string.format("家族历史最大积分:<color=#63F078FF>%s</color>", cfgs.familyHistoryMaxScore)
	self._currentScoreTxt.text = string.format("当前家族积分:<color=#63F078FF>%s</color>", cfgs.curFamilySore)
	self._personalScoreTxt.text = string.format("我的积分:<color=#63F078FF>%s</color>", cfgs.myScore)

	self:_setPlayerScore(cfgs.familyHistoryMaxScore)
	self:_updatePlayerRewardGo(cfgs)
end

function FamilyCallOrderView:_updateTopThreeFamily()
	local cfgs = FamilyCallOrderModel.instance:getFamilySummonCommandViewFamilyRank()
	local familyScore = cfgs.myFamilyRank
	local myFamilyHistoryMaxScore = string.format("积分:<color=#63F078FF>%s</color>", (not cfgs.myFamilyHistoryMaxScore or nil) and 0)

	if familyScore == nil or familyScore <= 0 then
		familyScore = "未上榜"
		myFamilyHistoryMaxScore = ""
	end

	self._rankingScroeTxt.text = string.format("我的家族排名:<color=#63F078FF>%s</color>", familyScore)
	self._familyScoreTxt.text = myFamilyHistoryMaxScore

	self:_updataTopThreeFamilyCell(self._first, cfgs.familyRankInfos[1])
	self:_updataTopThreeFamilyCell(self._second, cfgs.familyRankInfos[2])
	self:_updataTopThreeFamilyCell(self._third, cfgs.familyRankInfos[3])
end

function FamilyCallOrderView:_updataTopThreeFamilyCell(cell, data)
	if data ~= nil then
		local headIcon = goutil.findChildComponent(cell, "imgHead/headIcon", "UIImageSpriteChange")
		local nameTxt = goutil.findChildTextComponent(cell, "txtName")
		local areaTxt = goutil.findChildTextComponent(cell, "txtRegional")
		local scoreTxt = goutil.findChildTextComponent(cell, "txtNumber")

		headIcon:SetState(data.familyIconId)

		nameTxt.text = data.familyName
		areaTxt.text = data.areaName
		scoreTxt.text = data.historyMaxScore
	end
end

function FamilyCallOrderView:_sendAllReq(...)
	FamilyCallOrderController.instance:sendPM_FamilySummonCommandGetInfoReq()
end

function FamilyCallOrderView:_clearAllInfo()
	self._rankingScroeTxt.text = "我的家族排名"
	self._familyScoreTxt.text = "积分"
	self._highsetScoreTxt.text = "家族历史最大积分:"
	self._currentScoreTxt.text = "当前家族积分:"
	self._personalScoreTxt.text = "我的积分:"

	self:_setPlayerScore(0)
end

return FamilyCallOrderView
