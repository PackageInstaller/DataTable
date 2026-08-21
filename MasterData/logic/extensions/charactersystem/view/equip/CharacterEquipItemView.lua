-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CharacterEquipItemView.lua

module("logic.extensions.charactersystem.view.equip.CharacterEquipItemView", package.seeall)

local M = class("CharacterEquipItemView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._addTypeGo = goutil.findChild(self._mainGo, "addType")
	self._imgSelectGo = goutil.findChild(self._mainGo, "imgSelect")
	self._holeNumGo = goutil.findChild(self._mainGo, "holeNum")
	self._cellGo = goutil.findChild(self._mainGo, "cell")

	local backpackItemGo = goutil.findChild(self._mainGo, "cell/backpack_item")

	self._equipItemView = Astral.LuaComponentContainer.Add(backpackItemGo, CharacterEquipItemViewItemCell)

	self._equipItemView:getComponent("level"):setVisible(true)
	self._equipItemView:getComponent("num"):setVisible(false)
	self._equipItemView:getComponent("holeCount"):setVisible(false)
	self._equipItemView:setIsShowTips(false)
	self._equipItemView:setShowSelectedEffect(false)

	local clickGo = goutil.findChild(self._mainGo, "click")

	goutil.addComponentOnce(clickGo, goutil.Type_UIButton)

	self._btnClick = UIComponentType.ButtonAdapter(clickGo)

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:setShowData(equipMo)
	if equipMo then
		self._holeNumGo:SetActive(false)
		self._cellGo:SetActive(true)
		self._addTypeGo:SetActive(false)
		self._equipItemView:updateData(equipMo)

		local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.EquipD6, false)

		if isOpen then
			local holeCountComp = self._equipItemView:getComponent("holeCount")

			holeCountComp:setVisible(true)
			holeCountComp:setCount(equipMo)
		end
	else
		self._holeNumGo:SetActive(false)
		self._cellGo:SetActive(false)
		self._imgSelectGo:SetActive(false)
		self._addTypeGo:SetActive(true)
	end
end

function M:_onClick()
	if self._clickCallback then
		self._clickCallback()
	end
end

function M:setSelected(isSelect)
	goutil.setActive(self._imgSelectGo, isSelect)
end

function M:setClickCallback(callback)
	self._clickCallback = callback
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

return M
