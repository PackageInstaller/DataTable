-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilybossView.lua

module("logic.extensions.family.view.FamilybossView", package.seeall)

local FamilybossView = class("FamilybossView", TableViewComponent)

function FamilybossView:ctor()
	FamilybossView.super.ctor(self)
end

function FamilybossView:bindEvents()
	FamilybossView.super.bindEvents(self)
	self.closeBtn:AddClickListener(self.close, self)
	self.tipBtn:AddClickListener(function()
		TipsFacade.instance:openRulesView("FamilyBoss")
	end, self)
	self.leftPageBtn:AddClickListener(function()
		self:onClickSwitch(true)
	end, self)
	self.rightPageBtn:AddClickListener(self.onClickSwitch, self)
	self.sweepBtn:AddClickListener(self.onClickSweep, self)
	self.challengeBtn:AddClickListener(self.onClickChallenge, self)
end

function FamilybossView:unbindEvents()
	FamilybossView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.tipBtn:RemoveClickListener()
	self.leftPageBtn:RemoveClickListener()
	self.rightPageBtn:RemoveClickListener()
	self.sweepBtn:RemoveClickListener()
	self.challengeBtn:RemoveClickListener()
end

function FamilybossView:onExit()
	FamilybossView.super.onExit(self)
	removetimer(self._updateTimer, self)

	self.skillItemList = {}

	GlobalDispatcher:removeListener(FamilyModel.GetUnlockedBossInfosRes, self.resUnlockBossInfos, self)
	GlobalDispatcher:removeListener(FamilyModel.SweepBossRes, self.setChallengeBtnStatus, self)
	GlobalDispatcher:removeListener(FamilyModel.OpenBossChallengeRes, self.setChallengeBtnStatus, self)

	for go, _ in pairs(self._matCellGoList) do
		MaterialMgr.resetAll(go)
	end

	self._matCellGoList = {}
end

function FamilybossView:destroyUI()
	FamilybossView.super.destroyUI(self)
end

function FamilybossView:buildUI()
	FamilybossView.super.buildUI(self)

	self.goldBarCon = self:getGo("goldBarCon")

	local btnRoot = self:getGo("staticBtnGroup")

	self.closeBtn = self:getBtn("staticBtnGroup/closeBtn")
	self.tipBtn = self:getBtn("staticBtnGroup/tipBtn")
	self.openTipText = goutil.findChildTextComponent(self.mainGO, "staticTextGroup/Text")
	self.leftPageBtn = self:getBtn("staticBtnGroup/bossBtn1")
	self.rightPageBtn = self:getBtn("staticBtnGroup/bossBtn2")
	self.leftPageBtnDot = self:getGo("staticBtnGroup/bossBtn1/dot")
	self.rightPageBtnDot = self:getGo("staticBtnGroup/bossBtn2/dot")
	self._leftPageBtnChange = self:getBtn("staticBtnGroup/bossBtn1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._rightPageBtnChange = self:getBtn("staticBtnGroup/bossBtn2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._leftPageBtnText = goutil.findChildTextComponent(self.leftPageBtn, "text")
	self._rightPageBtnText = goutil.findChildTextComponent(self.rightPageBtn, "text")
	self.sweepBtn = self:getBtn("staticBtnGroup/sweepBtn")
	self.challengeBtn = self:getBtn("staticBtnGroup/challengeBtn")
	self.openChallengeBtn = self:getBtn("staticBtnGroup/openChallengeBtn")
	self.challengeBtnDot = goutil.findChild(btnRoot, "challengeBtn/dot")
	self.challengeBtnTextCon = goutil.findChild(btnRoot, "challengeBtnTextCon")
	self._timeGo = goutil.findChild(self.challengeBtnTextCon, "timeGo")
	self._timeTxt = goutil.findChildTextComponent(self._timeGo, "timeTxt")
	self.skillItemCon = self:getGo("skillItemGroup")
	self.skillItemCloneGo = self:getGo("skillItemGroup/skillItem")
	self.challengeLeftTimeText = goutil.findChildTextComponent(self.challengeBtnTextCon, "text")

	local rightGroup = self:getGo("rightGroup")

	self.ruleDescText = goutil.findChildTextComponent(rightGroup, "ruleDescText")
	self._livenessCon = goutil.findChild(rightGroup, "livenessProgress")
	self._livenessSlider = self._livenessCon:GetComponent(typeof(Framework.SliderAdapter))
	self._livenessText = goutil.findChildTextComponent(self._livenessCon, "livenessText")
	self.skillTipView = self:getGo("skillItemGroup/skillTip")
	self.skillTipViewNameText = goutil.findChildTextComponent(self.skillTipView, "txtSkillName")
	self.skillTipViewDesText = goutil.findChildTextComponent(self.skillTipView, "txtSkillDesc")

	local dragContent = self:getGo("role/dragContent")

	self._dragContent = Framework.UIDragTrigger.Get(dragContent)

	local rawImg = goutil.findChild(dragContent, "role_image_1")

	self._rawImgDrag = RawImageDrag.New(dragContent, rawImg)

	self._rawImgDrag:setUpdateCallback(self._updateRoleCell, self)

	self._imgBossNameChange = self:getGo("rightGroup/imgBossName"):GetComponent(ComponentType.UIImageSpriteChange)
	self._lockTipGo = self:getGo("rightGroup/lockTip")
	self._txtLockTip = goutil.findChildTextComponent(self.mainGO, "rightGroup/lockTip/txtLockTip")

	GameUtil.SetActive(self._timeGo, false)
end

function FamilybossView:onEnter()
	FamilybossView.super.onEnter(self)

	self._matCellGoList = {}

	local btnList = {
		{
			showAdd = false,
			id = GameEnum.GoldType.FamilyCoin
		}
	}

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btnList)

	self._curBossIndex = 1

	GlobalDispatcher:addListener(FamilyModel.GetUnlockedBossInfosRes, self.resUnlockBossInfos, self)
	GlobalDispatcher:addListener(FamilyModel.SweepBossRes, self.setChallengeBtnStatus, self)
	GlobalDispatcher:addListener(FamilyModel.OpenBossChallengeRes, self.setChallengeBtnStatus, self)
	FamilyController.instance:sendGetUnlockedBossInfosReq()
