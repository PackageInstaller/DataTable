-- chunkname: @modules/logic/versionactivity/view/VersionActivityExchangeTaskItem.lua

module("modules.logic.versionactivity.view.VersionActivityExchangeTaskItem", package.seeall)

local VersionActivityExchangeTaskItem = class("VersionActivityExchangeTaskItem", LuaCompBase)

function VersionActivityExchangeTaskItem:init(go)
	self.go = go
	self.viewGO = go
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "simage_bg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._txtcurcount = gohelper.findChildText(self.viewGO, "#txt_curcount")
	self._txttotalcount = gohelper.findChildText(self.viewGO, "#txt_totalcount")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._btnreceive = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_receive")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._goblackmask = gohelper.findChild(self.viewGO, "#go_mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityExchangeTaskItem:addEventListeners()
	self._btnreceive:AddClickListener(self._btnreceiveOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function VersionActivityExchangeTaskItem:removeEventListeners()
	self._btnreceive:RemoveClickListener()
	self._btnjump:RemoveClickListener()
end

function VersionActivityExchangeTaskItem:_btnreceiveOnClick()
	self._animator:Play("finish")
	UIBlockMgr.instance:startBlock("VersionActivityExchangeTaskItem")
	TaskDispatcher.runDelay(self.sendRewardRequest, self, 0.6)
end

function VersionActivityExchangeTaskItem:_btnjumpOnClick()
	GameFacade.jump(self.mo.config.jumpId)
end

function VersionActivityExchangeTaskItem:_editableInitView()
	self.icon = IconMgr.instance:getCommonItemIcon(self._gorewards)

	self.icon:setCountFontSize(36)
	self._simagebg:LoadImage(ResUrl.getVersionActivityExchangeIcon("bg_rwdi"))

	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
end

function VersionActivityExchangeTaskItem:sendRewardRequest()
	UIBlockMgr.instance:endBlock("VersionActivityExchangeTaskItem")
	Activity112Rpc.instance:sendReceiveAct112TaskRewardRequest(self.mo.actId, self.mo.id)
end

function VersionActivityExchangeTaskItem:onUpdateMO(mo, index, playAnimator)
	self.mo = mo
	self._txtdesc.text = mo.config.desc
	self._txtcurcount.text = mo.progress
	self._txttotalcount.text = mo.config.maxProgress

	self:_setCurCountFontSize()

	local arr = GameUtil.splitString2(mo.config.bonus, true)[1]

	self.icon:setMOValue(arr[1], arr[2], arr[3])
	self.icon:isShowCount(true)
	gohelper.setActive(self._btnjump.gameObject, mo.config.maxProgress > mo.progress and mo.hasGetBonus == false)
	gohelper.setActive(self._btnreceive.gameObject, mo.config.maxProgress <= mo.progress and mo.hasGetBonus == false)
	gohelper.setActive(self._gofinish, mo.hasGetBonus)
	gohelper.setActive(self._goblackmask, mo.hasGetBonus)

	if playAnimator then
		self._animator:Play(UIAnimationName.Open, 0, 0)
		self._animator:Update(0)

		local currentAnimatorStateInfo = self._animator:GetCurrentAnimatorStateInfo(0)
		local length = currentAnimatorStateInfo.length

		if length <= 0 then
			length = 1
		end

		self._animator:Play(UIAnimationName.Open, 0, -0.06 * (index - 1) / length)
		self._animator:Update(0)
	else
		self._animator:Play(UIAnimationName.Open, 0, 1)
		self._animator:Update(0)
	end
end

function VersionActivityExchangeTaskItem:_setCurCountFontSize()
	local minScale, maxScale = 0.35, 0.7
	local targetScale = maxScale
	local maxValueSize = 6
	local valueCount = #self._txtcurcount.text
	local canMaxValueCount = 3

	if canMaxValueCount < valueCount then
		targetScale = maxScale - (maxScale - minScale) / (maxValueSize - canMaxValueCount) * (valueCount - canMaxValueCount)
	end

	transformhelper.setLocalScale(self._txtcurcount.transform, targetScale, targetScale, 1)
end

function VersionActivityExchangeTaskItem:onDestroyView()
	self._simagebg:UnLoadImage()
end

return VersionActivityExchangeTaskItem
