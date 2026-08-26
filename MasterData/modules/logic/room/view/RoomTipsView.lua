-- chunkname: @modules/logic/room/view/RoomTipsView.lua

module("modules.logic.room.view.RoomTipsView", package.seeall)

local RoomTipsView = class("RoomTipsView", BaseView)

function RoomTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtname = gohelper.findChildText(self.viewGO, "container/title/#txt_name")
	self._gotitleLv = gohelper.findChild(self.viewGO, "container/title/#txt_name/#go_titleLv")
	self._txtlv = gohelper.findChildText(self.viewGO, "container/title/#txt_name/#go_titleLv/#txt_lv")
	self._txtnum = gohelper.findChildText(self.viewGO, "container/title/#txt_num")
	self._imageicon = gohelper.findChildImage(self.viewGO, "container/title/#image_icon")
	self._gocurrent = gohelper.findChild(self.viewGO, "container/#go_current")
	self._gocurrentitem = gohelper.findChild(self.viewGO, "container/#go_current/#go_currentitem")
	self._gonext = gohelper.findChild(self.viewGO, "container/#go_next")
	self._gonextline = gohelper.findChild(self.viewGO, "container/#go_next/#go_nextline")
	self._txtnextmaindesc = gohelper.findChildText(self.viewGO, "container/#go_next/next/nextmain/#txt_nextmaindesc")
	self._txtnextmainnum = gohelper.findChildText(self.viewGO, "container/#go_next/next/nextmain/#txt_nextmainnum")
	self._imagenextmain = gohelper.findChildImage(self.viewGO, "container/#go_next/next/nextmain/#txt_nextmainnum/resource/#image_nextmain")
	self._gonextsub = gohelper.findChild(self.viewGO, "container/#go_next/next/#go_nextsub")
	self._gonextsubitem = gohelper.findChild(self.viewGO, "container/#go_next/next/#go_nextsub/#go_nextsubitem")
	self._gosubline = gohelper.findChild(self.viewGO, "container/#go_next/next/#go_subline")
	self._goline = gohelper.findChild(self.viewGO, "container/tips/#go_line")
	self._txttipdesc = gohelper.findChildText(self.viewGO, "container/tips/#txt_tipdesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

RoomTipsView.ViewType = {
	Block = 3,
	PlanShare = 4,
	Character = 2,
	BuildDegree = 1
}

function RoomTipsView:_btncloseOnClick()
	self:closeThis()
end

function RoomTipsView:_editableInitView()
	gohelper.setActive(self._gocurrentitem, false)

	self._currentItemList = {}

	gohelper.setActive(self._gonextsubitem, false)

	self._nextItemList = {}
end

function RoomTipsView:_getOrCreateCurrentItemList(count)
	local list = {}

	for i = 1, count do
		local item = self._currentItemList[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._gocurrentitem, "item" .. tostring(i))
			item.txtdesc = gohelper.findChildText(item.go, "txt_desc")
			item.txtnum = gohelper.findChildText(item.go, "txt_num")
			item.goresourceitem = gohelper.findChild(item.go, "txt_num/resource/go_resourceitem")

			gohelper.setActive(item.goresourceitem, false)

			item.resourceItemList = {}

			table.insert(self._currentItemList, item)
		end

		gohelper.setActive(item.go, true)
		table.insert(list, item)
	end

	for i = count + 1, #self._currentItemList do
		local item = self._currentItemList[i]

		gohelper.setActive(item.go, false)
	end

	return list
end

function RoomTipsView:_getOrCreateNextSubItemList(count)
	local list = {}

	for i = 1, count do
		local item = self._nextItemList[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._gonextsubitem, "item" .. tostring(i))
			item.txtdesc = gohelper.findChildText(item.go, "txt_desc")
			item.txtnum = gohelper.findChildText(item.go, "txt_num")
			item.goresourceitem = gohelper.findChild(item.go, "txt_num/resource/go_resourceitem")

			gohelper.setActive(item.goresourceitem, false)

			item.resourceItemList = {}

			table.insert(self._nextItemList, item)
		end

		gohelper.setActive(item.go, true)
		table.insert(list, item)
	end

	for i = count + 1, #self._nextItemList do
		local item = self._nextItemList[i]

		gohelper.setActive(item.go, false)
	end

	return list
end

function RoomTipsView:_getOrCreateItemImageItemList(item, count)
	local list = {}

	for i = 1, count do
		local imageItem = item.resourceItemList[i]

		if not imageItem then
			imageItem = self:getUserDataTb_()
			imageItem.go = gohelper.cloneInPlace(item.goresourceitem, "item" .. tostring(i))
			imageItem.imageicon = gohelper.findChildImage(imageItem.go, "")

			table.insert(item.resourceItemList, imageItem)
		end

		gohelper.setActive(imageItem.go, true)
		table.insert(list, imageItem)
	end

	for i = count + 1, #item.resourceItemList do
		local imageItem = item.resourceItemList[i]

		gohelper.setActive(imageItem.go, false)
	end

	return list
end

function RoomTipsView:_refreshUI()
	if self._type == RoomTipsView.ViewType.BuildDegree then
		self:_refreshBuildDegreeUI()
	elseif self._type == RoomTipsView.ViewType.Character then
		self:_refreshCharacterUI()
	elseif self._type == RoomTipsView.ViewType.Block then
		self:_refreshBlockUI()
	elseif self._type == RoomTipsView.ViewType.PlanShare then
		self:_refreshPlanShareUI()
	end
end

function RoomTipsView:_refreshBuildDegreeUI()
	local buildDegree = RoomMapModel.instance:getAllBuildDegree()
	local characterAddLimit = RoomConfig.instance:getCharacterLimitAddByBuildDegree(buildDegree)
	local bonus, nextLevelNeed, curLevel = RoomConfig.instance:getBuildBonusByBuildDegree(buildDegree)
	local nextCharacterAddLimit = RoomConfig.instance:getCharacterLimitAddByBuildDegree(buildDegree + nextLevelNeed)
	local nextBonus = RoomConfig.instance:getBuildBonusByBuildDegree(buildDegree + nextLevelNeed)

	self._txtname.text = luaLang("room_topright_builddegree")

	gohelper.setActive(self._gotitleLv, true)

	self._txtlv.text = string.format("lv.%d", curLevel)
	self._txtnum.text = tostring(buildDegree)

	UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "jianshezhi")
	transformhelper.setLocalScale(self._imageicon.transform, 1, 1, 1)

	self._txttipdesc.text = luaLang("room_topright_builddegree_tips")

	gohelper.setActive(self._gocurrent, true)

	local currentItemList = self:_getOrCreateCurrentItemList(2)
	local currentItemResource = currentItemList[1]

	currentItemResource.txtdesc.text = luaLang("room_topright_builddegree_current_resource")
	currentItemResource.txtnum.text = string.format("+%.1f%%", bonus / 10)

	local currentItemResourceImageItemList = self:_getOrCreateItemImageItemList(currentItemResource, 2)
	local currentItemResourceImageItemCoin = currentItemResourceImageItemList[1]

	UISpriteSetMgr.instance:setCurrencyItemSprite(currentItemResourceImageItemCoin.imageicon, "203_1")

	local currentItemResourceImageItemExp = currentItemResourceImageItemList[2]

	UISpriteSetMgr.instance:setCurrencyItemSprite(currentItemResourceImageItemExp.imageicon, "205_1")

	local currentItemCharacter = currentItemList[2]

	currentItemCharacter.txtdesc.text = luaLang("room_topright_builddegree_current_character")
	currentItemCharacter.txtnum.text = tostring(characterAddLimit)

	local currentItemCharacterImageItem = self:_getOrCreateItemImageItemList(currentItemCharacter, 1)[1]

	UISpriteSetMgr.instance:setRoomSprite(currentItemCharacterImageItem.imageicon, "img_juese")
	gohelper.setActive(self._gonext, nextLevelNeed > 0)
	gohelper.setActive(self._gonextline, true)
	gohelper.setActive(self._goline, nextLevelNeed < 0)

	if nextLevelNeed > 0 then
		self._txtnextmaindesc.text = luaLang("room_topright_builddegree_next_title")
		self._txtnextmainnum.text = tostring(buildDegree + nextLevelNeed)

		gohelper.setActive(self._imagenextmain.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(self._imagenextmain, "jianshezhi")

		local nextItemList = self:_getOrCreateNextSubItemList(2)
		local nextItemResource = nextItemList[1]

		nextItemResource.txtdesc.text = luaLang("room_topright_builddegree_next_resource")
		nextItemResource.txtnum.text = string.format("+%.1f%%", nextBonus / 10)

		local nextItemResourceImageItemList = self:_getOrCreateItemImageItemList(nextItemResource, 2)
		local nextItemResourceImageItemCoin = nextItemResourceImageItemList[1]

		UISpriteSetMgr.instance:setCurrencyItemSprite(nextItemResourceImageItemCoin.imageicon, "203_1")

		local nextItemResourceImageItemExp = nextItemResourceImageItemList[2]

		UISpriteSetMgr.instance:setCurrencyItemSprite(nextItemResourceImageItemExp.imageicon, "205_1")

		local nextItemCharacter = nextItemList[2]

		nextItemCharacter.txtdesc.text = luaLang("room_topright_builddegree_next_character")
		nextItemCharacter.txtnum.text = tostring(nextCharacterAddLimit)

		local nextItemCharacterImageItem = self:_getOrCreateItemImageItemList(nextItemCharacter, 1)[1]

		UISpriteSetMgr.instance:setRoomSprite(nextItemCharacterImageItem.imageicon, "img_juese")
	end
end

function RoomTipsView:_refreshCharacterUI()
	local maxCharacterCount = RoomCharacterModel.instance:getMaxCharacterCount()
	local buildDegree = RoomMapModel.instance:getAllBuildDegree()
	local characterLimitAdd = RoomConfig.instance:getCharacterLimitAddByBuildDegree(buildDegree)
	local bonus, nextLevelNeed, curLevel = RoomConfig.instance:getBuildBonusByBuildDegree(buildDegree)
	local nextCharacterAddLimit = RoomConfig.instance:getCharacterLimitAddByBuildDegree(buildDegree + nextLevelNeed)

	self._txtname.text = luaLang("room_topright_character")

	gohelper.setActive(self._gotitleLv, false)

	self._txtnum.text = tostring(maxCharacterCount)

	UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "img_juese")

	local scale = 1.0666666666666667

	transformhelper.setLocalScale(self._imageicon.transform, scale, scale, scale)

	self._txttipdesc.text = luaLang("room_topright_character_tips")

	gohelper.setActive(self._gocurrent, false)
	gohelper.setActive(self._gonext, nextLevelNeed > 0)
	gohelper.setActive(self._gonextline, false)
	gohelper.setActive(self._goline, nextLevelNeed > 0)

	if nextLevelNeed > 0 then
		self._txtnextmaindesc.text = luaLang("room_topright_character_next_title")
		self._txtnextmainnum.text = tostring(buildDegree + nextLevelNeed)

		gohelper.setActive(self._imagenextmain.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(self._imagenextmain, "jianshezhi")

		local nextItem = self:_getOrCreateNextSubItemList(1)[1]

		nextItem.txtdesc.text = luaLang("room_topright_character_next_desc")
		nextItem.txtnum.text = tostring(nextCharacterAddLimit)

		local nextItemImageItem = self:_getOrCreateItemImageItemList(nextItem, 1)[1]

		UISpriteSetMgr.instance:setRoomSprite(nextItemImageItem.imageicon, "img_juese")
	end
end

function RoomTipsView:_refreshBlockUI()
	local roomLevel = RoomMapModel.instance:getRoomLevel()
	local maxBlockCount = RoomMapBlockModel.instance:getMaxBlockCount()
	local roomMaxLevel = RoomConfig.instance:getMaxRoomLevel()

	self._txtname.text = luaLang("room_topright_block")

	gohelper.setActive(self._gotitleLv, false)

	self._txtnum.text = tostring(maxBlockCount)

	UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "icon_zongkuai_light", true)
	transformhelper.setLocalScale(self._imageicon.transform, 0.8, 0.8, 0.8)

	self._txttipdesc.text = luaLang("room_topright_block_tips")

	gohelper.setActive(self._gocurrent, false)
	gohelper.setActive(self._gonext, roomLevel < roomMaxLevel)
	gohelper.setActive(self._gonextline, false)
	gohelper.setActive(self._goline, roomLevel < roomMaxLevel)

	if roomLevel < roomMaxLevel then
		local nextMaxBlockCount = RoomMapBlockModel.instance:getMaxBlockCount(roomLevel + 1)

		self._txtnextmaindesc.text = luaLang("room_topright_block_next_title")
		self._txtnextmainnum.text = string.format("lv.%d", roomLevel + 1)

		gohelper.setActive(self._imagenextmain.gameObject, false)

		local nextItem = self:_getOrCreateNextSubItemList(1)[1]

		nextItem.txtdesc.text = luaLang("room_topright_block_next_desc")
		nextItem.txtnum.text = tostring(nextMaxBlockCount)

		local nextItemImageItem = self:_getOrCreateItemImageItemList(nextItem, 1)[1]

		UISpriteSetMgr.instance:setRoomSprite(nextItemImageItem.imageicon, "icon_zongkuai_light", true)
	end
end

function RoomTipsView:_refreshPlanShareUI()
	self._txtname.text = luaLang("room_topright_plan_share_count_name")

	gohelper.setActive(self._gotitleLv, false)

	if self.viewParam then
		if not self.viewParam.shareCount then
			local shareCount = 0

			self._txtnum.text = tostring(shareCount)

			UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "room_layout_icon_redu", true)
			transformhelper.setLocalScale(self._imageicon.transform, 0.8, 0.8, 0.8)

			self._txttipdesc.text = luaLang("room_topright_plan_share_count_desc")

			gohelper.setActive(self._gocurrent, false)
			gohelper.setActive(self._gonext, false)
			gohelper.setActive(self._gonextline, false)
			gohelper.setActive(self._goline, false)
		end
	end
end

function RoomTipsView:onOpen()
	self._type = self.viewParam.type

	self:_refreshUI()
end

function RoomTipsView:onClose()
	return
end

function RoomTipsView:onDestroyView()
	return
end

return RoomTipsView
