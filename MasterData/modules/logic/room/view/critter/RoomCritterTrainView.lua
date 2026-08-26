-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainView.lua

module("modules.logic.room.view.critter.RoomCritterTrainView", package.seeall)

local RoomCritterTrainView = class("RoomCritterTrainView", BaseView)

function RoomCritterTrainView:onInitView()
	self._gomapui = gohelper.findChild(self.viewGO, "#go_mapui")
	self._goheroSub = gohelper.findChild(self.viewGO, "right/#go_heroSub")
	self._btnherosort = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_heroSub/sort/#drop_herosort/#btn_herosort")
	self._btnherofilter = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_heroSub/sort/#btn_herofilter")
	self._gonoherofilter = gohelper.findChild(self.viewGO, "right/#go_heroSub/sort/#btn_herofilter/#go_noherofilter")
	self._goherofilter = gohelper.findChild(self.viewGO, "right/#go_heroSub/sort/#btn_herofilter/#go_herofilter")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "right/#go_heroSub/#scroll_hero")
	self._gocritterSub = gohelper.findChild(self.viewGO, "right/#go_critterSub")
	self._btncrittersort = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_critterSub/sort/#drop_crittersort/#btn_crittersort")
	self._btncritterfilter = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_critterSub/sort/#btn_critterfilter")
	self._gonocritterfilter = gohelper.findChild(self.viewGO, "right/#go_critterSub/sort/#btn_critterfilter/#go_nocritterfilter")
	self._gocritterfilter = gohelper.findChild(self.viewGO, "right/#go_critterSub/sort/#btn_critterfilter/#go_critterfilter")
	self._scrollcritter = gohelper.findChildScrollRect(self.viewGO, "right/#go_critterSub/#scroll_critter")
	self._goslotSub = gohelper.findChild(self.viewGO, "right/#go_slotSub")
	self._scrollslot = gohelper.findChildScrollRect(self.viewGO, "right/#go_slotSub/#scroll_slot")
	self._btntrain = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_train")
	self._txtnum = gohelper.findChildText(self.viewGO, "right/#btn_train/#txt_num")
	self._gotrainfull = gohelper.findChild(self.viewGO, "right/#go_trainfull")
	self._btntrainstart = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_trainstart")
	self._txtlefttitle = gohelper.findChildText(self.viewGO, "left/#txt_lefttitle")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_des")
	self._txtleftDesc = gohelper.findChildText(self.viewGO, "left/#scroll_des/viewport/content/#txt_leftDesc")
	self._gotrainingdetail = gohelper.findChild(self.viewGO, "bottom/#go_trainingdetail")
	self._gotrainselect = gohelper.findChild(self.viewGO, "bottom/#go_trainselect")
	self._btncritterrefresh = gohelper.findChildButtonWithAudio(self._gotrainingdetail, "#btn_critterrefresh")
	self._btnheroselect = gohelper.findChildButtonWithAudio(self._gotrainselect, "hero/#btn_hero_select")
	self._btncritterselect = gohelper.findChildButtonWithAudio(self._gotrainselect, "critter/#btn_critter_select")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainView:addEvents()
	self._btnherosort:AddClickListener(self._btnherosortOnClick, self)
	self._btnherofilter:AddClickListener(self._btnherofilterOnClick, self)
	self._btncrittersort:AddClickListener(self._btncrittersortOnClick, self)
	self._btncritterfilter:AddClickListener(self._btncritterfilterOnClick, self)
	self._btntrain:AddClickListener(self._btntrainOnClick, self)
	self._btntrainstart:AddClickListener(self._btntrainstartOnClick, self)
	self._btncritterrefresh:AddClickListener(self._btncritterrefreshOnClick, self)
end

function RoomCritterTrainView:removeEvents()
	self._btnherosort:RemoveClickListener()
	self._btnherofilter:RemoveClickListener()
	self._btncrittersort:RemoveClickListener()
	self._btncritterfilter:RemoveClickListener()
	self._btntrain:RemoveClickListener()
	self._btntrainstart:RemoveClickListener()
	self._btncritterrefresh:RemoveClickListener()
end

