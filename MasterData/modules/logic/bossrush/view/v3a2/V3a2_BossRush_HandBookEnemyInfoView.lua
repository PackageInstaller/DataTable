-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_HandBookEnemyInfoView.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_HandBookEnemyInfoView", package.seeall)

local V3a2_BossRush_HandBookEnemyInfoView = class("V3a2_BossRush_HandBookEnemyInfoView", BaseView)

function V3a2_BossRush_HandBookEnemyInfoView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._scrollboss = gohelper.findChildScrollRect(self.viewGO, "boss/#scroll_boss")
	self._gorank = gohelper.findChild(self.viewGO, "#go_rank")
	self._gorightcontainer = gohelper.findChild(self.viewGO, "#go_right_container")
	self._goheader = gohelper.findChild(self.viewGO, "#go_right_container/#go_header")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_right_container/#go_header/head/#simage_icon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_right_container/#go_header/head/#simage_icon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#go_right_container/#go_header/head/#image_career")
	self._txtnameEn = gohelper.findChildText(self.viewGO, "#go_right_container/#go_header/root/name/#txt_nameEn")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_right_container/#go_header/root/name/#txt_name")
	self._scrollstrategy = gohelper.findChildScrollRect(self.viewGO, "#go_right_container/#go_header/root/#scroll_strategy")
	self._goUnlock = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock")
	self._goscore = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_score")
	self._imageslider = gohelper.findChildImage(self.viewGO, "#go_right_container/#go_Unlock/#go_score/#image_slider")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#go_right_container/#go_Unlock/#go_score/#txt_progress")
	self._gogoalbouns = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_score/#go_goalbouns")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right_container/#go_Unlock/#go_score/#go_goalbouns/#btn_claim")
	self._txtbonus = gohelper.findChildText(self.viewGO, "#go_right_container/#go_Unlock/#go_score/#go_goalbouns/#txt_bonus")
	self._goenemyinfo = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_enemyinfo")
	self._scrollenemyinfo = gohelper.findChildScrollRect(self.viewGO, "#go_right_container/#go_Unlock/#go_enemyinfo/#scroll_enemyinfo")
	self._goenemyinfoconent = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_enemyinfo/#scroll_enemyinfo/Viewport/#go_enemyinfoconent")
	self._gopassiveskillitem = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_enemyinfo/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskillitem")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_right_container/#go_Unlock/#go_enemyinfo/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskillitem/#txt_desc")
	self._goskillcontainer = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_skill_container")
	self._gonoskill = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_skill_container/#go_noskill")
	self._goskill = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_skill_container/#go_skill")
	self._gosuperitem = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_skill_container/#go_skill/card/scrollview/viewport/content/supers/#go_superitem")
	self._goskillitem = gohelper.findChild(self.viewGO, "#go_right_container/#go_Unlock/#go_skill_container/#go_skill/card/scrollview/viewport/content/skills/#go_skillitem")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_right_container/#go_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_HandBookEnemyInfoView:addEvents()
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
end

function V3a2_BossRush_HandBookEnemyInfoView:removeEvents()
	self._btnclaim:RemoveClickListener()
end

function V3a2_BossRush_HandBookEnemyInfoView:_btnclaimOnClick()
	gohelper.setActive(self._goFly, false)

	local actId = BossRushConfig.instance:getActivityId()

	BossRushRpc.instance:sendAct128GetExpRequest(actId, self.bossType, self._clickClaimCb, self)
end

function V3a2_BossRush_HandBookEnemyInfoView:_btnstressOnClick()
	StressTipController.instance:openMonsterStressTip(self.monsterConfig)
end

function V3a2_BossRush_HandBookEnemyInfoView:onClickSkillItem(skillItem)
	self.tipViewParam = self.tipViewParam or {}
	self.tipViewParam.super = skillItem.super
	self.tipViewParam.skillIdList = skillItem.skillIdList
	self.tipViewParam.monsterName = FightConfig.instance:getMonsterName(self.monsterConfig)

	ViewMgr.instance:openView(ViewName.SkillTipView3, self.tipViewParam)
