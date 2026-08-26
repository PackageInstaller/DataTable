-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarGameCoinView.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarGameCoinView", package.seeall)

local V3a9RacingCarGameCoinView = class("V3a9RacingCarGameCoinView", BaseView)
local MaxComboPopupInstancesPerLevel = 8

function V3a9RacingCarGameCoinView:onInitView()
	self._btnspeedUp = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/#btn_speedUp")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp/#go_unUse/#image_progress")
	self._goThumb = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp/#go_unUse/#go_Thumb")
	self._btnspeedUp2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/#btn_speedUp_2")
	self._btnspeedUp3 = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/#btn_speedUp_3")
	self._goThumb3 = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp_3/#go_unUse/#go_Thumb")
	self._imagerole = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp/#image_role")
	self._imagerole2 = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_2/#image_role2")
	self._imagerole3 = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_3/#image_role3")
	self._golevel1 = gohelper.findChild(self.viewGO, "root/Right/Combo/#go_level1")
	self._golevel2 = gohelper.findChild(self.viewGO, "root/Right/Combo/#go_level2")
	self._golevel3 = gohelper.findChild(self.viewGO, "root/Right/Combo/#go_level3")
	self._goperform = gohelper.findChild(self.viewGO, "root/Left/#go_perform")
	self._simageName = gohelper.findChildSingleImage(self.viewGO, "root/Left/#go_perform/#simage_Name")
	self._thumbRadius = 120
	self._comboCount = 0
	self._comboLevelConfig = {
		{
			levelIndex = 1,
			min = 1,
			max = 3
		},
		{
			levelIndex = 2,
			min = 4,
			max = 8
		},
		{
			levelIndex = 3,
			min = 9,
			max = math.huge
		}
	}
	self._currentComboLevel = 0
	self._levelTemplates = {
		self._golevel1,
		self._golevel2,
		self._golevel3
	}
	self._levelPools = {
		{},
		{},
		{}
	}
	self._instanceDisplayDuration = 1
	self._instanceFloatHeight = 80
	self._instanceFloatDuration = 1
	self._instanceLifetimes = {}
	self._instanceLifetimePool = {}
	self._comboContainer = gohelper.findChild(self.viewGO, "root/Right/Combo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarGameCoinView:addEvents()
	self._btnspeedUp:AddClickListener(self._btnspeedUpOnClick, self)
	self._btnspeedUp2:AddClickListener(self._btnspeedUp2OnClick, self)
	self._btnspeedUp3:AddClickListener(self._btnspeedUp3OnClick, self)
end

function V3a9RacingCarGameCoinView:removeEvents()
	self._btnspeedUp:RemoveClickListener()
	self._btnspeedUp2:RemoveClickListener()
	self._btnspeedUp3:RemoveClickListener()
end

function V3a9RacingCarGameCoinView:_btnspeedUp2OnClick()
	if not self._canClick or self._isUsingUltimate then
		return
	end

	if not self._player or not self._player:tryUseUltimateSkill() then
		return
	end
end

function V3a9RacingCarGameCoinView:_updateUltimateInfo()
	local energy = Time.deltaTime * self._ultimateParams.ultimateCostEnergy
	local currentEnergy = self._player:getCurrentEnergy()

	currentEnergy = math.max(currentEnergy - energy, 0)

	self._player:clearEnergy(currentEnergy)

	if currentEnergy <= 0 then
		self._isUsingUltimate = false

		self._animatorUsing:Play("close", self._usingCloseDone, self)
		TaskDispatcher.cancelTask(self._updateUltimateInfo, self)

		if self._player and self._player.resetUltimateSkillState then
			self._player:resetUltimateSkillState()
		end

		local removeBuffList = self._ultimateParams.ultimateEndRemoveBuff

		if removeBuffList then
			for _, buffId in ipairs(removeBuffList) do
				self._player.buffManager:removeBuffById(buffId, 0)
			end
		end
	end

	self:_updateProgress()
end

function V3a9RacingCarGameCoinView:_usingCloseDone()
	gohelper.setActive(self._goUsing, false)
	gohelper.setActive(self._goUnUse, true)
end

function V3a9RacingCarGameCoinView:_btnspeedUp3OnClick()
	if not self._canClick then
		return
	end

	if not self._player or not self._player:tryUseUltimateSkill() then
		return
	end
end

function V3a9RacingCarGameCoinView:_btnspeedUpOnClick()
	if not self._canClick then
		return
	end

	if not self._player or not self._player:tryUseUltimateSkill() then
		return
	end
end

function V3a9RacingCarGameCoinView:_loadedImage()
	gohelper.onceAddComponent(self._spine.gameObject, gohelper.Type_Image):SetNativeSize()

	local scale = tonumber(self._racer.scale) or 1
	local pos = string.splitToNumber(self._racer.pos, "#")

	transformhelper.setLocalScale(self._spine.transform, scale, scale, 1)
	recthelper.setAnchor(self._spine.transform, pos[1], pos[2])
end

function V3a9RacingCarGameCoinView:_editableInitView()
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnCoinEnergyGain, self._onCoinEnergyGain, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnUltimateEnergyChange, self._onUltimateEnergyChange, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnPerfectDodgeComboChange, self._onPerfectDodgeComboChange, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnUltimateUsed, self._onUltimateUsed, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnRestartGame, self._onRestartGame, self, LuaEventSystem.Low)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnRaceBegin, self._onRaceBegin, self, LuaEventSystem.Low)

	self._player = V3a9RacingCarModel.instance:getPlayerVehicleController()
	self._racer = V3a9RacingCarModel.instance:getMainPlayerRacer()
	self._ultimateParams = self._player:getUltimateParams()
	self._ultimateConfig = self._ultimateParams and self._ultimateParams.ultimateConfig
	self._comboCount = self._player:getPerfectDodgeCombo()

	TaskDispatcher.runRepeat(self._updateInstanceLifetimes, self, 0)

	for _, template in pairs(self._levelTemplates) do
		if template then
			gohelper.setActive(template, false)
		end
	end
