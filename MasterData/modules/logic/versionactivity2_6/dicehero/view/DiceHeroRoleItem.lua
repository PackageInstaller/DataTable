-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroRoleItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroRoleItem", package.seeall)

local DiceHeroRoleItem = class("DiceHeroRoleItem", LuaCompBase)

function DiceHeroRoleItem:ctor(param)
	self.chapter = param.chapter
end

function DiceHeroRoleItem:init(go)
	self.go = go
	self._emptyRelicItem = gohelper.findChild(go, "root/zaowu/#go_nulllayout/#go_item")
	self._relicItem = gohelper.findChild(go, "root/zaowu/#go_iconlayout/#simage_iconitem")
	self._powerItem = gohelper.findChild(go, "root/headbg/energylayout/#go_item")
	self._txtname = gohelper.findChildTextMesh(go, "root/#txt_name")
	self._hpSlider = gohelper.findChildImage(go, "root/#simage_hpbg/#simage_hp")
	self._shieldSlider = gohelper.findChildImage(go, "root/#simage_shieldbg/#simage_shield")
	self._hpNum = gohelper.findChildTextMesh(go, "root/#simage_hpbg/#txt_hpnum")
	self._shieldNum = gohelper.findChildTextMesh(go, "root/#simage_shieldbg/#txt_shieldnum")
	self._buffConatiner = gohelper.findChild(go, "root/#go_statelist")
	self._txtdicenum = gohelper.findChildTextMesh(go, "root/dice/#txt_num")
	self._headicon = gohelper.findChildSingleImage(go, "root/headbg/headicon")
	self._btnClickHead = gohelper.findChildButtonWithAudio(go, "root/#btn_clickhead")
	self._btnClickRelic = gohelper.findChildButtonWithAudio(go, "root/#btn_clickrelic")
	self._goskilltips = gohelper.findChild(go, "tips/#go_skilltip")
	self._gozaowutip = gohelper.findChild(go, "tips/#go_zaowutip")
	self._goskillitem = gohelper.findChild(go, "tips/#go_skilltip/viewport/content/item")
	self._gozaowuitem = gohelper.findChild(go, "tips/#go_zaowutip/viewport/content/item")

	gohelper.setActive(self._buffConatiner, false)
end

function DiceHeroRoleItem:addEventListeners()
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchScreen, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, self.updateInfo, self)
	self._btnClickHead:AddClickListener(self._showSkill, self)
	self._btnClickRelic:AddClickListener(self._showRelic, self)
end

function DiceHeroRoleItem:removeEventListeners()
	self._btnClickHead:RemoveClickListener()
	self._btnClickRelic:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, self.updateInfo, self)
end

function DiceHeroRoleItem:onStart()
	self:updateInfo()
end

function DiceHeroRoleItem:updateInfo()
	local gameInfo = DiceHeroModel.instance:getGameInfo(self.chapter)

	if not gameInfo or gameInfo.heroBaseInfo.id == 0 then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)

	local heroBaseInfo = gameInfo.heroBaseInfo
	local relicData = {}
	local emptyData = {}

	for i = 1, 5 do
		if heroBaseInfo.relicIds[i] then
			table.insert(relicData, heroBaseInfo.relicIds[i])
		else
			table.insert(emptyData, 1)
		end
	end

	gohelper.CreateObjList(self, self._createRelicItem, relicData, nil, self._relicItem)
	gohelper.CreateObjList(nil, nil, emptyData, nil, self._emptyRelicItem)

	local powerData = {}

	for i = 1, heroBaseInfo.maxPower do
		powerData[i] = i <= heroBaseInfo.power and 1 or 0
	end

	gohelper.CreateObjList(self, self._createPowerItem, powerData, nil, self._powerItem)

	local hp = heroBaseInfo.hp
	local maxHp = heroBaseInfo.maxHp
	local shield = heroBaseInfo.shield
	local maxShield = heroBaseInfo.maxShield

	if maxHp > 0 then
		self._hpSlider.fillAmount = hp / maxHp or 0
	end

	if maxShield > 0 then
		self._shieldSlider.fillAmount = shield / maxShield or 0
	end

	self._hpNum.text = hp
	self._shieldNum.text = shield
	self._txtname.text = heroBaseInfo.co.name

	local diceNum = #string.split(heroBaseInfo.co.dicelist, "#")

	self._txtdicenum.text = string.format("×%s", diceNum)

	self._headicon:LoadImage(ResUrl.getHeadIconSmall(heroBaseInfo.co.icon))