end

function FamilybossView:resUnlockBossInfos()
	self._bossCfgDatas = FamilyModel.instance:getAllFamilyBossCfgs()

	local initBossId = checknumber(self:getFirstParam())

	if initBossId > 0 then
		self:_centerOnIndex(self:_getRealIndex(initBossId), false)
	else
		self:_centerOnIndex(1, false)
	end

	if self._bossCfgDatas[1] then
		self._leftPageBtnText.text = self._bossCfgDatas[1].name

		GameUtil.SetActive(self.leftPageBtnDot, FamilyModel.instance:isBossCanBattle(self._bossCfgDatas[1].id))
	else
		self._leftPageBtnText.text = "Boss"

		GameUtil.SetActive(self.leftPageBtnDot, false)
	end

	if self._bossCfgDatas[2] then
		self._rightPageBtnText.text = self._bossCfgDatas[2].name

		GameUtil.SetActive(self.rightPageBtnDot, FamilyModel.instance:isBossCanBattle(self._bossCfgDatas[2].id))
	else
		self._rightPageBtnText.text = "Boss"

		GameUtil.SetActive(self.rightPageBtnDot, false)
	end
end

function FamilybossView:onClickSwitch(isLeft)
	self._curBossIndex = checknumber(self._curBossIndex)

	if isLeft and self._curBossIndex == 1 or not isLeft and self._curBossIndex == 2 then
		return
	end

	local index = self._curBossIndex + (isLeft and -1 or 1)

	if not self._bossCfgDatas[index] then
		return
	end

	self:_centerOnIndex(index, true)
end