function RoomCritterTrainView:_btntrainstartOnClick()
	if not self._selectSlotMO then
		return
	end

	if not self._selectCritterUid then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNoCritter)

		return
	end

	if not self._selectHeroId then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNoHero)

		return
	end

	local critterMO = self._selectSlotMO.critterMO
	local critterUid = critterMO and critterMO.id
	local heroId = critterMO and critterMO.trainInfo.heroId

	if self:_getTrainBtnOpState() == self._TrainBtnOpState.FinishTrain then
		if critterMO.trainInfo:isFinishAllEvent() then
			RoomCritterController.instance:sendFinishTrainCritter(critterMO.id)
		else
			RoomCritterController.instance:openTrainEventView(critterMO.id)
		end

		return
	end

	local boxId

	if critterUid then
		if critterUid == self._selectCritterUid and heroId == self._selectHeroId then
			boxId = MessageBoxIdDefine.RoomCritterTrainChangeCancel
		elseif critterUid ~= self._selectCritterUid then
			boxId = MessageBoxIdDefine.RoomCritterTrainChangeCritter
		elseif heroId ~= self._selectHeroId then
			boxId = MessageBoxIdDefine.RoomCritterTrainChangeHero
		end
	end

	if boxId then
		GameFacade.showMessageBox(boxId, MsgBoxEnum.BoxType.Yes_No, self._sendStartRequest, nil, nil, self, nil, nil)
	else
		self:_sendStartRequest()
	end
end

function RoomCritterTrainView:_sendStartRequest()
	if not self._selectSlotMO or not self._selectCritterUid or not self._selectHeroId then
		return
	end

	local critterMO = self._selectSlotMO.critterMO
	local critterUid = critterMO and critterMO.id
	local heroId = critterMO and critterMO.trainInfo.heroId

	if critterMO then
		CritterRpc.instance:sendCancelTrainRequest(critterMO.id)
	end

	if critterUid ~= self._selectCritterUid or heroId ~= self._selectHeroId then
		self._selectSlotMO:setWaitingCritterUid(self._selectCritterUid)

		local guideId = GuideModel.instance:getLockGuideId()

		if guideId == GuideEnum.GuideId.RoomCritterTrain then
			local guideMO = GuideModel.instance:getById(guideId)
			local curStep = guideMO.currStepId

			CritterRpc.instance:sendStartTrainCritterRequest(self._selectCritterUid, self._selectHeroId, guideId, curStep)
		else
			CritterRpc.instance:sendStartTrainCritterRequest(self._selectCritterUid, self._selectHeroId)
		end

		if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainOcne, 0) then
			RedDotRpc.instance:sendGetRedDotInfosRequest({
				RedDotEnum.DotNode.RoomCritterTrainOcne
			})
		end
	end
end

function RoomCritterTrainView:_btnherosortOnClick()
	self:_btncrittersortOnClick()
end

function RoomCritterTrainView:_btnherofilterOnClick()
	local filterTypeList = {
		CritterEnum.FilterType.Race
	}

	CritterController.instance:openCritterFilterView(filterTypeList, self.viewName)
end

function RoomCritterTrainView:_btncrittersortOnClick()
	self:_setSortIndex(self._lastCritterIndex, self._isHightToLow == false)
	self:_refreshFilterUI()
end

function RoomCritterTrainView:_btncritterfilterOnClick()
	local filterTypeList = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(filterTypeList, self.viewName)
end

function RoomCritterTrainView:_btncritterrefreshOnClick()
	self:setShowSubSelectView(true)
	self.viewContainer:dispatchEvent(CritterEvent.UIChangeTrainCritter, self._selectSlotMO)
end

function RoomCritterTrainView:_btntrainOnClick()
	local freeMO = RoomTrainSlotListModel.instance:findFreeSlotMO()

	if self.viewContainer and freeMO then
		self.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, freeMO)
	end
end

function RoomCritterTrainView:_btnheroOnClick()
	self:_selectSubView(self._TrainSubViewID.HeroSub)
end

function RoomCritterTrainView:_btncritterOnClick()
	self:_selectSubView(self._TrainSubViewID.CritterSub)
end

