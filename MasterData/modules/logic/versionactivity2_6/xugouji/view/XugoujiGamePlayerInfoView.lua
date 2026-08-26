-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiGamePlayerInfoView.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGamePlayerInfoView", package.seeall)

local XugoujiGamePlayerInfoView = class("XugoujiGamePlayerInfoView", BaseView)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji
local hpTweenDuration = 0.35

function XugoujiGamePlayerInfoView:onInitView()
	self._goPlayerInfo = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role")
	self._imagePlayerIcon = gohelper.findChildImage(self._goPlayerInfo, "Role/image/#simage_Role")
	self._txtPlayerHP = gohelper.findChildText(self._goPlayerInfo, "Role/image_RoleHPNumBG/#txt_RoleHP")
	self._imagePlayerHP = gohelper.findChildImage(self._goPlayerInfo, "Role/image_RoleHPBG/#image_RoleHPFG")
	self._goHp = gohelper.findChild(self._goPlayerInfo, "#go_HP")
	self._textHpDiff = gohelper.findChildText(self._goPlayerInfo, "#go_HP/#txt_HP")
	self._goBuffRoot = gohelper.findChild(self._goPlayerInfo, "#go_Buff")
	self._goBuffItem = gohelper.findChild(self._goBuffRoot, "#go_Buff")
	self._txtRemainTime = gohelper.findChildText(self._goPlayerInfo, "Remain/#txt_RemainValue")
	self._txtGotPairNum = gohelper.findChildText(self._goPlayerInfo, "Pairs/#txt_PairsValue")
	self._skillRoot = gohelper.findChild(self._goPlayerInfo, "#go_ViewSkillTips")
	self._skillItemRoot = gohelper.findChild(self._goPlayerInfo, "#go_ViewSkillTips/image_TipsBG")
	self._skillItem = gohelper.findChild(self._skillRoot, "image_TipsBG/#go_Item")
	self._btnPlayerIcon = gohelper.findChildButtonWithAudio(self._goPlayerInfo, "Role/image/#simage_Role")
	self._btnSkill = gohelper.findChildButtonWithAudio(self._goPlayerInfo, "Role/#btn_Skill")
	self._btnSkillTipsHide = gohelper.findChildButtonWithAudio(self._skillRoot, "#btnSkillTipsHide")
	self._skillTipsAnimator = ZProj.ProjAnimatorPlayer.Get(self._skillRoot)
	self._btnBuff = gohelper.findChildButtonWithAudio(self._goPlayerInfo, "#go_Buff")
	self._buffInfoRoot = gohelper.findChild(self._goPlayerInfo, "bufftipsview")
	self._goBuffInfoContent = gohelper.findChild(self._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content")
	self._goBuffInfoItem = gohelper.findChild(self._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	self._btnBuffInfoClose = gohelper.findChildButtonWithAudio(self._buffInfoRoot, "#btn_buffTipsHide")
	self._goDamageEffect = gohelper.findChild(self._goPlayerInfo, "#go_damage")
	self._viewAnimator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function XugoujiGamePlayerInfoView:addEvents()
	self._btnPlayerIcon:AddClickListener(self._onPlayerIconClick, self)
	self._btnSkill:AddClickListener(self._onSkillClick, self)
	self._btnBuff:AddClickListener(self._onBuffClick, self)
	self._btnSkillTipsHide:AddClickListener(self._onSkillHideClick, self)
	self._btnBuffInfoClose:AddClickListener(self._onBuffInfoCloseClick, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.HpUpdated, self._onHpUpdated, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.OperateTimeUpdated, self._onOperateCard, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.TurnChanged, self._onTurnChanged, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.GotActiveCard, self._refreshCardPair, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.BuffUpdated, self._onBuffsUpdated, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.GameRestart, self._onGameReStart, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.AutoShowSkillTips, self._onShowGameTips, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.AutoHideSkillTips, self._autoHideSkillTips, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.NewCards, self._onRefreshCards, self)
end

function XugoujiGamePlayerInfoView:removeEvents()
	self._btnPlayerIcon:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._btnSkillTipsHide:RemoveClickListener()
	self._btnBuffInfoClose:RemoveClickListener()
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.HpUpdated, self._onHpUpdated, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.OperateTimeUpdated, self._onOperateCard, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.TurnChanged, self._onTurnChanged, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.GotActiveCard, self._refreshCardPair, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.BuffUpdated, self._onBuffsUpdated, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.GameRestart, self._onGameReStart, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.AutoShowSkillTips, self._onShowGameTips, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.AutoHideSkillTips, self._autoHideSkillTips, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.NewCards, self._onRefreshCards, self)
end

function XugoujiGamePlayerInfoView:_onPlayerIconClick()
	local stepCtrl = XugoujiGameStepController.instance

	if stepCtrl then
		stepCtrl:nextStep()
	end
end

function XugoujiGamePlayerInfoView:_onSkillClick()
	if not self._gameCfg then
		local curGameId = Activity188Model.instance:getCurGameId()

		self._gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	end

	self._abilityCfgList = {
		{
			title = true
		}
	}
	self._abilityIdList = Activity188Model.instance:getPlayerAbilityIds()

	for idx, abilityId in ipairs(self._abilityIdList) do
		self._abilityCfgList[idx + 1] = Activity188Config.instance:getAbilityCfg(actId, abilityId)
	end

	gohelper.setActive(self._skillRoot, true)
	gohelper.setActive(self._btnSkillTipsHide.gameObject, true)
	self._skillTipsAnimator:Play(UIAnimationName.Open, nil, nil)
	gohelper.CreateObjList(self, self._createSkillItem, self._abilityCfgList, self._skillItemRoot, self._skillItem)
end

function XugoujiGamePlayerInfoView:_onSkillHideClick()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HideSkillTips)
	gohelper.setActive(self._btnSkillTipsHide.gameObject, false)
	self._skillTipsAnimator:Play(UIAnimationName.Close, self.onSkillTipsCloseAniFinish, self)
