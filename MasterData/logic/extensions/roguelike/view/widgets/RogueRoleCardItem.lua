-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleCardItem.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleCardItem", package.seeall)

local M = class("RogueRoleCardItem")

function M:ctor(go)
	self._go = go

	local temp = ""

	if goutil.findChild(go, "content") ~= nil then
		temp = "content/"
	end

	self._imgIcon = goutil.findChildComponent(go, temp .. "cardBg/charaterIcon", UIComponentType.Image)
	self._imgIcon = self._imgIcon or goutil.findChildComponent(go, "cardInfo/cardBg/charaterIcon", UIComponentType.Image)
	self._imgCampIcon = goutil.findChildComponent(go, "cardBg/campIcon", UIComponentType.Image)
	self._txtHp = goutil.findChildComponent(go, temp .. "cardInfo/hp/txtHp", UIComponentType.Text)
	self._txtHp = self._txtHp or goutil.findChildComponent(go, "cardInfo/txtHp", UIComponentType.Text)
	self._txtSan = goutil.findChildComponent(go, temp .. "cardInfo/san/txtSan", UIComponentType.Text)
	self._txtSan = self._txtSan or goutil.findChildComponent(go, "cardInfo/txtSan", UIComponentType.Text)
	self._txtIndex = goutil.findChildComponent(go, temp .. "cardInfo/Text1", UIComponentType.Text)
	self._txtIndex = self._txtIndex or goutil.findChildComponent(go, temp .. "num/Text1", UIComponentType.Text)
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, temp .. "click"))
	self._select1Go = goutil.findChild(go, temp .. "select_kuang")
	self._select2Go = goutil.findChild(go, temp .. "select_gou")
	self._goLock = goutil.findChild(go, temp .. "lock")
	self._goInfo = goutil.findChild(go, temp .. "cardInfo")
	self._qua6Ploygon = UIPolygon.Get(goutil.findChild(go, temp .. "sixDimensionInfo/imgDimension"))

	self._qua6Ploygon:Init(6)

	if goutil.findChild(go, "sixDimensionInfo/power") ~= nil then
		self._txtQua6List = {
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/power/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/agile/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/Knowledge/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/communicate/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/insight/txtLevel", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/lucky/txtLevel", UIComponentType.Text)
		}
	else
		self._txtQua6List = {
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtPower", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtAgile", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtKnowledge", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtCommunicate", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtInsight", UIComponentType.Text),
			goutil.findChildComponent(go, temp .. "sixDimensionInfo/txtLucky", UIComponentType.Text)
		}
	end

	local qua6SelectPloygonGo = goutil.findChild(go, temp .. "sixDimensionInfo/imgDimension_shadow")

	if qua6SelectPloygonGo then
		self._qua6SelectPloygon = UIPolygon.Get(qua6SelectPloygonGo)

		self._qua6SelectPloygon:Init(6)
	end

	self:bindEvents()
end

function M:bindEvents()
	if self._isBind then
		return
	end

	self._btnClick:AddClickListener(self.onClick, self)

	self._isBind = true
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()

	self._isBind = false
end

function M:setHp(hp)
	self._txtHp.text = hp
end

function M:setSan(san)
	self._txtSan.text = san
end

function M:setIndex(index)
	if self._txtIndex then
		self._txtIndex.text = index
	end
end

function M:setHeadIcon(roleId, useHeadIcon)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)
	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

	if useHeadIcon then
		IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	else
		IconLoader.setSprite(self._imgIcon, IconType.CharaterBust, modelCO.wholeIconName, nil, nil, modelCO.code)
	end
end

function M:updateData(data)
	local roleId = data.roleId

	self._roleId = roleId
	self._index = data.index

	self:setIndex(data.index)

	self._attrChangeList = data.attrChange
	self._isAllowEmptyClick = data.isAllowEmptyClick

	if self._imgCampIcon then
		goutil.setActive(self._imgCampIcon.gameObject, roleId ~= 0)

		if roleId ~= 0 then
			local characterCo = CharacterConfig.instance:getCharacterItemInfo(roleId)

			IconLoader.setSprite(self._imgCampIcon, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[characterCo.camp])
		end
	end

	goutil.setActive(self._imgIcon.gameObject, roleId ~= 0)
	goutil.setActive(self._goInfo, roleId ~= 0)
	goutil.setActive(self._qua6Ploygon.gameObject, roleId ~= 0)
	goutil.setActive(self._goLock, roleId == 0)
	goutil.setActive(self._select1Go, false)
	goutil.setActive(self._select2Go, false)

	self._clickCallback = data.callback

	if roleId == 0 then
		goutil.setActive(self._go, true)

		if self._qua6SelectPloygon then
			goutil.setActive(self._qua6SelectPloygon.gameObject, false)
		end

		for index = 1, 6 do
			self._qua6Ploygon:InitPolygon(index, 0)

			self._txtQua6List[index].text = "-"
		end

		return
	end

	self:setHeadIcon(roleId, data.useHeadIcon)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(roleId)
	local level = 0

	if heroData then
		level = heroData:getLevel()
	end

	self._level = level

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)

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

		self._txtQua6List[index].text = value

		TextUtils.SetColor(self._txtQua6List[index], CharacterCOUtil.qua2Color(value))
	end

	if self._attrChangeList then
		goutil.setActive(self._qua6SelectPloygon.gameObject, true)

		for index = 1, #qua6List do
			local value = qua6List[index]

			printWarn(index, value, self._attrChangeList[index])

			if self._attrChangeList[index] then
				value = value + self._attrChangeList[index]

				if value > 6 then
					value = 6
				elseif value < 1 then
					value = 1
				end

				if self._attrChangeList[index] > 0 then
					self._txtQua6List[index].text = string.format("<color=#18f7b0><size=22>+%d</size></color>", self._attrChangeList[index])
				else
					self._txtQua6List[index].text = string.format("<color=#FF1500><size=22>%d</size></color>", value)
				end
			end

			self._qua6SelectPloygon:InitPolygon(getRealIndex(index), CharacterCOUtil.qua2Ratio(value))
		end

		if self._attrChangeList[RoguelikeConst.ROLE_PROP.HP] then
			self:setHp(data.hp + self._attrChangeList[RoguelikeConst.ROLE_PROP.HP])
		end

		if self._attrChangeList[RoguelikeConst.ROLE_PROP.SAN] then
			self:setSan(data.san + self._attrChangeList[RoguelikeConst.ROLE_PROP.SAN])
		end
	elseif self._qua6SelectPloygon then
		goutil.setActive(self._qua6SelectPloygon.gameObject, false)
	end

	goutil.setActive(self._go, true)
	self:bindEvents()
end

function M:setOriginHp(roleCo)
	local hp = RoguelikeConfig.instance:getConstByName("InitialHp").numValue

	self:setHp(hp)
end

function M:setOriginSan(roleCo)
	local san = RoguelikeConfig.instance:getConstByName("InitialTeamSan").numValue + RoguelikeConst.SAN_OFFSET

	self:setSan(san)
end

function M:onClick()
	if RogueMgr.instance:isInRogue() then
		local roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(self._roleId)

		if roleMo ~= nil and roleMo.roleProp:getIsDeath() and not self._isAllowEmptyClick then
			return
		end
	end

	if self._clickCallback then
		self._clickCallback(self._index)
	end
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

return M