function RoomCritterTrainView:_editableInitView()
	gohelper.setActive(self._btntrain, false)
	gohelper.setActive(self._gotrainfull, false)

	self._dropCritterSort = gohelper.findChildDropdown(self.viewGO, "right/#go_critterSub/sort/#drop_crittersort")
	self._dropHeroSort = gohelper.findChildDropdown(self.viewGO, "right/#go_heroSub/sort/#drop_herosort")
	self._txttrainstart = gohelper.findChildText(self.viewGO, "right/#btn_trainstart/txt_start")
	self._gocritterArrow = gohelper.findChild(self.viewGO, "right/#go_critterSub/sort/#drop_crittersort/arrow")
	self._goheroArrow = gohelper.findChild(self.viewGO, "right/#go_heroSub/sort/#drop_herosort/arrow")
	self._gocritterEmpty = gohelper.findChild(self._gocritterSub, "#go_empty")
	self._goheroEmpty = gohelper.findChild(self._goheroSub, "#go_empty")
	self._gocritterArrowTrs = self._gocritterArrow.transform
	self._goheroArrowTrs = self._goheroArrow.transform
	self._subGOList = self:getUserDataTb_()

	table.insert(self._subGOList, self._goslotSub)
	table.insert(self._subGOList, self._gocritterSub)
	table.insert(self._subGOList, self._goheroSub)

	self._TrainSubViewID = {
		CritterSub = 2,
		HeroSub = 3,
		SlotSub = 1
	}
	self._TrainBtnOpState = {
		StartNewTrain = 1,
		FinishTrain = 4,
		CancelTrain = 2,
		ChangeTrain = 3
	}
	self._TrainBtnLang = {
		[self._TrainBtnOpState.StartNewTrain] = "critter_train_startnew_txt",
		[self._TrainBtnOpState.CancelTrain] = "critter_train_cancel_txt",
		[self._TrainBtnOpState.ChangeTrain] = "critter_train_change_txt",
		[self._TrainBtnOpState.FinishTrain] = "critter_train_finish_txt"
	}

	self:_initSortFilter()
end

function RoomCritterTrainView:onUpdateParam()
	return
end

function RoomCritterTrainView:onOpen()
	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainSelectCritter, self._onSelectCritterItem, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainSelectHero, self._onSelectHeroItem, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainSelectSlot, self._onSelectSlotItem, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainSubTab, self._selectSubView, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UIChangeTrainCritter, self._onChangeTrainCritter, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainViewGoBack, self._onTrainGoBack, self)
	end

	self.addEventCb(self, CritterController.instance, CritterEvent.TrainFinishTrainCritterReply, self._onTrainFinishTrainCritterReply, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.TrainStartTrainCritterReply, self._onTrainStartTrainCritterReply, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.TrainCancelTrainReply, self._onTrainCancelTrainReply, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self._onCritterChangeFilterType, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoPushUpdate, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._onTradeLevelChange, self)

	self.filterMO = CritterFilterModel.instance:generateFilterMO(self.viewName)

	RoomTrainSlotListModel.instance:setSlotList()
	RoomTrainHeroListModel.instance:setHeroList(self.filterMO)
	RoomTrainCritterListModel.instance:setCritterList(self.filterMO)
	self:_selectSubView(self._TrainSubViewID.SlotSub)
	TaskDispatcher.cancelTask(self._onRunCdTimeTask, self)
	TaskDispatcher.runRepeat(self._onRunCdTimeTask, self, 1)
	self:_refreshTarnBtnUI()

	local selectSlotMO = RoomTrainSlotListModel.instance:getSelectMO()

	if self.viewParam and self.viewParam.critterUid then
		local slotMO = RoomTrainSlotListModel.instance:getSlotMOByCritterUi(self.viewParam.critterUid)

		if slotMO then
			selectSlotMO = slotMO

			RoomTrainSlotListModel.instance:setSelect(slotMO.id)
		end
	end

	if self.viewContainer and selectSlotMO and selectSlotMO.critterMO then
		self.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, selectSlotMO)
	else
		gohelper.setActive(self._gotrainingdetail, false)
		gohelper.setActive(self._gomapui, false)
		gohelper.setActive(self._gotrainselect, false)
	end

	self:_refreshEmptyUI()

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainHas, 0) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoomCritterTrainHas
		})
	end
end

function RoomCritterTrainView:onClose()
	TaskDispatcher.cancelTask(self._onRunCdTimeTask, self)
	self._dropCritterSort:RemoveOnValueChanged()
	self._dropHeroSort:RemoveOnValueChanged()

	local scene = RoomCameraController.instance:getRoomScene()

	if scene then
		scene.cameraFollow:setFollowTarget(nil)
	end

	RoomCritterController.instance:setInteractionParam(nil)
end

function RoomCritterTrainView:onDestroyView()
	return
end

RoomCritterTrainView._sortAttrIdKey = "RoomCritterTrainView._sortAttrIdKey"

