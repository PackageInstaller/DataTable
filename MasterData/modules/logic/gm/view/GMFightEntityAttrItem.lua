-- chunkname: @modules/logic/gm/view/GMFightEntityAttrItem.lua

module("modules.logic.gm.view.GMFightEntityAttrItem", package.seeall)

local GMFightEntityAttrItem = class("GMFightEntityAttrItem", ListScrollCell)

function GMFightEntityAttrItem:init(go)
	self._go = go
	self._txt_base = gohelper.findChildText(go, "base")
	self._txt_fix = gohelper.findChildText(go, "fix")
	self._txt_part_fix = gohelper.findChildText(go, "partfix")
	self._txt_test = gohelper.findChildText(go, "test")
	self._txt_part_test = gohelper.findChildText(go, "parttest")
	self._txt_final = gohelper.findChildText(go, "final")
	self._txt_base_value = gohelper.findChildText(go, "base/value")
	self._txt_fix_value = gohelper.findChildText(go, "fix/value")
	self._txt_part_fix_value = gohelper.findChildText(go, "partfix/value")
	self._txt_final_value = gohelper.findChildText(go, "final/value")
	self._input_test = gohelper.findChildTextMeshInputField(go, "test/input")
	self._input_part_test = gohelper.findChildTextMeshInputField(go, "parttest/input")
end

function GMFightEntityAttrItem:addEventListeners()
	self._input_test:AddOnEndEdit(self._onFixEndEdit, self)
	self._input_part_test:AddOnEndEdit(self._onPartFixEndEdit, self)
end

function GMFightEntityAttrItem:removeEventListeners()
	self._input_test:RemoveOnEndEdit()
	self._input_part_test:RemoveOnEndEdit()
end

function GMFightEntityAttrItem:onUpdateMO(mo)
	self._mo = mo

	local co = lua_character_attribute.configDict[mo.id]

	if co then
		if not co.name then
			local attrName = tostring(mo.id)

			self._txt_base.text = attrName .. "基础值"
			self._txt_fix.text = attrName .. "百分比修正值"
			self._txt_part_fix.text = attrName .. "固定值修正值"
			self._txt_test.text = "外挂百分比修正值"
			self._txt_part_test.text = "外挂固定值修正值"
			self._txt_final.text = attrName .. "最终值"
			self._txt_base_value.text = mo.base
			self._txt_fix_value.text = mo.add * 0.001
			self._txt_part_fix_value.text = mo.partAdd

			self._input_test:SetText(mo.test * 0.001)
			self._input_part_test:SetText(mo.partTest)

			self._txt_final_value.text = mo.final
		end
	end
end

function GMFightEntityAttrItem:_onFixEndEdit()
	local inputValue = self._input_test:GetText()
	local value = tonumber(inputValue) or 0

	value = math.floor(value * 1000)

	local entityMO = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightChangeAttr %s %d %d", tostring(entityMO.id), self._mo.id, value))
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

function GMFightEntityAttrItem:_onPartFixEndEdit()
	local inputValue = self._input_part_test:GetText()
	local value = tonumber(inputValue) or 0
	local entityMO = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightChangePartAttr %s %d %d", tostring(entityMO.id), self._mo.id, value))
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

return GMFightEntityAttrItem
