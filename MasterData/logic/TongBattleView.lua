-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongBattleView.lua

module("logic.extensions.tongbattle.view.TongBattleView", package.seeall)

local TongBattleView = class("TongBattleView", ViewComponent)

function TongBattleView:ctor()
	TongBattleView.super.ctor(self)

	self._isActivityEnd = false
	self._rankItemList = nil
	self._roundItemList = nil
	self._fireItemList = nil
	self._roundCount = nil
	self._fireIndex = nil
	self._isRankComm = true
end

function TongBattleView:bindEvents()
	TongBattleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "tongmain")
	end, self)
	self._commBtn:AddClickListener(function()
		self:_onClickCommHellBtn(true)
	end, self)
	self._hellBtn:AddClickListener(function()
		self:_onClickCommHellBtn(false)
	end, self)
	self._rankCommBtn:AddClickListener(function()
		self:_onClickRankSwitchBtn(true, false)
	end, self)
	self._rankHellBtn:AddClickListener(function()
		self:_onClickRankSwitchBtn(false, false)
	end, self)
	self._rankBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.TongRank, true)
	end, self)
	self._dayAddBtn:AddClickListener(self._onClickDayAddBtn, self)
	GameUtil.asBtn(self._fuchouGo):AddClickListener(self._onClickFuchouBtn, self)
end

function TongBattleView:unbindEvents()
	TongBattleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._commBtn:RemoveClickListener()
	self._hellBtn:RemoveClickListener()
	self._rankCommBtn:RemoveClickListener()
	self._rankHellBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._dayAddBtn:RemoveClickListener()
	GameUtil.asBtn(self._fuchouGo):RemoveClickListener()

	for _, item in pairs(self._roundItemList or {}) do
		if item and item.progGo then
			GameUtil.asBtn(item.progGo):RemoveClickListener()
		end
	end
end

function TongBattleView:onExit()
	TongBattleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateTongBattleInfo, self._updataBattleViewInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateTongBuyCount, self._updataBattleCountShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateTongBaseInfo, self._updataBattleCountShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateTongRankInfo, self._onClickRankSwitchBtn, self)
	removetimer(self._calculationSurplusTime, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	if self._hellEff then
		UIEffectManager.instance:stopEffect(self._hellEff)
	end

	self._hellEff = nil

	if self._commEff then
		UIEffectManager.instance:stopEffect(self._commEff)
	end

	self._commEff = nil

	if self._fuchouEff then
		UIEffectManager.instance:stopEffect(self._fuchouEff)
	end

	self._fuchouEff = nil

	for _, item in pairs(self._roundItemList or {}) do
		if item and item.lineEff then
			UIEffectManager.instance:stopEffect(item.lineEff)

			item.lineEff = nil
		end
	end

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)

	MaterialMgr.resetAll(self._sprintRareGo)
	MaterialMgr.resetAll(self._tryGoods)
	MaterialMgr.resetAll(self._rankGoods)
	MaterialMgr.resetAll(self._shopGoods)
end

function TongBattleView:destroyUI()
	TongBattleView.super.destroyUI(self)
	uGuiUtil.clearImage(self._prizeIconIma.gameObject)

	self._rankItemList = nil
	self._roundItemList = nil
	self._fireItemList = nil
	self._roundCount = nil
	self._fireIndex = nil
	self._isRankComm = nil
end

