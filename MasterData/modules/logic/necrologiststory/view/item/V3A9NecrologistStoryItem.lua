-- chunkname: @modules/logic/necrologiststory/view/item/V3A9NecrologistStoryItem.lua

module("modules.logic.necrologiststory.view.item.V3A9NecrologistStoryItem", package.seeall)

local V3A9NecrologistStoryItem = class("V3A9NecrologistStoryItem", NecrologistStoryBaseItem)

function V3A9NecrologistStoryItem:onInit()
	self.btnClue = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_clue")
	self.goRecord = gohelper.findChild(self.viewGO, "Record")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "Record/#txt_name")
	self.optionList = {}

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.goRecord, string.format("option_%d", i))
		item.btnRecord = gohelper.findChildButtonWithAudio(item.go, "#btn_record")
		item.goHasRecord = gohelper.findChild(item.go, "#go_hasRecord")
		item.txtDesc = gohelper.findChildTextMesh(item.go, "ScrollView/Viewport/Content/#txt_desc")

		if item.btnRecord then
			self.addClickCb(self, item.btnRecord, self.onClickRecordItem, self, item)

			item.goSelect = gohelper.findChild(item.go, "#btn_record/#go_select")

			gohelper.setActive(item.goSelect, false)
		end

		self.optionList[i] = item
	end

	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function V3A9NecrologistStoryItem:onAddEvent()
	self.addClickCb(self, self.btnClue, self.onClickBtn, self)
end

function V3A9NecrologistStoryItem:onRemoveEvent()
	self:removeClickCb(self.btnClue)
end

function V3A9NecrologistStoryItem:onClickBtn()
	if self.isClicked then
		return
	end

	self.isClicked = true

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_task_page)
	gohelper.setActive(self.btnClue, false)
	gohelper.setActive(self.goRecord, true)
	self.anim:Play("switch")
	self:refreshRecord()
end

function V3A9NecrologistStoryItem:onPlayStory(isSkip)
	self.isClicked = false
	self.isRecorded = false

	gohelper.setActive(self.btnClue, true)
	gohelper.setActive(self.goRecord, false)
end

function V3A9NecrologistStoryItem:refreshRecord(itemId)
	local hasRecord = itemId ~= nil

	if hasRecord then
		for i = 1, 2 do
			local item = self.optionList[i]

			gohelper.setActive(item.goSelect, itemId == item.config.id)
			self:refreshItem(item)
		end

		local config = NecrologistStoryV3A9Config.instance:getItemConfig(itemId)

		self:refreshItem(self.optionList[3], config)
	else
		local storyConfig = self:getStoryConfig()
		local groupId = tonumber(storyConfig.param)
		local itemList = NecrologistStoryV3A9Config.instance:getItemListByGroupId(groupId)

		for i = 1, 2 do
			local item = self.optionList[i]
			local config = itemList[i]

			self:refreshItem(item, config)
		end

		self:refreshItem(self.optionList[3])
	end
end

function V3A9NecrologistStoryItem:refreshItem(item, config)
	if not item then
		return
	end

	item.config = config

	if not config then
		return
	end

	item.txtDesc.text = config.itemDesc1
	self.txtName.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v3a9_rolestoryinteractitem_title_txt"), config.group, config.itemName)

	gohelper.setActive(item.go, true)
end

function V3A9NecrologistStoryItem:onClickRecordItem(item)
	if self.isRecorded then
		return
	end

	local config = item.config

	if not config then
		return
	end

	self.isRecorded = true

	self:refreshRecord(config.id)
	self.anim:Play("select")

	local gameMo = NecrologistStoryModel.instance:getById(NecrologistStoryEnum.RoleStoryId.V3A9)

	if gameMo then
		gameMo:setItemUnlock(config.id)
	end

	self:onPlayFinish(true)
end

function V3A9NecrologistStoryItem:caleHeight()
	return 400
end

function V3A9NecrologistStoryItem:isDone()
	return self.isRecorded
end

function V3A9NecrologistStoryItem:onDestroy()
	return
end

function V3A9NecrologistStoryItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/v3a9_rolestoryinteractitem.prefab"
end

return V3A9NecrologistStoryItem