function RoomCritterTrainView:_initSortFilter()
	self._critterOptions = {}

	local opNames = {}

	self._selectAttrId = RoomTrainCritterListModel.instance:getSortAttrId()
	self._isHightToLow = true

	local selectIndex = 0

	tabletool.addValues(self._critterOptions, lua_critter_attribute.configList)

	for i, co in ipairs(self._critterOptions) do
		if co.id == self._selectAttrId then
			selectIndex = i - 1
		end

		table.insert(opNames, co.name)
	end

	self:_setSortIndex(selectIndex, self._isHightToLow)
	self._dropCritterSort:ClearOptions()
	self._dropCritterSort:AddOptions(opNames)
	self._dropCritterSort:SetValue(selectIndex)
	self._dropCritterSort:AddOnValueChanged(self._onCritterDropValueChanged, self)
	self._dropHeroSort:ClearOptions()
	self._dropHeroSort:AddOptions(opNames)
	self._dropHeroSort:SetValue(selectIndex)
	self._dropHeroSort:AddOnValueChanged(self._onHeroDropValueChanged, self)
	self:_refreshFilterUI()
end

function RoomCritterTrainView:_refreshFilterUI()
	if self.filterMO then
		local isFiltering = self.filterMO:isFiltering()

		gohelper.setActive(self._gocritterfilter, self.filterMO)
		gohelper.setActive(self._gonocritterfilter, not self.filterMO)
		gohelper.setActive(self._goherofilter, self.filterMO)
		gohelper.setActive(self._gonoherofilter, not self.filterMO)

		local scaleY = self._isHightToLow and -1 or 1

		transformhelper.setLocalScale(self._gocritterArrowTrs, 1, scaleY, 1)
		transformhelper.setLocalScale(self._goheroArrowTrs, 1, scaleY, 1)
		self:_refreshEmptyUI()
	end
end

function RoomCritterTrainView:_refreshEmptyUI()
	return
end

function RoomCritterTrainView:_setSortIndex(index, isHightToLow)
	if self._lastCritterIndex == index and self._isLastHightToLow == isHightToLow then
		return
	end

	self._lastCritterIndex = index
	self._isLastHightToLow = isHightToLow
	self._isHightToLow = isHightToLow

	local co = self._critterOptions[index + 1]

	if co then
		self._selectAttrId = co.id

		RoomTrainCritterListModel.instance:sortByAttrId(self._selectAttrId, self._isHightToLow)
		RoomTrainHeroListModel.instance:sortByAttrId(self._selectAttrId, self._isHightToLow)
		RoomTrainCritterListModel.instance:onModelUpdate()
		RoomTrainHeroListModel.instance:onModelUpdate()
	end
end

function RoomCritterTrainView:_onCritterDropValueChanged(index)
	self:_setSortIndex(index, self._isHightToLow)
	self._dropHeroSort:SetValue(index)
end

function RoomCritterTrainView:_onHeroDropValueChanged(index)
	self:_setSortIndex(index, self._isHightToLow)
	self._dropCritterSort:SetValue(index)
end

function RoomCritterTrainView:_onRunCdTimeTask()
	if self.viewContainer and self.viewContainer:isOpen() then
		self.viewContainer:dispatchEvent(CritterEvent.UITrainCdTime)
	else
		TaskDispatcher.cancelTask(self._onRunCdTimeTask, self)
	end
end

function RoomCritterTrainView:_selectSubView(idx)
	idx = idx or self._TrainSubViewID.SlotSub
	self._curSubTagIdx = idx

	for i = 1, #self._subGOList do
		gohelper.setActive(self._subGOList[i], i == idx)
	end
end

function RoomCritterTrainView:_setSelectSlotMO(mo)
	self._selectHeroId = nil
	self._trainHeroId = nil
	self._trainCritterUid = nil
	self._selectCritterUid = nil
	self._selectSlotMO = mo
	self._selectSlotId = mo and mo.id

	local critterMO = mo and mo.critterMO

	if critterMO then
		self._trainCritterUid = critterMO.id
		self._trainHeroId = critterMO.trainInfo.heroId
		self._selectCritterUid = critterMO.id
		self._selectHeroId = critterMO.trainInfo.heroId
	end
end

