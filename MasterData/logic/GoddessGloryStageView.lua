-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryStageView.lua

module("logic.extensions.goddessglory.view.GoddessGloryStageView", package.seeall)

local GoddessGloryStageView = class("GoddessGloryStageView", ViewComponent)

function GoddessGloryStageView:buildUI()
	GoddessGloryStageView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("txtTitle/btnTip")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTip = self:getTxt("tip/txtTip")
	self._imgNode = self:getGo("con")
	self._txtRemainEvts = self:getTxt("Remain/txtRemain")

	self:_initEventsNode()

	self._energyIcon = self:getGo("energy/icon")
	self._energyNum = self:getTxt("energy/num")
	self._buffNode = self:getGo("buffNode")
	self._buffTips = self:getTxt("buffNode/showTxt")
	self._buffHeadIcon = self:getGo("buffNode/headIcon")
	self._clickMask = self:getGo("clickMask")
end

function GoddessGloryStageView:_initEventsNode()
	self._eventsNode = self:getGo("events")
	self._btnEvent = self:getBtn("events/btnEvent")
	self._btnChanllenge = self:getBtn("events/btnChanllenge")
	self._evtsLayout = self:getGo("events/node"):GetComponent(ComponentType.UILayoutSingleLine)
end

function GoddessGloryStageView:bindEvents()
	GoddessGloryStageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._btnEvent:AddClickListener(self._onClickAllEvent, self)
	self._btnChanllenge:AddClickListener(self._onClickRechallenge, self)
end

function GoddessGloryStageView:unbindEvents()
	GoddessGloryStageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnEvent:RemoveClickListener()
	self._btnChanllenge:RemoveClickListener()
end

function GoddessGloryStageView:onEnter()
	GoddessGloryStageView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryRetset, self._onGoddeddGloryRetset, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryDoEvent, self._onGoddeddGloryDoEvent, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryFormations, self._onGoddeddGloryFormations, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGlorySelPets, self._onGoddeddGlorySelPets, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryStageInfo, self._onGoddeddGloryStageInfo, self)
	self._clickMask:SetActive(false)

	self._isPlayingFinishedEvt = nil
	self._lastExecutingEvents = nil
	self._challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	self._stageId = GoddessGloryModel.instance:getCurStageId()
	self._stageMo = GoddessGloryModel.instance:getGoddessGloryStage(self._challengeId, self._stageId)
	self._txtTitle.text = self._stageMo.stageName

	MaterialMgr.setIcon(self._energyIcon, MatType.Item_Fake, GoddessGloryModel.instance:getEnergyItemId())
	self:_createImage()
	self:_refreshGoddesGloryStageView()
	self:_startGoddesGloryStage()

	if not self._stageMo.stageInfos then
		GoddessGloryController.instance:requestGoddessGloryGetInfoReq(self._challengeId, self._stageId)
	end

	if not GoddessGloryFmtModel.instance:getFormation(self._challengeId, self._stageId) then
		GoddessGloryController.instance:requestGoddessGloryGetForm(self._challengeId, self._stageId)
	end

	self:_showBuff()
end

function GoddessGloryStageView:onExit()
	GoddessGloryStageView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryRetset, self._onGoddeddGloryRetset, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryDoEvent, self._onGoddeddGloryDoEvent, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGlorySelPets, self._onGoddeddGlorySelPets, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryStageInfo, self._onGoddeddGloryStageInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryFormations, self._onGoddeddGloryFormations, self)

	if self._goImage then
		goutil.destroy(self._goImage)

		self._goImage = nil
	end

	self._isBossAppearing = nil
	self._justFinishedEvtId = nil
	self._isPlayingFinishedEvt = nil
	self._lastExecutingEvents = nil

	self:_stopFinishedEventEffect()
	self:_stopBossAppearEffect()
	self._clickMask:SetActive(false)
	MaterialMgr.clearIcon(self._buffHeadIcon)
	MaterialMgr.clearIcon(self._energyIcon)

	local nodeCnt = self._evtsLayout.transform.childCount

	for i = 1, nodeCnt do
		local go = self._evtsLayout.transform:GetChild(i - 1).gameObject
		local iconReward = goutil.findChild(go, "btn/txtReward/icon")
		local evtIconPet = goutil.findChild(go, "btn/evtIconPet")
		local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

		btn:RemoveClickListener()
		MaterialMgr.clearIcon(iconReward)
		MaterialMgr.clearIcon(evtIconPet)
	end

	self._challengeId = nil
	self._stageId = nil
	self._stageMo = nil
	self._executingEvents = nil
	self._currShowEvents = nil
	self._needRefreshAfterFinishEff = nil
