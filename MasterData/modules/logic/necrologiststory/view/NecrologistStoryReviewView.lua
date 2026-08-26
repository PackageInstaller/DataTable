-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryReviewView.lua

module("modules.logic.necrologiststory.view.NecrologistStoryReviewView", package.seeall)

local NecrologistStoryReviewView = class("NecrologistStoryReviewView", BaseView)

function NecrologistStoryReviewView:onInitView()
	self._goBgCg = gohelper.findChild(self.viewGO, "#go_bgcg")
	self.bgCgCtrl = self._goBgCg:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self.animBgCg = self._goBgCg:GetComponent(typeof(UnityEngine.Animator))
	self._goUnlockedBg = gohelper.findChild(self._goBgCg, "unlocked")
	self._unlocksimagecgbg = gohelper.findChildSingleImage(self._goUnlockedBg, "#simage_cgbg")
	self._unlockimagecgbg = gohelper.findChildImage(self._goUnlockedBg, "#simage_cgbg")
	self._goLockedBg = gohelper.findChild(self._goBgCg, "locked")
	self._locksimagecgbg = gohelper.findChildSingleImage(self._goLockedBg, "bgmask/#simage_cgbg")
	self._lockimagecgbg = gohelper.findChildImage(self._goLockedBg, "bgmask/#simage_cgbg")
	self.goScroll = gohelper.findChild(self.viewGO, "#scroll_content")
	self.goContent = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content")
	self.goItem = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content/goItem")
	self.goItem1 = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content/go_item1")
	self.goItem2 = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content/go_item2")

	gohelper.setActive(self.goItem, false)
	gohelper.setActive(self.goItem1, false)
	gohelper.setActive(self.goItem2, false)

	self.itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryReviewView:addEvents()
	return
end

function NecrologistStoryReviewView:removeEvents()
	return
end

function NecrologistStoryReviewView:_editableInitView()
	return
end

function NecrologistStoryReviewView:onClickStoryItem(item)
	local plotCo = item.plotCo

	if not plotCo then
		return
	end

	local isFinish = self.gameMo:isStoryFinish(plotCo.id)

	if not isFinish then
		return
	end

	self.selectId = plotCo.id

	NecrologistStoryController.instance:openStoryView(plotCo.id)
	self:refreshStoryList()
end

function NecrologistStoryReviewView:onOpen()
	self:refreshParam()
	self:refreshRoleStoryBg()
	self:refreshStoryList()
end

function NecrologistStoryReviewView:refreshParam()
	self.storyId = self.viewParam.roleStoryId
	self.cgUnlock = self.viewParam.cgUnlock
	self.gameMo = NecrologistStoryModel.instance:getGameMO(self.storyId)
end

function NecrologistStoryReviewView:refreshStoryList()
	if self.cgUnlock then
		gohelper.setActive(self.goScroll, false)

		return
	end

	gohelper.setActive(self.goScroll, true)

	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(self.storyId)

	for i = 1, math.max(#plotList, #self.itemList) do
		local item = self:createItem(i)

		self:refreshItem(item, plotList[i])
	end
end

function NecrologistStoryReviewView:createItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.goParent = gohelper.cloneInPlace((index % 2 == 0 or nil) and self.goItem2, tostring(index))
		item.go = gohelper.clone(self.goItem, item.goParent, "item")

		gohelper.setActive(item.go, true)

		item.normalItem = self:getUserDataTb_()
		item.normalItem.go = gohelper.findChild(item.go, "go_normalbg")
		item.normalItem.txtIndex = gohelper.findChildTextMesh(item.normalItem.go, "txtIndex")
		item.normalItem.txtTitle = gohelper.findChildTextMesh(item.normalItem.go, "txtTitle")
		item.normalItem.txtTitleEn = gohelper.findChildTextMesh(item.normalItem.go, "txtTitleEn")
		item.selectItem = self:getUserDataTb_()
		item.selectItem.go = gohelper.findChild(item.go, "go_selectbg")
		item.selectItem.txtIndex = gohelper.findChildTextMesh(item.selectItem.go, "txtIndex")
		item.selectItem.txtTitle = gohelper.findChildTextMesh(item.selectItem.go, "txtTitle")
		item.selectItem.txtTitleEn = gohelper.findChildTextMesh(item.selectItem.go, "txtTitleEn")
		item.btn = gohelper.findButtonWithAudio(item.go)

		item.btn:AddClickListener(self.onClickStoryItem, self, item)

		item.goBranch = gohelper.findChild(item.go, "go_fencha")
		self.itemList[index] = item
	end

	return item
end

function NecrologistStoryReviewView:refreshItem(item, plotCo)
	item.plotCo = plotCo

	if not plotCo then
		gohelper.setActive(item.goParent, false)

		return
	end

	local isFinish = self.gameMo:isStoryFinish(plotCo.id)

	if not isFinish then
		gohelper.setActive(item.goParent, false)

		return
	end

	gohelper.setActive(item.goParent, true)

	local isSelect = self.selectId == plotCo.id

	gohelper.setActive(item.selectItem.go, isSelect)
	gohelper.setActive(item.normalItem.go, not isSelect)

	if isSelect then
		if not item.selectItem then
			local txtItem = item.normalItem

			txtItem.txtIndex.text = string.format("%02d", item.index)
			txtItem.txtTitle.text = plotCo.storyName
			txtItem.txtTitleEn.text = plotCo.storyNameEn

			gohelper.setActive(item.goBranch, plotCo.branch == 1)

			if plotCo.branch == 1 then
				NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.ShowBranch)
			end
		end
	end
