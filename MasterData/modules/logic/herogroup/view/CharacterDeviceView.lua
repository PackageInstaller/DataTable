-- chunkname: @modules/logic/herogroup/view/CharacterDeviceView.lua

module("modules.logic.herogroup.view.CharacterDeviceView", package.seeall)

local CharacterDeviceView = class("CharacterDeviceView", LuaCompBase)

function CharacterDeviceView:init(go)
	self.viewGO = go
	self._godevice = gohelper.findChild(self.viewGO, "#go_device")
	self._gonomal = gohelper.findChild(self.viewGO, "#go_device/#go_nomal")
	self._gonormalItem = gohelper.findChild(self.viewGO, "#go_device/#go_nomal/item")
	self._gospecial = gohelper.findChild(self.viewGO, "#go_device/#go_special")
	self._gospecialItem = gohelper.findChild(self.viewGO, "#go_device/#go_special/item")
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDeviceView:addEventListeners()
	if self._animEventWrap then
		self._animEventWrap:AddEventListener("switch", self._animSwitchEvent, self)
	end
end

function CharacterDeviceView:removeEventListeners()
	if self.s02btn then
		self.s02btn:RemoveClickListener()
	end

	if self._animEventWrap then
		self._animEventWrap:AddEventListener("switch", self._animSwitchEvent, self)
	end
end

function CharacterDeviceView:_animSwitchEvent()
	self:_refreshTwinssychubeSelectCardGroup()
end

function CharacterDeviceView:_editableInitView()
	gohelper.setActive(self._gonormalItem, false)
	gohelper.setActive(self._gospecialItem, false)

	self._cardNum = 3
	self._isLoadFinish = false

	local playcards = gohelper.findChild(self.viewGO, "playcards/card_layout")

	self._cardItems = self:getUserDataTb_()

	for i = 1, self._cardNum do
		local item = self:getUserDataTb_()

		item.root = gohelper.findChild(playcards, "card" .. i)
		self._cardItems[i] = item
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	for i, item in ipairs(self._cardItems) do
		item.index = i
		item.super = item.index == 3
		item.cardItem = item.super and CharacterDeviceCardItemUnique.Create(item.root) or CharacterDeviceCardItemNormal.Create(item.root)

		item.cardItem:AddClickListener(self._onSkillCardClick, self, item.index)
		item.cardItem:startLoad(self._refreshCardUI, self)
	end
end

function CharacterDeviceView:_initS02()
	if not self._gos02switch then
		if self._param then
			if not self._param.deviceType then
				local deviceType = 1
				local path = deviceType == 1 and "playcards/go_s02_switch" or "playcards/card_layout/go_s02_switch"

				self._selectCardGroupIndex = 1
				self._gos02switch = gohelper.findChild(self.viewGO, path)
				self._s02tbs = self:getUserDataTb_()

				if self._gos02switch then
					local s02tab = gohelper.findChild(self._gos02switch, "Tab")

					for i = 1, 2 do
						local item = self:getUserDataTb_()

						item.go = gohelper.findChild(s02tab, "tab_" .. i)
						item.select = gohelper.findChild(item.go, "select")
						item.unselect = gohelper.findChild(item.go, "unselect")
						self._s02tbs[i] = item
					end

					self.s02btn = gohelper.findChildButtonWithAudio(self._gos02switch, "#btn_switch")

					self.s02btn:AddClickListener(self._btnS02CardOnClick, self)
				end
			end
		end
	end
end

function CharacterDeviceView:_btnS02CardOnClick()
	self._selectCardGroupIndex = self._selectCardGroupIndex == 1 and 2 or 1

	if self._animEventWrap then
		self:playAnim("characterview_switch")
	else
		self:_refreshTwinssychubeSelectCardGroup()
	end

	if self._deviceMo then
		self._deviceMo:setSelectCardGroupIndex(self._selectCardGroupIndex)
	end
end

function CharacterDeviceView:_refreshCardUI()
	if not self._deviceMo or not self._cardItems then
		return
	end

	for i, item in ipairs(self._cardItems) do
		local index = item.index
		local skillInfo = self._deviceMo:getSkillInfo(index, self._selectCardGroupIndex)

		item.cardItem:refreshUI(skillInfo)
	end
end

function CharacterDeviceView:onUpdateMO(heroId, heroMo, param, isBalance, showAttributeOption, balanceHelper)
	self._heroId = heroId
	self._heroMo = heroMo
	self._isBalance = isBalance
	self._showAttributeOption = showAttributeOption
	self._balanceHelper = balanceHelper
	self._param = param

	local heroCo = HeroConfig.instance:getHeroCO(self._heroId)

	self._heroName = heroCo.name
	self._deviceMo = SkillConfig.instance:getHeroDeviceMO(self._heroId, self._heroMo)

	if not self._deviceMo then
		return
	end

	self:_initS02()
	self:_refreshUI()

	if self._deviceMo then
		self._deviceMo:setSelectCardGroupIndex(1)
	end
end

function CharacterDeviceView:_getPowerSkillItem(index)
	local item = self._normalPowerSkillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gonormalItem)
		item.imgIcon = gohelper.findChildImage(item.go, "imgIcon")
		item.txtnum = gohelper.findChildText(item.go, "#txt_num")
		item.btn = gohelper.findChildButtonWithAudio(item.go, "bg", AudioEnum.UI.Play_ui_role_description)
		self._normalPowerSkillItems[index] = item
	end

	return item
end

function CharacterDeviceView:_getSpecialPowerSkillItem(index)
	local item = self._specialPowerSkillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gospecialItem)
		item.simgIcon = gohelper.findChildSingleImage(item.go, "imgIcon")
		item.txtnum = gohelper.findChildText(item.go, "#txt_num")
		item.btn = gohelper.findChildButtonWithAudio(item.go, "bg", AudioEnum.UI.Play_ui_role_description)
		self._specialPowerSkillItems[index] = item
	end

	return item
