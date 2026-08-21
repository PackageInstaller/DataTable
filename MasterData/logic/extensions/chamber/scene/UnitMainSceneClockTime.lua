-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/scene/UnitMainSceneClockTime.lua

module("logic.extensions.chamber.scene.UnitMainSceneClockTime", package.seeall)

local M = class("UnitMainSceneClockTime")
local kNumMap = {
	[0] = {
		1,
		2,
		3,
		5,
		6,
		7
	},
	{
		3,
		6
	},
	{
		1,
		3,
		4,
		5,
		7
	},
	{
		1,
		3,
		4,
		6,
		7
	},
	{
		2,
		3,
		4,
		6
	},
	{
		1,
		2,
		4,
		6,
		7
	},
	{
		1,
		2,
		4,
		5,
		6,
		7
	},
	{
		1,
		3,
		6
	},
	{
		1,
		2,
		3,
		4,
		5,
		6,
		7
	},
	{
		1,
		2,
		3,
		4,
		6,
		7
	}
}
local kMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local kEmissionColorID = UnityEngine.Shader.PropertyToID("_EmissionColor")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_init()
end

function M:OnDestroy()
	GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._onSecondUpdate, self)
	self._materialSetter:Clear()

	self._materialSetter = nil
end

function M:_init()
	self._materialSetter = BatchMaterialSetter.Get(self._mainGO)
	self._hourList = {
		self:_getNumGoList(goutil.findChild(self._mainGO, "s001_obj_shijian_a")),
		self:_getNumGoList(goutil.findChild(self._mainGO, "s001_obj_shijian_b"))
	}
	self._minList = {
		self:_getNumGoList(goutil.findChild(self._mainGO, "s001_obj_shijian_c")),
		self:_getNumGoList(goutil.findChild(self._mainGO, "s001_obj_shijian_d"))
	}
	self._secondList = {
		self:_getNumGoList(goutil.findChild(self._mainGO, "s001_obj_shijian_e")),
		self:_getNumGoList(goutil.findChild(self._mainGO, "s001_obj_shijian_f"))
	}
	self._posX, self._posY, self._posZ = TransformUtils.GetLocalPosition(self._mainGO.transform, 0, 0, 0)
	self._eulerX, self._eulerY, self._eulerZ = TransformUtils.GetLocalEulerAngles(self._mainGO.transform, 0, 0, 0)
	self._scaleX, self._scaleY, self._scaleZ = TransformUtils.GetLocalScale(self._mainGO.transform, 0, 0, 0)

	GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._onSecondUpdate, self)
end

function M:_getNumGoList(rootGO)
	local list = {}

	for i = 1, 7 do
		local go = goutil.findChild(rootGO, string.format("s001_obj_shijian0%s", i))

		table.insert(list, go)
	end

	return list
end

function M:_onSecondUpdate()
	self:refreshTime()
end

function M:getMainGO()
	return self._mainGO
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:resetPos()
	TransformUtils.SetLocalPosition(self._mainGO.transform, self._posX, self._posY, self._posZ)
	TransformUtils.SetLocalEulerAngles(self._mainGO.transform, self._eulerX, self._eulerY, self._eulerZ)
	TransformUtils.SetLocalScale(self._mainGO.transform, self._scaleX, self._scaleY, self._scaleZ)
end

function M:refreshTime()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime, true, true, false)

	if inSpTime then
		self:_refreshTimeLost()
	else
		if inTimeByItem then
			local offsetTs = airtightEndTS - nowTime

			hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct(offsetTs)
		end

		self:setNum(self._hourList, hour)
		self:setNum(self._minList, minute)
		self:setNum(self._secondList, second)
	end

	self:_refreshColor(inAirtightTime)
end

function M:_refreshColor(inAirtightTime)
	if self._inAirtightTime == inAirtightTime then
		return
	end

	self._inAirtightTime = inAirtightTime

	local mainColorStr = inAirtightTime and "#FF0000" or "#FFFFFF"

	self._materialSetter:SetColor(kMainColorID, mainColorStr)

	local emissionColorStr = inAirtightTime and "#FF0000" or "#FFFFFF"

	self._materialSetter:SetColor(kEmissionColorID, emissionColorStr)
end

function M:setNum(numList, num)
	local first = math.floor(num / 10)
	local second = math.fmod(num, 10)
	local firstMapList = kNumMap[first]
	local secondMapList = kNumMap[second]

	for i, go in ipairs(numList[1]) do
		if table.indexof(firstMapList, i) then
			goutil.setActive(go, true)
		else
			goutil.setActive(go, false)
		end
	end

	for i, go in ipairs(numList[2]) do
		if table.indexof(secondMapList, i) then
			goutil.setActive(go, true)
		else
			goutil.setActive(go, false)
		end
	end
end

function M:_refreshTimeLost()
	self:_refreshTimeLostNum(self._hourList[1])
	self:_refreshTimeLostNum(self._hourList[2])
	self:_refreshTimeLostNum(self._minList[1])
	self:_refreshTimeLostNum(self._minList[2])
	self:_refreshTimeLostNum(self._secondList[1])
	self:_refreshTimeLostNum(self._secondList[2])
end

function M:_refreshTimeLostNum(list)
	for i, go in ipairs(list) do
		goutil.setActive(go, i == 4)
	end
end

return M
