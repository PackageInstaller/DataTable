-- chunkname: @modules/logic/survival/view/shelter/SurvivalBootyChooseView.lua

module("modules.logic.survival.view.shelter.SurvivalBootyChooseView", package.seeall)

local SurvivalBootyChooseView = class("SurvivalBootyChooseView", BaseView)

function SurvivalBootyChooseView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_FullBG")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_confirm")
	self._btnabandon = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_abandon")
	self._goreward = gohelper.findChild(self.viewGO, "Panel/Left/#go_reward")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Left/#go_reward/empty/#btn_add")
	self._simagereward = gohelper.findChildSingleImage(self.viewGO, "Panel/Left/#go_reward/has/go_icon/#simage_reward")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Left/#go_reward/has/#btn_switch")
	self._btnremove = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Left/#go_reward/has/#btn_remove")
	self._goreward1 = gohelper.findChild(self.viewGO, "Panel/Right/#go_reward1")
	self._goreward2 = gohelper.findChild(self.viewGO, "Panel/Right/#go_reward2")
	self._goreward3 = gohelper.findChild(self.viewGO, "Panel/Right/#go_reward3")
	self._gonpcselect = gohelper.findChild(self.viewGO, "Panel/#go_npcselect")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Panel/#go_npcselect/#simage_PanelBG")
	self._scrollList = gohelper.findChildScrollRect(self.viewGO, "Panel/#go_npcselect/#scroll_List")
	self._goempty = gohelper.findChildScrollRect(self.viewGO, "Panel/#go_npcselect/go_empty")
	self._goSmallItem = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem")
	self._imageChess = gohelper.findChildImage(self.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#image_Chess")
	self._txtPartnerName = gohelper.findChildText(self.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#txt_PartnerName")
	self._goTips = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#go_Tips")
	self._txtTentName = gohelper.findChildText(self.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#go_Tips/#txt_TentName")
	self._goSelected = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#go_Selected")
	self._btnnpcfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_npcselect/#btn_npc_filter")
	self._gonpcNormal = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_npcNormal")
	self._gonpcSelect = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_npcSelect")
	self._gotips = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_tips")
	self._goitem = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_tips/#go_item")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_tips/#go_item/#txt_desc")
	self._btnnpcSelect = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_npcselect/#btn_npc_Select")
	self._btnnpcSelectClose = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_npcselect/#btn_npcSelectClose")
	self._gocollectionselect = gohelper.findChild(self.viewGO, "Panel/#go_collectionselect")
	self._btncollectionClose = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_collectionselect/#btn_collectionClose")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_collectionselect/#btn_filter")
	self._gocollectionFilterNormal = gohelper.findChild(self.viewGO, "Panel/#go_collectionselect/#btn_filter/#go_collectionFilterNormal")
	self._gocollectionFilterSelect = gohelper.findChild(self.viewGO, "Panel/#go_collectionselect/#btn_filter/#go_collectionFilterSelect")
	self._goinfoview = gohelper.findChild(self.viewGO, "Panel/#go_collectionselect/#go_infoview")
	self._goinfo = gohelper.findChild(self.viewGO, "Panel/#go_info")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalBootyChooseView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnabandon:AddClickListener(self._btnabandonOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
	self._btnnpcfilter:AddClickListener(self._btnnpcfilterOnClick, self)
	self._btnnpcSelect:AddClickListener(self._btnnpcSelectOnClick, self)
	self._btnnpcSelectClose:AddClickListener(self._btnnpcSelectCloseOnClick, self)
	self._btncollectionClose:AddClickListener(self._btncollectionCloseOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function SurvivalBootyChooseView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btnabandon:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	self._btnremove:RemoveClickListener()
	self._btnnpcfilter:RemoveClickListener()
	self._btnnpcSelect:RemoveClickListener()
	self._btnnpcSelectClose:RemoveClickListener()
	self._btncollectionClose:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

local needSelectNpcCount = 3

function SurvivalBootyChooseView:_btnconfirmOnClick()
	self:sendSurvivalChooseBooty(false)
end

function SurvivalBootyChooseView:_btnabandonOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalCancelSelectNextReward, MsgBoxEnum.BoxType.Yes_No, self._abandonSelect, nil, nil, self, nil, nil)
end

function SurvivalBootyChooseView:_abandonSelect()
	self:sendSurvivalChooseBooty(true)
end

function SurvivalBootyChooseView:_btnaddOnClick()
	self:_selectEquip()
end

function SurvivalBootyChooseView:_btnswitchOnClick()
	self:_selectEquip()
end

function SurvivalBootyChooseView:_btnremoveOnClick()
	self.amplifierSelectMo:removeOneByPos(1)
	self:refreshEquipSelectInfo()
end

function SurvivalBootyChooseView:_btnnpcfilterOnClick()
	return
end

function SurvivalBootyChooseView:_btnnpcSelectOnClick()
	SurvivalShelterChooseNpcListModel.instance:changeQuickSelect()
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)
	self:_refreshNpcSelectPanel()
end

function SurvivalBootyChooseView:_btnnpcSelectCloseOnClick()
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)
	SurvivalShelterChooseNpcListModel.instance:setSelectPos(nil)
	self:_refreshNpcSelectPanel()
end

function SurvivalBootyChooseView:_btncollectionCloseOnClick()
	SurvivalShelterChooseEquipListModel.instance:setSelectEquip(nil)
	SurvivalShelterChooseEquipListModel.instance:setSelectPos(nil)
	self:_refreshEquipSelectPanel()
end

function SurvivalBootyChooseView:_btnfilterOnClick()
	return
end

function SurvivalBootyChooseView:_btnCloseOnClick()
	self:sendSurvivalChooseBooty(true)
end

function SurvivalBootyChooseView:_editableInitView()
	self.goNpcInfoRoot = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/go_manageinfo")
	self.goFilter = gohelper.findChild(self.viewGO, "Panel/#go_npcselect/#btn_npc_filter")
	self._allNpcPosItem = self:getUserDataTb_()

	for i = 1, needSelectNpcCount do
		local go = self["_goreward" .. i]
		local item = self:getUserDataTb_()

		item.index = i
		item.npcId = nil
		item.empty = gohelper.findChild(go, "empty")
		item.has = gohelper.findChild(go, "has")
		item.lock = gohelper.findChild(go, "lock")
		item.btnAdd = gohelper.findChildButtonWithAudio(go, "empty/btn_add")
		item.btnSwitch = gohelper.findChildButtonWithAudio(go, "has/btn_switch")
		item.btnRemove = gohelper.findChildButtonWithAudio(go, "has/#btn_remove")
		item.simage = gohelper.findChildSingleImage(go, "has/go_icon/image")
		item.goSelect = gohelper.findChild(go, "#go_Selected")

		item.btnAdd:AddClickListener(self._setNpcSelectPos, self, item.index)
		item.btnSwitch:AddClickListener(self._setNpcSelectPos, self, item.index)
		item.btnRemove:AddClickListener(self._onClickBtnRemove, self, item.index)
		gohelper.setActive(item.goSelect, false)
		table.insert(self._allNpcPosItem, item)
	end

	local infoViewRes = self.viewContainer._viewSetting.otherRes.equipInfoView
	local infoGo = self:getResInst(infoViewRes, self._goinfoview)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalShowBagInfoPart)

	local itemRes = self.viewContainer._viewSetting.otherRes.equipItemView

	self._equipItem = self:getResInst(itemRes, self.viewGO)

	gohelper.setActive(self._equipItem, false)

	self._equipHasGo = gohelper.findChild(self.viewGO, "Panel/Left/#go_reward/has")
	self._equipEmptyGo = gohelper.findChild(self.viewGO, "Panel/Left/#go_reward/empty")

	local goIcon = gohelper.findChild(self._equipHasGo, "go_icon")
	local itemRes = self.viewContainer:getSetting().otherRes.itemRes
	local go = self.viewContainer:getResInst(itemRes, goIcon)

	self._equipSelectedItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalBagItem)
	self._goscroll = gohelper.findChild(self.viewGO, "Panel/#go_collectionselect/scroll_collection")
	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._goscroll, SurvivalSimpleListPart)

	self._simpleList:setCellUpdateCallBack(self._createEquipItem, self, SurvivalChooseBagItem, self._equipItem)

	self._npcCloseClick = gohelper.findChildClickWithAudio(self.viewGO, "Panel/#go_npcselect/Mask")
	self._collectionCloseClick = gohelper.findChildClickWithAudio(self.viewGO, "Panel/#go_collectionselect/Mask")

	self._npcCloseClick:AddClickListener(self._btnnpcSelectCloseOnClick, self)
	self._collectionCloseClick:AddClickListener(self._btncollectionCloseOnClick, self)
