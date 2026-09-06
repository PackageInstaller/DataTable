-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/FeinChallengeBattleView.lua

module("logic.extensions.moonking.view.FeinChallengeBattleView", package.seeall)

local FeinChallengeBattleView = class("FeinChallengeBattleView", ViewComponent)

function FeinChallengeBattleView:ctor()
	FeinChallengeBattleView.super.ctor(self)

	self._curChallId = nil
	self._curMoshiDatas = nil
	self._curIndex = nil
	self._curRewardDatas = nil
	self._petPosList = nil
	self._prizeEffList = nil
end

function FeinChallengeBattleView:bindEvents()
	FeinChallengeBattleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "feiyinchallenge_rule")
	end, self)
	self._nanduBtn:AddClickListener(self._onClickNanduBtn, self)
	self._rewardListSR:AddOnScrollValueChanged(self._onCellUpdatePosition, self)
end

function FeinChallengeBattleView:unbindEvents()
	FeinChallengeBattleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._nanduBtn:RemoveClickListener()
	self._rewardListSR:UnRegisterAllCallbacks()
end

function FeinChallengeBattleView:onExit()
	FeinChallengeBattleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMoonKingInfo, self._updataBattleViewInfo, self)
	removetimer(self._calculationSurplusTime, self)

	self._curIndex = nil

	for _, go in pairs(self._petPosList) do
		if go then
			MaterialMgr.resetAll(go)
		end
	end

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	for _, eff in pairs(self._prizeEffList) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._prizeEffList = nil
	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._moveViewIndex = nil
end

function FeinChallengeBattleView:destroyUI()
	FeinChallengeBattleView.super.destroyUI(self)

	local sigBig = self._scoreIconGo.gameObject:GetComponent("ImageBigBG")

	if sigBig then
		sigBig:ClearImage()
	end

	uGuiUtil.clearImage(self._daibiIconGo)

	self._petPosList = nil
end

function FeinChallengeBattleView:buildUI()
	FeinChallengeBattleView.super.buildUI(self)

	self._sprintGo = self:getGo("sprintGo")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._viewNameTxt = self:getTxt("viewNameTxt")
	self._moshiListSR = self:getGo("moshiListSR"):GetComponent("UITableview")
	self._moshiItem = self:getGo("moshiItem")

	self._moshiItem:SetActive(false)

	local allRewardGo = self:getGo("allRewardGo")

	self._srContent = goutil.findChild(allRewardGo, "rewardListSR/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._rewardListSR = goutil.findChild(allRewardGo, "rewardListSR"):GetComponent("UITableview")
	self._rewardItem = goutil.findChild(allRewardGo, "rewardItem")

	self._rewardItem:SetActive(false)

	self.progBarGo = goutil.findChild(allRewardGo, "rewardListSR/Viewport/progBarGo/progBarSli")
	self.progBarSli = self.progBarGo:GetComponent("Slider")
	self.progBarSli.value = 0

	local scoreGo = self:getGo("allRewardGo/scoreGo")

	self._scoreIconGo = goutil.findChild(scoreGo, "scoreIconGo")
	self._scoreCountTxt = goutil.findChildTextComponent(scoreGo, "scoreCountTxt")
	self._scoreCountTxt.text = ""

	local rigthInfoGo = self:getGo("rigthInfoGo")

	self._buffNameTxt = goutil.findChildTextComponent(rigthInfoGo, "buffNameTxt")
	self._buffDescTxt = goutil.findChildTextComponent(rigthInfoGo, "buffDescGo/buffDescTxt")
	self._petPosList = {
		goutil.findChild(rigthInfoGo, "petPosGo_1"),
		goutil.findChild(rigthInfoGo, "petPosGo_2"),
		goutil.findChild(rigthInfoGo, "petPosGo_3"),
		goutil.findChild(rigthInfoGo, "petPosGo_4"),
		goutil.findChild(rigthInfoGo, "petPosGo_5"),
		goutil.findChild(rigthInfoGo, "petPosGo_6"),
		goutil.findChild(rigthInfoGo, "petPosGo_7"),
		goutil.findChild(rigthInfoGo, "petPosGo_8"),
		goutil.findChild(rigthInfoGo, "petPosGo_9")
	}
	self._nanduBtn = Framework.ButtonAdapter.GetFrom(rigthInfoGo, "nanduBtn")
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timeGo/timerTxt")
	self._daibiItemBtn = self:getBtn("daibiItem")
	self._daibiIconGo = self:getGo("daibiItem/daibiIconIma")
	self._daibiCountTxt = self:getTxt("daibiItem/daibiCountTxt")

	self:registCallbacks()
end

function FeinChallengeBattleView:registCallbacks()
	self._moshiListSR:RegisterCallback(self._MoshiInView, function()
		return 250, 112
	end, self._MoshiAtIndex, self)
	self._moshiListSR:RegisterUpdateCellCallback(self._OnMoshiCellUpdate)
	self._rewardListSR:RegisterCallback(self._RewardInView, function()
		return 70, 120
	end, self._RewardAtIndex, self)
	self._rewardListSR:RegisterUpdateCellCallback(self._OnRewardCellUpdate)
	self._rewardListSR:RegisterReloadFinishCallback(self._onRewardReloadFinish)
end

function FeinChallengeBattleView:_MoshiInView()
	if not self._curMoshiDatas then
		return 0
	end

	return #self._curMoshiDatas
end

function FeinChallengeBattleView:_MoshiAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._moshiItem)

	local data = self._curMoshiDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_updateMoshiCell(view, cell, data)

	return cell
