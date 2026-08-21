-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/teachingdungeon/TeachingDungeonView.lua

module("logic.extensions.dungeon.view.teachingdungeon.TeachingDungeonView", package.seeall)

local M = class("TeachingDungeonView", ViewComponent)
local root = false

function M:buildUI()
	self._btnReturn = self:getBtn("1&title_view_-878360263")
	self._btnHome = self:getBtn("1&title_view_1398742689")

	goutil.setActive(self._btnHome.gameObject, true)

	self._nameTxt = self:getText("4&title_view_-788888785")
	self._reward1CountTxt = self:getText("teach_explore_chapter_view_-1340831722")
	self._reward11CountTxt = self:getText("teach_explore_chapter_view_990183056")
	self._reward2CountTxt = self:getText("teach_explore_chapter_view_-1818151548")
	self._reward22CountTxt = self:getText("teach_explore_chapter_view_-1292197610")
	self._fillImg1 = self:getImage("teach_explore_chapter_view_-1570734002")
	self._fillImg2 = self:getImage("teach_explore_chapter_view_-1100990235")
	self._fillImg3 = self:getImage("teach_explore_chapter_view_1066096599")
	self._cell1Go = self:getGo("teach_explore_chapter_view_-1229012994")
	self._cell2Go = self:getGo("teach_explore_chapter_view_-292828398")
	self._reward1Cell = Astral.LuaComponentContainer.Add(self:getGo("5&rewards_detail_item_2141037416"), TeachingDungeonItemCell)
	self._reward2Cell = Astral.LuaComponentContainer.Add(self:getGo("6&rewards_detail_item_2141037416"), TeachingDungeonItemCell)
	self._cellGoList = {
		self._cell1Go,
		self._cell2Go
	}
	self._rewardCountTxtList = {
		self._reward1CountTxt,
		self._reward2CountTxt
	}
	self._rewardCountGetTxtList = {
		self._reward11CountTxt,
		self._reward22CountTxt
	}
	self._rewardCellList = {
		self._reward1Cell,
		self._reward2Cell
	}
	self._chapterGoList = {
		self:getGo("teach_explore_chapter_view_-499852338"),
		self:getGo("teach_explore_chapter_view_-1730150407"),
		self:getGo("teach_explore_chapter_view_-2054985405")
	}
	self._passedCountTxt = self:getText("teach_explore_chapter_view_-1696217053")
	self._scroll = self:getGo("teach_explore_chapter_view_-514742872")
	self._loopListHelper = LoopListHelper.New(self._scroll)

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._canvas = goutil.addComponentOnce(self._scroll, ComponentType.CanvasGroup)
	root = self
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._dealTimelineListener, self)
	GlobalDispatcher:addEventListener(EventType.TEACH_VIEW_VISIBLE, self._setViewVisible, self)
	GlobalDispatcher:addEventListener(EventType.TEACH_VIEW_UPDATE, self._updateView, self)
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._dealTimelineListener, self)
	GlobalDispatcher:removeEventListener(EventType.TEACH_VIEW_VISIBLE, self._setViewVisible, self)
	GlobalDispatcher:removeEventListener(EventType.TEACH_VIEW_UPDATE, self._updateView, self)
end

function M:_onClickReturn()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close1")
	self:_closeTweenAni()
end

function M:_dealTimelineListener(_, tagName, reason)
	if tagName == "close1" then
		if self._onEnterAni then
			self._onEnterAni = false

			return
		end

		GlobalDispatcher:dispatchEvent(EventType.JUMP_TO_TEACH_MAIN)
		self:_setViewVisible(_, false)
	end
end

function M:setActive(visible)
	goutil.setActive(root.mainGO, visible)

	if visible then
		root._loopListHelper:RefreshAllShownItem()
		root:_refreshRewardTakenPanel()

		local chapterMo = DungeonTeachingChapterModel.instance:getChapterMoByChapterId(root._chapterId or 1001)
		local focusIndex = chapterMo:getFirstNotPassedDungeonIndex() - 2

		root._loopListHelper:MoveToItemIndex(focusIndex)
	end
end

function M:_setViewVisible(_, visible)
	local posX, alpha = 100000, 0
	local interactFlag = false

	if visible then
		posX = 0
		alpha = 1
		interactFlag = true
	end

	Astral.GeometryUtil.SetAnchorPosX(self.mainGO.transform, posX)

	local cg = goutil.addComponentOnce(self.mainGO, typeof(UnityEngine.CanvasGroup))

	cg.alpha = alpha
	cg.interactable = interactFlag
	cg.blocksRaycasts = interactFlag

	if visible then
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open")
		self:_setAlpha(0)
		self:_openTweenAni()
	end
end

