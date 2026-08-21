-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/cell/WelfareSignInItemCell.lua

module("logic.extensions.signin.cell.WelfareSignInItemCell", package.seeall)

local M = class("WelfareSignInItemCell")
local kImportantItemBgName = "rdds_bf_0006"
local kNormalItemBgName = "rdds_bf_0005"
local kImportantNumColor = "#FFFFFF"
local kNormalNumColor = "#B6B7B7"

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	self._canvasGroup = self._registry:getUIComponent("sign_in_item_174912497", ComponentType.CanvasGroup)
	self._txtNum = self._registry:getText("sign_in_item_1686832625")
	self._txtNumMul = goutil.findChildTextComponent(self._txtNum.gameObject, "Text1")
	self._btnItemClick = self._registry:getBtn("sign_in_item_154812401")
	self._imgItemIcon = self._registry:getImage("sign_in_item_154812401")
	self._imgQuality = self._registry:getImage("sign_in_item_569090698")
	self._imgDay = self._registry:getImage("sign_in_item_-1633312477")
	self._imgItemBg = self._registry:getImage("sign_in_item_2129690909")
	self._goImgSelect = self._registry:getGo("sign_in_item_1552671839")
	self._goReceived = self._registry:getGo("sign_in_item_-1864057499")
	self._txtItemName = self._registry:getUIComponent("sign_in_item_1247317780", UIComponentType.Text)

	self._btnItemClick:SetClickInterval(0.3)
	goutil.setActive(self._goImgSelect, false)
end

function M:destroyUI()
	self._canvasGroup:DOKill(false)

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	self._animation = nil
	self._txtNum = nil
	self._btnItemClick = nil
	self._imgItemIcon = nil
	self._imgQuality = nil
	self._goImgSelect = nil

	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end
end

function M:bindEvents()
	self._btnItemClick:AddClickListener(self._onItemClick, self)
end

function M:unbindEvents()
	self._btnItemClick:RemoveClickListener()
end

function M:setData(data)
	self._activityId = data.activityId
	self._uiIndex = data.day
	self._rewardType = data.rewardType

	local isImportantReward = self._rewardType == WelfareSigninEnum.SevenSignInRewardType.Important

	if isImportantReward then
		IconLoader.setSprite(self._imgDay, IconType.DynSpriteAtlas_Wekfare, string.format("rdds_text_day_0%dblack", self._uiIndex))
		IconLoader.setSprite(self._imgItemBg, IconType.DynSpriteAtlas_Wekfare, kImportantItemBgName)

		self._imgDay.color = parsecolor("#FFFFFF")
	else
		IconLoader.setSprite(self._imgDay, IconType.DynSpriteAtlas_Wekfare, "rdds_text_day_0" .. self._uiIndex)
		IconLoader.setSprite(self._imgItemBg, IconType.DynSpriteAtlas_Wekfare, kNormalItemBgName)

		self._imgDay.color = parsecolor("#FFFFFF19")
	end

	self._canvasGroup:DOKill(false)

	self._canvasGroup.alpha = data.isReceived and 0.3 or 1

	goutil.setActive(self._goReceived, data.isReceived)

	self._itemData = ItemUtil.createItemData({
		itemId = data.itemId
	})

	self._itemData:setCount(data.itemCount)

	self._txtNum.text = data.itemCount
	self._isCanReceive = data.canReceive

	goutil.setActive(self._goImgSelect, self._isCanReceive)
	self:updateItemImg(data.itemId)
end

function M:_onItemClick()
	local actMO = ActivityModel.instance:getActivityById(self._activityId)
	local isActivityOpen = actMO and WelfareUtil.isShowActivity(actMO)

	if not isActivityOpen and self._isCanReceive then
		FloatWordMgr.instance:show(lang("tip_activity_end"))

		return
	end

	if WelfareSigninModel.instance:isCanReceive(self._activityId, self._uiIndex) then
		WelfareSigninAgent.instance:sendTakeSignInRewardRequest(self._activityId, self._uiIndex)
	else
		local itemData = self._itemData
		local cellIndex = 0
		local showTips = true
		local showTipsPassEvent = true

		GlobalDispatcher:dispatchEvent(EventType.ITEM_NORMAL_MARK_TYPE, itemData, self._goImgSelect.gameObject, cellIndex, showTips, showTipsPassEvent)
	end
end

function M:updateItemImg(itemId)
	itemId = itemId and itemId or 0

	if itemId <= 0 then
		return
	end

	local itemData = ItemUtil.createItemData({
		count = 0,
		itemId = itemId
	})
	local itemType = itemData:getType()
	local itemIcon = itemData:getIcon()
	local itemQuality = itemData:getQuality()
	local iconType = IconLoader.itemTypeToIconType(itemType)

	self._txtItemName.text = itemData:getName()

	IconLoader.setSprite(self._imgItemIcon, iconType, itemIcon)
	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_Wekfare, GameUrl.getSignInItemQualityUrl(itemQuality))
end

function M:setIsSign(isSigned)
	self._isSigned = isSigned
end

function M:getIsSign()
	return self._isSigned
end

function M:playSignAni(callBackFunc, callBackHandler)
	local duration = 0.4

	self._canvasGroup:DOKill(false)
	self._canvasGroup:DOFade(0.5, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end

	self._delayTween = DoTweenUtil.DelayedCall(duration, function()
		self:setIsSign(true)

		if callBackHandler and callBackFunc then
			callBackFunc(callBackHandler)
		end
	end)
end

return M
