-- chunkname: @modules/logic/lifecircle/view/LifeCircleSignView.lua

module("modules.logic.lifecircle.view.LifeCircleSignView", package.seeall)

local LifeCircleSignView = class("LifeCircleSignView", RougeSimpleItemBase)

function LifeCircleSignView:onInitView()
	self._simageBG2 = gohelper.findChildSingleImage(self.viewGO, "BG/#simage_BG2")
	self._simageBG1 = gohelper.findChildSingleImage(self.viewGO, "BG/#simage_BG1")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._txtDays = gohelper.findChildText(self.viewGO, "#txt_Days")
	self._txt = gohelper.findChildText(self.viewGO, "txtbg/#txt")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "#scroll_Reward")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/#go_Content")
	self._goGrayLine = gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	self._goNormalLine = gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/#go_Content/#go_NormalLine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LifeCircleSignView:addEvents()
	return
end

function LifeCircleSignView:removeEvents()
	return
end

local csTweenHelper = ZProj.TweenHelper
local ti = table.insert
local sf = string.format
local kCellWidth = 200
local kEndSpace = 90.86

function LifeCircleSignView:ctor(...)
	self:__onInit()
	LifeCircleSignView.super.ctor(self, ...)
end

function LifeCircleSignView:_editableInitView()
	LifeCircleSignView.super._editableInitView(self)

	self._txtbgGO = gohelper.findChild(self.viewGO, "txtbg")
	self._scrollRewardGo = self._scrollReward.gameObject
	self._goGraylineTran = self._goGrayLine.transform
	self._goNormallineTran = self._goNormalLine.transform
	self._goContentTran = self._goContent.transform
	self._rectViewPortTran = gohelper.findChild(self._scrollRewardGo, "Viewport").transform
	self._hLayoutGroup = self._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self._goGraylinePosX = recthelper.getAnchorX(self._goGraylineTran)
	self._scrollRewardTrans = self._scrollRewardGo.transform

	recthelper.setAnchorX(self._goContentTran, 0)

	self._itemList = {}
end

function LifeCircleSignView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function LifeCircleSignView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function LifeCircleSignView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function LifeCircleSignView:_stagetitle()
	local has = self:totalLoginDays()
	local COList = self:_COList()
	local COIndex = 0

	for i, CO in ipairs(COList) do
		local need = CO.logindaysid

		if need <= has then
			COIndex = i
		else
			break
		end
	end

	if COList[COIndex] then
		if not COList[COIndex].stagetitle then
			return ""
		end
	end
end

function LifeCircleSignView:_getLatestIndex()
	local lastIndex = 0

	for i, item in ipairs(self._itemList) do
		if item:isClaimable() then
			return i
		elseif item:isClaimed() then
			lastIndex = i
		end
	end

	return lastIndex
end

function LifeCircleSignView:onUpdateParam()
	self:_refresh()
	self:_refreshContentPosX(self:_getLatestIndex())
	self:_tryClaimAccumulateReward()
end

function LifeCircleSignView:_calcHLayoutContentMaxWidth(count)
	count = count or #self:_COList()

	local cellWidth = kCellWidth
	local endSpace = kEndSpace
	local padding = self._hLayoutGroup.padding
	local spacing = self._hLayoutGroup.spacing
	local left = padding.left

	return (cellWidth + spacing) * math.max(0, count) - left - cellWidth / 2 + endSpace
end

function LifeCircleSignView:onOpen()
	SignInController.instance:registerCallback(SignInEvent.OnSignInTotalRewardReply, self._onSignInTotalRewardReply, self)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, self._onReceiveSignInTotalRewardAllReply, self)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, self._onChangePlayerinfo, self)
	self:onUpdateParam()
	LifeCircleController.instance:markLatestConfigCount()
end

function LifeCircleSignView:onClose()
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInTotalRewardReply, self._onSignInTotalRewardReply, self)
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, self._onReceiveSignInTotalRewardAllReply, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, self._onChangePlayerinfo, self)
end

function LifeCircleSignView:onDestroyView()
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInTotalRewardReply, self._onSignInTotalRewardReply, self)
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, self._onReceiveSignInTotalRewardAllReply, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, self._onChangePlayerinfo, self)
	GameUtil.onDestroyViewMember(self, "_drag")
	GameUtil.onDestroyViewMember_ClickDownListener(self, "_touch")
	GameUtil.onDestroyViewMemberList(self, "_itemList")
	LifeCircleSignView.super.onDestroyView(self)
	self:__onDispose()
end

function LifeCircleSignView:_create_LifeCircleSignRewardsItem(index, parentGO)
	if not self.viewContainer then
		local c = self:baseViewContainer()
		local go = c:getResInst(SignInEnum.ResPath.lifecirclesignrewardsitem, parentGO)
		local item = LifeCircleSignRewardsItem.New({
			parent = self,
			baseViewContainer = c
		})

		item:setIndex(index)
		item:init(go)

		return item
	end
end

function LifeCircleSignView:_onSignInTotalRewardReply()
	self:_refresh()
end

function LifeCircleSignView:_onReceiveSignInTotalRewardAllReply()
	self:_scrollContentTo(self:_getLatestIndex())
	self:_refresh()
end

function LifeCircleSignView:_onChangePlayerinfo()
	self:_refresh()