end

function FeinChallengeBattleView:_OnMoshiCellUpdate(view, cell)
	local index = cell.index
	local data = self._curMoshiDatas[index + 1]

	cell.data = index + 1

	self:_updateMoshiCell(view, cell, data)
end

function FeinChallengeBattleView:_RewardInView()
	if not self._curRewardDatas then
		return 0
	end

	return #self._curRewardDatas
end

function FeinChallengeBattleView:_RewardAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rewardItem)

	local data = self._curRewardDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_updateRewardCell(view, cell, data)

	return cell
end

function FeinChallengeBattleView:_OnRewardCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRewardDatas[index + 1]

	cell.data = index + 1

	self:_updateRewardCell(view, cell, data)
end

function FeinChallengeBattleView:onEnter()
	FeinChallengeBattleView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateMoonKingInfo, self._updataBattleViewInfo, self)

	local curChallId = checknumber(self:getFirstParam())

	if curChallId <= 0 then
		curChallId = MoonKingModel.instance.feinChallengeId
	end

	MoonKingModel.instance:setMoonkingChooseBuff()

	local str = string.format("FeinViewRed_%s_%s", curChallId, LoginModel.instance.userId)
	local value = GameUtil.getUserDayData(str)

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData(str, 1)
	end

	self._prizeEffList = {}
	self._challCfg = MoonKingConfig.instance:getBattleBaseCfg(curChallId)
	self._viewNameTxt.text = self._challCfg.viewName

	MaterialMgr.updateItemByStr(self._scoreIconGo, self._challCfg.scoreStr)
	MaterialMgr.updateItemByStr(self._daibiIconGo, self._challCfg.daibiStr)
	self:_showActivityTimer()
	self:_updataBattleViewInfo(self._challCfg.challengeId)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._challCfg.skinId, self._sprintGo, self._challCfg.modelScale, nil, true, 0, 0)

	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
	MoonKingController.instance:csGetMoonShadowKingChallengeGetInfoReq(self._challCfg.challengeId)
end

function FeinChallengeBattleView:_showActivityTimer()
	self._timerTxt.text = TimeGateController.instance:getActTimeShowByChallengeId(MoonKingModel.instance.feinChallengeId)
end

function FeinChallengeBattleView:_calculationSurplusTime()
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

