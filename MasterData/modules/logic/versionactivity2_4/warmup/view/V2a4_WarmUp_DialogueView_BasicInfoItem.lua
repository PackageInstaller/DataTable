-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_DialogueView_BasicInfoItem.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_BasicInfoItem", package.seeall)

local V2a4_WarmUp_DialogueView_BasicInfoItem = class("V2a4_WarmUp_DialogueView_BasicInfoItem", RougeSimpleItemBase)

function V2a4_WarmUp_DialogueView_BasicInfoItem:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "bg/#txt_title")
	self._txtdec = gohelper.findChildText(self.viewGO, "#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp_DialogueView_BasicInfoItem:addEvents()
	return
end

function V2a4_WarmUp_DialogueView_BasicInfoItem:removeEvents()
	return
end

function V2a4_WarmUp_DialogueView_BasicInfoItem:ctor(...)
	self:__onInit()
	V2a4_WarmUp_DialogueView_BasicInfoItem.super.ctor(self, ...)
end

function V2a4_WarmUp_DialogueView_BasicInfoItem:onDestroyView()
	V2a4_WarmUp_DialogueView_BasicInfoItem.super.onDestroyView(self)
	self:__onDispose()
end

function V2a4_WarmUp_DialogueView_BasicInfoItem:setData(mo)
	local textInfoId = mo
	local CO = V2a4_WarmUpConfig.instance:textInfoCO(textInfoId)

	self._txttitle.text = CO.name
	self._txtdec.text = CO.value
end

return V2a4_WarmUp_DialogueView_BasicInfoItem
