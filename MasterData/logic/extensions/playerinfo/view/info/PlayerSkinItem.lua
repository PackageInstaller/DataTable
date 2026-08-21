-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerSkinItem.lua

module("logic.extensions.playerinfo.view.info.PlayerSkinItem", package.seeall)

local M = class("PlayerSkinItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._imgRoleIcon = registry:findUIElement("player_skin_item_2078113811", UIComponentType.Image)
	self._imgMaskGo = registry:findUIElement("player_skin_item_-1518440205")
	self._imgSpecialGo = registry:findUIElement("player_skin_item_1202249044")
	self._imgSelectGo = registry:findUIElement("player_skin_item_-787841920")
	self._imgEffect = registry:findUIElement("player_skin_item_-983251421")
	self._imgRoleMask = registry:findUIElement("player_skin_item_-4170336")
	self._imgRoleCamp = registry:findUIElement("player_skin_item_-344959931", UIComponentType.Image)
	self._btnSelect = registry:findUIElement("player_skin_item_1698518732", UIComponentType.ButtonAdapter)

	self._btnSelect:AddClickListener(self._clickSelect, self)
end

function M:_clickSelect()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._data:getId())
	end
end

function M:setClick(clickGoto, clickGotoHandler)
	self._clickCallBackFunc = clickGoto
	self._clickCallBackHandler = clickGotoHandler
end

function M:setCellData(data, index, curId, selectId)
	self._curIndex = index
	self._data = data

	goutil.setActive(self._imgSelectGo, selectId == self._data:getId())
	goutil.setActive(self._imgSpecialGo.gameObject, self._data:getSkillEffect() == 1)
	goutil.setActive(self._imgEffect.gameObject, self._data:getSkillEffect() == 1)
	goutil.setActive(self._imgMaskGo.gameObject, selectId ~= self._data:getId())
	goutil.setActive(self._imgBg, selectId == self._data:getId())
	goutil.setActive(self._imgRoleMask, selectId == self._data:getId())

	local modelCO = ModelConfig.instance:getModelConfig(self._data:getModelId())

	if modelCO then
		IconLoader.setSprite(self._imgRoleIcon, IconType.CharaterBust, modelCO.wholeIconName, nil, nil, modelCO.code)
	end

	local heroCO = CharacterConfig.instance:getCfgInfoByID(self._data:getHeroId())

	if heroCO then
		IconLoader.setSprite(self._imgRoleCamp, IconType.CampBg, CommEnum.CampType2BgIcon[heroCO.camp])
	end
end

function M:OnDisable()
	return
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M
