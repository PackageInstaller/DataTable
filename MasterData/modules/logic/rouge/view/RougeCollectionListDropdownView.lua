-- chunkname: @modules/logic/rouge/view/RougeCollectionListDropdownView.lua

module("modules.logic.rouge.view.RougeCollectionListDropdownView", package.seeall)

local RougeCollectionListDropdownView = class("RougeCollectionListDropdownView", BaseView)

function RougeCollectionListDropdownView:onInitView()
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/#btn_block")
	self._btnhole1 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/bottom/#btn_hole1")
	self._btnunequip1 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/bottom/#btn_hole1/#btn_unequip1")
	self._goempty1 = gohelper.findChild(self.viewGO, "Right/#go_normal/bottom/#btn_hole1/#go_empty1")
	self._goarrow1 = gohelper.findChild(self.viewGO, "Right/#go_normal/bottom/#btn_hole1/#go_empty1/#go_arrow1")
	self._simageruanpan1 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_normal/bottom/#btn_hole1/#simage_ruanpan1")
	self._btnhole2 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/bottom/#btn_hole2")
	self._btnunequip2 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/bottom/#btn_hole2/#btn_unequip2")
	self._goempty2 = gohelper.findChild(self.viewGO, "Right/#go_normal/bottom/#btn_hole2/#go_empty2")
	self._goarrow2 = gohelper.findChild(self.viewGO, "Right/#go_normal/bottom/#btn_hole2/#go_empty2/#go_arrow2")
	self._simageruanpan2 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_normal/bottom/#btn_hole2/#simage_ruanpan2")
	self._btnhole3 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/bottom/#btn_hole3")
	self._btnunequip3 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/bottom/#btn_hole3/#btn_unequip3")
	self._goempty3 = gohelper.findChild(self.viewGO, "Right/#go_normal/bottom/#btn_hole3/#go_empty3")
	self._goarrow3 = gohelper.findChild(self.viewGO, "Right/#go_normal/bottom/#btn_hole3/#go_empty3/#go_arrow3")
	self._simageruanpan3 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_normal/bottom/#btn_hole3/#simage_ruanpan3")
	self._scrollcollectiondesc = gohelper.findChildScrollRect(self.viewGO, "Right/#go_normal/#scroll_collectiondesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionListDropdownView:addEvents()
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnhole1:AddClickListener(self._btnhole1OnClick, self)
	self._btnunequip1:AddClickListener(self._btnunequip1OnClick, self)
	self._btnhole2:AddClickListener(self._btnhole2OnClick, self)
	self._btnunequip2:AddClickListener(self._btnunequip2OnClick, self)
	self._btnhole3:AddClickListener(self._btnhole3OnClick, self)
	self._btnunequip3:AddClickListener(self._btnunequip3OnClick, self)
end

function RougeCollectionListDropdownView:removeEvents()
	self._btnblock:RemoveClickListener()
	self._btnhole1:RemoveClickListener()
	self._btnunequip1:RemoveClickListener()
	self._btnhole2:RemoveClickListener()
	self._btnunequip2:RemoveClickListener()
	self._btnhole3:RemoveClickListener()
	self._btnunequip3:RemoveClickListener()
end

function RougeCollectionListDropdownView:_btnunequip1OnClick()
	self._holeMoList[1] = nil

	self:_updateHoles()
	self:_btnblockOnClick()
end

function RougeCollectionListDropdownView:_btnunequip2OnClick()
	self._holeMoList[2] = nil

	self:_updateHoles()
	self:_btnblockOnClick()
end

function RougeCollectionListDropdownView:_btnunequip3OnClick()
	self._holeMoList[3] = nil

	self:_updateHoles()
	self:_btnblockOnClick()
end

function RougeCollectionListDropdownView:_btnblockOnClick()
	if self._clickHoleIndex then
		local arrow = self["_goarrow" .. self._clickHoleIndex].transform

		transformhelper.setLocalScale(arrow, 1, 1, 1)
	end

	gohelper.setActive(self._scrollviewGo, false)
	gohelper.setActive(self._btnblock, false)

	self._clickHoleIndex = nil
end

function RougeCollectionListDropdownView:_btnhole1OnClick()
	self:_clickholeBtn(1)
end

function RougeCollectionListDropdownView:_btnhole2OnClick()
	self:_clickholeBtn(2)
end

function RougeCollectionListDropdownView:_btnhole3OnClick()
	self:_clickholeBtn(3)
end

function RougeCollectionListDropdownView:_clickholeBtn(index)
	if self._clickHoleIndex then
		self:_btnblockOnClick()

		return
	end

	self._clickHoleIndex = index

	local btn = self["_btnhole" .. index]

	RougeFavoriteCollectionEnchantListModel.instance:initData(self._holeMoList[index])
	gohelper.addChild(btn.gameObject, self._scrollviewGo)
	gohelper.setActive(self._scrollviewGo, true)
	gohelper.setActive(self._btnblock, true)
	recthelper.setAnchor(self._scrollviewGo.transform, -1, 374)

	local arrow = self["_goarrow" .. index].transform

	transformhelper.setLocalScale(arrow, 1, -1, 1)

	self._scrollview.verticalNormalizedPosition = 1
end

function RougeCollectionListDropdownView:getHoleMoList()
	return self._holeMoList
end

function RougeCollectionListDropdownView:_editableInitView()
	gohelper.setActive(self._btnhole1, false)
	gohelper.setActive(self._btnhole2, false)
	gohelper.setActive(self._btnhole3, false)

	self._holeMoList = {}
	self._holdNum = 3
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "Right/#go_normal/bottom/scrollview")
	self._scrollviewGo = self._scrollview.gameObject
	self._scrollAnchor = recthelper.getAnchor(self._scrollviewGo.transform)

	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickCollectionListItem, self._onClickCollectionListItem, self, LuaEventSystem.High)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickCollectionDropItem, self._onClickCollectionDropItem, self)
