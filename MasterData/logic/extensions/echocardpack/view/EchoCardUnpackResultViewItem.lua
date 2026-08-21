-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackResultViewItem.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackResultViewItem", package.seeall)

local M = class("EchoCardUnpackResultViewItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._txtCareerFlag = registry:findUIElement("echocard_gather_item_-1008651193", UIComponentType.TextMeshProUGUI)
	self._txtCareer = registry:findUIElement("echocard_gather_item_2029532050", UIComponentType.Text)
	self._txtName = registry:findUIElement("echocard_gather_item_2037138153", UIComponentType.Text)
	self._imgQuality = registry:findUIElement("echocard_gather_item_-1387630707", UIComponentType.Image)
	self._imgIcon = registry:findUIElement("echocard_gather_item_-1209554963", UIComponentType.Image)
	self._btnClick = registry:findUIElement("echocard_gather_item_-1579991187", UIComponentType.ButtonAdapter)
	self.goEffects = {}
	self.goEffects[GameEnum.QualityEnum.S] = registry:findUIElement("echocard_gather_item_996119852")
	self.goEffects[GameEnum.QualityEnum.A] = registry:findUIElement("echocard_gather_item_186647087")
	self.goEffects[GameEnum.QualityEnum.B] = registry:findUIElement("echocard_gather_item_2038219606")
end

function M:setData(data)
	self._echoItemData = data.itemData

	local career = self._echoItemData:getCareer()
	local campIcon = CommEnum.Career2TmpResName[career] or ""

	self._txtCareerFlag.text = string.format("<size=23>%s</size>", campIcon)
	self._txtCareer.text = string.format("%s", CommEnum.Career2Name[career])
	self._txtName.text = self._echoItemData:getName()

	local quality = self._echoItemData:getQuality()
	local url = GameUrl.getEchoItemQualityUrl(quality)

	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterSystem_Com, url)

	local icon = self._echoItemData:getIcon()
	local url = quality ~= GameEnum.QualityEnum.C and string.format("%s_1", icon) or icon

	IconLoader.setSprite(self._imgIcon, IconType.EchoItemBigIcon, url)

	for key, obj in pairs(self.goEffects) do
		goutil.setActive(obj, key == quality)
	end
end

function M:OnEnable()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:OnDisable()
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	IconLoader.clearSprite(self._imgIcon)
	IconLoader.clearSprite(self._imgQuality)
end

function M:_onClick()
	local data = ToolTipsUtil.createItemTipsData(self._echoItemData, self._go)

	ToolTipsMgr.showTips(data.viewName, data)
end

return M
