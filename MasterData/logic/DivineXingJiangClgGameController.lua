-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/controller/DivineXingJiangClgGameController.lua

module("logic.extensions.divinexingjiangclg.controller.DivineXingJiangClgGameController", package.seeall)

local DivineXingJiangClgGameController = class("DivineXingJiangClgGameController", BaseController)

DivineXingJiangClgGameController.EventCaculateScore = "DivineXingJiangClgGame_CaculateScore"
DivineXingJiangClgGameController.EventRemoveHorizontalPole = "DivineXingJiangClgGame_RemoveHorizontalPole"

function DivineXingJiangClgGameController:ctor()
	return
end

function DivineXingJiangClgGameController:onInit()
	return
end

function DivineXingJiangClgGameController:getRandomIndexs(createNum)
	createNum = Mathf.Clamp(createNum, 1, DivineXingJiangClgGameModel.PillarNum)

	local pillarIndexs = {
		1,
		2,
		3,
		4,
		5
	}
	local result = {}

	for i = 1, createNum do
		local index = math.random(#pillarIndexs)

		table.insert(result, table.remove(pillarIndexs, index))
	end

	printInfo("test 随机位置索引 = ", unpack(result))

	return result
end

function DivineXingJiangClgGameController:getRandomAstroIds()
	local selectNum = DivineXingJiangClgGameModel.PillarNum
	local tempList = {}

	for i = 1, #DivineXingJiangClgGameModel.Astro do
		table.insert(tempList, i)
	end

	local result = {}

	for i = 1, selectNum do
		local index = math.random(#tempList)

		table.insert(result, table.remove(tempList, index))
	end

	printInfo("test 随机星座id索引 = ", unpack(result))

	return result
end

function DivineXingJiangClgGameController:getAstroIdByRandom(list)
	local index = math.random(#list)

	return list[index]
end

DivineXingJiangClgGameController.instance = DivineXingJiangClgGameController.New()

return DivineXingJiangClgGameController
