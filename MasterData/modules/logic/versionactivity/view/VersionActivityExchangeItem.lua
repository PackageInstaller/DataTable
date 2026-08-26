-- chunkname: @modules/logic/versionactivity/view/VersionActivityExchangeItem.lua

module("modules.logic.versionactivity.view.VersionActivityExchangeItem", package.seeall)

local VersionActivityExchangeItem = class("VersionActivityExchangeItem", LuaCompBase)

function VersionActivityExchangeItem:init(go)
	self.go = go
	self._txtneed = gohelper.findChildText(self.go, "state/txt_need")
	self._gounfinishstate = gohelper.findChild(self.go, "state/go_unfinishstate")
	self._gofinishstate = gohelper.findChild(self.go, "state/go_finishstate")
	self._gorewardcontent = gohelper.findChild(self.go, "#go_rewardcontent")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self._goget = gohelper.findChild(self.go, "go_get")
	self._golingqu = gohelper.findChild(self.go, "go_get/#lingqu")
	self._gofinish = gohelper.findChild(self.go, "go_finish")
	self._gounfinish = gohelper.findChild(self.go, "go_unfinish")
	self._goselected = gohelper.findChild(self.go, "go_selected")
	self._goselectedbg = gohelper.findChildSingleImage(self.go, "go_selected/bg")
	self._gorewarditem = gohelper.findChild(self.go, "#go_rewardcontent/anim/#go_rewarditem")
	self._imgiconbgunselect = gohelper.findChildImage(self.go, "hero/img_iconbgunselect")
	self._imgiconbgselect = gohelper.findChildImage(self.go, "hero/img_iconbgselect")
	self._imgheadicon = gohelper.findChildSingleImage(self.go, "hero/mask/img_headicon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityExchangeItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.updateLingqu, self)
end

function VersionActivityExchangeItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.updateLingqu, self)
end

function VersionActivityExchangeItem:_btnClickOnClick()
	if self.state == -1 then
		-- block empty
	elseif self.state == 1 then
		local param = {}

		param.mark = true

		StoryController.instance:playStory(self.config.storyId, param)
	else
		local hasQuantity = ItemModel.instance:getItemQuantity(self.needArr[1], self.needArr[2])

		if hasQuantity >= self.needArr[3] then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self.config.storyId, param, self.sendExchange112Request, self)
		else
			local config = ItemModel.instance:getItemConfigAndIcon(self.needArr[1], self.needArr[2])

			ToastController.instance:showToast(3202, (config or nil) and (config.name or self.needArr[2]))
		end
	end

	self:onClick()
end

function VersionActivityExchangeItem:sendExchange112Request()
	if self.state == 0 then
		UIBlockMgr.instance:startBlock("VersionActivityExchangeItem")

		if self._animatorPlayer then
			self._animatorPlayer:Play(UIAnimationName.Close, self.sendRequest, self)
		else
			self:sendRequest()
		end
	end

	gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, false)
end

function VersionActivityExchangeItem:sendRequest()
	UIBlockMgr.instance:endBlock("VersionActivityExchangeItem")
	Activity112Rpc.instance:sendExchange112Request(self.config.activityId, self.config.id)
end

function VersionActivityExchangeItem:onClick()
	self.selectFunc(self.selectFuncObj, self.config)
end

function VersionActivityExchangeItem:_editableInitView()
	self.rewardItemList = {}
	self.click = gohelper.findChildClick(self.go, "")

	self.click:AddClickListener(self.onClick, self)
	self._goselectedbg:LoadImage(ResUrl.getVersionActivityExchangeIcon("img_bg_jiangjilan_xuanzhong"))

	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.go)
	self._gorewardcontentcg = gohelper.findChild(self._gorewardcontent, "anim"):GetComponent(typeof(UnityEngine.CanvasGroup))
end

function VersionActivityExchangeItem:setSelectFunc(selectFunc, selectFuncObj)
	self.selectFunc = selectFunc
	self.selectFuncObj = selectFuncObj
