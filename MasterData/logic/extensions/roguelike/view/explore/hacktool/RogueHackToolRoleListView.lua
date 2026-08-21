-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolRoleListView.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolRoleListView", package.seeall)

local PropertyItem = class("PropertyItem")

function PropertyItem:ctor(go)
	self._go = go
	self._imgIcon = goutil.findChildImageComponent(go, "icon")
	self._txtContent = goutil.findChildTextComponent(go, "txt")
end

function PropertyItem:updateData(data)
	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, data.icon)

	self._txtContent.text = data.text

	self:setActive(true)
end

function PropertyItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

local M = class("RogueRoleListView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._cardRoleListItems = {}
	self._selectRoleIds = {}
	self._selectRoleLevels = {}
	self._selectRoleNoSkills = {}
	self._propertyItems = {}
end

function M:buildUI()
	self._txtRoleName = self:getText("rungroup_role_list_view_-1166126229")
	self._txtRoleLevel = self:getText("rungroup_role_list_view_1094774047")
	self._txtRoleHp = self:getText("rungroup_role_list_view_844611792")
	self._txtRoleSan = self:getText("rungroup_role_list_view_800484607")
	self._btnSelect = self:getBtn("rungroup_role_list_view_1723089394")
	self._btnConfirm = self:getBtn("rungroup_role_list_view_1483118863")
	self._traHeroScroll = self:getGo("rungroup_role_list_view_1960407816").transform
	self._goRoleCardItem = goutil.findChild(self._traHeroScroll.gameObject, "charater_info_item")
	self._goRoleContent = self:getGo("rungroup_role_list_view_-1387224501")
	self._goPropertyParent = self:getGo("rungroup_role_list_view_1875586199")
	self._goPropertyItem = goutil.findChild(self._goPropertyParent, "property_item")
	self._btnFilter = self:getBtn("rungroup_role_list_view_324415464")
	self._btnCamp = self:getBtn("rungroup_role_list_view_1415083072")
	self._imgCamp = self:getImage("rungroup_role_list_view_-1882798724")
	self._imgRoleIcon = self:getImage("rungroup_role_list_view_copy_-1554982851")
	self._imgRoleShadowIcon = self:getImage("rungroup_role_list_view_copy_-1725386962")
	self._goSkillContent = self:getGo("rungroup_role_list_view_copy_-238890978")
	self._txtSkillContent = self:getText("rungroup_role_list_view_copy_-391936689")
	self._qua6Ploygon = UIPolygon.Get(self:getGo("rungroup_role_list_view_1385381324"))

	self._qua6Ploygon:Init(6)

	self._txtQua6List = {
		self:getText("rungroup_role_list_view_301895662"),
		self:getText("rungroup_role_list_view_1720220347"),
		self:getText("rungroup_role_list_view_1753822550"),
		self:getText("rungroup_role_list_view_189336665"),
		self:getText("rungroup_role_list_view_1432545592"),
		self:getText("rungroup_role_list_view_395699215")
	}
	self._goHackTool = self:getGo("rungroup_role_list_view_copy_-104655044")
	self._inputRoleLevel = Astral.InputFieldAdapter.Get(self:getGo("rungroup_role_list_view_copy_-1711162882"))
	self._toggleUseSkill = self:getUIComponent("rungroup_role_list_view_copy_1909987645", UIComponentType.SpaceXToggle)

	self._inputRoleLevel:SetText("1")
end

function M:destroyUI()
	for k, v in pairs(self._cardRoleListItems) do
		v:unbindEvents()
	end
end

function M:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnConfirm:AddClickListener(self._onClickExplore, self)
	self._btnSelect:AddClickListener(self._onClickAutoSelect, self)
	self._btnCamp:AddClickListener(self._onClickCamp, self)
	self._inputRoleLevel:AddOnEndEdit(self._onEndEditLevel, self)
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnCamp:RemoveClickListener()
	self._inputRoleLevel:RemoveOnEndEdit()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)

	self._closeCallback = self:getFirstParam()

	self:setEvent(true)
	self:_updateHeroData()
	self:updateSelectCard()
	self:onCardClickCallback(1)
	goutil.setActive(self._btnCamp.gameObject, false)
	goutil.setActive(self._goHackTool, true)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_TEAM_UP_SUCCESS, self._onTeamUpSuccess, self)
		GlobalDispatcher:addEventListener(EventType.FILTER_ROGUELIKE_DATA, self._updateHeroData, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_TEAM_UP_SUCCESS, self._onTeamUpSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.FILTER_ROGUELIKE_DATA, self._updateHeroData, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
	end
end

function M:setHp(hp)
	self._txtRoleHp.text = hp
end

function M:setSan(san)
	self._txtRoleSan.text = san
end

function M:setOriginHp(roleCo)
	local hp = RoguelikeConfig.instance:getConstByName("InitialHp").numValue

	self:setHp(string.format("%d/%d", hp, hp))
end

function M:setOriginSan(roleCo)
	local san = RoguelikeConfig.instance:getConstByName("InitialTeamSan").numValue + RoguelikeConst.SAN_OFFSET

	self:setSan(san)
end

function M:getOriginSan(roleCo, level)
	local san = RoguelikeConfig.instance:getConstByName("InitialTeamSan").numValue

	return san
end

function M:showCurRoleInfo(data)
	local roleId = data.roleId
	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)

	self._txtRoleName.text = RoguelikeConfig.instance:getRoleName(roleId)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(roleId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)
	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

	IconLoader.setSprite(self._imgRoleIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	IconLoader.setSprite(self._imgRoleShadowIcon, IconType.RoleHeadIcon, modelCO.headIconName)

	local level = 1

	if self._selectRoleLevels[#self._selectRoleLevels] then
		level = self._selectRoleLevels[#self._selectRoleLevels]
	end

	self._level = level
	self._txtRoleLevel.text = "Lv." .. level

	if data.hp then
		self:setHp(data.hp)
	else
		self:setOriginHp(roleCo)
	end

	if data.san then
		self:setSan(data.san)
	else
		self:setOriginSan(roleCo)
	end

	local qua6List = roleCo.qua6

	if RogueMgr.instance:isInRogue() then
		local roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId)

		if roleMo ~= nil then
			qua6List = {}

			for i = 1, 6 do
				table.insert(qua6List, roleMo.roleProp:getPropertyLevel(i))
			end
		end
	end

	function getRealIndex(idx)
		if idx == 1 then
			return 2
		elseif idx == 2 then
			return 1
		elseif idx == 6 then
			return 3
		elseif idx == 5 then
			return 4
		elseif idx == 3 then
			return 0
		elseif idx == 4 then
			return 5
		end
	end

	for index = 1, #qua6List do
		local value = qua6List[index]

		self._qua6Ploygon:InitPolygon(getRealIndex(index), CharacterCOUtil.qua2Ratio(value))

		local map = RoguelikeConst.PROP_LANG_MAP[index]

		self._txtQua6List[index].text = map.name .. "" .. CharacterCOUtil.qua2Score(value)

		TextUtils.SetColor(self._txtQua6List[index], CharacterCOUtil.qua2Color(value))
	end

	local skillIds = {}
	local hadSkill = skillIds and #skillIds > 0

	goutil.setActive(self._goSkillContent, hadSkill)

	local skillDesc = ""

	for k, v in pairs(skillIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		if effectCo then
			skillDesc = skillDesc .. effectCo.description .. "\n"
		end
	end

	self._txtSkillContent.text = skillDesc

	goutil.setActive(self._goRoleContent, true)
end

function M:updateRecommend()
	local co = self:getOpenParam()[2]
	local props = {}

	for k, v in pairs(self._propertyItems) do
		v:setActive(false)
	end

	for idx, prop in pairs(props) do
		local map = RoguelikeConst.PROP_LANG_MAP[prop]
		local item = self._propertyItems[idx]

		if not item then
			local go = goutil.cloneAndSetParent(self._goPropertyItem, self._goPropertyParent.transform)

			item = PropertyItem.New(go)
			self._propertyItems[idx] = item
		end

		local data = {}

		data.icon = string.format("dice_%d", RoguelikeConst.GetPatterIcon(prop))
		data.text = map.name

		item:updateData(data)
	end
end

function M:updateEquipment()
	local hadEquip = #RoguelikeModel.instance:getEquipMOS() > 0

	goutil.setActive(self._btnEquip.gameObject, hadEquip)
end

function M:_updateHeroData(event, resultList)
	local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getHeroDataList()

	self._heroMoList = CharacterConfig.instance:getCharacterDataList()

	local allRoleCo = {}

	for k, v in ipairs(self._heroMoList) do
		local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(v.id)

		if roleCo ~= nil then
			table.insert(allRoleCo, roleCo)
		end
	end

	self._allRoleCo = allRoleCo

	for k, v in pairs(self._cardRoleListItems) do
		v:setActive(false)
	end

	for i = 1, #allRoleCo do
		local item = self._cardRoleListItems[i]

		if not item then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goRoleCardItem, self._traHeroScroll, nil)

			item = RogueRoleSelectCardItem.New(go)

			item:bindEvents()

			self._cardRoleListItems[i] = item
		end

		local data = {}

		data.roleId = allRoleCo[i].id

		local level = 1
		local heroData = HeroDepotModel.instance:getHeroInfoByID(data.roleId)

		if heroData then
			level = heroData:getLevel()
		end

		data.index = i
		data.useHeadIcon = true
		data.level = level
		data.san = self:getOriginSan(allRoleCo[i], level) + RoguelikeConst.SAN_OFFSET
		data.six = allRoleCo[i].qua6

		local index = i

		function data.callback()
			self:onCardClickCallback(index)
		end

		item:updateData(data)
	end
end

function M:hideHeroDetail()
	goutil.setActive(self._goRoleContent, false)
end

function M:onCardClickCallback(index)
	local roleCo = self._allRoleCo[index]
	local roleId = roleCo.id
	local isSelect = self:checkIsSelect(roleId)

	if isSelect then
		for i = 1, #self._selectRoleIds do
			if roleId == self._selectRoleIds[i] then
				table.remove(self._selectRoleIds, i)
				table.remove(self._selectRoleLevels, i)
				table.remove(self._selectRoleNoSkills, i)
				self:updateSelectCard()
				self:_updateHeroData()
				self:hideHeroDetail()
			end
		end
	elseif #self._selectRoleIds < 4 then
		table.insert(self._selectRoleIds, roleId)
		self:checkRoleMaxLevel(roleId)
		table.insert(self._selectRoleLevels, tonumber(self._inputRoleLevel:GetText()))
		table.insert(self._selectRoleNoSkills, self._toggleUseSkill.IsOn and 1 or 0)
		self:updateSelectCard()
		self:_updateHeroData()

		local data = {}

		data.roleId = roleId

		self:showCurRoleInfo(data)
	else
		FloatWordMgr.instance:show("已经到达出战上限")
	end
end

function M:updateSelectCard()
	for k, v in pairs(self._cardRoleListItems) do
		local isSelect, selectIndex = self:checkIsSelect(v:getRoleId())

		v:setSelect(isSelect, selectIndex)
	end

	self:checkCampIconShow()
end

function M:checkCampIconShow()
	local allCamps = {}

	for k, v in ipairs(self._selectRoleIds or {}) do
		local characterCo = CharacterConfig.instance:getCharacterItemInfo(v)

		allCamps[characterCo.camp] = allCamps[characterCo.camp] or 0
		allCamps[characterCo.camp] = allCamps[characterCo.camp] + 1
	end

	for k, v in pairs(allCamps) do
		if v >= 3 then
			IconLoader.setSprite(self._imgCamp, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[k])
			goutil.setActive(self._imgCamp.gameObject, true)

			return
		end
	end

	goutil.setActive(self._imgCamp.gameObject, false)
end

function M:onSelectCardClickCallback(index)
	table.remove(self._selectRoleIds, index)
	table.remove(self._selectRoleLevels, index)
	table.remove(self._selectRoleNoSkills, index)
	self:updateSelectCard()
	self:_updateHeroData()
end

function M:checkIsSelect(roleId)
	for k, v in pairs(self._selectRoleIds) do
		if roleId == v then
			return true, k
		end
	end

	return false, 1
end

function M:_refreshHeroDepotData()
	if self._heroListBinderView then
		self._heroListBinderView:refreshView()
	end
end

function M:onExit()
	self._selectRoleIds = {}
	self._selectRoleLevels = {}
	self._selectRoleNoSkills = {}

	self:setEvent(false)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)
	self:hideHeroDetail()
end

function M:_onTeamUpSuccess()
	local callback = self:getFirstParam()

	if callback then
		callback()
	end

	self:initRogue()
	self:close()
end

function M:initRogue()
	if RogueMgr.instance:isInRogue() then
		return
	end

	local tb = {}

	tb.roleIds = {}

	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if allRoleState == nil then
		print("组队完成但是没角色")

		return
	end

	for k, v in pairs(allRoleState) do
		table.insert(tb.roleIds, v.code)
	end

	RogueMgr.instance:enter(tb)
	FloatWordMgr.instance:show("选择角色完成")
end

function M:_onClickClose()
	self:close()
end

function M:_onClickFilter()
	return
end

function M:_onClickExplore()
	if #self._selectRoleIds ~= 4 then
		FloatWordMgr.instance:show("没有选择足够出战角色")

		return
	end

	if self._closeCallback then
		self._closeCallback(self._selectRoleIds, self._selectRoleLevels, self._selectRoleNoSkills)
	end

	self:close()
end

function M:getNotSelectRole()
	for k, v in pairs(self._cardRoleListItems) do
		local isSelect, selectIndex = self:checkIsSelect(v:getRoleId())

		if not isSelect then
			return v, k
		end
	end

	return nil
end

function M:_onClickCamp()
	ViewMgr.instance:open(ViewName.RogueCampAffectTips, self._selectRoleIds)
end

function M:checkRoleMaxLevel(roleId)
	local level = tonumber(self._inputRoleLevel:GetText())
	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)
	local quality = roleCo.quality
	local maxPowerLevel = CharacterExpConfig.instance:getMaxPowerLevelByQuality(quality)
	local maxLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(maxPowerLevel, quality)

	if maxLevel < level then
		self._inputRoleLevel:SetText(tostring(maxLevel))
	end
