-- chunkname: @modules/logic/rouge/dlc/101/view/RougeMapView_1_101.lua

module("modules.logic.rouge.dlc.101.view.RougeMapView_1_101", package.seeall)

local RougeMapView_1_101 = class("RougeMapView_1_101", BaseViewExtended)

RougeMapView_1_101.AssetUrl = "ui/viewres/rouge/dlc/101/rougemapskillview.prefab"
RougeMapView_1_101.ParentObjPath = "Left/#go_rougezhouyu"

local State = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}

function RougeMapView_1_101:onInitView()
	self._heroSkillGO = gohelper.findChild(self.viewGO, "heroSkill")
	self._goSkillDescContent = gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent")
	self._goSkillDescItem = gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent/#go_skillDescItem")
	self._goSkillContent = gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent")
	self._goSkillItem = gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent/#go_skillitem")
	self._btnlimiter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_limiter")
	self._txtrisk = gohelper.findChildText(self.viewGO, "#btn_limiter/#txt_risk")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapView_1_101:addEvents()
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, self._onTouch, self)
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfoPower, self._onUpdateRougeInfoPower, self)
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, self._onChangeMapInfo, self)
	self._btnlimiter:AddClickListener(self._btnlimiterOnClick, self)
end

function RougeMapView_1_101:removeEvents()
	self._btnlimiter:RemoveClickListener()
end

function RougeMapView_1_101:_btnlimiterOnClick()
	local rougeInfo = RougeModel.instance:getRougeInfo()
	local gameLimiterMo = rougeInfo and rougeInfo:getGameLimiterMo()
	local totalRiskValue = gameLimiterMo and gameLimiterMo:getRiskValue() or 0
	local limiterIds = gameLimiterMo and gameLimiterMo:getLimiterIds()
	local limiterBuffIds = gameLimiterMo and gameLimiterMo:getLimiterBuffIds()
	local params = {
		limiterIds = limiterIds,
		buffIds = limiterBuffIds,
		totalRiskValue = totalRiskValue
	}

	RougeDLCController101.instance:openRougeLimiterOverView(params)
end

function RougeMapView_1_101:_editableInitView()
	self._state = State.Simple
	self._detailClick = self:getUserDataTb_()
	self._entryBtnClick = self:getUserDataTb_()
	self._animator = gohelper.onceAddComponent(self._heroSkillGO, gohelper.Type_Animator)

	self:checkAndShowLimiterEntry()
end

function RougeMapView_1_101:checkAndShowLimiterEntry()
	local rougeInfo = RougeModel.instance:getRougeInfo()
	local gameLimiterMo = rougeInfo and rougeInfo:getGameLimiterMo()
	local riskValue = gameLimiterMo and gameLimiterMo:getRiskValue() or 0
	local isShowEntry = gameLimiterMo ~= nil and riskValue > 0

	gohelper.setActive(self._btnlimiter.gameObject, isShowEntry)

	if not isShowEntry then
		return
	end

	self._txtrisk.text = riskValue
end

function RougeMapView_1_101:_onUpdateRougeInfo()
	self:_updateUI()
end

function RougeMapView_1_101:_onUpdateRougeInfoPower()
	self:_updateUI()
end

function RougeMapView_1_101:_onUpdateMapInfo()
	self:_updateUI()
end

function RougeMapView_1_101:_onChangeMapInfo()
	self:_updateUI()
end

function RougeMapView_1_101:_setState()
	if self._state == State.Expanding then
		self._state = State.Detail
	elseif self._state == State.Shrinking then
		self._state = State.Simple
	end
end

function RougeMapView_1_101:_onTouch()
	if self._state == State.Detail then
		TaskDispatcher.runDelay(self._delayDealTouch, self, 0.01)
	end
end

function RougeMapView_1_101:_delayDealTouch()
	if not self._hasClickDetailIcon then
		self:_shrinkDetailUI()
	end

	self._hasClickDetailIcon = nil
end

function RougeMapView_1_101:_shrinkDetailUI()
	self._animator:Play("fight_heroskill_out", 0, 0)
	self._animator:Update(0)

	self._state = State.Shrinking

	TaskDispatcher.runDelay(self._setState, self, 0.533)
end

function RougeMapView_1_101:onOpen()
	self:_updateUI()
end

function RougeMapView_1_101:_getPower()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	return (rougeInfo or nil) and (rougeInfo.power or 0)
end

function RougeMapView_1_101:_getCoint()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	return (rougeInfo or nil) and (rougeInfo.coin or 0)
end

function RougeMapView_1_101:_updateUI()
	self._mapSkills = RougeMapModel.instance:getMapSkillList()

	if self._mapSkills then
		if not #self._mapSkills then
			local mapSkillCount = 0

			self._visible = mapSkillCount > 0

			gohelper.setActive(self._heroSkillGO, self._visible)

			if not self._visible then
				return
			end

			gohelper.CreateObjList(self, self._refreshMapSkillDetail, self._mapSkills, self._goSkillDescContent, self._goSkillDescItem)
			gohelper.CreateObjList(self, self._refreshMapSkillEntry, self._mapSkills, self._goSkillContent, self._goSkillItem)
		end
	end
