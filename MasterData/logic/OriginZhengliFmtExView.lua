-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginZhengliFmtExView.lua

module("logic.extensions.originzhengli.view.OriginZhengliFmtExView", package.seeall)

local OriginZhengliFmtExView = class("OriginZhengliFmtExView", ViewComponent)

function OriginZhengliFmtExView:ctor()
	OriginZhengliFmtExView.super.ctor(self)
end

function OriginZhengliFmtExView:unbindEvents()
	OriginZhengliFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnActivate0)
	GameUtil.rmClickHandler(self._btnActivate1)
	GameUtil.rmClickHandler(self._btnActivate2)
end

function OriginZhengliFmtExView:bindEvents()
	OriginZhengliFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnActivate0, GameUtil.handler(self._onClickBtnActivate, self))
	GameUtil.addClickHandler(self._btnActivate1, GameUtil.handler(self._onClickBtnActivate, self))
	GameUtil.addClickHandler(self._btnActivate2, GameUtil.handler(self._onClickBtnActivate, self))
end

function OriginZhengliFmtExView:buildUI()
	OriginZhengliFmtExView.super.buildUI(self)

	self._btnActivate0 = self:getGo("btnActivate0")
	self._btnActivate1 = self:getGo("btnActivate1")
	self._btnActivate2 = self:getGo("btnActivate2")
end

function OriginZhengliFmtExView:onExit()
	OriginZhengliFmtExView.super.onExit(self)
end

function OriginZhengliFmtExView:onEnter()
	OriginZhengliFmtExView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ChangeOriginZhengliBuffId, self._onChangeSelectBuffId, self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
	self._curSelectBuffId = self._fmtMo:getCurSelectBuffId()

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function OriginZhengliFmtExView:_updateUIByCfg()
	self._actCfg = OriginZhengliConfig.instance:getActivityCfg(self._activityId)
	self._isStartPos = self._actCfg and self._stageId == self._actCfg.startingStageId
end

function OriginZhengliFmtExView:_updateUIByInfo()
	self._canSelect = false

	local stageInfo = OriginZhengliModel.instance:getStageInfoById(self._activityId, self._stageId)
	local curShowType = 0
	local curBuffId = 0

	if stageInfo then
		if not stageInfo.activateBuff then
			do
				local activateBuff = 0

				if activateBuff == 0 then
					curBuffId = self._curSelectBuffId or 0
					self._canSelect = true
				else
					self._canSelect = false
					curBuffId = activateBuff
				end
			end

			if curBuffId == 0 then
				self._canSelect = true
			else
				local buffCfg = OriginZhengliConfig.instance:getBuffCfgById(self._activityId, curBuffId)

				if buffCfg then
					curShowType = checknumber(buffCfg.buffType) or 0
				end
			end
		end
	end

	goutil.setActive(self._btnActivate0, curShowType == 0)
	goutil.setActive(self._btnActivate1, curShowType == 1)
	goutil.setActive(self._btnActivate2, curShowType == 2)

	if self._isStartPos then
		goutil.setActive(self._btnActivate0, false)
		goutil.setActive(self._btnActivate1, false)
		goutil.setActive(self._btnActivate2, false)
	end
end

function OriginZhengliFmtExView:_onClickBtnActivate()
	if not self._canSelect then
		TipsFacade.instance:openCommonTips(lang("无法更改本关印记"))

		return
	end

	if self._isStartPos then
		return
	end

	UIStateManager.instance:push(ViewName.OriginZhengliBuffView, self._activityId, self._stageId, false, self._curSelectBuffId)
end

function OriginZhengliFmtExView:_onChangeSelectBuffId(buffId)
	self._curSelectBuffId = buffId

	self._fmtMo:updateCurSelectBuffId(buffId)
	self:_updateUIByInfo()
end

return OriginZhengliFmtExView