end

function GoddessGloryStageView:_showBuff()
	local buffCo = GoddessGloryConfig.instance:getBuffCo(self._stageId)

	if not buffCo then
		self._buffNode:SetActive(false)

		return
	end

	self._buffNode:SetActive(true)

	self._buffTips.text = buffCo.desc

	MaterialMgr.setIcon(self._buffHeadIcon, MatType.Pet, buffCo.raceIds[1])
end

function GoddessGloryStageView:_createImage()
	local imgPath = self._stageMo.image

	if string.nilorempty(imgPath) then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(imgPath)

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self._goImage = goutil.clone(mainAsset)

	self._goImage.transform:SetParent(self._imgNode.transform, false)

	local stageCo = GoddessGloryConfig.instance:getStageCo(self._challengeId, self._stageId)

	if not stageCo.imagePose[3] then
		local x, y, scale = stageCo.imagePose[1] or 0, stageCo.imagePose[2] or 0, 1

		Framework.TransformUtil.SetLocalPos(self._imgNode.transform, x, y, 0)
		Framework.TransformUtil.SetLocalScale(self._imgNode.transform, scale, scale, scale)
	end
end

function GoddessGloryStageView:_onClickClose()
	self:close()
end

function GoddessGloryStageView:_onClickTips()
	ViewMgr.instance:open(ViewName.GoddesGloryStageRulesView)
end

function GoddessGloryStageView:_onClickAllEvent()
	ViewMgr.instance:open(ViewName.GoddessGloryEventsView)
end

function GoddessGloryStageView:_onClickRechallenge()
	TipsFacade.instance:openPopupWindow(lang("tip"), "是否重新进行挑战，重新挑战将清空所有的进度？", function()
		GoddessGloryController.instance:requestGoddessGloryReset(self._challengeId, self._stageId)
	end, function()
		return
	end, "确定", "取消")
end

function GoddessGloryStageView:_onGoddeddGloryStageInfo(challengeId, stageId)
	if challengeId ~= self._challengeId or stageId ~= self._stageId then
		return
	end

	self:_refreshGoddesGloryStageView()
	self:_startGoddesGloryStage()
end

function GoddessGloryStageView:_onGoddeddGlorySelPets(challengeId, stageId)
	self:_onGoddeddGloryStageInfo(challengeId, stageId)
end

function GoddessGloryStageView:_onGoddeddGloryDoEvent(challengeId, stageId, eventId)
	self:_onGoddeddGloryStageInfo(challengeId, stageId)
end

function GoddessGloryStageView:_onGoddeddGloryRetset(challengeId, stageId)
	self:close()
end

function GoddessGloryStageView:_onGoddeddGloryFormations(challengeId, stageId)
	self:_refreshEvents()
end

function GoddessGloryStageView:_refreshGoddesGloryStageView()
	self._txtRemainEvts.text = "剩余事件数量：" .. self._stageMo:getLeftEventCount()
	self._txtTip.text = self._stageMo.tips
	self._energyNum.text = tostring(self._stageMo:getEnergy())
end

function GoddessGloryStageView:_startGoddesGloryStage()
	self._executingEvents = {}

	self._clickMask:SetActive(false)

	if not self._stageMo.stageInfos then
		self._eventsNode:SetActive(false)

		return
	end

	if GoddessGloryController.instance.showStageRuleWhileOpening and not GoddessGloryModel.instance:hasShowedGoddessGloryStageRules(self._challengeId, self._stageId) then
		ViewMgr.instance:open(ViewName.GoddesGloryStageRulesView, function()
			self:_startGoddesGloryStage()
		end)

		GoddessGloryController.instance.showStageRuleWhileOpening = false

		return
	end

	self._eventsNode:SetActive(true)

	if not GoddessGloryPetsModel.instance:hasPet(self._challengeId, self._stageId) then
		self:_startSelectpPets()
	else
		self:_refreshEvents()
	end
end

