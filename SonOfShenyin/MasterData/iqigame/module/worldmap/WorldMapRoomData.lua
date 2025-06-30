-- chunkname: @IQIGame\\Module\\WorldMap\\WorldMapRoomData.lua

local WorldMapRoomData = {}
local ComponentDataClass = require("IQIGame/Module/WorldMap/WorldMapComponentData")

function WorldMapRoomData.New(cfgRoom, roomPod, componentsPod, actionsPod)
	local o = Clone(WorldMapRoomData)

	o:Initialize(cfgRoom, roomPod, componentsPod, actionsPod)

	return o
end

function WorldMapRoomData:Initialize(cfgRoom, roomPod, componentsPod, actionsPod)
	self.cfgRoom = cfgRoom
	self.cid = cfgRoom.Id
	self.status = 0
	self.skinData = {}
	self.cfgRoomScene = CfgUtil.GetCfgWorldRoomSceneDataWithID(self.cfgRoom.SceneId)
	self.currentPlot = 0
	self.openCount = 0

	self:ReloadPodData(roomPod)

	self.componentList = {}

	for i, v in pairsCfg(CfgWorldRoomCompTable) do
		if v.RoomId == self.cid then
			self.componentList[i] = ComponentDataClass.New(v, componentsPod[i] and componentsPod[i] or nil, actionsPod)
			WorldMapModule.componentsDataList[i] = self.componentList[i]
		end
	end
end

function WorldMapRoomData:AddOnComponentList(roomId, componentData)
	self.componentList[roomId] = componentData
end

function WorldMapRoomData:RemoveOnComponentList(roomId)
	self.componentList[roomId] = nil
end

function WorldMapRoomData:GetCfgRoomScene()
	return self.cfgRoomScene
end

function WorldMapRoomData:GetCfg()
	return self.cfgRoom
end

function WorldMapRoomData:GetComponentsList()
	return self.componentList
end

function WorldMapRoomData:GetIsUnlock()
	if self.status and self.status ~= 0 then
		return self.status == 1
	end

	return ConditionModule.CheckConditionIsAllPass(self:GetCfg().UnlockCondition)
end

function WorldMapRoomData:GetActionCount()
	local count = 0

	for _, v in pairs(self.componentList) do
		count = count + v:GetActionCount()
	end

	return count
end

function WorldMapRoomData:GetRoomTagArray()
	local array = {}

	for _, v in pairs(self.componentList) do
		for _, actionData in pairs(v:GetActionList()) do
			if actionData:CheckIsActiveTag() then
				table.insert(array, actionData)
			end
		end
	end

	return array
end

function WorldMapRoomData:GetStoryTag()
	if self.currentPlot == 0 then
		return 0
	end

	local cfgWorldMapItem = CfgUtil.GetCfgWorldMapItemDataWithID(self.currentPlot)

	if not cfgWorldMapItem then
		return 0
	end

	return cfgWorldMapItem.IconType
end

function WorldMapRoomData:ReloadPodData(roomPod)
	if not roomPod then
		return
	end

	self.cid = roomPod.cid

	if roomPod.status and roomPod.status ~= 0 then
		self.status = roomPod.status
	end

	self.currentPlot = roomPod.currentPlot
	self.skinData = roomPod.skin
	self.openCount = roomPod.openCount

	log(string.format("【RPG】（更新房间数据）房间id = %s,剧情 id = %s,状态 = %s,开启次数 = %s", self.cid, self.currentPlot, self.status, self.openCount))
end

return WorldMapRoomData
