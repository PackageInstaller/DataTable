-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewAchievementPanel.lua

module("logic.extensions.season.view.SeasonNewAchievementPanel", package.seeall)

local M = class("SeasonNewAchievementPanel", SeasonNewPanelBase)
local kScrollWidthOrigin = 980
local kScrollWidthAll = 1074

function M:ctor()
	M.super.ctor(self)

	self._scrollRectWidth = nil
	self._specialItemParentList = nil
	self._specialItemCellList = nil
	self._lvMOList = nil
	self._curLv = 0
	self._finalItemData = nil
	self._itemList = nil
end

function M:buildUI()
	M.super.buildUI(self)

	local registry = self._registry

	self._btnReceive = registry:getBtn("secret_time_achievements_panel_1658694366")
	self._btnReceive_white = registry:getBtn("6&btn_middle_-31477526")
	self.btn_bugVip = registry:getBtn("3&btn_middle_-31477526")
	self._goRedPointReceive = goutil.findChild(self._btnReceive.gameObject, "red_point")
	self._goRedPointReceive_white = goutil.findChild(self._btnReceive_white.gameObject, "red_point")
	self._btnPromoteLevel = registry:getBtn("secret_time_achievements_panel_-589721365")
	self._imgProgress = registry:getImage("secret_time_achievements_panel_-745033182")
	self._txtScore = registry:getText("secret_time_achievements_panel_-1430571089")
	self._txtProgress = registry:getText("secret_time_achievements_panel_-1045144691")
	self.text_txtSpecialLv = registry:getText("secret_time_achievements_panel_-1401601819")

	local itemKeys = {
		"secret_time_achievements_panel_-93908761",
		"secret_time_achievements_panel_-1291079352",
		"secret_time_achievements_panel_1800269378"
	}

	self._specialItemParentList = {}

	for i = 1, #itemKeys do
		table.insert(self._specialItemParentList, registry:getGo(itemKeys[i]))
	end

	self.btn_btnFinalReward = registry:getBtn("secret_time_achievements_panel_-579134633")
	self.btn_btnScrollLeft = registry:getBtn("secret_time_achievements_panel_-942444485")
	self.btn_btnScrollRight = registry:getBtn("secret_time_achievements_panel_751058085")
	self.text_remainTime = registry:getText("secret_time_achievements_panel_1969885140")
	self._textFinalRewardName = registry:getText("secret_time_achievements_panel_1107255778")
	self.go_vipLock = registry:getGo("secret_time_achievements_panel_-1218039047")
	self.go_vipUnLock = registry:getGo("secret_time_achievements_panel_-361452729")
	self.text_vipLockFinalReward = registry:getText("secret_time_achievements_panel_-1218039047")
	self.text_vipUnlockFinalReward = registry:getText("secret_time_achievements_panel_-1762487893")
	self._goImgReceived = registry:getGo("secret_time_achievements_panel_-1021086818")
	self._txtLvTips = registry:getText("secret_time_achievements_panel_1587784235")
	self.scrollRectAdapter = registry:getScrollRect("secret_time_achievements_panel_1179787629", UIComponentType.ScrollRectAdapter)
	self.scrollRectTrans = registry:getRectTransform("secret_time_achievements_panel_1179787629")
	self._goScrollView = registry:getGo("secret_time_achievements_panel_1179787629")
	self._loopList = LoopGridViewHelper.New(self._goScrollView)

	self._loopList:InitGridView(0, self._onCellUpdate, self)

	local loopGridView = self._loopList:GetLoopGridView()

	self._loopContainer = loopGridView.ContainerTrans
	self._itemWidth = loopGridView.ItemSize.x
	self._viewPresentor = self:getViewPage():getViewPresentor()
end

