-- chunkname: @modules/logic/versionactivity2_1/activity165/model/Activity165KeywordMo.lua

module("modules.logic.versionactivity2_1.activity165.model.Activity165KeywordMo", package.seeall)

local Activity165KeywordMo = class("Activity165KeywordMo")

function Activity165KeywordMo:ctor()
	self.keywordCo = nil
	self.keywordId = nil
	self.isUsed = nil
end

function Activity165KeywordMo:onInit(co)
	self.keywordCo = co
	self.keywordId = co.keywordId
end

function Activity165KeywordMo:setUsed(isUsed)
	self.isUsed = isUsed
end

function Activity165KeywordMo:onReset()
	self.isUsed = nil
end

return Activity165KeywordMo
