-- chunkname: @modules/logic/sodache/view/outside/SodacheRelicOverView.lua

module("modules.logic.sodache.view.outside.SodacheRelicOverView", package.seeall)

local SodacheRelicOverView = class("SodacheRelicOverView", BaseView)

function SodacheRelicOverView:onInitView()
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_Desc")
	self._goAttributes1 = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Attributes1")
	self._goPassiveAttributes = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Attributes1/#go_PassiveAttributes")
	self._goAttributeItem = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Attributes1/#go_PassiveAttributes/#go_AttributeItem")
	self._goLine1 = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Line1")
	self._goDescs1 = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Descs1")
	self._goDescGroupItem = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Descs1/#go_DescGroupItem")
	self._goAttributes2 = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Attributes2")
	self._goActiveAttributes = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Attributes2/#go_ActiveAttributes")
	self._goDescs2 = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Descs2")
	self._goDescItem = gohelper.findChild(self.viewGO, "#scroll_Desc/Viewport/Content/#go_Descs2/#go_DescItem")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self._goArrow = gohelper.findChild(self.viewGO, "#go_Arrow")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheRelicOverView:_editableInitView()
	return
end

function SodacheRelicOverView:onOpen()
	self.relicBox = SodacheModel.instance:getOutsideMo().relicBox

	local hasPassive = self:refreshPassive()
	local hasActive = self:refreshActive()

	gohelper.setActive(self._goEmpty, not hasPassive and not hasActive)
	gohelper.setActive(self._goAttributeItem, false)
	gohelper.setActive(self._goDescItem, false)
end

function SodacheRelicOverView:refreshPassive()
	self.descGroupItemMap = {}

	local attrMap = {}
	local passiveDescMap = {}
	local relicMos = self.relicBox.relics

	for _, mo in ipairs(relicMos) do
		if mo.level ~= 0 then
			local attrs = SodacheUtil.getRelicAttrs(mo.id, mo.level)

			for _, attr in ipairs(attrs) do
				SodacheUtil.getGlobalAttrMap(attr, attrMap)
			end

			if string.nilorempty(mo.relicCo.globalAttri) then
				local descType = tonumber(mo.relicCo.type)

				passiveDescMap[descType] = passiveDescMap[descType] or {}

				table.insert(passiveDescMap[descType], mo.relicCo.effectDesc)
			end
		end
	end

	for type, descs in pairs(passiveDescMap) do
		local item = self:getUserDataTb_()
		local goGroup = gohelper.cloneInPlace(self._goDescGroupItem)
		local btnFold = gohelper.findChildButtonWithAudio(goGroup, "title/btn_Fold")

		self.addClickCb(self, btnFold, self._btnFoldOnClick, self, type)

		item.goOff = gohelper.findChild(goGroup, "title/btn_Fold/off")
		item.goOn = gohelper.findChild(goGroup, "title/btn_Fold/on")
		item.isFold = false
		item.goRoot = gohelper.findChild(goGroup, "DescRoot")

		local txtTitle = gohelper.findChildText(goGroup, "title/txt_Title")

		txtTitle.text = luaLang("sodache_relicoverview_type" .. tostring(type))

		local root = gohelper.findChild(goGroup, "DescRoot")

		for _, desc in ipairs(descs) do
			local goDesc = gohelper.clone(self._goDescItem, root)
			local text = gohelper.findChildText(goDesc, "")

			text.text = SodacheUtil.changeDescColor(desc)
		end

		self.descGroupItemMap[type] = item
	end

	gohelper.setActive(self._goDescGroupItem, false)

	for attrId, value in pairs(attrMap) do
		local config = lua_sodache_attr.configDict[attrId]
		local go = gohelper.cloneInPlace(self._goAttributeItem)
		local name = gohelper.findChildText(go, "name")

		name.text = config.name

		local value1 = gohelper.findChildText(go, "value")

		if config.percent == 1 then
			local format = value > 0 and "+%d%%" or "%d%%"

			value1.text = string.format(format, value / 10)
		else
			local format = value > 0 and "+%d" or "%d"

			value1.text = string.format(format, value)
		end
	end

	gohelper.setActive(self._goDescs1, next(passiveDescMap))
	gohelper.setActive(self._goLine1, next(attrMap))

	local hasPassive = next(attrMap) or next(passiveDescMap)

	gohelper.setActive(self._goAttributes1, hasPassive)

	return hasPassive
end

function SodacheRelicOverView:refreshActive()
	local isShow = false

	if SodacheUtil.isInside() then
		local insideMo = SodacheModel.instance:getInsideMo()
		local relicIds = insideMo.prop.offerRelicIds

		isShow = #relicIds > 0

		if isShow then
			for _, relicId in ipairs(relicIds) do
				local mo = self.relicBox:getRelicMo(relicId)
				local go = gohelper.cloneInPlace(self._goDescItem)
				local desc = gohelper.findChildText(go, "")

				desc.text = SodacheUtil.changeDescColor(mo.relicCo.effect2Desc)
			end
		end
	end

	gohelper.setActive(self._goAttributes2, isShow)
	gohelper.setActive(self._goDescs2, isShow)

	return isShow
end

function SodacheRelicOverView:_btnFoldOnClick(type)
	local item = self.descGroupItemMap[type]

	if item then
		item.isFold = not item.isFold

		gohelper.setActive(item.goOff, item.isFold)
		gohelper.setActive(item.goOn, not item.isFold)
		gohelper.setActive(item.goRoot, not item.isFold)
	end
end

return SodacheRelicOverView
