-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginjiustageView.lua

module("logic.extensions.originjiu.view.OriginjiustageView", package.seeall)

local OriginjiustageView = class("OriginjiustageView", ViewComponent)

function OriginjiustageView:ctor()
	OriginjiustageView.super.ctor(self)
end

function OriginjiustageView:unbindEvents()
	OriginjiustageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnBoss)
	GameUtil.rmClickHandler(self._btnTip)

	for i, cell in ipairs(self._stageGoList) do
		local btn = goutil.findChild(cell, "btn")

		GameUtil.rmClickHandler(btn)
	end

	for i, mainGo in ipairs(self._buffGoList) do
		GameUtil.rmClickHandler(mainGo)
	end
end

function OriginjiustageView:bindEvents()
	OriginjiustageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onResetClick, self)
	GameUtil.addClickHandler(self._btnBoss, self._onBossClick, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)

	for i, cell in ipairs(self._stageGoList) do
		local btn = goutil.findChild(cell, "btn")

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onStageClick, self, i))
	end

	for i, mainGo in ipairs(self._buffGoList) do
		GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onBuffClick, self, i))
	end
end

function OriginjiustageView:buildUI()
	OriginjiustageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnReset = self:getGo("btnReset")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._stageGoList = {}

	for i = 1, 3 do
		local go = self:getGo("stage_" .. i)

		table.insert(self._stageGoList, go)
	end

	self._iconBoss = self:getGo("boss/btn/icon")
	self._passBoss = self:getGo("boss/btn/tagPass")
	self._tagLockBoss = self:getGo("boss/btn/tagLock")
	self._btnBoss = self:getGo("boss/btn")
	self._bubbleBoss = self:getGo("boss/bubble")
	self._itemBubbleBoss = self:getGo("boss/bubble/item")
	self._tagHasGainBoss = self:getGo("boss/bubble/tagHasGain")
	self._buffCol = self:getGo("buffCol")
	self._buffGoList = {}

	for idx = 1, self._buffCol.transform.childCount do
		local mainGo = self._buffCol.transform:GetChild(idx - 1).gameObject

		table.insert(self._buffGoList, mainGo)
	end

	self._txtBuffTips = self:getTxt("buffTips/txt")
	self._buffTips = self:getGo("buffTips")
	self._strBuffTips = self._txtBuffTips.text

	GameUtil.SetActive(self._buffTips, false)

	self._signCol = self:getGo("signCol")
	self._btnGainBuffSign = self:getGo("signCol/btnGain")
	self._txtDescBuffSign = self:getTxt("signCol/txtDesc")
	self._redBuffSign = self:getGo("signCol/cell/red")
end

function OriginjiustageView:onExit()
	OriginjiustageView.super.onExit(self)

	if self._lockHpScrollListDic then
		for k, scrollList in pairs(self._lockHpScrollListDic) do
			scrollList:dispose()

			self._lockHpScrollListDic[k] = nil
		end
	end

	if self._lockRaceScrollListDic then
		for k, scrollList in pairs(self._lockRaceScrollListDic) do
			scrollList:dispose()

			self._lockRaceScrollListDic[k] = nil
		end
	end

	MaterialMgr.clearIcon(self._iconBoss)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuffSign)
end

function OriginjiustageView:onEnter()
	OriginjiustageView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 577001
	end

	local params = self:getOpenParam() or {}

	self._modelId = checknumber(params[2])

	local modelData = OriginJiuConfig.instance:getModelData(self._activityId, self._modelId)

	self._selectedBuffIdx = 0

	self.addGEvent(self, GlobalNotify.ORIGIN_JIU_INFO_UPDATE, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.ORIGIN_JIU_RESET, self._getInfo, self)
	self:_getInfo()

	local isNeedSign = modelData.effectSignInBuff

	if isNeedSign then
		SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuffSign, function(param)
			self:_updateBuffSignUI(param)
		end)
	end

	GameUtil.SetActive(self._signCol, isNeedSign)
	self:_refreshUI()
end

function OriginjiustageView:_getInfo()
	OriginJiuController.instance:sendGetInfo(self._activityId)
end

