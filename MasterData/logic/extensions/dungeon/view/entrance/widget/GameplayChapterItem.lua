-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/widget/GameplayChapterItem.lua

module("logic.extensions.dungeon.view.entrance.widget.GameplayChapterItem", package.seeall)

local M = class("GameplayChapterItem", SimpleCellComponent)

function M:buildUI()
	self._btnClick = self._registry:getBtn("fight_entry_chapter_item_-2105435664")
	self._txtName = self._registry:getText("fight_entry_chapter_item_-1106906654")
	self._txtChapter = self._registry:getText("fight_entry_chapter_item_-702278482")
	self._txtPart = self._registry:getText("fight_entry_chapter_item_503559015")
	self._txtNormalProgress = self._registry:getText("fight_entry_chapter_item_1035518643")
	self._txtSpecialProgress = self._registry:getText("fight_entry_chapter_item_2032053318")
	self._txtLock = self._registry:getText("fight_entry_chapter_item_1772351753")
	self._goLock = self._registry:getGo("fight_entry_chapter_item_-1970950902")
	self._imgChapter = self._registry:getImage("fight_entry_chapter_item_-82559705")
	self._imgChapterLock = self._registry:getImage("fight_entry_chapter_item_-1421483943")
	self._canvasGroup = self._go:GetComponent(ComponentType.CanvasGroup)
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:bindDispatcherEvent()
	return
end

function M:unbindDispatcherEvent()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_onClick()
	if self._callback then
		self._callback()
	else
		self:_onClickChapter()
	end
end

function M:updateData(data)
	self._callback = data.callback

	local chapterMOList = data.mo

	self._chapterMOList = chapterMOList
	self._chapterMO = chapterMOList[1]

	self:_refreshCell()
	self:setActive(true)
end

function M:_tryShowUnlockAnim()
	local hasShow = DungeonMainLineChapterModel.instance:getDungeonChapterCache(self._chapterMO:getChapterId())

	if not hasShow and self._chapterMO:getIsChapterUnlock() then
		-- block empty
	end
end

function M:_refreshCell()
	local chapterCO = self._chapterMO:getChapterCO()

	IconLoader.setSprite(self._imgChapter, IconType.Mainline, string.format("fight_chapter/%s", chapterCO.iconRes))
	IconLoader.setSprite(self._imgChapterLock, IconType.Mainline, string.format("fight_chapter/%s", chapterCO.iconRes))

	local hasRedDot = self:_chapterHasRedDot()
	local isChpaterUnlock = self._chapterMO:getIsChapterUnlock()

	if isChpaterUnlock then
		goutil.setActive(self._goLock, false)
	else
		goutil.setActive(self._goLock, true)

		self._txtLock.text = self:_parseForLockStr()
	end

	goutil.setActive(self._goLock, not isChpaterUnlock)
	goutil.setActive(self._imgChapterLock.gameObject, not isChpaterUnlock)

	local partImgName = GameplayEntranceEnum.MainLinePartName[chapterCO.chapterId]

	goutil.setActive(self._txtPart.gameObject, partImgName)

	if partImgName then
		self._txtPart.text = partImgName
	end

	local chineseIdxKey = string.format("tip_chinese_%d", chapterCO.chapterId)
	local chapterIdxName = string.format(lang("tip_chapter_title_1"), lang(chineseIdxKey))

	self._txtChapter.text = chapterIdxName

	local chapterName = string.gsub(chapterCO.name, "partA", "")

	chapterName = string.gsub(chapterName, "partB", "")
	self._txtName.text = chapterName

	local normalMo = self._chapterMOList[1]
	local hardMo = self._chapterMOList[2]

	self._txtNormalProgress.text = ""
	self._txtSpecialProgress.text = ""

	if normalMo then
		self._txtNormalProgress.text = normalMo:getUnlockDungeonCount() .. "/" .. TableUtil.getLen(normalMo:getDungeonIds())
	end

	if hardMo then
		self._txtSpecialProgress.text = hardMo:getUnlockDungeonCount() .. "/" .. TableUtil.getLen(hardMo:getDungeonIds())
	end
end

function M:_parseForLockStr()
	return self._chapterMO:getChapterLockString()
end

function M:_onClickChapter()
	if not self._chapterMO:getIsChapterUnlock() then
		local hint = string.format(lang("tip_player_not_reach_level"), StringUtil.convertLevel(self._chapterMO:getChapterCO().unlockLv))

		FloatWordMgr.instance:show(hint)

		return
	end

	local chapterId = self._chapterMO:getChapterId()
	local difficulty = 1
	local chapterInfo = {}
	local info = Astral.LocalStorage.Instance:GetString("mainline_record")
	local id = Astral.LocalStorage.Instance:GetString("dungeon_latest_id")

	chapterInfo.chapterId = chapterId
	chapterInfo.dungeonIndex = self._chapterMO:getLastUnlockDungeonIndex() or 1
	chapterInfo.difficulty = difficulty
	chapterInfo.needShowChapterSelect = true

	DungeonMainLineChapterModel.instance:tryEnterChapterScene(false, chapterInfo)
end

function M:execClick()
	self:_onClickChapter()
end

function M:setHighLight(isHighLight)
	self._isHighLight = isHighLight
end

function M:getHighLight()
	return self._isHighLight
end

function M:_chapterHasRedDot()
	local normalRedDot = self._chapterMO:hasRedDot()

	if normalRedDot then
		return true
	end

	if #self._chapterMOList > 1 then
		local chapterMO = self._chapterMOList[2]

		return chapterMO:hasRedDot()
	end

	return false
end

return M