end

function NecrologistStoryReviewView:refreshRoleStoryBg()
	gohelper.setActive(self._goBgCg, true)

	local storyCo = RoleStoryConfig.instance:getStoryById(self.storyId)
	local cgUnlockStoryId = storyCo.cgUnlockStoryId
	local unlock = cgUnlockStoryId == 0 or self.gameMo:isStoryFinish(cgUnlockStoryId)

	if unlock and (self.cgUnlock or RoleStoryModel.instance:canPlayDungeonUnlockAnim(self.storyId)) then
		if ViewMgr.instance:isOpen(ViewName.NecrologistStoryView) then
			gohelper.setActive(self._goUnlockedBg, false)
			gohelper.setActive(self._goLockedBg, true)
			self.animBgCg:Play("idle")
			self:refreshRoleStoryLockBg(storyCo)
		else
			RoleStoryModel.instance:setPlayDungeonUnlockAnimFlag(self.storyId)
			gohelper.setActive(self._goUnlockedBg, true)
			gohelper.setActive(self._goLockedBg, true)
			self:refreshRoleStoryUnlockBg(storyCo)
			self:refreshRoleStoryLockBg(storyCo)
			self.animBgCg:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	else
		gohelper.setActive(self._goUnlockedBg, unlock)
		gohelper.setActive(self._goLockedBg, not unlock)
		self.animBgCg:Play("idle")

		if unlock then
			self:refreshRoleStoryUnlockBg(storyCo)
		else
			self:refreshRoleStoryLockBg(storyCo)
		end
	end
end

function NecrologistStoryReviewView:refreshRoleStoryUnlockBg(storyCo)
	self._unlocksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", storyCo.cgBg), self._onLoadUnlockCgCallback, self)
	recthelper.setAnchor(self._unlockimagecgbg.transform, 0, 0)
	transformhelper.setLocalScale(self._unlockimagecgbg.transform, 1, 1, 1)
end

function NecrologistStoryReviewView:refreshRoleStoryLockBg(storyCo)
	self._locksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", storyCo.cgBg), self._onLoadLockCgCallback, self)

	local poss = string.splitToNumber(storyCo.cgPos, "#")

	recthelper.setAnchor(self._lockimagecgbg.transform, poss[1] or 0, poss[2] or 0)
	transformhelper.setLocalScale(self._lockimagecgbg.transform, tonumber(storyCo.cgScale) or 1, tonumber(storyCo.cgScale) or 1, 1)
end

function NecrologistStoryReviewView:_onLoadUnlockCgCallback()
	self._unlockimagecgbg:SetNativeSize()
end

function NecrologistStoryReviewView:_onLoadLockCgCallback()
	self._lockimagecgbg:SetNativeSize()
end

function NecrologistStoryReviewView:getBranchItem()
	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(self.storyId)

	for i, plotCo in ipairs(plotList) do
		if plotCo.branch == 1 then
			self:_focusItem(i, 0.1)

			return self.itemList[i]
		end
	end
end

function NecrologistStoryReviewView:_focusItem(index, delayTime)
	local item = self.itemList[index]

	if not item then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self.goContent.transform)

	local pos = recthelper.getAnchorX(item.goParent.transform) - 308
	local scrollWidth = recthelper.getWidth(self.goScroll.transform)
	local contentWidth = recthelper.getWidth(self.goContent.transform)
	local widthOffset = contentWidth - scrollWidth
	local moveLimt = math.max(0, widthOffset)

	pos = math.min(moveLimt, pos)
	pos = -pos

	if delayTime and delayTime > 0 then
		ZProj.TweenHelper.DOAnchorPosX(self.goContent.transform, pos, delayTime)
	else
		recthelper.setAnchorX(self.goContent.transform, pos)
	end
end

function NecrologistStoryReviewView:onClose()
	return
end

function NecrologistStoryReviewView:onDestroyView()
	if self._unlocksimagecgbg then
		self._unlocksimagecgbg:UnLoadImage()
	end

	if self._locksimagecgbg then
		self._locksimagecgbg:UnLoadImage()
	end

	for _, item in ipairs(self.itemList) do
		item.btn:RemoveClickListener()
	end
end

return NecrologistStoryReviewView
