-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_IllustrationDetailView.lua

module("modules.logic.rouge2.outside.view.Rouge2_IllustrationDetailView", package.seeall)

local Rouge2_IllustrationDetailView = class("Rouge2_IllustrationDetailView", BaseView)

function Rouge2_IllustrationDetailView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageFrameBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FrameBG")
	self._txtName = gohelper.findChildText(self.viewGO, "Right/#txt_Name")
	self._txtNameEn = gohelper.findChildText(self.viewGO, "Right/#txt_Name/#txt_NameEn")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_desc")
	self._godecitem = gohelper.findChild(self.viewGO, "Right/#scroll_desc/Viewport/Content/#go_decitem")
	self._txttitle = gohelper.findChildText(self.viewGO, "Right/#scroll_desc/Viewport/Content/#go_decitem/title/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Right/#scroll_desc/Viewport/Content/#go_decitem/#txt_desc")
	self._simageBottomBG = gohelper.findChildSingleImage(self.viewGO, "Bottom/#simage_BottomBG")
	self._txteventChecktitle = gohelper.findChildText(self.viewGO, "Bottom/#txt_eventChecktitle")
	self._txtPage = gohelper.findChildText(self.viewGO, "Bottom/#txt_Page")
	self._scrollTabList = gohelper.findChildScrollRect(self.viewGO, "Bottom/#scroll_TabList")
	self._gotabitem = gohelper.findChild(self.viewGO, "Bottom/#scroll_TabList/Viewport/Content/#go_tabitem")
	self._gounlock = gohelper.findChild(self.viewGO, "Bottom/#scroll_TabList/Viewport/Content/#go_tabitem/#go_unlock")
	self._txtunlock = gohelper.findChildText(self.viewGO, "Bottom/#scroll_TabList/Viewport/Content/#go_tabitem/#go_unlock/#txt_unlock")
	self._imageeventIcon = gohelper.findChildImage(self.viewGO, "Bottom/#scroll_TabList/Viewport/Content/#go_tabitem/#go_unlock/#txt_unlock/#image_eventIcon")
	self._golock = gohelper.findChild(self.viewGO, "Bottom/#scroll_TabList/Viewport/Content/#go_tabitem/#go_lock")
	self._txtlock = gohelper.findChildText(self.viewGO, "Bottom/#scroll_TabList/Viewport/Content/#go_tabitem/#go_lock/#txt_lock")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Bottom/#scroll_TabList/Viewport/Content/#go_tabitem/#go_lock/#txt_lock/#image_icon")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._goLeftTop = gohelper.findChild(self.viewGO, "#go_LeftTop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_IllustrationDetailView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function Rouge2_IllustrationDetailView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function Rouge2_IllustrationDetailView:_btnLeftOnClick()
	self._index = self._index - 1

	if self._index < 1 then
		self._index = self._num
	end

	self:_changePage()
end

function Rouge2_IllustrationDetailView:_btnRightOnClick()
	self._index = self._index + 1

	if self._index > self._num then
		self._index = 1
	end

	self:_changePage()
end

function Rouge2_IllustrationDetailView:_changePage()
	self._aniamtor:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._delayUpdateInfo, self)
	TaskDispatcher.runDelay(self._delayUpdateInfo, self, 0.3)
end

function Rouge2_IllustrationDetailView:_delayUpdateInfo()
	self:_updateInfo(self._list[self._index])
end

function Rouge2_IllustrationDetailView:_editableInitView()
	self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._goAttribute = gohelper.findChild(self.viewGO, "Bottom")
	self._goAttributeItem = gohelper.findChild(self.viewGO, "Bottom/#scroll_TabList/Viewport/Content/#go_tabitem")

	gohelper.setActive(self._goAttribute, false)
	gohelper.setActive(self._goAttributeItem, false)

	self._attributeItemList = {}
end

function Rouge2_IllustrationDetailView:_initIllustrationList()
	local list = Rouge2_OutSideConfig.instance:getIllustrationList()

	self._list = {}

	for i, v in ipairs(list) do
		if v.config.type == self.displayType and Rouge2_OutsideModel.instance:passedAnyEventId(v.eventIdList) then
			table.insert(self._list, v.config)
		end
	end

	self._num = #self._list
end

function Rouge2_IllustrationDetailView:onOpen()
	local param = self.viewParam

	self.displayType = param.displayType or Rouge2_OutsideEnum.IllustrationDetailType.Illustration

	self:_initIllustrationList()

	local config = param.config

	self.isFormIllustration = self.displayType == Rouge2_OutsideEnum.IllustrationDetailType.Illustration
	self._index = self.isFormIllustration and (tabletool.indexOf(self._list, config) or 1) or 1

	self:_updateInfo(config)
end

function Rouge2_IllustrationDetailView:_updateInfo(mo)
	self._mo = mo
	self._txtName.text = self._mo.name
	self._txtNameEn.text = self._mo.nameEn
	self._txtdesc.text = self._mo.desc

	gohelper.setActive(self._btnLeft, self.isFormIllustration)
	gohelper.setActive(self._btnRight, self.isFormIllustration)
	gohelper.setActive(self._txtPage, self.isFormIllustration)
	gohelper.setActive(self._goAttribute, self.isFormIllustration)

	if not string.nilorempty(self._mo.fullImage) then
		Rouge2_IconHelper.setRougeIllustrationBigIcon(self._mo.id, self._simageFullBG)
	end

	if not self.isFormIllustration then
		return
	end

	self._txtPage.text = string.format("%s/%s", self._index, self._num)

	self:refreshAttribute()
end

function Rouge2_IllustrationDetailView:refreshAttribute()
	local config = self._mo
	local haveEvent = not string.nilorempty(config.eventId)

	if not haveEvent then
		return
	end

	local eventList = string.splitToNumber(config.eventId)

	if eventList == nil or #eventList <= 0 then
		return
	end

	local eventId = eventList[1]
	local choiceConfigIdList = Rouge2_MapConfig.instance:getChoiceListByEventId(eventId) or {}
	local attributeCount = 0

	for _, choiceConfigId in ipairs(choiceConfigIdList) do
		local choiceConfig = lua_rouge2_choice.configDict[choiceConfigId]
		local attributeThreshold = choiceConfig.attributeThreshold

		if not string.nilorempty(attributeThreshold) then
			local attributeParam = string.splitToNumber(attributeThreshold, "#")

			attributeCount = attributeCount + 1

			local item

			if self._attributeItemList[attributeCount] then
				item = self._attributeItemList[attributeCount]
			else
				local itemGo = gohelper.cloneInPlace(self._goAttributeItem, tostring(attributeCount))

				item = MonoHelper.addLuaComOnceToGo(itemGo, Rouge2_IllustrationDetailAttributeItem)

				table.insert(self._attributeItemList, item)
			end

			item:setActive(true)
			item:setInfo(attributeParam)
		end
	end

	gohelper.setActive(self._goAttribute, attributeCount > 0)

	local itemCount = #self._attributeItemList

	if attributeCount < itemCount then
		for i = attributeCount + 1, itemCount do
			local item = self._attributeItemList[i]

			item:setActive(false)
		end
	end
end

function Rouge2_IllustrationDetailView:onClose()
	return
end

function Rouge2_IllustrationDetailView:onDestroyView()
	TaskDispatcher.cancelTask(self._delayUpdateInfo, self)
end

return Rouge2_IllustrationDetailView
