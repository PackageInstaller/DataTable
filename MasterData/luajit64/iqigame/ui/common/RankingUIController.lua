-- chunkname: @IQIGame\\UI\\Common\\RankingUIController.lua

local m = {}

function m.New(view, renderCellFunc)
	local obj = Clone(m)

	obj:Init(view, renderCellFunc)

	return obj
end

function m:Init(view, renderCellFunc)
	self.View = view
	self.RenderCellFunc = renderCellFunc

	LuaCodeInterface.BindOutlet(self.View, self)

	local rankingItemScrollAreaList = self.RankingItemScrollArea:GetComponent("ScrollAreaList")

	function rankingItemScrollAreaList.onRenderCell(cell)
		self:OnRenderRankingItem(cell)
	end

	self.MyRankingItemGo = UnityEngine.Object.Instantiate(self.RankingItemPrefab)
	self.RankingGoalieGo = UnityEngine.Object.Instantiate(self.RankingItemPrefab)

	self.RankingGoalieGo:SetActive(false)
	self.RankingGoalieGo.transform:SetParent(self.MyRankNode.transform, false)
	self.MyRankingItemGo.transform:SetParent(self.MyRankNode.transform, false)

	function self.DelegateOnPlayerHeadFrameLoaded()
		self:OnPlayerHeadFrameLoaded()
	end

	self:AddListener()
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function m:OnRenderRankingItem(cell)
	self.RenderCellFunc(cell.gameObject, cell.index + 1, nil, nil, self.rankings, self.customData)
end

function m.GetPreloadAssetPaths()
	return nil
end

function m:SetRankingLabels(labels)
	for i = 1, #labels do
		local textTrans = self.ItemLabelGroup.transform:Find("Text_0" .. i)

		if LuaCodeInterface.GameObjIsDestroy(textTrans) then
			logError("设置的排行榜Label数量和UI上的文本框数量不匹配")

			break
		end

		UGUIUtil.SetText(textTrans.gameObject, labels[i])
	end
end

function m:SetNoneRankText(str)
	UGUIUtil.SetText(self.NoneRankText, str)
end

function m:SetData(rankings, myRanking, myScore, customData, rankType)
	self.rankings = rankings
	self.customData = customData

	self.RenderCellFunc(self.MyRankingItemGo, 0, myRanking, myScore, rankings, customData, rankType)

	local rankingItemScrollAreaList = self.RankingItemScrollArea:GetComponent("ScrollAreaList")

	rankingItemScrollAreaList:Refresh(#rankings)
	self.NoneRank:SetActive(not (#rankings > 0))
end

function m:SetRankingGoalieData(rankingPOD, ranking, rankType)
	self.RenderCellFunc(self.RankingGoalieGo, -1, rankingPOD, ranking, nil, nil, rankType)
end

function m:OnPlayerHeadFrameLoaded()
	if self.RankingItemScrollArea and not LuaCodeInterface.GameObjIsDestroy(self.RankingItemScrollArea) then
		local mask = self.RankingItemScrollArea:GetComponent(typeof(UnityEngine.UI.RectMask3D))

		mask:SetDirtyTarget()
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.RenderCellFunc = nil
	self.MyRankingItemGo = nil
	self.RankingGoalieGo = nil
end

return m
