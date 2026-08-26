-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateSelectChessMenView.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenView", package.seeall)

local EliminateSelectChessMenView = class("EliminateSelectChessMenView", BaseView)

function EliminateSelectChessMenView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._goSort = gohelper.findChild(self.viewGO, "Left/#go_Sort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Sort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Sort/#btn_rarerank")
	self._btnfaithrank = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Sort/#btn_faithrank")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Sort/#btn_classify")
	self._scrollChessList = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_ChessList")
	self._goEmpty = gohelper.findChild(self.viewGO, "Right/#go_Empty")
	self._goDetail = gohelper.findChild(self.viewGO, "Right/#go_Detail")
	self._imageChessQualityBG = gohelper.findChildImage(self.viewGO, "Right/#go_Detail/Info/#image_ChessQualityBG")
	self._imageChess = gohelper.findChildSingleImage(self.viewGO, "Right/#go_Detail/Info/#image_Chess")
	self._goResource = gohelper.findChild(self.viewGO, "Right/#go_Detail/Info/#go_Resource")
	self._goResourceItem = gohelper.findChild(self.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem")
	self._imageResourceQuality = gohelper.findChildImage(self.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	self._txtResourceNum = gohelper.findChildText(self.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	self._txtFireNum = gohelper.findChildText(self.viewGO, "Right/#go_Detail/Info/image_Fire/#txt_FireNum")
	self._goStar1 = gohelper.findChild(self.viewGO, "Right/#go_Detail/Info/Stars/#go_Star1")
	self._txtChessName = gohelper.findChildText(self.viewGO, "Right/#go_Detail/Info/#txt_ChessName")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#go_Detail/Scroll View/Viewport/#txt_Descr")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Detail/#btn_Add")
	self._btnOut = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Detail/#btn_Out")
	self._goSlot = gohelper.findChild(self.viewGO, "Bottom/#go_Slot")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#btn_Enter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateSelectChessMenView:addEvents()
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnfaithrank:AddClickListener(self._btnfaithrankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self._btnOut:AddClickListener(self._btnOutOnClick, self)
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
end

function EliminateSelectChessMenView:removeEvents()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnfaithrank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnOut:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
end

function EliminateSelectChessMenView:_btnlvrankOnClick()
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Rare)
	self:_refreshBtnStatus()
end

function EliminateSelectChessMenView:_btnrarerankOnClick()
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Power)
	self:_refreshBtnStatus()
end

function EliminateSelectChessMenView:_btnfaithrankOnClick()
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Resource)
	self:_refreshBtnStatus()
end

function EliminateSelectChessMenView:_btnclassifyOnClick()
	if EliminateTeamSelectionModel.instance:isPreset() then
		GameFacade.showToast(ToastEnum.EliminatePresetTip1)

		return
	end

	local value = EliminateSelectChessMenListModel.instance:getQuickEdit()

	EliminateSelectChessMenListModel.instance:setQuickEdit(not value)
	EliminateSelectChessMenListModel.instance:setSelectedChessMen()
	self:_refreshQuickEditBtnStatus()
end

function EliminateSelectChessMenView:_btnAddOnClick()
	local selectedChessMen = EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	if EliminateSelectChessMenListModel.instance:canAddChessMen(selectedChessMen) then
		EliminateSelectChessMenListModel.instance:addSelectedChessMen(selectedChessMen)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_add)
	else
		GameFacade.showToast(ToastEnum.EliminateAddedFull)
	end
end

function EliminateSelectChessMenView:_btnOutOnClick()
	local selectedChessMen = EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	EliminateSelectChessMenListModel.instance:removeSelectedChessMen(selectedChessMen)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_mln_receive)
end