function OriginjiustageView:_updateBuffSignUI(param)
	GameUtil.SetActive(self._redBuffSign, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuffSign.text = buffCfg.des or "点击激活Buff"
	end
end

function OriginjiustageView:_refreshUI()
	local info = OriginJiuModel.instance:getInfo(self._activityId) or {}

	OriginJiuModel.instance:resetAllPetLockState(self._activityId, self._modelId)

	local currentPhaseId = OriginJiuModel.instance:getCurrentChallengePhaseId(self._activityId, self._modelId)

	for phaseId, mainGo in ipairs(self._stageGoList) do
		local isPass = OriginJiuModel.instance:isPassPhase(self._activityId, self._modelId, phaseId)
		local clgType = OriginJiuModel.instance:getStageClgType(self._activityId, self._modelId, phaseId)
		local isPhaseGainedPrize = OriginJiuModel.instance:isPhaseGainedPrize(self._activityId, self._modelId, phaseId)
		local phaseData = OriginJiuConfig.instance:getPhaseData(self._activityId, self._modelId, phaseId)
		local tagSelect = goutil.findChild(mainGo, "btn/tagSelect")
		local tagPass = goutil.findChild(mainGo, "btn/tagPass")
		local lockHpGo = goutil.findChild(mainGo, "lockHp")
		local lockPetGo = goutil.findChild(mainGo, "lockPet")
		local bubble = goutil.findChild(mainGo, "bubble")
		local itemBubble = goutil.findChild(mainGo, "bubble/item")
		local tagHasGain = goutil.findChild(mainGo, "bubble/tagHasGain")

		GameUtil.SetActive(tagSelect, phaseId == currentPhaseId)
		GameUtil.SetActive(tagPass, isPass)
		GameUtil.SetActive(lockHpGo, false)
		GameUtil.SetActive(lockPetGo, false)

		local prize = phaseData.prize
		local isNeedBubble = not string.nilorempty(prize)

		if isNeedBubble then
			MaterialMgr.setCellByCfg(prize, itemBubble)
		else
			MaterialMgr.resetAll(itemBubble)
		end

		GameUtil.SetActive(bubble, isNeedBubble)
		GameUtil.SetActive(tagHasGain, isPhaseGainedPrize)

		if clgType == OriginJiuModel.ClgType_Wheel then
			local scrView = goutil.findChild(mainGo, "lockHp/scrView")
			local scrCell = goutil.findChild(mainGo, "lockHp/scrCell")
			local tagEmpty = goutil.findChild(mainGo, "lockHp/tagEmpty")

			GameUtil.SetActive(lockHpGo, true)

			local phaseInfo = OriginJiuModel.instance:getPhaseInfo(self._activityId, self._modelId, phaseId)

			if phaseInfo and phaseInfo.wheelInfo then
				if not phaseInfo.wheelInfo.wheelTeam then
					local wheelTeam = {}
					local lockHpList = {}

					for i, team in ipairs(wheelTeam or {}) do
						for j, pet in ipairs(team.pets or {}) do
							local petId = pet.petId
							local petMo = BagPetsController.instance:getPet(petId)
							local raceId = petMo and petMo:getDefineId()

							if petMo and petMo._maxHp > 0 then
								if not petMo._maxHp then
									local maxHp = 0

									if pet.leftHp < 0 then
										table.insert(lockHpList, {
											hpRate = 1,
											raceId = raceId
										})
									else
										local hpRate = maxHp > 0 and checknumber(pet.leftHp / maxHp) or 0

										hpRate = Mathf.Clamp(hpRate, 0, 1)

										table.insert(lockHpList, {
											raceId = raceId,
											hpRate = hpRate
										})
									end
								end
							end
						end
					end

					GameUtil.SetActive(tagEmpty, #lockHpList == 0)

					self._lockHpScrollListDic = self._lockHpScrollListDic or {}

					if not self._lockHpScrollListDic[mainGo] then
						local scrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateLockHpCell, self), GameUtil.handler(self._clearLockHpCell, self))

						self._lockHpScrollListDic[mainGo] = scrollList

						scrollList:reloadData(lockHpList)
						scrollList:dragNotifyParent()
					end
				end
			end
		elseif clgType == OriginJiuModel.ClgType_LockPet then
			local scrView = goutil.findChild(mainGo, "lockPet/scrView")
			local scrCell = goutil.findChild(mainGo, "lockPet/scrCell")
			local tagEmpty = goutil.findChild(mainGo, "lockPet/tagEmpty")

			GameUtil.SetActive(lockPetGo, true)

			local phaseInfo = OriginJiuModel.instance:getPhaseInfo(self._activityId, self._modelId, phaseId)
			local lockPetInfo = phaseInfo and phaseInfo.lockPetInfo

			if lockPetInfo then
				if not lockPetInfo.lockPetRaceIds then
					local lockPetRaceIds = {}
					local lockRaceList = {}

					for i, raceId in ipairs(lockPetRaceIds) do
						table.insert(lockRaceList, raceId)
					end

					GameUtil.SetActive(tagEmpty, #lockRaceList == 0)

					self._lockRaceScrollListDic = self._lockRaceScrollListDic or {}

					if not self._lockRaceScrollListDic[mainGo] then
						local scrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateLockRaceCell, self), GameUtil.handler(self._clearLockRaceCell, self))

						self._lockRaceScrollListDic[mainGo] = scrollList

						scrollList:reloadData(lockRaceList)
						scrollList:dragNotifyParent()
					end
				end
			end
		end
	end

	GameUtil.SetActive(self._buffCol, self._modelId == OriginJiuModel.ModelId_Ext)

	for phaseId, mainGo in ipairs(self._buffGoList) do
		local buffId = phaseId
		local notGet = goutil.findChild(mainGo, "notGet")
		local icon = goutil.findChild(mainGo, "icon")
		local isPassPhase = OriginJiuModel.instance:isPassPhase(self._activityId, self._modelId, phaseId)

		GameUtil.SetActive(notGet, not isPassPhase)
		GameUtil.setUIImageSpriteIdx(icon, buffId - 1)
	end

	self:_updateBuffTagSelect()

	local isKilledBoss = OriginJiuModel.instance:isKilledBoss(self._activityId, self._modelId)
	local isOpenBoss = OriginJiuModel.instance:isEnoughBoss(self._activityId, self._modelId)
	local modelData = OriginJiuConfig.instance:getModelData(self._activityId, self._modelId)
	local actData = OriginJiuConfig.instance:getActivityData(self._activityId)

	if actData then
		if not actData.bossSkinId then
			local bossSkinId = 0

			MaterialMgr.setIcon(self._iconBoss, MatType.Pet, bossSkinId)

			local bossPrize = modelData and modelData.bossPrize
			local isNeedBossBubble = not string.nilorempty(bossPrize)

			GameUtil.SetActive(self._bubbleBoss, isNeedBossBubble)

			if isNeedBossBubble then
				MaterialMgr.setCellByCfg(bossPrize, self._itemBubbleBoss)
			else
				MaterialMgr.resetAll(self._itemBubbleBoss)
			end

			GameUtil.SetActive(self._tagHasGainBoss, isKilledBoss)
			GameUtil.SetActive(self._passBoss, isKilledBoss)
			GameUtil.SetActive(self._tagLockBoss, not isOpenBoss)

			local resetResult = self:_getTryResetResultAndTips(false)

			GameUtil.SetGray(self._btnReset, resetResult ~= GameEnum.ResultCode.Success)

			if self._modelId == OriginJiuModel.ModelId_Nor then
				local hadGainBossPrize = OriginJiuModel.instance:hadGainBossPrize(self._activityId, self._modelId)

				GameUtil.SetActive(self._btnReset, not hadGainBossPrize)
			else
				GameUtil.SetActive(self._btnReset, true)
			end
		end
	end
