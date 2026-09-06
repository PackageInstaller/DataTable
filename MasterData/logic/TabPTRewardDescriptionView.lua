-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/rewarddesc/TabPTRewardDescriptionView.lua

module("logic.extensions.peaktournament.view.common.rewarddesc.TabPTRewardDescriptionView", package.seeall)

local TabPTRewardDescriptionView = class("TabPTRewardDescriptionView", TabFrameWorkMainView)

function TabPTRewardDescriptionView:buildUI()
	TabPTRewardDescriptionView.super.buildUI(self)
end

function TabPTRewardDescriptionView:bindEvents()
	TabPTRewardDescriptionView.super.bindEvents(self)
end

function TabPTRewardDescriptionView:unbindEvents()
	TabPTRewardDescriptionView.super.unbindEvents(self)
end

function TabPTRewardDescriptionView:onEnter()
	self._ptActivityId = PeakTournamentController.instance:getCurActivityId()

	if self._ptActivityId == 0 then
		FloatWordMgr.instance:show("巅峰赛未开启")
		self:close()

		return
	end

	local key = PeakTournamentController.instance:getQuaRewardFirstRedKey(self._ptActivityId)
	local redId = PeakTournamentConfig.instance:getPtCommonValue("PT_RED_QUA_REWARD_ONCE")

	PeakTournamentController.instance:saveOnceRedAsPT(key, redId, true)
	TabPTRewardDescriptionView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentQualifierTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentGainQualifierTaskPrizeRes, self._sendTaskInfoReq, self)
	self:_sendTaskInfoReq()
end

function TabPTRewardDescriptionView:onExit()
	TabPTRewardDescriptionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentQualifierTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentGainQualifierTaskPrizeRes, self._sendTaskInfoReq, self)
end

function TabPTRewardDescriptionView:_getFrameId()
	return PeakTournamentConfig.instance:getRewardDescriptionFrameId()
end

function TabPTRewardDescriptionView:_isNeedRedByExCondAsHeadTab(headTabIndex)
	local info = self:_getHeadTabViewInfo(headTabIndex)
	local isNeedRed = false
	local params = info.data.params

	if not string.nilorempty(params) and string.split(params, "#")[1] ~= "reward" then
		local arrStr = string.split(params, "#")[1]
		local arr = string.split(arrStr, ":")
		local pageIdxList = {}

		for _, v in ipairs(arr) do
			table.insert(pageIdxList, checknumber(v))
		end

		for _, pageIdx in ipairs(pageIdxList) do
			local cfg = PeakTournamentConfig.instance:getPtQuaTaskCfgWithPageIdxById(self._ptActivityId, pageIdx)

			for _, data in ipairs(cfg or {}) do
				if PeakTournamentController.instance:isCanGetPrizeTaskAsQua(self._ptActivityId, data.quaTaskId) then
					isNeedRed = true

					break
				end
			end

			if isNeedRed then
				break
			end
		end
	end

	return isNeedRed
end

function TabPTRewardDescriptionView:_sendTaskInfoReq()
	PeakTournamentController.instance:sendPM_PeakTournamentQualifierTaskInfoReq(self._ptActivityId)
end

return TabPTRewardDescriptionView