end

function CharacterDeviceView:_refreshUI()
	self:_refreshCardUI()

	self._powerSkills = self._deviceMo:getPowerSkills()
	self._specialPowerSkill = self._deviceMo:getSpecialPowerSkills()
	self._normalPowerSkillItems = self._normalPowerSkillItems or self:getUserDataTb_()
	self._specialPowerSkillItems = self._specialPowerSkillItems or self:getUserDataTb_()

	if self._powerSkills then
		for i, info in ipairs(self._powerSkills) do
			local item = self:_getPowerSkillItem(i)
			local energyType = info.energyType
			local count = info.energyCount

			if lua_device_power.configDict[energyType] then
				local powerCo = lua_device_power.configDict[energyType][count]

				if powerCo then
					UISpriteSetMgr.instance:setUiCharacterSprite(item.imgIcon, powerCo.powerIcon)
				end

				local lang = luaLang("character_device_skillpowernum")

				item.txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, luaLang("multiple"), info.count)

				item.btn:AddClickListener(self._onDeviceNormalSkillCardClick, self, i)
			end
		end
	end

	if self._powerSkills then
		local count1 = #self._powerSkills

		if self._normalPowerSkillItems then
			for i = 1, #self._normalPowerSkillItems do
				local item = self._normalPowerSkillItems[i]

				gohelper.setActive(item.go, i <= count1)
			end
		end

		if self._specialPowerSkill then
			for i, info in ipairs(self._specialPowerSkill) do
				local item = self:_getSpecialPowerSkillItem(i)
				local skillId = info.skillId
				local skillCO = lua_skill.configDict[skillId]

				if skillCO then
					item.simgIcon:LoadImage(ResUrl.getSkillIcon(skillCO.icon))
				end

				local var_12_2 = luaLang("character_device_skillpowernum")

				item.txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, luaLang("multiple"), info.count or 0)

				gohelper.setActive(item.txtnum.gameObject, info.count and info.count > 0)
				item.btn:AddClickListener(self._onDeviceSecialSkillCardClick, self, i)
			end
		end

		if self._specialPowerSkill then
			local count2 = #self._specialPowerSkill

			if self._specialPowerSkillItems then
				for i = 1, #self._specialPowerSkillItems do
					local item = self._specialPowerSkillItems[i]

					gohelper.setActive(item.go, i <= count2)
				end
			end

			self:_refreshTwinssychube()
		end
	end
end

function CharacterDeviceView:_refreshTwinssychube()
	if self._heroId then
		local isTwinssychube = self._heroId == CharacterEnum.TwinssychubeHeroId

		gohelper.setActive(self._gos02switch, isTwinssychube)
		self:_refreshTwinssychubeSelectCardGroup()
	end
end

function CharacterDeviceView:_refreshTwinssychubeSelectCardGroup()
	if not self._s02tbs then
		return
	end

	for i, item in ipairs(self._s02tbs) do
		gohelper.setActive(item.select, self._selectCardGroupIndex == i)
		gohelper.setActive(item.unselect, self._selectCardGroupIndex ~= i)
	end

	self:_refreshCardUI()
end

function CharacterDeviceView:_onDeviceNormalSkillCardClick(index)
	if self._powerSkills then
		local skillInfo = self._powerSkills[index]

		if skillInfo then
			local skillIdList = {
				skillInfo.skillId
			}

			self:_onDeviceSkillCardClick(skillIdList)
		end
	end
end

function CharacterDeviceView:_onDeviceSecialSkillCardClick(index)
	local skillInfo = self._specialPowerSkill[index]

	if skillInfo then
		local skillIdList = {
			skillInfo.skillId
		}

		self:_onDeviceSkillCardClick(skillIdList)
	end
end

function CharacterDeviceView:_onDeviceSkillCardClick(skillIdList, skillIndex)
	if self._heroId then
		local info = {}

		if self._deviceMo then
			info.super = skillIndex == 3
			info.skillIndex = skillIndex
			info.skillIdList = skillIdList
			info.isBalance = self._isBalance
			info.monsterName = self._heroName
			info.heroId = self._heroId
			info.heroMo = self._heroMo

			if self._param then
				info.anchorX = self._param.skillTipX
				info.anchorY = self._param.skillTipY
				info.adjustBuffTip = self._param.adjustBuffTip
				info.showAssassinBg = self._param.showAssassinBg
			end

			info.selectCardGroupIndex = self._selectCardGroupIndex
			info.isDeviceSkill = true

			ViewMgr.instance:openView(ViewName.SkillTipView, info)
		end
	end
end

function CharacterDeviceView:_onSkillCardClick(index)
	if self._heroId and self._deviceMo then
		local skillid = self._deviceMo:getSkillId(index, self._selectCardGroupIndex)

		self:_onDeviceSkillCardClick({
			skillid
		}, index)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)
end

function CharacterDeviceView:playAnim(animName)
	if not self._animator then
		return
	end

	self._animator:Play(animName, 0, 0)
end

function CharacterDeviceView:onDestroy()
	if self._normalPowerSkillItems then
		for i = 1, #self._normalPowerSkillItems do
			local item = self._normalPowerSkillItems[i]

			item.btn:RemoveClickListener()
		end
	end

	if self._specialPowerSkillItems then
		for i = 1, #self._specialPowerSkillItems do
			local item = self._specialPowerSkillItems[i]

			item.btn:RemoveClickListener()
			item.simgIcon:UnLoadImage()
		end
	end

	for i, item in ipairs(self._cardItems) do
		item.cardItem:onDestroy()
	end
end

return CharacterDeviceView
