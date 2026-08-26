-- chunkname: @modules/logic/room/view/record/RoomCritterHandBookView.lua

module("modules.logic.room.view.record.RoomCritterHandBookView", package.seeall)

local RoomCritterHandBookView = class("RoomCritterHandBookView", BaseView)

function RoomCritterHandBookView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_view")
	self._btnleftreverse = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_reverse")
	self._goleftbtnback = gohelper.findChild(self.viewGO, "left/#btn_reverse/back")
	self._goleftbtnfront = gohelper.findChild(self.viewGO, "left/#btn_reverse/front")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "left/#txt_collectionnum")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goshow = gohelper.findChild(self.viewGO, "right/show")
	self._goempty = gohelper.findChild(self.viewGO, "right/empty")
	self._gobtnmutate = gohelper.findChild(self.viewGO, "right/show/btnbg")
	self._btnmutate = gohelper.findChildButtonWithAudio(self.viewGO, "right/show/btnbg/#btn_mutate")
	self._goshowmutate = gohelper.findChild(self.viewGO, "right/show/btnbg/#btn_mutate/selected")
	self._gohidemutate = gohelper.findChild(self.viewGO, "right/show/btnbg/#btn_mutate/unselet")
	self._btnyoung = gohelper.findChildButtonWithAudio(self.viewGO, "right/show/btnbg/#btn_young")
	self._goshowyoung = gohelper.findChild(self.viewGO, "right/show/btnbg/#btn_young/selected")
	self._gohideyoung = gohelper.findChild(self.viewGO, "right/show/btnbg/#btn_young/unselect")
	self._btnrightbtn = gohelper.findChildButtonWithAudio(self.viewGO, "right/show/#btn_reverse")
	self._goreversereddot = gohelper.findChild(self.viewGO, "right/show/#btn_reverse/#go_reversereddot")
	self._gofront = gohelper.findChild(self.viewGO, "right/show/front")
	self._goback = gohelper.findChild(self.viewGO, "right/show/back")
	self._imagecardbg = gohelper.findChildImage(self.viewGO, "right/show/front/#image_cardbg")
	self._simagecritter = gohelper.findChildSingleImage(self.viewGO, "right/show/front/#simage_critter")
	self._gobackbgicon = gohelper.findChild(self.viewGO, "right/show/back/#simage_back/icon")
	self._simageutm = gohelper.findChildSingleImage(self.viewGO, "right/show/back/#simage_utm")
	self._txtcrittername = gohelper.findChildText(self.viewGO, "right/show/#txt_crittername")
	self._txtcrittertype = gohelper.findChildText(self.viewGO, "right/show/#txt_crittername/#txt_crittertype")
	self._imagerelationship = gohelper.findChildImage(self.viewGO, "right/legend/layout/scroll/#simage_critter")
	self._txtreleationship = gohelper.findChildText(self.viewGO, "right/legend/layout/scroll/Viewport/Content/relationship/#txt_releationship")
	self._txtlegend = gohelper.findChildText(self.viewGO, "right/legend/layout/scroll2/Viewport/Content/#txt_legend")
	self._golengendempty = gohelper.findChild(self.viewGO, "right/legend/#go_legendempty")
	self._goscrolllegend = gohelper.findChild(self.viewGO, "right/legend/layout")
	self._goscrollrelationship = gohelper.findChild(self.viewGO, "right/legend/layout/scroll")
	self._goscroll2 = gohelper.findChild(self.viewGO, "right/legend/layout/scroll2")
	self._btnlog = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_log")
	self._gologreddot = gohelper.findChild(self.viewGO, "#btn_log/reddot")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "#btn_task/#go_taskreddot")
	self._rightanimator = self._goright:GetComponent(typeof(UnityEngine.Animator))
	self._btnanimator = self._btnleftreverse.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._gofoods = {}
	self._mo = nil
	self._scrollview = self.viewContainer:getHandBookScrollView()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterHandBookView:addEvents()
	self._btnleftreverse:AddClickListener(self._btnleftreverseOnClick, self)
	self._btnrightbtn:AddClickListener(self._btnrightbtnOnClick, self)
	self._btnmutate:AddClickListener(self._btnmutateOnClick, self)
	self._btnyoung:AddClickListener(self._btnyoungOnClick, self)
	self._btnlog:AddClickListener(self._btnlogOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.onClickHandBookItem, self.updateView, self)
	self.addEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.refreshBack, self.refreshBack, self)
	self.addEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.showMutate, self.refreshMutate, self)
end

function RoomCritterHandBookView:removeEvents()
	self._btnleftreverse:RemoveClickListener()
	self._btnrightbtn:RemoveClickListener()
	self._btnmutate:RemoveClickListener()
	self._btnyoung:RemoveClickListener()
	self._btnlog:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self.removeEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.onClickHandBookItem, self.updateView, self)
	self.removeEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.refreshBack, self.refreshBack, self)
	self.removeEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.showMutate, self.refreshMutate, self)
