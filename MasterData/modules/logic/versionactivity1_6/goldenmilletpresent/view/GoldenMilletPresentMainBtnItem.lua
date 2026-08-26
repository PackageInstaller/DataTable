-- chunkname: @modules/logic/versionactivity1_6/goldenmilletpresent/view/GoldenMilletPresentMainBtnItem.lua

module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentMainBtnItem", package.seeall)

local GoldenMilletPresentMainBtnItem = class("GoldenMilletPresentMainBtnItem", LuaCompBase)

function GoldenMilletPresentMainBtnItem:init(go)
	self.go = go
	self._imgitem = gohelper.findChildImage(self.go, "bg")
	self._btnitem = gohelper.findChildClickWithAudio(self.go, "bg", AudioEnum.UI.GoldenMilletMainBtnClick)
	self._redDotParent = gohelper.findChild(self.go, "go_activityreddot")

	UISpriteSetMgr.instance:setMainSprite(self._imgitem, "v1a6_act_icon4")

	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()

	if not ActivityType101Model.instance:isInit(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	end

	self.redDot = RedDotController.instance:addNotEventRedDot(self._redDotParent, GoldenMilletPresentModel.isShowRedDot, GoldenMilletPresentModel.instance)

	gohelper.setActive(self.go, true)
end

function GoldenMilletPresentMainBtnItem:addEventListeners()
	self._btnitem:AddClickListener(self._onItemClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshRedDot, self)
end

function GoldenMilletPresentMainBtnItem:removeEventListeners()
	self._btnitem:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshRedDot, self)
end

function GoldenMilletPresentMainBtnItem:_onItemClick()
	GoldenMilletPresentController.instance:openGoldenMilletPresentView()
end

function GoldenMilletPresentMainBtnItem:refreshRedDot()
	if not gohelper.isNil(self.redDot.gameObject) then
		return
	end

	self.redDot:refreshRedDot()
end

function GoldenMilletPresentMainBtnItem:isShowRedDot()
	return self.redDot and self.redDot.isShowRedDot
end

function GoldenMilletPresentMainBtnItem:destroy()
	gohelper.setActive(self.go, false)
	gohelper.destroy(self.go)
end

function GoldenMilletPresentMainBtnItem:onDestroy()
	self.go = nil
	self._imgitem = nil
	self._btnitem = nil
	self.redDot = nil
end

return GoldenMilletPresentMainBtnItem
