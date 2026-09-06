-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/controller/InfiniteJigsawController.lua

module("logic.extensions.infinitejigsaw.controller.InfiniteJigsawController", package.seeall)

local InfiniteJigsawController = class("InfiniteJigsawController", BaseController)

function InfiniteJigsawController:onInit()
	return
end

function InfiniteJigsawController:markDailyRedPoint()
	GameUtil.saveUserDayData(InfiniteJigsawModel.DailyRedPoint, true)
end

InfiniteJigsawController.instance = InfiniteJigsawController.New()

return InfiniteJigsawController