function FeinChallengeBattleView:_updataBattleViewInfo(challId, isPrize)
	if self._challCfg.challengeId ~= challId then
		return
	end

	self._moonkingInfo = MoonKingModel.instance:getMoonkingBaseInfo(self._challCfg.challengeId)
	self._curRewardDatas = MoonKingModel.instance:getMoonkingPrizeList(self._challCfg.challengeId, self._challCfg.scorePrizePlanId)
	self._scoreCountTxt.text = tostring(self._moonkingInfo.totalScore)
	self._daibiCountTxt.text = tostring(self._moonkingInfo.totalScore)

	self:_updateShowProgressBar()
	self._rewardListSR:ReloadData()

	if not isPrize then
		local groupCfg

		if self._moonkingInfo and checknumber(self._moonkingInfo.curGroupId) > 0 then
			groupCfg = MoonKingConfig.instance:getBattlePlanCfg(self._challCfg.challengePlanId, self._moonkingInfo.curGroupId)
		end

		self._curMoshiDatas = {}
		self._curIndex = 1

		if groupCfg then
			self._buffNameTxt.text = groupCfg.groupName
			self._buffDescTxt.text = groupCfg.buffDesc
			self._curMoshiDatas, self._curIndex = MoonKingModel.instance:getMoonkingStageList(self._challCfg.challengeId, groupCfg.stagePlanId)
		end

		self:_showChoiseStageInfo()
	end
end

function FeinChallengeBattleView:_updateMoshiCell(view, cell, data)
	local itemGrp = cell:GetComponent("UIChangeGroup")
	local arrowGo = goutil.findChild(cell, "arrowGo")
	local bgIma = goutil.findChild(cell, "bgIma"):GetComponent("UIImageSpriteChange")
	local scoreImaGo = goutil.findChild(cell, "bgIma/scoreIma")
	local scoreTxt = goutil.findChildTextComponent(cell, "bgIma/scoreTxt")
	local levelTxt = goutil.findChildTextComponent(cell, "bgIma/levelTxt")
	local lockGo = goutil.findChild(cell, "bgIma/lockGo")

	MaterialMgr.clearIcon(scoreImaGo)
	GameUtil.asBtn(cell):RemoveClickListener()

	if cell.data == self._curIndex then
		itemGrp:SetState(1)
		arrowGo:SetActive(true)
		bgIma:SetState(1)
		Framework.TransformUtil.SetLocalPos(bgIma.gameObject.transform, 10, 0, 0)
		Framework.TransformUtil.SetLocalScale(bgIma.gameObject.transform, 1.05, 1.05, 1.05)
	else
		itemGrp:SetState(0)
		arrowGo:SetActive(false)
		bgIma:SetState(0)
		Framework.TransformUtil.SetLocalPos(bgIma.gameObject.transform, -2, 0, 0)
		Framework.TransformUtil.SetLocalScale(bgIma.gameObject.transform, 1, 1, 1)
	end

	scoreTxt.text = tostring(data.score)
	levelTxt.text = data.stageName

	lockGo:SetActive(not data.isOpen)
	MaterialMgr.updateItemByStr(scoreImaGo, self._challCfg.scoreStr)
	GameUtil.asBtn(cell):AddClickListener(function()
		if not data.isOpen then
			FloatWordMgr.instance:show("需通关上一个关卡")

			return
		end

		self:_showChoiseStageInfo(cell.data)
	end, self)
end

function FeinChallengeBattleView:_showChoiseStageInfo(index)
	if self._curIndex == checknumber(index) then
		return
	end

	self._curIndex = index or self._curIndex

	self._moshiListSR:ReloadData()

	for i = 1, #self._petPosList do
		if self._petPosList[i] then
			MaterialMgr.resetAll(self._petPosList[i])
		end
	end

	local groupCfg = self._curMoshiDatas[self._curIndex]

	if groupCfg then
		local allPets = MoonKingModel.instance:getMoonkingStageMasters(groupCfg.creepsMasterId)

		if allPets == nil or #allPets == 0 then
			return
		end

		for i = 1, #allPets do
			if allPets[i] and allPets[i].posId and self._petPosList[allPets[i].posId] then
				local subLua = MaterialMgr.setCell(MatType.Pet, allPets[i].raceId, self._petPosList[allPets[i].posId])

				subLua.binder:setAutoTips(false)
			end
		end
	end
end

