-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/intelligence/CharacterIntelligenceItem.lua

module("logic.extensions.charactersystem.view.intelligence.CharacterIntelligenceItem", package.seeall)

local M = class("CharacterIntelligenceItem", CellBaseComponent)
local posY1 = 124
local posY2 = 155

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:getContentObj()
	return self._go
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._viewAnim = self._go:GetComponent(typeof(Astral.GUITimelineAniLua))

	local registry = self._viewElementsRegistry

	self._imgBg = registry:findUIElement("cloth_item_-863714680")
	self._imgId = registry:findUIElement("cloth_item_1815551866")
	self._imgRoleIcon = registry:findUIElement("cloth_item_-1102281846", UIComponentType.Image)
	self._imgMaskGo = registry:findUIElement("cloth_item_1626305386")
	self._imgSpecialGo = registry:findUIElement("cloth_item_-2110136627")
	self._imgSelectGo = registry:findUIElement("cloth_item_345734937")
	self._panelCanvasGroup = self._go:GetComponent(ComponentType.CanvasGroup)
	self._imgRoleMask = registry:findUIElement("cloth_item_978411065")
	self._btnSelect = registry:findUIElement("cloth_item_-1599318699", UIComponentType.ButtonAdapter)

	self._btnSelect:AddClickListener(self._clickSelect, self)

	self._leftMask = registry:findUIElement("cloth_item_16106938")
	self._rightMask = registry:findUIElement("cloth_item_1573539478")
end

function M:_clickSelect()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._index)
	end
end

function M:isActive()
	return self._go.activeInHierarchy
end

function M:updateData(data, index, maxCount)
	self._index = index
	self._data = data
	self._maxCount = maxCount

	self:_refreshView()
end

function M:_refreshView()
	if self._transformCell and self._curSelectId == self._data:getId() then
		self._transformCell.transform:SetAsLastSibling()
	end

	self._isSelect = self._curSelectId == self._data:getId()

	goutil.setActive(self._btnSelect.gameObject, self._isSelect)
	goutil.setActive(self._imgSpecialGo.gameObject, self._data:getSkillEffect() == 1)
	goutil.setActive(self._imgMaskGo.gameObject, not self._isSelect)
	goutil.setActive(self._imgId, not self._isSelect)
	goutil.setActive(self._imgBg, self._isSelect)
	goutil.setActive(self._imgRoleMask, self._isSelect)

	if self._isSelect then
		if self._viewAnim then
			self._viewAnim:StopTimelineAni()
			self._viewAnim:PlayAniByName("select")
		end

		goutil.setActive(self._leftMask, self._index > 1)
		goutil.setActive(self._rightMask, self._index < self._maxCount)
	end

	local modelCO = ModelConfig.instance:getModelConfig(self._data:getModelId())

	if modelCO then
		IconLoader.setSprite(self._imgRoleIcon, IconType.CharaterBust, modelCO.wholeIconName, nil, nil, self._data:getModelId())
	end
end

function M:setUseAndSelectSkinId(curUseId, curSelectId, index)
	self._curUseId = curUseId
	self._curSelectId = curSelectId
end

function M:getIsSelect()
	return self._isSelect
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:setCellTransform(transformCell)
	self._transformCell = transformCell
end

function M:getPositionX()
	return Astral.TransformUtil.GetLocalPosX(self._transformCell)
end

function M:OnDestroy()
	self._btnSelect:RemoveClickListener()
end

function M:setScale(scale)
	self._imgSelectGo:SetActive(scale >= 1)
	Astral.TransformUtil.SetLocalScale(self._go.transform, scale, scale, 1)
end

function M:setPos(posY)
	Astral.TransformUtil.SetLocalPosY(self._go.transform, posY)
end

function M:setAlpha(alpha)
	self._panelCanvasGroup.alpha = alpha
end

function M:setSelectState(state)
	self._imgSelectGo:SetActive(state)
end

return M