end

function SurvivalBootyChooseView:_setNpcSelectPos(pos)
	local param = {
		closeCallBack = self.onInheritViewClose,
		closeCallBackContext = self
	}

	SurvivalController.instance:sendOpenSurvivalRewardInheritView(SurvivalEnum.HandBookType.Npc, param)
end

function SurvivalBootyChooseView:_onClickBtnRemove(pos)
	self.npcSelectMo:removeOneByPos(pos)
	self:refreshSelectInfo()
end

function SurvivalBootyChooseView:onUpdateParam()
	return
end

function SurvivalBootyChooseView:onOpen()
	self.amplifierSelectMo = SurvivalRewardInheritModel.instance.amplifierSelectMo
	self.npcSelectMo = SurvivalRewardInheritModel.instance.npcSelectMo

	self:clearSelect()
	self:refreshFilter()
	self:refreshEquipFilter()
	self:refreshSelectPanel()

	self._isSendSurvivalChoose = false

	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnSelectFinish, self.refreshSelectPanel, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnSetNpcSelectPos, self._setNpcSelectPos, self)
end

function SurvivalBootyChooseView:onInheritViewClose()
	self:refreshSelectInfo()
	self:refreshEquipSelectInfo()
end

function SurvivalBootyChooseView:refreshSelectPanel()
	self:_refreshNpcSelectPanel()
	self:_refreshEquipSelectPanel()