function EliminateSelectChessMenView:_btnEnterOnClick()
	local list = EliminateSelectChessMenListModel.instance:getAddIds()
	local num = #list

	if num == 0 then
		GameFacade.showToast(ToastEnum.EliminateAddedEmpty)

		return
	end

	if not EliminateTeamSelectionModel.instance:isPreset() and num < EliminateSelectChessMenListModel.instance:getAddMaxCount() then
		GameFacade.showMessageBox(MessageBoxIdDefine.EliminateAddedNotEnough, MsgBoxEnum.BoxType.Yes_No, function()
			self:_enterEpisode()
		end)

		return
	end

	self:_enterEpisode()
end

function EliminateSelectChessMenView:_enterEpisode()
	local list = EliminateSelectChessMenListModel.instance:getAddIds()
	local episodeId = EliminateTeamSelectionModel.instance:getSelectedEpisodeId()
	local characterId = EliminateTeamSelectionModel.instance:getSelectedCharacterId()

	EliminateLevelController.instance:enterLevel(episodeId, characterId, list)

	if not EliminateTeamSelectionModel.instance:isPreset() then
		EliminateMapController.setPrefsString(EliminateMapEnum.PrefsKey.RoleSelected, characterId)

		local str = EliminateSelectChessMenListModel.instance:serializeAddList()

		EliminateMapController.setPrefsString(EliminateMapEnum.PrefsKey.ChessSelected, str)
	end
end

function EliminateSelectChessMenView:_initSortNode(sortType, btnName)
	local btn1 = gohelper.findChild(self.viewGO, string.format("Left/#go_Sort/%s/btn1", btnName))
	local btn1Arrow = gohelper.findChild(self.viewGO, string.format("Left/#go_Sort/%s/btn1/txt/arrow", btnName))
	local btn2 = gohelper.findChild(self.viewGO, string.format("Left/#go_Sort/%s/btn2", btnName))
	local btn2Arrow = gohelper.findChild(self.viewGO, string.format("Left/#go_Sort/%s/btn2/txt/arrow", btnName))

	self._sortBtnNodeList[sortType] = {
		btn1 = btn1,
		btn1ArrowTrans = btn1Arrow and btn1Arrow.transform,
		btn2 = btn2,
		btn2ArrowTrans = btn2Arrow and btn2Arrow.transform
	}
end

function EliminateSelectChessMenView:_refreshBtnStatus()
	local curSortType = EliminateSelectChessMenListModel.instance:getCurSortType()

	for sortType, v in ipairs(self._sortBtnNodeList) do
		local isSelected = sortType == curSortType

		gohelper.setActive(v.btn1, not isSelected)
		gohelper.setActive(v.btn2, isSelected)

		local sortState = EliminateSelectChessMenListModel.instance:getSortState(sortType)

		transformhelper.setLocalScale(v.btn1ArrowTrans, 1, sortState, 1)
		transformhelper.setLocalScale(v.btn2ArrowTrans, 1, sortState, 1)
	end
end

function EliminateSelectChessMenView:_refreshQuickEditBtnStatus()
	local isSelected = EliminateSelectChessMenListModel.instance:getQuickEdit()

	gohelper.setActive(self._quickEditBtns.btn1, not isSelected)
	gohelper.setActive(self._quickEditBtns.btn2, isSelected)
end

function EliminateSelectChessMenView:_editableInitView()
	self._goStars = gohelper.findChild(self.viewGO, "Right/#go_Detail/Info/Stars")
	self._sortBtnNodeList = self:getUserDataTb_()

	self:_initSortNode(EliminateMapEnum.SortType.Rare, "#btn_lvrank")
	self:_initSortNode(EliminateMapEnum.SortType.Power, "#btn_rarerank")
	self:_initSortNode(EliminateMapEnum.SortType.Resource, "#btn_faithrank")

	self._levelList = {}

	for i = 1, 5 do
		table.insert(self._levelList, i)
	end

	local quickEdit = "quickEdit"

	self:_initSortNode(quickEdit, "#btn_classify")

	self._quickEditBtns = self._sortBtnNodeList[quickEdit]

	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.QuickSelectChessMen, self._onQuickSelectChessMen, self)
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.SelectChessMen, self._onSelectChessMen, self)
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.ChangeChessMen, self._onChangeChessMen, self)
	gohelper.setActive(self._goEmpty, true)
	gohelper.setActive(self._goDetail, false)
	EliminateSelectChessMenListModel.instance:initList()
	self:_initSlots()
	self:_updateSlots()
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.ComeShow)
end

