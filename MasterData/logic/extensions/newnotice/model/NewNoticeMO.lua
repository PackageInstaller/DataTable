-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newnotice/model/NewNoticeMO.lua

module("logic.extensions.newnotice.model.NewNoticeMO", package.seeall)

local NewNoticeMO = class("NewNoticeMO")

function NewNoticeMO:ctor()
	self.id = 0
	self.moduleCode = 0
	self.flag = 0
	self.title = nil
	self.url = nil
	self.order = nil
	self.isAlter = 0
	self.level = nil
end

return NewNoticeMO