end

function SurvivalBootyChooseView:_refreshNpcSelectPanel()
	local pos = SurvivalShelterChooseNpcListModel.instance:getSelectPos()
	local isShow = not not pos

	gohelper.setActive(self._gonpcselect, isShow)
	self:refreshSelectInfo()

	if not isShow then
		return
	end

	self:refreshNpcInfoView()
	self:refreshQuickSelect()
	SurvivalShelterChooseNpcListModel.instance:refreshNpcList(self._filterList)

	local isEmpty = #SurvivalShelterChooseNpcListModel.instance:getList() == 0

	gohelper.setActive(self._scrollList, not isEmpty)
	gohelper.setActive(self._goempty, isEmpty)
end

function SurvivalBootyChooseView:refreshSelectInfo()
	for i = 1, self.npcSelectMo.maxAmount do
		local item = self._allNpcPosItem[i]
		local npcId = self.npcSelectMo:getSelectCellCfgId(i)
		local isNil = npcId == nil

		if item ~= nil then
			gohelper.setActive(item.empty, isNil)
			gohelper.setActive(item.has, not isNil)
			gohelper.setActive(item.goSelect, false)

			if not isNil and (item.npcId == nil or item.npcId ~= npcId) then
				local config = SurvivalConfig.instance:getNpcConfig(npcId)

				if config and not string.nilorempty(config.smallIcon) then
					local path = ResUrl.getSurvivalNpcIcon(config.smallIcon)

					item.simage:LoadImage(path)
				end

				item.npcId = npcId
			end
		end
	end
end

