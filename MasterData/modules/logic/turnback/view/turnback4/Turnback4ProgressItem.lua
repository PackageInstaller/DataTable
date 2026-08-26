-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4ProgressItem.lua

module("modules.logic.turnback.view.turnback4.Turnback4ProgressItem", package.seeall)

local Turnback4ProgressItem = class("Turnback4ProgressItem", LuaCompBase)

function Turnback4ProgressItem:init(go)
	self.viewGO = go
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "#simage_pic")
	self._txttitle = gohelper.findChildText(self.viewGO, "titlebg/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "txt_desc")
	self._gotime = gohelper.findChild(self.viewGO, "time")
	self._txttime = gohelper.findChildText(self.viewGO, "time/#txt_time")
	self._goreward = gohelper.findChild(self.viewGO, "reward")
	self._gorewarditem = gohelper.findChild(self.viewGO, "reward/#go_rewarditem")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._simagelockpic = gohelper.findChildSingleImage(self.viewGO, "#go_lock/#simage_pic")
	self._btnactivity = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_activity")
	self._gojumpnormal = gohelper.findChild(self.viewGO, "#btn_activity/image_goto")
	self._gojumplock = gohelper.findChild(self.viewGO, "#btn_activity/lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback4ProgressItem:addEventListeners()
	self._btnactivity:AddClickListener(self._btnactivityOnClick, self)
end

function Turnback4ProgressItem:removeEventListeners()
	self._btnactivity:RemoveClickListener()
end

function Turnback4ProgressItem:_btnactivityOnClick()
	if self.config.jumpId == 0 then
		return
	end

	GameFacade.jump(self.config.jumpId, self._finishTask, self)
end

function Turnback4ProgressItem:_finishTask()
	local taskId = TurnbackController.instance:getProgressTaskId()

	if taskId then
		TurnbackRpc.instance:sendFinishReadTaskRequest(taskId)
		StatController.instance:track(StatEnum.EventName.ReflowActivityJump, {
			[StatEnum.EventProperties.TurnbackJumpName] = self.config.name,
			[StatEnum.EventProperties.TurnbackJumpId] = tostring(self.config.id)
		})
	end
end

function Turnback4ProgressItem:_editableInitView()
	self._rewardItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem.gameObject, false)
end

function Turnback4ProgressItem:onUpdateMO(mo)
	self.mo = mo
	self.config = self.mo.co

	if not string.nilorempty(self.config.picPath) then
		local icon = ResUrl.getTurnbackIcon("new/progress/" .. self.config.picPath)

		self._simagepic:LoadImage(icon)
		self._simagelockpic:LoadImage(icon)
	end

	self._txttitle.text = mo:getName()

	local showRewardItem = mo:isShowRewardItem()

	gohelper.setActive(self._txtdesc.gameObject, not showRewardItem)
	gohelper.setActive(self._goreward.gameObject, showRewardItem)

	if showRewardItem then
		-- block empty
	else
		self._txtdesc.text = self.config.showTxt
	end

	local isUnlock = mo:isUnlock()
	local isJump = not string.nilorempty(self.config.jumpId)

	gohelper.setActive(self._btnactivity.gameObject, isJump)
	gohelper.setActive(self._gojumpnormal.gameObject, isUnlock)
	gohelper.setActive(self._gojumplock.gameObject, not isUnlock)
	gohelper.setActive(self._golock, not isUnlock)
	self:_refreshTime()

	local showTime = self.mo:getShowTime()

	TaskDispatcher.cancelTask(self._refreshTime, self)

	if showTime then
		-- block empty
	end

	self:_refreshRewards()
end

function Turnback4ProgressItem:refreshTurnBack()
	self:_refreshRewards()
end

function Turnback4ProgressItem:_refreshRewards()
	local rewards = self.mo:getShowRewards()

	if rewards then
		for i, v in ipairs(rewards) do
			local item = self:_getRewardItem(i)
			local materialType = v[1]
			local materialId = v[2]
			local count = self.mo:getCount(materialType, materialId, 1)
			local isReceive = count <= 0

			item.iconItem:setMOValue(materialType, materialId, count, nil, true)
			item.iconItem:isShowCount(v[1] ~= MaterialEnum.MaterialType.Hero and not isReceive)
			item.iconItem:setScale(0.6)
			item.iconItem:setCountFontSize(45)
			item.iconItem:showStackableNum2()
			item.iconItem:hideEquipLvAndCount()
			gohelper.setActive(item.gocanget, false)
			gohelper.setActive(item.goreceive, isReceive)
		end
	end

	if rewards then
		if not #rewards then
			local count = 0

			for i, item in ipairs(self._rewardItems) do
				gohelper.setActive(item.go, i <= count)
			end
		end
	end
end

function Turnback4ProgressItem:_getRewardItem(index)
	local item = self._rewardItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gorewarditem)
		item.itemParent = gohelper.findChild(item.go, "go_icon")
		item.gocanget = gohelper.findChild(item.go, "go_canget")
		item.goreceive = gohelper.findChild(item.go, "go_receive")
		item.iconItem = IconMgr.instance:getCommonItemIcon(item.itemParent)
		self._rewardItems[index] = item
	end

	return item
end

function Turnback4ProgressItem:_refreshTime()
	local showTime = self.mo:getShowTime()

	gohelper.setActive(self._gotime, showTime)

	if showTime then
		if not self._actMo then
			local actId = self.mo:getActId()

			self._actMo = ActivityModel.instance:getActMO(actId)
		end

		if self._actMo then
			local offsetSecond = self._actMo:getRealEndTimeStamp() - ServerTime.now()

			if offsetSecond > 0 then
				self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
			end
		end
	end
end

function Turnback4ProgressItem:onDestroy()
	self._simagepic:UnLoadImage()
	self._simagelockpic:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

return Turnback4ProgressItem
