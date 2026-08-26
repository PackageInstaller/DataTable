-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainDetailItem.lua

module("modules.logic.room.view.critter.RoomCritterTrainDetailItem", package.seeall)

local RoomCritterTrainDetailItem = class("RoomCritterTrainDetailItem", ListScrollCellExtend)

function RoomCritterTrainDetailItem:ctor(view)
	RoomCritterTrainDetailItem.super.ctor(self)

	if view then
		self._view = view
	end
end

function RoomCritterTrainDetailItem:onInitView()
	self._txttrainlevel = gohelper.findChildText(self.viewGO, "TrainProgress/#txt_trainlevel")
	self._imagetotalBarValue = gohelper.findChildImage(self.viewGO, "TrainProgress/ProgressBg/#image_totalBarValue")
	self._goeventpointitem = gohelper.findChild(self.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventpointitem")
	self._goeventtips = gohelper.findChild(self.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventtips")
	self._txteventtime = gohelper.findChildText(self.viewGO, "TrainProgress/ProgressBg/eventlayout/#go_eventtips/#txt_eventtime")
	self._gotrainTime = gohelper.findChild(self.viewGO, "TrainProgress/#go_trainTime")
	self._txttotalTrainTime = gohelper.findChildText(self.viewGO, "TrainProgress/#go_trainTime/#txt_totalTrainTime")
	self._btnaccelerate = gohelper.findChildButtonWithAudio(self.viewGO, "TrainProgress/#btn_accelerate")
	self._btntrainfinish = gohelper.findChildButtonWithAudio(self.viewGO, "TrainProgress/#btn_trainfinish")
	self._gotrainslotitem = gohelper.findChild(self.viewGO, "#go_trainslotitem")
	self._gocrittericon = gohelper.findChild(self.viewGO, "#go_trainslotitem/#go_critter_icon")
	self._simageheroIcon = gohelper.findChildSingleImage(self.viewGO, "#go_trainslotitem/#simage_heroIcon")
	self._btncritterchange = gohelper.findChildButtonWithAudio(self.viewGO, "#go_trainslotitem/#btn_critterchange")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txttrainingname = gohelper.findChildText(self.viewGO, "#go_info/#txt_trainingname")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "#go_info/#scroll_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/#txt_name")
	self._txtlevel = gohelper.findChildText(self.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_ratelevel/#txt_level")
	self._simagelevelBarValue = gohelper.findChildSingleImage(self.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_ratelevel/ProgressBg/#simage_levelBarValue")
	self._simagetotalBarValue = gohelper.findChildSingleImage(self.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_detail/ProgressBg/#simage_totalBarValue")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_info/#scroll_base/viewport/content/#go_baseitem/go_detail/#txt_num")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_switch")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_detail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainDetailItem:addEvents()
	self._btnaccelerate:AddClickListener(self._btnaccelerateOnClick, self)
	self._btntrainfinish:AddClickListener(self._btntrainfinishOnClick, self)
	self._btncritterchange:AddClickListener(self._btncritterchangeOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
end

function RoomCritterTrainDetailItem:removeEvents()
	self._btnaccelerate:RemoveClickListener()
	self._btntrainfinish:RemoveClickListener()
	self._btncritterchange:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	self._btndetail:RemoveClickListener()
end

function RoomCritterTrainDetailItem:_btnswitchOnClick()
	self._showLv = not self._showLv

	self:refreshAttributeItem()
end

function RoomCritterTrainDetailItem:_btnaccelerateOnClick()
	local critterMO = self._critterMO

	if critterMO then
		RoomCritterController.instance:openTrainAccelerateView(critterMO.uid)
	end
end

function RoomCritterTrainDetailItem:_btntrainfinishOnClick()
	local critterMO = self._critterMO

	if critterMO and critterMO.trainInfo then
		if critterMO.trainInfo:isFinishAllEvent() then
			RoomCritterController.instance:sendFinishTrainCritter(critterMO.id)
		else
			GameFacade.showToast(ToastEnum.RoomCritterTrainEventNotFinished)
			RoomCritterController.instance:openTrainEventView(critterMO.id)
		end
	end

	if self._finishCallback then
		if self._finishCallbackObj ~= nil then
			self._finishCallback(self._finishCallbackObj)
		else
			self._finishCallback()
		end
	end
end

function RoomCritterTrainDetailItem:_btncritterchangeOnClick()
	if self._critterchangeCallback then
		if self._critterchangeCallbackObj ~= nil then
			self._critterchangeCallback(self._critterchangeCallbackObj)
		else
			self._critterchangeCallback()
		end
	end
end

function RoomCritterTrainDetailItem:_btndetailOnClick()
	CritterController.instance:openRoomCritterDetailView(self._critterMO.finishTrain ~= true, self._critterMO, true)
end

function RoomCritterTrainDetailItem:_editableInitView()
	self._showStateInfo = true

	gohelper.setActive(self._gobaseitem, false)
	gohelper.setActive(self._goeventtips, false)
	gohelper.setActive(self._btncritterchange, false)

	self._gogrssBg = gohelper.findChild(self.viewGO, "TrainProgress/bg")
	self._gogressFinishBg = gohelper.findChild(self.viewGO, "TrainProgress/#go_finishbg")
	self._imageTrainBarValue = gohelper.findChildImage(self.viewGO, "TrainProgress/ProgressBg/#simage_totalBarValue")
	self._eventPointTbList = self:getUserDataTb_()
	self._attributeItems = {}
	self._showLv = false
	self._barTrs = self._imagetotalBarValue.transform
	self._goeventtipsTrs = self._goeventtips.transform

	table.insert(self._eventPointTbList, self:_createEventPointTB(self._goeventpointitem))
	self:setBarValue(0)
end

function RoomCritterTrainDetailItem:_editableAddEvents()
	RoomController.instance:registerCallback(RoomEvent.CritterTrainLevelFinished, self._onTrainResultFinished, self)
end

function RoomCritterTrainDetailItem:_editableRemoveEvents()
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainLevelFinished, self._onTrainResultFinished, self)
end

function RoomCritterTrainDetailItem:_onTrainResultFinished()
	self._showLv = true

	self:refreshAttributeItem()
end

function RoomCritterTrainDetailItem:onUpdateMO(mo)
	self._critterMO = mo
	self._critterId = mo and mo.id

	self:refreshUI()
end

function RoomCritterTrainDetailItem:onSelect(isSelect)
	return
end

function RoomCritterTrainDetailItem:onDestroyView()
	if self._attributeItems then
		for _, v in pairs(self._attributeItems) do
			v:destroy()
		end

		self._attributeItems = nil
	end

	if self._eventPointTbList then
		local tbList = self._eventPointTbList

		self._eventPointTbList = nil

		for i, tb in ipairs(tbList) do
			self:_disposeEventPointBT(tb)
		end
	end
end

function RoomCritterTrainDetailItem:setFinishCallback(callback, callbackObj)
	self._finishCallback = callback
	self._finishCallbackObj = callbackObj
end

function RoomCritterTrainDetailItem:setCritterChanageCallback(callback, callbackObj)
	self._critterchangeCallback = callback
	self._critterchangeCallbackObj = callbackObj

	if callback then
		gohelper.setActive(self._btncritterchange, true)
	else
		gohelper.setActive(self._btncritterchange, false)
	end
end

function RoomCritterTrainDetailItem:tranCdTimeUpdate()
	self:refreshTrainProgressUI()
end

function RoomCritterTrainDetailItem:refreshUI()
	self:refreshTrainProgressUI()
	self:refreshSlotUI()
	self:refreshAttributeItem()
end

function RoomCritterTrainDetailItem:setShowStateInfo(isShow)
	self._showStateInfo = not not isShow

	self:refreshTrainProgressUI()
end

function RoomCritterTrainDetailItem:refreshTrainProgressUI()
	local critterMO = self._critterMO

	if critterMO and critterMO.trainInfo then
		local trainInfo = critterMO.trainInfo
		local isTrainFinish = trainInfo:isTrainFinish()

		gohelper.setActive(self._btntrainfinish, self._showStateInfo and isTrainFinish)
		gohelper.setActive(self._gogressFinishBg, self._showStateInfo and isTrainFinish)
		gohelper.setActive(self._gogrssBg, not self._showStateInfo or not isTrainFinish)
		gohelper.setActive(self._gotrainTime, self._showStateInfo and not isTrainFinish)
		gohelper.setActive(self._btnaccelerate, self._showStateInfo and not isTrainFinish)
		self:setBarValue(trainInfo:getProcess())

		self._txttotalTrainTime.text = TimeUtil.second2TimeString(trainInfo:getCurCdTime(), true)

		self:refreshEventPointUI()
	end

	self:_refreshTipsUI()
end

function RoomCritterTrainDetailItem:setBarValue(value)
	self._barValue = value
	self._imagetotalBarValue.fillAmount = value
end

function RoomCritterTrainDetailItem:getBarValue(value)
	return self._barValue
end

function RoomCritterTrainDetailItem:_refreshTipsUI()
	if self._lookTrainInfoMO then
		local cdTime = self._lookEventTime - self._lookTrainInfoMO:getProcessTime()

		if cdTime < 0 or self._critterId ~= self._lookCritterId then
			gohelper.setActive(self._goeventtips, false)

			self._lookTrainInfoMO = nil
			self._lookCritterId = nil
		else
			self._txteventtime.text = TimeUtil.second2TimeString(cdTime, true)
		end
	end
end

function RoomCritterTrainDetailItem:refreshSlotUI()
	local critterMO = self._critterMO

	if critterMO then
		self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocrittericon)

		self.critterIcon:setMOValue(critterMO:getId(), critterMO:getDefineId())

		local heroMO = HeroModel.instance:getByHeroId(critterMO.trainInfo.heroId)

		if heroMO then
			::label_26_0::

			local skinConfig = SkinConfig.instance:getSkinCo(heroMO.skin)

			if skinConfig then
				self._simageheroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
			end

			self._txttrainingname.text = critterMO:getName()
		end
	end
end

function RoomCritterTrainDetailItem:refreshEventPointUI()
	if not self._eventPointTbList then
		return
	end

	local count = 0
	local critterMO = self._critterMO

	if critterMO and critterMO.trainInfo then
		local eventTimePoints = critterMO.trainInfo.eventTimePoints
		local trainTime = critterMO:getTainTime()
		local barWith = recthelper.getWidth(self._barTrs)

		for i = 1, #eventTimePoints do
			local eventTime = eventTimePoints[i]

			count = count + 1

			local tb = self._eventPointTbList[count]

			if not tb then
				local go = gohelper.cloneInPlace(self._goeventpointitem)

				tb = self:_createEventPointTB(go)

				table.insert(self._eventPointTbList, tb)
			end

			tb.roundIndex = count

			local anchorX = barWith * eventTime / trainTime

			self:_updateEventPointTB(tb, anchorX, eventTime, critterMO.trainInfo, critterMO.id)
		end
	end

	for i, tb in ipairs(self._eventPointTbList) do
		gohelper.setActive(tb.go, i <= count)
	end
end

function RoomCritterTrainDetailItem:refreshAttributeItem()
	local critterMO = self._critterMO

	if critterMO then
		for _, v in pairs(self._attributeItems) do
			v:hideItem()
		end

		local attrInfos = critterMO:getAttributeInfos()

		for i = 1, #attrInfos do
			if not self._attributeItems[i] then
				self._attributeItems[i] = RoomCritterTrainDetailItemAttributeItem.New()

				self._attributeItems[i]:init(self._gobaseitem)
			end

			self._attributeItems[i]:setShowLv(self._showLv)
			self._attributeItems[i]:refresh(attrInfos[i], critterMO)
		end
	end
end

function RoomCritterTrainDetailItem:playLevelUp(addAttributeMOs, isNotAddAttValue)
	local critterMO = self._critterMO

	if critterMO then
		for _, item in ipairs(self._attributeItems) do
			local needUp = false

			for i = 1, #addAttributeMOs do
				if item:getAttributeId() == addAttributeMOs[i].attributeId then
					needUp = true

					item:playLevelUp(addAttributeMOs[i], isNotAddAttValue)
				end
			end

			if not needUp then
				item:playNoLevelUp()
			end
		end
	end
end

function RoomCritterTrainDetailItem:playBarAdd(play, options)
	local critterMO = self._critterMO

	if critterMO then
		for _, item in ipairs(self._attributeItems) do
			if play then
				for i = 1, #options do
					if item:getAttributeId() == options[i].addAttriButes[1].attributeId then
						item:playBarAdd(play, options[i].addAttriButes[1])
					end
				end
			else
				item:playBarAdd(play)
			end
		end
	end
end

function RoomCritterTrainDetailItem:_updateEventPointTB(tb, anchorX, eventTime, trainInfoMO, critterId)
	tb.trainInfoMO = trainInfoMO
	tb.critterId = critterId
	tb.eventTime = eventTime

	local isActive = eventTime < trainInfoMO:getProcessTime()
	local isFinish = trainInfoMO:checkRoundFinish(tb.roundIndex, CritterEnum.EventType.ActiveTime)

	if tb.isLastActivie ~= isActive or tb.isLastFinish ~= isFinish then
		tb.isLastActivie = isActive
		tb.isLastFinish = isFinish

		gohelper.setActive(tb._gounactive, not isActive)
		gohelper.setActive(tb._gounfinish, isActive and not isFinish)
		gohelper.setActive(tb._gofinish, isActive and isFinish)
	end

	if tb.anchorX ~= anchorX then
		tb.anchorX = anchorX

		recthelper.setAnchorX(tb.goTrs, anchorX)
	end
end

function RoomCritterTrainDetailItem:_tbunactiveOnClick(tb)
	if self._lookCritterId == tb.critterId and self._lookEventTime == tb.eventTime then
		self._lookTrainInfoMO = nil
		self._lookCritterId = nil

		gohelper.setActive(self._goeventtips, false)

		return
	end

	self._lookTrainInfoMO = tb.trainInfoMO
	self._lookCritterId = tb.critterId
	self._lookEventTime = tb.eventTime

	recthelper.setAnchorX(self._goeventtipsTrs, tb.anchorX)
	gohelper.setActive(self._goeventtips, not tb.isLastActivie)
	self:_refreshTipsUI()
end

function RoomCritterTrainDetailItem:_createEventPointTB(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.goTrs = go.transform
	tb._gounfinish = gohelper.findChild(go, "unfinish")
	tb._gofinish = gohelper.findChild(go, "finished")
	tb._gounactive = gohelper.findChild(go, "unactive")
	tb._btnunactive = gohelper.findChildButtonWithAudio(go, "unactive")

	tb._btnunactive:AddClickListener(self._tbunactiveOnClick, self, tb)

	return tb
end

function RoomCritterTrainDetailItem:_disposeEventPointBT(tb)
	if tb then
		tb.go = nil
		tb.goTrs = nil
		tb._gounfinsh = nil
		tb._gofinish = nil

		if tb._btnunactive then
			tb._btnunactive:RemoveClickListener()
		end

		tb._btnunactive = nil
	end
end

function RoomCritterTrainDetailItem:getUserDataTb_()
	if self._view then
		return self._view:getUserDataTb_()
	end

	return {}
end

RoomCritterTrainDetailItem.prefabPath = "ui/viewres/room/critter/roomcrittertraindetailitem.prefab"

return RoomCritterTrainDetailItem