end

function M:_onEndEditLevel()
	if #self._selectRoleLevels > 0 then
		local roleId = self._selectRoleIds[#self._selectRoleIds]

		self:checkRoleMaxLevel(roleId)

		self._selectRoleLevels[#self._selectRoleLevels] = tonumber(self._inputRoleLevel:GetText())
	end
end

function M:_onClickAutoSelect()
	for i = #self._selectRoleIds + 1, 4 do
		local item, index = self:getNotSelectRole()

		if item ~= nil then
			self:onCardClickCallback(index)
		else
			print("自动选择失败", i)
		end
	end
end

function M:_onClickEquip()
	local equips = RoguelikeModel.instance:getEquipMOS() or {}

	if #equips == 0 then
		FloatWordMgr.instance:show("当前没有装备")

		return
	end

	ViewMgr.instance:open(ViewName.RogueEquipMain, {})
end

function M:_onEquipRefresh()
	local equips = RoguelikeModel.instance:getCurEquipMOS() or {}
	local curEquip = equips[1]
	local hadEquip = curEquip ~= nil and curEquip:getId() ~= 0

	goutil.setActive(self._imgEquipIcon.gameObject, hadEquip)
	goutil.setActive(self._btnEquip.gameObject, not hadEquip)

	if hadEquip then
		IconLoader.setSprite(self._imgEquipIcon, IconType.ItemIcon, curEquip:getIcon())
	end
end

return M
