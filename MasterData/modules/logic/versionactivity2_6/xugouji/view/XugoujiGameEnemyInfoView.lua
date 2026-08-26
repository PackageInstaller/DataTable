-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiGameEnemyInfoView.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameEnemyInfoView", package.seeall)

local XugoujiGameEnemyInfoView = class("XugoujiGameEnemyInfoView", BaseView)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji
local hpTweenDuration = 0.35

function XugoujiGameEnemyInfoView:onInitView()
	self._goEnemyInfo = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy")
	self._txtHP = gohelper.findChildText(self._goEnemyInfo, "Role/image_RoleHPNumBG/#txt_RoleHP")
	self._btnIcon = gohelper.findChildButtonWithAudio(self._goEnemyInfo, "Role/image/#simage_Role")
	self._imageIcon = gohelper.findChildSingleImage(self._goEnemyInfo, "Role/image/#simage_Role")
	self._txtRemainTime = gohelper.findChildText(self._goEnemyInfo, "Remain/#txt_RemainValue")
	self._txtGotPairNum = gohelper.findChildText(self._goEnemyInfo, "Pairs/#txt_PairsValue")
	self._imageHP = gohelper.findChildImage(self._goEnemyInfo, "Role/image_RoleHPBG/#image_RoleHPFG")
	self._goHp = gohelper.findChild(self._goEnemyInfo, "#go_HP")
	self._textHpDiff = gohelper.findChildText(self._goEnemyInfo, "#go_HP/#txt_HP")
	self._btnBuff = gohelper.findChildButtonWithAudio(self._goEnemyInfo, "#go_Buff")
	self._goBuffRoot = gohelper.findChild(self._goEnemyInfo, "#go_Buff")
	self._goBuffItem = gohelper.findChild(self._goBuffRoot, "#go_Buff")
	self._buffInfoRoot = gohelper.findChild(self._goEnemyInfo, "bufftipsview")
	self._goBuffInfoContent = gohelper.findChild(self._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content")
	self._goBuffInfoItem = gohelper.findChild(self._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	self._btnBuffInfoClose = gohelper.findChildButtonWithAudio(self._buffInfoRoot, "#btn_buffTipsHide")
	self._btnSkill = gohelper.findChildButtonWithAudio(self._goEnemyInfo, "Role/#btn_Skill")
	self._skillRoot = gohelper.findChild(self._goEnemyInfo, "#go_ViewSkillTips")
	self._btnSkillTipsHide = gohelper.findChildButtonWithAudio(self._skillRoot, "#btnSkillTipsHide")
	self._skillItemRoot = gohelper.findChild(self._goEnemyInfo, "#go_ViewSkillTips/image_TipsBG")
	self._skillItem = gohelper.findChild(self._skillRoot, "image_TipsBG/#go_Item")
	self._skillTipsAnimator = ZProj.ProjAnimatorPlayer.Get(self._skillRoot)
	self._viewAnimator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._goDamageEffect = gohelper.findChild(self._goEnemyInfo, "#go_damage")
end

function XugoujiGameEnemyInfoView:addEvents()
	self._btnIcon:AddClickListener(self._onIconClick, self)
	self._btnSkill:AddClickListener(self._onSkillClick, self)
	self._btnSkillTipsHide:AddClickListener(self._onSkillHideClick, self)
	self._btnBuff:AddClickListener(self._onBuffClick, self)
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

function XugoujiGameEnemyInfoView:removeEvents()
	self._btnIcon:RemoveClickListener()
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

function XugoujiGameEnemyInfoView:_onIconClick()
	return
end

function XugoujiGameEnemyInfoView:_onSkillClick()
	if not self._gameCfg then
		local curGameId = Activity188Model.instance:getCurGameId()

		self._gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	end

	self._abilityCfgList = {
		{
			title = true
		}
	}
	self._abilityIdList = Activity188Model.instance:getEnemyAbilityIds()

	for idx, abilityId in ipairs(self._abilityIdList) do
		self._abilityCfgList[idx + 1] = Activity188Config.instance:getAbilityCfg(actId, abilityId)
	end

	if #self._abilityCfgList == 1 then
		return
	end

	gohelper.setActive(self._skillRoot, true)
	self._skillTipsAnimator:Play(UIAnimationName.Open, nil, nil)
	gohelper.setActive(self._btnSkillTipsHide.gameObject, true)
	gohelper.CreateObjList(self, self._createSkillItem, self._abilityCfgList, self._skillItemRoot, self._skillItem)
end

function XugoujiGameEnemyInfoView:_onSkillHideClick()
	gohelper.setActive(self._btnSkillTipsHide.gameObject, false)
	self._skillTipsAnimator:Play(UIAnimationName.Close, self.onSkillTipsCloseAniFinish, self)
end

function XugoujiGameEnemyInfoView:onSkillTipsCloseAniFinish()
	gohelper.setActive(self._skillRoot, false)
end

function XugoujiGameEnemyInfoView:_onBuffClick()
	self._buffDataList = Activity188Model.instance:getBuffs(false)

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

function XugoujiGameEnemyInfoView:_onBuffInfoCloseClick()
	gohelper.setActive(self._buffInfoRoot, false)
end

function XugoujiGameEnemyInfoView:_onHpUpdated()
	local newText = Activity188Model.instance:getEnemyHP()
	local newValue = tonumber(newText)

	if self._curTextValue == newValue then
		return
	elseif self._showingDamage then
		if self._showDamageQueue then
			self._showDamageQueue = self._showDamageQueue or {}
		end

		self._showDamageQueue[#self._showDamageQueue + 1] = newValue
	else
		self:_refreshHP(nil)
	end
end

function XugoujiGameEnemyInfoView:_onOperateCard()
	self:_refreshOperateLeftTime()
end

function XugoujiGameEnemyInfoView:_onTurnChanged()
	self:_refreshOperateLeftTime()
end

function XugoujiGameEnemyInfoView:_onBuffsUpdated(isPlayer)
	if isPlayer then
		return
	end

	self:_refreshBuffList()
end

function XugoujiGameEnemyInfoView:_onGameReStart()
	self._initialHP = Activity188Model.instance:getEnemyInitialHP()

	self:_refreshHP()
	self:_refreshOperateLeftTime()
	self:_refreshIcon()
	self:_refreshBuffList()
	self:_refreshSkillBtn()
end

function XugoujiGameEnemyInfoView:_onShowGameTips()
	self:_onSkillClick()
end

function XugoujiGameEnemyInfoView:_autoHideSkillTips()
	self:_onSkillHideClick()
end

function XugoujiGameEnemyInfoView:_onRefreshCards()
	self:_refreshCardPair()
end

function XugoujiGameEnemyInfoView:_editableInitView()
	return
end

function XugoujiGameEnemyInfoView:onOpen()
	self._initialHP = Activity188Model.instance:getEnemyInitialHP()
	self._txtHP.text = Activity188Model.instance:getEnemyHP()
	self._curTextValue = Activity188Model.instance:getEnemyHP()
	self._imageHP.fillAmount = 1

	self:_refreshHP()
	self:_refreshOperateLeftTime()
	self:_refreshIcon()
	self:_refreshBuffList()
	self:_refreshSkillBtn()
end

function XugoujiGameEnemyInfoView:_refreshIcon()
	local gameId = Activity188Model.instance:getCurGameId()
	local gameCfg = Activity188Config.instance:getGameCfg(actId, gameId)
	local iconPath = gameCfg.portrait

	if iconPath or iconPath ~= "" then
		self._imageIcon:LoadImage(iconPath)
	end
end

function XugoujiGameEnemyInfoView:_refreshSkillBtn()
	if not self._gameCfg then
		local curGameId = Activity188Model.instance:getCurGameId()

		self._gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	end

	self._abilityIdList = Activity188Model.instance:getEnemyAbilityIds()

	gohelper.setActive(self._btnSkill.gameObject, #self._abilityIdList > 0)
end

function XugoujiGameEnemyInfoView:_refreshTurns(curTurnNum, totalTurnNum)
	self._txtTurn.text = string.format("%d/%d", curTurnNum, totalTurnNum)
end

function XugoujiGameEnemyInfoView:_refreshHP(hpValue)
	local newText = Activity188Model.instance:getEnemyHP()
	local newValue = hpValue and hpValue or tonumber(newText)

	if self._curTextValue then
		if not self._curTextValue then
			local oriValue = 0

			if oriValue == newValue then
				return
			end

			if newValue < oriValue and not self._showingDamageEffect then
				self._showingDamageEffect = true

				TaskDispatcher.runDelay(self._resetShowDemageEffect, self, 2.5)
				gohelper.setActive(self._goDamageEffect, false)
				gohelper.setActive(self._goDamageEffect, true)
				AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.enemyDamage)
				self._viewAnimator:Play("damage1", nil, nil)
			end

			self._showingDamage = true

			local newValue = Activity188Model.instance:getEnemyHP()

			self._curTextValue = newValue
			self._txtHP.text = newValue

			local fillAmount = tonumber(newValue) / self._initialHP

			ZProj.TweenHelper.DOFillAmount(self._imageHP, fillAmount, hpTweenDuration)
			gohelper.setActive(self._goHp, true)

			local diffValue = newValue - oriValue

			self._textHpDiff.text = diffValue < 0 and diffValue or "+" .. diffValue

			SLFramework.UGUI.GuiHelper.SetColor(self._textHpDiff, diffValue < 0 and "#E57279" or "#7AC886")
			TaskDispatcher.cancelTask(self._hpChangeDone, self)
			TaskDispatcher.runDelay(self._hpChangeDone, self, 1)
		end
	end
end

function XugoujiGameEnemyInfoView:_resetShowDemageEffect()
	self._showingDamageEffect = false
end

function XugoujiGameEnemyInfoView:_hpChangeDone()
	self._showingDamage = false

	gohelper.setActive(self._goHp, false)

	if self._showDamageQueue and #self._showDamageQueue > 0 then
		local hpValue = self._showDamageQueue[1]

		table.remove(self._showDamageQueue, 1)
		self:_refreshHP(hpValue)
	end
end

function XugoujiGameEnemyInfoView:_refreshOperateLeftTime()
	self._txtRemainTime.text = Activity188Model.instance:getEnemyOperateTime()
end

function XugoujiGameEnemyInfoView:_refreshCardPair()
	self._txtGotPairNum.text = Activity188Model.instance:getEnemyPairCount()
end

function XugoujiGameEnemyInfoView:_refreshBuffList()
	self._buffDataList = Activity188Model.instance:getBuffs(false)

	gohelper.CreateObjList(self, self._createBuffItem, self._buffDataList, self._goBuffRoot, self._goBuffItem)
end

function XugoujiGameEnemyInfoView:_createBuffItem(itemGo, buffData, index)
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

function XugoujiGameEnemyInfoView:_createSkillItem(itemGo, abilityCfg, index)
	gohelper.setActive(itemGo, true)

	local isTitle = abilityCfg.title

	if isTitle then
		return
	end

	local descText = gohelper.findChildText(itemGo, "txt_Descr")
	local icon = gohelper.findChildImage(itemGo, "#image_Icon")

	descText.text = abilityCfg.desc
end

function XugoujiGameEnemyInfoView:_createBuffInfoItem(itemGo, buffData, index)
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

function XugoujiGameEnemyInfoView:_createTargetList()
	gohelper.CreateObjList(self, self._createTargetItem, self._targetDataList, self._gotargetItemRoot, self._gotargetItem)
end

function XugoujiGameEnemyInfoView:_createTargetItem(itemGo, targetData, index)
	gohelper.setActive(itemGo, true)
end

function XugoujiGameEnemyInfoView:_storyEnd()
	return
end

function XugoujiGameEnemyInfoView:onClose()
	TaskDispatcher.cancelTask(self._resetShowDemageEffect, self)
	TaskDispatcher.cancelTask(self._hpChangeDone, self)
end

function XugoujiGameEnemyInfoView:onDestroyView()
	self._imageIcon:UnLoadImage()
end

return XugoujiGameEnemyInfoView
