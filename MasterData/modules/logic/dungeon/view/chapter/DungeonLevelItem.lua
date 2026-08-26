-- chunkname: @modules/logic/dungeon/view/chapter/DungeonLevelItem.lua

module("modules.logic.dungeon.view.chapter.DungeonLevelItem", package.seeall)

local DungeonLevelItem = class("DungeonLevelItem", BaseChildView)

function DungeonLevelItem:onInitView()
	self._txt1 = gohelper.findChildText(self.viewGO, "#txt_1")
	self._txtglow = gohelper.findChildText(self.viewGO, "#txt_glow")
	self._txtsection = gohelper.findChildText(self.viewGO, "#txt_section")
	self._goendline = gohelper.findChild(self.viewGO, "#go_endline")
	self._gostartline = gohelper.findChild(self.viewGO, "#go_startline")
	self._gostar = gohelper.findChild(self.viewGO, "#txt_section/star/#go_star")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonLevelItem:addEvents()
	return
end

function DungeonLevelItem:removeEvents()
	return
end

function DungeonLevelItem:_editableInitView()
	local raycast = gohelper.findChild(self.viewGO, "raycast")

	self._click = gohelper.getClick(raycast)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_initStar()
	self:onUpdateParam()
end

function DungeonLevelItem:hideBeforeAnimation()
	if self._animator then
		self._animator:Play(UIAnimationName.Open, 0, 0)

		self._animator.speed = 0

		self._animator:Update(0)
	end
end

function DungeonLevelItem:playAnimation()
	if self._animator then
		self._animator:Play(UIAnimationName.Open, 0, 0)

		self._animator.speed = 1
	end
end

function DungeonLevelItem:_playIsNewAnimation()
	local lastEpisode = DungeonModel.instance:getLastEpisodeShowData()
	local isNew = lastEpisode and lastEpisode.id == self._config.id

	if self._animator then
		self._animator:SetBool("isNew", isNew)
	end
end

function DungeonLevelItem:_initStar()
	local starGo = gohelper.findChild(self.viewGO, "#txt_section/star")

	gohelper.setActive(starGo, true)
	gohelper.setActive(self._gostar, true)

	self._starImgList = self:getUserDataTb_()

	local transform = self._gostar.transform
	local itemCount = transform.childCount

	for i = 1, itemCount do
		local child = transform:GetChild(i - 1)
		local img = child:GetComponent(gohelper.Type_Image)

		table.insert(self._starImgList, img)
	end
end

function DungeonLevelItem:getLineStartTrans()
	return self._gostartline.transform
end

function DungeonLevelItem:getLineEndTrans()
	return self._goendline.transform
end

function DungeonLevelItem:getTrans()
	return self.viewGO.transform
end

function DungeonLevelItem:showStatus()
	local normalEpisodeId = self._config.id
	local hardOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon)

	if normalEpisodeId then
		::label_12_0::

		local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)
		local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)
		local normalEpisodeInfo = self._info
		local hardEpisodeConfig = DungeonConfig.instance:getHardEpisode(self._config.id)

		if hardEpisodeConfig then
			::label_12_1::

			local hardEpisodeInfo = DungeonModel.instance:getEpisodeInfo(hardEpisodeConfig.id)
			local starImg3 = self._starImgList[3]
			local starImg2 = self._starImgList[2]

			self:_setStar(self._starImgList[1], normalEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory)
			gohelper.setActive(starImg2.gameObject, false)
			gohelper.setActive(starImg3.gameObject, false)

			if not string.nilorempty(advancedConditionText) then
				self:_setStar(starImg2, normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and passStory)
				gohelper.setActive(starImg2.gameObject, true)

				if hardEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and hardOpen and passStory then
					self:_setStar(starImg3, hardEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory)
					gohelper.setActive(starImg3.gameObject, true)
				end
			end
		end
	end
end

function DungeonLevelItem:_setStar(image, light)
	local star = light and "star_liang" or "star_an"

	UISpriteSetMgr.instance:setUiFBSprite(image, star)

	if light then
		gohelper.setAsLastSibling(image.gameObject)
	end
end

function DungeonLevelItem:setGray(gray)
	if gray and not self._graphicsContainer then
		self._graphicsContainer = self:getUserDataTb_()
		self._graphicsContainer.images = self.viewGO:GetComponentsInChildren(gohelper.Type_Image, true)
		self._graphicsContainer.tmps = self.viewGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)
	end

	if self._graphicsContainer then
		local iter = self._graphicsContainer.images:GetEnumerator()

		while iter:MoveNext() do
			ZProj.UGUIHelper.SetGrayscale(iter.Current.gameObject, gray)
		end

		local iter = self._graphicsContainer.tmps:GetEnumerator()

		while iter:MoveNext() do
			ZProj.UGUIHelper.SetGrayscale(iter.Current.gameObject, gray)
		end
	end
end

function DungeonLevelItem.showEpisodeName(config, chapterIndex, episodeIndex, txt)
	txt.text = DungeonController.getEpisodeName(config)
end

function DungeonLevelItem:hasUnlockContent()
	local openList = OpenConfig.instance:getOpenShowInEpisode(self._config.id)
	local unlockEpisodeList = DungeonConfig.instance:getUnlockEpisodeList(self._config.id)
	local openGroupList = OpenConfig.instance:getOpenGroupShowInEpisode(self._config.id)

	if openList or unlockEpisodeList or openGroupList then
		::label_16_0::

		local showContent = not DungeonModel.instance:hasPassLevelAndStory(self._config.id)
		local showEpisode = self._config.unlockEpisode > 0 and not DungeonModel.instance:hasPassLevelAndStory(self._config.unlockEpisode)

		return showContent or showEpisode
	end
end

function DungeonLevelItem:addUnlockItem(go)
	local item = MonoHelper.addLuaComOnceToGo(go, DungeonChapterUnlockItem, self._config)
end

function DungeonLevelItem:onUpdateParam()
	self._config = self.viewParam[1]
	self._info = self.viewParam[2]
	self._chapterIndex = self.viewParam[3]
	self._levelIndex = self.viewParam[4]

	DungeonLevelItem.showEpisodeName(self._config, self._chapterIndex, self._levelIndex, self._txtsection)

	self._txt1.text = self._config.name
	self._txtglow.text = self._config.name

	self:showStatus()

	if DungeonModel.isBattleEpisode(self._config) then
		local iconParam = string.splitToNumber(self._config.icon, "#")
		local iconType = iconParam[1]
		local iconId = iconParam[2]
		local config, icon

		if iconType and iconId then
			config, icon = ItemModel.instance:getItemConfigAndIcon(iconType, iconId)
		end
	end

	local isCanChallenge = DungeonModel.instance:isCanChallenge(self._config)

	self:setGray(not isCanChallenge)
	self:_playIsNewAnimation()
end

function DungeonLevelItem:_onClickHandler()
	if not DungeonModel.isBattleEpisode(self._config) then
		local toastParam = DungeonModel.instance:getCantChallengeToast(self._config)

		if toastParam then
			GameFacade.showToast(ToastEnum.CantChallengeToast, toastParam)

			return
		end
	end

	DungeonController.instance:enterLevelView(self.viewParam)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, self)
end

function DungeonLevelItem:onOpen()
	self._click:AddClickListener(self._onClickHandler, self)
end

function DungeonLevelItem:onClose()
	self._click:RemoveClickListener()
end

function DungeonLevelItem:onDestroyView()
	return
end

return DungeonLevelItem
