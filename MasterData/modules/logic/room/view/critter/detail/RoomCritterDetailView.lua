-- chunkname: @modules/logic/room/view/critter/detail/RoomCritterDetailView.lua

module("modules.logic.room.view.critter.detail.RoomCritterDetailView", package.seeall)

local RoomCritterDetailView = class("RoomCritterDetailView", BaseView)

function RoomCritterDetailView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goyoung = gohelper.findChild(self.viewGO, "#go_young")
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
	self._scrolltipbase = gohelper.findChildScrollRect(self.viewGO, "#go_young/Left/base/basetips/#scroll_base")
	self._gobasetipsitem = gohelper.findChild(self.viewGO, "#go_young/Left/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	self._scrollskill = gohelper.findChildScrollRect(self.viewGO, "#go_young/Left/skill/#scroll_skill")
	self._goskillItem = gohelper.findChild(self.viewGO, "#go_young/Left/skill/#scroll_skill/viewport/content/#go_skillItem")
	self._gocritterlive2d = gohelper.findChild(self.viewGO, "#go_young/Right/#go_critterlive2d")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gostar = gohelper.findChild(self.viewGO, "#go_young/Left/#go_detail/starList")
	self._gotipbase = gohelper.findChild(self.viewGO, "#go_young/Left/base/basetips")
	self._goLock = gohelper.findChild(self.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterDetailView:addEvents()
	return
end

function RoomCritterDetailView:removeEvents()
	if self._lockbtn then
		self._lockbtn:RemoveClickListener()
	end
end

function RoomCritterDetailView:_btnLockOnClick()
	CritterRpc.instance:sendLockCritterRequest(self._critterMo.uid, not self._critterMo.lock, self.refreshLock, self)
end

function RoomCritterDetailView:_editableInitView()
	if self._goLock then
		local golockbtn = gohelper.findChild(self._goLock, "clickarea")

		self._lockbtn = SLFramework.UGUI.UIClickListener.Get(golockbtn)

		self._lockbtn:AddClickListener(self._btnLockOnClick, self)
	end

	self._starItem = self:getUserDataTb_()

	if self._gostar then
		for i = 1, self._gostar.transform.childCount do
			self._starItem[i] = gohelper.findChild(self._gostar, "star" .. i)
		end
	end
end

function RoomCritterDetailView:onOpen()
	self._critterMo = self.viewParam.critterMo

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
end

function RoomCritterDetailView:onRefresh()
	if not self._critterMo then
		return
	end

	self:refreshLock()
	self:showInfo()
	self:refrshCritterSpine()
	self:refreshAttrInfo()
end

function RoomCritterDetailView:onClickModalMask()
	self:closeThis()
end

function RoomCritterDetailView:showInfo()
	if not self._critterMo then
		return
	end

	self._txtname.text = self._critterMo:getName()
	self._txtsort.text = self._critterMo:getCatalogueName()
	self._txtDesc.text = self._critterMo:getDesc()

	local isMaturity = self._critterMo:isMaturity()
	local ageTxt = isMaturity and "room_critter_adult" or "room_critter_child"

	self._txttag1.text = luaLang(ageTxt)

	local isMutate = self._critterMo:isMutate()

	gohelper.setActive(self._txttag2.gameObject, isMutate)

	local rare = self._critterMo:getDefineCfg().rare

	for i, item in ipairs(self._starItem) do
		gohelper.setActive(item, i <= rare + 1)
	end

	self:showAttr()
	self:showSkill()
end

function RoomCritterDetailView:showAttr()
	local attrInfos = self._critterMo:getAttributeInfos()

	self._attrItems = self._attrItems or self:getUserDataTb_()

	local index = 1

	if attrInfos then
		for type, mo in pairs(attrInfos) do
			local item = self:getAttrItem(index)
			local normal, add = self:getAttrRatioColor()

			item:setRatioColor(normal, add)
			item:onRefreshMo(mo, index, self:getAttrNum(type, mo), self:getAttrRatio(type, mo), self:getAttrName(type, mo), self.attrOnClick, self)

			index = index + 1
		end
	end

	for i = 1, #self._attrItems do
		gohelper.setActive(self._attrItems[i].viewGO, i < index)
	end
end

function RoomCritterDetailView:getAttrNum(type, attrMo)
	return attrMo:getValueNum()
end

function RoomCritterDetailView:getAttrRatio(type, attrMo)
	return attrMo:getRateStr()
end

function RoomCritterDetailView:getAttrName(type, attrMo)
	return attrMo:getName()
end

function RoomCritterDetailView:getAttrItem(index)
	local item = self._attrItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gobaseitem)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterDetailAttrItem)
		self._attrItems[index] = item
	end

	return item
