-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/goddesscompetition/GoddessCompetitionRankFatherListView.lua

module("logic.extensions.commontabrank.view.goddesscompetition.GoddessCompetitionRankFatherListView", package.seeall)

local GoddessCompetitionRankFatherListView = class("GoddessCompetitionRankFatherListView", CommonTabRankFatherListView)

function GoddessCompetitionRankFatherListView:buildUI()
	GoddessCompetitionRankFatherListView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
end

function GoddessCompetitionRankFatherListView:bindEvents()
	GoddessCompetitionRankFatherListView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function GoddessCompetitionRankFatherListView:unbindEvents()
	GoddessCompetitionRankFatherListView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function GoddessCompetitionRankFatherListView:onEnter()
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetBaseInfoRes, self._updateUIByInfo, self)
	self:_updateUIByInfo()
	GoddessCompetitionRankFatherListView.super.onEnter(self)
end

function GoddessCompetitionRankFatherListView:_updateUIByInfo()
	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()

	if baseInfo then
		self._curStepId = baseInfo.curStepId or 0
	end
end

function GoddessCompetitionRankFatherListView:_isUnlock(tabData)
	local leaf = checknumber(tabData.leaf)

	if leaf > 0 then
		local data = tabData.data
		local tabKey = data and data.tabKey
		local array = string.split(tabKey, "_")
		local key = array[1]
		local stepId = checknumber(array[2])

		if key == "StepRank" then
			return stepId <= checknumber(self._curStepId)
		end
	end

	return true
end

function GoddessCompetitionRankFatherListView:_onGetDefaultLeaf(tabData)
	local targetLeafIdx = 0
	local leafList = tabData.leafList

	if leafList and #leafList > 0 then
		for i, v in ipairs(leafList) do
			if self:_isUnlock(v) then
				if v.data then
					local tabKey = v.data.tabKey

					if tabKey then
						local array = string.split(tabKey, "_")

						if array[1] == "StepRank" then
							local stepId = checknumber(array[2])

							if stepId == self._curStepId then
								targetLeafIdx = v.leaf

								break
							end
						end
					end
				end
			end
		end
	end

	return targetLeafIdx
end

function GoddessCompetitionRankFatherListView:_onClickTip()
	local key = "goddesscompetitionS4_rank_rule"

	TipsFacade.instance:openRulesView(key)
end

return GoddessCompetitionRankFatherListView