function M:bindEvents()
	self._btnPromoteLevel:AddClickListener(self._onClickBtnPromoteLevel, self)
	self._btnReceive:AddClickListener(self._onClickBtnReceive, self)
	self._btnReceive_white:AddClickListener(self._onClickBtnReceive, self)
	self.btn_btnFinalReward:AddClickListener(self._onClickFinalReward, self)
	self.btn_bugVip:AddClickListener(self._onClickBuyVip, self)
	self.scrollRectAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
	self.btn_btnScrollLeft:AddClickListener(self._onClickLeftArrow, self)
	self.btn_btnScrollRight:AddClickListener(self._onClickRightArrow, self)
end

function M:unbindEvents()
	self._btnPromoteLevel:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnReceive_white:RemoveClickListener()
	self.btn_btnFinalReward:RemoveClickListener()
	self.btn_bugVip:RemoveClickListener()
	self.scrollRectAdapter:RemoveOnValueChanged()
	self.btn_btnScrollLeft:RemoveClickListener()
	self.btn_btnScrollRight:RemoveClickListener()
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
	end
end

function M:onEnter()
	M.super.onEnter(self)

	self._tipsLvMO = SeasonLvMO.New()

	self._tipsLvMO:setIsTips()

	self._scrollRectWidth = self.scrollRectTrans.rect.width
	self._imgProgress.fillAmount = 0
	self._itemList = {}

	self:refreshView()
	self:_moveToTargetLv()
	self:_onScrollValueChanged()
	self:_setEvents(true)
	self:_showUIPaticle(false)
end

function M:onExit()
	self:_showUIPaticle(false)
	self:_setEvents(false)

	self._finalItemData = nil
	self._itemList = nil
end

function M:_showUIPaticle(isShow)
	if not isShow then
		if not goutil.isNil(self._uiParticle) then
			goutil.setActive(self._uiParticle, false)
		end
	else
		if goutil.isNil(self._uiParticle) then
			self._uiParticle = self._viewPresentor:getResInstance(ResName.Secret_secret_time_common_effect)

			goutil.addChildToParent(self._uiParticle, self._imgProgress.gameObject)
		end

		goutil.setActive(self._uiParticle, true)
	end
end

function M:refreshView()
	self:_refreshLv()
	self:_tryCreateLvMOList()
	self._loopList:SetListItemCount(#self._lvMOList, true)
	self._loopList:RefreshAllShownItem()

	local vipStatus = SeasonModel.instance:getVipStatus()

	goutil.setActive(self._btnReceive.gameObject, SeasonModel.instance:hasLvActive() and vipStatus ~= SeasonEnum.VipStatus.Vip2)
	goutil.setActive(self._btnReceive_white.gameObject, SeasonModel.instance:hasLvActive() and vipStatus == SeasonEnum.VipStatus.Vip2)
	goutil.setActive(self._goRedPointReceive, SeasonModel.instance:hasLvActive())
	goutil.setActive(self._goRedPointReceive_white, SeasonModel.instance:hasLvActive())
	self:_updateVipInfo()
	self:_updateRemainTime()
	self:_updateSpecial()
end

function M:_updateRemainTime()
	local timeStr, needShowTime = SeasonModel.instance:getRemainTimeStr()

	self.text_remainTime.text = lang("season_residue_time") .. timeStr
end

function M:_updateVipInfo()
	local isVip = SeasonModel.instance:isVip()
	local vipStatus = SeasonModel.instance:getVipStatus()
	local curSeasonId = SeasonModel.instance:getSeasonId()
	local curLv = SeasonModel.instance:getCurrLv()

	goutil.setActive(self.btn_bugVip.gameObject, vipStatus ~= SeasonEnum.VipStatus.Vip2)
	goutil.setActive(self.go_vipLock, not isVip)
	goutil.setActive(self.go_vipUnLock, isVip)

	self.text_vipLockFinalReward.text = SeasonConfig.instance:getFinalRewardContent(curSeasonId)

	local finalRewardLv = SeasonConfig.instance:getFinalRewardLv(curSeasonId)
	local lvMO = SeasonModel.instance:getMOByLv(finalRewardLv)

	if lvMO and lvMO:getRewardStatus() == SeasonEnum.RewardStatus.Finished then
		self.text_vipUnlockFinalReward.text = lang("season_reward_receive")

		goutil.setActive(self._goImgReceived, true)
	else
		local process = string.format("%s/%s", curLv, finalRewardLv)

		self.text_vipUnlockFinalReward.text = string.format(lang("season_reward_score"), process)

		goutil.setActive(self._goImgReceived, false)
	end

	self._txtLvTips.text = langF("level_get_reward", finalRewardLv)

	if lvMO then
		local rewards = lvMO:getRewards()
		local itemId = rewards[1]:getCode()
		local itemData = ItemUtil.createItemData({
			itemId = itemId
		})

		self._finalItemData = itemData
		self._textFinalRewardName.text = itemData:getName()
		self._finalRewardData = itemData
	end
end

function M:_refreshLv()
	local lv = SeasonModel.instance:getCurrLv()
	local maxLv = SeasonConfig.instance:getMaxLv()
	local currScore = SeasonModel.instance:getCurrScore()
	local upgradeScore = SeasonConfig.instance:getScorePerLv()

	self._txtScore.text = lv

	if lv < maxLv then
		self._txtProgress.text = string.format("%s/%s", currScore, upgradeScore)
	else
		self._txtProgress.text = "MAX"
	end

	if self._curLv ~= lv then
		self._curLv = lv

		self:_showUIPaticle(false)
		self:_showUIPaticle(true)

		self._imgProgress.fillAmount = 0
	end

	local progress = Mathf.Clamp(currScore / upgradeScore, 0, 1)
	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:AppendInterval(0.3)
	sequence:Append(self._imgProgress:DOFillAmount(progress, 0.3):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true))
	sequence:SetTarget(self._imgProgress.gameObject)
