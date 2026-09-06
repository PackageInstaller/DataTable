-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/model/PersonLookbackMo.lua

module("logic.extensions.recap2021.model.PersonLookbackMo", package.seeall)

local PersonLookbackMo = class("PersonLookbackMo")

function PersonLookbackMo:ctor()
	self.viewCfg = nil
	self.tagCfgs = nil
	self.page = nil
	self.totalPage = nil
end

function PersonLookbackMo:getTagPlanId()
	return self.viewCfg.tagPlanId
end

function PersonLookbackMo:getCurrPage()
	return self.page
end

function PersonLookbackMo:getCfgs()
	return self.tagCfgs
end

function PersonLookbackMo:getViewCfg()
	return self.viewCfg
end

function PersonLookbackMo:getTitleName()
	return self.viewCfg.name
end

function PersonLookbackMo:getParam()
	return self.viewCfg.param
end

return PersonLookbackMo
