-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityQuoteDemandItem.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteDemandItem", package.seeall)

local ActivityQuoteDemandItem = class("ActivityQuoteDemandItem", UserDataDispose)

function ActivityQuoteDemandItem:ctor(go)
	self:__onInit()

	self.go = go
	self.anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._simagebg = gohelper.findChildSingleImage(self.go, "simage_bg")

	self._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_changguidi"))

	self.goFinish = gohelper.findChild(self.go, "go_finish")
	self.txtCurProgress = gohelper.findChildTextMesh(self.go, "layout/left/txt_curcount")
	self.txtMaxProgress = gohelper.findChildTextMesh(self.go, "layout/right/txt_curcount")
	self.txtDesc = gohelper.findChildTextMesh(self.go, "txt_desc")
	self.txtPricerange = gohelper.findChildTextMesh(self.go, "bargain/txt_pricerange")
	self.btnJump = gohelper.findChildButtonWithAudio(self.go, "btn_jump", AudioEnum.UI.play_ui_petrus_mission_skip)

	self.btnJump:AddClickListener(self.onClickJump, self)

	self.btnCancel = gohelper.findChildButtonWithAudio(self.go, "btn_cancel", AudioEnum.UI.Play_UI_Rolesback)

	self.btnCancel:AddClickListener(self.onClickCancel, self)

	self.btnBargain = gohelper.findChildButtonWithAudio(self.go, "btn_bargain")

	self.btnBargain:AddClickListener(self.onClickStartBargain, self)

	self._simageclickbg = gohelper.findChildSingleImage(self.go, "click/bg")

	self._simageclickbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_diehei"))
end

function ActivityQuoteDemandItem:setData(data, allFinish, index, count, callback, callbackObj)
	self.data = data

	if not data then
		gohelper.setActive(self.go, false)

		return
	end

	self.index = index
	self.count = count
	self.callback = callback
	self.callbackObj = callbackObj

	gohelper.setActive(self.go, true)

	local isFinish = data:isProgressEnough()
	local hasGetBonus = data.hasGetBonus
	local isSelect = data.id == Activity117Model.instance:getSelectOrder(data.activityId)

	if isSelect then
		gohelper.setActive(self.btnCancel, true)
		gohelper.setActive(self.goFinish, false)
		gohelper.setActive(self.btnJump, false)
		gohelper.setActive(self.btnBargain, false)
	elseif allFinish then
		gohelper.setActive(self.goFinish, true)
		gohelper.setActive(self.btnJump, false)
		gohelper.setActive(self.btnBargain, false)
		gohelper.setActive(self.btnCancel, false)
	else
		gohelper.setActive(self.goFinish, hasGetBonus)
		gohelper.setActive(self.btnJump, not isFinish and not hasGetBonus)
		gohelper.setActive(self.btnBargain, isFinish and not hasGetBonus)
		gohelper.setActive(self.btnCancel, false)
	end

	self.txtCurProgress.text = (isFinish or hasGetBonus) and "1" or "0"
	self.txtMaxProgress.text = "1"
	self.txtDesc.text = data:getDesc() or ""
	self.txtPricerange.text = string.format("%s-%s", data.minScore, data.maxScore)

	if not self.playedAnim then
		self.playedAnim = true
		self.anim.speed = 0

		local delayTime = (index - 1) * 0.06

		if delayTime and delayTime > 0 then
			TaskDispatcher.runDelay(self.playOpenAnim, self, delayTime)
		else
			self:playOpenAnim()
		end
	else
		self:checkDoCallback()
	end
end

function ActivityQuoteDemandItem:playOpenAnim()
	TaskDispatcher.cancelTask(self.playOpenAnim, self)

	self.anim.speed = 1

	self.anim:Play(UIAnimationName.Open, 0, 0)
	self:checkDoCallback()
end

function ActivityQuoteDemandItem:checkDoCallback()
	if self.index == self.count and self.callback then
		self.callback(self.callbackObj)

		self.callback = nil
	end
end

function ActivityQuoteDemandItem:onAllAnimFinish()
	if self.data then
		local go = gohelper.findChild(self.btnBargain.gameObject, "huan")

		gohelper.setActive(go, false)
		gohelper.setActive(go, true)
	end
end

function ActivityQuoteDemandItem:onClickStartBargain()
	if not self.data then
		return
	end

	local data = self.data
	local actId = data.activityId

	Activity117Model.instance:setSelectOrder(actId, data.id)
	Activity117Model.instance:setInQuote(actId)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, actId)
end

function ActivityQuoteDemandItem:onClickJump()
	if self.data then
		if not self.data then
			return
		end

		local item = {
			jumpId = 10011205,
			special = true,
			desc = luaLang("versionactivity_1_2_tradedemand"),
			sceneType = SceneType.Main,
			checkFunc = self.data.isProgressEnough,
			checkFuncObj = self.data
		}

		GameFacade.jump(self.data, nil, nil, item)
	end
end

function ActivityQuoteDemandItem:onClickCancel()
	if not self.data then
		return
	end

	local actId = self.data.activityId

	Activity117Model.instance:setSelectOrder(actId)
	Activity117Model.instance:setInQuote(actId)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, actId)
end

function ActivityQuoteDemandItem:destory()
	if self.btnBargain then
		self.btnBargain:RemoveClickListener()
	end

	if self.btnJump then
		self.btnJump:RemoveClickListener()
	end

	if self.btnCancel then
		self.btnCancel:RemoveClickListener()
	end

	self._simagebg:UnLoadImage()
	self._simageclickbg:UnLoadImage()
	TaskDispatcher.cancelTask(self.playOpenAnim, self)
	self:__onDispose()
end

return ActivityQuoteDemandItem