end

function M:_onLoadRewardSFX(inst, res)
	return
end

function M:_tryCreateLvMOList()
	if self._lvMOList == nil then
		self:_createLvMOList()
	else
		local curSeasonId = SeasonModel.instance:getSeasonId()
		local curLv = SeasonModel.instance:getCurrLv()
		local normalMaxLv = SeasonConfig.instance:getLimitLv(curSeasonId)
		local loopAddLv = SeasonConfig.instance:getLoopRewardAddLvCount()

		if normalMaxLv <= curLv and math.fmod(curLv - normalMaxLv, loopAddLv) == 0 then
			self:_createLvMOList()
		end
	end
end

function M:_createLvMOList()
	self._lvMOList = {}

	local curSeasonId = SeasonModel.instance:getSeasonId()
	local curLv = SeasonModel.instance:getCurrLv()
	local normalMaxLv = SeasonConfig.instance:getLimitLv(curSeasonId)

	if normalMaxLv <= curLv then
		local allRewardLv = SeasonModel.instance:getAllMOs()

		for i = 1, #allRewardLv do
			local lvMO = allRewardLv[i]

			if lvMO then
				table.insert(self._lvMOList, lvMO)
			end
		end
	else
		local normals = SeasonModel.instance:getNormalMOs()

		table.insertto(self._lvMOList, normals)
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item
	local shower = self._itemList[curIndex]

	if not shower then
		item = self._loopList:NewListViewItem("secret_time_achievements_grid_item")
		shower = Astral.LuaComponentContainer.Get(item.gameObject, SeasonNewAchievementCell)

		if shower == nil then
			shower = Astral.LuaComponentContainer.Add(item.gameObject, SeasonNewAchievementCell)

			shower:setClickCallback(self._onClickLvCell, self)
		end
	end

	shower:setIndex(curIndex)
	shower:updateData(self._lvMOList[curIndex])

	item.gameObject.name = "item_" .. tostring(curIndex)

	return item
end

