-- chunkname: @modules/logic/necrologiststory/game/v3a9/V3A9_RoleStoryClueView.lua

module("modules.logic.necrologiststory.game.v3a9.V3A9_RoleStoryClueView", package.seeall)

local V3A9_RoleStoryClueView = class("V3A9_RoleStoryClueView", BaseView)

function V3A9_RoleStoryClueView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "mask")
	self.btnResult = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_result")
	self.goNew = gohelper.findChild(self.viewGO, "#btn_result/#go_new")

	gohelper.setActive(self.goNew, false)

	self.goClueItem = gohelper.findChild(self.viewGO, "Left/pos/#go_clueitem")

	gohelper.setActive(self.goClueItem, false)

	self.itemList = {}
	self.txtProgress = gohelper.findChildTextMesh(self.viewGO, "Left/layout/#txt_progress")
	self.goRight = gohelper.findChild(self.viewGO, "Right")
	self.animRight = gohelper.findChildAnim(self.viewGO, "Right")
	self.animEventRight = gohelper.onceAddComponent(self.goRight, gohelper.Type_AnimationEventWrap)
	self.simagePic = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_level")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "Right/namebg/#txt_name")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "Right/ScrollView/Viewport/Content/#txt_desc")
	self.txtTips = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A9_RoleStoryClueView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
	self.addClickCb(self, self.btnResult, self.onClickResult, self)
	self.animEventRight:AddEventListener("refresh", self._onRefreshRightInfo, self)
end

function V3A9_RoleStoryClueView:removeEvents()
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnResult)
	self.animEventRight:RemoveAllEventListener()
end

function V3A9_RoleStoryClueView:_editableInitView()
	return
end

function V3A9_RoleStoryClueView:_onRefreshRightInfo()
	self:refreshRight()
end

function V3A9_RoleStoryClueView:onClickClose()
	self:closeThis()
end

function V3A9_RoleStoryClueView:onClickResult()
	ViewMgr.instance:openView(ViewName.V3A9_RoleStoryResultView, {
		roleStoryId = self.heroStoryId
	})
	gohelper.setActive(self.goNew, false)
	NecrologistStoryPlayerPrefs.instance:setExist(NecrologistStoryEnum.PrefsKey.V3A9ItemOldTag, 0)
end

function V3A9_RoleStoryClueView:onClickItem(item)
	local config = item.config

	if not config then
		return
	end

	self:setSelectId(config.id)
end

function V3A9_RoleStoryClueView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function V3A9_RoleStoryClueView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A9_RoleStoryClueView:onOpenFinish()
	self:refreshItemListAnim()
end

function V3A9_RoleStoryClueView:refreshParam()
	if not self.viewParam then
		local viewParam = {}
		local storyId = viewParam.roleStoryId

		self.heroStoryId = storyId

		if storyId then
			self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
		end
	end
end

function V3A9_RoleStoryClueView:refreshView()
	self:refreshItemList()
	self:refreshRight()
end

function V3A9_RoleStoryClueView:refreshItemList()
	local list = self.gameBaseMO:getShowItemList()

	if self._selectItemId == nil then
		self:setSelectId(list[1] and list[1].id, true)
	end

	self.itemId2Item = {}

	for i = 1, math.max(#list, #self.itemList) do
		local config = list[i]
		local item = self:getItem(i)

		self:refreshItem(item, config)
	end

	local cur, total = self.gameBaseMO:getProgress()

	self.txtProgress.text = string.format("<#FF7A33>%s</color>/%s", cur, total)

	gohelper.setActive(self.btnResult, total <= cur)

	local isExistOld = NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V3A9ItemOldTag, 0)

	gohelper.setActive(self.goNew, not isExistOld)
end

function V3A9_RoleStoryClueView:refreshItemListAnim()
	if self.itemList then
		for i, v in ipairs(self.itemList) do
			self:playItemUnlock(v)
			self:refreshItemSelect(v)
		end
	end
end

