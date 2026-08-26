-- chunkname: @modules/logic/room/view/RoomCharacterPlaceView.lua

module("modules.logic.room.view.RoomCharacterPlaceView", package.seeall)

local RoomCharacterPlaceView = class("RoomCharacterPlaceView", BaseView)

function RoomCharacterPlaceView:onInitView()
	self._gomaskbg = gohelper.findChild(self.viewGO, "#go_maskbg")
	self._goroleview1 = gohelper.findChild(self.viewGO, "#go_roleview1")
	self._btnunfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_roleview1/rolescroll/#btn_unfold")
	self._goroleview2 = gohelper.findChild(self.viewGO, "#go_roleview2")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_roleview2/rolescroll/#btn_fold")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCharacterPlaceView:addEvents()
	self._btnunfold:AddClickListener(self._btnunfoldOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomCharacterPlaceView:removeEvents()
	self._btnunfold:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomCharacterPlaceView:_btncloseviewOnClick()
	local scene = GameSceneMgr.instance:getCurScene()

	if scene.camera:isTweening() or not scene.fsm:getCurStateName() then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		RoomCharacterController.instance:setCharacterListShow(false)
	end
end

function RoomCharacterPlaceView:_btnunfoldOnClick()
	self:_setCramerFoucs(true)
	self:_unfold(true)
	self:_tweentCramerFoucs()
end

function RoomCharacterPlaceView:_btnfoldOnClick()
	self:_setCramerFoucs(false)
	self:_fold(true)
	self:_tweentCramerFoucs()
end

function RoomCharacterPlaceView:_unfold(anim)
	RoomCharacterModel.instance:setCanDragCharacter(false)

	self._isFold = false
	self._canvasGroup1.blocksRaycasts = false
	self._canvasGroup2.blocksRaycasts = true
	self._roleViewItem1.scrollrole.horizontalNormalizedPosition = 0
	self._roleViewItem2.scrollrole.verticalNormalizedPosition = 1

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	self._animator.enabled = true

	if anim then
		self._animator:Play("switchup", 0, 0)
	else
		self._animator:Play("switchup", 0, 1)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)

	self._scrollRect = self._roleViewItem2.scrollrole.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function RoomCharacterPlaceView:_fold(anim)
	RoomCharacterModel.instance:setCanDragCharacter(true)

	self._isFold = true
	self._canvasGroup1.blocksRaycasts = true
	self._canvasGroup2.blocksRaycasts = false
	self._roleViewItem1.scrollrole.horizontalNormalizedPosition = 0
	self._roleViewItem2.scrollrole.verticalNormalizedPosition = 1

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	self._animator.enabled = true

	if anim then
		self._animator:Play("switchdown", 0, 0)
	else
		self._animator:Play("switchdown", 0, 1)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)

	self._scrollRect = self._roleViewItem1.scrollrole.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function RoomCharacterPlaceView:_btnbirthdayfilterOnClick()
	local curBirthdayFilter = RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday()
	local isFilter = not curBirthdayFilter
	local isSucceed = RoomCharacterController.instance:setFilterOnBirthday(isFilter)

	if isSucceed then
		self:_refreshBirthdayFilter()
	end
end

function RoomCharacterPlaceView:_onDailyRefresh()
	local curBirthdayFilter = RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday()
	local cancelBirthdayFilter = false

	if curBirthdayFilter then
		local hasOnBirthdayHero = RoomCharacterPlaceListModel.instance:hasHeroOnBirthday()

		if not hasOnBirthdayHero then
			cancelBirthdayFilter = true
		end
	end

	if cancelBirthdayFilter then
		self:_btnbirthdayfilterOnClick()
	else
		RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	end
end

function RoomCharacterPlaceView:_setCramerFoucs(isMoreShow)
	if isMoreShow then
		if not RoomCharacterEnum.CameraFocus.MoreShowList then
			local characterFocus = RoomCharacterEnum.CameraFocus.Normal

			RoomCharacterController.instance:setCharacterFocus(characterFocus)
		end
	end
end

function RoomCharacterPlaceView:_tweentCramerFoucs()
	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	if tempCharacterMO and tempCharacterMO.currentPosition then
		local characterFocus = RoomCharacterController.instance:getCharacterFocus()
		local currentPosition = tempCharacterMO.currentPosition
		local worldX = currentPosition.x
		local worldZ = currentPosition.z

		RoomCharacterController.instance:tweenCameraFocus(worldX, worldZ, characterFocus)
	end
