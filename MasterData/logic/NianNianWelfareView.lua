-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/view/NianNianWelfareView.lua

module("logic.extensions.niannianwelfare.view.NianNianWelfareView", package.seeall)

local NianNianWelfareView = class("NianNianWelfareView", ViewComponent)

function NianNianWelfareView:unbindEvents()
	NianNianWelfareView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._welfareBtn:RemoveClickListener()
	self._awardBtn:RemoveClickListener()
	self._knowledgeBtn:RemoveClickListener()

	for i, v in ipairs(self._stove) do
		v.btn:RemoveClickListener()
	end

	self._refiningBtn:RemoveClickListener()
end

function NianNianWelfareView:bindEvents()
	NianNianWelfareView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._welfareBtn:AddClickListener(self._onClickWelfare, self)
	self._awardBtn:AddClickListener(self._onClickAward, self)
	self._knowledgeBtn:AddClickListener(self._onClickKnowledge, self)

	for i, v in ipairs(self._stove) do
		v.btn:AddClickListener(function()
			self:_onClickStove(i)
		end)
	end

	self._refiningBtn:AddClickListener(self._onClickRefining, self)
end

function NianNianWelfareView:buildUI()
	NianNianWelfareView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._tipBtn = self:getBtn("btnTip")
	self._welfareBtn = self:getBtn("btnWelfare")
	self._welfareBtnRed = self:getGo("btnWelfare/redPoint")
	self._awardBtn = self:getBtn("btnAward")
	self._awardBtnRed = self:getGo("btnAward/redPoint")
	self._rewardBubble = self:getGo("rewardBubble")
	self._pointItem = self:getGo("rewardBubble/pointItem")
	self._bubbleTip = self:getTxt("rewardBubble/txtTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self._knowledgeBtn = self:getBtn("btnKnowledge")
	self._limit = self:getTxt("limit/txtLimit")
	self._stove = {}

	for i = 1, 5 do
		self._stove[i] = {
			btn = self:getBtn("stove/" .. i)
		}
		self._stove[i].level = goutil.findChildTextComponent(self._stove[i].btn.gameObject, "txtLevel")
		self._stove[i].name = goutil.findChildTextComponent(self._stove[i].btn.gameObject, "txtName")
		self._stove[i].red = goutil.findChild(self._stove[i].btn.gameObject, "red")
	end

	self._tip = self:getGo("tip")
	self._tipTxt = self:getTxt("tip/txt")
	self._refiningBtn = self:getBtn("btnRefining")
	self._refiningBtnRed = self:getGo("btnRefining/red")
	self._goldBar = self:getGo("goldBar")
end

function NianNianWelfareView:onExit()
	NianNianWelfareView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._viewEff)
	MaterialMgr.resetAll(self._pointItem)
	GlobalDispatcher:removeListener(NianNianWelfareController.PM_NianNianBenefitsInfoRes, self._handlePM_NianNianBenefitsInfoRes, self)
	GlobalDispatcher:removeListener(NianNianWelfareController.PM_NianNianBenefitsGainDailPrizeRes, self._handlePM_NianNianBenefitsGainDailPrizeRes, self)
	GlobalDispatcher:removeListener(NianNianWelfareController.PM_NianNianBenefitsRefineRes, self._handlePM_NianNianBenefitsRefineRes, self)
	GlobalDispatcher:removeListener(NianNianWelfareController.PM_NianNianBenefitsUpgradeRes, self._handlePM_NianNianBenefitsUpgradeRes, self)
	GlobalDispatcher:removeListener(NianNianWelfareController.PM_NianNianBenefitsAchievementPrizeRes, self._handlePM_NianNianBenefitsAchievementPrizeRes, self)
end

