-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/EliteStageView.lua

module("logic.extensions.plotcopy.view.EliteStageView", package.seeall)

local EliteStageView = class("EliteStageView", StageViewBase)

function EliteStageView:buildUI()
	EliteStageView.super.buildUI(self)

	self._imgArrow = self:getGo("main/top/perfectPass/imgArrow")
	self._txtPerfect = self:getGo("main/top/perfectPass/txtPerfect"):GetComponent(goutil.Type_UIText)
end

function EliteStageView:_refreshView()
	EliteStageView.super._refreshView(self)
	self._perfectPass:SetActive(true)
	self._imgArrow:SetActive(self._teamIsPerfectPass)

	local cfgStage = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

	self._txtPerfect.text = string.format("完美通关：阵亡精灵不超过%d个", (cfgStage or nil) and checknumber(string.split(cfgStage.perfectPassCondition, "$")[2]))
end

function EliteStageView:_onClickStart()
	local isEnough = PlotCopyModel.instance:isPowerEnough(self._chapterId, self._stageId)

	if not isEnough then
		ViewMgr.instance:open(ViewName.RecoveryTili)

		return
	end

	self:_openCopyMissionView()
end

function EliteStageView:_onClickAuto()
	return
end

function EliteStageView:_updateRewardList(cfgTeam)
	if not self._teamIsPerfectPass then
		local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

		if cfg and not string.nilorempty(cfg.perfectPassMp) then
			local perfectItems = string.split(cfg.perfectPassMp, "#")
			local length = #perfectItems

			for i = 1, length do
				local index = #self._curViewDatas + 1

				self._curViewDatas[index] = self._curViewDatas[index] or {}
				self._curViewDatas[index].rewardStr = perfectItems[i]
				self._curViewDatas[index].isPerfect = true
				self._curViewDatas[index].isFirst = false
				self._curViewDatas[index].isProb = false
			end
		end
	end

	EliteStageView.super._updateRewardList(self, cfgTeam)
end

return EliteStageView
