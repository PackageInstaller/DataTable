-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectclothes/controller/CollectClothesController.lua

module("logic.extensions.collectclothes.controller.CollectClothesController", package.seeall)

local CollectClothesController = class("CollectClothesController", BaseController)

CollectClothesController.E_InfoRes = "E_InfoRes"
CollectClothesController.E_GainPrizeRes = "E_GainPrizeRes"

function CollectClothesController:ctor()
	return
end

function CollectClothesController:onInit()
	return
end

function CollectClothesController:onReset()
	CollectClothesModel.instance:onReset()
end

function CollectClothesController:handleInfoRes(status, msg)
	if status == 0 then
		CollectClothesModel.instance:handleInfoRes(msg)
		self:localNotify(CollectClothesController.E_InfoRes)
	end
end

function CollectClothesController:handleGainPrizeRes(status, msg)
	if status == 0 then
		CollectClothesModel.instance:handleGainPrizeRes(msg)
		self:localNotify(CollectClothesController.E_GainPrizeRes)
	end
end

CollectClothesController.instance = CollectClothesController.New()

return CollectClothesController
