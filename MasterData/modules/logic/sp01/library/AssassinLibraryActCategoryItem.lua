-- chunkname: @modules/logic/sp01/library/AssassinLibraryActCategoryItem.lua

module("modules.logic.sp01.library.AssassinLibraryActCategoryItem", package.seeall)

local AssassinLibraryActCategoryItem = class("AssassinLibraryActCategoryItem", LuaCompBase)

function AssassinLibraryActCategoryItem:init(go)
	self.go = go
	self._gotop = gohelper.findChild(go, "go_top")
	self._gotopselect = gohelper.findChild(go, "go_top/go_select")
	self._gotopunselect = gohelper.findChild(go, "go_top/go_unselect")
	self._txttitle1 = gohelper.findChildText(go, "go_top/go_select/txt_title")
	self._txttitle2 = gohelper.findChildText(go, "go_top/go_unselect/txt_title")
	self._goreddot1 = gohelper.findChild(go, "go_top/go_select/go_reddot")
	self._goreddot2 = gohelper.findChild(go, "go_top/go_unselect/go_reddot")
	self._btnclick = gohelper.findChildButton(go, "go_top/btn_click")
	self._goselectarrow_in = gohelper.findChild(go, "go_top/go_select/image_Arrow_in")
	self._goselectarrow_out = gohelper.findChild(go, "go_top/go_select/image_Arrow_out")
	self._gounselectarrow_in = gohelper.findChild(go, "go_top/go_unselect/image_Arrow_in")
	self._gounselectarrow_out = gohelper.findChild(go, "go_top/go_unselect/image_Arrow_out")
	self._gosubs = gohelper.findChild(go, "go_subs")
	self._gosubitem = gohelper.findChild(go, "go_subs/go_subitem")

	gohelper.setActive(self._gosubitem, false)

	self._libTypeItemList = {}

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateLibraryReddot, self.refreshRedDot, self)
end

function AssassinLibraryActCategoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinLibraryActCategoryItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AssassinLibraryActCategoryItem:_btnclickOnClick()
	self:setFold(not self._isFoldOut, true)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_glassclick)
end

function AssassinLibraryActCategoryItem:setActId(actId)
	self._actId = actId
	self._libTypes = AssassinConfig.instance:getActLibraryTypeList(actId)
	self._isFoldOut = false

	self:refreshUI()
end

function AssassinLibraryActCategoryItem:refreshUI()
	local status = ActivityHelper.getActivityStatus(self._actId)

	self._isVisible = status ~= ActivityEnum.ActivityStatus.NotOpen and status ~= ActivityEnum.ActivityStatus.None

	gohelper.setActive(self.go, self._isVisible)

	if not self._isVisible then
		return
	end

	local title = AssassinHelper.getLibraryTopTitleByActId(self._actId)

	self._txttitle1.text = title
	self._txttitle2.text = title

	self:refreshLibTypeList()
	self:refreshRedDot()
	self:refreshSelectUI(false)
	self:setFold(self._isFoldOut)
end

function AssassinLibraryActCategoryItem:refreshLibTypeList()
	for index, libType in ipairs(self._libTypes) do
		local libTypeItem = self:_getOrCreateLibTypeItem(index)

		libTypeItem:setLibType(self._actId, libType)
	end
end

function AssassinLibraryActCategoryItem:_getOrCreateLibTypeItem(index)
	local libTypeItem = self._libTypeItemList[index]

	if not libTypeItem then
		local categoryItemGo = gohelper.cloneInPlace(self._gosubitem, index)

		libTypeItem = MonoHelper.addNoUpdateLuaComOnceToGo(categoryItemGo, AssassinLibraryTypeCategoryItem)
		self._libTypeItemList[index] = libTypeItem
	end

	return libTypeItem
end

function AssassinLibraryActCategoryItem:onSelect(isSelect, libType)
	self:refreshSelectUI(isSelect, libType)
end

function AssassinLibraryActCategoryItem:refreshSelectUI(isSelect, libType)
	gohelper.setActive(self._gotopselect, isSelect)
	gohelper.setActive(self._gotopunselect, not isSelect)

	for _, typeItem in pairs(self._libTypeItemList) do
		local type = typeItem:getLibType()

		if type == libType then
			typeItem:onSelect(isSelect)

			if isSelect then
				self:setFold(true)
			end
		else
			typeItem:onSelect(false)
		end
	end
