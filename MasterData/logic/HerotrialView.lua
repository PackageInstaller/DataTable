-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialView.lua

module("logic.extensions.herotrial.view.HerotrialView", package.seeall)

local HerotrialView = class("HerotrialView", ViewComponent)

function HerotrialView:ctor()
	HerotrialView.super.ctor(self)
end

function HerotrialView:buildUI()
	HerotrialView.super.buildUI(self)

	self.btnChallenge = self:getBtn("btnChallenge")
	self.btnRank = self:getBtn("btnRank")
	self.btnRankReward = self:getBtn("btnRankReward")
	self.petNameGo = self:getGo("petName")
	self.btnInfo = self:getBtn("petName/btnInfo")
	self.btnClose = self:getBtn("leftTop/btnClose")
	self.btnTip = self:getBtn("leftTop/btnTip")
	self.verifyGo = self:getGo("verify")
	self.btnVerify = self:getBtn("verify/btnVerify")
	self.btnVerifyTip = self:getBtn("verify/btnVerifyTip")
	self.txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "verify/txtVerifyEffect")
	self.imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "verify/imgEffect")
	self.txtVerifyPower = goutil.findChildTextComponent(self.mainGO, "verify/txtVerifyPower")
	self.contentTime = self:getGo("openTime")
	self.openTimeCell = self:getGo("openTimeCell")
	self._pet = goutil.findChild(self.mainGO, "verify/iconHead")
	self.txtPetName = goutil.findChildTextComponent(self.mainGO, "verify/txtPetName")
	self._cellList = {}
	self._nextRewardMainGo = self:getGo("reward")
	self.txtDamage = self:getGo("reward/txtDamage"):GetComponent(goutil.Type_UIText)
	self._nextRankRewardCon1 = self:getGo("reward/itemGroup/item1")
	self._nextRankRewardCon2 = self:getGo("reward/itemGroup/item2")
	self._nextRankRewardCon3 = self:getGo("reward/itemGroup/item3")

	goutil.setActive(self._nextRewardMainGo, false)

	self._rewardRedpoint = self:getGo("btnRankReward/redPoint")
	self.roleModel = self:getGo("roleModel")
	self.goBubble = self:getGo("bubble")
end

function HerotrialView:bindEvents()
	HerotrialView.super.bindEvents(self)
	self.btnChallenge:AddClickListener(self._onClickChallenge, self)
	self.btnRank:AddClickListener(self._onClickRank, self)
	self.btnRankReward:AddClickListener(self._onClickRankReward, self)
	self.btnInfo:AddClickListener(self._onClickInfo, self)
	self.btnClose:AddClickListener(self._onClickClose, self)
	self.btnTip:AddClickListener(self._onClickTip, self)
	self.btnVerify:AddClickListener(self._onClickVerify, self)
	self.btnVerifyTip:AddClickListener(self._onClickVerifyTip, self)
end

function HerotrialView:unbindEvents()
	HerotrialView.super.unbindEvents(self)
	self.btnChallenge:RemoveClickListener()
	self.btnRank:RemoveClickListener()
	self.btnRankReward:RemoveClickListener()
	self.btnInfo:RemoveClickListener()
	self.btnClose:RemoveClickListener()
	self.btnTip:RemoveClickListener()
	self.btnVerify:RemoveClickListener()
	self.btnVerifyTip:RemoveClickListener()
end

function HerotrialView:destroyUI()
	HerotrialView.super.destroyUI(self)
end

function HerotrialView:onEnter()
	HerotrialView.super.onEnter(self)

	if not HerotrialController.instance:checkIfOpen() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.HeroTrialGetInfo, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.HeroTrialVerifySuccess, self._refresh, self)
	GlobalDispatcher:addListener(TimelimitrankController.UPDATE_REDPOINT, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)

	local isFirstOpen = UnityEngine.PlayerPrefs.GetInt("firstopen_draw_longyan_ht" .. LoginModel.instance.userId)

	if isFirstOpen == 0 then
		ViewBlockMgr.instance:blockClick(true, self)
		AnimationPlayer.play("storyconfig/animations/cc_longyan.txt", self._onAnimationPlayFinished, function()
			PetCvController.instance:_playPetCvByIndex(10143, 3, false, null)
		end, self)
		UnityEngine.PlayerPrefs.SetInt("firstopen_draw_longyan_ht" .. LoginModel.instance.userId, 1)
	end

	GameUtil.SetActive(self.verifyGo, false)
	GameUtil.SetActive(self.goBubble, false)
	GameUtil.SetActive(self.petNameGo, false)
	HerotrialController.instance:getHeroTrialInfo()
