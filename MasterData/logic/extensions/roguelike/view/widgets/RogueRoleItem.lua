-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleItem.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleItem", package.seeall)

local M = class("RogueRoleItem")

function M:ctor(go)
	self._go = go.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go.gameObject)
end

function M:Awake()
	self:onInit()
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("rungroup_role_item_1143481319"))
	self._imgQuality = registry:findUIElement("rungroup_role_item_-630434854", UIComponentType.Image)
	self._imgQuality2 = registry:findUIElement("rungroup_role_item_-766627121", UIComponentType.Image)
	self._goInUse = registry:findUIElement("rungroup_role_item_1554756569")
	self._imgIcon = registry:findUIElement("rungroup_role_item_-1962125289", UIComponentType.Image)
	self._goSelect = registry:findUIElement("rungroup_role_item_-1358340678")
	self._imgAttr1 = registry:findUIElement("rungroup_role_item_1968489521", UIComponentType.Image)
	self._imgAttr2 = registry:findUIElement("rungroup_role_item_-587859671", UIComponentType.Image)
	self._txtAttr1 = registry:findUIElement("rungroup_role_item_-917589381", UIComponentType.Text)
	self._txtAttr2 = registry:findUIElement("rungroup_role_item_-1269804522", UIComponentType.Text)

	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_onClick()
	if self._clickCallback then
		self._clickCallback()
	end
end

function M:getTopAttr(six)
	local temp = {}

	for k, v in pairs(six) do
		table.insert(temp, {
			idx = k,
			value = v
		})
	end

	table.sort(temp, function(a, b)
		local aValue = a.value
		local bValue = b.value

		if aValue ~= bValue then
			return a.value > b.value
		else
			return a.idx < b.idx
		end
	end)

	return temp[1], temp[2]
end

function M:setHeadIcon(roleId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)
	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

	if modelCO then
		IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, modelCO.headIconName, self._onLoadSprite, self)
	end
end

function M:updateData(data)
	local roleId = data.roleId

	self._roleId = roleId
	self._index = data.index
	self._clickCallback = data.callback

	self:setHeadIcon(roleId)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(roleId)
	local first, second = self:getTopAttr(data.six)

	IconLoader.setSprite(self._imgAttr1, IconType.DynSpriteAtlas_Dice, string.format("ptxr_tb_%s", first.idx))
	IconLoader.setSprite(self._imgAttr2, IconType.DynSpriteAtlas_Dice, string.format("ptxr_tb_%s", second.idx))

	self._txtAttr1.text = first.value

	TextUtils.SetColor(self._txtAttr1, CharacterCOUtil.qua2Color(first.value))

	self._txtAttr2.text = second.value

	TextUtils.SetColor(self._txtAttr2, CharacterCOUtil.qua2Color(second.value))
	goutil.setActive(self._go, true)
	goutil.setActive(self._goInUse, data.inSelect)

	local characterCO = CharacterConfig.instance:getCfgInfoByID(data.roleId)

	if characterCO then
		IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterDepot, CommEnum.Quality2DepotCardBg[characterCO.quality])
		IconLoader.setSprite(self._imgQuality2, IconType.DynSpriteAtlas_CharacterDepot, CommEnum.Quality2DepotCardBg2[characterCO.quality])
	end
end

function M:OnDestroy()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	self._btnClick = nil
end

return M
