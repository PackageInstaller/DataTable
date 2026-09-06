-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenFmtExView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenFmtExView", package.seeall)

local DragonAwakenFmtExView = class("DragonAwakenFmtExView", ViewComponent)

function DragonAwakenFmtExView:ctor()
	DragonAwakenFmtExView.super.ctor(self)
end

function DragonAwakenFmtExView:unbindEvents()
	DragonAwakenFmtExView.super.unbindEvents(self)
end

function DragonAwakenFmtExView:bindEvents()
	DragonAwakenFmtExView.super.bindEvents(self)
end

function DragonAwakenFmtExView:buildUI()
	DragonAwakenFmtExView.super.buildUI(self)

	self._txtTips = self:getTxt("txtTips")
	self._cost = self:getGo("cost")
	self._icon = self:getGo("cost/icon")
	self._txtNum = self:getTxt("cost/txtNum")
end

function DragonAwakenFmtExView:onExit()
	DragonAwakenFmtExView.super.onExit(self)
	MaterialMgr.resetAll(self._icon)
end

function DragonAwakenFmtExView:onEnter()
	DragonAwakenFmtExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self.activityId = self.customFmtMo.activityId
	self.curPhaseId = self.customFmtMo.curPhaseId
	self.curStageCfg = self.customFmtMo.curStageCfg

	self.addGEvent(self, GlobalNotify.DragonAwakenUpdateFormInfo, self._updateInfo, self)
	self:_updateInfo()
	self:_updateCost()
end

function DragonAwakenFmtExView:_updateInfo()
	local curPhasePetCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self.activityId, self.curPhaseId)

	self._txtTips.text = curPhasePetCfg and string.format("%s必须上阵", curPhasePetCfg.creepsName) or ""
end

function DragonAwakenFmtExView:_updateCost()
	if self.curStageCfg then
		goutil.setActive(self._cost, false)

		if not GameUtil.isEmptyString(self.curStageCfg.cost) then
			goutil.setActive(self._cost, true)

			local type, id, num = MaterialMgr.getMatParams(self.curStageCfg.cost)

			MaterialMgr.setIcon(self._icon, type, id)

			self._txtNum.text = num
		end
	else
		goutil.setActive(self._cost, false)
	end
end

return DragonAwakenFmtExView
