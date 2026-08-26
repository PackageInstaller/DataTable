-- chunkname: @modules/logic/room/view/critter/detail/RoomCritterDetailYoungView.lua

module("modules.logic.room.view.critter.detail.RoomCritterDetailYoungView", package.seeall)

local RoomCritterDetailYoungView = class("RoomCritterDetailYoungView", RoomCritterDetailView)

function RoomCritterDetailYoungView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goyoung = gohelper.findChild(self.viewGO, "#go_young")
	self._scrollcritter = gohelper.findChildScrollRect(self.viewGO, "#go_young/#scroll_critter")
	self._gocritteritem = gohelper.findChild(self.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem")
	self._gocrittericon = gohelper.findChild(self.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem/#go_crittericon")
	self._godetail = gohelper.findChild(self.viewGO, "#go_young/Left/#go_detail")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_young/Left/#go_detail/#txt_name")
	self._imagelock = gohelper.findChildImage(self.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")
	self._imagesort = gohelper.findChildImage(self.viewGO, "#go_young/Left/#go_detail/#image_sort")
	self._txtsort = gohelper.findChildText(self.viewGO, "#go_young/Left/#go_detail/#image_sort/#txt_sort")
	self._txttag1 = gohelper.findChildText(self.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag1")
	self._txttag2 = gohelper.findChildText(self.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag2")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "#go_young/Left/#go_detail/#scroll_des")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_young/Left/#go_detail/#scroll_des/viewport/content/#txt_Desc")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "#go_young/Left/base/#scroll_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#go_young/Left/base/#scroll_base/viewport/content/#go_baseitem")
	self._btnattrclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_young/Left/base/basetips/#btn_attrclose")
	self._scrolltipbase = gohelper.findChildScrollRect(self.viewGO, "#go_young/Left/base/basetips/#scroll_base")
	self._gobasetipsitem = gohelper.findChild(self.viewGO, "#go_young/Left/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	self._scrollskill = gohelper.findChildScrollRect(self.viewGO, "#go_young/Left/skill/#scroll_skill")
	self._goskillItem = gohelper.findChild(self.viewGO, "#go_young/Left/skill/#scroll_skill/viewport/content/#go_skillItem")
	self._gocritterlive2d = gohelper.findChild(self.viewGO, "#go_young/Right/#go_critterlive2d")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gostar = gohelper.findChild(self.viewGO, "#go_young/Left/#go_detail/starList")
	self._gotipbase = gohelper.findChild(self.viewGO, "#go_young/Left/base/basetips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterDetailYoungView:addEvents()
	RoomCritterDetailYoungView.super.addEvents(self)
	self._btnattrclose:AddClickListener(self._btnattrcloseOnClick, self)
end

function RoomCritterDetailYoungView:removeEvents()
	RoomCritterDetailYoungView.super.removeEvents(self)
	self._btnattrclose:RemoveClickListener()
end

function RoomCritterDetailYoungView:_btnattrcloseOnClick()
	gohelper.setActive(self._gotipbase.gameObject, false)
end

function RoomCritterDetailYoungView:_btnLockOnClick()
	CritterRpc.instance:sendLockCritterRequest(self._critterMo.uid, not self._critterMo.lock, self.refreshLock, self)
end

function RoomCritterDetailYoungView:_editableInitView()
	RoomCritterDetailYoungView.super._editableInitView(self)

	self._goLock = gohelper.findChild(self.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")

	if self._goLock then
		local golockbtn = gohelper.findChild(self._goLock, "clickarea")

		self._lockbtn = SLFramework.UGUI.UIClickListener.Get(golockbtn)

		self._lockbtn:AddClickListener(self._btnLockOnClick, self)
	end
end

function RoomCritterDetailYoungView:onOpen()
	self._critterMo = self.viewParam.critterMo
	self._critterMoList = self.viewParam.critterMos

	if self._critterMoList then
		gohelper.setActive(self._scrollcritter.gameObject, true)

		self._selectCritterIndex = 1
		self._critterMo = self._critterMoList and self._critterMoList[self._selectCritterIndex]

		self:setCritter()
	else
		gohelper.setActive(self._scrollcritter.gameObject, false)
	end

	if not self._critterMo then
		return
	end

	gohelper.setActive(self._gobaseitem.gameObject, false)
	gohelper.setActive(self._goskillItem.gameObject, false)

	if self._goLock then
		gohelper.setActive(self._goLock.gameObject, not self.viewParam.isPreview)
	end

	self:onRefresh()
	self:initAttrInfo()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_open)
end

function RoomCritterDetailYoungView:onRefresh()
	self._critterMo = self._critterMoList and self._critterMoList and self._critterMoList[self._selectCritterIndex] or self.viewParam.critterMo

	RoomCritterDetailYoungView.super.onRefresh(self)
end

function RoomCritterDetailYoungView:setCritter()
	if not self._scrollcritter or not self._critterMoList then
		return
	end

	local count = #self._critterMoList

	for i = 1, count do
		local mo = self._critterMoList[i]
		local item = self:getCritterItem(i)

		item._critterIcon = item._critterIcon or IconMgr.instance:getCommonCritterIcon(item.critterGo)

		item._critterIcon:onUpdateMO(mo, true)
		item._critterIcon:hideMood()
		item._critterIcon:setSelectUIVisible(i == self._selectCritterIndex)
		item._critterIcon:onSelect(i == self._selectCritterIndex)
		item._critterIcon:setCustomClick(self._btnCritterOnClick, self, i)
		gohelper.setActive(item.line, i < count)
	end

	if self._critterItems then
		for i, item in ipairs(self._critterItems) do
			gohelper.setActive(item.go, i <= count)
		end
	end
end

function RoomCritterDetailYoungView:_btnCritterOnClick(index)
	self._selectCritterIndex = index

	if self._critterItems then
		for i, item in ipairs(self._critterItems) do
			item._critterIcon:setSelectUIVisible(i == self._selectCritterIndex)
			item._critterIcon:onSelect(i == self._selectCritterIndex)
		end
	end

	gohelper.setActive(self._gotipbase.gameObject, false)
	self:onRefresh()
end

function RoomCritterDetailYoungView:getCritterItem(index)
	self._critterItems = self._critterItems or self:getUserDataTb_()

	local item = self._critterItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gocritteritem)
		local critterGo = gohelper.findChild(go, "#go_crittericon")
		local line = gohelper.findChild(go, "line")

		item = {
			go = go,
			critterGo = critterGo,
			line = line
		}
		self._critterItems[index] = item
	end

	return item
end

function RoomCritterDetailYoungView:getAttrRatio(type, attrMo)
	if self.viewParam.isPreview then
		local defineId = self._critterMo:getDefineId()
		local mo = CritterIncubateModel.instance:getSelectParentCritterMoByid(defineId)

		if mo then
			local info = mo:getAttributeInfoByType(type)

			if info then
				local parentRatio = info:getRate()
				local childRatio = attrMo:getRate()
				local num = childRatio - parentRatio

				num = math.floor(num * 100) / 100

				if num == 0 then
					return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_attr_rate"), childRatio)
				else
					local lang = num > 0 and "room_preview_critter_attr_add_ratio" or "room_preview_critter_attr_reduce_ratio"

					return GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(lang), childRatio, num)
				end
			end
		end
	else
		return attrMo:getRateStr()
	end
end

return RoomCritterDetailYoungView
