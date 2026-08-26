-- chunkname: @modules/logic/survival/model/SurvivalOutSideClientDataMo.lua

module("modules.logic.survival.model.SurvivalOutSideClientDataMo", package.seeall)

local SurvivalOutSideClientDataMo = pureTable("SurvivalOutSideClientDataMo")

function SurvivalOutSideClientDataMo:init(data)
	local dict = {}

	if not string.nilorempty(data) then
		dict = cjson.decode(data)
	end

	if dict.ver and dict.ver ~= self:getCurVersion() then
		dict = {}
	end

	dict.ver = dict.ver or self:getCurVersion()
	self.data = dict
end

function SurvivalOutSideClientDataMo:getCurVersion()
	return 1
end

function SurvivalOutSideClientDataMo:saveDataToServer()
	SurvivalOutSideRpc.instance:sendSurvivalSurvivalOutSideClientData(cjson.encode(self.data))
end

return SurvivalOutSideClientDataMo