function FamilybossView:_centerOnIndex(idx, isSpring)
	idx = checknumber(idx)

	if idx >= 1 and idx <= #self._bossCfgDatas then
		self._rawImgDrag:setMaxNum(#self._bossCfgDatas)
		self._rawImgDrag:centerOnIndex(idx, isSpring, idx == 1)
	else
		print("invalid idx = " .. tostring(idx))
	end
end

function FamilybossView:_updateRoleCell(idx, cell)
	local petPhotoShow = PetPhotoShow.Get(cell.gameObject)

	self._curBossIndex = checknumber(idx)

	self:switchBoss()

	local bossId = self._bossCfgDatas[self._curBossIndex].id
	local creepCfg = FamilyConfig.instance:getBossCreepsCfg(bossId)[1]

	petPhotoShow:showPetEffect(creepCfg.raceId, true, nil, "familyboss")

	self._curPetPhotoShow = petPhotoShow

	PetCvController.instance:turnOffCurCv(nil, nil, true)
end

function FamilybossView:switchBoss()
	removetimer(self._updateTimer, self)

	local bossCfg = self._bossCfgDatas[self._curBossIndex]

	self:setSkillItems(bossCfg.id)

	self._curViewDatas = string.split(bossCfg.rewardShow, "#")

	self:reloadData()

	self._leftTime = 0

	local info = FamilyModel.instance:getUnlockedBossInfo(bossCfg.id)

	if info and checknumber(info.endTimeMillis) > 0 then
		self._leftTime = 2 + math.ceil(info.endTimeMillis / 1000) - ServerTime.now()

		settimer(1, self._updateTimer, self)
	end

	self:setChallengeBtnStatus()

	if self._leftTime > 0 and self._timeGo.activeSelf then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._leftTime)

		self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
	end

	self._leftPageBtnChange:SetState(self._curBossIndex == 1 and 1 or 0)
	self._rightPageBtnChange:SetState(self._curBossIndex == 2 and 1 or 0)
	self._imgBossNameChange:SetState(bossCfg.id - 1)
end

function FamilybossView:setSkillItems(bossId)
	self.skillItemGroup = self.skillItemGroup or ItemGroup.New(self.skillItemCon, self.skillItemCloneGo, nil, nil, true)

	local cfg = FamilyConfig.instance:getBossCreepsCfg(bossId)[1]
	local petCo = PetSkinConfig.instance:getPetSkinCfg(cfg.raceId)

	if not petCo then
		printInfo("没精灵配置", cfg.raceId)

		return
	end

	local dataList = {}
	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for _, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.SkillName[skillType]

		if petCo[v] > 0 then
			table.insert(dataList, {
				skillId = petCo[v],
				raceId = cfg.raceId,
				skinId = cfg.faceId
			})
		end
	end

	self.skillItemList = {}

	self.skillItemGroup:updateWithMoArray(dataList, self.handleSkill, self)
	self:switchSkill(nil, false)
end

function FamilybossView:handleSkill(item, data)
	item.selectGo = item.selectGo or goutil.findChild(item.mainGO, "select")
	item.imgIcon = item.imgIcon or goutil.findChild(item.mainGO, "imgIcon")
	item.raycast = item.raycast or goutil.findChild(item.mainGO, "raycast")
	self.skillItemList[data.skillId] = item

	MaterialMgr.setSkillByFaceId(data.skillId, data.raceId, item.imgIcon)

	self._matCellGoList[item.imgIcon] = true

	GameUtil.setLocalPos(item.mainGO, 20, -(item.index - 1) * 100)
	GameUtil.asBtn(item.raycast):AddClickListener(function()
		local skillCfg = BattleConfig.instance:getSkillCo(data.skillId, data.skinId)

		item.selectStatus = not item.selectStatus

		self:switchSkill(data.skillId, item.selectStatus, skillCfg.name, skillCfg.desc, item.mainGO.transform.localPosition)
	end)
end

function FamilybossView:switchSkill(skillId, bool, name, desc, pos)
	for id, item in pairs(self.skillItemList) do
		local realBool = bool and id == skillId

		item.selectStatus = realBool

		GameUtil.SetActive(item.selectGo, realBool)
	end

	GameUtil.SetActive(self.skillTipView, bool)

	if skillId then
		GameUtil.setLocalPos(self.skillTipView, pos.x + 100, pos.y)

		self.skillTipViewNameText.text = name
		self.skillTipViewDesText.text = desc
	end
end

