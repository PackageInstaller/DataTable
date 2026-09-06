-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/view/WandererpassmainView.lua

module("logic.extensions.wandererpass.view.WandererpassmainView", package.seeall)

local WandererpassmainView = class("WandererpassmainView", ViewComponent)

function WandererpassmainView:unbindEvents()
	WandererpassmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function WandererpassmainView:bindEvents()
	WandererpassmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function WandererpassmainView:buildUI()
	WandererpassmainView.super.buildUI(self)

	self._txtTime = self:getTxt("openTime/txtTime")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._contentCol = self:getGo("contentCol")
	self._con = self:getGo("con")
	self._tablist = self:getGo("tablist")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self._getFrameId())
end

function WandererpassmainView:onExit()
	WandererpassmainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function WandererpassmainView:onEnter()
	WandererpassmainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 582001
	end

	local params = self:getOpenParam() or {}
	local rootTab = checknumber(params[2])

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local cfg = WandererpassConfig.instance:getActivityCfgById(self._activityId) or {}
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(cfg.skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, cfg.skinId, self._con, scale, nil, true, modelCfg[1], y)

				self._tabFrameWorkShow:initTabViewWithFrameId(self._activityId)

				if rootTab > 0 then
					self._tabFrameWorkShow:jumpTab(rootTab)
				else
					self._tabFrameWorkShow:jumpTab()
				end
			end
		end
	end
end

function WandererpassmainView:_onClickTips()
	TipsFacade.instance:openRulesView("wandererpassmainview_rule")
end

function WandererpassmainView:_getFrameId()
	return 0
end

return WandererpassmainView
