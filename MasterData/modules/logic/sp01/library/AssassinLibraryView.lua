-- chunkname: @modules/logic/sp01/library/AssassinLibraryView.lua

module("modules.logic.sp01.library.AssassinLibraryView", package.seeall)

local AssassinLibraryView = class("AssassinLibraryView", BaseView)
local DefaultSelectActIndex = 1
local DefaultSelectTypeIndex = 1

function AssassinLibraryView:onInitView()
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_category")
	self._gobanneritem = gohelper.findChild(self.viewGO, "root/#scroll_category/Viewport/Content/#go_banneritem")
	self._gocontainer = gohelper.findChild(self.viewGO, "root/#go_container")
	self._gocontainer1 = gohelper.findChild(self.viewGO, "root/#go_container/#go_container1")
	self._gocontainer2 = gohelper.findChild(self.viewGO, "root/#go_container/#go_container2")
	self._btnclick = gohelper.getClick(self._scrollcategory.gameObject)
	self._gocamera = gohelper.findChild(self.viewGO, "#go_camera")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinLibraryView:addEvents()
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnSelectLibLibType, self._onSelectLibLibType, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinLibraryView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function AssassinLibraryView:_btnclickOnClick(_, clickPosition)
	for _, actItem in pairs(self._actItemTab) do
		if actItem:tryClickSelf(clickPosition, self._eventCamera) then
			return
		end
	end
end

function AssassinLibraryView:_editableInitView()
	self._actItemTab = self:getUserDataTb_()

	gohelper.setActive(self._gobanneritem, false)
	self:initEventCamera()
end

function AssassinLibraryView:onOpen()
	self:initActItemList()
	OdysseyStatHelper.instance:initViewStartTime()
	AudioMgr.instance:trigger(AudioEnum2_9.AssassinLibrary.play_ui_openlibrary)
end

function AssassinLibraryView:onUpdateParam()
	self:_initParams()
end

function AssassinLibraryView:initEventCamera()
	self._eventCamera = self._gocamera:GetComponent("Camera")

	local cameraWorldPosX = AssassinEnum.LibraryCategoryCameraParams.cameraPos.x
	local cameraWorldPosY = AssassinEnum.LibraryCategoryCameraParams.cameraPos.y
	local cameraWorldPosZ = AssassinEnum.LibraryCategoryCameraParams.cameraPos.z

	transformhelper.setPos(self._gocamera.transform, cameraWorldPosX, cameraWorldPosY, cameraWorldPosZ)
	transformhelper.setLocalScale(self._gocamera.transform, 1, 1, 1)

	self._eventCamera.orthographic = false
	self._eventCamera.fieldOfView = AssassinEnum.LibraryCategoryCameraParams.perspFOV

	gohelper.setActive(self._gocamera, false)
end

function AssassinLibraryView:initActItemList()
	local actIdList = AssassinConfig.instance:getLibraryActIdList()

	for index, actId in ipairs(actIdList) do
		local actItem = self:_getOrCreateActItem(actId)

		actItem:setActId(actId)

		if index == DefaultSelectActIndex then
			self._defaultActId = actId
			self._defaultLibType = actItem:getLibType(DefaultSelectTypeIndex)
		end
	end

	self:_initParams()
end

function AssassinLibraryView:_initParams()
	if self.viewParam then
		if self.viewParam then
			local viewParam_libraryType = self.viewParam.libraryType

			self._defaultActId = self.viewParam or self._defaultActId
			self._defaultLibType = viewParam_libraryType or self._defaultLibType

			self:_foldOutSelectActItem()
			AssassinController.instance:dispatchEvent(AssassinEvent.OnSelectLibLibType, self._defaultActId, self._defaultLibType)
		end
	end
end

function AssassinLibraryView:_foldOutSelectActItem()
	if self._actItemTab then
		if not self._actItemTab then
			return
		end

		self._actItemTab:setFold(true)
	end
end

function AssassinLibraryView:_getOrCreateActItem(actId)
	local actItem = self._actItemTab[actId]

	if not actItem then
		local go = gohelper.cloneInPlace(self._gobanneritem, actId)

		actItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AssassinLibraryActCategoryItem)
		self._actItemTab[actId] = actItem
	end

	return actItem
end

function AssassinLibraryView:_onSelectLibLibType(actId, libType)
	local actItem = self._actItemTab[actId]

	if not actItem then
		logError(string.format("刺客信条资料库页签不存在 actId = %s, libType = %s", actId, libType))

		return
	end

	if self._selectActItem then
		self._selectActItem:onSelect(false)
	end

	actItem:onSelect(true, libType)

	self._selectActItem = actItem

	AssassinLibraryModel.instance:switch(actId, libType)
	AssassinLibraryModel.instance:readTypeLibrarys(actId, libType)
	self.viewContainer:switchLibType(libType)
end

function AssassinLibraryView:onClose()
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("AssassinLibraryView")
end

function AssassinLibraryView:onDestroyView()
	return
end

return AssassinLibraryView
