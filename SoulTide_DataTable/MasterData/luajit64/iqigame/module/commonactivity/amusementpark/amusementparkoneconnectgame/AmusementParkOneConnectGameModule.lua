-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkOneConnectGame\\AmusementParkOneConnectGameModule.lua

local m = {
	maxLevel = 0,
	oneConnectLevels = {},
	callBack = Queue.New()
}
local AmusementParkOneConnectLevelData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkOneConnectGame.AmusementParkOneConnectLevelData")
local AmusementParkOneConnectGameData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkOneConnectGame.AmusementParkOneConnectGameData")

function m.Reload()
	m.callBack = Queue.New()

	m.AddListeners()
end

function m.InitData()
	m.oneConnectLevels = {}

	for i, v in pairsCfg(CfgAmusementParkOneTouchDrawingControlTable) do
		if v.Group == AmusementParkModule.GlobalCid then
			local levelData = AmusementParkOneConnectLevelData.New(v.Id)

			table.insert(m.oneConnectLevels, levelData)
		end
	end

	table.sort(m.oneConnectLevels, function(a, b)
		return a:GetCfgData().Level < b:GetCfgData().Level
	end)
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetOpenLevelCount()
	local num = 0

	for i, v in pairs(m.oneConnectLevels) do
		if v:IsUnlock() then
			num = num + 1
		end
	end

	return num
end

function m.GetLevelDataByCid(cid)
	for i, v in pairs(m.oneConnectLevels) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetLevelDataByLevel(level)
	for i, v in pairs(m.oneConnectLevels) do
		if v:GetCfgData().Level == level then
			return v
		end
	end

	return nil
end

function m.CreateNewGame(cid)
	local levelData

	if cid ~= nil then
		levelData = m.GetLevelDataByCid(cid)
	else
		local nextLv = m.maxLevel + 1
		local nextLVData = m.GetLevelDataByLevel(nextLv)

		if nextLVData and nextLVData:IsUnlock() then
			levelData = nextLVData
		else
			levelData = m.GetLevelDataByLevel(m.maxLevel)
		end
	end

	m.oneConnectGameData = AmusementParkOneConnectGameData.New(levelData)
end

function m.StartOneConnectGame()
	m.OneStrokeInfo(function()
		m.CreateNewGame()
		UIModule.Open(Constant.UIControllerName.AmusementParkGameConnectUI, Constant.UILayer.UI)
	end)
end

function m.Shutdown()
	m.RemoveListeners()
	m.callBack:Clear()
end

function m.OneStrokeInfo(callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_amusementPark.oneStrokeInfo()
end

function m.OneStroke(id)
	if not AmusementParkModule.IsShow() then
		return
	end

	net_amusementPark.oneStroke(id)
end

function m.OneStrokeInfoResult(score)
	m.maxLevel = score or 0

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.OneStrokeResult(score)
	if score > m.maxLevel then
		m.maxLevel = score
	end

	AmusementParkModule.GetLittleGameInfo()
end

AmusementParkOneConnectGameModule = m
