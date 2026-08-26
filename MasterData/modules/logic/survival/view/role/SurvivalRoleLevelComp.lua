-- chunkname: @modules/logic/survival/view/role/SurvivalRoleLevelComp.lua

module("modules.logic.survival.view.role.SurvivalRoleLevelComp", package.seeall)

local SurvivalRoleLevelComp = class("SurvivalRoleLevelComp", LuaCompBase)

function SurvivalRoleLevelComp:init(viewGO)
	self.viewGO = viewGO
	self.txt_level = gohelper.findChildTextMesh(self.viewGO, "root/#txt_level")
	self.imgLevelProgress = gohelper.findChildImage(self.viewGO, "root/#image_progress")
	self.btn_click = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")
	self.go_flyItemContent = gohelper.findChild(self.viewGO, "root/#go_flyItemContent")
	self.survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
end

function SurvivalRoleLevelComp:addEventListeners()
	self.addClickCb(self, self.btn_click, self.onClick, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnRoleDateChange, self.onRoleDateChange, self)
end

function SurvivalRoleLevelComp:onDestroy()
	TaskDispatcher.cancelTask(self.onExpGainAnimEnd, self)

	if self.progressAnimWork then
		self.progressAnimWork:destroy()
	end
end

function SurvivalRoleLevelComp:setData()
	self:refresh()
end

function SurvivalRoleLevelComp:onClick()
	if self.onClickFunc then
		self.onClickFunc(self.context)
	end
end

function SurvivalRoleLevelComp:setOnClickFunc(func, context)
	self.onClickFunc = func
	self.context = context
end

function SurvivalRoleLevelComp:onRoleDateChange()
	self:refresh(false)
end

function SurvivalRoleLevelComp:refresh(isPlayAnim)
	isPlayAnim = isPlayAnim ~= false

	if self.survivalShelterRoleMo:haveRole() then
		gohelper.setActive(self.viewGO, true)

		local level = self.survivalShelterRoleMo.level
		local isMaxLevel = SurvivalRoleConfig.instance:isMaxLevel(level)

		self.txt_level.text = string.format("<#871D1D>%s</color>", level)

		if not isMaxLevel then
			if isPlayAnim then
				self:playProgressAnim()
			else
				if self.progressAnimWork then
					self.progressAnimWork:destroy()
				end

				local curNeed = SurvivalRoleConfig.instance:getLevelNeedExp(level)
				local nextNeed = SurvivalRoleConfig.instance:getLevelNeedExp(level + 1)

				self.imgLevelProgress.fillAmount = (self.survivalShelterRoleMo.roleExp - curNeed) / (nextNeed - curNeed)
			end
		else
			self.imgLevelProgress.fillAmount = 0
		end
	else
		gohelper.setActive(self.viewGO, false)
	end
end

function SurvivalRoleLevelComp:playProgressAnim()
	local level = self.survivalShelterRoleMo.level
	local isMaxLevel = SurvivalRoleConfig.instance:isMaxLevel(level)

	if isMaxLevel then
		return
	end

	local curNeed = SurvivalRoleConfig.instance:getLevelNeedExp(level)
	local nextNeed = SurvivalRoleConfig.instance:getLevelNeedExp(level + 1)
	local per = (self.survivalShelterRoleMo.roleExp - curNeed) / (nextNeed - curNeed)

	if self.progressAnimWork then
		self.progressAnimWork:destroy()
	end

	self.progressAnimWork = self:getProgressAnimWork(level, level, 0, per)

	self.progressAnimWork:start()
end

function SurvivalRoleLevelComp:getLevelUpAnimWork(oldLevel, newLevel, oldExpPercent, newExpPercent, isAudio)
	return self:getProgressAnimWork(oldLevel, newLevel, oldExpPercent, newExpPercent, isAudio)
end

function SurvivalRoleLevelComp:getProgressAnimWork(oldLevel, newLevel, oldExpPercent, newExpPercent, isAudio)
	oldExpPercent = oldExpPercent or 0
	newExpPercent = newExpPercent or 1

	local upAnimFlow = FlowSequence.New()

	upAnimFlow:addWork(FunctionWork.New(function()
		self.imgLevelProgress.fillAmount = oldExpPercent
		self.txt_level.text = string.format("<#871D1D>%s</color>", oldLevel)
	end))

	local flowParallel = FlowParallel.New()

	flowParallel:addWork(TweenWork.New({
		type = "DOTweenFloat",
		t = 1.6,
		from = oldLevel,
		to = newLevel,
		frameCb = self.onFloat,
		cbObj = self,
		ease = EaseType.OutQuart
	}))
	flowParallel:addWork(TweenWork.New({
		type = "DOFillAmount",
		t = 1.6,
		img = self.imgLevelProgress,
		to = newExpPercent,
		ease = EaseType.OutQuart
	}))

	if isAudio then
		flowParallel:addWork(FunctionWork.New(function()
			AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_progress)
		end))
	end

	upAnimFlow:addWork(flowParallel)

	if isAudio then
		upAnimFlow:addWork(FunctionWork.New(function()
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Upgrade)
		end))
	end

	return upAnimFlow
end

function SurvivalRoleLevelComp:onFloat(value)
	self.txt_level.text = string.format("<#871D1D>%s</color>", math.floor(value))
end

function SurvivalRoleLevelComp:playExpGainAnim()
	if self.isPlayExpGainAnim then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_all)

	self.isPlayExpGainAnim = true

	gohelper.setActive(self.go_flyItemContent, false)
	gohelper.setActive(self.go_flyItemContent, true)
	TaskDispatcher.runDelay(self.onExpGainAnimEnd, self, 1.5)
end

function SurvivalRoleLevelComp:onExpGainAnimEnd()
	self.isPlayExpGainAnim = nil

	gohelper.setActive(self.go_flyItemContent, false)
end

return SurvivalRoleLevelComp
