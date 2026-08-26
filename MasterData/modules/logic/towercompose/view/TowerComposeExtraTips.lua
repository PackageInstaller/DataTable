-- chunkname: @modules/logic/towercompose/view/TowerComposeExtraTips.lua

module("modules.logic.towercompose.view.TowerComposeExtraTips", package.seeall)

local TowerComposeExtraTips = class("TowerComposeExtraTips", BaseView)

function TowerComposeExtraTips:onInitView()
	self._txttipDesc = gohelper.findChildText(self.viewGO, "#txt_tipDesc")
	self._btncloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeTip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeExtraTips:addEvents()
	self._btncloseTip:AddClickListener(self._btncloseTipOnClick, self)
end

function TowerComposeExtraTips:removeEvents()
	self._btncloseTip:RemoveClickListener()
end

function TowerComposeExtraTips:_btncloseTipOnClick()
	self:closeThis()
end

function TowerComposeExtraTips:_editableInitView()
	return
end

function TowerComposeExtraTips:onUpdateParam()
	return
end

function TowerComposeExtraTips:onOpen()
	self.posGO = self.viewParam.posGO

	local posX, posY = recthelper.getAnchor(self.posGO.transform)

	recthelper.setAnchor(self.viewGO.transform, posX, posY)

	self._txttipDesc.text = TowerComposeConfig.instance:getConstValue(TowerComposeEnum.ConstId.ModEquipRuleDesc, false, true)
end

function TowerComposeExtraTips:onClose()
	return
end

function TowerComposeExtraTips:onDestroyView()
	return
end

return TowerComposeExtraTips