end

function DiceHeroRoleItem:_createRelicItem(obj, data, index)
	local image = gohelper.findChildSingleImage(obj, "")
	local co = lua_dice_relic.configDict[data]

	if co then
		image:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. co.icon .. ".png")
	end
end

function DiceHeroRoleItem:_createPowerItem(obj, data, index)
	local light = gohelper.findChild(obj, "light")

	gohelper.setActive(light, data == 1)
end

function DiceHeroRoleItem:_showSkill()
	if self._goskilltips.activeSelf then
		gohelper.setActive(self._goskilltips, false)

		return
	end

	gohelper.setActive(self._gozaowutip, false)

	local gameInfo = DiceHeroModel.instance:getGameInfo(self.chapter)
	local skillId = gameInfo.heroBaseInfo.co.powerSkill
	local relicIds = gameInfo.heroBaseInfo.relicIds
	local skillCo = lua_dice_card.configDict[skillId]
	local allSkills = {
		skillCo
	}

	for _, id in ipairs(relicIds) do
		local relicCo = lua_dice_relic.configDict[id]

		if relicCo.effect == "skill" then
			local newSkillCo = lua_dice_card.configDict[tonumber(relicCo.param)]

			if newSkillCo and newSkillCo.type == DiceHeroEnum.CardType.Hero then
				table.insert(allSkills, newSkillCo)
			end
		end
	end

	if not allSkills[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(self._goskilltips, true)
	gohelper.CreateObjList(self, self._createSkillItem, allSkills, nil, self._goskillitem)
end

function DiceHeroRoleItem:_createSkillItem(obj, data, index)
	local title = gohelper.findChildTextMesh(obj, "#txt_title/#txt_title")
	local desc = gohelper.findChildTextMesh(obj, "#txt_desc")

	title.text = data.name
	desc.text = data.desc
end

function DiceHeroRoleItem:_showRelic()
	if self._gozaowutip.activeSelf then
		gohelper.setActive(self._gozaowutip, false)

		return
	end

	gohelper.setActive(self._goskilltips, false)

	local gameInfo = DiceHeroModel.instance:getGameInfo(self.chapter)
	local relicIds = gameInfo.heroBaseInfo.relicIds
	local relicCos = {}

	for _, id in ipairs(relicIds) do
		table.insert(relicCos, lua_dice_relic.configDict[id])
	end

	if #relicCos <= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(self._gozaowutip, true)
	gohelper.CreateObjList(self, self._createZaowuItem, relicCos, nil, self._gozaowuitem)
end

function DiceHeroRoleItem:_createZaowuItem(obj, data, index)
	local title = gohelper.findChildTextMesh(obj, "name/#txt_name")
	local desc = gohelper.findChildTextMesh(obj, "#txt_desc")
	local image = gohelper.findChildSingleImage(obj, "name/#simage_icon")

	image:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. data.icon .. ".png")

	title.text = data.name
	desc.text = data.desc
end

function DiceHeroRoleItem:onTouchScreen()
	if self._goskilltips.activeSelf then
		if gohelper.isMouseOverGo(self._goskilltips) and gohelper.isMouseOverGo(self._goskillitem.transform.parent) or gohelper.isMouseOverGo(self._btnClickHead) then
			return
		end

		gohelper.setActive(self._goskilltips, false)
	elseif self._gozaowutip.activeSelf then
		if gohelper.isMouseOverGo(self._gozaowutip) and gohelper.isMouseOverGo(self._gozaowuitem.transform.parent) or gohelper.isMouseOverGo(self._btnClickRelic) then
			return
		end

		gohelper.setActive(self._gozaowutip, false)
	end
end

return DiceHeroRoleItem
