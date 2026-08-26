-- chunkname: @modules/logic/survival/view/shelter/SurvivalNpcStationView.lua

module("modules.logic.survival.view.shelter.SurvivalNpcStationView", package.seeall)

local SurvivalNpcStationView = class("SurvivalNpcStationView", BaseView)

function SurvivalNpcStationView:onInitView()
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG")
	self._simagePanelBG2 = gohelper.findChildSingleImage(self.viewGO, "Panel/Left/#simage_PanelBG2")
	self._txttitledec = gohelper.findChildText(self.viewGO, "Panel/Left/#txt_titledec")
	self._gobuffitem = gohelper.findChild(self.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem")
	self._txtdec = gohelper.findChildText(self.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#txt_dec")
	self._scrolltag = gohelper.findChildScrollRect(self.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag")
	self._gotagitem = gohelper.findChild(self.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag/viewport/content/#go_tagitem")
	self._imageType = gohelper.findChildImage(self.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag/viewport/content/#go_tagitem/#image_Type")
	self._txtType = gohelper.findChildText(self.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag/viewport/content/#go_tagitem/#txt_Type")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag/viewport/content/#go_tagitem/#btn_click")
	self._goNpcitem = gohelper.findChild(self.viewGO, "Panel/Left/Npc/layout/#go_Npcitem")
	self._goempty = gohelper.findChild(self.viewGO, "Panel/Left/Npc/layout/#go_Npcitem/#go_empty")
	self._gohas = gohelper.findChild(self.viewGO, "Panel/Left/Npc/layout/#go_Npcitem/#go_has")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "Panel/Left/Npc/layout/#go_Npcitem/#go_has/#simage_hero")
	self._scrollList = gohelper.findChildScrollRect(self.viewGO, "Panel/Right/#scroll_List")
	self._goItem = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item")
	self._goSmallItem = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem")
	self._imageChess = gohelper.findChildImage(self.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem/#image_Chess")
	self._txtPartnerName = gohelper.findChildText(self.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem/#txt_PartnerName")
	self._goSelected = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem/#go_Selected")
	self._gorecommend = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem/#go_recommend")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Right/Btns/#btn_Next")
	self._goNextLock = gohelper.findChild(self.viewGO, "Panel/Right/Btns/#go_NextLock")
	self._btnCancel = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Right/Btns/#btn_Cancel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalNpcStationView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
	self._btnCancel:AddClickListener(self._btnCancelOnClick, self)
end

function SurvivalNpcStationView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function SurvivalNpcStationView:_btnclickOnClick()
	self:closeThis()
end

function SurvivalNpcStationView:onClickModalMask()
	self:closeThis()
end

function SurvivalNpcStationView:_btnNextOnClick()
	if not self._fight:canSelectNpc() then
		GameFacade.showToast(ToastEnum.SurvivalBossDotSelectNpc)

		return
	end

	local selectNpcIds = SurvivalShelterNpcMonsterListModel.instance:getSelectList()
	local selectNpcNum = #selectNpcIds
	local isRepress = false
	local schemes = self._fight.schemes

	for id, _ in pairs(schemes) do
		local state = SurvivalShelterMonsterModel.instance:calBuffIsRepress(id)

		if state then
			isRepress = true
		end
	end

	if selectNpcNum > 0 and not isRepress then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalSelectNpcNotRecommend, MsgBoxEnum.BoxType.Yes_No, self._sendSelectNpc, nil, nil, self, nil, nil)

		return
	else
		self:_sendSelectNpc()
	end
end

function SurvivalNpcStationView:_sendSelectNpc()
	self:closeThis()
end

function SurvivalNpcStationView:_btnCancelOnClick()
	SurvivalShelterNpcMonsterListModel.instance:setSelectNpcByList(self._enterSelect)
	self:closeThis()
end

function SurvivalNpcStationView:_editableInitView()
	gohelper.setActive(self._gobuffitem, false)
	gohelper.setActive(self._goNpcitem, false)

	self._nextUIEffect = ZProj_UIEffectsCollection.Get(self._btnNext.gameObject)
end

function SurvivalNpcStationView:onUpdateParam()
	return
end

function SurvivalNpcStationView:onOpen()
	self._enterSelect = SurvivalShelterNpcMonsterListModel.instance:getSelectList()

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self._fight = weekInfo:getMonsterFight()

	self:refreshView()
end

function SurvivalNpcStationView:refreshView()
	SurvivalShelterNpcMonsterListModel.instance:refreshList()
	self:_refreshSchemes()
	self:_updateNpcInfo()

	local canSelectNpc = self._fight:canSelectNpc()

	if self._nextUIEffect then
		self._nextUIEffect:SetGray(not canSelectNpc)
	end
end

function SurvivalNpcStationView:_refreshSchemes()
	local schemes = self._fight.schemes

	if self._schemesItems == nil then
		self._schemesItems = self:getUserDataTb_()
	end

	for id, repress in pairs(schemes) do
		local item = self._schemesItems[id]

		if item == nil then
			local go = gohelper.cloneInPlace(self._gobuffitem)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalMonsterEventSelectBuffItem)

			item:initItem(id)

			self._schemesItems[id] = item

			gohelper.setActive(go, true)
		end

		item:updateItem()
	end
end

function SurvivalNpcStationView:_updateNpcInfo()
	local selectNpcIds = SurvivalShelterNpcMonsterListModel.instance:getSelectList()

	if selectNpcIds == nil then
		return
	end

	if self._smallNpcItems == nil then
		self._smallNpcItems = self:getUserDataTb_()
	end

	local configValue = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterMonsterSelectNpcMax)
	local count = configValue and tonumber(configValue) or 0

	for i = 1, count do
		local item = self._smallNpcItems[i]
		local npcId = selectNpcIds[i]

		if item == nil then
			local go = gohelper.cloneInPlace(self._goNpcitem)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalMonsterEventSmallNpcItem)

			gohelper.setActive(go, true)
			table.insert(self._smallNpcItems, item)
		end

		item:setNeedShowEmpty(true)
		item:updateItem(npcId)
	end
end

function SurvivalNpcStationView:onClose()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateView)
end

function SurvivalNpcStationView:onDestroyView()
	return
end

return SurvivalNpcStationView