function TongBattleView:buildUI()
	TongBattleView.super.buildUI(self)

	self._sprintGo = self:getGo("sprintGo")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._daySupTxt = self:getGo("daySupGo/daySupTxt"):GetComponent("Text")
	self._dayAddBtn = self:getBtn("daySupGo/dayAddBtn")
	self._areaSupTxt = self:getGo("areaSupGo/areaSupTxt"):GetComponent("Text")
	self._timerTxt = self:getGo("timerTxt"):GetComponent("Text")

	local prizeLimitGo = self:getGo("prizeLimitGo")

	self._prizeDescTxt = goutil.findChildTextComponent(prizeLimitGo, "prizeDescTxt")
	self._prizeCountTxt = goutil.findChildTextComponent(prizeLimitGo, "prizeCountTxt")
	self._prizeIconIma = goutil.findChild(prizeLimitGo, "prizeCountTxt/prizeIconIma"):GetComponent("Image")
	self._getTongTxt = self:getGo("getTongGo/getTongTxt"):GetComponent("Text")
	self._commBtn = self:getBtn("commBtn")
	self._commRedGo = self:getGo("commBtn/commRedGo")
	self._commEffGo = self:getGo("commBtn/commEffGo")
	self._hellBtn = self:getBtn("hellBtn")
	self._hellRedGo = self:getGo("hellBtn/hellRedGo")
	self._hellEffGo = self:getGo("hellBtn/hellEffGo")
	self._fireItemList = {}
	self._fireItemList[1] = {
		self:getGo("commBtn/fireGo1"),
		self:getGo("commBtn/fireGo2"),
		self:getGo("commBtn/fireGo3")
	}
	self._fireItemList[2] = {
		self:getGo("hellBtn/fireGo1"),
		self:getGo("hellBtn/fireGo2"),
		self:getGo("hellBtn/fireGo3")
	}

	local progInfoGo = self:getGo("progInfoGo")

	self._fuchouGo = goutil.findChild(progInfoGo, "fuchouGo")
	self._fuchouEffGo = goutil.findChild(self._fuchouGo, "fuchouEffGo")
	self._fuchouCountTxt = goutil.findChildTextComponent(self._fuchouGo, "fuchouCountTxt")
	self._roundItemList = {
		{
			lineGo = goutil.findChild(progInfoGo, "lineGo_1"),
			progGo = goutil.findChild(progInfoGo, "progGo_1"),
			progTxt = goutil.findChildTextComponent(progInfoGo, "progGo_1/progTxt")
		},
		{
			lineGo = goutil.findChild(progInfoGo, "lineGo_2"),
			progGo = goutil.findChild(progInfoGo, "progGo_2"),
			progTxt = goutil.findChildTextComponent(progInfoGo, "progGo_2/progTxt")
		},
		{
			lineGo = goutil.findChild(progInfoGo, "lineGo_3"),
			progGo = goutil.findChild(progInfoGo, "progGo_3"),
			progTxt = goutil.findChildTextComponent(progInfoGo, "progGo_3/progTxt")
		},
		{
			lineGo = goutil.findChild(progInfoGo, "lineGo_4"),
			progGo = goutil.findChild(progInfoGo, "progGo_4"),
			progTxt = goutil.findChildTextComponent(progInfoGo, "progGo_4/progTxt")
		}
	}

	local rankInfoGo = self:getGo("rankInfoGo")

	self._noRankGo = goutil.findChild(rankInfoGo, "noRankGo")
	self._rankCommBtn = Framework.ButtonAdapter.GetFrom(rankInfoGo, "rankCommBtn")
	self._rankCommGrp = self._rankCommBtn.gameObject:GetComponent("UIChangeGroup")
	self._rankHellBtn = Framework.ButtonAdapter.GetFrom(rankInfoGo, "rankHellBtn")
	self._rankHellGrp = self._rankHellBtn.gameObject:GetComponent("UIChangeGroup")
	self._rankBtn = Framework.ButtonAdapter.GetFrom(rankInfoGo, "rankBtn")
	self._rankItemList = {
		{
			itemGo = goutil.findChild(rankInfoGo, "rankItem_1"),
			headGo = goutil.findChild(rankInfoGo, "rankItem_1/headGo"),
			nameTxt = goutil.findChildTextComponent(rankInfoGo, "rankItem_1/rankNameTxt"),
			timeTxt = goutil.findChildTextComponent(rankInfoGo, "rankItem_1/rankTimeTxt")
		},
		{
			itemGo = goutil.findChild(rankInfoGo, "rankItem_2"),
			headGo = goutil.findChild(rankInfoGo, "rankItem_2/headGo"),
			nameTxt = goutil.findChildTextComponent(rankInfoGo, "rankItem_2/rankNameTxt"),
			timeTxt = goutil.findChildTextComponent(rankInfoGo, "rankItem_2/rankTimeTxt")
		},
		{
			itemGo = goutil.findChild(rankInfoGo, "rankItem_3"),
			headGo = goutil.findChild(rankInfoGo, "rankItem_3/headGo"),
			nameTxt = goutil.findChildTextComponent(rankInfoGo, "rankItem_3/rankNameTxt"),
			timeTxt = goutil.findChildTextComponent(rankInfoGo, "rankItem_3/rankTimeTxt")
		}
	}
	self._bubbleGo = self:getGo("bubbleGo")
	self._bubbleTxt = goutil.findChildTextComponent(self._bubbleGo, "bubbleTxt")
	self._daySupTxt.text = ""
	self._areaSupTxt.text = ""
	self._timerTxt.text = ""
	self._prizeDescTxt.text = ""
	self._prizeCountTxt.text = ""
	self._getTongTxt.text = ""

	self._commRedGo:SetActive(false)
	self._hellRedGo:SetActive(false)

	self._fuchouCountTxt.text = ""

	self._noRankGo:SetActive(false)

	self._bubbleTxt.text = ""

	self._bubbleGo:SetActive(false)
