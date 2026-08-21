-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonStarRewardView.lua

module("logic.extensions.dungeon.view.DungeonStarRewardView", package.seeall)

local M = class("DungeonStarRewardView", ViewComponent)
local kMinX = 5
local kSlider1Width = 81
local kSlider2Width = 335
local kSlider3Width = 334

function M:buildUI()
	self._btnReturn = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._btnBg = self:getBtnByPath("universal_second_tips_common_bg/clickExit")
	self._chapterTxt = self:getTextByPath("allContent/Text1")
	self._curNumTxt = self:getTextByPath("allContent/txtValue")
	self._sliderNormalPanelGo = self:getGoByPath("allContent/bounty_slider/sliderNormal")
	self._sliderNormal1Img = self:getImageByPath("allContent/bounty_slider/sliderNormal/slider1")
	self._sliderNormal2Img = self:getImageByPath("allContent/bounty_slider/sliderNormal/slider2")
	self._sliderNormal3Img = self:getImageByPath("allContent/bounty_slider/sliderNormal/slider3")
	self._item1Btn = self:getBtnByPath("allContent/bounty_slider/bountyitem1")
	self._item2Btn = self:getBtnByPath("allContent/bounty_slider/bountyitem2")
	self._item3Btn = self:getBtnByPath("allContent/bounty_slider/bountyitem3")
	self._itemGoList = {
		self:getGoByPath("allContent/bounty_slider/bountyitem1"),
		self:getGoByPath("allContent/bounty_slider/bountyitem2"),
		self:getGoByPath("allContent/bounty_slider/bountyitem3")
	}
	self._starNumTxtList = {}
	self._itemNormalCanGotList = {}
	self._itemHardCanGotList = {}
	self._itemCommImgList = {}

	for i, v in ipairs(self._itemGoList) do
		table.insert(self._starNumTxtList, goutil.findChildTextComponent(v, "txtValue"))
		table.insert(self._itemNormalCanGotList, goutil.findChild(v, "imgCanReceiveNormal"))
		table.insert(self._itemHardCanGotList, goutil.findChild(v, "imgCanReceiveHard"))
		table.insert(self._itemCommImgList, goutil.findChildImageComponent(v, "btnIcon"))
	end

	self._rewardCellGoList = {
		self:getGoByPath("allContent/itemShow1/backpack_item_1"),
		self:getGoByPath("allContent/itemShow1/backpack_item_2"),
		self:getGoByPath("allContent/itemShow2/backpack_item_1"),
		self:getGoByPath("allContent/itemShow2/backpack_item_2"),
		self:getGoByPath("allContent/itemShow3/backpack_item_1"),
		self:getGoByPath("allContent/itemShow3/backpack_item_2")
	}
	self._rewardCellList = {}

	for i, go in ipairs(self._rewardCellGoList) do
		table.insert(self._rewardCellList, Astral.LuaComponentContainer.Add(go, RewardCell))
	end
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnBg:AddClickListener(self._onClickReturn, self)
	self._item1Btn:AddClickListener(self._onClickReward1, self)
	self._item2Btn:AddClickListener(self._onClickReward2, self)
	self._item3Btn:AddClickListener(self._onClickReward3, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	self._item1Btn:RemoveClickListener()
	self._item2Btn:RemoveClickListener()
	self._item3Btn:RemoveClickListener()
end

function M:_onClickReward1()
	self:_onClickReward(1)
end

function M:_onClickReward2()
	self:_onClickReward(2)
end

function M:_onClickReward3()
	self:_onClickReward(3)
end

function M:_onClickReward(index)
	if self._isWaitingAgent then
		return
	end

	if not self._isCanGet[index] then
		local starReward = self._chapterMo:getStarReward()

		ViewMgr.instance:open(ViewName.RewardPreview, {
			starReward[index]
		}, self._starHasGotList[index])

		return
	end

	self._isWaitingAgent = true

	DungeonAgent.instance:SendTakeMainlineStarRewardRequest(self._chapterMo:getChapterId(), self._chapterMo:getChapterDifficulty(), index - 1)
end

function M:onEnter()
	self._isWaitingAgent = false

	GlobalDispatcher:addEventListener(EventType.DUNGEON_STAR_REWARD_UPDATE, self._starRewardGot, self)

	self._chapterMo = self:getFirstParam()

	self:_refreshView()
end

function M:_refreshView()
	local chapterMo = self._chapterMo
	local difficulty = chapterMo:getChapterDifficulty()
	local chapterCo = chapterMo:getChapterCO()
	local starCount = self._chapterMo:getStarCount()
	local starRequireList = chapterMo:getStarRewardRequire()
	local totalStarCount = self._chapterMo:getTotalStarCount()
	local fillAmount = starCount / totalStarCount

	self._starHasGotList = chapterMo:getStarRewardGotStatus()

	local chineseIdxKey = string.format("tip_chinese_%d", chapterCo.chapterId)
	local chapterIdxName = string.format(lang("tip_chapter_title_1"), lang(chineseIdxKey))

	self._chapterTxt.text = string.format("%s·%s", chapterIdxName, chapterCo.name)
	self._curNumTxt.text = string.format("<color=#e8e8e8><size=40>%d</size></color>/%d", starCount, totalStarCount)

	local kMaxX = 746
	local kSlider1Width = 81
	local kSlider2Width = 335
	local kSlider3Width = 334
	local signPosX = kMinX
	local sliderVal1, sliderVal2, sliderVal3 = 0, 0, 0

	if difficulty == 1 then
		if starCount <= starRequireList[1] then
			signPosX = signPosX + kSlider1Width * starCount / starRequireList[1]
			sliderVal1 = starCount / starRequireList[1]
		elseif starCount <= starRequireList[2] then
			signPosX = signPosX + kSlider1Width + kSlider2Width * (starCount - starRequireList[1]) / (starRequireList[2] - starRequireList[1])
			sliderVal1 = 1
			sliderVal2 = (starCount - starRequireList[1]) / (starRequireList[2] - starRequireList[1])
			sliderVal3 = 0
		else
			signPosX = signPosX + kSlider1Width + kSlider2Width + kSlider3Width * (starCount - starRequireList[2]) / (starRequireList[3] - starRequireList[2])
			sliderVal1 = 1
			sliderVal2 = 1
			sliderVal3 = (starCount - starRequireList[2]) / (starRequireList[3] - starRequireList[2])
		end

		for i, v in ipairs(self._itemHardCanGotList) do
			goutil.setActive(v, false)
		end

		self._activeCanGetList = self._itemNormalCanGotList
	else
		if starCount <= starRequireList[1] then
			signPosX = signPosX + kSlider1Width * starCount / starRequireList[1]
			sliderVal1 = starCount / starRequireList[1]
			sliderVal2 = 0
			sliderVal3 = 0
		elseif starCount <= starRequireList[2] then
			signPosX = signPosX + kSlider1Width + kSlider2Width * (starCount - starRequireList[1]) / (starRequireList[2] - starRequireList[1])
			sliderVal1 = 1
			sliderVal2 = (starCount - starRequireList[1]) / (starRequireList[2] - starRequireList[1])
			sliderVal3 = 0
		else
			signPosX = signPosX + kSlider1Width + kSlider2Width + kSlider3Width * (starCount - starRequireList[2]) / (starRequireList[3] - starRequireList[2])
			sliderVal1 = 1
			sliderVal2 = 1
			sliderVal3 = (starCount - starRequireList[2]) / (starRequireList[3] - starRequireList[2])
		end

		for i, v in ipairs(self._itemNormalCanGotList) do
			goutil.setActive(v, false)
		end

		self._activeCanGetList = self._itemHardCanGotList
	end

	self._sliderNormal1Img.fillAmount = sliderVal1
	self._sliderNormal2Img.fillAmount = sliderVal2
	self._sliderNormal3Img.fillAmount = sliderVal3
	self._isCanGet = {}

	for i, v in ipairs(self._itemGoList) do
		goutil.setActive(v, false)
	end

	for i, v in ipairs(starRequireList) do
		local hasGotReward = self._starHasGotList[i]

		goutil.setActive(self._itemGoList[i], true)

		if hasGotReward then
			goutil.setActive(self._itemCommImgList[i].gameObject, true)

			self._itemCommImgList[i].color = Astral.ColorUtil.ParseColor("#858585")

			goutil.setActive(self._activeCanGetList[i], false)

			self._starNumTxtList[i].color = Astral.ColorUtil.ParseColor("#FCFCFC")
		elseif v <= starCount then
			self._isCanGet[i] = true

			goutil.setActive(self._itemCommImgList[i].gameObject, false)
			goutil.setActive(self._activeCanGetList[i], true)

			self._starNumTxtList[i].color = Astral.ColorUtil.ParseColor("#FCFCFC")
		else
			goutil.setActive(self._itemCommImgList[i].gameObject, true)

			self._itemCommImgList[i].color = Astral.ColorUtil.ParseColor("#bcbcbc")

			goutil.setActive(self._activeCanGetList[i], false)

			self._starNumTxtList[i].color = Astral.ColorUtil.ParseColor("#979797")
		end

		self._starNumTxtList[i].text = v

		local starReward = self._chapterMo:getStarReward()
		local rewardCode = starReward[i]
		local rewardList = self:_getRewardLst(rewardCode)

		for j = 1, 2 do
			local idx = (i - 1) * 2 + j

			if rewardList[j] then
				goutil.setActive(self._rewardCellGoList[idx], true)

				local rewardCell = self._rewardCellList[idx]
				local rewardData = RewardData.New({
					code = rewardList[j]:getItemId(),
					count = rewardList[j].count,
					rewardStatus = rewardList[j].rewardStatus,
					itemSign = rewardList[j].itemSign
				})

				rewardCell:updateData(rewardData)
				rewardCell:getComponent("reward"):setRewardStatus(hasGotReward and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot)
			else
				goutil.setActive(self._rewardCellGoList[idx], false)
			end
		end
	end
end

function M:_collectFirstPassRewardItemData(rewardList, reward)
	for i, v in ipairs(reward and reward or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP then
			local itemData = ItemUtil.createItemData({
				itemId = v.code
			})

			itemData:setCount(v.num)

			itemData.count = v.num
			itemData.rewardStatus = CommEnum.RewardEnum.CanNotGot
			itemData.itemSign = CommEnum.BackPackItemSignTyp.None

			table.insert(rewardList, itemData)
		end
	end
end

function M:_getRewardLst(rewardCode)
	local rewardLst = {}

	if rewardCode > 0 then
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.reward)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward1)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward2)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward3)
	end

	return rewardLst
end

function M:_onClickReturn()
	self:back()
end

function M:_starRewardGot()
	self._isWaitingAgent = false

	self:_refreshView()
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.DUNGEON_STAR_REWARD_UPDATE, self._starRewardGot, self)
end

return M