end

function V3a9RacingCarGameCoinView:onOpen()
	self._ultimateType = self._ultimateParams.ultimateType
	self._ultimateAllType = self._ultimateType == RacingCarPropEnum.UltimateEnergyType.All
	self._ultimatePerSecondType = self._ultimateType == RacingCarPropEnum.UltimateEnergyType.PerSecond
	self._ultimateSegmentType = self._ultimateType == RacingCarPropEnum.UltimateEnergyType.Segmentation
	self._ultimateName = gohelper.findChildText(self.viewGO, "root/Right/#go_name_1/#txt_name")
	self._ultimateName.text = self._ultimateConfig.name

	gohelper.setActive(self._btnspeedUp, self._ultimateAllType)
	gohelper.setActive(self._btnspeedUp2, self._ultimatePerSecondType)
	gohelper.setActive(self._btnspeedUp3, self._ultimateSegmentType)

	local roleName = "v3a9_racing_game_character_skill_" .. self._racer.pic

	if self._ultimateAllType then
		UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagerole, roleName)

		self._goCanUse = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp/#go_canUse")
		self._goUnUse = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp/#go_unUse")
	elseif self._ultimatePerSecondType then
		UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagerole2, roleName)

		self._goCanUse = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp_2/#go_canUse")
		self._goUnUse = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp_2/#go_unUse")
		self._goUsing = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp_2/#go_Using")
		self._animatorUsing = ZProj.ProjAnimatorPlayer.Get(self._goUsing)
		self._imageProgress = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_2/#go_unUse/#image_progress")
		self._imageMask = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_2/#go_unUse/#image_progressmask")
		self._imageMaskUsing = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_2/#go_Using/#image_progressmask")
		self._txtProgressUsing = gohelper.findChildText(self.viewGO, "root/Right/#btn_speedUp_2/#go_Using/#txt_progress")
		self._txtProgressUnUse = gohelper.findChildText(self.viewGO, "root/Right/#btn_speedUp_2/#go_unUse/#txt_progress")
		self._isUsingUltimate = false

		gohelper.setActive(self._goUnUse, true)
		gohelper.setActive(self._goCanUse, false)
		gohelper.setActive(self._goUsing, false)
	elseif self._ultimateSegmentType then
		UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagerole3, roleName)

		self._imageProgress1 = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_3/#go_unUse/progress/#image_progress_1")
		self._imageProgress2 = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_3/#go_unUse/progress/#image_progress_2")
		self._imageProgress3 = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_3/#go_unUse/progress/#image_progress_3")
		self._imageMask = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp_3/#image_progressmask")
		self._goCanUse = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp_3/#go_canUse")
	end

	TaskDispatcher.runRepeat(self._frameUpdate, self, 0.1)