function M:_onClickLvCell(cell)
	local lvMO = self._lvMOList[cell:getIndex()]
	local status = lvMO:getRewardStatus()

	if status == SeasonEnum.RewardStatus.AllActive or status == SeasonEnum.RewardStatus.VipActive then
		SeasonAgent.instance:sendTakeLvRewardRequest(lvMO:getLv())
	end
end

function M:_onClickBtnPromoteLevel()
	local curSeasonId = SeasonModel.instance:getSeasonId()
	local curLv = SeasonModel.instance:getCurrLv()
	local normalMaxLv = SeasonConfig.instance:getLimitLv(curSeasonId)

	if normalMaxLv <= curLv then
		FloatWordMgr.instance:show(lang("season_buy_lv_limit"))

		return
	end

	local costCode = SeasonConfig.instance:getUpgradeLvMoneyCode()
	local costPerNum = SeasonConfig.instance:getUpgradeLvMoneyNum()
	local ownNum = ItemModel.instance:getItemCountByItemId(costCode)

	if costPerNum <= ownNum then
		ViewMgr.instance:open(ViewName.SeasonNewPromote)
	else
		FloatWordMgr.instance:show(lang("tip_season_5"))
	end
end

function M:_onClickBtnReceive()
	if SeasonModel.instance:hasLvActive() then
		SeasonAgent.instance:sendTakeLvRewardRequest(0)
	end
end

function M:_onClickFinalReward()
	if self._finalRewardData then
		local data = self._finalRewardData

		GlobalDispatcher:dispatchEvent(data:getItemMarkType(), data, self.btn_btnFinalReward.gameObject, nil, true, true, false, false)

		return
	end

	local vipStatus = SeasonModel.instance:getVipStatus()

	if vipStatus == SeasonEnum.VipStatus.Vip2 then
		return
	end

	SeasonFacade.instance:enterBuyVipView()
end

function M:_onClickBuyVip()
	SeasonFacade.instance:enterBuyVipView()
end

function M:_onScrollValueChanged()
	self:_updateSpecial()
end

function M:_updateSpecial()
	local firstItemIndex_left, firstItemIndex_right = self:_getItemIndexHeadAndTail()

	if not firstItemIndex_left or not firstItemIndex_right then
		return
	end

	if firstItemIndex_right < firstItemIndex_left then
		return
	end

	self:_updateSpecialReward(firstItemIndex_right)
	self:_updateNavigationArrowBtn(firstItemIndex_left, firstItemIndex_right)
end

function M:_onClickLeftArrow()
	self:_moveToTargetLv()
end

function M:_onClickRightArrow()
	self:_moveToTargetLv()
end

function M:_moveToTargetLv()
	local curLocationLv = SeasonModel.instance:getCurLocationLv()
	local jumpIndex = curLocationLv - 3

	jumpIndex = jumpIndex < 0 and 0 or jumpIndex

	self._loopList:MoveToItemIndex(jumpIndex)
end

function M:_updateSpecialReward(firstItemIndex_right)
	local lvMO = self._lvMOList[firstItemIndex_right + 1]

	if not lvMO then
		return
	end

	local lvInterval = SeasonConfig.instance:getSpecialLvInterval()

	if lvInterval <= 0 then
		return
	end

	local specialLv = math.ceil(lvMO:getLv() / lvInterval) * lvInterval
	local specialMO = SeasonModel.instance:getMOByLv(specialLv)
	local allReward = specialMO:getTotalRewards()
	local rewardState = specialMO:getRewardStatus()

	self.text_txtSpecialLv.text = specialLv
	self._specialItemCellList = self._specialItemCellList or {}

	for i = 1, #allReward do
		local rewardItemMo = allReward[i]
		local cell = self._specialItemCellList[i]

		if not cell then
			local cellGo = self._viewPresentor:getResInstance(ResName.Common_Backpack_Item)

			if self._specialItemParentList[i] then
				goutil.addChildToParent(cellGo, self._specialItemParentList[i])
			end

			cell = Astral.LuaComponentContainer.Add(cellGo, SeasonRewardItemCell)
			self._specialItemCellList[i] = cell
		end

		if cell and rewardItemMo then
			local receiveItemState = self:_getRewardItemStatus(rewardState, rewardItemMo)

			cell:updateData(rewardItemMo, receiveItemState)
		end
	end

	for i = 1, #self._specialItemCellList do
		local cell = self._specialItemCellList[i]

		cell:setVisible(allReward[i] ~= nil)
	end
