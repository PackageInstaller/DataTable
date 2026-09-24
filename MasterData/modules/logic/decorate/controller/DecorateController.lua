-- chunkname: @modules/logic/decorate/controller/DecorateController.lua

module("modules.logic.decorate.controller.DecorateController", package.seeall)

local DecorateController = class("DecorateController", BaseController)

function DecorateController:openPreviewView(itemConfig)
	if not itemConfig then
		return
	end

	local itemDecorateCo, classify = DecorateModel.instance:getItemDecorateCo(itemConfig)

	if itemConfig.subType == ItemEnum.SubType.PlayerBg then
		ViewMgr.instance:openView(ViewName.PlayerCardGetView, {
			isHideEquipBtn = true,
			preview = true,
			id = itemConfig.id
		})
	elseif itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
		ViewMgr.instance:openView(ViewName.MainSceneSwitchInfoView, {
			isAmplify = true,
			isPreview = true,
			noInfoEffect = true,
			sceneSkinId = itemDecorateCo.id
		})
	elseif itemConfig.subType == ItemEnum.SubType.MainUISkin then
		if classify == MainSwitchClassifyEnum.Classify.UI then
			MainUISwitchController.instance:openMainUISwitchInfoView(itemDecorateCo.id, true, true, false, false, true)
		elseif classify == MainSwitchClassifyEnum.Classify.Click then
			ClickUISwitchController.instance:openClickUISwitchInfoView(itemDecorateCo.id, true, true, true)
		end
	elseif itemConfig.subType == ItemEnum.SubType.FightCard or itemConfig.subType == ItemEnum.SubType.FightFloatType then
		FightUISwitchController.instance:openSceneView(itemConfig.id)
	end
end

function DecorateController:openBuyView(goodsId)
	local param = {
		goodsId = goodsId
	}

	ViewMgr.instance:openView(ViewName.DecorateMaterialBuyView, param)
end

function DecorateController:openBuySkinView(goodsMO)
	local param = {
		goodsMO = goodsMO
	}

	ViewMgr.instance:openView(ViewName.DecorateSkinBuyView, param)
end

DecorateController.instance = DecorateController.New()

return DecorateController