function EliminateSelectChessMenView:_onQuickSelectChessMen()
	local selectedChessMen = EliminateSelectChessMenListModel.instance:getSelectedChessMen()
	local isAdded = EliminateSelectChessMenListModel.instance:isInAddList(selectedChessMen)

	if isAdded then
		self:_btnOutOnClick()
	else
		self:_btnAddOnClick()
	end
end

function EliminateSelectChessMenView:_onChangeChessMen()
	self:_updateSlots()
	self:_onSelectChessMen()
end

function EliminateSelectChessMenView:_onSelectChessMen()
	local selectedChessMen = EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(self._goEmpty, not selectedChessMen)
	gohelper.setActive(self._goDetail, selectedChessMen)

	if not selectedChessMen then
		return
	end

	local config = selectedChessMen.config

	self._txtFireNum.text = config.defaultPower

	local skillDesc = self:_getSkillDesc(config.skillId)

	self._txtDescr.text = EliminateLevelModel.instance.formatString(skillDesc, EliminateTeamChessEnum.PreBattleFormatType)
	self._txtChessName.text = config.name

	self:_showOperationBtns()
	UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. config.level, false)

	local costList = selectedChessMen.costList

	gohelper.CreateObjList(self, self._onItemShow, costList, self._goResource, self._goResourceItem)
	SurvivalUnitIconHelper.instance:setNpcIcon(self._imageChess, config.resPic)
	gohelper.setActive(self._goStar1, false)
end

function EliminateSelectChessMenView:_getSkillDesc(skillIds)
	local str = ""
	local list = string.splitToNumber(skillIds, "#")

	for i, id in ipairs(list) do
		local config = lua_soldier_skill.configDict[id]

		str = string.nilorempty(str) and config.skillDes or str .. "\n" .. config.skillDes
	end

	return str
end

function EliminateSelectChessMenView:_onItemShow(obj, data, index)
	local resourceImage = gohelper.findChildImage(obj, "#image_ResourceQuality")
	local txt = gohelper.findChildText(obj, "#image_ResourceQuality/#txt_ResourceNum")
	local resourceId = data[1]

	UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

	txt.text = data[2]
end

function EliminateSelectChessMenView:_showOperationBtns()
	local selectedChessMen = EliminateSelectChessMenListModel.instance:getSelectedChessMen()
	local isAdded = EliminateSelectChessMenListModel.instance:isInAddList(selectedChessMen)

	if EliminateSelectChessMenListModel.instance:getQuickEdit() or EliminateTeamSelectionModel.instance:isPreset() then
		gohelper.setActive(self._btnAdd, false)
		gohelper.setActive(self._btnOut, false)

		return
	end

	gohelper.setActive(self._btnAdd, not isAdded)
	gohelper.setActive(self._btnOut, isAdded)
end

function EliminateSelectChessMenView:_initSlots()
	self._slotList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[2]

	for i = 1, 8 do
		local itemGO = self:getResInst(path, self._goSlot)
		local slotItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, EliminateSelectChessMenSlot)

		self._slotList[i] = slotItem

		slotItem:setIndex(i)
	end
end

function EliminateSelectChessMenView:_updateSlots()
	for i, v in ipairs(self._slotList) do
		local mo = EliminateSelectChessMenListModel.instance:getAddChessMen(i)

		v:onUpdateMO(mo)
	end
end

function EliminateSelectChessMenView:onOpen()
	self:_refreshBtnStatus()
	self:_refreshQuickEditBtnStatus()
end

function EliminateSelectChessMenView:onClose()
	return
end

function EliminateSelectChessMenView:onDestroyView()
	EliminateSelectChessMenListModel.instance:clearList()
end

return EliminateSelectChessMenView