function GoddessGloryStageView:_initEvents()
	self._justFinishedEvtId = GoddessGloryModel.instance:getJustFinishedEvtId()

	GoddessGloryModel.instance:resetJustFinishedEvtId()

	self._isPlayingFinishedEvt = nil

	local currSlotsInfo, lastSlotInfos = GoddesGloryEvtSlotModel.instance:getSlots()

	self._lastExecutingEvents = lastSlotInfos or currSlotsInfo
	self._executingEvents = currSlotsInfo

	if self._justFinishedEvtId == 0 then
		self._currShowEvents = {}

		for i = 1, #currSlotsInfo do
			if currSlotsInfo[i].event then
				table.insert(self._currShowEvents, currSlotsInfo[i])
			end
		end

		return
	end

	self._isPlayingFinishedEvt = true

	local lastNum = 0
	local currNum = 0

	for i = 1, #self._lastExecutingEvents do
		if self._lastExecutingEvents[i].event then
			lastNum = lastNum + 1
		end
	end

	for i = 1, #self._executingEvents do
		if self._executingEvents[i].event then
			currNum = currNum + 1
		end
	end

	self._currShowEvents = lastSlotInfos

	if lastNum == currNum then
		self._needRefreshAfterFinishEff = nil
	else
		self._needRefreshAfterFinishEff = true
	end
end

function GoddessGloryStageView:_refreshEvents()
	self:_playBossAppearEffect()
	self:_initEvents()
	self:_refreshCurrShowEvents()
	self:_playFinishedEventEffect()
end

