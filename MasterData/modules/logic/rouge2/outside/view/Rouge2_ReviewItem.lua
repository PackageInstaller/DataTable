-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_ReviewItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_ReviewItem", package.seeall)

local Rouge2_ReviewItem = class("Rouge2_ReviewItem", LuaCompBase)

function Rouge2_ReviewItem:init(go)
	self.go = go
	self._goUnlocked = gohelper.findChild(self.go, "#go_Unlocked")
	self._simageItemPic = gohelper.findChildSingleImage(self.go, "#go_Unlocked/#simage_ItemPic")
	self._gonew = gohelper.findChild(self.go, "#go_Unlocked/#go_new")
	self._txtName = gohelper.findChildText(self.go, "#go_Unlocked/#txt_Name")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.go, "#go_Unlocked/#btn_Play")
	self._imagePlay = gohelper.findChildImage(self.go, "#go_Unlocked/#btn_Play")
	self._goLocked = gohelper.findChild(self.go, "#go_Locked")
	self._goLine = gohelper.findChild(self.go, "#go_Line")
	self._goLine1 = gohelper.findChild(self.go, "#go_Line/#go_Line1")
	self._goLine2 = gohelper.findChild(self.go, "#go_Line/#go_Line2")
	self._goLine3 = gohelper.findChild(self.go, "#go_Line/#go_Line3")
	self._goLine4 = gohelper.findChild(self.go, "#go_Line/#go_Line4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ReviewItem:addEventListeners()
	self._btnPlay:AddClickListener(self._btnPlayOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnAVGScrollViewValueChanged, self.onScrollValueChanged, self)
end

function Rouge2_ReviewItem:removeEventListeners()
	self._btnPlay:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnAVGScrollViewValueChanged, self.onScrollValueChanged, self)
end

function Rouge2_ReviewItem:_btnPlayOnClick()
	if not string.nilorempty(self._config.eventId) then
		local param = {}

		param.config = Rouge2_OutSideConfig.instance:getIllustrationConfig(tonumber(self._config.eventId))
		param.displayType = Rouge2_OutsideEnum.IllustrationDetailType.Story

		Rouge2_ViewHelper.openRougeIllustrationDetailView(param)

		return
	end

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
end

function Rouge2_ReviewItem:_editableInitView()
	self.animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)
	self._subItem = {}
end

function Rouge2_ReviewItem:setIndex(index)
	self._index = index
end

function Rouge2_ReviewItem:onUpdateMO(mo, isEnd, reviewView, nodeStoryList, path, scrollGo)
	self._mo = mo
	self._config = mo.config
	self._isEnd = isEnd
	self._reviewView = reviewView
	self._path = path
	self.scrollGo = scrollGo

	self:_updateInfo()
	self:_initNodes(nodeStoryList)
	self:_updateNewFlag()
end

function Rouge2_ReviewItem:onScrollValueChanged()
	self:checkRedDot()
end

function Rouge2_ReviewItem:_updateNewFlag()
	self._reddotComp = Rouge2_OutsideRedDotComp.Get(self._gonew, self._btnPlay.gameObject, self.scrollGo)

	local config = self._mo.config
	local uid

	self._reddotComp:intReddotInfo(RedDotEnum.DotNode.V3a2_Rouge_Review_AVG, not string.nilorempty(config.eventId) and tonumber(config.eventId) or tonumber(self._mo.storyIdList[#self._mo.storyIdList]), Rouge2_OutsideEnum.LocalData.Avg)

	self._showNewFlag = self._reddotComp._isDotShow

	self:checkRedDot()
end

function Rouge2_ReviewItem:checkRedDot()
	if self._reddotComp and self._reddotComp._isDotShow then
		logNormal("check")

		local unlock = self._reddotComp:refresh()

		if unlock then
			self.animator:Play("unlock", 0, 0)
		else
			self.animator:Play("idle", 0, 0)
		end
	end
end

function Rouge2_ReviewItem:_initNodes(nodeStoryList)
	if not nodeStoryList or #nodeStoryList <= 1 then
		local showLine = not self._isEnd

		gohelper.setActive(self._goLine1, showLine)

		if nodeStoryList and showLine then
			for i, v in ipairs(nodeStoryList) do
				self:_showNodeText(v, self._goLine1, i, 1)
			end
		end

		return
	end

	local nodeStoryCount = #nodeStoryList
	local goLine = self["_goLine" .. nodeStoryCount]

	gohelper.setActive(goLine, true)

	for i, v in ipairs(nodeStoryList) do
		local nodeItem

		if not self._subItem[i] then
			local node = gohelper.findChild(goLine, "#go_End" .. i)
			local nodeGo = self._reviewView:getResInst(self._path, node, "item" .. v.config.id)

			nodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(nodeGo, Rouge2_ReviewItem)

			table.insert(self._subItem, nodeItem)
		else
			nodeItem = self._subItem[i]
		end

		nodeItem._showLock = true

		nodeItem:onUpdateMO(v, true, nil, nil, nil, self.scrollGo)
		self:_showNodeText(v, goLine, i, nodeStoryCount)
	end
end

function Rouge2_ReviewItem:_showNodeText(storyMo, go, index, nodeStoryCount)
	local isUnlock = storyMo and self:_isUnlockStory(storyMo)

	if isUnlock then
		local path = nodeStoryCount <= 1 and string.format("image_Line/image_Line%s/#txt_Descr%s", index, index) or string.format("image_Line/image_Line2/image_Line%s/#txt_Descr%s", index, index)
		local txt = gohelper.findChildTextMesh(go, path)

		if txt then
			txt.text = storyMo.config.desc
		else
			logError("Rouge2_ReviewItem txt is not exist  path:" .. path)
		end
	end
end

function Rouge2_ReviewItem:_updateInfo()
	self._isUnlock = self:_isUnlockStory(self._mo)

	gohelper.setActive(self._goUnlocked, self._isUnlock)

	local canShowLock = true

	gohelper.setActive(self._goLocked, not self._isUnlock and canShowLock)

	if not self._isUnlock then
		return
	end

	self._imagePlay.enabled = string.nilorempty(self._config.eventId)
	self._txtName.text = self._config.name

	if not string.nilorempty(self._config.eventId) then
		local illustrationConfig = Rouge2_OutSideConfig.instance:getIllustrationConfig(tonumber(self._config.eventId))

		self._simageItemPic:LoadImage(ResUrl.getRouge2Icon("small/" .. illustrationConfig.image))
	else
		self._simageItemPic:LoadImage(ResUrl.getRouge2Icon("small/" .. self._config.fullImage))
	end
end

function Rouge2_ReviewItem:isUnlock()
	return self._isUnlock
end

function Rouge2_ReviewItem:setMaxUnlockStateId(id)
	self._maxUnlockStateId = id
end

function Rouge2_ReviewItem:_isUnlockStory(mo)
	if self._maxUnlockStateId and self._maxUnlockStateId >= mo.config.stageId then
		return true
	end

	if not string.nilorempty(mo.config.eventId) then
		local illustrationId = tonumber(mo.config.eventId)
		local illustrationConfig = Rouge2_OutSideConfig.instance:getIllustrationConfig(illustrationId)

		return illustrationConfig and Rouge2_OutsideModel.instance:passedEventId(illustrationConfig.eventId)
	else
		local storyList = mo.storyIdList
		local storyId = storyList[#storyList]

		return Rouge2_OutsideModel.instance:storyIsPass(storyId)
	end
end

function Rouge2_ReviewItem:onDestroy()
	return
end

return Rouge2_ReviewItem