end

function TongBattleView:onEnter()
	TongBattleView.super.onEnter(self)

	self._petRaceId = TongBattleModel.instance.petRaceId
	self._challCfg = TongBattleConfig.instance:getBattleBaseCfg(TongBattleModel.instance.challengeId)

	local value = GameUtil.getUserDayData("TongBattleRedpoint")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData("TongBattleRedpoint", 1)
	end

	self:_showActivityTimer()
	self:_showSpriteRawInfo()
	self:_onClickRankSwitchBtn(self._isRankComm, true)
	self:_updataBattleViewInfo(true)

	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)

	if self._isActivityEnd then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdateTongBattleInfo, self._updataBattleViewInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateTongBuyCount, self._updataBattleCountShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateTongBaseInfo, self._updataBattleCountShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateTongRankInfo, self._onClickRankSwitchBtn, self)
	TongBattleController.instance:csGetTongBattleInfoReq()
end

function TongBattleView:_updataBattleViewInfo(isFirst)
	self:_updataBattleCountShow()

	self._battleInfo = TongBattleModel.instance:getTongBattleInfo()
	self._getTongTxt.text = self._baseInfo.isGetTong and langPara("text_tong_desc_8", 1) or langPara("text_tong_desc_8", 0)

	local list = string.split(self._challCfg.prizeLimit, ":")

	if list and #list >= 3 then
		local prizeCfg = MaterialMgr.getMatCfg(list[1], list[2])

		if prizeCfg then
			self._prizeDescTxt.text = langPara("text_tong_desc_9", prizeCfg.name)
			self._prizeCountTxt.text = string.format("<color=#F84F89FF>%s</color>/%s", self._baseInfo.prizeCount, list[3])

			MaterialMgr.setIcon(self._prizeIconIma, tonumber(list[1]), tonumber(list[2]))
		end
	end

	local count = 0

	for i = 1, #self._roundItemList do
		count = checknumber(self._battleInfo.roundList[i])
		self._roundItemList[i].progTxt.text = tostring(count)

		if self._battleInfo.isLockBuxi or count == 0 then
			if self._roundItemList[i].lineEff then
				UIEffectManager.instance:stopEffect(self._roundItemList[i].lineEff)
			end

			self._roundItemList[i].lineEff = nil
		elseif self._roundItemList[i].lineEff == nil then
			local effPath = self._battleInfo.isLockBuxi and "fx_ui_tongtiaozhan/fx_ui_lianjie2_tongtiaozhan.prefab" or "fx_ui_tongtiaozhan/fx_ui_lianjie1_tongtiaozhan.prefab"

			self._roundItemList[i].lineEff = UIEffectManager.instance:playEffect(self, effPath, self._roundItemList[i].lineGo, 0, 0, true, nil, nil, function()
				self._roundItemList[i].lineEff:setParent(self._roundItemList[i].lineGo.transform)
				self._roundItemList[i].lineEff:setLocalPos(0, 0, 0)
				self._roundItemList[i].lineEff:setScale(1)

				if self._roundItemList[i].lineEff.effGo then
					Framework.TransformUtil.SetLocalRotation(self._roundItemList[i].lineEff.effGo.transform, 0, 0, -93)
				end
			end, self)
		end

		if isFirst then
			GameUtil.asBtn(self._roundItemList[i].progGo):RemoveClickListener()
			GameUtil.asBtn(self._roundItemList[i].progGo):AddClickListener(function()
				self:_onClickBuxiBtn(i)
			end, self)
		end
	end

	if self._fuchouEff then
		UIEffectManager.instance:stopEffect(self._fuchouEff)
	end

	self._fuchouEff = nil
	self._fuchouCountTxt.text = string.format("<color=#F84F89FF>%s</color>/%s", self._battleInfo.fireCount, self._battleInfo.roundCount)

	if self._battleInfo.isLockBuxi then
		uGuiUtil.setImageGrayState(self._fuchouGo, false)
		uGuiUtil.setTextGrayState(self._fuchouCountTxt, false)

		local effPath = "fx_ui_tongtiaozhan/fx_ui_fuchouzhiyan_tongtiaozhan.prefab"

		self._fuchouEff = UIEffectManager.instance:playEffect(self, effPath, self._fuchouEffGo, 0, 0, true, nil, nil, nil, self)

		self._fuchouEff:setParent(self._fuchouEffGo.transform)
		self._fuchouEff:setLocalPos(0, 0, 0)
		self._fuchouEff:setScale(1)
	else
		uGuiUtil.setImageGrayState(self._fuchouGo, true)
		uGuiUtil.setTextGrayState(self._fuchouCountTxt, true)
	end

	for i = 1, #self._battleInfo.roundList do
		if i <= self._battleInfo.fireNum then
			if self._fireItemList[1][i] then
				GameUtil.SetActive(self._fireItemList[1][i], true)
			end

			if self._fireItemList[2][i] then
				GameUtil.SetActive(self._fireItemList[2][i], true)
			end
		else
			if self._fireItemList[1][i] then
				GameUtil.SetActive(self._fireItemList[1][i], false)
			end

			if self._fireItemList[2][i] then
				GameUtil.SetActive(self._fireItemList[2][i], false)
			end
		end
	end

	if not isFirst and self._battleInfo.isFireEff and self._battleInfo.fireNum > 0 then
		local effPath = "fx_ui_tongtiaozhan/fx_ui_dianliang_tongtiaozhan.prefab"
		local eff1 = UIEffectManager.instance:playEffect(self, effPath, self._fireItemList[1][self._battleInfo.fireNum], 0, 0, false, nil, nil, nil, self)

		eff1:setParent(self._fireItemList[1][self._battleInfo.fireNum].transform)
		eff1:setLocalPos(0, 0, 0)
		eff1:setScale(1)

		local eff2 = UIEffectManager.instance:playEffect(self, effPath, self._fireItemList[2][self._battleInfo.fireNum], 0, 0, false, nil, nil, nil, self)

		eff2:setParent(self._fireItemList[2][self._battleInfo.fireNum].transform)
		eff2:setLocalPos(0, 0, 0)
		eff2:setScale(1)
	end

	if not isFirst then
		return
	end

	if TongBattleModel.instance:isOpenDemonChooseRound() then
		return
	end