function SurvivalBootyChooseView:refreshFilter()
	self:_setFilterCb(false)

	local filterComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goFilter, SurvivalFilterPart)
	local filterOptions = {}
	local list = lua_survival_tag_type.configList

	for _, v in ipairs(list) do
		table.insert(filterOptions, {
			desc = v.name,
			type = v.id
		})
	end

	filterComp:setOptionChangeCallback(self._onFilterChange, self)
	filterComp:setOptions(filterOptions)
	filterComp:setClickCb(self._setFilterCb, self)
end

function SurvivalBootyChooseView:_setFilterCb(active)
	gohelper.setActive(self._gonpcNormal, not active)
	gohelper.setActive(self._gonpcSelect, active)
end

function SurvivalBootyChooseView:_onFilterChange(filterList)
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)

	self._filterList = filterList

	self:refreshSelectPanel()
end

local lastSelectNpcId

function SurvivalBootyChooseView:refreshNpcInfoView()
	local selectNpcId = SurvivalShelterChooseNpcListModel.instance:getSelectNpc()

	if not selectNpcId or selectNpcId == 0 then
		gohelper.setActive(self.goNpcInfoRoot, false)

		return
	end

	if self.goNpcInfoRoot.activeSelf and (lastSelectNpcId == nil or lastSelectNpcId == selectNpcId) then
		gohelper.setActive(self.goNpcInfoRoot, false)

		return
	end

	lastSelectNpcId = selectNpcId

	gohelper.setActive(self.goNpcInfoRoot, true)

	if not self.npcInfoView then
		local prefabRes = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes.infoView)

		self.npcInfoView = ShelterManagerInfoView.getView(prefabRes, self.goNpcInfoRoot, "infoView")
	end

	local param = {}

	param.showType = SurvivalEnum.InfoShowType.NpcOnlyConfig
	param.showId = selectNpcId
	param.showSelect = true
	param.showUnSelect = true

	self.npcInfoView:refreshParam(param)
end

function SurvivalBootyChooseView:refreshQuickSelect()
	local isGray = not SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

	ZProj.UGUIHelper.SetGrayscale(self._btnnpcSelect.gameObject, isGray)
end

function SurvivalBootyChooseView:_selectEquip()
	local param = {
		closeCallBack = self.onInheritViewClose,
		closeCallBackContext = self
	}

	SurvivalController.instance:sendOpenSurvivalRewardInheritView(SurvivalEnum.HandBookType.Amplifier, param)
end

function SurvivalBootyChooseView:_refreshEquipSelectPanel()
	local pos = SurvivalShelterChooseEquipListModel.instance:getSelectPos()
	local isShow = not not pos

	gohelper.setActive(self._gocollectionselect, isShow)
	self:refreshEquipSelectInfo()

	if not isShow then
		return
	end

	SurvivalShelterChooseEquipListModel.instance:refreshList(self._equipFilterList)
	self._simpleList:setList(SurvivalShelterChooseEquipListModel.instance:getList())
	self:refreshEquipInfoView()
end

function SurvivalBootyChooseView:refreshEquipSelectInfo()
	local equipId = self.amplifierSelectMo:getSelectCellCfgId(1)
	local isNil = equipId == nil

	gohelper.setActive(self._equipEmptyGo, isNil)
	gohelper.setActive(self._equipHasGo, not isNil)

	if not isNil then
		local mo = SurvivalBagItemMo.New()

		mo:init({
			count = 1,
			id = equipId
		})
		self._equipSelectedItem:updateMo(mo)
		self._equipSelectedItem:setShowNum(false)
		self._equipSelectedItem:setItemSize(180, 180)
	end
end

function SurvivalBootyChooseView:_createEquipItem(obj, data, index)
	obj:updateMo(data)
	obj:setClickCallback(self._onEquipItemClick, self)

	local equipId = SurvivalShelterChooseEquipListModel.instance:getSelectEquip()

	if obj:getEquipId() == equipId then
		obj:setIsSelect(true)
	end
end

