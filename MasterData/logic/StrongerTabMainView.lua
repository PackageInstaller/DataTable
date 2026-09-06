-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/strongertabmainview/StrongerTabMainView.lua

module("logic.extensions.tabframework.view.strongertabmainview.StrongerTabMainView", package.seeall)

local StrongerTabMainView = class("StrongerTabMainView", ViewComponent)

function StrongerTabMainView:ctor()
	StrongerTabMainView.super.ctor(self)
end

function StrongerTabMainView:destroyUI()
	StrongerTabMainView.super.destroyUI(self)
end

function StrongerTabMainView:buildUI()
	StrongerTabMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self._getFrameId())
end

function StrongerTabMainView:bindEvents()
	StrongerTabMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StrongerTabMainView:unbindEvents()
	StrongerTabMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function StrongerTabMainView:onEnter()
	self._maxZdl = RoleModel.instance:getMaxPower()
	self._periodId = MasterFormController.instance:getPeriodId()

	if self._periodId == 0 then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	self._masterFormMgr = MasterFormController.instance:getMasterFormMgr(self._periodId)

	StrongerTabMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local baseData = TabFrameWorkConfig.instance:getFwBaseData(self._getFrameId())

	if self._txtTitle and not string.nilorempty(baseData.planName) then
		self._txtTitle.text = baseData.planName
	end

	self._tabFrameWorkShow:setUpdateCellExtCallBack(GameUtil.handler(self._onUpdatExtCell, self))
	self._tabFrameWorkShow:jumpTab(params[1], params[2])
end

function StrongerTabMainView:onExit()
	StrongerTabMainView.super.onExit(self)
end

function StrongerTabMainView:_getFrameId()
	return 3
end

function StrongerTabMainView:_onUpdatExtCell(view, cell, tabData, tag)
	local newTag = goutil.findChild(cell, "newTag")
	local txtTag = goutil.findChildTextComponent(cell, "newTag/txtTag")

	txtTag.text = "推荐"

	GameUtil.SetActive(newTag, self:_isRec(tabData.data.exTabParams))
end

function StrongerTabMainView:_onClickBtnTip()
	local baseData = TabFrameWorkConfig.instance:getFwBaseData(self._getFrameId())

	if baseData and not string.nilorempty(baseData.ruleKey) then
		TipsFacade.instance:openRulesView(baseData.ruleKey)
	end
end

function StrongerTabMainView:_isRec(zdlRange)
	if not string.nilorempty(zdlRange) then
		local list = string.split(zdlRange, "#")

		if list and #list == 2 then
			return self._maxZdl >= checknumber(list[1]) and self._maxZdl <= checknumber(list[2])
		end
	end

	return false
end

return StrongerTabMainView