end

function TongBattleView:_updataBattleCountShow()
	self._baseInfo = TongBattleModel.instance:getTongBaseInfo()

	local supCount = math.max(self._challCfg.freeChallengeTimes + self._baseInfo.buyCount - self._baseInfo.useCount, 0)

	GameUtil.SetActive(self._dayAddBtn, supCount <= 0)

	self._daySupTxt.text = langPara("text_tong_desc_10", supCount, self._challCfg.freeChallengeTimes)
	supCount = math.max(self._challCfg.spaceLimit - self._baseInfo.tongCount, 0)
	self._areaSupTxt.text = langPara("text_tong_desc_11", supCount, self._challCfg.spaceLimit)
end

function TongBattleView:_showActivityTimer()
	self._isActivityEnd = false

	removetimer(self._calculationSurplusTime, self)

	if not TLChallengeController.instance:isInOpenTime(TongBattleModel.instance.challengeId) then
		self._isActivityEnd = true
		self._timerTxt.text = ""

		return
	end

	local actCfg = TimeLimitedConfig.instance:getCfgById(TongBattleModel.instance.challengeId)
	local start, timer = TLChallengeController.instance:getStartAndEndTime(actCfg)

	if start == nil or checknumber(timer) <= ServerTime.now() then
		self._timerTxt.text = lang("text_tong_desc_12")
		self._isActivityEnd = true
	end

	self._endTime = timer

	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function TongBattleView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = lang("text_tong_desc_12")
		self._isActivityEnd = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function TongBattleView:_showSpriteRawInfo()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_anniu_diyutiaozhan_tongtiaozhan.prefab"

	self._hellEff = UIEffectManager.instance:playEffect(self, effPath, self._hellEffGo, 0, 0, true, nil, nil, nil, self)

	self._hellEff:setParent(self._hellEffGo.transform)
	self._hellEff:setLocalPos(0, 0, 0)
	self._hellEff:setScale(1)

	effPath = "fx_ui_tongtiaozhan/fx_ui_anniu_putongtiaozhan_tongtiaozhan.prefab"
	self._commEff = UIEffectManager.instance:playEffect(self, "fx_ui_tongtiaozhan/fx_ui_anniu_putongtiaozhan_tongtiaozhan.prefab", self._commEffGo, 0, 0, true, nil, nil, nil, self)

	self._commEff:setParent(self._commEffGo.transform)
	self._commEff:setLocalPos(0, 0, 0)
	self._commEff:setScale(1)
	self._bubbleGo:SetActive(true)

	self._bubbleTxt.text = self._challCfg.petBubble

	local x, y, scale = 0, 0, 0.7

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._petRaceId, self._sprintGo, scale, nil, true, x, y)
end

