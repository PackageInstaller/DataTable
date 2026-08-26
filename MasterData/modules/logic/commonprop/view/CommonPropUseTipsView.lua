-- chunkname: @modules/logic/commonprop/view/CommonPropUseTipsView.lua

module("modules.logic.commonprop.view.CommonPropUseTipsView", package.seeall)

local CommonPropUseTipsView = class("CommonPropUseTipsView", BaseView)

function CommonPropUseTipsView:ctor()
	return
end

function CommonPropUseTipsView:onInitView()
	self._txttips = gohelper.findChildText(self.viewGO, "root/tipbg/container/#txt_tips")
	self._btncommon = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_common")
	self._txtdec = gohelper.findChildText(self.viewGO, "root/#btn_common/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonPropUseTipsView:addEvents()
	self._btncommon:AddClickListener(self._btncommonOnClick, self)
end

function CommonPropUseTipsView:removeEvents()
	self._btncommon:RemoveClickListener()
end

function CommonPropUseTipsView:_btncommonOnClick()
	if self.materialMo == nil or self.curTipsConfig == nil then
		return
	end

	if self.curTipsConfig.jumpId ~= nil and self.curTipsConfig.jumpId ~= 0 then
		JumpController.instance:jump(self.curTipsConfig.jumpId, self.onJumpFinish, self)
	else
		MaterialTipController.instance:showMaterialInfo(self.materialMo.materilType, self.materialMo.materilId, true)
		self:closeThis()
	end
end

function CommonPropUseTipsView:onJumpFinish()
	self:closeThis()
end

function CommonPropUseTipsView:_editableInitView()
	return
end

function CommonPropUseTipsView:onUpdateParam()
	return
end

function CommonPropUseTipsView:onOpen()
	if not self.viewParam then
		gohelper.setActive(self.viewGO, false)

		return
	end

	self:checkParam()
	self:refreshUI()
end

function CommonPropUseTipsView:checkParam()
	local moDic = {}
	local configList = {}

	for _, materialMo in ipairs(self.viewParam) do
		local itemConfig = ItemConfig.instance:getItemConfig(materialMo.materilType, materialMo.materilId)
		local useTipsConfig = ItemConfig.instance:getItemUseTipConfigById(itemConfig.id)

		if useTipsConfig then
			moDic[useTipsConfig.id] = materialMo

			table.insert(configList, useTipsConfig)
		end
	end

	if configList == nil or next(configList) == nil then
		gohelper.setActive(self.viewGO, false)

		return
	end

	table.sort(configList, CommonPropUseTipsHelper.sortList)

	local firstUseTipConfig = configList[CommonPropUseTipsEnum.UseTipDefaultIndex]
	local firstMo = moDic[firstUseTipConfig.id]

	self.materialMo = {
		materilType = firstMo.materilType,
		materilId = firstMo.materilId
	}
	self.curTipsConfig = firstUseTipConfig
end

function CommonPropUseTipsView:refreshUI()
	if not self.materialMo then
		gohelper.setActive(self.viewGO, false)

		return
	end

	if not CommonPropUseTipsHelper.checkShow(self.curTipsConfig.id) then
		gohelper.setActive(self.viewGO, false)

		return
	end

	self._txttips.text = CommonPropUseTipsHelper.getUseTipDesc(self.materialMo.materilId, self.materialMo.materilType)
	self._txtdec.text = luaLang("common_use_tips_btn_title")
end

function CommonPropUseTipsView:onClose()
	return
end

function CommonPropUseTipsView:onDestroyView()
	return
end

return CommonPropUseTipsView