function NianNianWelfareView:onEnter()
	NianNianWelfareView.super.onEnter(self)

	self._activityInfo = NianNianWelfareController.instance:getActivity()

	GlobalDispatcher:addListener(NianNianWelfareController.PM_NianNianBenefitsInfoRes, self._handlePM_NianNianBenefitsInfoRes, self)
	GlobalDispatcher:addListener(NianNianWelfareController.PM_NianNianBenefitsGainDailPrizeRes, self._handlePM_NianNianBenefitsGainDailPrizeRes, self)
	GlobalDispatcher:addListener(NianNianWelfareController.PM_NianNianBenefitsRefineRes, self._handlePM_NianNianBenefitsRefineRes, self)
	GlobalDispatcher:addListener(NianNianWelfareController.PM_NianNianBenefitsUpgradeRes, self._handlePM_NianNianBenefitsUpgradeRes, self)
	GlobalDispatcher:addListener(NianNianWelfareController.PM_NianNianBenefitsAchievementPrizeRes, self._handlePM_NianNianBenefitsAchievementPrizeRes, self)
	goutil.setActive(self._welfareBtnRed, false)
	goutil.setActive(self._awardBtnRed, false)
	NianNianWelfareController.instance:sendPM_NianNianBenefitsInfoReq(self._activityInfo.actId, self._activityInfo.partsPlan)

	local objList = {
		{
			showAdd = true,
			id = self._activityInfo.itemId
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)

	self._viewEff = UIEffectManager.instance:playEffect(self, "fx_ui_20211014/nianniansongfuli/fx_ui_nnsfl_lianqi.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
	end)
end

function NianNianWelfareView:_handlePM_NianNianBenefitsInfoRes()
	if GameUtil.getUserData(self._activityInfo.actId .. "") == nil then
		UIStateManager.instance:push(ViewName.DialogueView, self._activityInfo.dialogueId)
		GameUtil.saveUserData(self._activityInfo.actId .. "", true)
	end

	goutil.setActive(self._welfareBtnRed, not NianNianWelfareModel.instance:isGainDailyPrize())

	self._limit.text = string.format(lang("nian_welfare_limit_tip"), NianNianWelfareModel.instance:getDailyItemNum(), self._activityInfo.maxItemNum)

	local stoveInfo = NianNianWelfareModel.instance:getPartInfo()

	for i, v in ipairs(self._stove) do
		v.level.text = stoveInfo[i].level
		v.name.text = stoveInfo[i].name

		local matType, id, num = MaterialMgr.getMatParams(stoveInfo[i].upgradeCost)

		goutil.setActive(v.red, num <= MaterialFacade.instance:getMatNumber(matType, id) and stoveInfo[i].level < stoveInfo[i].maxLevel)
	end

	goutil.setActive(self._tip, not NianNianWelfareController.instance:isCanRefine())
	goutil.setActive(self._refiningBtnRed, NianNianWelfareController.instance:isCanRefine())
	uGuiUtil.setGoGrayState(self._refiningBtn.gameObject, not NianNianWelfareController.instance:isCanRefine())
	self:_updateRefining(stoveInfo)
end

function NianNianWelfareView:_handlePM_NianNianBenefitsUpgradeRes(partsId)
	local stoveInfo = NianNianWelfareModel.instance:getPartInfo()
	local partInfo = stoveInfo[partsId]

	self._stove[partsId].level.text = partInfo.level

	for i, v in ipairs(self._stove) do
		local matType, id, num = MaterialMgr.getMatParams(stoveInfo[i].upgradeCost)

		goutil.setActive(v.red, num <= MaterialFacade.instance:getMatNumber(matType, id) and stoveInfo[i].level < stoveInfo[i].maxLevel)
	end

	self:_updateRefining(stoveInfo)
	goutil.setActive(self._tip, not NianNianWelfareController.instance:isCanRefine())
	goutil.setActive(self._refiningBtnRed, NianNianWelfareController.instance:isCanRefine())
	uGuiUtil.setGoGrayState(self._refiningBtn.gameObject, not NianNianWelfareController.instance:isCanRefine())
end

function NianNianWelfareView:_handlePM_NianNianBenefitsGainDailPrizeRes()
	self._limit.text = string.format(lang("nian_welfare_limit_tip"), NianNianWelfareModel.instance:getDailyItemNum(), self._activityInfo.maxItemNum)

	goutil.setActive(self._welfareBtnRed, false)
end

function NianNianWelfareView:_handlePM_NianNianBenefitsRefineRes()
	goutil.setActive(self._tip, false)
	goutil.setActive(self._refiningBtnRed, false)
	uGuiUtil.setGoGrayState(self._refiningBtn.gameObject, true)
end

function NianNianWelfareView:_handlePM_NianNianBenefitsAchievementPrizeRes()
	local stoveInfo = NianNianWelfareModel.instance:getPartInfo()

	self:_updateRefining(stoveInfo)
end

function NianNianWelfareView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "niannianwelfare")
end