end

function VersionActivityExchangeItem:updateSelect(id)
	gohelper.setActive(self._goselected, self.config.id == id)
	gohelper.setActive(self._imgiconbgselect.gameObject, self.config.id == id)
	gohelper.setActive(self._imgiconbgunselect.gameObject, self.config.id ~= id)
end

VersionActivityExchangeItem.DefaultHeadOffsetX = 2.4
VersionActivityExchangeItem.DefaultHeadOffsetY = -70.9

function VersionActivityExchangeItem:updateItem(config, index, playAnimator)
	self.config = config
	self.needArr = string.splitToNumber(config.items, "#")

	self._imgheadicon:LoadImage(config.head)

	local headoffset = string.splitToNumber(config.chatheadsOffSet, "#")

	recthelper.setAnchor(self._imgheadicon.transform, headoffset[1] or VersionActivityExchangeItem.DefaultHeadOffsetX, headoffset[2] or VersionActivityExchangeItem.DefaultHeadOffsetY)

	self.state = -1
	self.state = VersionActivity112Model.instance:getRewardState(self.config.activityId, self.config.id)

	local arr = GameUtil.splitString2(config.bonus, true)

	for i, v in ipairs(arr) do
		local item = self.rewardItemList[i]

		if item == nil then
			item = {
				go = gohelper.cloneInPlace(self._gorewarditem, "item" .. i)
			}

			local iconroot = gohelper.findChild(item.go, "go_iconroot")

			item.icon = IconMgr.instance:getCommonItemIcon(iconroot)
			self.rewardItemList[i] = item
		end

		item.icon:setMOValue(v[1], v[2], v[3])
		item.icon:isShowCount(true)
		item.icon:setScale(0.5, 0.5, 0.5)
		item.icon:setCountFontSize(52)
		gohelper.setActive(item.go, true)
		gohelper.setActive(gohelper.findChild(item.go, "go_finish"), self.state == 1)
	end

	for i = #arr + 1, #self.rewardItemList do
		gohelper.setActive(self.rewardItemList[i].go, false)
	end

	self._gorewardcontentcg.alpha = self.state == 1 and 0.45 or 1

	gohelper.setActive(self._gofinish, self.state == 1)

	self._txtneed.text = self.needArr[3]

	self:updateNeed()
	self:updateLingqu()

	self._animator.enabled = true

	if playAnimator then
		self._animator:Play(UIAnimationName.Open, 0, 0)
		self._animator:Update(0)

		local currentAnimatorStateInfo = self._animator:GetCurrentAnimatorStateInfo(0)
		local length = currentAnimatorStateInfo.length

		if length <= 0 then
			length = 1
		end

		self._animator:Play(UIAnimationName.Open, 0, -0.066 * (index - 1) / length)
		self._animator:Update(0)
	else
		self._animator:Play(UIAnimationName.Open, 0, 1)
		self._animator:Update(0)
	end
end

function VersionActivityExchangeItem:updateNeed()
	local hasQuantity = ItemModel.instance:getItemQuantity(self.needArr[1], self.needArr[2])

	gohelper.setActive(self._gounfinishstate, hasQuantity < self.needArr[3])
	gohelper.setActive(self._gofinishstate, hasQuantity >= self.needArr[3])
end

function VersionActivityExchangeItem:updateLingqu()
	local hasQuantity = ItemModel.instance:getItemQuantity(self.needArr[1], self.needArr[2])

	gohelper.setActive(self._golingqu, true)
	gohelper.setActive(self._goget, self.state == 0 and hasQuantity >= self.needArr[3])
	gohelper.setActive(self._gounfinish, self.state == 0 and hasQuantity < self.needArr[3])
end

function VersionActivityExchangeItem:onDestroyView()
	self.rewardItemList = nil

	self.click:RemoveClickListener()
	self._goselectedbg:UnLoadImage()
end

return VersionActivityExchangeItem