end

function RoomCritterDetailView:showSkill()
	local skillInfo = self._critterMo:getSkillInfo()

	self._skillItems = self._skillItems or self:getUserDataTb_()

	local index = 1

	if skillInfo then
		for _, tag in pairs(skillInfo) do
			local tagCo = CritterConfig.instance:getCritterTagCfg(tag)

			if tagCo and tagCo.type == RoomCritterDetailView._exclusiveSkill then
				local item = self:getSkillItem(index)

				item:onRefreshMo(tagCo, index)

				index = index + 1
			end
		end
	end

	if self._skillItems then
		for i = 1, #self._skillItems do
			gohelper.setActive(self._skillItems[i].viewGO, i < index)
		end
	end
end

function RoomCritterDetailView:getSkillItem(index)
	local item = self._skillItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goskillItem)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterDetailSkillItem)
		self._skillItems[index] = item
	end

	return item
end

function RoomCritterDetailView:refreshLock()
	if not self.viewParam.isPreview then
		local icon = self._critterMo:isLock() and "xinxiang_suo" or "xinxiang_jiesuo"

		UISpriteSetMgr.instance:setEquipSprite(self._imagelock, icon, false)
	end
end

function RoomCritterDetailView:getAttrRatioColor()
	return "#CAC8C5", "#FFAE46"
end

function RoomCritterDetailView:initAttrInfo()
	gohelper.setActive(self._gotipbase.gameObject, false)
	self:refreshAttrInfo()
end

function RoomCritterDetailView:refreshAttrInfo()
	local attrInfos = self._critterMo:getAttributeInfos()

	self._tipAttrItems = self._tipAttrItems or self:getUserDataTb_()

	local index = 1

	if attrInfos then
		for type, mo in pairs(attrInfos) do
			if mo:getIsAddition() then
				local item = self:getTipAttrItem(index)

				if item then
					self:setAttrTipText(item, mo)

					if item.icon and not string.nilorempty(mo:getIcon()) then
						UISpriteSetMgr.instance:setCritterSprite(item.icon, mo:getIcon())
					end
				end

				index = index + 1
			end
		end
	end

	for i = 1, #self._tipAttrItems do
		gohelper.setActive(self._tipAttrItems[i].go, i < index)
	end
end

function RoomCritterDetailView:setAttrTipText(item, mo)
	if item.nametxt then
		item.nametxt.text = mo:getName()
	end

	if item.uptxt then
		item.uptxt.text = mo:getaddRateStr()
	end

	if item.numtxt then
		item.numtxt.text = mo:getValueNum()
	end

	if item.ratiotxt then
		item.ratiotxt.text = mo:getRateStr()
	end
end

function RoomCritterDetailView:attrOnClick()
	gohelper.setActive(self._gotipbase.gameObject, true)
end

function RoomCritterDetailView:getTipAttrItem(index)
	local item = self._tipAttrItems[index]

	if not item then
		item = {}

		local go = gohelper.cloneInPlace(self._gobasetipsitem)

		item.nametxt = gohelper.findChildText(go, "#txt_name")
		item.uptxt = gohelper.findChildText(go, "#txt_up")
		item.icon = gohelper.findChildImage(go, "#txt_name/#image_icon")
		item.ratiotxt = gohelper.findChildText(go, "#txt_ratio")
		item.numtxt = gohelper.findChildText(go, "#txt_num")
		item.go = go
		self._tipAttrItems[index] = item
	end

	return item
end

function RoomCritterDetailView:refrshCritterSpine()
	self.bigSpine = self.bigSpine or MonoHelper.addNoUpdateLuaComOnceToGo(self._gocritterlive2d, RoomCritterUISpine)

	self.bigSpine:setResPath(self._critterMo)
end

function RoomCritterDetailView:onClose()
	return
end

function RoomCritterDetailView:onDestroyView()
	return
end

RoomCritterDetailView._exclusiveSkill = CritterEnum.SkilTagType.Race

return RoomCritterDetailView