function NianNianWelfareView:_onClickWelfare()
	if NianNianWelfareModel.instance:isGainDailyPrize() then
		FloatWordMgr.instance:show(lang("nian_welfare_daily_prize"))
	else
		NianNianBenefitsAgent.instance:sendPM_NianNianBenefitsGainDailPrizeReq(self._activityInfo.actId)
	end
end

function NianNianWelfareView:_onClickAward()
	UIStateManager.instance:push(ViewName.NnWelfarePrizeView, self._activityInfo.actId, self._activityInfo.achievementPlan)
end

function NianNianWelfareView:_onClickKnowledge()
	local matType, id, num = MaterialMgr.getMatParams(self._activityInfo.itemId)

	MaterialMgr.openGetSource(matType, id)
end

function NianNianWelfareView:_onClickStove(index)
	local stoveInfo = NianNianWelfareModel.instance:getPartInfo()

	UIStateManager.instance:push(ViewName.NianNianWelfareInfoView, stoveInfo[index], self._activityInfo.actId)
end

function NianNianWelfareView:_onClickRefining()
	local stoveInfo = NianNianWelfareModel.instance:getPartInfo()

	if stoveInfo.lv >= stoveInfo.maxLevel then
		if not NianNianWelfareModel.instance:isRefine() then
			NianNianBenefitsAgent.instance:sendPM_NianNianBenefitsRefineReq(self._activityInfo.actId)
		else
			FloatWordMgr.instance:show(lang("nian_welfare_refining_ed"))
		end
	else
		FloatWordMgr.instance:show(lang("nian_welfare_refining_ing"))
	end
end

function NianNianWelfareView:_updateRefining(stoveInfo)
	MaterialMgr.resetAll(self._pointItem)

	self._bubbleProxy = nil
	self._tipTxt.text = string.format(lang("nian_welfare_refining"), stoveInfo.maxLevel - stoveInfo.lv)

	local achievementCfg = NianNianWelfareConfig.instance:getAchievementByPlanId(self._activityInfo.achievementPlan)
	local redFlag = false

	for i, cfg in ipairs(achievementCfg) do
		if cfg.totalGrade <= stoveInfo.lv and not NianNianWelfareModel.instance:isGainAchievementPrizeById(i) then
			self._bubbleTip.text = string.format(lang("nian_welfare_achievement_prize_ed"))
			self._bubbleProxy = MaterialMgr.setCellByCfg(cfg.achievementPrize, self._pointItem)
			redFlag = true

			break
		elseif cfg.totalGrade > stoveInfo.lv then
			self._bubbleTip.text = string.format(lang("nian_welfare_achievement_prize"), cfg.totalGrade - stoveInfo.lv)
			self._bubbleProxy = MaterialMgr.setCellByCfg(cfg.achievementPrize, self._pointItem)

			break
		end
	end

	goutil.setActive(self._awardBtnRed, redFlag)
	goutil.setActive(self._rewardBubble, self._bubbleProxy)
end

return NianNianWelfareView