end

function OriginjiustageView:_updateBuffTagSelect()
	for buffId, mainGo in ipairs(self._buffGoList) do
		local data = OriginJiuConfig.instance:getBuffData(self._activityId, buffId)
		local name = data and data.name
		local txtName = goutil.findChildTextComponent(mainGo, "txt")
		local tagSelect = goutil.findChild(mainGo, "tagSelect")

		GameUtil.SetActive(tagSelect, self._selectedBuffIdx == buffId)

		txtName.text = name
	end

	local buffData = OriginJiuConfig.instance:getBuffData(self._activityId, self._selectedBuffIdx)
	local sourceDesc = buffData and buffData.sourceDesc
	local desc = buffData and buffData.desc

	self._txtBuffTips.text = string.format(self._strBuffTips, sourceDesc, desc)

	GameUtil.SetActive(self._buffTips, buffData ~= nil)
end

function OriginjiustageView:_onBuffClick(idx)
	self._selectedBuffIdx = self._selectedBuffIdx == idx and 0 or idx

	self:_updateBuffTagSelect()
end

function OriginjiustageView:_updateLockHpCell(view, cell, info, tag)
	local raceId = info.raceId
	local hpRate = info.hpRate
	local isDie = hpRate <= 0
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tagDie = goutil.findChild(mainGo, "tagDie")
	local hpSliderGo = goutil.findChild(mainGo, "hpSlider")
	local hpSlider = Framework.SliderAdapter.GetFrom(mainGo, "hpSlider")
	local fillChangeComp = goutil.findChildComponent(mainGo, "hpSlider/FillArea/Fill", ComponentType.UIImageColorChange)
	local txtProgress = goutil.findChildTextComponent(mainGo, "hpSlider/txtProgress")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

	if proxy then
		proxy.binder:setClickCallBack(nil)
		proxy.binder:setGray(isDie)
	end

	local hpValue = hpRate
	local level = Mathf.Clamp(math.floor(hpValue * 10) - 1, 0, 9)

	if fillChangeComp then
		fillChangeComp:SetState(level)
	end

	hpSlider:SetValue(hpValue)

	txtProgress.text = string.format("%d%%", hpValue * 100)

	GameUtil.SetActive(tagDie, isDie)
	GameUtil.SetActive(hpSliderGo, not isDie)
