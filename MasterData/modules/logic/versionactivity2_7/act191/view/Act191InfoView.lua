-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191InfoView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191InfoView", package.seeall)

local Act191InfoView = class("Act191InfoView", BaseView)

function Act191InfoView:onInitView()
	self._goroleitem = gohelper.findChild(self.viewGO, "right/scroll_rule/Viewport/go_content/role/#go_roleitem")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "right/scroll_rule/Viewport/go_content/collection/#go_collectionitem")
	self._gobuffitem = gohelper.findChild(self.viewGO, "right/scroll_rule/Viewport/go_content/buff/#go_buffitem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191InfoView:onClickModalMask()
	if self.openViewName then
		self:closeTipView()

		return
	end

	self:closeThis()
end

function Act191InfoView:_editableInitView()
	local goAnim = gohelper.findChild(self.viewGO, "right")

	self.anim = goAnim:GetComponent(gohelper.Type_Animator)
	self._txtRule2 = gohelper.findChildText(self.viewGO, "right/simage_rightbg/txt_rule2")
	self.rightTr = gohelper.findChild(self.viewGO, "right").transform
end

function Act191InfoView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onViewClose, self)

	self.actId = Activity191Model.instance:getCurActId()
	self.actInfo = Activity191Model.instance:getActInfo()

	self:initCharacterItem()
	self:initCollectionItem()
	self:initBuffItem()
end

function Act191InfoView:onClose()
	self:closeTipView()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)

	local manual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, manual)
end

function Act191InfoView:initCharacterItem()
	self.characterItemList = {}

	local heroCfgList = Activity191Config.instance:getShowRoleCoList(self.actId)

	for index, cfg in ipairs(heroCfgList) do
		local item = self:getUserDataTb_()

		item.config = cfg

		local go = gohelper.cloneInPlace(self._goroleitem)
		local btnClick = gohelper.findButtonWithAudio(go)

		self.addClickCb(self, btnClick, self.clickCharacterItem, self, index)

		local imageRare = gohelper.findChildImage(go, "rare")

		item.heroIcon = gohelper.findChildSingleImage(go, "heroicon")
		item.goSelect = gohelper.findChild(go, "go_select")

		item.heroIcon:LoadImage(Activity191Helper.getHeadIconSmall(cfg))
		UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_roleframe_" .. tostring(cfg.quality))

		self.characterItemList[index] = item
	end

	gohelper.setActive(self._goroleitem, false)
end

function Act191InfoView:clickCharacterItem(index)
	local item = self.characterItemList[index]

	if item == self.selectItem then
		self:closeTipView()
		self:refreshSelect()
	else
		if self.openViewName and self.openViewName ~= ViewName.Act191HeroTipView then
			ViewMgr.instance:closeView(self.openViewName, false, true)
		end

		self.openViewName = ViewName.Act191HeroTipView

		local param = {
			preview = true,
			notShowBg = true,
			heroList = {
				item.config.id
			},
			pos = self.rightTr.position
		}

		Activity191Controller.instance:openHeroTipView(param)
		self:refreshSelect(item)
	end
end

function Act191InfoView:initCollectionItem()
	gohelper.setActive(self._gocollectionitem.transform.parent, false)
end

function Act191InfoView:clickCollectionItem(index)
	local item = self.collectionItemList[index]

	if item == self.selectItem then
		self:closeTipView()
		self:refreshSelect()
	else
		if self.openViewName and self.openViewName ~= ViewName.Act191CollectionTipView then
			ViewMgr.instance:closeView(self.openViewName, false, true)
		end

		self.openViewName = ViewName.Act191CollectionTipView

		local param = {
			notShowBg = true,
			itemId = item.config.id,
			pos = self.rightTr.position
		}

		Activity191Controller.instance:openCollectionTipView(param)
		self:refreshSelect(item)
	end
end

function Act191InfoView:initBuffItem()
	self.buffItemList = {}

	local buffCfgList = {}

	for _, v in ipairs(lua_activity191_enhance.configList) do
		if v.activityId == self.actId then
			buffCfgList[#buffCfgList + 1] = v
		end
	end

	for index, cfg in ipairs(buffCfgList) do
		local item = self:getUserDataTb_()

		item.config = cfg

		local go = gohelper.cloneInPlace(self._gobuffitem)
		local btnClick = gohelper.findButtonWithAudio(go)

		self.addClickCb(self, btnClick, self.clickBuffItem, self, index)

		local imageRare = gohelper.findChildImage(go, "rare")

		item.buffIcon = gohelper.findChildSingleImage(go, "bufficon")

		item.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(cfg.icon))

		item.goSelect = gohelper.findChild(go, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_propitembg_3")

		self.buffItemList[index] = item
	end

	gohelper.setActive(self._gobuffitem, false)
end

function Act191InfoView:clickBuffItem(index)
	local item = self.buffItemList[index]

	if item == self.selectItem then
		self:closeTipView()
		self:refreshSelect()
	else
		if self.openViewName and self.openViewName ~= ViewName.Act191EnhanceTipView then
			ViewMgr.instance:closeView(self.openViewName, false, true)
		end

		self.openViewName = ViewName.Act191EnhanceTipView

		local param = {
			notShowBg = true,
			co = item.config,
			pos = self.rightTr.position
		}

		Activity191Controller.instance:openEnhanceTipView(param)
		self:refreshSelect(item)
	end
end

function Act191InfoView:refreshSelect(clickItem)
	if self.selectItem then
		gohelper.setActive(self.selectItem.goSelect, false)
	end

	if clickItem then
		gohelper.setActive(clickItem.goSelect, true)
	end

	self.selectItem = clickItem
end

function Act191InfoView:closeTipView()
	if ViewMgr.instance:isOpen(self.openViewName) then
		ViewMgr.instance:closeView(self.openViewName, false, true)
	end

	self.openViewName = nil
end

function Act191InfoView:onViewClose(viewName)
	if self.openViewName == viewName then
		self:refreshSelect()

		self.openViewName = nil
	end
end

return Act191InfoView