end

function RoomCritterHandBookView:_btnlogOnClick()
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.HandBook2Log,
		view = RoomRecordEnum.View.Log
	})
end

function RoomCritterHandBookView:_btntaskOnClick()
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.HandBook2Task,
		view = RoomRecordEnum.View.Task
	})
end

function RoomCritterHandBookView:_btnleftreverseOnClick()
	RoomHandBookModel.instance:setScrollReverse()
	self:reverseIcon()

	self._isreverse = RoomHandBookModel.instance:getReverse()

	gohelper.setActive(self._goleftbtnback, self._isreverse)
	gohelper.setActive(self._goleftbtnfront, not self._isreverse)

	if self._isreverse then
		self._btnanimator:Play("to_front", 0, 0)
		TaskDispatcher.runDelay(self.reverseAnim, self, RoomRecordEnum.AnimTime)
	else
		self._btnanimator:Play("to_back", 0, 0)
		TaskDispatcher.runDelay(self.reverseAnim, self, RoomRecordEnum.AnimTime)
	end
end

function RoomCritterHandBookView:reverseAnim()
	TaskDispatcher.cancelTask(self.reverseAnim, self)

	if self._isreverse then
		self._btnanimator:Play("to_back", 0, 0)
	else
		self._btnanimator:Play("to_front", 0, 0)
	end
end

function RoomCritterHandBookView:_btnrightbtnOnClick()
	ViewMgr.instance:openView(ViewName.RoomCritterHandBookBackView)
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.Newstriker, false)
end

function RoomCritterHandBookView:_btnmutateOnClick()
	local mo = RoomHandBookModel.instance:getSelectMo()

	CritterRpc.instance:sendSetCritterBookUseSpecialSkinRequest(mo.id, true)
end

function RoomCritterHandBookView:_btnyoungOnClick()
	local mo = RoomHandBookModel.instance:getSelectMo()

	CritterRpc.instance:sendSetCritterBookUseSpecialSkinRequest(mo.id, false)
end

function RoomCritterHandBookView:_editableInitView()
	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "right/show/food/item" .. i)
		item.simage = gohelper.findChildSingleImage(item.go, "#simage_icon")

		gohelper.setActive(item.go, false)
		table.insert(self._gofoods, item)
	end
end

function RoomCritterHandBookView:updateView(itemMo)
	if self._mo ~= itemMo then
		self._rightanimator:Play("switch", 0, 0)
	end

	self._mo = itemMo and itemMo or RoomHandBookModel.instance:getSelectMo()
	self._isSpecial = self._mo.UseSpecialSkin

	local isget = self._mo:checkGotCritter()
	local config = self._mo:getConfig()

	gohelper.setActive(self._goshow, isget)
	gohelper.setActive(self._goempty, not isget)

	if isget then
		self._simagecritter:LoadImage(ResUrl.getCritterLargeIcon(config.id), function()
			self._simagecritter:GetComponent(gohelper.Type_Image):SetNativeSize()
		end, self)
	end

	if isget then
		self._txtcrittername.text = config.name or ""
	end

	local typeid = config.catalogue
	local typename = lua_critter_catalogue.configDict[typeid].name
	local cardbg = lua_critter_catalogue.configDict[typeid].baseCard

	UISpriteSetMgr.instance:setCritterSprite(self._imagecardbg, cardbg)

	self._txtcrittertype.text = isget and typename or ""

	local showMutateBtn = self._mo:checkShowMutate()

	gohelper.setActive(self._gobtnmutate, showMutateBtn)

	if showMutateBtn then
		gohelper.setActive(self._btnmutate.gameObject, not self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._btnyoung.gameObject, self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._goshowmutate, not self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._gohidemutate, self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._goshowyoung, self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._gohideyoung, not self._mo:checkShowSpeicalSkin())
	end

	if self._mo:checkShowSpeicalSkin() then
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

	self:refreshLikeFood(self._mo)
	self:refreshLegend(self._mo)

	local utmbg = self._mo:getBackGroundId()
	local havebg = utmbg and utmbg ~= 0

	gohelper.setActive(self._simageutm.gameObject, havebg)
	gohelper.setActive(self._gobackbgicon, not havebg)

	if utmbg and utmbg ~= 0 then
		self._simageutm:LoadImage(ResUrl.getPropItemIcon(self._mo:getBackGroundId()), function()
			self._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
		end)
	end

	local haveNum = RoomHandBookModel.instance:getCount()
	local allNum = CritterConfig.instance:getCritterCount()

	self._txtcollectionnum.text = string.format("<color=#cd5200>%s</color>/%s", haveNum, allNum)