end

function OriginjiustageView:_clearLockHpCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function OriginjiustageView:_updateLockRaceCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

	if proxy then
		proxy.binder:setClickCallBack(nil)
	end
end

function OriginjiustageView:_clearLockRaceCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function OriginjiustageView:_onResetClick()
	local result = self:_getTryResetResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否确认重置本层所有关卡？"

	local function okFunc()
		OriginJiuController.instance:sendPM_OriginJiuClgResetReq(self._activityId, self._modelId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function OriginjiustageView:_onStageClick(idx)
	local result = self:_getTryEnterPhaseResultAndTips(true, idx)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if idx == OriginJiuModel.PHASE_MODE_1 then
		UIStateManager.instance:push(ViewName.OriginjiumodeView, self._activityId, self._modelId, OriginJiuModel.PHASE_MODE_1)
	elseif idx == OriginJiuModel.PHASE_MODE_2 then
		UIStateManager.instance:push(ViewName.OriginjiumodeView, self._activityId, self._modelId, OriginJiuModel.PHASE_MODE_2)
	elseif idx == OriginJiuModel.PHASE_MODE_3 then
		UIStateManager.instance:push(ViewName.OriginjiumodeView, self._activityId, self._modelId, OriginJiuModel.PHASE_MODE_3)
	end
end

function OriginjiustageView:_onBossClick()
	local result = self:_getTryEnterBossResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	OriginJiuController.instance:enterBossBattle(self._activityId, self._modelId)
end

function OriginjiustageView:_onClickBtnTips()
	local actData = OriginJiuConfig.instance:getActivityData(self._activityId)
	local key = actData and actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginjiustageView:_getTryEnterPhaseResultAndTips(isShowTips, phaseId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间范围内"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local currentPhaseId = OriginJiuModel.instance:getCurrentChallengePhaseId(self._activityId, self._modelId)

		if currentPhaseId ~= 0 and currentPhaseId ~= phaseId then
			result = GameEnum.ResultCode.Error
			tips = "有正在挑战的关卡"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function OriginjiustageView:_getTryEnterBossResultAndTips(isShowTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间范围内"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isKilledBoss = OriginJiuModel.instance:isKilledBoss(self._activityId, self._modelId)

		if isKilledBoss then
			result = GameEnum.ResultCode.Error
			tips = "boss已击杀"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isOpen = OriginJiuModel.instance:isEnoughBoss(self._activityId, self._modelId)

		if not isOpen then
			result = GameEnum.ResultCode.Error
			tips = "boss未开启"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function OriginjiustageView:_getTryResetResultAndTips(isShowTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间范围内"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isHavePassStage = false
		local stageDatass = OriginJiuConfig.instance:getStageDatass(self._activityId, self._modelId)

		for phaseId, datas in ipairs(stageDatass or {}) do
			for stageId, data in ipairs(datas or {}) do
				local isPass = OriginJiuModel.instance:isPassStage(self._activityId, self._modelId, phaseId, stageId)

				if isPass then
					isHavePassStage = true

					break
				end
			end
		end

		if not isHavePassStage then
			result = GameEnum.ResultCode.Error
			tips = "无需重置"
		end
	end

	if result == GameEnum.ResultCode.Success and self._modelId == OriginJiuModel.ModelId_Nor then
		local hadGainBossPrize = OriginJiuModel.instance:hadGainBossPrize(self._activityId, self._modelId)

		if hadGainBossPrize then
			result = GameEnum.ResultCode.Error
			tips = "已通关，不可重置"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return OriginjiustageView