end

function RoomCharacterPlaceView:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._canvasGroup1 = self._goroleview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._canvasGroup2 = self._goroleview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._goarrowTrs1 = gohelper.findChild(self.viewGO, "#go_roleview1/rolesort/#drop_equipclassify1/go_arrow").transform
	self._goarrowTrs2 = gohelper.findChild(self.viewGO, "#go_roleview2/rolescroll/rolesort/#drop_equipclassify2/go_arrow").transform
	self._birthdayFilterBtn1 = self:getUserDataTb_()
	self._birthdayFilterBtn2 = self:getUserDataTb_()

	local goBtn1 = gohelper.findChild(self.viewGO, "#go_roleview1/rolesort/#btn_birthdayfilter1")
	local goBtn2 = gohelper.findChild(self.viewGO, "#go_roleview2/rolescroll/rolesort/#btn_birthdayfilter2")

	self:_initBirthdayFilterBtn(goBtn1, self._birthdayFilterBtn1)
	self:_initBirthdayFilterBtn(goBtn2, self._birthdayFilterBtn2)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._roleViewItem1 = self:getUserDataTb_()
	self._roleViewItem2 = self:getUserDataTb_()

	self:_initRoleViewItem(self._roleViewItem1, self._goroleview1, 1)
	self:_initRoleViewItem(self._roleViewItem2, self._goroleview2, 2)
	TaskDispatcher.runRepeat(self._checkDropList1Exist, self, 0.2)
	TaskDispatcher.runRepeat(self._checkDropList2Exist, self, 0.2)
end

function RoomCharacterPlaceView:_initBirthdayFilterBtn(goBtn, filterBtnItem)
	if not filterBtnItem or gohelper.isNil(goBtn) then
		return
	end

	filterBtnItem.btn = gohelper.findButtonWithAudio(goBtn)

	filterBtnItem.btn:AddClickListener(self._btnbirthdayfilterOnClick, self)

	filterBtnItem.gonormal = gohelper.findChild(goBtn, "normal")
	filterBtnItem.goselect = gohelper.findChild(goBtn, "select")
end

function RoomCharacterPlaceView:_initRoleViewItem(roleViewItem, goroleview, index)
	roleViewItem.gorare = gohelper.findChild(goroleview, "rolesort/leftbtn/#btn_rarerank" .. index) or gohelper.findChild(goroleview, "rolescroll/rolesort/leftbtn/#btn_rarerank" .. index)
	roleViewItem.gofaith = gohelper.findChild(goroleview, "rolesort/leftbtn/#btn_faithrank" .. index) or gohelper.findChild(goroleview, "rolescroll/rolesort/leftbtn/#btn_faithrank" .. index)
	roleViewItem.sortRareItem = self:getUserDataTb_()
	roleViewItem.sortFaithItem = self:getUserDataTb_()

	self:_initSortItem(roleViewItem.sortRareItem, roleViewItem.gorare, RoomCharacterEnum.CharacterOrderType.RareUp, RoomCharacterEnum.CharacterOrderType.RareDown)
	self:_initSortItem(roleViewItem.sortFaithItem, roleViewItem.gofaith, RoomCharacterEnum.CharacterOrderType.FaithUp, RoomCharacterEnum.CharacterOrderType.FaithDown)

	roleViewItem.scrollrole = gohelper.findChildScrollRect(goroleview, "rolescroll")
	roleViewItem.dropClassify = gohelper.findChildDropdown(goroleview, "rolesort/#drop_equipclassify" .. index) or gohelper.findChildDropdown(goroleview, "rolescroll/rolesort/#drop_equipclassify" .. index)

	gohelper.addUIClickAudio(roleViewItem.dropClassify.gameObject, AudioEnum.UI.play_ui_callfor_open)

	roleViewItem.dropClassifyClick = gohelper.getClick(roleViewItem.dropClassify.gameObject)

	roleViewItem.dropClassifyClick:AddClickListener(self._onClicked, self, roleViewItem.dropClassify)
	roleViewItem.dropClassify:AddOnValueChanged(self._onValueChanged, self)

	local options = {}

	for career = 1, 6 do
		table.insert(options, luaLang("career" .. career))
	end

	roleViewItem.dropClassify:AddOptions(options)
end

