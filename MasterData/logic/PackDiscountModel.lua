-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/packdiscount/model/PackDiscountModel.lua

module("logic.extensions.packdiscount.model.PackDiscountModel", package.seeall)

local PackDiscountModel = class("PackDiscountModel", BaseModel)

function PackDiscountModel:ctor()
	return
end

function PackDiscountModel:onInit()
	self:onReset()
end

function PackDiscountModel:onReset()
	self.packInfo = {}
end

function PackDiscountModel:setPackInfo(msg)
	GameUtil.pbToTable(msg, self.packInfo)
end

function PackDiscountModel:isBuyPack()
	return checkbool(self.packInfo.buyPack)
end

function PackDiscountModel:hasBuyItems()
	return self.packInfo.hasBuyItems or {}
end

PackDiscountModel.instance = PackDiscountModel.New()

return PackDiscountModel
