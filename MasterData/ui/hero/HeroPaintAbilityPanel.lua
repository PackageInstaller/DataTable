-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroPaintAbilityPanel.lua

local ResPaintAbility = require("ClientData/ResPaintAbility")
local ResAbilityStore = require("ClientData/ResAbilityStore")
local ResHeroMisc = require("ClientData/ResHeroMisc")
local strClassName = "HeroPaintAbilityPanel"
local HeroPaintAbilityPanel = Class(strClassName, UIControls.Panel)

function HeroPaintAbilityPanel:ctor()
	self:initUI()
end

function HeroPaintAbilityPanel:initUI()
	self.attrList = {}
	self.optionList = {}

	for i = 1, 5 do
		local attrPanel = UIControls.UIAni(self, self.mPath .. "/PropertiesNode/Attr0" .. i)
		local attrIcon = UIControls.Image(self, self.mPath .. "/PropertiesNode/Attr0" .. i .. "/Icon")
		local attrTxt = UIControls.Label(self, self.mPath .. "/PropertiesNode/Attr0" .. i .. "/Text")
		local attrNew = UIControls.Image(self, self.mPath .. "/PropertiesNode/Attr0" .. i .. "/IconNew")

		self.attrList[i] = {
			panel = attrPanel,
			icon = attrIcon,
			text = attrTxt,
			new = attrNew
		}

		local optionToggle = UIControls.Button(self, self.mPath .. "/PropertiesList/Option" .. i)

		optionToggle:addEventClick(self.onOptionToggleClick)

		local optionTxt = UIControls.Label(self, self.mPath .. "/PropertiesList/Option" .. i .. "/Text")
		local optionCheck = UIControls.Image(self, self.mPath .. "/PropertiesList/Option" .. i .. "/Background/Checkmark")

		self.optionList[i] = {
			toggle = optionToggle,
			text = optionTxt,
			check = optionCheck
		}
	end

	self.txtTitle = UIControls.Label(self, self.mPath .. "/PropertiesList/TtileText")
	self.txtTick = UIControls.Label(self, self.mPath .. "/PropertiesList/TextTime/Text")
	self.txtTime = UIControls.Label(self, self.mPath .. "/PropertiesList/TextTime")
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/PropertiesList/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnPropertiesNode = UIControls.Button(self, self.mPath .. "/PropertiesNode")

	self.btnPropertiesNode:addEventClick(self.onBtnPropertiesNodeClick)

	self.panelPropertiesList = UIControls.Panel(self, self.mPath .. "/PropertiesList")
	self.panelProperAni = UIControls.UIAni(self, self.mPath)

	self.panelProperAni:addEventFinish(self._onAniFinish)
end

function HeroPaintAbilityPanel:onBtnPropertiesNodeClick()
	if self.panelPropertiesList:getVisible() then
		self.selectAbilityDic = {}

		self:refreshOptionShow()
		self.panelProperAni:startAni("HidePropertiesList", true)
		self.mWindow.btnCloseProperSensor:setVisible(false)
	else
		self.panelPropertiesList:setVisible(true)
		self.mWindow.btnCloseProperSensor:setVisible(true)
		self.panelProperAni:startAni("ShowPropertiesList", true)
	end
end

function HeroPaintAbilityPanel:_onAniFinish(aniCom, aniName)
	if aniName == "HidePropertiesList" then
		self.panelPropertiesList:setVisible(false)
	end
end

