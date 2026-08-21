-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/RedMistChapterCell.lua

module("logic.extensions.dungeon.view.equipdungeon.RedMistChapterCell", package.seeall)

local M = class("RedMistChapterCell", SimpleCellComponent)

function M:ctor(container)
	self.super.ctor(self, container)

	self._clickHandler = Handler.New()
	self._dropGoList = {}
end

function M:buildUI()
	self._textName = self._registry:getText("red_mist_chapter_item_1470325876")
	self._textHint = self._registry:getText("red_mist_chapter_item_-959429007")
	self._imgBg = Astral.ImageDynIcon.Get(self._registry:getGo("red_mist_chapter_item_-1958521298"))
	self._imgLockBg = Astral.ImageDynIcon.Get(self._registry:getGo("red_mist_chapter_item_1688166275"))
	self._btnClick = self._registry:getBtn("red_mist_chapter_item_-215230638")
	self._btnLock = self._registry:getBtn("red_mist_chapter_item_1688166275")
	self._goLock = self._registry:getGo("red_mist_chapter_item_1688166275")
	self._textLock = self._registry:getText("red_mist_chapter_item_-1929773247")
	self._transfItemRoot = self._registry:getRectTransform("red_mist_chapter_item_589722329")
	self._goItemPrefab = self._registry:getGo("0&rewards_detail_item_2141037416")
	self._doubleHint = self._registry:getGo("1&com_multiple_rewards_hint_2109480314")

	goutil.setActive(self._goItemPrefab, false)
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
	self._btnLock:AddClickListener(self._onClickLock, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
	self._btnLock:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	self._clickHandler:clear()

	self._clickHandler = nil
	self._dropGoList = nil
end

function M:_setData(chapterMo, systemEnum, clickFunc, clickObj)
	self._chapterMo = chapterMo
	self._systemEnum = systemEnum
	self._chapterId = self._chapterMo:getChapterId()

	self._clickHandler:setListener(clickFunc, clickObj)
end

function M:_refreshUI()
	self._textName.text = self._chapterMo:getName()
	self._textHint.text = self._chapterMo:getDesc()

	self._imgBg:SetImage(self:_getImgUrl())
	self._imgLockBg:SetImage(self:_getImgUrl())

	local isLock = not self._chapterMo:getIsChapterUnlock()

	goutil.setActive(self._goLock, isLock)

	if isLock then
		self._textLock.text = self._chapterMo:getLockStr()
	end

	self:_refresDropItems()
	self:setMultipleDrop()
end

function M:_getImgUrl()
	local imgName = self._chapterMo:getIconRes1()

	return string.format("ui/bigbg/resources_explore/red_mist_banner/%s.png", imgName)
end

function M:_refresDropItems()
	local dropItems = self._chapterMo:getDropItems()

	for _, go in pairs(self._dropGoList) do
		goutil.setActive(go, false)
	end

	for i, itemId in ipairs(dropItems) do
		local go = self._dropGoList[i]

		if not go then
			go = goutil.cloneAndSetParent(self._goItemPrefab, self._transfItemRoot)
			self._dropGoList[i] = go
		end

		local cell = Astral.SimpleLuaComponentContainer.Add(go, RewardCell)
		local rewardData = RewardData.New({
			code = itemId
		})

		cell:updateData(rewardData)
		goutil.setActive(go, true)
	end
end

function M:_onClickSelf()
	self:_onClickItem()
end

function M:_onClickLock()
	self:_onClickItem()
end

function M:_onClickItem()
	if not self._chapterMo:getIsChapterUnlock() then
		FloatWordMgr.instance:show(self._chapterMo:getLockStr())
	else
		self._clickHandler:call(self._chapterMo)
	end
end

function M:setMultipleDrop()
	local itemList = self._chapterMo:getDropItems()
	local dungeonType = self._chapterMo:getDungeonType()

	if MultipleDropController.instance:equipIsOpen() then
		local tableT = MultipleDropController.instance:getLeftNumberByTypeAndReward(dungeonType, itemList)

		if tableT.times ~= "" and tableT.leftNumber ~= 0 then
			goutil.setActive(self._doubleHint.gameObject, true)
		else
			goutil.setActive(self._doubleHint.gameObject, false)
		end
	else
		goutil.setActive(self._doubleHint.gameObject, false)
	end
end

return M