function SurvivalBootyChooseView:_onEquipItemClick()
	self:_refreshEquipSelectPanel()
end

local lastSelectEquipId

function SurvivalBootyChooseView:refreshEquipInfoView()
	local selectEquipId = SurvivalShelterChooseEquipListModel.instance:getSelectEquip()

	if not selectEquipId or selectEquipId == 0 then
		gohelper.setActive(self._goinfoview, false)

		return
	end

	if self._goinfoview.activeSelf and (lastSelectEquipId == nil or lastSelectEquipId == selectEquipId) then
		gohelper.setActive(self._goinfoview, false)

		return
	end

	lastSelectEquipId = selectEquipId

	gohelper.setActive(self._goinfoview, true)

	local mo = SurvivalBagItemMo.New()

	mo:init({
		id = selectEquipId
	})
	self._infoPanel:updateMo(mo)
end

function SurvivalBootyChooseView:refreshEquipFilter()
	self:_setEquipFilterCb(false)

	local filterComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._btnfilter.gameObject, SurvivalFilterPart)
	local filterOptions = {}
	local list = lua_survival_equip_found.configList

	for _, v in ipairs(list) do
		table.insert(filterOptions, {
			desc = v.name,
			type = v.id
		})
	end

	filterComp:setOptionChangeCallback(self._onEquipFilterChange, self)
	filterComp:setOptions(filterOptions)
	filterComp:setClickCb(self._setEquipFilterCb, self)
end

function SurvivalBootyChooseView:_setEquipFilterCb(active)
	gohelper.setActive(self._gocollectionFilterNormal, not active)
	gohelper.setActive(self._gocollectionFilterSelect, active)
end

function SurvivalBootyChooseView:_onEquipFilterChange(filterList)
	SurvivalShelterChooseEquipListModel.instance:setSelectEquip(nil)

	self._equipFilterList = filterList

	self:refreshSelectPanel()
end

function SurvivalBootyChooseView:clearSelect()
	self.equipSelectList = {}
	self.npcSelectList = {}
end

function SurvivalBootyChooseView:sendSurvivalChooseBooty(isClear)
	self._isSendSurvivalChoose = true

	if isClear then
		self:clearSelect()
	else
		self._selectNpcList = SurvivalShelterChooseNpcListModel.instance:getAllSelectPosNpc()
		self._selectEquipList = SurvivalShelterChooseEquipListModel.instance:getAllSelectPosEquip()
		self.equipSelectList = self.amplifierSelectMo:getSelectList()
		self.npcSelectList = self.npcSelectMo:getSelectList()
	end

	SurvivalWeekRpc.instance:sendSurvivalChooseBooty(self.npcSelectList, self.equipSelectList, self._selectFinish, self)
end

function SurvivalBootyChooseView:_selectFinish()
	self:closeThis()

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType == SceneType.SurvivalShelter or curSceneType == SceneType.Fight then
		SurvivalController.instance:exitMap()
	end

	SurvivalShelterChooseNpcListModel.instance:setNeedSelectNpcList()
	SurvivalShelterChooseEquipListModel.instance:setNeedSelectEquipList()
	self.amplifierSelectMo:clear()
	self.npcSelectMo:clear()
end

function SurvivalBootyChooseView:onClose()
	if not self._isSendSurvivalChoose then
		self:sendSurvivalChooseBooty(true)
	end
end

function SurvivalBootyChooseView:onDestroyView()
	if self._npcCloseClick then
		self._npcCloseClick:RemoveClickListener()

		self._npcCloseClick = nil
	end

	if self._collectionCloseClick then
		self._collectionCloseClick:RemoveClickListener()

		self._collectionCloseClick = nil
	end

	for i = 1, needSelectNpcCount do
		local item = self._allNpcPosItem[i]

		if item ~= nil then
			item.btnAdd:RemoveClickListener()
			item.btnSwitch:RemoveClickListener()
			item.btnRemove:RemoveClickListener()

			item = nil
		end
	end
end

return SurvivalBootyChooseView