function RoomCritterTrainView:_onSelectSlotItem(mo, notMoveCamera)
	if mo then
		::label_28_0::

		local var_28_0 = mo.critterMO

		if mo.critterMO then
			local slotCritterUid = mo.critterMO.id
			local isShow = slotCritterUid == nil

			self:_setSelectSlotMO(mo)
			RoomTrainSlotListModel.instance:setSelect(mo.id)
			RoomTrainHeroListModel.instance:setSelect(nil)
			RoomTrainCritterListModel.instance:setSelect(nil)
			self:setShowSubSelectView(isShow, notMoveCamera)
		end
	end
end

function RoomCritterTrainView:_onSelectCritterItem(mo)
	if self._selectCritterUid ~= mo.id then
		self._selectCritterUid = mo.id

		RoomTrainCritterListModel.instance:setSelect(mo.id)
		self:setShowSubSelectView(true)
		RoomTrainHeroListModel.instance:updateHeroList()
	end
end

function RoomCritterTrainView:_onSelectHeroItem(mo)
	self._selectHeroMO = mo

	if self._selectHeroId ~= mo.id then
		self._selectHeroId = mo.id

		RoomTrainHeroListModel.instance:setSelect(mo.id)
		self:setShowSubSelectView(true)
		RoomTrainCritterListModel.instance:updateCritterList()
	end
end

function RoomCritterTrainView:_onChangeTrainCritter(slotMO)
	self:_setSelectSlotMO(slotMO)
	RoomTrainHeroListModel.instance:setSelect(self._selectCritterUid)
	RoomTrainCritterListModel.instance:setSelect(self._selectHeroId)
	self:setShowSubSelectView(true)
	RoomTrainHeroListModel.instance:updateHeroList()
	RoomTrainCritterListModel.instance:updateCritterList()
end

function RoomCritterTrainView:_onTrainGoBack()
	self:_setSelectSlotMO(self._selectSlotMO)
	RoomTrainHeroListModel.instance:setSelect(nil)
	RoomTrainCritterListModel.instance:setSelect(nil)
	self:setShowSubSelectView(false, true)
end

function RoomCritterTrainView:_onTrainStartTrainCritterReply(critterUid, heroId)
	self:_updateSelectReply(critterUid)
end

function RoomCritterTrainView:_onTrainFinishTrainCritterReply(critterUid)
	self:_updateSelectReply(critterUid, true)
end

function RoomCritterTrainView:_onTrainCancelTrainReply(critterUid)
	self:_updateSelectReply(critterUid)
end

function RoomCritterTrainView:_onTradeLevelChange()
	RoomTrainSlotListModel.instance:updateSlotList()
end

function RoomCritterTrainView:_onCritterInfoPushUpdate()
	RoomTrainCritterListModel.instance:updateCritterList()
end

function RoomCritterTrainView:_udateCritterAndHeroList(isNotHero)
	RoomTrainCritterListModel.instance:updateCritterList()

	if isNotHero == true then
		RoomTrainHeroListModel.instance:updateCritterList()
	end
end

function RoomCritterTrainView:_onCritterChangeFilterType(viewName)
	if self.viewName == viewName then
		RoomTrainHeroListModel.instance:setHeroList(self.filterMO)
		RoomTrainCritterListModel.instance:setCritterList(self.filterMO)
		self:_refreshFilterUI()
	end
end

function RoomCritterTrainView:_updateSelectReply(critterUid, isCheckTrain)
	if self._selectCritterUid == critterUid and (not isCheckTrain or self._trainCritterUid == critterUid) then
		if self._selectSlotMO then
			self.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, self._selectSlotMO)
		end

		self:setShowSubSelectView(false)
	end

	RoomTrainSlotListModel.instance:onModelUpdate()
	RoomTrainCritterListModel.instance:updateCritterList()
	RoomTrainHeroListModel.instance:updateHeroList()
	self:_refreshEmptyUI()
end

function RoomCritterTrainView:setShowSubSelectView(isShow, noFollowCamera)
	if isShow then
		if not CritterEnum.TrainOPState.PairOP then
			local opState = CritterEnum.TrainOPState.Normal

			self:_setOpState(opState)

			local hasTrain = self._trainCritterUid ~= nil

			self._isShowSubSelect = isShow

			gohelper.setActive(self._gotrainingdetail, not isShow and hasTrain)
			gohelper.setActive(self._gomapui, not isShow and hasTrain)
			gohelper.setActive(self._gotrainselect, isShow)

			if isShow then
				if not self._curSubTagIdx or self._curSubTagIdx == self._TrainSubViewID.SlotSub then
					self:_selectSubView(self._TrainSubViewID.CritterSub)
				end
			else
				self:_selectSubView(self._TrainSubViewID.SlotSub)
			end

			self:_refreshTarnBtnUI()

			if noFollowCamera ~= true then
				if isShow then
					self:_followTrainHero(0)
				else
					self:_followTrainHero(self._trainHeroId or 0)
				end
			end
		end
	end
