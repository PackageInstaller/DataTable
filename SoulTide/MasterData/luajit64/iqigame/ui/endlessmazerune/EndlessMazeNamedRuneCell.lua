-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeNamedRuneCell.lua

local m = {}
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function m.New(view, interactive)
	local obj = Clone(m)

	obj:Init(view, interactive)

	return obj
end

function m:Init(view, interactive)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI, interactive)
end

function m:SetData(mazeRunePOD)
	self.MazeRunePOD = mazeRunePOD

	self.View:SetActive(mazeRunePOD ~= nil)
	self.RuneCell:SetData(mazeRunePOD)

	if mazeRunePOD == nil then
		return
	end

	local cfgRuneData = CfgRuneTable[mazeRunePOD.CID]

	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)

	if self.LevelText ~= nil then
		self.LevelText:SetActive(cfgRuneData.Feature == Constant.Maze.RuneFeatureStrengthen)
		UGUIUtil.SetText(self.LevelText, EndlessMazeRuneMainUIApi:GetString("RuneCellLevelText", mazeRunePOD.Level))
	end
end

function m:SetDataByCID(runeCid)
	self.View:SetActive(runeCid ~= nil)

	if runeCid == nil then
		return
	end

	local cfgRuneData = CfgRuneTable[runeCid]

	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
end

function m:SetDataByCfgData(cfgRuneData)
	self.View:SetActive(cfgRuneData ~= nil)

	if cfgRuneData == nil then
		return
	end

	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
end

function m:Dispose()
	self.RuneCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.MazeRunePOD = nil
end

return m
