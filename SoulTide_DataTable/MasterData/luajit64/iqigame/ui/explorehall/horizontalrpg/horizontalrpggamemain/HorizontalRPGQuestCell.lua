-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGGameMain\\HorizontalRPGQuestCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(cid)
	local cfgHorizontalGuideData = CfgHorizontalRPGGuideTable[cid]

	if cfgHorizontalGuideData then
		UGUIUtil.SetText(self.TextTitle, cfgHorizontalGuideData.GuideTitle)
		UGUIUtil.SetText(self.TextTaskDes, cfgHorizontalGuideData.Guide)
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
