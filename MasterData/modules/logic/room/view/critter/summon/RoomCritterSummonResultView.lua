-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonResultView.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonResultView", package.seeall)

local RoomCritterSummonResultView = class("RoomCritterSummonResultView", BaseView)

function RoomCritterSummonResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtclose = gohelper.findChildText(self.viewGO, "#btn_close/#txt_close")
	self._goposcontent = gohelper.findChild(self.viewGO, "#go_pos_content")
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._goegg = gohelper.findChild(self.viewGO, "#go_item/#go_egg")
	self._gocritter = gohelper.findChild(self.viewGO, "#go_item/#go_critter")
	self._imagequality = gohelper.findChildImage(self.viewGO, "#go_item/#go_critter/#image_quality")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_item/#go_critter/#simage_icon")
	self._btnopenEgg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_item/#btn_openEgg")
	self._btnopenall = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_openall")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#btn_skip/#image_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterSummonResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnopenEgg:AddClickListener(self._btnopenEggOnClick, self)
	self._btnopenall:AddClickListener(self._btnopenallOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function RoomCritterSummonResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnopenEgg:RemoveClickListener()
	self._btnopenall:RemoveClickListener()
	self._btnskip:RemoveClickListener()
end

function RoomCritterSummonResultView:_btnskipOnClick()
	self:_setAllOpen(true)
	self:_refreshUI()
end

function RoomCritterSummonResultView:_btnopenallOnClick()
	local moList = self:_findNotOpenMOList()

	if moList and #moList > 0 then
		local param = {
			mode = RoomSummonEnum.SummonType.Summon,
			critterMo = moList[1],
			critterMOList = moList
		}

		CritterSummonController.instance:openSummonGetCritterView(param, true)
		self:_setAllOpen()
	end
end

function RoomCritterSummonResultView:_btncloseOnClick()
	if self:isAllOpen() then
		self:closeThis()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewRefreshCamera)
		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onCloseGetCritter)
	end
end

function RoomCritterSummonResultView:_btnopenEggOnClick()
	return
end

function RoomCritterSummonResultView:_editableInitView()
	self._itemCompList = {}

	for i = 1, 10 do
		local parentGO = gohelper.findChild(self._goposcontent, "go_pos" .. i)
		local childGO = gohelper.clone(self._goitem, parentGO)
		local itemComp = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, RoomCritterSummonResultItem)

		itemComp._view = self
		self._itemCompList[i] = itemComp
	end

	gohelper.setActive(self._goitem)
end

function RoomCritterSummonResultView:onUpdateParam()
	return
end

function RoomCritterSummonResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_obtain)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onOpenCloseView, self)

	local critterMOList = {}

	if self.viewParam and self.viewParam.critterMOList then
		tabletool.addValues(critterMOList, self.viewParam.critterMOList)
	end

	self._critterMOList = critterMOList

	self:_refreshCritterUI()
	self:_refreshUI()
end

function RoomCritterSummonResultView:onClose()
	return
end

function RoomCritterSummonResultView:_onOpenCloseView()
	local isOpen = ViewMgr.instance:isOpen(ViewName.RoomGetCritterView)

	if self._lastIsOpen ~= isOpen then
		self._lastIsOpen = isOpen

		self:_refreshUI()

		if not isOpen then
			local hasOpen = false

			for i = 1, #self._itemCompList do
				local comp = self._itemCompList[i]

				if comp.critterMO then
					local isOpenEgg = comp:isOpenEgg()

					if comp:playAnim(isOpenEgg) then
						hasOpen = true
					end
				end
			end

			if hasOpen then
				AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_shilian1)
			end
		end
	end
end

function RoomCritterSummonResultView:_refreshUI()
	local isAllOpen = self:isAllOpen()

	gohelper.setActive(self._txtclose, isAllOpen)
	gohelper.setActive(self._btnopenall, not isAllOpen)
	gohelper.setActive(self._btnskip, not isAllOpen)
end

function RoomCritterSummonResultView:_refreshCritterUI()
	for i = 1, #self._itemCompList do
		self._itemCompList[i]:onUpdateMO(self._critterMOList[i])
	end
end

function RoomCritterSummonResultView:isAllOpen()
	for i = 1, #self._itemCompList do
		if not self._itemCompList[i]:isOpenEgg() and self._critterMOList[i] then
			return false
		end
	end

	return true
end

function RoomCritterSummonResultView:_findNotOpenMOList(isSetCompOpen)
	local moList

	for i = 1, #self._itemCompList do
		if not self._itemCompList[i]:isOpenEgg() and self._critterMOList[i] then
			moList = moList or {}

			table.insert(moList, self._critterMOList[i])
		end
	end

	return moList
end

function RoomCritterSummonResultView:_setAllOpen(isPlayAnim)
	local hasOpen = false

	for i = 1, #self._itemCompList do
		if self._critterMOList[i] then
			local comp = self._itemCompList[i]

			comp:setOpenEgg(true)

			if isPlayAnim and comp:playAnim(true) then
				hasOpen = true
			end
		end
	end

	if hasOpen then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_shilian1)
	end
end

function RoomCritterSummonResultView:onDestroyView()
	for _, itemComp in ipairs(self._itemCompList) do
		itemComp:onDestroy()
	end
end

return RoomCritterSummonResultView