end

function RoomCritterTrainView:_setOpState(opState)
	if self.viewContainer and self.viewContainer.setContainerTabState then
		if self._lastOptate == opState then
			return
		end

		self._lastOptate = opState

		self.viewContainer:setContainerTabState(RoomCritterBuildingViewContainer.SubViewTabId.Training, opState)

		if CritterEnum.TrainOPState.Normal == opState then
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
		else
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView, true)
		end
	end
end

function RoomCritterTrainView:_refreshTarnBtnUI()
	local state = 0

	if self._isShowSubSelect then
		state = 1
	else
		local train, free = RoomTrainSlotListModel.instance:getTrarinAndFreeCount()

		if free > 0 then
			state = 2
			self._txtnum.text = string.format("%s/%s", train, train + free)
		end
	end

	gohelper.setActive(self._btntrainstart, state == 1)

	if state == 1 then
		local opState = self:_getTrainBtnOpState()

		self._txttrainstart.text = luaLang(self._TrainBtnLang[opState])
	end
end

function RoomCritterTrainView:_getTrainBtnOpState()
	if self._trainCritterUid then
		if self._trainCritterUid == self._selectCritterUid and self._trainHeroId == self._selectHeroId then
			if self._selectSlotMO then
				if self._selectSlotMO and self._selectSlotMO.trainInfo:isTrainFinish() then
					return self._TrainBtnOpState.FinishTrain
				end

				return self._TrainBtnOpState.CancelTrain
			end
		end

		return self._TrainBtnOpState.ChangeTrain
	end

	return self._TrainBtnOpState.StartNewTrain
end

function RoomCritterTrainView:_followTrainHero(heroId)
	if self.viewContainer:getContainerCurSelectTab() ~= RoomCritterBuildingViewContainer.SubViewTabId.Training then
		RoomCritterController.instance:setInteractionParam(nil)

		return
	end

	heroId = heroId or 0

	if self._lastFollowHeroId == heroId then
		return
	end

	local scene = RoomCameraController.instance:getRoomScene()

	if not scene then
		return
	end

	self._lastFollowHeroId = heroId

	local characterEntity = scene.charactermgr:getUnit(RoomCharacterEntity:getTag(), heroId)

	if characterEntity then
		local px, py, pz = transformhelper.getPos(characterEntity.goTrs)
		local cameraParam = {
			focusX = px,
			focusY = pz
		}

		scene.cameraFollow._offsetY = py

		local cameraState = RoomEnum.CameraState.ThirdPerson

		scene.camera:setChangeCameraParamsById(cameraState, RoomEnum.CameraParamId.CritterTrainHeroFollow)
		scene.camera:switchCameraState(cameraState, cameraParam, nil, self._onTweenCameraFollerMoveFinish, self)
		scene.cameraFollow:setFollowTarget(characterEntity.cameraFollowTargetComp, false)
		scene.cameraFollow:setIsPass(true)
		RoomCritterController.instance:setInteractionParam(self._lastFollowHeroId)
	else
		RoomCritterController.instance:setInteractionParam(nil)

		local curBuildingUid, curBuildingMO = self.viewContainer:getContainerViewBuilding()

		if not curBuildingMO then
			return
		end

		local buildingId = curBuildingMO.buildingId
		local cameraId = ManufactureConfig.instance:getBuildingCameraIdByIndex(buildingId, self.viewContainer:getContainerCurSelectTab())
		local roomCamera = RoomCameraController.instance:getRoomCamera()

		if roomCamera and cameraId then
			RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(curBuildingUid, cameraId)
		end
	end
end

function RoomCritterTrainView:_onTweenCameraFollerMoveFinish()
	if self.viewContainer:getContainerCurSelectTab() == RoomCritterBuildingViewContainer.SubViewTabId.Training then
		local scene = RoomCameraController.instance:getRoomScene()

		if scene then
			scene.cameraFollow:setIsPass(false)
		end
	end
end

return RoomCritterTrainView
