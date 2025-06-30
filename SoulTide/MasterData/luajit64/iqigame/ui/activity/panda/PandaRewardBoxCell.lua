-- chunkname: @IQIGame\\UI\\Activity\\Panda\\PandaRewardBoxCell.lua

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

function m:SetData(operateEventID, index, cfgGiftData)
	self.operateEventID = operateEventID
	self.index = index
	self.cfgGiftData = cfgGiftData

	UGUIUtil.SetText(self.TextScore, self.cfgGiftData.FavorNum)

	if self.cfgGiftData.RewardImage ~= "" and self.cfgGiftData.RewardImage ~= nil then
		local path = UIGlobalApi.GetImagePath(self.cfgGiftData.RewardImage)

		AssetUtil.LoadImage(self, path, self.ImgIcon1:GetComponent("Image"))
		AssetUtil.LoadImage(self, path, self.ImgIcon2:GetComponent("Image"))
	end

	self.state = ActivePandaModule.GetPandaRewardBoxState(operateEventID, cfgGiftData.Id)

	self.goState1:SetActive(self.state == 3)
	self.goState2:SetActive(self.state == 2)
	self.goState3:SetActive(self.state == 1)
	self.RedPoint:SetActive(self.state == 2)
end

function m:OnBtnSelf()
	local rewards = {}

	for i = 1, #self.cfgGiftData.Reward, 2 do
		local rewardId = self.cfgGiftData.Reward[i]
		local rewardNum = self.cfgGiftData.Reward[i + 1]

		table.insert(rewards, {
			id = rewardId,
			num = rewardNum
		})
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		Rewards = rewards,
		State = self.state,
		GetCallback = function()
			ActivePandaModule.GetGift(self.cfgGiftData.Id)
		end
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
