-- chunkname: @modules/logic/room/view/record/RoomCritterHandBookItem.lua

module("modules.logic.room.view.record.RoomCritterHandBookItem", package.seeall)

local RoomCritterHandBookItem = class("RoomCritterHandBookItem", ListScrollCellExtend)

function RoomCritterHandBookItem:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "empty")
	self._goshow = gohelper.findChild(self.viewGO, "show")
	self._gofront = gohelper.findChild(self.viewGO, "show/front")
	self._goback = gohelper.findChild(self.viewGO, "show/back")
	self._simagecritter = gohelper.findChildSingleImage(self.viewGO, "show/front/#simage_critter")
	self._imagecardbg = gohelper.findChildImage(self.viewGO, "show/front/#image_cardbg")
	self._simageutm = gohelper.findChildSingleImage(self.viewGO, "show/back/#simage_utm")
	self._gobackbgicon = gohelper.findChild(self.viewGO, "show/back/#simage_back/icon")
	self._gonew = gohelper.findChild(self.viewGO, "show/#go_new")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click", AudioEnum.Room.play_ui_home_firmup_close)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterHandBookItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClickBtn, self)
	self.addEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.refreshBack, self.refreshBack, self)
	self.addEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.reverseIcon, self.reverse, self)
	self.addEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.showMutate, self.refreshMutate, self)
end

function RoomCritterHandBookItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.refreshBack, self.refreshBack, self)
	self.removeEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.reverseIcon, self.reverse, self)
	self.removeEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.showMutate, self.refreshMutate, self)
end

function RoomCritterHandBookItem:_editableInitView()
	gohelper.setActive(self.viewGO, true)
end

function RoomCritterHandBookItem:_onClickBtn()
	self._view:selectCell(self._index, true)
	RoomHandBookModel.instance:setSelectMo(self._mo)

	if self._mo:checkNew() then
		CritterRpc.instance:sendMarkCritterBookNewReadRequest(self._id)
	end

	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.onClickHandBookItem, self._mo)
end

function RoomCritterHandBookItem:onUpdateMO(mo)
	self._mo = mo
	self._id = mo.id
	self._config = mo:getConfig()

	local isGot = mo:checkGotCritter()

	self._isreverse = mo:checkIsReverse()

	gohelper.setActive(self._goempty, not isGot)
	gohelper.setActive(self._goshow, isGot)
	gohelper.setActive(self._gonew, mo:checkNew())
	self:refreshUI()

	if self._isreverse ~= nil then
		if self._isreverse then
			self._animator:Play("empty", 0, 0)
		else
			self._animator:Play("show", 0, 0)
		end
	end
end

function RoomCritterHandBookItem:reverse()
	self._isreverse = self._mo:checkIsReverse()

	if self._isreverse then
		self._animator:Play("to_empty", 0, 0)
	else
		self._animator:Play("to_show", 0, 0)
	end
end

function RoomCritterHandBookItem:refreshUI()
	if self._mo:checkShowSpeicalSkin() then
		local co = lua_critter_skin.configDict[self._config.mutateSkin]

		if co then
			self._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(co.largeIcon), function()
				self._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, self)
		end
	else
		self._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(self._id), function()
			self._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, self)
	end

	local haveUtm = not not self._mo:getBackGroundId()

	gohelper.setActive(self._simageutm.gameObject, haveUtm)
	gohelper.setActive(self._gobackbgicon, not haveUtm)

	if haveUtm then
		self._simageutm:LoadImage(ResUrl.getPropItemIcon(self._mo:getBackGroundId()), function()
			self._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, self)
	end

	local typeid = self._config.catalogue
	local cardbg = lua_critter_catalogue.configDict[typeid].baseCard

	UISpriteSetMgr.instance:setCritterSprite(self._imagecardbg, cardbg)
end

function RoomCritterHandBookItem:refreshBack()
	local haveUtm = not not self._mo:getBackGroundId()

	gohelper.setActive(self._simageutm.gameObject, haveUtm)
	gohelper.setActive(self._gobackbgicon, not haveUtm)

	if haveUtm then
		self._simageutm:LoadImage(ResUrl.getPropItemIcon(self._mo:getBackGroundId()), function()
			self._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, self)
	end
end

function RoomCritterHandBookItem:refreshMutate(info)
	if info.id ~= self._mo.id then
		return
	end

	local UseSpecialSkin = info.UseSpecialSkin
	local showMutateBtn = self._mo:checkShowMutate()
	local config = self._mo:getConfig()

	if showMutateBtn then
		if UseSpecialSkin then
			local co = lua_critter_skin.configDict[config.mutateSkin]

			if co then
				self._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(co.largeIcon), function()
					self._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
				end, self)
			end
		else
			self._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(config.id), function()
				self._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, self)
		end
	end
end

function RoomCritterHandBookItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RoomCritterHandBookItem:onDestroyView()
	return
end

return RoomCritterHandBookItem
