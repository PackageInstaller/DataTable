-- chunkname: @IQIGame\\UI\\Maze\\MazeUIStageElement.lua

local StageItem = {
	stageCid = 0
}

function StageItem.New(view, handler)
	local obj = Clone(StageItem)

	obj:__Init(view, handler)

	return obj
end

function StageItem:__Init(view, handler)
	self.gameObject = view
	self.clickHandler = handler
	self.stageCid = tonumber(self.gameObject.name)

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnStageItemClick()
		self:OnStageItemClick()
	end

	self.grayCom = self.gameObject:GetComponent("GrayComponent")

	self.buttonGo:GetComponent("Button").onClick:AddListener(self.__delegateOnStageItemClick)
end

function StageItem:RefreshStageInfo()
	local labyrinthStagePOD = MazeModule.GetLabyrinthStagePOD(self.stageCid)

	UGUIUtil.SetText(self.stageName1, CfgLabyrinthBarrierTable[self.stageCid].Id)
	UGUIUtil.SetText(self.stageName2, CfgLabyrinthBarrierTable[self.stageCid].Id)

	self.canExplore = not labyrinthStagePOD.settlementFlg

	self.grayCom:SetGray(not self.canExplore)
	LuaUtility.SetGameObjectShow(self.explorableParent, self.canExplore)
	LuaUtility.SetGameObjectShow(self.notExplorableParent, not self.canExplore)
end

function StageItem:OnStageItemClick()
	if self.clickHandler == nil then
		return
	end

	if not self.canExplore then
		NoticeModule.ShowNotice(80004)
	end

	self.clickHandler(self.stageCid)
end

function StageItem:SetData()
	self:RefreshStageInfo()
end

function StageItem:Show()
	self.gameObject:SetActive(true)
end

function StageItem:Hide()
	self.gameObject:SetActive(false)
end

function StageItem:Dispose()
	self.buttonGo:GetComponent("Button").onClick:RemoveListener(self.__delegateOnStageItemClick)

	self.grayCom = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	stageItems = {}
}

function Element.New(view, stageSelectHandler)
	local obj = Clone(Element)

	obj:__Init(view, stageSelectHandler)

	return obj
end

function Element:__Init(view, stageSelectHandler)
	self.gameObject = view
	self.stageSelectHandler = stageSelectHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.stageRoot.transform, function(_trans, _index)
		local stageItem = StageItem.New(_trans.gameObject, function(_stageCid)
			self:__OnStageItemSelect(_stageCid)
		end)

		self.stageItems[stageItem.stageCid] = stageItem
	end)
end

function Element:__OnStageItemSelect(stageCid)
	if self.stageSelectHandler == nil then
		return
	end

	self.stageSelectHandler(stageCid)
end

function Element:RefreshStage()
	ForPairs(MazeModule.__labyrinthDataPOD.labyrinthStagePODs, function(_stageCid, v)
		local stageItem = self.stageItems[_stageCid]

		stageItem:SetData()
	end)
end

function Element:Show()
	ForPairs(self.stageItems, function(_, _stageItem)
		_stageItem:Hide()
	end)
	ForPairs(MazeModule.__labyrinthDataPOD.labyrinthStagePODs, function(_stageCid, v)
		local stageItem = self.stageItems[_stageCid]

		stageItem:Show()
		stageItem:SetData()
	end)
	self.gameObject.gameObject:SetActive(true)
end

function Element:Hide()
	self.gameObject.gameObject:SetActive(false)
end

function Element:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	UnityEngine.Object.Destroy(self.gameObject)

	self.gameObject = nil
end

return Element