end

function XugoujiGamePlayerInfoView:onSkillTipsCloseAniFinish()
	gohelper.setActive(self._skillRoot, false)
end

function XugoujiGamePlayerInfoView:_onBuffClick()
	self._buffDataList = Activity188Model.instance:getBuffs(true)

	if not self._buffDataList or #self._buffDataList == 0 then
		return
	end

	local buffInfoDataList = {
		{
			bg = true
		}
	}

	for idx, buffData in ipairs(self._buffDataList) do
		buffInfoDataList[idx + 1] = buffData
	end

	gohelper.setActive(self._buffInfoRoot, true)
	gohelper.CreateObjList(self, self._createBuffInfoItem, buffInfoDataList, self._goBuffInfoContent, self._goBuffInfoItem)
end

function XugoujiGamePlayerInfoView:_onBuffInfoCloseClick()
	gohelper.setActive(self._buffInfoRoot, false)
end

function XugoujiGamePlayerInfoView:_onHpUpdated()
	self:_refreshPlayerHP()
end

function XugoujiGamePlayerInfoView:_onOperateCard()
	self:_refreshOperateLeftTime()
end

function XugoujiGamePlayerInfoView:_onTurnChanged()
	self:_refreshOperateLeftTime()
end

function XugoujiGamePlayerInfoView:_onGotCardPair()
	self:_refreshOperateLeftTime()
end

function XugoujiGamePlayerInfoView:_onBuffsUpdated(isPlayer)
	if not isPlayer then
		return
	end

	self:_refreshBuffList()
end

function XugoujiGamePlayerInfoView:_onGameReStart()
	self:_refreshBuffList()
	self:_refreshOperateLeftTime()

	self._initialHP = Activity188Model.instance:getPlayerInitialHP()

	self:_refreshPlayerHP()
	self:_refreshSkillBtn()
end

function XugoujiGamePlayerInfoView:_onShowGameTips()
	self:_onSkillClick()
end

function XugoujiGamePlayerInfoView:_autoHideSkillTips()
	self:_onSkillHideClick()
end

function XugoujiGamePlayerInfoView:_onRefreshCards()
	self:_refreshCardPair()
end

function XugoujiGamePlayerInfoView:_editableInitView()
	return
end

function XugoujiGamePlayerInfoView:onOpen()
	self:_refreshBuffList()
	self:_refreshOperateLeftTime()

	self._initialHP = Activity188Model.instance:getPlayerInitialHP()
	self._txtPlayerHP.text = Activity188Model.instance:getCurHP()
	self._imagePlayerHP.fillAmount = 1

	self:_refreshPlayerHP()
	self:_refreshSkillBtn()
end

function XugoujiGamePlayerInfoView:_refreshPlayerHP()
	local oriValue = tonumber(self._txtPlayerHP.text)
	local newValue = tonumber(Activity188Model.instance:getCurHP())

	if oriValue == newValue then
		return
	end

	if newValue < oriValue and not self._showingDamage then
		self._showingDamage = true

		TaskDispatcher.runDelay(self._resetShowDemageEffect, self, 2.5)
		gohelper.setActive(self._goDamageEffect, false)
		gohelper.setActive(self._goDamageEffect, true)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.playerDamage)
		self._viewAnimator:Play("damage2", nil, nil)
	end

	self._txtPlayerHP.text = newValue

	local fillAmount = newValue / self._initialHP

	ZProj.TweenHelper.DOFillAmount(self._imagePlayerHP, fillAmount, hpTweenDuration)
	gohelper.setActive(self._goHp, true)

	local diffValue = newValue - oriValue

	self._textHpDiff.text = diffValue < 0 and diffValue or "+" .. diffValue

	SLFramework.UGUI.GuiHelper.SetColor(self._textHpDiff, diffValue < 0 and "#E57279" or "#7AC886")
	TaskDispatcher.cancelTask(self._delayHideHpChange, self)
	TaskDispatcher.runDelay(self._delayHideHpChange, self, 1)
