-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResRewardView.lua

module("logic.extensions.materialchallenge.view.ResRewardView", package.seeall)

local ResRewardView = class("ResRewardView", ViewComponent)

function ResRewardView:ctor()
	self._level0 = ResRewardItem.New()
	self._level1 = ResRewardItem.New()
	self._level2 = ResRewardItem.New()
end

function ResRewardView:buildUI()
	self._closeButton = self:getBtn("btnClose")

	self._level0:buildUI(self:getGo("level0"))
	self._level1:buildUI(self:getGo("level1"))
	self._level2:buildUI(self:getGo("level2"))

	self._txtCurCount = self:getGo("txtCurCount"):GetComponent(goutil.Type_UIText)
	self._btnOneKey = self:getBtn("btnOneKey")
end

function ResRewardView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._level0:bindEvents()
	self._level1:bindEvents()
	self._level2:bindEvents()
end

function ResRewardView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._level0:unbindEvents()
	self._level1:unbindEvents()
	self._level2:unbindEvents()
end

function ResRewardView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.MCLG_DailyTaskRewardRes, self._onDailyTaskRewardRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_OneKeyDailyTaskRewardRes, self._onOneKeyDailyTaskRewardRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_InfoRes, self._onInfoRes, self)

	local chapterId = self:getFirstParam()

	if not chapterId then
		return
	end

	self._chapterId = chapterId

	self._level0:onEnter(chapterId, 0)
	self._level1:onEnter(chapterId, 1)
	self._level2:onEnter(chapterId, 2)
	self:_setBottom()
	MaterialChallengeAgent.instance:sendMCLG_InfoReq(self._chapterId)
end

function ResRewardView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_DailyTaskRewardRes, self._onDailyTaskRewardRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_OneKeyDailyTaskRewardRes, self._onOneKeyDailyTaskRewardRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_InfoRes, self._onInfoRes, self)
	self._level0:onExit()
	self._level1:onExit()
	self._level2:onExit()
end

function ResRewardView:_updateState()
	self._level0:updateState()
	self._level1:updateState()
	self._level2:updateState()
	self:_setBottom()
end

function ResRewardView:_setBottom()
	local progress = MaterialChallengeModel.instance:curDailyTaskProgress(self._chapterId)
	local curValue = MaterialChallengeModel.instance:curDailyTaskValue(self._chapterId)
	local cfgs = MaterialChallengeConfig.instance:getProcessorSectionCfgs(self._chapterId, progress)

	self._txtCurCount.text = cfgs and string.format(cfgs[1].taskDes, curValue) or "nil"

	self:_setBtnState()
end

function ResRewardView:_onClickClose()
	self:close()
end

function ResRewardView:_onClickOneKey()
	if self._isCanClick then
		MaterialChallengeAgent.instance:sendMCLG_OneKeyDailyTaskRewardReq(self._chapterId)
	else
		FloatWordMgr.instance:show("已经没有奖励可以领取了哦")
	end
end

function ResRewardView:_onDailyTaskRewardRes(msg)
	self:_setBtnState()
end

function ResRewardView:_onOneKeyDailyTaskRewardRes(msg)
	self:_setBtnState()
end

function ResRewardView:_onInfoRes()
	self:_updateState()
end

function ResRewardView:_setBtnState()
	self._isCanClick = MaterialChallengeModel.instance:isOneKeyCanClick(self._chapterId)
	self._btnOneKey.btn.interactable = self._isCanClick
end

return ResRewardView