end

function V3a9RacingCarGameCoinView:_frameUpdate()
	self:_updateProgress()
end

function V3a9RacingCarGameCoinView:onOpenFinish()
	if not string.nilorempty(self._racer.img) then
		self._spine = gohelper.findChildSingleImage(self.viewGO, "root/Left/#go_perform/Mask/spine")

		self._spine:LoadImage(ResUrl.getHeadIconImg(self._racer.img), self._loadedImage, self)
		self._simageName:LoadImage(string.format("singlebg_lang/txt_v3a9_racing_singlebg/v3a9_racing_game_skillname_%s.png", self._racer.skillPic))
	end
end

function V3a9RacingCarGameCoinView:_onRaceBegin()
	self:_updateProgress()
end

function V3a9RacingCarGameCoinView:_onRestartGame()
	self._lastCurrentEnergy = nil

	if self._isUsingUltimate then
		self._isUsingUltimate = false

		gohelper.setActive(self._goUsing, false)
		gohelper.setActive(self._goUnUse, true)
		TaskDispatcher.cancelTask(self._updateUltimateInfo, self)
	end

	if self._player and self._player.resetUltimateSkillState then
		self._player:resetUltimateSkillState()
	end

	self._comboCount = self._player:getPerfectDodgeCombo()

	self:_updateComboDisplay()
	self:_updateProgress()
end

function V3a9RacingCarGameCoinView:_onCoinEnergyGain()
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayBulaochuanGetCandle)
	self:_updateProgress()
end

function V3a9RacingCarGameCoinView:_onUltimateEnergyChange()
	self:_updateProgress()
end

function V3a9RacingCarGameCoinView:_onPerfectDodgeComboChange(comboCount)
	self._comboCount = math.max(0, comboCount or 0)

	self:_updateComboDisplay()
end

function V3a9RacingCarGameCoinView:_onUltimateUsed()
	self:_updateProgress()
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayChongranCastSkillmax)

	if self._ultimatePerSecondType then
		self._isUsingUltimate = true

		gohelper.setActive(self._goUsing, true)
		gohelper.setActive(self._goUnUse, false)
		TaskDispatcher.cancelTask(self._updateUltimateInfo, self)
		TaskDispatcher.runRepeat(self._updateUltimateInfo, self, 0)
	end

	self:_playUltimatePerform()
end

function V3a9RacingCarGameCoinView:_playUltimatePerform()
	if string.nilorempty(self._racer.img) then
		return
	end

	gohelper.setActive(self._goperform, false)
	gohelper.setActive(self._goperform, true)
end

function V3a9RacingCarGameCoinView:_updateProgress()
	local currentEnergy = self._player:getCurrentEnergy()

	if currentEnergy == self._lastCurrentEnergy then
		return
	end

	self._lastCurrentEnergy = currentEnergy

	local maxEnergy = self._ultimateConfig.energy

	if self._ultimateAllType then
		self:_updateUltimateTypeAll(currentEnergy, maxEnergy)
	elseif self._ultimatePerSecondType then
		self:_updateUltimateTypePerSecond(currentEnergy, maxEnergy)
	elseif self._ultimateSegmentType then
		self:_updateUltimateTypeSegment(currentEnergy, maxEnergy)
	end
end

function V3a9RacingCarGameCoinView:_updateUltimateTypeAll(currentEnergy, maxEnergy)
	local percent = currentEnergy / maxEnergy

	percent = math.min(1, percent)
	self._imageprogress.fillAmount = percent
	self._canClick = currentEnergy >= self._ultimateParams.ultimateCostEnergy

	gohelper.setActive(self._goCanUse, self._canClick)
	gohelper.setActive(self._goUnUse, not self._canClick)

	local showThumb = currentEnergy > 0 and percent ~= 1

	gohelper.setActive(self._goThumb, showThumb)

	if showThumb then
		local degree = percent * 360 - 90
		local angleRad = math.rad(-degree)

		recthelper.setAnchor(self._goThumb.transform, math.cos(angleRad) * self._thumbRadius, math.sin(angleRad) * self._thumbRadius)
	end

	if self._canClick then
		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.ActivateUltimate)
	end
end

