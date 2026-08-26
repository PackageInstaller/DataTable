-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemySubMaterialItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemySubMaterialItem", package.seeall)

local Rouge2_AlchemySubMaterialItem = class("Rouge2_AlchemySubMaterialItem", LuaCompBase)

function Rouge2_AlchemySubMaterialItem:init(go)
	self.go = go
	self._imageicon = gohelper.findChildImage(self.go, "has/#image_icon")
	self._simageicon = gohelper.findChildSingleImage(self.go, "has/#image_icon")
	self._btnremove = gohelper.findChildButtonWithAudio(self.go, "has/#btn_remove")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AlchemySubMaterialItem:addEventListeners()
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
end

function Rouge2_AlchemySubMaterialItem:removeEventListeners()
	self._btnremove:RemoveClickListener()
end

function Rouge2_AlchemySubMaterialItem:_btnremoveOnClick()
	if self.type ~= Rouge2_OutsideEnum.SubMaterialDisplayType.Wearable then
		return
	end

	if self.id == nil then
		return
	end

	local index = Rouge2_AlchemyModel.instance:getCurSubMaterialIndex(self.id)

	if index then
		Rouge2_AlchemyModel.instance:setCurSubMaterialDic(index)
	end
end

function Rouge2_AlchemySubMaterialItem:_editableInitView()
	self._goHas = gohelper.findChild(self.go, "has")
	self._goempty = gohelper.findChild(self.go, "empty")
	self.animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)
end

function Rouge2_AlchemySubMaterialItem:setInfo(type, id)
	self.type = type
	self.id = id

	self:refreshUI()
end

function Rouge2_AlchemySubMaterialItem:refreshUI()
	self.animator:Play("idle", 0, 0)

	local haveMaterial = self.id ~= nil

	if haveMaterial then
		::label_7_0::

		local isSelect = Rouge2_AlchemyModel.instance:isSelectSubMaterial(self.id)

		gohelper.setActive(self._btnremove, isSelect and self.type == Rouge2_OutsideEnum.SubMaterialDisplayType.Wearable)
		gohelper.setActive(self._goHas, haveMaterial)
		gohelper.setActive(self._goempty, not haveMaterial)

		if not haveMaterial then
			return
		end

		Rouge2_IconHelper.setMaterialIcon(self.id, self._simageicon)

		if self.type == Rouge2_OutsideEnum.SubMaterialDisplayType.Wearable then
			local color = self._imageicon.color

			if isSelect then
				color.a = Rouge2_OutsideEnum.AlchemyTempAlpha.Select or Rouge2_OutsideEnum.AlchemyTempAlpha.Temp
			end

			self._imageicon.color = color
		end
	end
end

function Rouge2_AlchemySubMaterialItem:onDestroy()
	return
end

return Rouge2_AlchemySubMaterialItem
