-- chunkname: @IQIGame\\UI\\ExploreHall\\MainMazeBtnController.lua

local m = {}
local ExploreHallPaidView = require("IQIGame.UI.ExploreHall.ExploreHallPaidView")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.ExploringView, ExploreHallUIApi:GetString("ExploringViewText"))
	UGUIUtil.SetTextInChildren(self.ProgressLabel, ExploreHallUIApi:GetString("ProgressLabel"))
	UGUIUtil.SetTextInChildren(self.ChapterEnLabel, ExploreHallUIApi:GetString("ChapterEnLabel"))

	self.exploreHallPaidView = ExploreHallPaidView.New(self.PaidNode)
end

function m:SetData(cfgChapterData, cfgMazeInstanceData, unfinishedMazeCid)
	self.ExploringView:SetActive(unfinishedMazeCid ~= nil)

	if self.Host.UIController:GetPreloadedAsset(UIGlobalApi.GetImagePath(cfgChapterData.Bg)) ~= nil then
		self.ChapterBg:GetComponent("Image").sprite = self.Host.UIController:GetPreloadedAsset(UIGlobalApi.GetImagePath(cfgChapterData.Bg))
	else
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgChapterData.Bg), self.ChapterBg:GetComponent("Image"))
	end

	UGUIUtil.SetText(self.ChapterNameText, ExploreHallUIApi:GetString("ChapterNameText", cfgChapterData.ChapterTypeName, cfgChapterData.Alias, cfgChapterData.Name))
	UGUIUtil.SetText(self.MazeNameText, ExploreHallUIApi:GetString("MazeNameText", cfgChapterData.Alias, cfgChapterData.Name, cfgChapterData.Order, cfgMazeInstanceData.Order, cfgMazeInstanceData.Name))
	self.exploreHallPaidView:UpdateView()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.exploreHallPaidView:Dispose()

	self.exploreHallPaidView = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