end

function V3a2_BossRush_HandBookEnemyInfoView:_editableInitView()
	self._goFly = gohelper.findChild(self.viewGO, "fly")

	gohelper.setActive(self._gosuperitem, false)
	gohelper.setActive(self._goskillitem, false)
	gohelper.setActive(self._gopassiveskillitem, false)

	self.smallSkillItemList = {}
	self.superSkillItemList = {}
	self.passiveSkillItemList = {}
	self._scoreAnim = self._goscore:GetComponent(gohelper.Type_Animator)
	self._simggoalbouns = gohelper.findChildSingleImage(self._gogoalbouns, "icon")

	self.addEventCb(self, BossRushController.instance, BossRushEvent.V3a2_BossRush_HandBook_SelectMonsterCB, self.onSelectMonsterChange, self)
end

function V3a2_BossRush_HandBookEnemyInfoView:onOpen()
	gohelper.setActive(self._goFly, false)
end

function V3a2_BossRush_HandBookEnemyInfoView:onSelectMonsterChange(mo)
	self:_onfinishExpLoopAudio()

	if not mo then
		return
	end

	local bossType = mo:getBossType()

	if self.bossType == bossType then
		return
	end

	self.monsterId = mo:getBossId()
	self.bossType = bossType
	self._handBookMo = V3a2_BossRushModel.instance:getHandBookMo(self.bossType)
	self.monsterConfig = lua_monster.configDict[self.monsterId]
	self.skinConfig = FightConfig.instance:getSkinCO(self.monsterConfig.skinId)

	self:refreshUI()
end

function V3a2_BossRush_HandBookEnemyInfoView:refreshUI()
	self:refreshHeader()
	self:refreshSkill()
	self:refreshExp()
	self:_refreshStrategy()
end

function V3a2_BossRush_HandBookEnemyInfoView:refreshHeader()
	local monsterConfig = self.monsterConfig
	local skinConfig = self.skinConfig

	self._simageicon:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))

	local variantId = monsterConfig.heartVariantId

	if variantId ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(variantId), self._imageicon)
	else
		self._imageicon.material = nil
	end

	UISpriteSetMgr.instance:setEnemyInfoSprite(self._imagecareer, "sxy_" .. monsterConfig.career)

	self._txtname.text = self._handBookMo:getBossName()
end