function M:_openTweenAni()
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)
	printWarn("open")

	local passedCount = self._chapterMo:getPassedDungeonCount()
	local totalCount = #self._chapterMo:getDungeonIds()

	self._passedCountTxt.text = string.format("<color=#ffffff><size=32>%d</size></color>/%d", passedCount, totalCount)

	local rewardList = self._chapterMo:getChapterReward()
	local isGetReward = self._chapterMo:getRewardTakenStatusByIndex(#rewardList)

	self._fillImg1.fillAmount = 0
	self._fillImg2.fillAmount = 0
	self._fillImg3.fillAmount = 0

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:AppendInterval(0.5)
	sequence:Append(self._fillImg1:DOFillAmount(passedCount / rewardList[1].count, 0.2))
	sequence:AppendInterval(0.1)
	sequence:Append(self._fillImg2:DOFillAmount((passedCount - rewardList[1].count) / (rewardList[2].count - rewardList[1].count), 0.2))
	sequence:AppendInterval(0.1)
	sequence:Append(self._fillImg3:DOFillAmount(isGetReward and 1 or 0, 0.2))

	self._loopList = self._loopListHelper:GetLoopListView()

	local minIndex, maxIndex = self._loopListHelper:GetCurShowItemIndexRange()
	local delayTime = 0
	local minItem = self._loopList:GetShownItemByItemIndex(minIndex).gameObject

	minItem:GetComponent(ComponentType.CanvasGroup).alpha = 1

	local prePos = minItem:GetComponent(UIComponentType.RectTransform).localPosition.x

	self._canvas.alpha = 1

	local tweenAni = DG.Tweening.DOTween.Sequence()

	for i = minIndex + 1, maxIndex do
		local loopItem = self._loopList:GetShownItemByItemIndex(i)

		tweenAni:AppendCallback(function()
			loopItem.transform.position = self._loopList:GetShownItemByItemIndex(i - 1).transform.position

			loopItem.transform:DOLocalMoveX(prePos + 400, 0.2)

			prePos = prePos + 400

			loopItem.gameObject:GetComponent(ComponentType.CanvasGroup):DOFade(1, 0.2)
		end)
		tweenAni:AppendInterval(0.22)
	end

	tweenAni:AppendInterval(0.2)
	tweenAni:AppendCallback(function()
		self._loopListHelper:RefreshAllShownItem()
		self:_setAlpha(1)
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
	end)
end

function M:_closeTweenAni()
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)
	printWarn("close")

	self._loopList = self._loopListHelper:GetLoopListView()

	local minIndex, maxIndex = self._loopListHelper:GetCurShowItemIndexRange()

	self:_setAlpha(0)

	self._loopList:GetShownItemByItemIndex(minIndex):GetComponent(ComponentType.CanvasGroup).alpha = 1

	local maxItem = self._loopList:GetShownItemByItemIndex(maxIndex).gameObject
	local prePos = maxItem:GetComponent(UIComponentType.RectTransform).localPosition.x
	local delayTime = 0
	local tweenAni = DG.Tweening.DOTween.Sequence()

	for i = maxIndex, minIndex + 1, -1 do
		local loopItem = self._loopList:GetShownItemByItemIndex(i)

		loopItem.gameObject:GetComponent(ComponentType.CanvasGroup).alpha = 1

		tweenAni:AppendCallback(function()
			prePos = prePos - 409.5

			loopItem.transform:DOLocalMoveX(prePos, 0.2)
			loopItem:GetComponent(ComponentType.CanvasGroup):DOFade(0, 0.2)
		end)
		tweenAni:AppendInterval(0.2)
	end

	tweenAni:AppendCallback(function()
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
	end)
end

function M:_setAlpha(alpha)
	local t = goutil.findChild(self._scroll, "view/content")
	local childList = Astral.GameObjectUtil.GetChildren(t)

	for index = 0, childList.Length - 1 do
		local k = goutil.addComponentOnce(childList[index], ComponentType.CanvasGroup)

		k.alpha = alpha
	end
end

function M:onEnter()
	self:_setViewVisible(_, false)
end

function M:onEnterFinished()
	self._onEnterAni = true

	self._guiAnimation:PlayAniByName("close1", Astral.GUITimeLineMode.TimeToEnd)

	local chapterId = DungeonTeachingChapterModel.instance:getClickChapterIdAndDungeonIndex()

	if chapterId then
		GlobalDispatcher:dispatchEvent(EventType.SELECT_TEACH_CHAPTER, chapterId)
	end
end

function M:_updateView(_, index)
	GlobalDispatcher:addEventListener(EventType.DUNGEON_STAR_REWARD_UPDATE, self._refreshRewardTakenPanel, self)

	self._chapterId = index
	self._chapterMo = DungeonTeachingChapterModel.instance:getChapterMoByChapterId(self._chapterId)
	self._focusIndex = self._chapterMo:getFirstNotPassedDungeonIndex() - 2
	self._canvas.alpha = 0

	self:_initLeftPanel()
	self:_refreshView()
	self:_refreshRewardTakenPanel()
	self._loopListHelper:MoveToItemIndex(self._focusIndex)

	self._loopList = self._loopListHelper:GetLoopListView()
end

function M:_initLeftPanel()
	self._nameTxt.text = self._chapterMo:getName()

	for i, v in ipairs(self._chapterGoList) do
		if self._chapterId - 1000 == i then
			goutil.setActive(v, true)
		else
			goutil.setActive(v, false)
		end
	end