end

function RougeCollectionListDropdownView:_onClickCollectionDropItem(mo)
	self._holeMoList[self._clickHoleIndex] = mo

	self:_updateHoles()
	self:_btnblockOnClick()
end

function RougeCollectionListDropdownView:_updateHoles(skipRefresh)
	for i = 1, self._holdNum do
		local image = self["_simageruanpan" .. i]
		local mo = self._holeMoList[i]
		local showIcon = mo ~= nil

		gohelper.setActive(image, showIcon)
		gohelper.setActive(self["_btnunequip" .. i], showIcon)
		gohelper.setActive(self["_goempty" .. i], not showIcon)

		if showIcon then
			image:LoadImage(RougeCollectionHelper.getCollectionIconUrl(mo.id))
		end
	end

	if not skipRefresh then
		local listView = self.viewContainer:getCollectionListView()

		listView:_refreshSelectCollectionInfo()
	end
end

function RougeCollectionListDropdownView:_onClickCollectionListItem()
	TaskDispatcher.cancelTask(self._onRefresh, self)
	TaskDispatcher.runDelay(self._onRefresh, self, RougeEnum.CollectionListViewDelayTime)
end

function RougeCollectionListDropdownView:_onRefresh()
	recthelper.setHeight(self._scrollcollectiondesc.transform, 372)

	local selectedConfig = RougeCollectionListModel.instance:getSelectedConfig()

	if not selectedConfig then
		return
	end

	local productId = selectedConfig.id
	local productCfg = RougeCollectionConfig.instance:getCollectionCfg(productId)

	if not productCfg then
		return
	end

	if productCfg.holeNum > 0 then
		recthelper.setHeight(self._scrollcollectiondesc.transform, 293)
	end

	for i = 1, self._holdNum do
		self._holeMoList[i] = nil

		self:_setHoleVisible(i, i <= productCfg.holeNum)
	end

	self:_updateHoles(true)
end

function RougeCollectionListDropdownView:_setHoleVisible(index, visible)
	local go = self["_btnhole" .. index]

	gohelper.setActive(go, visible)
end

function RougeCollectionListDropdownView:onClose()
	gohelper.setActive(self._scrollviewGo, false)
	gohelper.setActive(self._btnblock, false)
end

function RougeCollectionListDropdownView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefresh, self)
end

return RougeCollectionListDropdownView
