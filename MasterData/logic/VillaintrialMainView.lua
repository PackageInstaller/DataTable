-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialMainView.lua

module("logic.extensions.villaintrial.view.VillaintrialMainView", package.seeall)

local VillaintrialMainView = class("VillaintrialMainView", ViewComponent)

function VillaintrialMainView:ctor()
	VillaintrialMainView.super.ctor(self)

	self._curStageId = 0
	self._playerItemList = {}
	self._effect = nil
end

function VillaintrialMainView:unbindEvents()
	VillaintrialMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._equipBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._startBtn:RemoveClickListener()
	self._btnRules:RemoveClickListener()
end

function VillaintrialMainView:bindEvents()
	VillaintrialMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._close, self)
	self._equipBtn:AddClickListener(self._openEquipView, self)
	self._rankBtn:AddClickListener(self._openRankView, self)
	self._startBtn:AddClickListener(self._startGame, self)
	self._btnRules:AddClickListener(self._openRulertips, self)
end

function VillaintrialMainView:onExit()
	VillaintrialMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.VillaintrialMain, self._updateAllInfo, self)
	VillaintrialController.instance:clearEffect(self._effect)
	self:_clearRewardList()
end

function VillaintrialMainView:buildUI()
	VillaintrialMainView.super.buildUI(self)

	self._startBtn = self:getBtn("startbtn")
	self._btnRules = self:getBtn("topleft/btnRules")
	self._closeBtn = self:getBtn("topleft/btn_close")
	self._equipBtn = self:getBtn("bottomleft/previewBtn")
	self._rankBtn = self:getBtn("bottomleft/rankingListBtn")
	self._rightBtnTran = self:getGo("right")
	self._rewardSilder = self:getSlider("bottom/playerReward/tableview/viewport/content/progressSlider")
	self._rewardCell = self:getGo("bottom/playerReward/playercell")
	self._tableView = self:getGo("bottom/playerReward/tableview"):GetComponent(goutil.Type_RectTransform)
	self._txtRewardScore = self:getTxt("bottom/txt/txtNumber")
	self._CumulativeScore = self:getTxt("tips")
	self._activityTime = self:getTxt("topRight/activityTimeBG/activityTime")
	self._dailyScoreTxt = self:getTxt("right/score/txtScore")
	self._playerContentRectTrans = self:getGo("bottom/playerReward/tableview/viewport/content"):GetComponent(goutil.Type_RectTransform)
	self._playerSliderRectTrans = self._rewardSilder.gameObject:GetComponent(goutil.Type_RectTransform)

	local px, py = Framework.TransformUtil.GetAnchoredPos(self._playerSliderRectTrans, 0, 0)

	self._playerSliderStartOffset = py
	self._playerSliderEndOffset = 50
	self._playerWidthSpace = 135
end

function VillaintrialMainView:onEnter()
	VillaintrialMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.VillaintrialMain, self._updateAllInfo, self)
	self:_initPlayerReward()
	VillaintrialController.instance:sendPM_VillainPetTrialGetInfoReq()

	local actId = VillaintrialConfig.instance:getActivityId()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.VillainPet, actId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	self._activityTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function VillaintrialMainView:_startGame()
	CustomFmtController.instance:showMissionView(VillaintrialModel.instance:getCustomFmtMo())
end

function VillaintrialMainView:_close()
	self:close()
end

function VillaintrialMainView:_openRankView()
	UIStateManager.instance:push(ViewName.VillaintrialRankView)
end

function VillaintrialMainView:_openEquipView()
	UIStateManager.instance:push(ViewName.VillaintrialEquipView)
end

function VillaintrialMainView:_openRulertips()
	TipsFacade.instance:openRulesView("villaintrialmainview")
end

function VillaintrialMainView:_updateAllInfo()
	local msg = VillaintrialModel.instance:getVillaintrialMainInfo()

	VillaintrialModel.instance:setCurStageId(msg.curStageId)
	self:_updatePlayerRewardGo(msg)
	self:_setPlayerScore(msg.totalScore)
	self:_updateBtnGroup(msg)

	self._curStageId = msg.curStageId
	self._dailyScoreTxt.text = msg.dailyScore

	self:_setEffect()
end

function VillaintrialMainView:_setSliderContentLength(rewardCount)
	local sliderLength = rewardCount * self._playerWidthSpace
	local contentTotalLength = self._playerSliderStartOffset + sliderLength + self._playerSliderEndOffset

	goutil.setWidth(self._playerContentRectTrans, contentTotalLength)
	goutil.setWidth(self._playerSliderRectTrans, sliderLength)
end

function VillaintrialMainView:_setPlayerScore(Score)
	local maxScore = VillaintrialConfig.instance:getPrizeMaxScore(self._progressPrizePlanId)
	local curScore = Score or 0
	local cfgs = VillaintrialConfig.instance:getProgressCfgById(self._progressPrizePlanId)
	local progress = self:_getSilderValue(curScore, cfgs)

	self._rewardSilder:SetValue(progress)

	self._txtRewardScore.text = curScore
end

function VillaintrialMainView:_getSilderValue(curScore, progressPrizeDatas)
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
					if curScore >= progressPrizeDatas[i].socre then
						value = value + once
					else
						local syc = 0

						if progressPrizeDatas[i - 1] and progressPrizeDatas[i - 1].socre > 0 then
							syc = progressPrizeDatas[i - 1].socre
						end

						local temp = (curScore - syc) * once / (progressPrizeDatas[i].socre - syc)

						value = value + temp

						break
					end
				end
			end

			return value
		end
	end
