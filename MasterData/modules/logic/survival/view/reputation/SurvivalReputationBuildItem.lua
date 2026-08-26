-- chunkname: @modules/logic/survival/view/reputation/SurvivalReputationBuildItem.lua

module("modules.logic.survival.view.reputation.SurvivalReputationBuildItem", package.seeall)

local SurvivalReputationBuildItem = class("SurvivalReputationBuildItem", LuaCompBase)

function SurvivalReputationBuildItem:ctor()
	return
end

function SurvivalReputationBuildItem:init(viewGO)
	self.viewGO = viewGO
	self._txtcamp = gohelper.findChildText(self.viewGO, "go_card/#txt_camp")
	self._simagebuilding = gohelper.findChildSingleImage(self.viewGO, "go_card/#simage_building")
	self._txtname = gohelper.findChildText(self.viewGO, "go_card/#txt_name")
	self._imagecamp = gohelper.findChildImage(self.viewGO, "go_card/#image_camp")
	self._imagelevelbg = gohelper.findChildImage(self.viewGO, "go_card/#image_levelbg")
	self._txtlevel = gohelper.findChildText(self.viewGO, "go_card/#image_levelbg/#txt_level")
	self._imageprogresspre = gohelper.findChildImage(self.viewGO, "go_card/score/progress/#image_progress_pre")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "go_card/score/progress/#image_progress")
	self._txtcurrent = gohelper.findChildText(self.viewGO, "go_card/score/#txt_current")
	self._txtcurrentloop = gohelper.findChildText(self.viewGO, "go_card/score/#txt_current_loop")
	self._txttotal = gohelper.findChildText(self.viewGO, "go_card/score/#txt_total")
	self._golevelUp = gohelper.findChild(self.viewGO, "go_card/#go_levelUp")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
end

function SurvivalReputationBuildItem:onStart()
	return
end

function SurvivalReputationBuildItem:addEventListeners()
	self.addClickCb(self, self._btnclick, self.onClickBtnClick, self)
end

function SurvivalReputationBuildItem:removeEventListeners()
	return
end

function SurvivalReputationBuildItem:onDestroy()
	return
end

function SurvivalReputationBuildItem:setData(data)
	self.score = data.score
	self.mo = data.mo
	self.index = data.index
	self.onAnimalPlayCallBack = data.onAnimalPlayCallBack

	if data == nil then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.buildingCfgId = self.mo.buildingId
	self.buildCfg = SurvivalConfig.instance:getBuildingConfig(self.buildingCfgId, self.mo.level)
	self.onClickCallBack = data.onClickCallBack
	self.onClickContext = data.onClickContext
	self.reputationProp = self.mo.survivalReputationPropMo.prop

	self:refreshReputationData()
	self:refreshNotAnimUI()
	self:refreshTextScore()
	self:refreshProgress()
	self:refreshProgressPre()
	self:refreshUpgrade()
end

function SurvivalReputationBuildItem:refreshReputationData()
	self.survivalReputationPropMo = SurvivalReputationPropMo.New()

	self.survivalReputationPropMo:setData(self.reputationProp)

	self.reputationId = self.reputationProp.reputationId
	self.reputationCfg = SurvivalConfig.instance:getReputationCfgById(self.reputationId, self.reputationProp.reputationLevel)
	self.reputationType = self.reputationCfg.type
	self.isMaxLevel = self.survivalReputationPropMo:isMaxLevel()
end

function SurvivalReputationBuildItem:onClickBtnClick()
	if self.onClickCallBack then
		self.onClickCallBack(self.onClickContext, self)
	end
end

function SurvivalReputationBuildItem:setSelect(value)
	gohelper.setActive(self._goselect, value)

	self.isSelect = value

	self:refreshProgress()
	self:refreshProgressPre()
	self:refreshTextScore()
end

function SurvivalReputationBuildItem:refreshNotAnimUI()
	self._txtcamp.text = self.reputationCfg.name

	self._simagebuilding:LoadImage(self.buildCfg.icon)

	self._txtname.text = self.buildCfg.name

	UISpriteSetMgr.instance:setSurvivalSprite(self._imagecamp, self.reputationCfg.icon)

	self.reputationLevel = self.reputationProp.reputationLevel
	self._txtlevel.text = "Lv." .. self.reputationLevel
	self.curReputation = self.reputationProp.reputationExp

	local leveBg = self.survivalReputationPropMo:getLevelBkg()

	UISpriteSetMgr.instance:setSurvivalSprite2(self._imagelevelbg, leveBg)

	leveBg = self.survivalReputationPropMo:getLevelProgressBkg(true)

	UISpriteSetMgr.instance:setSurvivalSprite2(self._imageprogresspre, leveBg)

	leveBg = self.survivalReputationPropMo:getLevelProgressBkg()

	UISpriteSetMgr.instance:setSurvivalSprite2(self._imageprogress, leveBg)

	self._txttotal.text = self.isMaxLevel and "--" or SurvivalConfig.instance:getReputationCost(self.reputationId, self.reputationLevel)
end