function V3a9RacingCarGameCoinView:_updateUltimateTypePerSecond(currentEnergy, maxEnergy)
	local percent = currentEnergy / maxEnergy

	percent = math.min(1, percent)
	self._canClick = maxEnergy <= currentEnergy

	gohelper.setActive(self._goCanUse, self._canClick)
	gohelper.setActive(self._goUnUse, not self._canClick)

	if self._isUsingUltimate then
		self._imageMaskUsing.fillAmount = math.max(1 - percent, 0)
		self._txtProgressUsing.text = math.floor(percent * 100) .. "%"
	else
		self._imageMask.fillAmount = math.max(1 - percent, 0)
		self._imageProgress.fillAmount = percent
		self._txtProgressUnUse.text = math.floor(percent * 100) .. "%"
	end
end

function V3a9RacingCarGameCoinView:_updateUltimateTypeSegment(currentEnergy, maxEnergy)
	local percent = currentEnergy / maxEnergy

	percent = math.min(1, percent)
	self._canClick = currentEnergy >= self._ultimateParams.ultimateCostEnergy

	gohelper.setActive(self._goCanUse, self._canClick)

	local ultimateCostEnergy = self._ultimateParams.ultimateCostEnergy

	self._imageMask.fillAmount = math.max(1 - currentEnergy / ultimateCostEnergy, 0)

	local progress1Value = currentEnergy
	local percent1 = math.min(progress1Value / ultimateCostEnergy, 1)

	self._imageProgress1.fillAmount = percent1

	local progress2Value = math.max(progress1Value - ultimateCostEnergy, 0)
	local percent2 = math.min(progress2Value / ultimateCostEnergy, 1)

	self._imageProgress2.fillAmount = percent2

	local progress3Value = math.max(progress2Value - ultimateCostEnergy, 0)
	local percent3 = math.min(progress3Value / ultimateCostEnergy, 1)

	self._imageProgress3.fillAmount = percent3

	local showThumb = false
	local thumbDegree = 0

	if percent3 > 0 then
		showThumb = percent3 < 1
		thumbDegree = Mathf.Lerp(38, 13, percent3)
	elseif percent2 > 0 then
		showThumb = true
		thumbDegree = Mathf.Lerp(75, 50, percent2)
	elseif percent1 > 0 then
		showThumb = true
		thumbDegree = Mathf.Lerp(110, 85, percent1)
	end

	gohelper.setActive(self._goThumb3, showThumb)

	if showThumb then
		local degree = thumbDegree + 90
		local angleRad = math.rad(degree)

		recthelper.setAnchor(self._goThumb3.transform, math.cos(angleRad) * self._thumbRadius, math.sin(angleRad) * self._thumbRadius)
	end
end