end

function AssassinLibraryActCategoryItem:getLibType(index)
	return self._libTypes and self._libTypes[index]
end

function AssassinLibraryActCategoryItem:_onRefreshActivityState(actId)
	if self._actId ~= actId then
		return
	end

	self:refreshUI()
end

function AssassinLibraryActCategoryItem:refreshRedDot()
	if not self._isVisible then
		return
	end

	local isReddotEnable = self:_redDotCheckFunc()

	gohelper.setActive(self._goreddot1, isReddotEnable)
	gohelper.setActive(self._goreddot2, isReddotEnable)
end

function AssassinLibraryActCategoryItem:_redDotCheckFunc()
	local type2RedDotMap = AssassinLibraryModel.instance:getNewUnlockLibraryIdMap(self._actId)
	local isShowActRedDot = false

	for type, showRedDot in pairs(type2RedDotMap) do
		self._libTypeItemList[type]:refreshRedDot(showRedDot)

		if showRedDot then
			isShowActRedDot = true
		end
	end

	return isShowActRedDot
end

function AssassinLibraryActCategoryItem:setFold(isFoldOut, tween)
	self._isFoldOut = isFoldOut

	gohelper.setActive(self._goselectarrow_in, isFoldOut)
	gohelper.setActive(self._goselectarrow_out, not isFoldOut)
	gohelper.setActive(self._gounselectarrow_in, isFoldOut)
	gohelper.setActive(self._gounselectarrow_out, not isFoldOut)

	if tween then
		self:_playFoldAnim(isFoldOut)
	else
		self:setSubListVisible(isFoldOut)
	end
end

function AssassinLibraryActCategoryItem:_playFoldAnim(isFoldOut)
	self:setSubListVisible(true)

	self._foldFlow = FlowSequence.New()

	self._foldFlow:addWork(FunctionWork.New(self._lockScreen, self, true))

	if self._libTypeItemList then
		if not #self._libTypeItemList then
			local subItemCount = 0
			local startIndex = isFoldOut and 1 or subItemCount
			local endIndex = isFoldOut and subItemCount or 1
			local step = isFoldOut and 1 or -1

			for i = startIndex, endIndex, step do
				local subItem = self._libTypeItemList[i]

				self._foldFlow:addWork(subItem:buildFoldTweenWork(isFoldOut))
			end

			self._foldFlow:addWork(FunctionWork.New(self._lockScreen, self, false))
			self._foldFlow:addWork(FunctionWork.New(self.setSubListVisible, self, isFoldOut))
			self._foldFlow:start()
		end
	end
end

function AssassinLibraryActCategoryItem:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AssassinLibraryActCategoryItem")
	else
		UIBlockMgr.instance:endBlock("AssassinLibraryActCategoryItem")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function AssassinLibraryActCategoryItem:setSubListVisible(isVisible)
	gohelper.setActive(self._gosubs, isVisible)

	self._isSubVisible = isVisible
end

function AssassinLibraryActCategoryItem:tryClickSelf(clickPosition, eventCamera)
	local isClickTop = self:tryClickTop(clickPosition, eventCamera)

	return isClickTop and isClickTop or self:tryClickSubItems(clickPosition, eventCamera)
end

function AssassinLibraryActCategoryItem:tryClickTop(clickPosition, eventCamera)
	local isClickTop = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._btnclick.transform, clickPosition, eventCamera)

	if isClickTop then
		self:_btnclickOnClick()
	end

	return isClickTop
end

function AssassinLibraryActCategoryItem:tryClickSubItems(clickPosition, eventCamera)
	if not self._isSubVisible then
		return
	end

	for _, subItem in ipairs(self._libTypeItemList) do
		if subItem:tryClickSelf(clickPosition, eventCamera) then
			return true
		end
	end
end

function AssassinLibraryActCategoryItem:onDestroy()
	if self._foldFlow then
		self._foldFlow:destroy()

		self._foldFlow = nil

		self:_lockScreen(false)
	end
end

return AssassinLibraryActCategoryItem
