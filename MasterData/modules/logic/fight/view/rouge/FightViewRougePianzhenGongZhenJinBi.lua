-- chunkname: @modules/logic/fight/view/rouge/FightViewRougePianzhenGongZhenJinBi.lua

module("modules.logic.fight.view.rouge.FightViewRougePianzhenGongZhenJinBi", package.seeall)

local FightViewRougePianzhenGongZhenJinBi = class("FightViewRougePianzhenGongZhenJinBi", BaseViewExtended)

function FightViewRougePianzhenGongZhenJinBi:onInitView()
	self._coinRoot = gohelper.findChild(self.viewGO, "coin")
	self._coinText = gohelper.findChildText(self.viewGO, "coin/#txt_num")
	self._addCoinEffect = gohelper.findChild(self.viewGO, "coin/obtain")
	self._minCoinEffect = gohelper.findChild(self.viewGO, "coin/without")
	self._resonancelObj = gohelper.findChild(self.viewGO, "layout/buffitem_short")
	self._resonancelNameText = gohelper.findChildText(self.viewGO, "layout/buffitem_short/bg/#txt_name")
	self._resonancelLevelText = gohelper.findChildText(self.viewGO, "layout/buffitem_short/bg/#txt_level")
	self._clickResonancel = gohelper.findChildClickWithDefaultAudio(self.viewGO, "layout/buffitem_short/bg")
	self._polarizationRoot = gohelper.findChild(self.viewGO, "layout/polarizationRoot")
	self._polarizationItem = gohelper.findChild(self.viewGO, "layout/polarizationRoot/buffitem_long")
	self._desTips = gohelper.findChild(self.viewGO, "#go_desc_tips")
	self._clickTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_desc_tips/#btn_click")
	self._tipsContentObj = gohelper.findChild(self.viewGO, "#go_desc_tips/Content")
	self._tipsContentTransform = self._tipsContentObj and self._tipsContentObj.transform
	self._tipsNameText = gohelper.findChildText(self.viewGO, "#go_desc_tips/Content/#txt_title")
	self._tipsDescText = gohelper.findChildText(self.viewGO, "#go_desc_tips/Content/#txt_details")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRougePianzhenGongZhenJinBi:addEvents()
	self.addClickCb(self, self._clickResonancel, self._onBtnResonancel, self)
	self.addClickCb(self, self._clickTips, self._onBtnTips, self)
	self.addEventCb(self, FightController.instance, FightEvent.ResonanceLevel, self._onResonanceLevel, self)
	self.addEventCb(self, FightController.instance, FightEvent.PolarizationLevel, self._onPolarizationLevel, self)
	self.addEventCb(self, FightController.instance, FightEvent.RougeCoinChange, self._onRougeCoinChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._onRespBeginFight, self)
end

function FightViewRougePianzhenGongZhenJinBi:removeEvents()
	return
end

function FightViewRougePianzhenGongZhenJinBi:_editableInitView()
	return
end

function FightViewRougePianzhenGongZhenJinBi:onRefreshViewParam()
	return
end

function FightViewRougePianzhenGongZhenJinBi:_onBtnTips()
	gohelper.setActive(self._desTips, false)
end

function FightViewRougePianzhenGongZhenJinBi:_onClothSkillRoundSequenceFinish()
	self:_hideObj()
end

function FightViewRougePianzhenGongZhenJinBi:_onRoundSequenceFinish()
	self:_hideObj()
end

function FightViewRougePianzhenGongZhenJinBi:_onRespBeginFight()
	self:_refreshCoin()
end

function FightViewRougePianzhenGongZhenJinBi:_hideObj()
	gohelper.setActive(self._resonancelObj, false)
	gohelper.setActive(self._polarizationRoot, false)
	gohelper.setActive(self._desTips, false)
	self.viewContainer.rightElementLayoutView:hideElement(FightRightElementEnum.Elements.Rouge)
end

function FightViewRougePianzhenGongZhenJinBi:_onResonanceLevel()
	self:_refreshData()
end

function FightViewRougePianzhenGongZhenJinBi:_onPolarizationLevel()
	self:_refreshData()
end

function FightViewRougePianzhenGongZhenJinBi:_cancelCoinTimer()
	TaskDispatcher.cancelTask(self._hideCoinEffect, self)
end

function FightViewRougePianzhenGongZhenJinBi:_hideCoinEffect()
	gohelper.setActive(self._addCoinEffect, false)
	gohelper.setActive(self._minCoinEffect, false)
end

function FightViewRougePianzhenGongZhenJinBi:_onRougeCoinChange(offset)
	self:_refreshData()
	self:_cancelCoinTimer()
	TaskDispatcher.runDelay(self._hideCoinEffect, self, 0.6)

	if offset > 0 then
		gohelper.setActive(self._addCoinEffect, true)
		gohelper.setActive(self._minCoinEffect, false)
	else
		gohelper.setActive(self._addCoinEffect, false)
		gohelper.setActive(self._minCoinEffect, true)
	end
end