function V3a9RacingCarGameCoinView:_getLevelIndexByCombo(comboCount)
	if comboCount <= 0 then
		return 0
	end

	for _, config in ipairs(self._comboLevelConfig) do
		if comboCount >= config.min and comboCount <= config.max then
			return config.levelIndex
		end
	end

	return self._comboLevelConfig[#self._comboLevelConfig].levelIndex
end

function V3a9RacingCarGameCoinView:_updateComboDisplay()
	local newLevel = self:_getLevelIndexByCombo(self._comboCount)

	if newLevel ~= self._currentComboLevel then
		self._currentComboLevel = newLevel
	end

	if self._currentComboLevel > 0 then
		self:_ensureLevelInstances(self._currentComboLevel, self._comboCount)
	end
end

function V3a9RacingCarGameCoinView:_updateInstanceLifetimes()
	local lifetimes = self._instanceLifetimes

	if #lifetimes == 0 then
		return
	end

	local deltaTime = Time.deltaTime

	for i = #lifetimes, 1, -1 do
		local lifetime = lifetimes[i]

		lifetime.remainingTime = lifetime.remainingTime - deltaTime
		lifetime.floatProgress = lifetime.floatProgress + deltaTime / self._instanceFloatDuration

		if lifetime.floatProgress > 1 then
			lifetime.floatProgress = 1
		end

		if lifetime.instance and lifetime.initialY then
			local floatOffset = self:_easeOutCubic(lifetime.floatProgress) * self._instanceFloatHeight

			transformhelper.setLocalPos(lifetime.instance.transform, lifetime.initialX, lifetime.initialY + floatOffset, lifetime.initialZ)
		end

		if lifetime.remainingTime <= 0 then
			self:_recycleInstance(lifetime.instance, lifetime.initialX, lifetime.initialY, lifetime.initialZ)

			local lastIndex = #lifetimes

			lifetimes[i] = lifetimes[lastIndex]
			lifetimes[lastIndex] = nil
			lifetime.instance = nil
			lifetime.levelIndex = nil
			self._instanceLifetimePool[#self._instanceLifetimePool + 1] = lifetime
		end
	end
end

function V3a9RacingCarGameCoinView:_easeOutCubic(t)
	return 1 - math.pow(1 - t, 3)
end

function V3a9RacingCarGameCoinView:_recycleInstance(instance, initialX, initialY, initialZ)
	if not instance then
		return
	end

	gohelper.setActive(instance, false)

	if instance.transform and initialY then
		transformhelper.setLocalPos(instance.transform, initialX, initialY, initialZ)
	end
end

function V3a9RacingCarGameCoinView:_ensureLevelInstances(levelIndex, count)
	local pool = self._levelPools[levelIndex]
	local template = self._levelTemplates[levelIndex]
	local var_30_0

	if not template then
		do return end

		var_30_0 = tonumber(count) or 0
	end

	local comboCount = math.max(0, var_30_0)
	local displayCount = math.min(comboCount, MaxComboPopupInstancesPerLevel)

	while displayCount > #pool do
		local newInstance = gohelper.clone(template, self._comboContainer, "go_level" .. levelIndex .. "_" .. #pool + 1)

		if newInstance then
			local initialX, initialY, initialZ = transformhelper.getLocalPos(newInstance.transform)

			table.insert(pool, newInstance)
			gohelper.setActive(newInstance, true)

			local txtCoin = gohelper.findChildText(newInstance, "txt")

			if txtCoin then
				txtCoin.text = "+" .. comboCount
			end

			self:_registerInstanceLifetime(newInstance, levelIndex, initialX, initialY, initialZ)
		else
			break
		end
	end

	for i = 1, displayCount do
		if pool[i] then
			gohelper.setActive(pool[i], true)

			local txtCoin = gohelper.findChildText(pool[i], "txt")

			if txtCoin then
				txtCoin.text = "+" .. comboCount
			end

			if not self:_isInstanceRegistered(pool[i]) then
				local initialX, initialY, initialZ = transformhelper.getLocalPos(pool[i].transform)

				self:_registerInstanceLifetime(pool[i], levelIndex, initialX, initialY, initialZ)
			end
		end
	end

	for i = displayCount + 1, #pool do
		if pool[i] then
			gohelper.setActive(pool[i], false)
		end
	end
end

function V3a9RacingCarGameCoinView:_registerInstanceLifetime(instance, levelIndex, initialX, initialY, initialZ)
	local recordPool = self._instanceLifetimePool
	local poolCount = #recordPool
	local lifetime = recordPool[poolCount]

	if lifetime then
		recordPool[poolCount] = nil
	else
		lifetime = {}
	end

	lifetime.instance = instance
	lifetime.remainingTime = self._instanceDisplayDuration
	lifetime.levelIndex = levelIndex
	lifetime.initialX = initialX
	lifetime.initialY = initialY
	lifetime.initialZ = initialZ
	lifetime.floatProgress = 0
	self._instanceLifetimes[#self._instanceLifetimes + 1] = lifetime
end

function V3a9RacingCarGameCoinView:_isInstanceRegistered(instance)
	for _, lifetime in ipairs(self._instanceLifetimes) do
		if lifetime.instance == instance then
			return true
		end
	end

	return false
end

function V3a9RacingCarGameCoinView:onClose()
	TaskDispatcher.cancelTask(self._updateUltimateInfo, self)
	TaskDispatcher.cancelTask(self._frameUpdate, self)
end

function V3a9RacingCarGameCoinView:onDestroyView()
	TaskDispatcher.cancelTask(self._updateInstanceLifetimes, self)

	for levelIndex = 1, 3 do
		local pool = self._levelPools[levelIndex]

		for _, instance in ipairs(pool) do
			if instance then
				gohelper.destroy(instance)
			end
		end

		self._levelPools[levelIndex] = {}
	end

	self._instanceLifetimes = {}
	self._instanceLifetimePool = {}
end

return V3a9RacingCarGameCoinView