function V3a2_BossRush_HandBookEnemyInfoView:refreshPassiveSkill()
	local skillIdList = FightConfig.instance:getPassiveSkillsAfterUIFilter(self.monsterConfig.id)

	for i, skillId in ipairs(skillIdList) do
		self:refreshOnePassiveSkill(i, skillId)
	end

	for i = 1, #self.passiveSkillItemList do
		gohelper.setActive(self.passiveSkillItemList[i].go, i <= #skillIdList)
	end
end

function V3a2_BossRush_HandBookEnemyInfoView:refreshOnePassiveSkill(index, skillId)
	local skillItem = self:_getPassiveSkillItem(index)
	local skillConfig = lua_skill.configDict[skillId]

	skillItem.txtName.text = skillConfig.name

	local name = FightConfig.instance:getMonsterName(self.monsterConfig)
	local txt = FightConfig.instance:getSkillEffectDesc(name, skillConfig)

	skillItem.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(skillItem.txtDesc.gameObject, SkillDescComp)

	skillItem.skillDesc:setNumberColor("#C66030")
	skillItem.skillDesc:setLinkColor("#4e6698")
	skillItem.skillDesc:setTipParam(0, Vector2(189, -35))
	skillItem.skillDesc:updateInfo(skillItem.txtDesc, txt)
end

function V3a2_BossRush_HandBookEnemyInfoView:_getPassiveSkillItem(index)
	local item = self.passiveSkillItemList[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gopassiveskillitem)

		item.go = go
		item.txtDesc = gohelper.findChildText(go, "#txt_desc")
		item.txtName = gohelper.findChildText(go, "#txt_desc/bg/name")
		self.passiveSkillItemList[index] = item
	end

	return item
end

function V3a2_BossRush_HandBookEnemyInfoView:refreshSkill()
	if self._handBookMo then
		gohelper.setActive(self._goUnlock, self._handBookMo)
		gohelper.setActive(self._goLocked, not self._handBookMo)

		if not self._handBookMo then
			return
		end

		self:refreshPassiveSkill()
		self:refreshSmallSkill()
		self:refreshSuperSkill()

		local hasSkill = not string.nilorempty(self.monsterConfig.activeSkill) or #self.monsterConfig.uniqueSkill > 0

		gohelper.setActive(self._gonoskill, not hasSkill)
		gohelper.setActive(self._goskill, hasSkill)
	end
end

function V3a2_BossRush_HandBookEnemyInfoView:refreshSmallSkill()
	self:recycleAllSmallSkill()

	if string.nilorempty(self.monsterConfig.activeSkill) then
		return
	end

	local skillIdList = GameUtil.splitString2(self.monsterConfig.activeSkill, true)

	for _, skillIdArr in ipairs(skillIdList) do
		table.remove(skillIdArr, 1)

		local skillId = skillIdArr[1]
		local skillConfig = lua_skill.configDict[skillId]
		local skillItem = self:getSmallSkillItem()

		skillItem.icon:LoadImage(ResUrl.getSkillIcon(skillConfig.icon))
		skillItem.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))

		skillItem.super = false
		skillItem.skillIdList = skillIdArr
	end
end

function V3a2_BossRush_HandBookEnemyInfoView:refreshSuperSkill()
	self:recycleAllSuperSkill()

	local uniqueSkillList = self.monsterConfig.uniqueSkill

	for _, skillId in ipairs(uniqueSkillList) do
		local skillItem = self:getSuperSkillItem()
		local skillConfig = lua_skill.configDict[skillId]

		skillItem.icon:LoadImage(ResUrl.getSkillIcon(skillConfig.icon))
		skillItem.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))

		skillItem.super = true

		table.insert(skillItem.skillIdList, skillId)
	end
end

function V3a2_BossRush_HandBookEnemyInfoView:recycleAllSmallSkill()
	for _, skillItem in ipairs(self.smallSkillItemList) do
		gohelper.setActive(skillItem.go, false)
	end

	self.useSmallSkillItemCount = 0
end