end

function RougeMapView_1_101:_refreshMapSkillDetail(obj, skillMo, index)
	local mapSkillCo = lua_rouge_map_skill.configDict[skillMo.id]

	if mapSkillCo then
		local canUse = RougeMapSkillCheckHelper.canUseMapSkill(skillMo)
		local goNotCost = gohelper.findChild(obj, "skill1/notcost1")
		local goCanCost = gohelper.findChild(obj, "skill1/cancost1")

		gohelper.setActive(goNotCost, not canUse)
		gohelper.setActive(goCanCost, canUse)

		local iconName = mapSkillCo.icon
		local imageNotCost = gohelper.findChildImage(obj, "skill1/notcost1")
		local imageCost = gohelper.findChildImage(obj, "skill1/cancost1")

		UISpriteSetMgr.instance:setRouge2Sprite(imageNotCost, iconName)
		UISpriteSetMgr.instance:setRouge2Sprite(imageCost, iconName .. "_light")

		local desc = mapSkillCo.desc
		local txtDesc = gohelper.findChildText(obj, "desc1")

		txtDesc.text = desc .. "\nCOST<color=#FFA500>-" .. mapSkillCo.powerCost .. "</color>"

		if not self._detailClick[index] then
			local detailIconClick = gohelper.getClick(obj)

			detailIconClick:AddClickListener(self._onClickSkillIcon, self, index)

			self._detailClick[index] = detailIconClick
		end
	else
		logError("肉鸽地图技能配置不存在:" .. tostring(skillMo.id))
	end
end

function RougeMapView_1_101:_refreshMapSkillEntry(obj, skillMo, index)
	local mapSkillCo = lua_rouge_map_skill.configDict[skillMo.id]

	if mapSkillCo then
		local canUse = RougeMapSkillCheckHelper.canUseMapSkill(skillMo)
		local goNotCost = gohelper.findChild(obj, "notcost")
		local goCanCost = gohelper.findChild(obj, "cancost")

		gohelper.setActive(goNotCost, not canUse)
		gohelper.setActive(goCanCost, canUse)

		local iconName = mapSkillCo.icon
		local imageNotCost = gohelper.findChildImage(obj, "notcost/#image_skill_normal")
		local imageCost = gohelper.findChildImage(obj, "cancost/#image_skill_light")

		UISpriteSetMgr.instance:setRouge2Sprite(imageNotCost, iconName)
		UISpriteSetMgr.instance:setRouge2Sprite(imageCost, iconName .. "_light")

		if not self._entryBtnClick[index] then
			local btnclick = gohelper.findChildButtonWithAudio(obj, "btn_click")

			btnclick:AddClickListener(self._onClickEntrySkillIcon, self, index)

			self._entryBtnClick[index] = btnclick
		end
	else
		logError("肉鸽地图技能配置不存在:" .. tostring(skillMo.id))
	end
end

function RougeMapView_1_101:_onClickEntrySkillIcon(index)
	if self._mapSkills then
		local skillMo = self._mapSkills[index]
		local canUse, reason = RougeMapSkillCheckHelper.canUseMapSkill(skillMo)

		if not canUse and reason == RougeMapSkillCheckHelper.CantUseMapSkillReason.DoingEvent then
			RougeMapSkillCheckHelper.showCantUseMapSkillToast(reason)

			return
		end

		if self._state == State.Simple then
			self._animator:Play("fight_heroskill_tips", 0, 0)
			self._animator:Update(0)

			self._state = State.Expanding

			TaskDispatcher.runDelay(self._setState, self, 0.533)
			AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
		end
	end
end

function RougeMapView_1_101:_onClickSkillIcon(index)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._mapSkills then
		local skillMo = self._mapSkills[index]

		if not skillMo then
			return
		end

		self._hasClickDetailIcon = true

		local canUse, reason = RougeMapSkillCheckHelper.canUseMapSkill(skillMo)

		if canUse then
			local season = RougeModel.instance:getSeason()

			RougeRpc.instance:sendRougeUseMapSkillRequest(season, skillMo.id, function(_, resultCode)
				if resultCode ~= 0 then
					return
				end

				self:_updateUI()
				self:_shrinkDetailUI()
				RougeMapSkillCheckHelper.executeUseMapSkillCallBack(skillMo)
			end)
		else
			RougeMapSkillCheckHelper.showCantUseMapSkillToast(reason)
		end
	end
end

function RougeMapView_1_101:onClose()
	TaskDispatcher.cancelTask(self._delayDealTouch, self)
	TaskDispatcher.cancelTask(self._setState, self)

	for _, detailIconClick in ipairs(self._detailClick) do
		detailIconClick:RemoveClickListener()
	end

	for _, entryIconClick in ipairs(self._entryBtnClick) do
		entryIconClick:RemoveClickListener()
	end

	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, self._onTouch, self)
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfoPower, self._onUpdateRougeInfoPower, self)
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, self._onChangeMapInfo, self)
end

return RougeMapView_1_101