function SurvivalReputationBuildItem:refreshUpgrade()
	if self.isMaxLevel then
		gohelper.setActive(self._golevelUp, false)
	else
		local reputationCost = SurvivalConfig.instance:getReputationCost(self.reputationId, self.reputationLevel)

		gohelper.setActive(self._golevelUp, reputationCost <= self.score + self.curReputation)
	end
end

function SurvivalReputationBuildItem:refreshProgress()
	if self.isMaxLevel then
		self._imageprogress.fillAmount = 0
	else
		local reputationCost = SurvivalConfig.instance:getReputationCost(self.reputationId, self.reputationLevel)

		self._imageprogress.fillAmount = self.curReputation / reputationCost
	end
end

function SurvivalReputationBuildItem:refreshProgressPre()
	local per

	if self.isSelect and not self.isMaxLevel then
		local reputationCost = SurvivalConfig.instance:getReputationCost(self.reputationId, self.reputationLevel)

		self._imageprogresspre.fillAmount = (self.score + self.curReputation) / reputationCost

		gohelper.setActive(self._imageprogresspre, true)
	else
		gohelper.setActive(self._imageprogresspre, false)
	end
end

function SurvivalReputationBuildItem:refreshTextScore()
	if self.isMaxLevel then
		self._txtcurrent.text = "--"

		gohelper.setActive(self._txtcurrentloop, false)
	elseif self.isSelect then
		self._txtcurrent.text = string.format("%s", self.curReputation)
		self._txtcurrentloop.text = string.format("(+%s)", self.score)

		gohelper.setActive(self._txtcurrentloop, true)
	else
		self._txtcurrent.text = self.curReputation

		gohelper.setActive(self._txtcurrentloop, false)
	end
end

function SurvivalReputationBuildItem:playUpAnim(survivalBuilding)
	local oldReputation = self.curReputation
	local oldTotalReputation = SurvivalConfig.instance:getReputationCost(self.reputationId, self.reputationLevel)

	self.oldPer = oldReputation / oldTotalReputation

	local oldUpgradePer = (oldReputation + self.score) / oldTotalReputation

	self.isUpgrade = oldUpgradePer >= 1
	self.reputationProp = survivalBuilding.reputationProp

	self:refreshReputationData()

	local firstPer = math.min(oldUpgradePer, 1)
	local totalTimeS = 1.5

	self.firstMovePer = firstPer - self.oldPer

	local toNum = oldReputation + self.score
	local curReputationLevel = self.reputationProp.reputationLevel

	self.secondMovePer = 0

	if self.isUpgrade then
		if self.isMaxLevel then
			self.secondMovePer = 0
		else
			local curReputation = self.reputationProp.reputationExp
			local curTotalReputation = SurvivalConfig.instance:getReputationCost(self.reputationId, curReputationLevel)

			self.secondMovePer = curReputation / curTotalReputation
		end
	end

	local flow = FlowSequence.New()

	flow:addWork(TweenWork.New({
		from = 0,
		type = "DOTweenFloat",
		to = self.firstMovePer + self.secondMovePer,
		t = totalTimeS,
		frameCb = self._onProgressFloat,
		cbObj = self,
		ease = EaseType.OutQuart
	}))
	gohelper.setActive(self._imageprogresspre, true)

	self._imageprogresspre.fillAmount = firstPer

	if self.isUpgrade then
		flow:addWork(AnimatorWork.New({
			animName = "lvup",
			go = self.viewGO
		}))
	end

	local parallelWork = FlowParallel.New()

	parallelWork:addWork(AnimatorWork.New({
		animName = "scoreup",
		go = self.viewGO
	}))
	parallelWork:addWork(TweenWork.New({
		type = "DOTweenFloat",
		from = oldReputation,
		to = toNum,
		t = totalTimeS,
		frameCb = self._onFloat,
		cbObj = self,
		ease = EaseType.OutQuart
	}))
	parallelWork:addWork(flow)

	return parallelWork
end

function SurvivalReputationBuildItem:_onProgressFloat(num)
	if num <= self.firstMovePer then
		self.progresMoveStage = 1
		self._imageprogress.fillAmount = self.oldPer + num
	end

	if num >= self.firstMovePer and self.isUpgrade and self.progresMoveStage == 1 then
		self.progresMoveStage = 2

		self:_refreshUIState({
			per = self.secondMovePer
		})
	end

	if num > self.firstMovePer and self.isUpgrade then
		self._imageprogress.fillAmount = num - self.firstMovePer
	end
end

function SurvivalReputationBuildItem:_onFloat(num)
	self._txtcurrent.text = string.format("%s", math.floor(num))
end

function SurvivalReputationBuildItem:_refreshUIState2()
	self:refreshNotAnimUI()
end

function SurvivalReputationBuildItem:_refreshUIState(param)
	local per = param.per

	self:refreshNotAnimUI()
	gohelper.setActive(self._imageprogresspre, true)

	self._imageprogresspre.fillAmount = per
	self._imageprogress.fillAmount = 0

	gohelper.setActive(self._golevelUp, false)
end

return SurvivalReputationBuildItem
