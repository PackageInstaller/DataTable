-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcemon/model/SourceMonModel.lua

module("logic.extensions.sourcemon.model.SourceMonModel", package.seeall)

local SourceMonModel = class("SourceMonModel", BaseModel)

function SourceMonModel:ctor()
	return
end

function SourceMonModel:onInit()
	self:onReset()
end

function SourceMonModel:onReset()
	self.sourceMonList = {}
	self.isFirstInited = true
end

function SourceMonModel:changeInfo(msg)
	local infolist = msg.infoList

	for i, v in ipairs(infolist) do
		if v.isDelete == false then
			local mo = SourcemonMo.New()

			mo:init(v)

			self.sourceMonList[v.id] = mo

			MaterialFacade.instance:AddMaterial(MatType.SourceMon, v.id, 1)
		else
			self:removeMoById(v.id)
			MaterialFacade.instance:AddMaterial(MatType.SourceMon, v.id, -1)
		end
	end

	self.isFirstInited = false
end

function SourceMonModel:removeMoById(id)
	self.sourceMonList[id] = nil
end

function SourceMonModel:getMonById(id)
	return self.sourceMonList[id]
end

function SourceMonModel:getAllMons()
	return self.sourceMonList
end

SourceMonModel.instance = SourceMonModel.New()

return SourceMonModel
