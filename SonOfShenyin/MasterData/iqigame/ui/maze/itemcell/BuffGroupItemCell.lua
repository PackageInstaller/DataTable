-- chunkname: @IQIGame\\UI\\Maze\\ItemCell\\BuffGroupItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.uiSizeAdapterCom = self.View:GetComponent(typeof(UISizeAdapter))

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(buffGroupData)
	LuaUtility.SetGameObjectShow(self.activitedBg, buffGroupData.mazeBuffGroupItemData.isActived)
	LuaUtility.SetGameObjectShow(self.noActiviteBg, not buffGroupData.mazeBuffGroupItemData.isActived)
	UGUIUtil.SetText(self.activedText, buffGroupData.mazeBuffGroupItemData.needNum)
	UGUIUtil.SetText(self.noActivedText, buffGroupData.mazeBuffGroupItemData.needNum)

	local desc = CfgLabyrinthBuffGroupTable[buffGroupData.buffGroupId].SpecialBuffDes[buffGroupData.mazeBuffGroupItemData.index]

	if buffGroupData.mazeBuffGroupItemData.isActived then
		UGUIUtil.SetText(self.buffDesc, string.format(ColorCfg.Maze.BuffGroupPurple, desc))
	else
		UGUIUtil.SetText(self.buffDesc, string.format(ColorCfg.Maze.BuffGroupGray, desc))
	end

	self.uiSizeAdapterCom:UpdateSize()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	self.uiSizeAdapterCom = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
