-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/facade/CommonInstructionFacade.lua

module("logic.extensions.common.instruction.facade.CommonInstructionFacade", package.seeall)

local CommonInstructionFacade = class("CommonInstructionFacade", BaseFacade)

CommonInstructionFacade.TYPE_SKILL = "skill"
CommonInstructionFacade.TYPE_EGG = "egg"
CommonInstructionFacade.TYPE_EQUIP = "equip"
CommonInstructionFacade.TYPE_ITEM = "item"
CommonInstructionFacade.TYPE_POKEBALL = "pokeball"

function CommonInstructionFacade:ctor()
	return
end

function CommonInstructionFacade:OpenView(...)
	return
end

function CommonInstructionFacade:CloseView()
	return
end

CommonInstructionFacade.instance = CommonInstructionFacade.New()

return CommonInstructionFacade
