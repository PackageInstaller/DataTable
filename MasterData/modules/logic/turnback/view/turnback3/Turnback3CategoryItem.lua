-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3CategoryItem.lua

module("modules.logic.turnback.view.turnback3.Turnback3CategoryItem", package.seeall)

local Turnback3CategoryItem = class("Turnback3CategoryItem", ListScrollCell)

function Turnback3CategoryItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(go, "beselected")
	self._gounselect = gohelper.findChild(go, "noselected")
	self._txtnamecn = gohelper.findChildText(go, "beselected/activitynamecn")
	self._txtnameen = gohelper.findChildText(go, "beselected/activitynamecn/activitynameen")
	self._txtunselectnamecn = gohelper.findChildText(go, "noselected/noactivitynamecn")
	self._txtunselectnameen = gohelper.findChildText(go, "noselected/noactivitynamecn/noactivitynameen")
	self._goreddot = gohelper.findChild(go, "#go_reddot")
	self._itemClick = gohelper.getClickWithAudio(self.go)
	self._gobubble = gohelper.findChild(go, "bubble")
	self._txtbubble = gohelper.findChildText(go, "bubble/#txt_num")
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	self._openAnimTime = 0.43

	self:playEnterAnim()
end

function Turnback3CategoryItem:addEventListeners()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function Turnback3CategoryItem:removeEventListeners()
	self._itemClick:RemoveClickListener()
end

function Turnback3CategoryItem:_onItemClick()
	if self._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
	self:_setLoginReddOtData(self._mo.id)
	TurnbackModel.instance:setTargetCategoryId(self._mo.id)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)
	self:_refreshItem()
end

function Turnback3CategoryItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()

	if Time.realtimeSinceStartup - TurnbackBeginnerCategoryListModel.instance.openViewTime > self._openAnimTime then
		self._anim:Play(UIAnimationName.Idle, 0, 1)
	end

	local isShowBubble = self:_isShowBubble()

	gohelper.setActive(self._gobubble, isShowBubble)
end

function Turnback3CategoryItem:_isShowBubble()
	if TurnbackModel.instance:getTargetCategoryId(self.curTurnbackId) == TurnbackEnum.ActivityId.Turnback4ProgressView then
		return false
	end

	if self._mo.id == TurnbackEnum.ActivityId.Turnback4ProgressView then
		local count = TurnbackModel.instance:getTotalCouponCount()

		self._txtbubble.text = count

		return count > 0
	end

	return false
end

function Turnback3CategoryItem:_refreshItem()
	self._selected = self._mo.id == TurnbackModel.instance:getTargetCategoryId(self.curTurnbackId)

	local co = TurnbackConfig.instance:getTurnbackSubModuleCo(self._mo.id)

	if not string.nilorempty(co.reddotId) then
		RedDotController.instance:addRedDot(self._goreddot, co.reddotId, nil, self._checkCustomShowRedDotData, self)
	end

	self._txtnamecn.text = co.name
	self._txtnameen.text = co.nameEn
	self._txtunselectnamecn.text = co.name
	self._txtunselectnameen.text = co.nameEn

	gohelper.setActive(self._goselect, self._selected)
	gohelper.setActive(self._gounselect, not self._selected)
end

function Turnback3CategoryItem:_checkCustomShowRedDotData(redDotIcon)
	TurnbackController.instance:_checkCustomShowRedDotData(redDotIcon, self._mo.id)
end

function Turnback3CategoryItem:_setLoginReddOtData(id)
	local signStr = self.curTurnbackId .. "_" .. id

	TimeUtil.setDayFirstLoginRed(signStr)
end

function Turnback3CategoryItem:playEnterAnim()
	local openAnimProgress = Mathf.Clamp01((Time.realtimeSinceStartup - TurnbackBeginnerCategoryListModel.instance.openViewTime) / self._openAnimTime)

	self._anim:Play(UIAnimationName.Open, 0, openAnimProgress)
end

function Turnback3CategoryItem:onDestroy()
	return
end

return Turnback3CategoryItem