function RoomCharacterPlaceView:_onValueChanged(index)
	if index == 0 then
		RoomCharacterPlaceListModel.instance:setFilterCareer()
	else
		RoomCharacterPlaceListModel.instance:setFilterCareer({
			index
		})
	end

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	self:_refreshCareer()
	self:_refreshBirthdayFilter()
end

function RoomCharacterPlaceView:_onClicked(args)
	local dropDown = args.dropDown
	local index = RoomCharacterPlaceListModel.instance:getFilterCareer()
	local DropdownListTrs = gohelper.findChild(dropDown.gameObject, "Dropdown List/Viewport/Content").transform
	local txt = gohelper.findChildText(index and DropdownListTrs:GetChild(index + 1).gameObject or DropdownListTrs:GetChild(1).gameObject, "Text")

	txt.color = GameUtil.parseColor("#EFB785")

	self:_addAudioToBlock()
	self:_addAudioToToggles(DropdownListTrs)
end

function RoomCharacterPlaceView:_refreshCareer()
	self:_refreshRoleViewItemCareer(self._roleViewItem1)
	self:_refreshRoleViewItemCareer(self._roleViewItem2)
end

function RoomCharacterPlaceView:_refreshRoleViewItemCareer(roleViewItem)
	if RoomCharacterPlaceListModel.instance:isFilterCareerEmpty() then
		roleViewItem.dropClassify:SetValue(0)
	else
		for career = 1, 6 do
			if RoomCharacterPlaceListModel.instance:isFilterCareer(career) then
				roleViewItem.dropClassify:SetValue(career)

				break
			end
		end
	end
end

function RoomCharacterPlaceView:_roleViewItemOnDestroy(roleViewItem)
	self:_sortItemOnDestroy(roleViewItem.sortRareItem)
	self:_sortItemOnDestroy(roleViewItem.sortFaithItem)
	roleViewItem.dropClassify:RemoveOnValueChanged()
	roleViewItem.dropClassifyClick:RemoveClickListener()
end

function RoomCharacterPlaceView:_initSortItem(sortItem, go, orderUp, orderDown)
	sortItem.btnsort = gohelper.findChildButtonWithAudio(go, "")
	sortItem.go1 = gohelper.findChild(go, "btn1")
	sortItem.go2 = gohelper.findChild(go, "btn2")
	sortItem.goarrow = gohelper.findChild(go, "btn2/arrow")
	sortItem.orderUp = orderUp
	sortItem.orderDown = orderDown

	sortItem.btnsort:AddClickListener(self._btnsortOnClick, self, sortItem)
end

function RoomCharacterPlaceView:_btnsortOnClick(sortItem)
	local order = RoomCharacterPlaceListModel.instance:getOrder()

	if order == sortItem.orderDown then
		RoomCharacterPlaceListModel.instance:setOrder(sortItem.orderUp)
	else
		RoomCharacterPlaceListModel.instance:setOrder(sortItem.orderDown)
	end

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	self:_refreshSort()
end

function RoomCharacterPlaceView:_setSort(sortItem, select, reverse)
	if select then
		gohelper.setActive(sortItem.go1, false)
		gohelper.setActive(sortItem.go2, true)
		self:_setReverse(sortItem.goarrow.transform, reverse)
	else
		gohelper.setActive(sortItem.go1, true)
		gohelper.setActive(sortItem.go2, false)
	end
end

function RoomCharacterPlaceView:_setReverse(transform, reverse)
	local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(transform)

	if reverse then
		transformhelper.setLocalScale(transform, scaleX, -math.abs(scaleY), scaleZ)
	else
		transformhelper.setLocalScale(transform, scaleX, math.abs(scaleY), scaleZ)
	end
end

function RoomCharacterPlaceView:_sortItemOnDestroy(sortItem)
	sortItem.btnsort:RemoveClickListener()
end

function RoomCharacterPlaceView:_refreshSort()
	self:_refreshRoleViewItemSort(self._roleViewItem1)
	self:_refreshRoleViewItemSort(self._roleViewItem2)
end

function RoomCharacterPlaceView:_refreshRoleViewItemSort(roleViewItem)
	self:_refreshSortItemSort(roleViewItem.sortRareItem)
	self:_refreshSortItemSort(roleViewItem.sortFaithItem)
end

function RoomCharacterPlaceView:_refreshSortItemSort(sortItem)
	local order = RoomCharacterPlaceListModel.instance:getOrder()

	self:_setSort(sortItem, order == sortItem.orderUp or order == sortItem.orderDown, order == sortItem.orderUp)