function V3a2_BossRush_HandBookEnemyInfoView:getSmallSkillItem()
	if self.useSmallSkillItemCount < #self.smallSkillItemList then
		self.useSmallSkillItemCount = self.useSmallSkillItemCount + 1

		local skillItem = self.smallSkillItemList[self.useSmallSkillItemCount]

		gohelper.setActive(skillItem.go, true)

		return skillItem
	end

	self.useSmallSkillItemCount = self.useSmallSkillItemCount + 1

	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self._goskillitem)
	skillItem.icon = gohelper.findChildSingleImage(skillItem.go, "imgIcon")
	skillItem.tag = gohelper.findChildSingleImage(skillItem.go, "tag/tagIcon")
	skillItem.btn = gohelper.findChildButtonWithAudio(skillItem.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	skillItem.btn:AddClickListener(self.onClickSkillItem, self, skillItem)
	gohelper.setActive(skillItem.go, true)
	table.insert(self.smallSkillItemList, skillItem)

	return skillItem
end

function V3a2_BossRush_HandBookEnemyInfoView:recycleAllSuperSkill()
	for _, skillItem in ipairs(self.superSkillItemList) do
		gohelper.setActive(skillItem.go, false)

		skillItem.super = nil

		tabletool.clear(skillItem.skillIdList)
	end

	self.useSuperSkillItemCount = 0
end

function V3a2_BossRush_HandBookEnemyInfoView:getSuperSkillItem()
	if self.useSuperSkillItemCount < #self.superSkillItemList then
		self.useSuperSkillItemCount = self.useSuperSkillItemCount + 1

		local skillItem = self.superSkillItemList[self.useSuperSkillItemCount]

		gohelper.setActive(skillItem.go, true)

		return skillItem
	end

	self.useSuperSkillItemCount = self.useSuperSkillItemCount + 1

	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self._gosuperitem)
	skillItem.icon = gohelper.findChildSingleImage(skillItem.go, "imgIcon")
	skillItem.tag = gohelper.findChildSingleImage(skillItem.go, "tag/tagIcon")
	skillItem.btn = gohelper.findChildButtonWithAudio(skillItem.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	skillItem.btn:AddClickListener(self.onClickSkillItem, self, skillItem)

	skillItem.skillIdList = {}

	gohelper.setActive(skillItem.go, true)
	table.insert(self.superSkillItemList, skillItem)

	return skillItem
end

function V3a2_BossRush_HandBookEnemyInfoView:_playExpAddAnim()
	local target = math.min(self._heightScore, self._needExp)

	self:_doTweenExp(self._saveExp, target)
end

function V3a2_BossRush_HandBookEnemyInfoView:_doTweenExp(orgin, target)
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	ZProj.TweenHelper.KillByObj(self._imageslider)

	local time = 1

	self:_showExpSlider()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(orgin, target, time, self.frameCallback, self.finishCallback, self, nil, EaseType.Linear)

	local fillAmount = self._needExp == 0 and 0 or target / self._needExp * self._sliderScale

	if fillAmount - self._imageslider.fillAmount < 0.01 then
		self._imageslider.fillAmount = fillAmount
		self._saveExp = self._heightScore

		self:_setProgressTxt()
		self:_onfinishExpLoopAudio()

		return
	end

	self:_onPlayExpLoopAudio()
	TaskDispatcher.cancelTask(self._onfinishExpLoopAudio, self)
	TaskDispatcher.runDelay(self._onfinishExpLoopAudio, self, time)
	ZProj.TweenHelper.DOFillAmount(self._imageslider, fillAmount, time, self._onfinishExpLoopAudio, self, nil, EaseType.Linear)
end

function V3a2_BossRush_HandBookEnemyInfoView:frameCallback(value)
	self._saveExp = math.ceil(value)
	self._saveExp = math.min(self._heightScore, self._saveExp)

	self:_setProgressTxt()
end

function V3a2_BossRush_HandBookEnemyInfoView:finishCallback()
	self:_showExpSlider()
	self:_refreshExpBonus()
	self._handBookMo:setSaveExp(self._saveExp)

	if math.ceil(self._saveExp) < self._heightScore then
		local nextPointBonus = self._handBookMo:getNextPointBonus()

		if nextPointBonus then
			self._needExp = nextPointBonus.exp

			if nextPointBonus.exp < self._heightScore then
				self:_doTweenExp(self._saveExp, nextPointBonus.exp)
			else
				self:_doTweenExp(self._saveExp, self._heightScore)
			end

			return
		end
	end

	self:_onfinishExpLoopAudio()
end

function V3a2_BossRush_HandBookEnemyInfoView:_showExpSlider()
	self._saveExp = math.min(self._heightScore, self._saveExp)

	self:_setProgressTxt()

	self._imageslider.fillAmount = self._needExp == 0 and 0 or self._saveExp / self._needExp * self._sliderScale
end

function V3a2_BossRush_HandBookEnemyInfoView:_setProgressTxt()
	local isMax = self._handBookMo.acceptExp >= self._handBookMo.maxBonusExp

	gohelper.setActive(self._gogoalbouns, not isMax)

	if isMax then
		self._txtprogress.text = self._heightScore
		self._sliderScale = 1

		ZProj.TweenHelper.KillByObj(self._imageslider)

		self._imageslider.fillAmount = 1
	else
		self._txtprogress.text = string.format("%s/%s", self._saveExp, self._needExp)
		self._sliderScale = 0.81
	end
end

function V3a2_BossRush_HandBookEnemyInfoView:getCurPointBonus()
	return self._handBookMo:getCurPointBonus() or self._handBookMo:getMaxPointBonus()
end

function V3a2_BossRush_HandBookEnemyInfoView:refreshExp()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	ZProj.TweenHelper.KillByObj(self._imageslider)

	local curPointBonus = self:getCurPointBonus()

	self._saveExp = self._handBookMo.saveExp or 0
	self._heightScore = self._handBookMo.heightScore or 0
	self._needExp = curPointBonus.exp

	self:_refreshExpBonus()
	self:_showExpSlider()

	if self._heightScore > self._saveExp then
		self:_playExpAddAnim()
	end
end

function V3a2_BossRush_HandBookEnemyInfoView:_onPlayExpLoopAudio()
	AudioMgr.instance:trigger(AudioEnum3_2.BossRush.play_ui_zongmao_jiafen_loop)
end

function V3a2_BossRush_HandBookEnemyInfoView:_onfinishExpLoopAudio()
	AudioMgr.instance:trigger(AudioEnum3_2.BossRush.stop_ui_zongmao_jiafen_loop)
end

function V3a2_BossRush_HandBookEnemyInfoView:_refreshExpBonus()
	local bonus = self._handBookMo:getCanClaimBonus(self._saveExp)

	gohelper.setActive(self._btnclaim.gameObject, bonus > 0)

	local curPointBonus = self:getCurPointBonus()

	bonus = bonus > 0 and bonus or curPointBonus and curPointBonus.bonus or 0
	self._txtbonus.text = luaLang("multiple") .. bonus
end

function V3a2_BossRush_HandBookEnemyInfoView:_refreshStrategy()
	if not self._handBookMo or not self._handBookMo.haveFight then
		gohelper.setActive(self._scrollstrategy.gameObject, false)

		return
	end

	gohelper.setActive(self._scrollstrategy.gameObject, true)

	local strategy = BossRushConfig.instance:getBossRecommendStrategy(self.bossType)
	local content = self._scrollstrategy.content

	if not self._strategyRes then
		local resPath = BossRushEnum.ResPath.v3a2_bossrush_strategyitem

		self._strategyRes = self.viewContainer:getRes(resPath)
	end

	gohelper.CreateObjList(self, self._createStrategyCB, strategy, content.gameObject, self._strategyRes, V3a2_BossRush_StrategyItem)
end

function V3a2_BossRush_HandBookEnemyInfoView:_createStrategyCB(obj, data, index)
	obj:refreshUI(data)
end

function V3a2_BossRush_HandBookEnemyInfoView:_clickClaimCb()
	self._handBookMo:setSaveExp(self._handBookMo.heightScore or self._saveExp)
	self._scoreAnim:Play(V3a2BossRushEnum.AnimName.Lingqu, 0, 0)
	self:_onfinishExpLoopAudio()
	self:refreshExp()
	gohelper.setActive(self._goFly, true)
	AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources)
end

function V3a2_BossRush_HandBookEnemyInfoView:onClose()
	self:_onfinishExpLoopAudio()
	TaskDispatcher.cancelTask(self._onfinishExpLoopAudio, self)
end

function V3a2_BossRush_HandBookEnemyInfoView:onDestroyView()
	for _, skillItem in ipairs(self.smallSkillItemList) do
		skillItem.btn:RemoveClickListener()
		skillItem.icon:UnLoadImage()
		skillItem.tag:UnLoadImage()
	end

	self.smallSkillItemList = nil

	for _, skillItem in ipairs(self.superSkillItemList) do
		skillItem.btn:RemoveClickListener()
		skillItem.icon:UnLoadImage()
		skillItem.tag:UnLoadImage()
	end

	self.superSkillItemList = nil

	self._simggoalbouns:UnLoadImage()

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	ZProj.TweenHelper.KillByObj(self._imageslider)
end

return V3a2_BossRush_HandBookEnemyInfoView
