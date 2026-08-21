-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleSelectCardItem.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleSelectCardItem", package.seeall)

local M = class("RogueRoleSelectCardItem")

function M:ctor(go)
	self._go = go
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._imgIcon = goutil.findChildComponent(go, "cardInfo/mask/charaterIcon", UIComponentType.Image)
	self._imgIcon = self._imgIcon or goutil.findChildComponent(go, "cardBg/charaterIcon", UIComponentType.Image)
	self._goSelect = goutil.findChild(go, "selectKuang")
	self._txtSelectIndex = goutil.findChildTextComponent(go, "selectKuang/Text")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._txtName = goutil.findChildTextComponent(go, "bottomInfo/txtName")
	self._txtLevel = goutil.findChildTextComponent(go, "bottomInfo/txtLevel")
	self._qualityBg = goutil.findChildImageComponent(go, "bottomInfo/quality")
	self._careerDiIcon = self._viewElementsRegistry:findUIElement("0&career_-1600786498", UIComponentType.Image)
	self._careerSignIcon = self._viewElementsRegistry:findUIElement("0&career_1390243743", UIComponentType.Image)
	self._campIcon = goutil.findChildImageComponent(go, "cardInfo/mask1/campIcon")
	self._imgAttr1 = goutil.findChildImageComponent(go, "excellentPropertyInfo/txt1/icon")
	self._imgAttr2 = goutil.findChildImageComponent(go, "excellentPropertyInfo/txt2/icon")
	self._txtAttr1 = goutil.findChildTextComponent(go, "excellentPropertyInfo/txt1")
	self._txtAttr2 = goutil.findChildTextComponent(go, "excellentPropertyInfo/txt2")
	self._goSans = {}
	self._traSanGroup = goutil.findChild(go, "excellentPropertyInfo/sanGroup").transform

	for i = 0, self._traSanGroup.childCount - 1 do
		table.insert(self._goSans, self._traSanGroup:GetChild(i).gameObject)
	end

	self:bindEvents()
end

function M:setSelect(isSelect, index)
	goutil.setActive(self._goSelect, isSelect)

	self._txtSelectIndex.text = index or ""
end

function M:bindEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:setHeadIcon(roleId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)
	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

	if modelCO then
		IconLoader.setSprite(self._imgIcon, IconType.RoleCard, modelCO.halfIconName, self._onLoadSprite, self)
	end
end

function M:_onLoadSprite()
	return
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

function M:updateData(data)
	local roleId = data.roleId

	self._roleId = roleId
	self._index = data.index
	self._clickCallback = data.callback

	self:setHeadIcon(roleId)

	self._txtName.text = RoguelikeConfig.instance:getRoleName(roleId)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(roleId)

	self._txtLevel.text = "Lv." .. (heroData and not RoguelikeConst.IsGuildMode() and heroData:getLevel() or data.level)

	for k, v in pairs(self._goSans) do
		goutil.setActive(v, k <= data.san)
	end

	local first, second = self:getTopAttr(data.six)

	IconLoader.setSprite(self._imgAttr1, IconType.DynSpriteAtlas_Dice, string.format("ptxr_tb_%s", first.idx))
	IconLoader.setSprite(self._imgAttr2, IconType.DynSpriteAtlas_Dice, string.format("ptxr_tb_%s", second.idx))

	self._txtAttr1.text = first.value

	TextUtils.SetColor(self._txtAttr1, CharacterCOUtil.qua2Color(first.value))

	self._txtAttr2.text = second.value

	TextUtils.SetColor(self._txtAttr2, CharacterCOUtil.qua2Color(second.value))
	goutil.setActive(self._go, true)

	local characterCO = CharacterConfig.instance:getCfgInfoByID(data.roleId)

	if characterCO then
		IconLoader.setSprite(self._qualityBg, IconType.DynSpriteAtlas_CharacterDepot, CommEnum.Quality2CardBg[characterCO.quality])
		IconLoader.setSprite(self._careerDiIcon, IconType.Skinlib, CommEnum.ColorType2Icon[characterCO.colorType])
		IconLoader.setSprite(self._careerSignIcon, IconType.Skinlib, CommEnum.Career2Icon[characterCO.career])
		IconLoader.setSprite(self._campIcon, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[characterCO.camp], self._onLoadCmapFinish, self)
	end
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:_onLoadCmapFinish()
	self._campIcon:SetNativeSize()
end

function M:getRoleId()
	return self._roleId
end

function M:onClick()
	if self._clickCallback then
		self._clickCallback(self._index)
	end
end

return M
