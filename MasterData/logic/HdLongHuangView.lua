-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdLongHuangView.lua

module("logic.extensions.activitypopup.view.HdLongHuangView", package.seeall)

local HdLongHuangView = class("HdLongHuangView", ActivityPopupBase)

function HdLongHuangView:buildUI()
	HdLongHuangView.super.buildUI(self)

	self._btnGo = self:getBtn("btnGo")
	self._itemGo1 = self:getGo("item1")
	self._itemGo2 = self:getGo("item2")
end

function HdLongHuangView:bindEvents()
	HdLongHuangView.super.bindEvents(self)
	self._btnGo:AddClickListener(self._onClickGo, self)
end

function HdLongHuangView:unbindEvents()
	HdLongHuangView.super.unbindEvents(self)
	self._btnGo:RemoveClickListener()
end

function HdLongHuangView:onEnter()
	HdLongHuangView.super.onEnter(self)

	local cfg = self:getActivityPopupCfg()

	if cfg and not string.nilorempty(cfg.reward) then
		local rewardList = string.split(cfg.reward, "#")

		if rewardList and #rewardList >= 2 then
			MaterialMgr.setCellByCfg(rewardList[1], self._itemGo1)
			MaterialMgr.setCellByCfg(rewardList[2], self._itemGo2)
		end
	end
end

function HdLongHuangView:onExit()
	HdLongHuangView.super.onExit(self)
	MaterialMgr.resetAll(self._itemGo1)
	MaterialMgr.resetAll(self._itemGo2)
end

function HdLongHuangView:_onClickGo()
	local cfg = self:getActivityPopupCfg()

	if cfg then
		if not ActivityPopupModel.instance:isHaveNextActivityViewId() then
			UIStateManager.instance:clear()
		end

		GotoMgr.gotoByString(cfg.jumpTo)
	end
end

return HdLongHuangView
