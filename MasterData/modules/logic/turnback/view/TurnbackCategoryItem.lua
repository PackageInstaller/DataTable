-- chunkname: @modules/logic/turnback/view/TurnbackCategoryItem.lua

module("modules.logic.turnback.view.TurnbackCategoryItem", package.seeall)

local TurnbackCategoryItem = class("TurnbackCategoryItem", ListScrollCell)

function TurnbackCategoryItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(go, "beselected")
	self._gounselect = gohelper.findChild(go, "noselected")
	self._txtnamecn = gohelper.findChildText(go, "beselected/activitynamecn")
	self._txtnameen = gohelper.findChildText(go, "beselected/activitynamecn/activitynameen")
	self._txtunselectnamecn = gohelper.findChildText(go, "noselected/noactivitynamecn")
	self._txtunselectnameen = gohelper.findChildText(go, "noselected/noactivitynamecn/noactivitynameen")
	self._goreddot = gohelper.findChild(go, "#go_reddot")
	self._itemClick = gohelper.getClickWithAudio(self.go)
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	self._openAnimTime = 0.43

	self:playEnterAnim()
end

function TurnbackCategoryItem:addEventListeners()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function TurnbackCategoryItem:removeEventListeners()
	self._itemClick:RemoveClickListener()
end

function TurnbackCategoryItem:_onItemClick()
	if self._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
	self:_setLoginReddOtData(self._mo.id)
	TurnbackModel.instance:setTargetCategoryId(self._mo.id)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)
	self:_refreshItem()
end

function TurnbackCategoryItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()

	if Time.realtimeSinceStartup - TurnbackBeginnerCategoryListModel.instance.openViewTime > self._openAnimTime then
		self._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function TurnbackCategoryItem:_refreshItem()
	self._selected = self._mo.id == TurnbackModel.instance:getTargetCategoryId(self.curTurnbackId)

	local co = TurnbackConfig.instance:getTurnbackSubModuleCo(self._mo.id)

	RedDotController.instance:addRedDot(self._goreddot, co.reddotId, nil, self._checkCustomShowRedDotData, self)

	self._txtnamecn.text = co.name
	self._txtnameen.text = co.nameEn
	self._txtunselectnamecn.text = co.name
	self._txtunselectnameen.text = co.nameEn

	gohelper.setActive(self._goselect, self._selected)
	gohelper.setActive(self._gounselect, not self._selected)
end

function TurnbackCategoryItem:_checkCustomShowRedDotData(redDotIcon)
	TurnbackController.instance:_checkCustomShowRedDotData(redDotIcon, self._mo.id)
end

function TurnbackCategoryItem:_setLoginReddOtData(id)
	local signStr = self.curTurnbackId .. "_" .. id

	TimeUtil.setDayFirstLoginRed(signStr)
end

function TurnbackCategoryItem:playEnterAnim()
	local openAnimProgress = Mathf.Clamp01((Time.realtimeSinceStartup - TurnbackBeginnerCategoryListModel.instance.openViewTime) / self._openAnimTime)

	self._anim:Play(UIAnimationName.Open, 0, openAnimProgress)
end

function TurnbackCategoryItem:onDestroy()
	return
end

return TurnbackCategoryItem