function GoddessGloryStageView:_refreshCurrShowEvents()
	local items = self._evtsLayout
	local childCount = items.transform.childCount
	local refeshEvts
	local itemNum = #self._currShowEvents

	while childCount < itemNum do
		UGUIToolHelper.AddChild(items.gameObject, items.transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, itemNum do
		local data = self._currShowEvents[i].event
		local go = items.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		self:_fillEvent(go, data)
	end

	for i = itemNum + 1, childCount do
		local go = items.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	items:Layout()
end

function GoddessGloryStageView:_playFinishedEventEffect()
	if not self._isPlayingFinishedEvt then
		return
	end

	local idx, event

	for i = 1, #self._lastExecutingEvents do
		local data = self._lastExecutingEvents[i].event

		if data and data.instanceId == self._justFinishedEvtId then
			idx = i
			event = data

			break
		end
	end

	if not idx then
		return
	end

	self._clickMask:SetActive(true)

	local effPath = self:_getRfreshEffPath(event)
	local posGo = self._evtsLayout.transform:GetChild(idx - 1).gameObject

	self._finishEvtEff = UIEffectManager.instance:playEffectBrief(self, effPath, posGo, false, function()
		if self._needRefreshAfterFinishEff then
			local btn = goutil.findChild(posGo, "btn")

			btn:SetActive(false)
		else
			self._currShowEvents = self._executingEvents

			self:_refreshCurrShowEvents()
		end
	end)

	self._finishEvtEff:setParent(posGo.transform)
	self._finishEvtEff:setLocalPos(-68, 0, 0)
	self._finishEvtEff:setScale(1)
	self._finishEvtEff:setEffTime(2)

	function self._finishEvtEff.finishHandler()
		self._finishEvtEff = nil

		if not self._bossAppearEff then
			self._clickMask:SetActive(false)
		end

		self._isPlayingFinishedEvt = nil

		if self._needRefreshAfterFinishEff then
			self:_refreshEvents()
		end
	end
end

function GoddessGloryStageView:_stopFinishedEventEffect()
	if self._finishEvtEff then
		UIEffectManager.instance:stopEffect(self._finishEvtEff)

		self._finishEvtEff = nil
	end
end

function GoddessGloryStageView:_getRfreshEffPath(evtData)
	local path = "20220304/nvshenrongyao/nvshenrongyao_perfab/"
	local evtCo = GoddessGloryConfig.instance:getEventCo(evtData.eventId)

	if evtCo.type == GoddessGloryEvtType.Challenge then
		if evtCo.isBossEvent then
			return path .. "fx_ui_nvshenrongyao_xiaoshi_red.prefab"
		end

		return path .. "fx_ui_nvshenrongyao_xiaoshi_blue.prefab"
	else
		return path .. "fx_ui_nvshenrongyao_xiaoshi_green.prefab"
	end
end

function GoddessGloryStageView:_playBossAppearEffect()
	self._isBossAppearing = self._stageMo.isBossAppear
	self._stageMo.isBossAppear = false

	if not self._isBossAppearing then
		return
	end

	self._clickMask:SetActive(true)

	local effPath = "20220304/nvshenrongyao/nvshenrongyao_perfab/fx_ui_nvshenrongyao_boss.prefab"

	self._bossAppearEff = UIEffectManager.instance:playEffectBrief(self, effPath, self.mainGO, false)

	self._bossAppearEff:setParent(self.mainGO.transform)
	self._bossAppearEff:setLocalPos(0, 0, 0)
	self._bossAppearEff:setScale(1)
	self._bossAppearEff:setEffTime(1.5)

	function self._bossAppearEff.finishHandler()
		self._bossAppearEff = nil

		if not self._isPlayingFinishedEvt then
			self._clickMask:SetActive(false)
		end
	end
end

function GoddessGloryStageView:_stopBossAppearEffect()
	if self._bossAppearEff then
		UIEffectManager.instance:stopEffect(self._bossAppearEff)

		self._bossAppearEff = nil
	end
end

function GoddessGloryStageView:_fillEvent(go, evtData)
	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	btn:RemoveClickListener()

	if not evtData then
		btn.gameObject:SetActive(false)

		return
	end

	btn.gameObject:SetActive(true)

	local evtCo = GoddessGloryConfig.instance:getEventCo(evtData.eventId)
	local imgTitle = goutil.findChildComponent(go, "btn/imgTitle", ComponentType.UIImageSpriteChange)
	local imgBg = btn:GetComponent(ComponentType.UIImageSpriteChange)
	local iconEvt = goutil.findChildComponent(go, "btn/evtIcon", ComponentType.UIImageSpriteChange)
	local txtDesc = goutil.findChildTextComponent(go, "btn/txtDesc")
	local evtIconPet = goutil.findChild(go, "btn/evtIconPet")

	if evtCo.type == GoddessGloryEvtType.Challenge and evtCo.isBossEvent then
		imgTitle:SetState(GoddessGloryEvtType.Boss - 1)
		imgBg:SetState(GoddessGloryEvtType.Boss - 1)
	else
		imgTitle:SetState(evtCo.type - 1)
		imgBg:SetState(evtCo.type - 1)
	end

	txtDesc.text = evtCo.desc

	self:_fillRewards(go, evtCo, evtData)
	btn:AddClickListener(function()
		GoddessGloryController.instance:exexuteEvent(evtData)
	end)

	if evtCo.type == GoddessGloryEvtType.Challenge or evtCo.type == GoddessGloryEvtType.Boss then
		iconEvt.gameObject:SetActive(false)
		evtIconPet:SetActive(true)
		MaterialMgr.setIcon(evtIconPet, MatType.Pet, evtCo.evtPetIcon)
	else
		iconEvt.gameObject:SetActive(true)
		evtIconPet:SetActive(false)
		iconEvt:SetState(evtCo.type - 1)
	end
end

function GoddessGloryStageView:_fillRewards(go, evtCo, evtData)
	local txtReward = goutil.findChildTextComponent(go, "btn/txtReward")
	local iconReward = goutil.findChild(go, "btn/txtReward/icon")
	local typeReward = goutil.findChildTextComponent(go, "btn/txtReward/txt")

	MaterialMgr.setIcon(iconReward, MatType.Item_Fake, GoddessGloryModel.instance:getEnergyItemId())

	if evtCo.energy > 0 then
		txtReward.gameObject:SetActive(true)

		typeReward.text = "奖励："
		txtReward.text = "x" .. evtCo.energy
	elseif evtCo.cost > 0 then
		txtReward.gameObject:SetActive(true)

		typeReward.text = "消耗："
		txtReward.text = "x" .. evtCo.cost
	else
		txtReward.gameObject:SetActive(false)
	end
end

function GoddessGloryStageView:_startSelectpPets()
	local petList = BagPetsController.instance:getFightBagPet()
	local maps = {}
	local singleList = {}

	if petList then
		for i = 1, #petList do
			if not maps[petList[i].raceId] then
				maps[petList[i].raceId] = true

				local mo = FightingPowerPetMo.getMaxPetMoByData(petList[i])

				mo.summonMasterId = 0
				mo.summonedPetId = 0

				local petCo = CharacterConfig.instance:getPetCo(mo.raceId)

				mo.name = petCo.name

				table.insert(singleList, mo)
			end
		end
	end

	PetSelectController.instance:OpenView(5, "需要选择5只精灵", nil, function(petIds)
		GoddessGloryController.instance:requestGoddessGlorySelectPet(self._challengeId, self._stageId, petIds)
	end, function()
		self:close()
	end, nil, nil, singleList, true, true)
end

function GoddessGloryStageView:_checkBoss()
	return
end

return GoddessGloryStageView
