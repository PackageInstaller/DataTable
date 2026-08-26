-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterBuffEntry.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffEntry", package.seeall)

local RougeLimiterBuffEntry = class("RougeLimiterBuffEntry", LuaCompBase)

RougeLimiterBuffEntry.DefaultDifficultyFontSize = 38

function RougeLimiterBuffEntry:init(go)
	self.viewGO = go
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "#txt_difficulty")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._gonamebg = gohelper.findChild(self.viewGO, "namebg")
	self._numAnim = gohelper.onceAddComponent(self._txtnum.gameObject, gohelper.Type_Animator)
	self._canvasgroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	self._selectIndex = 0
end

function RougeLimiterBuffEntry:addEventListeners()
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, self._onUpdateBuffState, self)
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, self._onUpdateLimiterGroup, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
end

function RougeLimiterBuffEntry:removeEventListeners()
	return
end

function RougeLimiterBuffEntry:refreshUI(enabledPlayAnim)
	self:refreshRisk()
	self:refreshAllBuffEntry()
	self:refreshRiskIcon(enabledPlayAnim)
end

function RougeLimiterBuffEntry:refreshRisk()
	local totalRiskValue = self:getTotalRiskValue()
	local curRiskCo = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(totalRiskValue)

	self._switchRiskStage = not self._riskCo or not curRiskCo or self._riskCo.id ~= curRiskCo.id
	self._riskCo = curRiskCo
	self._txtdifficulty.text = self._riskCo and self._riskCo.title
	self._txtnum.text = totalRiskValue

	self._numAnim:Play(self._switchRiskStage and "refresh" or "idle", 0, 0)

	local maxLevelRiskCo = RougeDLCConfig101.instance:getMaxLevlRiskCo()
	local var_5_0

	if maxLevelRiskCo then
		::label_5_0::

		var_5_0 = self._riskCo and maxLevelRiskCo.id == self._riskCo.id
	end

	self._isCurMaxLevel = var_5_0
end

function RougeLimiterBuffEntry:getTotalRiskValue()
	return RougeDLCModel101.instance:getTotalRiskValue()
end

function RougeLimiterBuffEntry:refreshRiskIcon(enabledPlayAnim)
	local isAnyRiskStage = false

	for index = 1, #lua_rouge_risk.configList do
		local riskCo = lua_rouge_risk.configList[index]
		local godifficulty = gohelper.findChild(self.viewGO, "difficulty/" .. riskCo.id)

		if self._riskCo then
			local isRisk = self._riskCo.id == riskCo.id

			gohelper.setActive(godifficulty, isRisk)

			if isRisk then
				isAnyRiskStage = true

				if self._switchRiskStage and enabledPlayAnim then
					local anim = gohelper.onceAddComponent(godifficulty, gohelper.Type_Animator)

					anim:Play("open", 0, 0)
					anim:Update(0)
				end
			end
		end
	end

	local goNoneRisk = gohelper.findChild(self.viewGO, "difficulty/none")

	gohelper.setActive(goNoneRisk, not isAnyRiskStage)

	if not isAnyRiskStage and enabledPlayAnim then
		local anim = gohelper.onceAddComponent(goNoneRisk, gohelper.Type_Animator)

		anim:Play("open", 0, 0)
	end
end

function RougeLimiterBuffEntry:refreshAllBuffEntry()
	if self._riskCo then
		if not self._riskCo.buffNum then
			local buffNum = 0
			local allBuffTyps = self:_getAllBuffTypes()

			for _, buffType in ipairs(allBuffTyps) do
				local isVisible = buffType <= buffNum

				self:refreshBuffEntry(buffType, isVisible)
			end
		end
	end
end

function RougeLimiterBuffEntry:_getAllBuffTypes()
	local allBuffTypes = {}

	for _, buffType in pairs(RougeDLCEnum101.LimiterBuffType) do
		table.insert(allBuffTypes, buffType)
	end

	table.sort(allBuffTypes, RougeLimiterBuffEntry._sortBuffType)

	return allBuffTypes
end

function RougeLimiterBuffEntry._sortBuffType(aBuffType, bBuffType)
	return aBuffType < bBuffType
end

