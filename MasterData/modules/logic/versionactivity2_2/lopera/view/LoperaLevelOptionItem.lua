-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaLevelOptionItem.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelOptionItem", package.seeall)

local LoperaLevelOptionItem = class("LoperaLevelOptionItem", ListScrollCellExtend)
local loperaActId = VersionActivity2_2Enum.ActivityId.Lopera

function LoperaLevelOptionItem:onInitView()
	self._optionText = gohelper.findChildText(self.viewGO, "#txt_Choice")
	self._optionEffectText = gohelper.findChildText(self.viewGO, "#txt_Choice/#txt_effect")
	self._btn = gohelper.findChildButtonWithAudio(self.viewGO, "image_ChoiceBG")
	self._goProp = gohelper.findChild(self.viewGO, "#image_Prop")
	self._imgPropIcon = gohelper.findChildImage(self.viewGO, "#image_Prop")
	self._goPowerIcon = gohelper.findChild(self.viewGO, "image_Power")
	self._goOption = gohelper.findChild(self.viewGO, "#txt_Choice")
	self._goEffectOption = gohelper.findChild(self.viewGO, "go_optionWithEffect")
	self._txtEffectOption = gohelper.findChildText(self.viewGO, "go_optionWithEffect/#txt_option")
	self._txtEffect = gohelper.findChildText(self.viewGO, "go_optionWithEffect/#txt_effect")
	self._costText = gohelper.findChildText(self.viewGO, "#txt_PowerNum")
	self._goCostNum = gohelper.findChild(self.viewGO, "#txt_PowerNum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LoperaLevelOptionItem:addEvents()
	self._btn:AddClickListener(self._clickOption, self)
end

function LoperaLevelOptionItem:removeEvents()
	self._btn:RemoveClickListener()
end

function LoperaLevelOptionItem:_clickOption()
	if not string.nilorempty(self._mo.costItems) then
		local itemParamsArray = string.split(self._mo.costItems, "|")
		local itemId = string.splitToNumber(itemParamsArray[1], "#")[1]
		local itemCost = string.splitToNumber(itemParamsArray[1], "#")[2]
		local itemCount = Activity168Model.instance:getItemCount(itemId)
		local itemCfg = Activity168Config.instance:getGameItemCfg(loperaActId, itemId)
		local itemTypeCfg = Activity168Config.instance:getComposeTypeCfg(loperaActId, itemCfg.compostType)

		if itemCount < itemCost then
			local itemTypeName = itemTypeCfg.name
			local itemName = itemCfg.name
			local toastContent = formatLuaLang("store_currency_limit", itemTypeName .. "-" .. itemName)

			ToastController.instance:showToastWithString(toastContent)

			return
		end
	end

	LoperaController.instance:selectOption(self._mo.optionId)
end

function LoperaLevelOptionItem:_editableInitView()
	return
end

function LoperaLevelOptionItem:_editableAddEvents()
	self.addEventCb(self, LoperaController.instance, LoperaEvent.ComposeDone, self.refreshUI, self)
end

function LoperaLevelOptionItem:_editableRemoveEvents()
	self.removeEventCb(self, LoperaController.instance, LoperaEvent.ComposeDone, self.refreshUI, self)
end

function LoperaLevelOptionItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function LoperaLevelOptionItem:refreshUI()
	if not self._mo then
		return
	end

	gohelper.setActive(self._goProp, false)
	gohelper.setActive(self._goPowerIcon, false)
	gohelper.setActive(self._goCostNum, false)
	gohelper.setActive(self._goEffectOption, false)
	gohelper.setActive(self._goOption, false)
	gohelper.setActive(self._txtEffect.gameObject, true)
	gohelper.setActive(self._optionEffectText.gameObject, false)

	self._btn.enabled = true

	local effectCfg = Activity168Config.instance:getOptionEffectCfg(self._mo.effectId)

	if not string.nilorempty(self._mo.costItems) then
		gohelper.setActive(self._goProp, true)
		gohelper.setActive(self._goCostNum, true)

		local itemParamsArray = string.split(self._mo.costItems, "|")
		local itemId = string.splitToNumber(itemParamsArray[1], "#")[1]
		local itemCost = string.splitToNumber(itemParamsArray[1], "#")[2]
		local itemCfg = Activity168Config.instance:getGameItemCfg(VersionActivity2_2Enum.ActivityId.Lopera, itemId)
		local itemCount = Activity168Model.instance:getItemCount(itemId)

		self._optionText.text = self._mo.name

		local isChoosed = LoperaController.instance:checkOptionChoosed(self._mo.optionId)

		gohelper.setActive(self._optionEffectText.gameObject, true)

		if isChoosed and effectCfg then
			self._optionEffectText.text = effectCfg.desc or ""
		end

		local itemCountText = gohelper.findChildText(self._goProp, "#txt_PropNum")

		itemCountText.text = itemCount
		self._costText.text = "-" .. itemCost

		local isGray = itemCount < itemCost

		ZProj.UGUIHelper.SetGrayscale(self._btn.gameObject, isGray)

		self._btn.enabled = not isGray

		UISpriteSetMgr.instance:setLoperaItemSprite(self._imgPropIcon, itemCfg.icon, false)
		gohelper.setActive(self._goOption, true)
	elseif effectCfg then
		gohelper.setActive(self._goEffectOption, true)

		self._txtEffectOption.text = self._mo.name

		local isChoosed = LoperaController.instance:checkOptionChoosed(self._mo.optionId)

		gohelper.setActive(self._txtEffect.gameObject, isChoosed)

		if isChoosed then
			self._txtEffect.text = effectCfg.desc
		end

		ZProj.UGUIHelper.SetGrayscale(self._btn.gameObject, false)
	else
		gohelper.setActive(self._goEffectOption, true)

		self._txtEffectOption.text = self._mo.name

		local isChoosed = LoperaController.instance:checkOptionChoosed(self._mo.optionId)

		gohelper.setActive(self._txtEffect.gameObject, isChoosed)

		if isChoosed then
			self._txtEffect.text = luaLang("lopera_event_no_effect_buff")
		end

		ZProj.UGUIHelper.SetGrayscale(self._btn.gameObject, false)
	end
end

function LoperaLevelOptionItem:onDestroyView()
	return
end

return LoperaLevelOptionItem