function FightViewRougePianzhenGongZhenJinBi:onOpen()
	gohelper.setActive(self._desTips, false)
	self:_refreshData()
end

function FightViewRougePianzhenGongZhenJinBi:_refreshData()
	gohelper.setActive(self.viewGO, true)
	self:_refreshCoin()
	self:_refreshPianZhenGongZhen()
end

function FightViewRougePianzhenGongZhenJinBi:_onBtnResonancel()
	local tab = self:getUserDataTb_()

	tab.config = self._resonancelConfig
	tab.obj = self._resonancelObj

	self:_showTips(tab)
end

function FightViewRougePianzhenGongZhenJinBi:_refreshPianZhenGongZhen()
	self._resonancelLevel = FightRoundSequence.roundTempData.ResonanceLevel

	if self._resonancelLevel then
		local showResonancelLevel = self._resonancelLevel ~= 0

		gohelper.setActive(self._resonancelObj, showResonancelLevel)

		if showResonancelLevel then
			self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.Rouge)

			local config = lua_resonance.configDict[self._resonancelLevel]

			if config then
				self._resonancelConfig = config
				self._resonancelNameText.text = config and config.name
				self._resonancelLevelText.text = "Lv." .. self._resonancelLevel

				for i = 1, 3 do
					local effectObj = gohelper.findChild(self.viewGO, "buffitem_short/effect_lv/effect_lv" .. i)

					gohelper.setActive(effectObj, i == self._resonancelLevel)
				end

				if self._resonancelLevel > 3 then
					gohelper.setActive(gohelper.findChild(self.viewGO, "buffitem_short/effect_lv/effect_lv3"), true)
				end
			else
				gohelper.setActive(self._resonancelObj, false)
			end
		end

		self._polarizationDic = FightRoundSequence.roundTempData.PolarizationLevel

		if self._polarizationDic then
			for k, v in pairs(self._polarizationDic) do
				if v.effectNum == 0 then
					self._polarizationDic[k] = nil
				end
			end
		end

		if self._polarizationDic then
			local showPolarization = tabletool.len(self._polarizationDic) > 0

			gohelper.setActive(self._polarizationRoot, showPolarization)

			if showPolarization then
				self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.Rouge)

				local list = {}

				for k, v in pairs(self._polarizationDic) do
					table.insert(list, v)
				end

				table.sort(list, FightViewRougePianzhenGongZhenJinBi.sortPolarization)
				self:com_createObjList(self._onPolarizationItemShow, list, self._polarizationRoot, self._polarizationItem)
			end
		end
	end
end

function FightViewRougePianzhenGongZhenJinBi.sortPolarization(item1, item2)
	return item1.configEffect < item2.configEffect
end

function FightViewRougePianzhenGongZhenJinBi:_onPolarizationItemShow(obj, data, index)
	local config = lua_polarization.configDict[data.effectNum]

	config = config and lua_polarization.configDict[data.effectNum][data.configEffect]

	if not config then
		gohelper.setActive(obj, false)

		return
	end

	local nameText = gohelper.findChildText(obj, "bg/#txt_name")
	local levelText = gohelper.findChildText(obj, "bg/#txt_level")

	nameText.text = config and config.name

	local level = data.effectNum

	levelText.text = "Lv." .. level

	local click = gohelper.getClickWithDefaultAudio(gohelper.findChild(obj, "bg"))

	self:removeClickCb(click)

	local tab = self:getUserDataTb_()

	tab.config = config
	tab.obj = obj

	self.addClickCb(self, click, self._onBtnPolarization, self, tab)

	for i = 1, 3 do
		local effectObj = gohelper.findChild(obj, "effect_lv/effect_lv" .. i)

		gohelper.setActive(effectObj, i == level)
	end

	if level > 3 then
		gohelper.setActive(gohelper.findChild(obj, "effect_lv/effect_lv3"), true)
	end
end

function FightViewRougePianzhenGongZhenJinBi:_onBtnPolarization(config)
	self:_showTips(config)
end

function FightViewRougePianzhenGongZhenJinBi:_showTips(tab)
	local config = tab and tab.config

	if config then
		gohelper.setActive(self._desTips, true)

		self._tipsNameText.text = config.name
		self._tipsDescText.text = HeroSkillModel.instance:skillDesToSpot(config.desc)

		if self._tipsContentTransform then
			local posX, posY = recthelper.rectToRelativeAnchorPos2(tab.obj.transform.position, self.viewGO.transform)

			recthelper.setAnchorY(self._tipsContentTransform, posY)
		end
	end
end

function FightViewRougePianzhenGongZhenJinBi:_refreshCoin()
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local showCoin = episode_config and episode_config.type == DungeonEnum.EpisodeType.Rouge

	if showCoin then
		self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.Rouge)
	end

	gohelper.setActive(self._coinRoot, showCoin)

	self._coinText.text = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)
end

function FightViewRougePianzhenGongZhenJinBi:onClose()
	self:_cancelCoinTimer()
end

function FightViewRougePianzhenGongZhenJinBi:onDestroyView()
	return
end

return FightViewRougePianzhenGongZhenJinBi