function TongBattleView:_onClickBuxiBtn(index)
	SurveyController.instance:reportBehavior(200481, 1)

	if self._battleInfo.isLockBuxi then
		FloatWordMgr.instance:show(lang("text_tong_desc_13"))

		return
	end

	if self._challCfg.freeChallengeTimes + self._baseInfo.buyCount <= self._baseInfo.useCount then
		self:_onClickDayAddBtn()

		return
	end

	UIStateManager.instance:push(ViewName.TongRule, {
		chalType = 1,
		planId = self._challCfg.challengePlanId,
		stageIndex = index
	})
end

function TongBattleView:_onClickFuchouBtn()
	SurveyController.instance:reportBehavior(200481, 2)

	if not self._battleInfo.isLockBuxi then
		FloatWordMgr.instance:show(lang("text_tong_desc_14"))

		return
	end

	if self._challCfg.freeChallengeTimes + self._baseInfo.buyCount <= self._baseInfo.useCount then
		self:_onClickDayAddBtn()

		return
	end

	local index = 1

	if self._challCfg.fireTurns and #self._challCfg.fireTurns > 0 then
		for i = 1, #self._challCfg.fireTurns do
			if checknumber(self._challCfg.fireTurns[i]) == self._battleInfo.roundCount then
				index = i

				break
			end
		end
	end

	UIStateManager.instance:push(ViewName.TongRule, {
		chalType = 2,
		planId = self._challCfg.challengePlanId,
		stageIndex = index
	})
end