end

function HerotrialView:_onAnimationPlayFinished()
	ViewBlockMgr.instance:blockClick(false, self)
end

function HerotrialView:onEnterFinished()
	HerotrialView.super.onEnterFinished(self)
end

function HerotrialView:onExit()
	MaterialMgr.resetAll(self._pet)

	for k, v in ipairs(self._cellList) do
		goutil.destroy(v)
	end

	table.clear(self._cellList)
	GlobalDispatcher:removeListener(GlobalNotify.HeroTrialGetInfo, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.HeroTrialVerifySuccess, self._refresh, self)
	GlobalDispatcher:removeListener(TimelimitrankController.UPDATE_REDPOINT, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	MaterialMgr.resetAll(self._nextRewardMainGo)
	self.imgEffect:ClearImage()

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	removetimer(self._closeBubble, self)
	HerotrialView.super.onExit(self)
end

function HerotrialView:onExitFinished()
	HerotrialView.super.onExitFinished(self)
end

function HerotrialView:_refresh()
	self:ShowRoleModel()

	local activityId = HerotrialModel.instance:getActivityId()
	local higestVerifiedZdl = HerotrialModel.instance:getHigestVerifiedZdl()

	if #self._cellList == 0 then
		local data_versions = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.HeroTrial)
		local versions = {}

		for k, v in pairs(data_versions) do
			table.insert(versions, v)
		end

		table.sort(versions, function(a, b)
			return a.activityId < b.activityId
		end)

		for k, v in pairs(versions) do
			local cell = goutil.cloneAndSetParent(self.openTimeCell, self.contentTime.transform)
			local isOpen = v.activityId == activityId

			self:_setCell(cell, v, isOpen)
			table.insert(self._cellList, cell)
		end
	end

	local verifyCfg = HerotrialController.instance:getCurVerifyPlan(higestVerifiedZdl)

	if verifyCfg then
		local color = "60ee85"
		local verifyName = string.format(verifyCfg.name, color)
		local verifyDes = string.format(verifyCfg.des, color)

		self.txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)
	else
		self.txtVerifyEffect.text = "未激活鼓舞"
	end

	local highestDamage = HerotrialModel.instance:getHighestDamage()
	local htCfg = HerotrialConfig.instance:getHeroTrialActivity(activityId)

	MaterialMgr.setCell(MatType.Pet, htCfg.verifyRaceId, self._pet)

	self.txtPetName.text = CharacterConfig.instance:getPetCo(htCfg.verifyRaceId).name

	local higestVerifiedZdl = HerotrialModel.instance:getHigestVerifiedZdl()

	self.txtVerifyPower.text = "已验证最佳战力：" .. higestVerifiedZdl

	GameUtil.SetActive(self.verifyGo, true)

	local plans = HerotrialConfig.instance:getVerifyPlans(activityId)
	local tempStr = string.split((verifyCfg or nil) and verifyCfg.bossBuff, ":")
	local buffId = tempStr[1]
	local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

	self.imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))

	local progressPrizeId = HerotrialConfig.instance:getHeroTrialActivity(activityId).progressPrizeId
	local prizeCfg = TimelimitrankConfig.instance:getProgressPrizeById(progressPrizeId)
	local prizeList = {}

	for k, v in pairs(prizeCfg) do
		table.insert(prizeList, v)
	end

	table.sort(prizeList, function(a, b)
		return a.progress < b.progress
	end)

	local curPrize

	for i, v in ipairs(prizeList) do
		if highestDamage < v.progress then
			curPrize = v

			break
		end
	end

	if curPrize then
		local list = string.split(curPrize.prize, "#")

		for i, v in ipairs(list) do
			self["_nextRankRewardCon" .. i]:SetActive(true)
			MaterialMgr.setCellByCfg(v, self["_nextRankRewardCon" .. i])
		end

		goutil.setActive(self._nextRewardMainGo, true)

		self.txtDamage.text = "总伤害达到\n" .. curPrize.progress
	else
		goutil.setActive(self._nextRewardMainGo, false)
		goutil.setActive(self._rewardRedpoint, false)
	end

	self:_updateRedPoint()