function HeroPaintAbilityPanel:setPaintData(paintData, hero)
	self.paintData = paintData
	self.hero = hero
	self.selectAbilityDic = {}

	if ResAbilityStore[self.hero.id] then
		self.txtTitle:setText(string.format(Lang.get(30344), self.paintData.resData.ability_count or 0))

		for _, attrPanel in ipairs(self.attrList) do
			attrPanel.panel:setVisible(false)
		end

		for _, optionCom in ipairs(self.optionList) do
			optionCom.toggle:setVisible(false)
		end

		self.abilityIdList = {}

		for _, abilityId in pairs(self.paintData.abilityList) do
			table.insert(self.abilityIdList, abilityId)
		end

		self.optionToggleDic = {}

		for i, abilityId in ipairs(ResAbilityStore[self.hero.id].ability_store) do
			self.optionList[i].toggle:setVisible(true)
			self.optionList[i].text:setText(ResPaintAbility[abilityId].desc)
		end

		for i = 1, self.paintData.resData.ability_count or 0 do
			self.attrList[i].panel:setVisible(true)
			self.attrList[i].new:setVisible(true)
			self.attrList[i].text:setVisible(false)
		end

		for i, abilityId in ipairs(self.abilityIdList) do
			if ResPaintAbility[abilityId] then
				self.attrList[i].text:setVisible(true)
				self.attrList[i].new:setVisible(false)
				self.attrList[i].text:setText(ResPaintAbility[abilityId].simple_desc)
			end
		end

		self:refreshOptionShow()
		self.txtTime:setVisible(true)

		self.remainTime = self.paintData.changeTick + ResHeroMisc[1].ability_cd - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondTickUI(self.txtTick, self.remainTime, nil, nil, nil, Slot(self.countdownCallback, self), nil, 1)
	end
end

function HeroPaintAbilityPanel:countdownCallback()
	self.txtTime:setVisible(false)

	self.remainTime = 0
end

function HeroPaintAbilityPanel:refreshOptionShow()
	if ResAbilityStore[self.hero.id] then
		for i, _ in ipairs(self.optionList) do
			self.optionList[i].check:setVisible(self.selectAbilityDic[ResAbilityStore[self.hero.id].ability_store[i]] ~= nil)
		end
	end
end

function HeroPaintAbilityPanel:onOptionToggleClick(sender)
	if self.remainTime > 0 then
		MsgManager.clientNotice(354)

		return
	end

	for i, _ in ipairs(self.optionList) do
		if sender == self.optionList[i].toggle then
			local abilityId = ResAbilityStore[self.hero.id].ability_store[i]

			if self.selectAbilityDic[abilityId] then
				self.selectAbilityDic[abilityId] = nil
			else
				local canSelectCount = self.paintData.resData.ability_count

				if canSelectCount <= utils.getTableElemCount(self.selectAbilityDic) then
					MsgManager.clientNotice(356)
				else
					self.selectAbilityDic[abilityId] = true
				end
			end
		end
	end

	self:refreshOptionShow()
end

function HeroPaintAbilityPanel:onBtnConfirmClick()
	if self.remainTime > 0 then
		MsgManager.clientNotice(354)

		return
	end

	if utils.getTableElemCount(self.selectAbilityDic) ~= self.paintData.resData.ability_count then
		MsgManager.clientNotice(357)

		return
	end

	local unchange = utils.getTableElemCount(self.selectAbilityDic) == #self.abilityIdList

	for i, abilityId in ipairs(self.abilityIdList) do
		if not self.selectAbilityDic[abilityId] then
			unchange = false

			break
		end
	end

	if not unchange then
		local function yesFunc()
			local ability = {}
			local abilityIdIdxDic = {}

			for idx, abilityId in ipairs(ResAbilityStore[self.hero.id].ability_store) do
				abilityIdIdxDic[abilityId] = idx
			end

			for abilityId, _ in pairs(self.selectAbilityDic) do
				table.insert(ability, abilityIdIdxDic[abilityId])
			end

			RPC.heroPaintAbility(self.hero.id, ability)

			if self.panelPropertiesList:getVisible() then
				self.panelProperAni:startAni("HidePropertiesList", true)
				self.mWindow.btnCloseProperSensor:setVisible(false)
			end
		end

		local msgContent = ClientUtils.getClientNotice(355)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
	else
		MsgManager.clientNotice(358)
	end
end

function HeroPaintAbilityPanel:playUnlockAbility(unlockAbility)
	self.attrList[unlockAbility].panel:startAni("ShowEnablingAttr", true)
end

return HeroPaintAbilityPanel
