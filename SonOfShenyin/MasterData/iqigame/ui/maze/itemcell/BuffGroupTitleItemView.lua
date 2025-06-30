-- chunkname: @IQIGame\\UI\\Maze\\ItemCell\\BuffGroupTitleItemView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickTipsBtn()
		self:__OnClickTipsBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateOnClickTipsBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTipsBtn)
end

function m:SetData(buffPoolId)
	self.buffPoolId = buffPoolId

	local isCanCombination = MazeModule.GetBuffCanCombination(buffPoolId)

	if isCanCombination then
		local buffGroupActivedData = MazeModule.GetMazeBuffGroupActivedNumByBuffPoolId(buffPoolId)

		UGUIUtil.SetText(self.BuffName, buffGroupActivedData.buffGroupCfg.Name)
		UGUIUtil.SetText(self.buffGroupActivedNumText, buffGroupActivedData.activedNum)
		UGUIUtil.SetText(self.buffGroupAllNumText, "/" .. buffGroupActivedData.allNum)
		AssetUtil.LoadImage(self, buffGroupActivedData.buffGroupCfg.GroupIcon, self.BuffIcon:GetComponent("Image"))
		self:Show()
	else
		self:Hide()
	end
end

function m:__OnClickTipsBtn()
	EventDispatcher.Dispatch(EventID.OpenBuffGroupTips, self.buffPoolId)
end

function m:SetBtnVisable(state)
	self.View:GetComponent("Button").interactable = state
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