end

function LifeCircleSignView:totalLoginDays()
	local info = PlayerModel.instance:getPlayinfo()

	return info.totalLoginDays
end

function LifeCircleSignView:_COList()
	return lua_sign_in_lifetime_bonus.configList
end

function LifeCircleSignView:_maxLogindaysid()
	local list = self:_COList()
	local lastCO = list[#list]

	return (lastCO or nil) and (lastCO.logindaysid or 0)
end

function LifeCircleSignView:_COListCount()
	local list = self:_COList()

	return (list or nil) and (#list or 0)
end

function LifeCircleSignView:_refreshProgress(cur, max)
	local cellWidth = kCellWidth
	local spacing = self._hLayoutGroup.spacing
	local startPosX = self._goGraylinePosX
	local padding = self._hLayoutGroup.padding
	local left = padding.left
	local firstStep = left + cellWidth / 2
	local normalStep = spacing + cellWidth
	local width, maxWidth = self:_calcProgWidth(cur, spacing, cellWidth, firstStep, normalStep, startPosX, -startPosX)

	recthelper.setWidth(self._goGraylineTran, maxWidth)
	recthelper.setWidth(self._goNormallineTran, width)
end

function LifeCircleSignView:_calcProgWidth(value, spacing, cellWidth, firstStep, normalStep, startPosX, endSpace)
	local COList = self:_COList()
	local rewardCount = #COList

	if rewardCount == 0 then
		return 0, 0
	end

	startPosX = startPosX or 0
	endSpace = endSpace or 0
	firstStep = firstStep or cellWidth / 2
	normalStep = normalStep or cellWidth + spacing

	local maxWidth = firstStep + (rewardCount - 1) * normalStep + endSpace
	local curWidth = 0
	local last = 0

	for i, CO in ipairs(COList) do
		local num = CO.logindaysid
		local step = i == 1 and firstStep or normalStep

		if num <= value then
			curWidth = curWidth + step
			last = num
		else
			local offset = GameUtil.remap(value, last, num, 0, step)

			curWidth = curWidth + offset

			break
		end
	end

	local width = math.max(0, curWidth - startPosX)

	return width, maxWidth
end

function LifeCircleSignView:_getContentPosXByIndex(index)
	local scrollPixel = self:_calcHorizontalLayoutPixel(index)
	local halfViewportOfs = 0

	return -math.max(0, scrollPixel - halfViewportOfs)
end

function LifeCircleSignView:_refreshContentPosX(index)
	local posX = self:_getContentPosXByIndex(index)

	recthelper.setAnchorX(self._goContentTran, posX)
end

function LifeCircleSignView:_scrollContentTo(index)
	local posX = self:_getContentPosXByIndex(index)

	csTweenHelper.DOAnchorPosX(self._goContentTran, posX, 1)
end

function LifeCircleSignView:_calcHorizontalLayoutPixel(index)
	local cellWidth = kCellWidth
	local spacing = self._hLayoutGroup.spacing
	local padding = self._hLayoutGroup.padding
	local left = padding.left
	local viewportWidth = self:_viewportWidth()
	local maxWidth = recthelper.getWidth(self._goContentTran)
	local maxScrollPosX = math.max(0, maxWidth - viewportWidth)

	if index <= 1 then
		return 0
	end

	return math.min(maxScrollPosX, (index - 1) * (spacing + cellWidth) + left)
end

function LifeCircleSignView:_viewportWidth()
	return recthelper.getWidth(self._scrollRewardTrans)
end

function LifeCircleSignView:_refresh()
	local stagetitle = self:_stagetitle()

	self._txt.text = stagetitle

	gohelper.setActive(self._txtbgGO, not string.nilorempty(stagetitle))

	local totalLoginDays = self:totalLoginDays()

	self._txtDays.text = sf(luaLang("lifecirclesignview_txt_Days"), totalLoginDays)

	self:_refreshProgress(totalLoginDays, self:_maxLogindaysid())

	local width = self:_calcHLayoutContentMaxWidth(self:_COListCount())

	recthelper.setWidth(self._goContentTran, width)
	self:_refreshItemList()
end

function LifeCircleSignView:_refreshItemList()
	local COList = self:_COList()

	for i, CO in ipairs(COList) do
		local item

		if i > #self._itemList then
			item = self:_create_LifeCircleSignRewardsItem(i, self._goContent)

			ti(self._itemList, item)
		else
			item = self._itemList[i]
		end

		item:onUpdateMO(CO)
		item:setActive(true)
	end

	for i = #COList + 1, #self._itemList do
		local item = self._itemList[i]

		item:setActive(false)
	end
end

local kBlock = "LifeCircleSignView:_tryClaimAccumulateReward()"

function LifeCircleSignView:_tryClaimAccumulateReward()
	if not LifeCircleController.instance:isClaimableAccumulateReward() then
		return
	end

	UIBlockHelper.instance:startBlock(kBlock, 5, self.viewName)
	LifeCircleController.instance:sendSignInTotalRewardAllRequest(function(_, resultCode)
		UIBlockHelper.instance:endBlock(kBlock)

		if resultCode ~= 0 then
			SignInController.instance:sendGetSignInInfoRequestIfUnlock()
		end
	end)
end

return LifeCircleSignView