end

function HerotrialView:_onClickTip()
	TipsFacade.instance:openRulesView("herotrialrule")
end

function HerotrialView:_setCell(cell, data, isOpen)
	local activityId = data.activityId

	GameUtil.SetActive(cell, true)

	local goOn = goutil.findChild(cell, "on")

	GameUtil.SetActive(goOn, isOpen)

	local txtContent = goutil.findChildTextComponent(cell, "txtOpenTime")
	local timeObj = GameUtil.time2date(RoleModel.instance:GetRole().areaOpenTime / 1000 - 18000)
	local areaOpenTime = checknumber(timeObj.day) + data.startDay - 1
	local intervalTime = data.durationDay
	local endTime = areaOpenTime + intervalTime - 1
	local maxDay = GameUtil.GetMonthMaxDay(timeObj.year, timeObj.month) + 1

	if maxDay <= areaOpenTime then
		areaOpenTime = areaOpenTime % maxDay + 1
	end

	if maxDay <= endTime then
		endTime = endTime % maxDay + 1
	end

	local heroCfg = HerotrialConfig.instance:getHeroTrialActivity(activityId)

	txtContent.text = string.format("%d日-%d日    %s", areaOpenTime, endTime, heroCfg.name)
end

function HerotrialView:_onClickChallenge()
	HerotrialController.instance:realTimeUpdate(function()
		UIStateManager.instance:push(ViewName.HerotrialMissionView)
	end)
end

function HerotrialView:_onClickRank()
	HerotrialController.instance:realTimeUpdate(function()
		local activityId = HerotrialModel.instance:getActivityId()
		local htCfg = HerotrialConfig.instance:getHeroTrialActivity(activityId)

		TimelimitrankController.instance:pushView(htCfg.activityId)
	end)
end

function HerotrialView:_onClickRankReward()
	HerotrialController.instance:realTimeUpdate(function()
		local activityId = HerotrialModel.instance:getActivityId()
		local htCfg = HerotrialConfig.instance:getHeroTrialActivity(activityId)

		TimelimitrankController.instance:pushPrizeView(htCfg.activityId)
	end)
end

function HerotrialView:_onClickInfo()
	HerotrialController.instance:realTimeUpdate(function()
		local creepId = HerotrialModel.instance:getCreepsId()
		local suppportCfg = HerotrialConfig.instance:getHeroSupport(creepId)

		PetbookController.instance:openPetinfoView(suppportCfg.raceId)
	end)
end

function HerotrialView:_onClickClose()
	self:close()
end

function HerotrialView:_onClickVerify()
	HerotrialController.instance:realTimeUpdate(function()
		UIStateManager.instance:push(ViewName.HerotrialverifyView)
	end)
end

function HerotrialView:ShowRoleModel()
	local creepId = HerotrialModel.instance:getCreepsId()
	local suppportCfg = HerotrialConfig.instance:getHeroSupport(creepId)
	local petCfg = CharacterConfig.instance:getPetCo(suppportCfg.raceId)

	if petCfg == nil then
		printError("精灵配置为空 ,id", suppportCfg.raceId)

		return
	end

	GameUtil.SetActive(self.goBubble, true)
	GameUtil.SetActive(self.petNameGo, true)

	local rare = CharacterConfig.instance:getRareByAwakenLv(petCfg.initAwakenLv, petCfg.raceId)
	local modelOff = CharacterConfig.instance:getModelUIPosAndScale("petcollege", suppportCfg.raceId)

	if not modelOff[1] then
		if not modelOff[2] then
			local posy = 0

			if not modelOff[3] then
				local scale = 1

				self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, petCfg.faceIds, self.roleModel, scale, nil, nil, modelOff[1], posy)
			end
		end
	end
end

function HerotrialView:_updateRedPoint()
	goutil.setActive(self._rewardRedpoint, RedPointModel.instance:isActive(66))
end

function HerotrialView:_onClickVerifyTip()
	HerotrialController.instance:realTimeUpdate(function()
		UIStateManager.instance:push(ViewName.HTVerifytipView)
	end)
end

return HerotrialView
