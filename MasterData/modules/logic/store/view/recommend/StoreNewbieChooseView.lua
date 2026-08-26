-- chunkname: @modules/logic/store/view/recommend/StoreNewbieChooseView.lua

module("modules.logic.store.view.recommend.StoreNewbieChooseView", package.seeall)

local StoreNewbieChooseView = class("StoreNewbieChooseView", StoreRecommendBaseSubView)
local newbieCharNum = 3
local autoSwitchNextCharTime = 3
local charIds = {
	3082,
	3020,
	3076
}
local jumpToPackTab = 10170

function StoreNewbieChooseView:onInitView()
	self._goNewbieChar1 = gohelper.findChild(self.viewGO, "recommend/anibg/#simage_char1")
	self._goNewbieChar2 = gohelper.findChild(self.viewGO, "recommend/anibg/#simage_char2")
	self._goNewbieChar3 = gohelper.findChild(self.viewGO, "recommend/anibg/#simage_char3")

	local goCharRoot = gohelper.findChild(self.viewGO, "recommend/anibg")

	self._charAnim = goCharRoot:GetComponent(typeof(UnityEngine.Animation))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreNewbieChooseView:addEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function StoreNewbieChooseView:removeEvents()
	self._btn:RemoveClickListener()
end

function StoreNewbieChooseView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local gotmp = gohelper.findChild(self.viewGO, "recommend")

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(gotmp)
	self._btn = gohelper.getClickWithAudio(self.viewGO)
	self._newbieCharGoList = self:getUserDataTb_()
	self._newbieCharGoList[1] = self._goNewbieChar3
	self._newbieCharGoList[2] = self._goNewbieChar2
	self._newbieCharGoList[3] = self._goNewbieChar1
end

function StoreNewbieChooseView:onOpen()
	StoreRecommendBaseSubView.onOpen(self)

	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.ChargeView)

	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, false)

	self._curCharIdx = 0

	self:_toNextChar()
	self._charAnim:Play()
end

function StoreNewbieChooseView:onClose()
	TaskDispatcher.cancelTask(self._toNextChar, self)
	StoreRecommendBaseSubView.onClose(self)
	self._charAnim:Stop()
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
end

function StoreNewbieChooseView:onUpdateParam()
	return
end

function StoreNewbieChooseView:_toNextChar()
	if self._curCharIdx >= newbieCharNum then
		self._curCharIdx = 0
	end

	self._curCharIdx = self._curCharIdx + 1

	if self._curCharIdx == newbieCharNum then
		StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
	end

	local newbieCharGo = self._newbieCharGoList[self._curCharIdx]
	local curCharId = charIds[self._curCharIdx]
	local charNameText = gohelper.findChildText(newbieCharGo, "name/image_NameBG/#txt_Name")
	local attrImage = gohelper.findChildImage(newbieCharGo, "name/#image_Attr")
	local heroConfig = HeroConfig.instance:getHeroCO(curCharId)

	charNameText.text = heroConfig.name

	UISpriteSetMgr.instance:setCommonSprite(attrImage, "lssx_" .. heroConfig.career)
	TaskDispatcher.runDelay(self._toNextChar, self, autoSwitchNextCharTime)
end

function StoreNewbieChooseView:_onClick()
	local jumpParams = string.splitToNumber(self.config.systemJumpCode, "#")

	if jumpParams[2] then
		local goodId = jumpParams[2]
		local packageMo = StoreModel.instance:getGoodsMO(goodId)

		StoreController.instance:openPackageStoreGoodsView(packageMo)
	else
		GameFacade.jumpByAdditionParam(jumpToPackTab .. "#" .. StoreEnum.NewbiePackId)
	end

	AudioMgr.instance:trigger(2000001)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})
end

function StoreNewbieChooseView:onDestroyView()
	TaskDispatcher.cancelTask(self._toNextChar, self)
end

return StoreNewbieChooseView
