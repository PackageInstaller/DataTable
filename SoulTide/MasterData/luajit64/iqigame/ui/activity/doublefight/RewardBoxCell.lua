-- chunkname: @IQIGame\\UI\\Activity\\DoubleFight\\RewardBoxCell.lua

local m = {}

function m.New(view, rootUI)
	local obj = Clone(m)

	obj:Init(view, rootUI)

	return obj
end

function m:Init(view, rootUI)
	self.View = view
	self.rootUI = rootUI

	LuaCodeInterface.BindOutlet(self.View, self)

	local sortComponents = self.View:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = self.rootUI.UIController:GetComponent("Canvas")
	end

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
end

function m:SetData(operateEventID, fightListCid, index)
	self.operateEventID = operateEventID
	self.fightListCid = fightListCid
	self.index = index
	self.cfgDoubleFightList = CfgDoubleFightListTable[self.fightListCid]
	self.score = self.cfgDoubleFightList.ScoreList[self.index]

	UGUIUtil.SetText(self.TextScore, self.score)

	self.state = ActiveDoubleFightModule.GetRewardBoxState(self.operateEventID, self.fightListCid, self.index)

	self.goState1:SetActive(self.state == 3)
	self.goState2:SetActive(self.state == 2)
	self.goState3:SetActive(self.state == 1)
end

function m:OnBtnSelf()
	local rewards = {}
	local scoreReward = self.cfgDoubleFightList.ScoreReward[self.index]

	for i = 1, #scoreReward, 2 do
		local rewardId = scoreReward[i]
		local rewardNum = scoreReward[i + 1]

		table.insert(rewards, {
			id = rewardId,
			num = rewardNum
		})
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		Rewards = rewards,
		State = self.state,
		GetCallback = function()
			ActiveDoubleFightModule.GetRewards(self.operateEventID, self.fightListCid, {
				self.index
			})
		end
	})
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