function FamilybossView:setChallengeBtnStatus()
	if self._bossCfgDatas[1] then
		GameUtil.SetActive(self.leftPageBtnDot, FamilyModel.instance:isBossCanBattle(self._bossCfgDatas[1].id))
	else
		GameUtil.SetActive(self.leftPageBtnDot, false)
	end

	if self._bossCfgDatas[2] then
		GameUtil.SetActive(self.rightPageBtnDot, FamilyModel.instance:isBossCanBattle(self._bossCfgDatas[2].id))
	else
		GameUtil.SetActive(self.rightPageBtnDot, false)
	end

	local bossCfg = self._bossCfgDatas[self._curBossIndex]
	local isChallengeOpen = FamilyModel.instance:isChallengeOpen(bossCfg.id)
	local hasChallenge = FamilyModel.instance:hasChallenge(bossCfg.id)
	local isBossLock, openLv = FamilyModel.instance:isBossLock(bossCfg.id)

	isChallengeOpen = isChallengeOpen and not isBossLock

	GameUtil.SetActive(self._livenessCon, not isChallengeOpen and not isBossLock)
	GameUtil.SetActive(self.sweepBtn, hasChallenge and isChallengeOpen)
	GameUtil.SetActive(self.challengeBtn, isChallengeOpen)
	GameUtil.SetActive(self.challengeBtnTextCon, isChallengeOpen)
	GameUtil.SetActive(self._lockTipGo, isBossLock)
	GameUtil.SetGray(self.challengeBtn, FamilyModel.instance:getBossChallegenLeftTime(bossCfg.id) <= 0)

	if isBossLock then
		self._livenessText.text = ""
		self._txtLockTip.text = langPara("text_family_desc_47", openLv)
	else
		self._txtLockTip.text = ""
		self._livenessText.text = "活跃度：\n" .. FamilyModel.instance:getBossLivenessPro(bossCfg.id)
	end

	if isChallengeOpen then
		self.challengeLeftTimeText.text = FamilyModel.instance:getBossChallegenLeftTimeStr(bossCfg.id)

		if bossCfg.contTime > 0 then
			GameUtil.SetActive(self._timeGo, true)

			self._timeTxt.text = ""
		else
			self._timeTxt.text = ""

			GameUtil.SetActive(self._timeGo, false)
		end

		self.challengeLeftTimeText.text = FamilyModel.instance:getBossChallegenLeftTimeStr(bossCfg.id)
	else
		self.challengeLeftTimeText.text = ""

		self._livenessSlider:SetValue(FamilyModel.instance:getBossLivenessRatio(bossCfg.id))
	end

	self.openTipText.text = bossCfg.contTime > 0 and langPara("text_family_desc_45", bossCfg.contTime) or lang("text_family_desc_46")
	self.ruleDescText.text = bossCfg.rule or "没配"
end

function FamilybossView:_updateTimer()
	if checknumber(self._leftTime) <= 0 then
		removetimer(self._updateTimer, self)

		return
	end

	self._leftTime = self._leftTime - 1

	if self._leftTime <= 0 then
		removetimer(self._updateTimer, self)
		FamilyController.instance:sendGetUnlockedBossInfosReq()
	end

	if self._timeGo.activeSelf then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._leftTime)

		self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
	end
end

function FamilybossView:onClickSweep()
	local bossCfg = self._bossCfgDatas[self._curBossIndex]

	if bossCfg == nil then
		return
	end

	if FamilyModel.instance:getBossChallegenLeftTime(bossCfg.id) <= 0 then
		FloatWordMgr.instance:show(lang("text_family_desc_48"))

		return
	end

	UIStateManager.instance:open(ViewName.FamilybosssweepView, bossCfg.id)
end

function FamilybossView:onClickChallenge()
	local bossCfg = self._bossCfgDatas[self._curBossIndex]

	if bossCfg == nil then
		return
	end

	local info = FamilyModel.instance:getUnlockedBossInfo(bossCfg.id)
	local endTimeMillis = info and checknumber(info.endTimeMillis) or 0

	if endTimeMillis <= 0 then
		FloatWordMgr.instance:show(lang("text_family_desc_50"))
		FamilyController.instance:sendGetUnlockedBossInfosReq()

		return
	end

	if FamilyModel.instance:getBossChallegenLeftTime(bossCfg.id) <= 0 then
		FloatWordMgr.instance:show(lang("text_family_desc_49"))
	else
		UIStateManager.instance:push(ViewName.FamilyBossMissionview, bossCfg.id)
	end
end

function FamilybossView:_getRealIndex(bossId)
	local index = 1

	for i, v in ipairs(self._bossCfgDatas) do
		if v.id == bossId then
			index = i

			break
		end
	end

	return index
end

function FamilybossView:_getPath()
	return {
		cellPath = "rightGroup/rewardCon",
		viewPath = "rightGroup/ScrollView"
	}
end

function FamilybossView:handleBossReward(item, data)
	local component = GameUtil.AddLuaOnce(item.mainGO, FamilyBossRewardItem)

	component:setData(data, item.index)
end

function FamilybossView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell, FamilyBossRewardItem)

	component:setData(data, cell.data)
end

function FamilybossView:_clearTableview(cell)
	local component = GameUtil.AddLuaOnce(cell, FamilyBossRewardItem)

	component:onExit()
end

return FamilybossView