end

function RoomCharacterPlaceView:_refreshBirthdayFilter()
	local isBirthdayFilter = RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday()

	gohelper.setActive(self._birthdayFilterBtn1.goselect, isBirthdayFilter)
	gohelper.setActive(self._birthdayFilterBtn2.goselect, isBirthdayFilter)
	gohelper.setActive(self._birthdayFilterBtn1.gonormal, not isBirthdayFilter)
	gohelper.setActive(self._birthdayFilterBtn2.gonormal, not isBirthdayFilter)
end

function RoomCharacterPlaceView:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnunfold.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(self._btnfold.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function RoomCharacterPlaceView:_onEscape()
	self:_btncloseviewOnClick()
end

function RoomCharacterPlaceView:_clientPlaceCharacter()
	return
end

function RoomCharacterPlaceView:_onListDragBeginListener(pointerEventData)
	self._scrollRect:OnBeginDrag(pointerEventData)
end

function RoomCharacterPlaceView:_onListDragListener(pointerEventData)
	self._scrollRect:OnDrag(pointerEventData)
end

function RoomCharacterPlaceView:_onListDragEndListener(pointerEventData)
	self._scrollRect:OnEndDrag(pointerEventData)
end

function RoomCharacterPlaceView:onOpen()
	self:_setCramerFoucs(false)
	self:_fold()
	self._animator:Play(UIAnimationName.Open, 0, 0)
	self:_refreshSort()
	self:_refreshCareer()
	self:_addBtnAudio()
	self:_refreshBirthdayFilter()
	NavigateMgr.instance:addEscape(ViewName.RoomCharacterPlaceView, self._onEscape, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientPlaceCharacter, self._clientPlaceCharacter, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterListOnDragBeginListener, self._onListDragBeginListener, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterListOnDragListener, self._onListDragListener, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterListOnDragEndListener, self._onListDragEndListener, self)
end

function RoomCharacterPlaceView:_addAudioToBlock()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local blockGO = gohelper.findChild(uiRoot, "Blocker")

	if blockGO then
		gohelper.addUIClickAudio(blockGO, AudioEnum.UI.play_ui_callfor_open)
	end
end

function RoomCharacterPlaceView:_addAudioToToggles(DropdownListTrs)
	local toggleList = DropdownListTrs.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Toggle), false)

	if toggleList then
		local iter = toggleList:GetEnumerator()

		while iter:MoveNext() do
			local toggle = iter.Current

			gohelper.addUIClickAudio(toggle.gameObject, AudioEnum.UI.play_ui_callfor_open)
		end
	end
end

function RoomCharacterPlaceView:_checkDropList1Exist()
	local dropClassify = self._roleViewItem1.dropClassify
	local dropListGO = gohelper.findChild(dropClassify.gameObject, "Dropdown List")

	if dropListGO then
		if not self.dropShow1 then
			transformhelper.setLocalRotation(self._goarrowTrs1, 0, 0, 180)

			self.dropShow1 = true
		end
	elseif self.dropShow1 then
		transformhelper.setLocalRotation(self._goarrowTrs1, 0, 0, 0)

		self.dropShow1 = false
	end
end

function RoomCharacterPlaceView:_checkDropList2Exist()
	local dropClassify = self._roleViewItem2.dropClassify
	local dropListGO = gohelper.findChild(dropClassify.gameObject, "Dropdown List")

	if dropListGO then
		if not self.dropShow2 then
			transformhelper.setLocalRotation(self._goarrowTrs2, 0, 0, 0)

			self.dropShow2 = true
		end
	elseif self.dropShow2 then
		transformhelper.setLocalRotation(self._goarrowTrs2, 0, 0, 180)

		self.dropShow2 = false
	end
end

function RoomCharacterPlaceView:onClose()
	RoomCharacterController.instance:onCloseRoomCharacterPlaceView()
end

function RoomCharacterPlaceView:onDestroyView()
	TaskDispatcher.cancelTask(self._checkDropList1Exist, self)
	TaskDispatcher.cancelTask(self._checkDropList2Exist, self)
	self:_roleViewItemOnDestroy(self._roleViewItem1)
	self:_roleViewItemOnDestroy(self._roleViewItem2)
	self._birthdayFilterBtn1.btn:RemoveClickListener()
	self._birthdayFilterBtn2.btn:RemoveClickListener()
	self:_setCramerFoucs(false)
end

return RoomCharacterPlaceView
