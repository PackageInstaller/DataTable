-- chunkname: @modules/logic/reddot/define/RedDotCustomFunc.lua

module("modules.logic.reddot.define.RedDotCustomFunc", package.seeall)

local RedDotCustomFunc = class("RedDotCustomFunc")

function RedDotCustomFunc.isCustomShow(id, uid)
	local func = RedDotCustomFunc.CustomRedHandleFunc[id]

	if func then
		return true, func(id, uid)
	end
end

function RedDotCustomFunc.isShowNecrologistStory(id, uid)
	local storyId = RoleStoryModel.instance:getCurActStoryId()

	return NecrologistStoryController.instance:getNecrologistStoryActivityRed(storyId)
end

RedDotCustomFunc.CustomRedHandleFunc = {
	[RedDotEnum.DotNode.NecrologistStory] = RedDotCustomFunc.isShowNecrologistStory,
	[RedDotEnum.DotNode.CommandStationRelationShipBoard] = CommandStationController.getCommandStationRelationShipBoardReddot
}

return RedDotCustomFunc