end

function XugoujiGamePlayerInfoView:_resetShowDemageEffect()
	self._showingDamage = false
end

function XugoujiGamePlayerInfoView:_delayHideHpChange()
	gohelper.setActive(self._goHp, false)
end

function XugoujiGamePlayerInfoView:_refreshOperateLeftTime()
	self._txtRemainTime.text = Activity188Model.instance:getCurTurnOperateTime()
end

function XugoujiGamePlayerInfoView:_refreshSkillBtn()
	if not self._gameCfg then
		local curGameId = Activity188Model.instance:getCurGameId()

		self._gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	end

	self._abilityIdList = Activity188Model.instance:getPlayerAbilityIds()

	gohelper.setActive(self._btnSkill.gameObject, #self._abilityIdList > 0)
end

function XugoujiGamePlayerInfoView:_refreshCardPair()
	self._txtGotPairNum.text = Activity188Model.instance:getCurPairCount()
end

function XugoujiGamePlayerInfoView:_refreshBuffList()
	self._buffDataList = Activity188Model.instance:getBuffs(true)

	gohelper.CreateObjList(self, self._createBuffItem, self._buffDataList, self._goBuffRoot, self._goBuffItem)
end

function XugoujiGamePlayerInfoView:_createBuffItem(itemGo, buffData, index)
	gohelper.setActive(itemGo, true)

	local icon = gohelper.findChildImage(itemGo, "#image_BuffIcon")
	local buffCfg = Activity188Config.instance:getBuffCfg(actId, buffData.buffId)
	local buffIconId = buffCfg.icon

	if string.nilorempty(buffIconId) or buffIconId == "0" then
		-- block empty
	else
		UISpriteSetMgr.instance:setBuffSprite(icon, tonumber(buffIconId))
	end

	local layerNum = buffData.layer
	local buffNumText = gohelper.findChildText(itemGo, "#txt_Num")

	gohelper.setActive(buffNumText.gameObject, buffCfg.laminate == XugoujiEnum.BuffType.Round or buffCfg.laminate == XugoujiEnum.BuffType.Layer)

	buffNumText.text = layerNum
end

function XugoujiGamePlayerInfoView:_createSkillItem(itemGo, abilityCfg, index)
	gohelper.setActive(itemGo, true)

	local isTitle = abilityCfg.title

	if isTitle then
		return
	end

	local descText = gohelper.findChildText(itemGo, "txt_Descr")
	local icon = gohelper.findChildImage(itemGo, "#image_Icon")

	descText.text = abilityCfg.desc
end

function XugoujiGamePlayerInfoView:_createBuffInfoItem(itemGo, buffData, index)
	gohelper.setActive(itemGo, true)

	if buffData.bg then
		return
	end

	local buffCfg = Activity188Config.instance:getBuffCfg(actId, buffData.buffId)
	local buffIconId = buffCfg.icon
	local titleText = gohelper.findChildText(itemGo, "title/txt_name")
	local icon = gohelper.findChildImage(itemGo, "title/simage_Icon")

	titleText.text = buffCfg.name

	if not string.nilorempty(buffIconId) and buffIconId == "0" then
		UISpriteSetMgr.instance:setBuffSprite(icon, tonumber(buffIconId))
	end

	local descText = gohelper.findChildText(itemGo, "txt_desc")

	descText.text = buffCfg.desc

	local layerText = gohelper.findChildText(itemGo, "title/txt_name/go_tag/bg/txt_tagname")
	local layerNum = buffData.layer
	local layerStr = ""

	if buffCfg.laminate == XugoujiEnum.BuffType.Round then
		layerStr = formatLuaLang("x_round", layerNum)
	elseif buffCfg.laminate == XugoujiEnum.BuffType.Layer then
		layerStr = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_layer"), {
			layerNum
		})
	else
		local goTag = gohelper.findChild(itemGo, "title/txt_name/go_tag")

		gohelper.setActive(goTag, false)
	end

	layerText.text = layerStr
end

function XugoujiGamePlayerInfoView:onClose()
	return
end

function XugoujiGamePlayerInfoView:onDestroyView()
	return
end

return XugoujiGamePlayerInfoView
