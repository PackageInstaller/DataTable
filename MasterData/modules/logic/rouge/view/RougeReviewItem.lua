-- chunkname: @modules/logic/rouge/view/RougeReviewItem.lua

module("modules.logic.rouge.view.RougeReviewItem", package.seeall)

local RougeReviewItem = class("RougeReviewItem", ListScrollCellExtend)

function RougeReviewItem:onInitView()
	self._goUnlocked = gohelper.findChild(self.viewGO, "#go_Unlocked")
	self._simageItemPic = gohelper.findChildSingleImage(self.viewGO, "#go_Unlocked/#simage_ItemPic")
	self._gonew = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_new")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Unlocked/#txt_Name")
	self._txtNameEn = gohelper.findChildText(self.viewGO, "#go_Unlocked/#txt_Name/#txt_NameEn")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Unlocked/#btn_Play")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_desc")
	self._txtUnknown = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_Unknown")
	self._goLine = gohelper.findChild(self.viewGO, "#go_Line")
	self._goLine1 = gohelper.findChild(self.viewGO, "#go_Line/#go_Line1")
	self._goLine2 = gohelper.findChild(self.viewGO, "#go_Line/#go_Line2")
	self._goLine3 = gohelper.findChild(self.viewGO, "#go_Line/#go_Line3")
	self._goLine4 = gohelper.findChild(self.viewGO, "#go_Line/#go_Line4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeReviewItem:addEvents()
	self._btnPlay:AddClickListener(self._btnPlayOnClick, self)
end

function RougeReviewItem:removeEvents()
	self._btnPlay:RemoveClickListener()
end

function RougeReviewItem:_btnPlayOnClick()
	local levelIdDict = {}

	if not string.nilorempty(self._config.levelIdDict) then
		local levelIdPairs = string.split(self._config.levelIdDict, "|")

		for _, levelIdPair in ipairs(levelIdPairs) do
			local levelIdParam = string.splitToNumber(levelIdPair, "#")

			levelIdDict[levelIdParam[1]] = levelIdParam[2]
		end
	end

	local data = {}

	data.levelIdDict = levelIdDict
	data.isReplay = true

	StoryController.instance:playStories(self._mo.storyIdList, data)

	if self._showNewFlag then
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(season, RougeEnum.FavoriteType.Story, self._mo.config.id, self._updateNewFlag, self)
	end
end

function RougeReviewItem:_editableInitView()
	return
end

function RougeReviewItem:_editableAddEvents()
	return
end

function RougeReviewItem:_editableRemoveEvents()
	return
end

function RougeReviewItem:setIndex(index)
	self._index = index
end

function RougeReviewItem:onUpdateMO(mo, isEnd, reviewView, nodeStoryList, path)
	self._mo = mo
	self._config = mo.config
	self._isEnd = isEnd
	self._reviewView = reviewView
	self._path = path

	self:_updateInfo()
	self:_initNodes(nodeStoryList)
	self:_updateNewFlag()
end

function RougeReviewItem:_updateNewFlag()
	self._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Story, self._mo.config.id) ~= nil

	gohelper.setActive(self._gonew, self._showNewFlag)
end

function RougeReviewItem:_initNodes(nodeStoryList)
	if not self._isUnlock then
		return
	end

	if not nodeStoryList or #nodeStoryList <= 1 then
		local showLine = not self._isEnd

		gohelper.setActive(self._goLine1, showLine)

		if nodeStoryList and showLine then
			for i, v in ipairs(nodeStoryList) do
				self:_showNodeText(v, self._goLine1, i)
			end
		end

		return
	end

	local goLine = self["_goLine" .. #nodeStoryList]

	gohelper.setActive(goLine, true)

	for i, v in ipairs(nodeStoryList) do
		local node = gohelper.findChild(goLine, "#go_End" .. i)
		local nodeGo = self._reviewView:getResInst(self._path, node, "item" .. v.config.id)
		local nodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(nodeGo, RougeReviewItem)

		nodeItem._showLock = true

		nodeItem:onUpdateMO(v, true)
		self:_showNodeText(v, goLine, i)
	end
end

function RougeReviewItem:_showNodeText(storyMo, go, index)
	local isUnlock = storyMo and self:_isUnlockStory(storyMo)

	if isUnlock then
		local txt = gohelper.findChildText(go, string.format("image_Line/image_Line%s/#txt_Descr%s", index, index))

		txt.text = storyMo.config.desc
	end
end

function RougeReviewItem:_updateInfo()
	self._isUnlock = self:_isUnlockStory(self._mo)

	gohelper.setActive(self._goUnlocked, self._isUnlock)

	if not self._showLock then
		local canShowLock = self._index == 1

		gohelper.setActive(self._goLocked, not self._isUnlock and canShowLock)

		if not self._isUnlock then
			return
		end

		self._txtName.text = self._config.name
		self._txtNameEn.text = self._config.nameEn

		self._simageItemPic:LoadImage(self._config.image)
	end
end

function RougeReviewItem:isUnlock()
	return self._isUnlock
end

function RougeReviewItem:setMaxUnlockStateId(id)
	self._maxUnlockStateId = id
end

function RougeReviewItem:_isUnlockStory(mo)
	if self._maxUnlockStateId and self._maxUnlockStateId >= mo.config.stageId then
		return true
	end

	local storyList = mo.storyIdList
	local storyId = storyList[#storyList]

	return RougeOutsideModel.instance:storyIsPass(storyId)
end

function RougeReviewItem:onDestroyView()
	return
end

return RougeReviewItem