function TongBattleView:_onClickCommHellBtn(isComm)
	if isComm then
		SurveyController.instance:reportBehavior(200481, 3)
	else
		SurveyController.instance:reportBehavior(200481, 4)
	end

	if #self._challCfg.fireTurns > self._battleInfo.fireNum then
		FloatWordMgr.instance:show(lang("text_tong_desc_15"))

		return
	end

	if isComm then
		if not string.nilorempty(self._challCfg.OPEN_TIME) then
			local times = string.split(self._challCfg.OPEN_TIME, ",")
			local isOpen = false

			for i = 1, #times do
				local list = string.split(times[i], "#")

				if list and #list == 2 and GameUtil.checkIsInTimePeriod(list[1], list[2], true) then
					isOpen = true

					break
				end
			end

			if not isOpen then
				FloatWordMgr.instance:show(lang("text_tong_desc_27"))

				return
			end
		end

		if self._challCfg.spaceLimit <= self._baseInfo.tongCount then
			FloatWordMgr.instance:show(lang("text_tong_desc_16"))

			return
		end

		UIStateManager.instance:push(ViewName.TongPlay, {
			stageIndex = 1,
			chalType = 3,
			planId = self._challCfg.challengePlanId
		})
	else
		UIStateManager.instance:push(ViewName.TongPlay, {
			stageIndex = 1,
			chalType = 4,
			planId = self._challCfg.challengePlanId
		})
	end
end

function TongBattleView:_onClickRankSwitchBtn(isComm, isForce)
	if self._isRankComm == isComm and not isForce then
		return
	end

	self._isRankComm = isComm

	local ranklist = TongBattleModel.instance:getPlayerRankInfo(self._isRankComm)

	if self._isRankComm then
		self._rankCommGrp:SetState(1)
		self._rankHellGrp:SetState(0)
	else
		self._rankCommGrp:SetState(0)
		self._rankHellGrp:SetState(1)
	end

	for i = 1, #self._rankItemList do
		if self._rankItemList[i] then
			if self._rankItemList[i].headGo then
				MaterialMgr.resetAll(self._rankItemList[i].headGo)
			end

			if self._rankItemList[i].itemGo then
				GameUtil.SetActive(self._rankItemList[i].itemGo, false)
			end
		end
	end

	if ranklist == nil or ranklist.infoList == nil or checknumber(ranklist.rankSize) == 0 then
		self._noRankGo:SetActive(true)

		return
	end

	local infoList = ranklist.infoList

	if infoList == nil or #infoList == 0 then
		self._noRankGo:SetActive(true)

		return
	end

	self._noRankGo:SetActive(false)

	for i = 1, #self._rankItemList do
		if self._rankItemList[i] and infoList[i] then
			GameUtil.SetActive(self._rankItemList[i].itemGo, true)
			HeadItemController.instance:setHeadCellByInfo(self._rankItemList[i].headGo, infoList[i].headInfo)

			self._rankItemList[i].nameTxt.text = infoList[i].headInfo.userName

			local timer = GameUtil.time2date(checknumber(infoList[i].gainTime) / 1000)

			self._rankItemList[i].timeTxt.text = langPara("%d月%d日 %02d:%02d:%02d", timer.month, timer.day, timer.hour, timer.min, timer.sec)
		else
			return
		end
	end
end

function TongBattleView:_onClickDayAddBtn()
	local list, allNum = TongBattleModel.instance:getBuyCountConsume(self._challCfg.buyTimePlanId, self._baseInfo.buyCount + 1)

	if list == nil or checknumber(allNum) <= 0 then
		FloatWordMgr.instance:show(lang("text_tong_desc_17"))

		return
	end

	if allNum <= self._baseInfo.buyCount then
		TipsFacade.instance:openTipWindow(lang("text_tong_tips"), lang("text_tong_desc_18"), nil, lang("text_tong_know"), UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	local function callback()
		TongBattleController.instance:csGetTongBuyTimesReq()
	end

	local matName = MaterialMgr.getMaterialsName(tonumber(list[1]), tonumber(list[2]))
	local content = langPara("text_tong_desc_19", list[3], matName, allNum, allNum - self._baseInfo.buyCount)

	if tonumber(list[1]) == MatType.Diamond or tonumber(list[1]) == MatType.Diamond_Consume then
		TipsFacade.instance:openPopupCostDiamondView(tonumber(list[3]), content, callback)
	elseif tonumber(list[1]) == MatType.Coin then
		TipsFacade.instance:openPopupCostCoinView(tonumber(list[3]), content, callback)
	else
		TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), content, callback, nil, lang("text_lottery_buy"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
	end
end

return TongBattleView