end

function M:_updateNavigationArrowBtn(firstItemIndex_left, firstItemIndex_right)
	local curLocationLv = SeasonModel.instance:getCurLocationLv()

	curLocationLv = curLocationLv > 0 and curLocationLv or 1

	local lvMO_left = self._lvMOList[firstItemIndex_left + 1]
	local lvMO_right = self._lvMOList[firstItemIndex_right + 1]

	if not lvMO_left or not lvMO_right then
		return
	end

	goutil.setActive(self.btn_btnScrollLeft.gameObject, curLocationLv < lvMO_left:getLv())
	goutil.setActive(self.btn_btnScrollRight.gameObject, curLocationLv > lvMO_right:getLv())
end

function M:_getRewardItemStatus(rewardState, rewardItemMo)
	local receiveItemState = CommEnum.RewardEnum.CanNotGot
	local isVip = SeasonModel.instance:isVip()

	if rewardItemMo:isVip() then
		if rewardState == SeasonEnum.RewardStatus.Finished then
			receiveItemState = isVip and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot
		elseif rewardState == SeasonEnum.RewardStatus.AllActive then
			receiveItemState = isVip and CommEnum.RewardEnum.CanGot or CommEnum.RewardEnum.CanNotGot
		elseif rewardState == SeasonEnum.RewardStatus.VipActive then
			receiveItemState = CommEnum.RewardEnum.CanGot
		end
	elseif rewardState == SeasonEnum.RewardStatus.Finished then
		receiveItemState = CommEnum.RewardEnum.HasGot
	elseif rewardState == SeasonEnum.RewardStatus.AllActive then
		receiveItemState = CommEnum.RewardEnum.CanGot
	elseif rewardState == SeasonEnum.RewardStatus.VipActive then
		receiveItemState = CommEnum.RewardEnum.HasGot
	end

	return receiveItemState
end

function M:_getItemIndexHeadAndTail()
	local leftItemIndex, rightItemIndex
	local leftMinX = math.huge
	local rightMaxX = 0
	local containerPox = Astral.TransformUtil.GetAnchoredPos(self._loopContainer, 0, 0)

	for i = 0, self._loopContainer.childCount - 1 do
		local transItem = self._loopContainer:GetChild(i)
		local anchorX = Astral.TransformUtil.GetAnchoredPos(transItem, 0, 0) + containerPox
		local goLeftX = anchorX
		local goRightX = anchorX + self._itemWidth

		if goRightX >= 0 and goRightX <= leftMinX then
			leftMinX = goRightX
			leftItemIndex = transItem:GetComponent(typeof(SuperScrollView.LoopGridViewItem)).ItemIndex
		end

		if goLeftX <= self._scrollRectWidth and rightMaxX <= goLeftX then
			rightMaxX = goLeftX
			rightItemIndex = transItem:GetComponent(typeof(SuperScrollView.LoopGridViewItem)).ItemIndex
		end
	end

	return leftItemIndex, rightItemIndex
end

function M:_onClickExtra()
	FloatWordMgr.instance:show(lang("tip_season_11"))
end

function M:_onSeasonInfoUpdate()
	self:refreshView()
end

function M:destroyUI()
	M.super.destroyUI(self)
	self._loopList:Dispose()

	self._loopList = nil
	self._scrollRectWidth = nil
	self._specialItemCellList = nil
	self._lvMOList = nil

	if self._uiParticle then
		goutil.destroy(self._uiParticle)
	end

	self._uiParticle = nil
end

return M