end

function VillaintrialMainView:_clearRewardList()
	local activityInfo = VillaintrialConfig.instance:getPlanIdInfo()
	local cfgs = VillaintrialConfig.instance:getProgressCfgById(self._progressPrizePlanId)
	local count = #cfgs

	for i = 1, count do
		local cell = goutil.findChild(self._playerContentRectTrans, "playercell" .. i)

		goutil.destroy(cell)
	end

	self._playerItemList = {}
end

function VillaintrialMainView:_initPlayerReward()
	table.clear(self._playerItemList)

	local activityInfo = VillaintrialConfig.instance:getPlanIdInfo()

	if activityInfo then
		self._progressPrizePlanId = activityInfo.prizePlanId or 1
	end

	local cfgs = VillaintrialConfig.instance:getProgressCfgById(self._progressPrizePlanId)
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

function VillaintrialMainView:_setPlayerContentLength(rewardCount)
	local sliderLength = rewardCount * self._playerWidthSpace
	local contentTotalLength = self._playerSliderStartOffset + sliderLength + self._playerSliderEndOffset

	goutil.setWidth(self._playerContentRectTrans, contentTotalLength)
	goutil.setWidth(self._playerSliderRectTrans, sliderLength)
end

function VillaintrialMainView:_getPlayerRewardGo(data)
	local go = goutil.clone(self._rewardCell)
	local item = goutil.findChild(go, "item")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	MaterialMgr.resetAll(item)

	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.socre

	goutil.setActive(go, true)

	return go
end

function VillaintrialMainView:_updatePlayerRewardGo(data)
	local activityInfo = VillaintrialConfig.instance:getPlanIdInfo()

	if activityInfo then
		local cfgs = VillaintrialConfig.instance:getProgressCfgById(activityInfo.progressPrizePlanId or 1)
		local count = #cfgs

		for i = 1, count do
			local cell = goutil.findChild(self._playerContentRectTrans, "playercell" .. i)
			local geted = goutil.findChild(cell, "geted")
			local canGet = goutil.findChild(cell, "canGet")
			local prize = i

			goutil.setActive(geted, false)

			if table.indexof(data.gainPrizeIds, i) ~= false then
				goutil.setActive(geted, true)
				goutil.setActive(canGet, false)
			elseif data.totalScore >= checknumber(VillaintrialConfig.instance:getProgressPrizeCfgById(activityInfo.prizePlanId, prize)) then
				goutil.setActive(canGet, true)

				local effect = VillaintrialController.instance:playEffect(canGet, self, self._tableView, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab")

				GameUtil.asBtn(canGet):RemoveClickListener()
				GameUtil.asBtn(canGet):AddClickListener(function()
					VillaintrialController.instance:sendPM_VillainPetTrialGainPrizeReq(prize)
					goutil.setActive(canGet, false)
					VillaintrialController.instance:clearEffect(effect)
				end, self)
			else
				goutil.setActive(canGet, false)
			end
		end
	end
end

function VillaintrialMainView:_updateBtnGroup(data)
	local rightBtnTran = self._rightBtnTran.transform

	for i = 1, 5 do
		local btn = goutil.findChild(rightBtnTran, "btn_" .. i)
		local lock = goutil.findChild(btn, "lock")
		local btnTxt = goutil.findChildTextComponent(btn, "Text")
		local select = goutil.findChild(btn, "select")
		local score = goutil.findChildTextComponent(btn, "txtScore")
		local selectTip = goutil.findChildTextComponent(btn, "select/txt")
		local stageInfos = data.stageInfos[i]
		local curStageId = i
		local isLock = i > data.curStageId

		goutil.setActive(lock, isLock)
		GameUtil.asBtn(btn):RemoveClickListener()
		GameUtil.asBtn(btn):AddClickListener(function()
			if isLock then
				FloatWordMgr.instance:show("暂未解锁")

				return
			end

			if data.curStageId <= 5 and data.curStageId ~= curStageId then
				FloatWordMgr.instance:show(string.format("您还没有通关第%s层", data.curStageId))

				return
			end

			self._curStageId = curStageId

			VillaintrialModel.instance:setCurStageId(curStageId)
			VillaintrialModel.instance:setCurSelectStageId(curStageId)
			self:_updataBtnState(curStageId, rightBtnTran)
		end)

		btnTxt.text = string.format("第%s层", i)

		if stageInfos and stageInfos.stageScore then
			score.text = string.format("积分:%s", stageInfos.stageScore)
		end

		selectTip.text = data.curStageId <= 5 and "当前进度" or "当前选择"
	end

	self:_updataBtnState(data.curStageId, rightBtnTran)
end

function VillaintrialMainView:_updataBtnState(curStageId, rightBtnTran)
	local stageId = VillaintrialModel.instance:getCurStageId()

	for i = 1, 5 do
		local btn = goutil.findChild(rightBtnTran, "btn_" .. i)
		local go = goutil.findChild(btn, "select")

		goutil.setActive(go, stageId == i)
	end
end

function VillaintrialMainView:_setEffect()
	local level = VillaintrialModel.instance:getCurStageId()

	if GameUtil.getUserDayData("VillaintrialEquipView" .. level) == nil then
		self._effect = VillaintrialController.instance:playEffect(self._equipBtn, self, self._tableView, "common/fx_ui_anniu_tongyong.prefab")
	end
end

return VillaintrialMainView