function FeinChallengeBattleView:_updateRewardCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local itemCountTxt = goutil.findChildTextComponent(cell, "itemCountTxt")
	local itemClickGo = goutil.findChild(cell, "itemClickBtn")
	local receivedGo = goutil.findChild(cell, "receivedGo")

	MaterialMgr.resetAll(goodsGo)
	GameUtil.asBtn(itemClickGo):RemoveClickListener()

	if self._prizeEffList[cell] then
		UIEffectManager.instance:stopEffect(self._prizeEffList[cell])

		self._prizeEffList[cell] = nil
	end

	if data.prizes and data.prizes[1] then
		MaterialMgr.setCellByCfg(data.prizes[1], goodsGo)
	end

	itemCountTxt.text = tostring(data.score)

	receivedGo:SetActive(data.isFinish)

	if not data.isFinish and data.isFull then
		self._prizeEffList[cell] = UIEffectManager.instance:playEffect(self, "fx_ui_qirirenwu/fx_qirirenwu_kelingqu.prefab", cell, 0, 0, true, nil, nil, function(_, eff)
			eff:setParent(cell.transform)
			eff:setScale(1.1)
			eff:setLocalPos(0, 15, 0)
			eff:setClipping(self._srContent)
		end)
	end

	GameUtil.asBtn(itemClickGo):AddClickListener(function()
		if data.isFinish then
			FloatWordMgr.instance:show("此奖励已领取过")

			return
		end

		if not data.isFull then
			FloatWordMgr.instance:show("不满足可领取条件")

			return
		end

		MoonKingController.instance:csGetMoonShadowKingChallengeGainScorePrizeReq(self._challCfg.challengeId, data.id)
	end, self)
end

function FeinChallengeBattleView:_onRewardReloadFinish()
	if checknumber(self._moveViewIndex) > 0 then
		self._rewardListSR:MoveCellInView(self._moveViewIndex - 1, false)
	end
end

function FeinChallengeBattleView:_onCellUpdatePosition()
	local contentGo = self._rewardListSR:GetContent()

	if self._curRewardDatas then
		if not #self._curRewardDatas then
			local count = 0

			GameUtil.setWidth(contentGo, count * 140 + 35)
			Framework.TransformUtil.SetLocalPos(self.progBarGo.transform, contentGo.transform.localPosition.x, -50, 0)
		end
	end
end

function FeinChallengeBattleView:_updateShowProgressBar()
	if self._curRewardDatas then
		if not #self._curRewardDatas then
			local count = 0

			GameUtil.setWidth(self.progBarGo, count * 140)

			if count == 0 or self._moonkingInfo.totalScore <= 0 then
				self.progBarSli.value = 0

				return
			end

			local once = 1 / count
			local value = 0

			self._moveViewIndex = 1

			for i = 1, count do
				if self._curRewardDatas[i] then
					if self._curRewardDatas[i].isFinish and i > self._moveViewIndex then
						self._moveViewIndex = i
					end

					if self._curRewardDatas[i].score <= self._moonkingInfo.totalScore then
						value = value + once
					else
						local syc = 0

						if self._curRewardDatas[i - 1] and self._curRewardDatas[i - 1].score > 0 then
							syc = self._curRewardDatas[i - 1].score
						end

						local temp = (self._moonkingInfo.totalScore - syc) * once / (self._curRewardDatas[i].score - syc)

						value = value + temp

						break
					end
				end
			end

			self.progBarSli.value = value

			if count > self._moveViewIndex then
				self._moveViewIndex = self._moveViewIndex + 1
			end
		end
	end
end

function FeinChallengeBattleView:_onClickNanduBtn()
	if self._curIndex == nil or self._curMoshiDatas == nil or self._curMoshiDatas[self._curIndex] == nil then
		return
	end

	if not self._curMoshiDatas[self._curIndex].isOpen then
		FloatWordMgr.instance:show("需通关上一个关卡")

		return
	end

	MoonKingController.instance:csGetMoonShadowKingChallengeGetStageInfoReq(self._challCfg.challengeId, self._moonkingInfo.curGroupId, self._curMoshiDatas[self._curIndex])
end

return FeinChallengeBattleView
