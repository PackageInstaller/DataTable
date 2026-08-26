-- chunkname: @modules/logic/rouge/view/RougerewardThemeTipView.lua

module("modules.logic.rouge.view.RougerewardThemeTipView", package.seeall)

local RougerewardThemeTipView = class("RougerewardThemeTipView", BaseView)

function RougerewardThemeTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageblockpackageicon = gohelper.findChildSingleImage(self.viewGO, "content/blockpackageiconmask/#simage_blockpackageicon")
	self._gosuitcollect = gohelper.findChild(self.viewGO, "content/blockpackageiconmask/#go_suitcollect")
	self._simagebuildingicon = gohelper.findChildSingleImage(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#simage_buildingicon")
	self._btnsuitcollect = gohelper.findChildButtonWithAudio(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#btn_suitcollect")
	self._gocollecticon = gohelper.findChild(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#go_collecticon")
	self._txtbuildingname = gohelper.findChildText(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_buildingname")
	self._txtcollectdesc = gohelper.findChildText(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_collectdesc")
	self._gonormaltitle = gohelper.findChild(self.viewGO, "content/title/#go_normaltitle")
	self._txtname = gohelper.findChildText(self.viewGO, "content/title/#go_normaltitle/#txt_name")
	self._gohascollect = gohelper.findChild(self.viewGO, "content/title/#go_hascollect")
	self._txtname2 = gohelper.findChildText(self.viewGO, "content/title/#go_hascollect/#txt_name2")
	self._txtdesc = gohelper.findChildText(self.viewGO, "content/desc/#txt_desc")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "content/go_scroll/#scroll_item")
	self._txtnameitem = gohelper.findChildText(self.viewGO, "content/go_scroll/#scroll_item/viewport/content/#txt_nameitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougerewardThemeTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsuitcollect:AddClickListener(self._btnsuitcollectOnClick, self)
end

function RougerewardThemeTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsuitcollect:RemoveClickListener()
end

function RougerewardThemeTipView:_btncloseOnClick()
	self:closeThis()
end

function RougerewardThemeTipView:_btnsuitcollectOnClick()
	return
end

function RougerewardThemeTipView:_editableInitView()
	return
end

function RougerewardThemeTipView:onUpdateParam()
	return
end

function RougerewardThemeTipView:onOpen()
	self._config = self.viewParam

	self._simageblockpackageicon:LoadImage(ResUrl.getRougeIcon("reward/rouge_reward_roomskindetail"))
end

function RougerewardThemeTipView:_initUI()
	return
end

function RougerewardThemeTipView:onClose()
	return
end

function RougerewardThemeTipView:onDestroyView()
	return
end

return RougerewardThemeTipView
