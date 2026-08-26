-- chunkname: @modules/logic/versionactivity1_6/decalogpresent/view/DecalogPresetMainBtnItem.lua

module("modules.logic.versionactivity1_6.decalogpresent.view.DecalogPresetMainBtnItem", package.seeall)

local DecalogPresetMainBtnItem = class("DecalogPresetMainBtnItem", LuaCompBase)

function DecalogPresetMainBtnItem:init(go)
	self.go = go
	self._imgitem = gohelper.findChildImage(self.go, "bg")
	self._btnitem = gohelper.findChildClickWithAudio(self.go, "bg", AudioEnum.ui_activity.play_ui_activity_open)
	self._redDotParent = gohelper.findChild(self.go, "go_activityreddot")

	UISpriteSetMgr.instance:setMainSprite(self._imgitem, "v1a6_act_icon1")

	local actId = DecalogPresentModel.instance:getDecalogPresentActId()

	if not ActivityType101Model.instance:isInit(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	end

	self.redDot = RedDotController.instance:addNotEventRedDot(self._redDotParent, DecalogPresentModel.isShowRedDot, DecalogPresentModel.instance)

	gohelper.setActive(self.go, true)
end

function DecalogPresetMainBtnItem:addEventListeners()
	self._btnitem:AddClickListener(self._onItemClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshRedDot, self)
end

function DecalogPresetMainBtnItem:removeEventListeners()
	self._btnitem:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshRedDot, self)
end

function DecalogPresetMainBtnItem:_onItemClick()
	DecalogPresentController.instance:openDecalogPresentView()
end

function DecalogPresetMainBtnItem:refreshRedDot()
	if not gohelper.isNil(self.redDot.gameObject) then
		return
	end

	self.redDot:refreshRedDot()
end

function DecalogPresetMainBtnItem:isShowRedDot()
	return self.redDot and self.redDot.isShowRedDot
end

function DecalogPresetMainBtnItem:destroy()
	gohelper.setActive(self.go, false)
	gohelper.destroy(self.go)
end

function DecalogPresetMainBtnItem:onDestroy()
	self.go = nil
	self._imgitem = nil
	self._btnitem = nil
	self.redDot = nil
end

return DecalogPresetMainBtnItem