function RougeLimiterBuffEntry:refreshBuffEntry(buffType, isVisible)
	local buffPartItem = self:_getOrCreateBuffPart(buffType)

	gohelper.setActive(buffPartItem.gobuff, isVisible)

	if not isVisible then
		return
	end

	local buffCo = self:_getTypeBuffEquiped(buffType)
	local isEquiped = buffCo ~= nil
	local isEquipedBlank = buffCo and buffCo.blank == 1
	local isSelect = self._selectIndex == buffType

	gohelper.setActive(buffPartItem.imageunequiped.gameObject, not isEquiped)
	gohelper.setActive(buffPartItem.imageequipednormal.gameObject, isEquiped and not isEquipedBlank)
	gohelper.setActive(buffPartItem.goquipedblank, isEquipedBlank and not self._isCurMaxLevel)
	gohelper.setActive(buffPartItem.goequipedblankred, isEquipedBlank and self._isCurMaxLevel)
	gohelper.setActive(buffPartItem.imageselect.gameObject, isSelect)

	local imageName = string.format("rouge_dlc1_buffbtn" .. buffType)

	if self._isCurMaxLevel then
		imageName = imageName .. "_hong"
	end

	UISpriteSetMgr.instance:setRouge3Sprite(buffPartItem.imageunequiped, imageName, true)
	UISpriteSetMgr.instance:setRouge3Sprite(buffPartItem.imageequipednormal, imageName, true)
end

function RougeLimiterBuffEntry:_getOrCreateBuffPart(index)
	self._buffPartTab = self._buffPartTab or self:getUserDataTb_()

	local buffPartItem = self._buffPartTab[index]

	if not buffPartItem then
		buffPartItem = self:getUserDataTb_()
		buffPartItem.gobuff = gohelper.findChild(self.viewGO, "#go_buff" .. index)
		buffPartItem.imageunequiped = gohelper.findChildImage(buffPartItem.gobuff, "unselect_unequip")
		buffPartItem.imageequipednormal = gohelper.findChildImage(buffPartItem.gobuff, "unselect_equiped")
		buffPartItem.goquipedblank = gohelper.findChild(buffPartItem.gobuff, "none")
		buffPartItem.goequipedblankred = gohelper.findChild(buffPartItem.gobuff, "none_red")
		buffPartItem.imageselect = gohelper.findChildImage(buffPartItem.gobuff, "select_equiped")
		buffPartItem.btnclick = gohelper.findChildButtonWithAudio(buffPartItem.gobuff, "btn_click")

		buffPartItem.btnclick:AddClickListener(self._btnbuffOnClick, self, index)

		self._buffPartTab[index] = buffPartItem
	end

	return buffPartItem
end

function RougeLimiterBuffEntry:_getTypeBuffEquiped(buffType)
	local versions = RougeModel.instance:getVersion()
	local buffCos = RougeDLCConfig101.instance:getAllLimiterBuffCosByType(versions, buffType)

	if buffCos then
		for _, buffCo in ipairs(buffCos) do
			local state = RougeDLCModel101.instance:getLimiterBuffState(buffCo.id)

			if state == RougeDLCEnum101.BuffState.Equiped then
				return buffCo
			end
		end
	end
end

function RougeLimiterBuffEntry:_onUpdateBuffState(buffId)
	local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

	if not buffCo then
		return
	end

	self:refreshBuffEntry(buffCo.buffType, true)
end

function RougeLimiterBuffEntry:_onUpdateLimiterGroup(groupId)
	self:refreshUI(true)
end

function RougeLimiterBuffEntry:_onUpdateRougeInfo()
	self:refreshUI()
end

function RougeLimiterBuffEntry:_btnbuffOnClick(index)
	self:selectBuffEntry(index)
	RougeDLCController101.instance:openRougeLimiterBuffView({
		buffType = index
	})
end

function RougeLimiterBuffEntry:selectBuffEntry(index)
	self._selectIndex = index or 0

	self:refreshAllBuffEntry()
end

function RougeLimiterBuffEntry:setDifficultyTxtFontSize(fontSize)
	fontSize = fontSize or RougeLimiterBuffEntry.DefaultDifficultyFontSize
	self._txtdifficulty.fontSize = fontSize
end

function RougeLimiterBuffEntry:setDifficultyVisible(isVisible)
	gohelper.setActive(self._txtdifficulty.gameObject, isVisible)
	gohelper.setActive(self._gonamebg, isVisible)
end

function RougeLimiterBuffEntry:setPlaySwitchAnim(isEnabled)
	self._enabledPlaySwitchAnim = isEnabled
end

function RougeLimiterBuffEntry:setInteractable(interactable)
	self._canvasgroup.interactable = interactable
	self._canvasgroup.blocksRaycasts = interactable
end

function RougeLimiterBuffEntry:removeAllBuffPartClick()
	if self._buffPartTab then
		for _, buffPartItem in pairs(self._buffPartTab) do
			if buffPartItem.btnclick then
				buffPartItem.btnclick:RemoveClickListener()
			end
		end
	end
end

function RougeLimiterBuffEntry:onDestroy()
	self:removeAllBuffPartClick()
end

return RougeLimiterBuffEntry