end

function M:_refreshView()
	self._dungeonIds = self._chapterMo:getDungeonIds()

	self._loopListHelper:SetListItemCount(#self._dungeonIds, true)
end

function M:_refreshRewardTakenPanel()
	local passedCount = self._chapterMo:getPassedDungeonCount()
	local totalCount = #self._chapterMo:getDungeonIds()

	self._passedCountTxt.text = string.format("<color=#ffffff><size=32>%d</size></color>/%d", passedCount, totalCount)

	local rewardList = self._chapterMo:getChapterReward()
	local getReward = self._chapterMo:getRewardTakenStatusByIndex(#rewardList)

	self._fillImg1:DOFillAmount(passedCount / rewardList[1].count, 0.2)
	self._fillImg2:DOFillAmount((passedCount - rewardList[1].count) / (rewardList[2].count - rewardList[1].count), 0.2)
	self._fillImg3:DOFillAmount(getReward and 1 or 0, 0.2)

	for i, v in ipairs(rewardList) do
		self._rewardCountTxtList[i].text = v.count
		self._rewardCountGetTxtList[i].text = v.count

		local rewardConfig = RewardConfig.instance:getRewardCfgByCode(v.reward)

		if rewardConfig and rewardConfig.reward and rewardConfig.reward[1] then
			local reward = rewardConfig.reward[1]
			local canGot = passedCount >= v.count
			local status = CommEnum.RewardEnum.CanNotGot

			if self._chapterMo:getRewardTakenStatusByIndex(i) then
				status = CommEnum.RewardEnum.HasGot
			elseif passedCount >= v.count then
				status = CommEnum.RewardEnum.CanGot
			end

			local itemData = ItemData.New({
				itemId = reward.code,
				count = reward.num
			})

			self._rewardCellList[i]:Awake()
			self._rewardCellList[i]:updateData(itemData)
			self._rewardCellList[i]:setShowSelectedEffect(false)
			self._rewardCellList[i]:getComponent("reward"):setRewardStatus(status)
			self._rewardCellList[i]:getComponent("normal"):setClickListener(self._clickReward, self)
			self._rewardCellList[i]:getComponent("reward"):setIndex(i)

			local stateReveiveGo = goutil.findChild(self._cellGoList[i], "stateReveive")
			local rewardGo = self._rewardCellList[i]:getGo()
			local receivedGo = goutil.findChild(rewardGo.transform.parent.gameObject, "stateReceived")
			local canvasGroup = rewardGo:GetComponent(ComponentType.CanvasGroup)
			local isGetReward = self._chapterMo:getRewardTakenStatusByIndex(i)

			canvasGroup.alpha = isGetReward and 0.5 or 1

			goutil.setActive(receivedGo, isGetReward)
			goutil.setActive(stateReveiveGo, canGot)
		end
	end
end

function M:_clickReward(cell)
	local index = cell:getComponent("reward"):getIndex()

	if self._chapterMo:getRewardTakenStatusByIndex(index) then
		cell:dealSelect()

		return true
	end

	local passedCount = self._chapterMo:getPassedDungeonCount()
	local rewardList = self._chapterMo:getChapterReward()

	if passedCount >= rewardList[index].count then
		DungeonAgent.instance:SendTakeTrainingRewardRequest(self._chapterId, index - 1)
	else
		cell:dealSelect()

		return true
	end
end

function M:_onClickHome()
	DungeonTeachingChapterModel.instance:setClickChapterIdAndDungeonIndex()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickFight(dungeonId)
	local dungeonMo = DungeonTeachingChapterModel.instance:getDungeonMoById(dungeonId)

	if dungeonMo:getIsUnlock() then
		local index = 1

		for i, v in ipairs(self._chapterMo:getDungeonIds()) do
			if v == dungeonId then
				index = i
			end
		end

		DungeonTeachingChapterModel.instance:setClickChapterIdAndDungeonIndex(self._chapterId, index)

		local info = {}

		info.dungeonCode = dungeonId
		info.afflatusBuff = false
		info.isShowPlot = true
		info.multiCount = 1
		info.dungeonIndex = self._curDungeonIndex
		info.gamePlay = BattleEnum.GamePlayType.NORMAL

		DungeonController.instance:startDungeonBattle(info)
	else
		FloatWordMgr.instance:show(lang("tip_chapter_lock"))
	end
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local dungeonId = self._dungeonIds[curIndex]
	local item = self._loopListHelper:NewListViewItem("case_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, TeachingDungeonCell)

	shower:setData(dungeonId)
	shower:setClickFightCallBack(self._onClickFight, self)

	return item
end

function M:onExit()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
	GlobalDispatcher:removeEventListener(EventType.DUNGEON_STAR_REWARD_UPDATE, self._refreshRewardTakenPanel, self)
	self._loopListHelper:ClearCells()
	ViewMgr.instance:destroy(ViewName.TeachingDungeon)
end

return M