function V3A9_RoleStoryClueView:getItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index

		local goParent = gohelper.findChild(self.viewGO, string.format("Left/pos/pos_%d", index))

		item.go = gohelper.clone(self.goClueItem, goParent, tostring(index))

		recthelper.setAnchor(item.go.transform, 0, 0)

		item.goUnlock = gohelper.findChild(item.go, "unlock")
		item.txtName = gohelper.findChildTextMesh(item.go, "unlock/#txt_name")
		item.goLock = gohelper.findChild(item.go, "lock")
		item.goNew = gohelper.findChild(item.go, "#go_new")
		item.goSelect = gohelper.findChild(item.go, "#go_select")
		item.btnClick = gohelper.findChildButtonWithAudio(item.go, "click")

		self.addClickCb(self, item.btnClick, self.onClickItem, self, item)

		item.anim = item.go:GetComponent(gohelper.Type_Animator)
		self.itemList[index] = item
	end

	return item
end

function V3A9_RoleStoryClueView:refreshItem(item, config)
	item.config = config

	if not config then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	self.itemId2Item[config.id] = item

	local isUnlock = self.gameBaseMO:isItemUnlock(config.id)

	if isUnlock then
		local isExist = NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V3A9ItemHasPlayUnlockTag, config.id)

		if not isExist then
			item.anim:Play("lock_idle")
		else
			item.anim:Play("unlock_idle")
		end
	else
		item.anim:Play("lock_idle")
	end

	if not isUnlock then
		gohelper.setActive(item.goNew, false)

		return
	end

	local isExistOld = NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V3A9ItemOldTag, config.id)

	gohelper.setActive(item.goNew, not isExistOld)

	item.txtName.text = string.format("%s.%s", item.index, config.itemName)
end

function V3A9_RoleStoryClueView:refreshItemNew(item)
	if not item.config then
		return
	end

	local config = item.config
	local isUnlock = self.gameBaseMO:isItemUnlock(config.id)

	if not isUnlock then
		gohelper.setActive(item.goNew, false)

		return
	end

	local isExistOld = NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V3A9ItemOldTag, config.id)

	gohelper.setActive(item.goNew, not isExistOld)
end

function V3A9_RoleStoryClueView:refreshItemSelect(item)
	if not item.config then
		return
	end

	local config = item.config
	local isSelect = self:isSelectItem(config.id)

	gohelper.setActive(item.goSelect, isSelect)
end

function V3A9_RoleStoryClueView:playItemUnlock(item)
	if not item.config then
		return
	end

	local config = item.config
	local isUnlock = self.gameBaseMO:isItemUnlock(config.id)

	if isUnlock then
		local isExist = NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V3A9ItemHasPlayUnlockTag, config.id)

		if not isExist then
			NecrologistStoryPlayerPrefs.instance:setExist(NecrologistStoryEnum.PrefsKey.V3A9ItemHasPlayUnlockTag, config.id)
			item.anim:Play("unlock")
		end
	end
end

function V3A9_RoleStoryClueView:isSelectItem(itemId)
	return self._selectItemId == itemId
end

function V3A9_RoleStoryClueView:setSelectId(itemId, notUpdate)
	if self._selectItemId == itemId then
		return
	end

	local lastItemId = self._selectItemId

	self._selectItemId = itemId

	if self.gameBaseMO:isItemUnlock(itemId) then
		NecrologistStoryPlayerPrefs.instance:setExist(NecrologistStoryEnum.PrefsKey.V3A9ItemOldTag, itemId)
	end

	if notUpdate then
		return
	end

	local lastItem = self.itemId2Item[lastItemId]

	if lastItem then
		self:refreshItemSelect(lastItem)
		self:refreshItemNew(lastItem)
	end

	local item = self.itemId2Item[itemId]

	if item then
		self:refreshItemSelect(item)
		self:refreshItemNew(item)
	end

	self.animRight:Play("refresh", 0, 0)
end

function V3A9_RoleStoryClueView:refreshRight()
	local config = NecrologistStoryV3A9Config.instance:getItemConfig(self._selectItemId)

	if not config then
		return
	end

	local isUnlock = self.gameBaseMO:isItemUnlock(config.id)

	if not isUnlock then
		self.txtName.text = "???"
		self.txtDesc.text = config.sourceDesc
		self.txtTips.text = ""

		self.simagePic:LoadImage(ResUrl.getRoleStoryIcon("3054/rolestory_3054_level_empty"))

		return
	end

	self.txtName.text = config.itemName
	self.txtDesc.text = config.itemDesc1
	self.txtTips.text = config.sourceDesc

	self.simagePic:LoadImage(ResUrl.getRoleStoryIcon(string.format("3054/%s", config.storyPic)))
end

function V3A9_RoleStoryClueView:onDestroyView()
	self.simagePic:UnLoadImage()
end

return V3A9_RoleStoryClueView
