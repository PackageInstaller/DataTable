-- chunkname: @modules/logic/room/view/backpack/RoomBackpackCritterView.lua

module("modules.logic.room.view.backpack.RoomBackpackCritterView", package.seeall)

local RoomBackpackCritterView = class("RoomBackpackCritterView", BaseView)

function RoomBackpackCritterView:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_num/#txt_num")
	self._gonumreddot = gohelper.findChild(self.viewGO, "#go_num/#txt_num/#go_reddot")
	self._gocritterSort = gohelper.findChild(self.viewGO, "#go_critterSort")
	self._btncirtterRare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterSort/#btn_cirtterRare")
	self._transcritterRareArrow = gohelper.findChild(self.viewGO, "#go_critterSort/#btn_cirtterRare/selected/txt/arrow").transform
	self._dropmaturefilter = gohelper.findChildDropdown(self.viewGO, "#go_critterSort/#drop_mature")
	self._transmatureDroparrow = gohelper.findChild(self.viewGO, "#go_critterSort/#drop_mature/#go_arrow").transform
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterSort/#btn_filter")
	self._gonotfilter = gohelper.findChild(self.viewGO, "#go_critterSort/#btn_filter/#go_notfilter")
	self._gofilter = gohelper.findChild(self.viewGO, "#go_critterSort/#btn_filter/#go_filter")
	self._btncompose = gohelper.findChildButtonWithAudio(self.viewGO, "compose/#btn_compose")
	self._gocomposeReddot = gohelper.findChild(self.viewGO, "compose/#btn_compose/#go_reddot")
	self._gocomposebtn = self._btncompose.gameObject

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBackpackCritterView:addEvents()
	self._dropmaturefilter:AddOnValueChanged(self.onMatureDropValueChange, self)
	self._btncirtterRare:AddClickListener(self._btncirtterRareOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btncompose:AddClickListener(self._btncomposeOnClick, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self.onCritterFilterTypeChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self.onCritterChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeReply, self.onCritterChange, self)
end

function RoomBackpackCritterView:removeEvents()
	self._dropmaturefilter:RemoveOnValueChanged()
	self._btncirtterRare:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btncompose:RemoveClickListener()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self.onCritterFilterTypeChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self.onCritterChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeReply, self.onCritterChange, self)
end

function RoomBackpackCritterView:_btncirtterRareOnClick()
	RoomBackpackController.instance:clickCritterRareSort(self.filterMO)
	self:refreshRareSort()
end

function RoomBackpackCritterView:_btnfilterOnClick()
	local filterTypeList = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(filterTypeList, self.viewName)
end

function RoomBackpackCritterView:_btncomposeOnClick()
	RoomBackpackController.instance:openCritterDecomposeView()
end

function RoomBackpackCritterView:onDropShow()
	transformhelper.setLocalScale(self._transmatureDroparrow, 1, 1, 1)
end

function RoomBackpackCritterView:onMatureDropValueChange(index)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)

	if self._filterTypeList then
		RoomBackpackController.instance:selectMatureFilterType(self._filterTypeList, self.filterMO)
		self:refreshCritterCount()
	end
end

function RoomBackpackCritterView:onDropHide()
	transformhelper.setLocalScale(self._transmatureDroparrow, 1, -1, 1)
end

function RoomBackpackCritterView:onCritterFilterTypeChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	self:refreshFilterBtn()
	self:refreshCritterList()
end

function RoomBackpackCritterView:onCritterChange()
	self:refreshCritterList()
end

function RoomBackpackCritterView:_editableInitView()
	self.dropExtend = DropDownExtend.Get(self._dropmaturefilter.gameObject)

	self.dropExtend:init(self.onDropShow, self.onDropHide, self)
	self:initMatureDropFilter()
end

function RoomBackpackCritterView:initMatureDropFilter()
	self._filterTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}

	local filterName = {}

	for _, filterType in ipairs(self._filterTypeList) do
		local filterTypeNameLangId = CritterEnum.MatureFilterTypeName[filterType]
		local filterTypeName = luaLang(filterTypeNameLangId)

		table.insert(filterName, filterTypeName)
	end

	self._dropmaturefilter:ClearOptions()
	self._dropmaturefilter:AddOptions(filterName)

	self.initMatureDropDone = true
end

function RoomBackpackCritterView:onUpdateParam()
	return
end

function RoomBackpackCritterView:onOpen()
	self.filterMO = CritterFilterModel.instance:generateFilterMO(self.viewName)

	self:refreshRareSort()
	self:refreshCritterList()
	self:refreshFilterBtn()
	RedDotController.instance:addRedDot(self._gonumreddot, RedDotEnum.DotNode.CritterIsFull)
	RedDotController.instance:addRedDot(self._gocomposeReddot, RedDotEnum.DotNode.CritterIsFull)
end

function RoomBackpackCritterView:refreshRareSort()
	local isRareAscend = RoomBackpackCritterListModel.instance:getIsSortByRareAscend()
	local scaleY = isRareAscend and 1 or -1

	transformhelper.setLocalScale(self._transcritterRareArrow, 1, scaleY, 1)
end

function RoomBackpackCritterView:refreshCritterList()
	RoomBackpackController.instance:refreshCritterBackpackList(self.filterMO)
	self:refreshCritterCount()
end

function RoomBackpackCritterView:refreshCritterCount()
	local count = RoomBackpackCritterListModel.instance:getCount()
	local capacity = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterBackpackCapacity) or 0

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_critter_backpack_num"), count, capacity)

	self:refreshIsEmpty()
end

function RoomBackpackCritterView:refreshIsEmpty()
	local isEmpty = RoomBackpackCritterListModel.instance:isBackpackEmpty()

	gohelper.setActive(self._goempty, isEmpty)
	gohelper.setActive(self._gocomposebtn, not isEmpty)
end

function RoomBackpackCritterView:refreshFilterBtn()
	local isFiltering = self.filterMO:isFiltering()

	gohelper.setActive(self._gonotfilter, not isFiltering)
	gohelper.setActive(self._gofilter, isFiltering)
end

function RoomBackpackCritterView:onClose()
	return
end

function RoomBackpackCritterView:onDestroyView()
	if self.dropExtend then
		self.dropExtend:dispose()
	end
end

return RoomBackpackCritterView
