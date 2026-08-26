-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaGameUnitDetailView.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameUnitDetailView", package.seeall)

local NuoDiKaGameUnitDetailView = class("NuoDiKaGameUnitDetailView", BaseView)

function NuoDiKaGameUnitDetailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_enemyicon")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_desc/#txt_name")
	self._goclose = gohelper.findChild(self.viewGO, "image_Close")
	self._closeClick = gohelper.getClickWithAudio(self._goclose)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NuoDiKaGameUnitDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._closeClick:AddClickListener(self._btncloseOnClick, self)
end

function NuoDiKaGameUnitDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._closeClick:RemoveClickListener()
end

function NuoDiKaGameUnitDetailView:_btncloseOnClick()
	self:closeThis()
end

function NuoDiKaGameUnitDetailView:_editableInitView()
	self:_addEvents()
end

function NuoDiKaGameUnitDetailView:_addEvents()
	return
end

function NuoDiKaGameUnitDetailView:_removeEvents()
	return
end

function NuoDiKaGameUnitDetailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unit_tip)

	if self.viewParam.unitType == NuoDiKaEnum.EventType.Enemy then
		self:_refreshEnemy()
	elseif self.viewParam.unitType == NuoDiKaEnum.EventType.Item then
		self:_refreshItem()
	end
end

function NuoDiKaGameUnitDetailView:_refreshEnemy()
	local enemyCo = NuoDiKaConfig.instance:getEnemyCo(self.viewParam.unitId)

	self._txtname.text = enemyCo.name
	self._txtdesc.text = string.gsub(enemyCo.desc, "#FF7373", "#931E0E")

	self._simageicon:LoadImage(ResUrl.getNuoDiKaMonsterIcon(enemyCo.picture))
end

function NuoDiKaGameUnitDetailView:_refreshItem()
	local itemCo = NuoDiKaConfig.instance:getItemCo(self.viewParam.unitId)

	self._txtname.text = itemCo.name
	self._txtdesc.text = string.gsub(itemCo.desc, "#FF7373", "#931E0E")

	self._simageicon:LoadImage(ResUrl.getNuoDiKaItemIcon(itemCo.picture))
end

function NuoDiKaGameUnitDetailView:onClose()
	self._simageicon:UnLoadImage()
end

function NuoDiKaGameUnitDetailView:onDestroyView()
	self:_removeEvents()
end

return NuoDiKaGameUnitDetailView
