-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/role/RogueUnitCompRoleInfoBar.lua

module("logic.extensions.roguelike.unit.comp.role.RogueUnitCompRoleInfoBar", package.seeall)

local EntryTipItem = class("EntryTipItem")

function EntryTipItem:ctor(go)
	self._go = go
	self._imgIcon = goutil.findChildImageComponent(go, "icon")
	self._imgIconNum = goutil.findChildImageComponent(go, "imgNum")
	self._imgDi = goutil.findChildImageComponent(go, "imgDi")
end

function EntryTipItem:updateData(data)
	if data.icon and data.icon ~= "" then
		IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, data.icon)

		local numSpriteName = data.color == 1 and string.format("pt_num_zheng_%s", data.level) or string.format("pt_num_fu_%s", data.level)

		IconLoader.setSprite(self._imgIconNum, IconType.DynSpriteAtlas_Dice, numSpriteName)
	end

	if data.color then
		local color = data.color == 1 and "#000000" or "#c1ae84"

		TextUtils.SetColor(self._imgIcon, color)
		IconLoader.setSprite(self._imgDi, IconType.DynSpriteAtlas_Dice, data.color == 1 and "pt_bf_0034_02" or "pt_bf_0034_01")
	end

	self:setActive(true)
end

function EntryTipItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

local M = class("RogueUnitCompRoleInfoBar", RogueUnitCompBase)
local URL_INFOBAR = ResName.Rungroup_character_unit

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = SingleResLoader.New()
	self._goInst = nil
	self._followUIComp = nil
	self._viewElementsRegistry = nil
	self._isVisible = nil
	self._entryItems = {}
end

function M:onInit()
	self._followUIComp = self._unit.uiFollow

	self:setEvent(true)
	self._followUIComp:setPerspectiveArgs(10, 0.7, 1.5)
end

function M:onReset()
	self:clear()
end

function M:onDestroy()
	self:clear()
end

function M:setVisible(visible, exit)
	self._isVisible = visible

	if self._goInst then
		self:_setVisible()
	else
		if exit then
			return
		end

		if self._resLoader then
			self._resLoader:load(URL_INFOBAR, self._onResLoaded, self)
		end
	end
end

function M:_setVisible()
	goutil.setActive(self._goInst, self._isVisible)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	self:_buildUI(self._goInst)

	local parentGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.addChildToParent(self._goInst, parentGo)
	self._followUIComp:addFollowGameObject(UIFollowType.Top, self._goInst)
	self._followUIComp:setPivot(UIFollowType.Top, 0, 2.5)
	self._followUIComp:setPerspectiveEnable(true)
	self:_setVisible()
end

function M:_buildUI(mainGO)
	self._viewElementsRegistry = ViewElementsRegistry.New()

	self._viewElementsRegistry:setMainGO(mainGO)

	self._txtHp = self._viewElementsRegistry:findUIElement("rungroup_character_unit_-572532714", UIComponentType.Text)
	self._txtCard = self._viewElementsRegistry:findUIElement("rungroup_character_unit_-1669361359", UIComponentType.Text)
	self._goHpEffect = self._viewElementsRegistry:findUIElement("rungroup_character_unit_-1970305614")
	self._traDiceParent = self._viewElementsRegistry:findUIElement("rungroup_character_unit_1615473304").transform
	self._goDiceItem = self._traDiceParent:GetChild(0).gameObject
	self._txtHpEffect = self._viewElementsRegistry:findUIElement("rungroup_character_unit_-917986025", UIComponentType.Text)

	local goBtnClick = self._viewElementsRegistry:findUIElement("rungroup_character_unit_-1821818898")

	self._btnClick = UIComponentType.ButtonAdapter(goBtnClick)

	self._btnClick:AddClickListener(self.onItemClick, self)
	self:updateData()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRoleInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_CLIENT_ENTRIES_CHANGE, self._onClientEntriesChange, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_CHANGE_ROLE, self._onClientEntriesChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRoleInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_CLIENT_ENTRIES_CHANGE, self._onClientEntriesChange, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_CHANGE_ROLE, self._onClientEntriesChange, self)
	end
end

function M:onItemClick()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SELECT_ROLE_UNIT)
end

function M:_onClientEntriesChange()
	self:showTempEntries()
end

function M:showTempEntries()
	for k, v in pairs(self._entryItems or {}) do
		v:setActive(false)
	end

	local stateMgr = RogueMgr.instance:getRogueFlow().stateMgr
	local entries = {}
	local roleIndex = RogueMgr.instance:getModel():getCurRoleIndex()

	for k, v in pairs(stateMgr:getClientNextCardEntries() or {}) do
		if self._unit.roleProp:getRoleIndex() == roleIndex then
			table.insert(entries, v)
		end
	end

	for k, v in pairs(stateMgr:getContinueEntries() or {}) do
		table.insert(entries, v)
	end

	for k, v in pairs(entries) do
		local item = self._entryItems[k]

		if not item then
			local go = goutil.cloneAndSetParent(self._goDiceItem, self._traDiceParent)

			item = EntryTipItem.New(go)
			self._entryItems[k] = item
		end

		local data = {}
		local entryCo = RoguelikeConfig.instance:getCardEntryById(v)

		data.name = entryCo.name
		data.content = entryCo.desc

		if entryCo then
			data.icon = entryCo.icon
			data.level = entryCo.level
			data.color = entryCo.color
		end

		item:updateData(data)
	end
end

function M:_onRoleInfoUpdate(sender, roleId, roleIndex)
	local id = self._unit.roleProp:getRoleId()

	if id == roleId then
		self:updateData()
	end
end

function M:updateData()
	local roleProp = self._unit.roleProp
	local hp = roleProp:getHp()
	local totalHp = roleProp:getHpMax()

	if not hp or not totalHp then
		return
	end

	if not self._txtHp then
		return
	end

	if self._txtHp.text ~= "" and self._txtHp.text ~= tostring(hp) then
		self:showHpAnimation(hp)
	end

	self._txtHp.text = hp

	local fillAmount = hp / totalHp

	self._txtCard.text = roleProp:getCard()
	self._fillAmount = fillAmount

	self:showTempEntries()
end

function M:showHpAnimation(hp)
	local lastHp = tonumber(self._txtHp.text)
	local offset = hp - lastHp

	self._txtHpEffect.text = offset > 0 and "+" .. offset or offset

	goutil.setActive(self._goHpEffect, true)
	settimer(0.7, self._delayHideHpEffect, self, false)
end

function M:_delayHideHpEffect()
	goutil.setActive(self._goHpEffect, false)
end

function M:_onChangeVisible(visible)
	self:showByData(visible)
end

function M:clear()
	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._btnClick = nil
	end

	removetimer(self._delayHideHpEffect, self)
	self:setEvent(false)

	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)

		self._goInst = false
	end

	if self._resLoader then
		self._resLoader:clear()
	end

	self._isVisible = false
	self._entryItems = {}
end

return M