end

function RoomCritterHandBookView:refreshLikeFood(mo)
	local config = mo:getConfig()

	if not config or string.nilorempty(config.foodLike) or not mo:checkGotCritter() then
		for i = 1, #self._gofoods do
			gohelper.setActive(self._gofoods[i].go, false)
		end

		return
	end

	local tempList = GameUtil.splitString2(config.foodLike)
	local likefood = {}

	for _, food in ipairs(tempList) do
		local foodId = food[1]

		table.insert(likefood, foodId)
	end

	for i = 1, #likefood do
		local item = self._gofoods[i]
		local path = ItemConfig.instance:getItemCo(tonumber(likefood[i])).icon

		item.simage:LoadImage(ResUrl.getPropItemIcon(path))
		gohelper.setActive(item.go, true)
	end

	for i = #self._gofoods, #likefood + 1, -1 do
		gohelper.setActive(self._gofoods[i].go, false)
	end
end

function RoomCritterHandBookView:refreshLegend(mo)
	local hideHeight = 446
	local showHeight = 264
	local config = mo:getConfig()
	local show = true

	show = config and mo:checkGotCritter() or false

	gohelper.setActive(self._golengendempty, not show)
	gohelper.setActive(self._goscrolllegend, show)

	if string.nilorempty(config.line) then
		gohelper.setActive(self._goscrollrelationship.gameObject, false)
		recthelper.setHeight(self._goscroll2.transform, hideHeight)
	else
		gohelper.setActive(self._goscrollrelationship.gameObject, true)

		self._txtreleationship.text = config.line

		recthelper.setHeight(self._goscroll2.transform, showHeight)
	end

	self._txtlegend.text = config.story

	if not string.nilorempty(config.relation) then
		local str = "room_handbook_relationship" .. config.relation

		UISpriteSetMgr.instance:setCritterSprite(self._imagerelationship, str)
	end
end

function RoomCritterHandBookView:reverseIcon()
	local isreverse = RoomHandBookModel.instance:getReverse()
	local mo = RoomHandBookModel.instance:getSelectMo()

	gohelper.setActive(self._gofront, not isreverse)
	gohelper.setActive(self._goback, isreverse)
	gohelper.setActive(self._goleftbtnback, not isreverse)
	gohelper.setActive(self._goleftbtnfront, isreverse)

	if isreverse then
		local haveUtm = not not mo:getBackGroundId()

		gohelper.setActive(self._simageutm.gameObject, haveUtm)

		if haveUtm then
			self._simageutm:LoadImage(ResUrl.getPropItemIcon(mo:getBackGroundId()), function()
				self._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, self)
		end

		gohelper.setActive(self._gobackbgicon, not haveUtm)
	end
end

function RoomCritterHandBookView:refreshBack()
	local isreverse = RoomHandBookModel.instance:getReverse()
	local mo = RoomHandBookModel.instance:getSelectMo()

	if isreverse then
		local haveUtm = not not mo:getBackGroundId()

		gohelper.setActive(self._simageutm.gameObject, haveUtm)

		if haveUtm then
			self._simageutm:LoadImage(ResUrl.getPropItemIcon(mo:getBackGroundId()), function()
				self._simageutm:GetComponent(gohelper.Type_Image):SetNativeSize()
			end, self)
		end

		gohelper.setActive(self._gobackbgicon, not haveUtm)
	end
end

function RoomCritterHandBookView:refreshMutate(info)
	local UseSpecialSkin = info.UseSpecialSkin
	local showMutateBtn = self._mo:checkShowMutate()
	local config = self._mo:getConfig()

	if showMutateBtn then
		gohelper.setActive(self._btnmutate.gameObject, not self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._btnyoung.gameObject, self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._goshowmutate, not self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._gohidemutate, self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._goshowyoung, self._mo:checkShowSpeicalSkin())
		gohelper.setActive(self._gohideyoung, not self._mo:checkShowSpeicalSkin())
	end

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

function RoomCritterHandBookView:onOpen()
	RoomHandBookListModel.instance:init()
	self._scrollview:selectCell(1, true)
	gohelper.setActive(self._gofront, true)
	gohelper.setActive(self._goback, false)
	self:updateView()
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.TradeTask)
	RedDotController.instance:addRedDot(self._gologreddot, RedDotEnum.DotNode.CritterLog)
	RedDotController.instance:addRedDot(self._goreversereddot, RedDotEnum.DotNode.Newstriker)
end

function RoomCritterHandBookView:onClose()
	TaskDispatcher.cancelTask(self.reverseAnim, self)
end

function RoomCritterHandBookView:onDestroyView()
	return
end

return RoomCritterHandBookView
