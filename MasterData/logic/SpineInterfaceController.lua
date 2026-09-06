-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/controller/SpineInterfaceController.lua

module("logic.extensions.spineinterface.controller.SpineInterfaceController", package.seeall)

local SpineInterfaceController = class("SpineInterfaceController", BaseController)

function SpineInterfaceController:ctor()
	return
end

function SpineInterfaceController:onInit()
	self:onReset()
end

function SpineInterfaceController:onReset()
	return
end

function SpineInterfaceController:isSupportInterface(skinId)
	local data = SpineInterfaceConfig.instance:getMsBaseData(checknumber(skinId))

	return data ~= nil
end

function SpineInterfaceController:_getInteractionRegistry()
	if self._interactionRegistry == nil then
		self._interactionRegistry = {
			[1802103] = {
				[MsEnum.Interaction_BubbleGame_Enter] = {
					behaviorId = 1,
					behaviorLayerId = 7
				},
				[MsEnum.Interaction_BubbleGame_Success] = {
					behaviorId = 1,
					behaviorLayerId = 8
				},
				[MsEnum.Interaction_BubbleGame_Fail] = {
					behaviorId = 1,
					behaviorLayerId = 9
				}
			},
			[1403803] = {
				[MsEnum.Interaction_XiWangShenNvEnvelope_Success] = {
					behaviorId = 1,
					behaviorLayerId = 6
				},
				[MsEnum.Interaction_XiWangShenNvEnvelope_Fail] = {
					behaviorId = 1,
					behaviorLayerId = 7
				}
			},
			[1802104] = {
				[MsEnum.Interaction_FeiNiYaClothes_Clothes_0] = {
					behaviorId = 1,
					behaviorLayerId = 9
				},
				[MsEnum.Interaction_FeiNiYaClothes_Clothes_1] = {
					behaviorId = 1,
					behaviorLayerId = 10
				},
				[MsEnum.Interaction_FeiNiYaClothes_Shoes_0] = {
					behaviorId = 1,
					behaviorLayerId = 14
				},
				[MsEnum.Interaction_FeiNiYaClothes_Shoes_1] = {
					behaviorId = 1,
					behaviorLayerId = 12
				},
				[MsEnum.Interaction_FeiNiYaClothes_Shoes_2] = {
					behaviorId = 1,
					behaviorLayerId = 13
				},
				[MsEnum.Interaction_FeiNiYaClothes_Shoes_3] = {
					behaviorId = 1,
					behaviorLayerId = 11
				},
				[MsEnum.Interaction_FeiNiYaClothes_Hair_0] = {
					behaviorId = 1,
					behaviorLayerId = 15
				},
				[MsEnum.Interaction_FeiNiYaClothes_Hair_1] = {
					behaviorId = 1,
					behaviorLayerId = 17
				},
				[MsEnum.Interaction_FeiNiYaClothes_Hair_2] = {
					behaviorId = 1,
					behaviorLayerId = 16
				},
				[MsEnum.Interaction_FeiNiYaClothes_Headwear_0] = {
					behaviorId = 1,
					behaviorLayerId = 19
				},
				[MsEnum.Interaction_FeiNiYaClothes_Headwear_1] = {
					behaviorId = 1,
					behaviorLayerId = 20
				},
				[MsEnum.Interaction_FeiNiYaClothes_Headwear_2] = {
					behaviorId = 1,
					behaviorLayerId = 18
				},
				[MsEnum.Interaction_FeiNiYaClothes_Headwear_3] = {
					behaviorId = 1,
					behaviorLayerId = 21
				},
				[MsEnum.Interaction_FeiNiYaClothes_Headwear_3_Off] = {
					behaviorId = 1,
					behaviorLayerId = 22
				}
			}
		}
	end

	return self._interactionRegistry
end

function SpineInterfaceController:getInteractionBehavior(skinId, eventName)
	if string.nilorempty(eventName) then
		printError("spineinterface interaction eventName is empty")

		return nil
	end

	local skinPlanId = SpineInterfaceConfig.instance:getSkinPlanId(checknumber(skinId))
	local planRegistry = self:_getInteractionRegistry()[skinPlanId]

	if planRegistry == nil then
		printError(string.format("spineinterface interaction registry missing, skinPlanId = %s, eventName = %s", skinPlanId, eventName))

		return nil
	end

	local behavior = planRegistry[eventName]

	if behavior == nil then
		printError(string.format("spineinterface interaction missing, skinPlanId = %s, eventName = %s", skinPlanId, eventName))

		return nil
	end

	return behavior
end

function SpineInterfaceController:getFsmId(skinId, behaviorLayerId)
	return string.format("%s_%s", skinId, behaviorLayerId)
end

function SpineInterfaceController:getFsmStateId(skinId, behaviorLayerId, behaviorId)
	return string.format("%s_%s_%s", skinId, behaviorLayerId, behaviorId)
end

function SpineInterfaceController:doSpineInterfaceBagExtension(spineComp, extendRoot, viewPresentor, eventParams)
	return ExtensionRegistry.openBagExtension(spineComp, extendRoot, viewPresentor, eventParams)
end

SpineInterfaceController.instance = SpineInterfaceController.New()

return SpineInterfaceController
