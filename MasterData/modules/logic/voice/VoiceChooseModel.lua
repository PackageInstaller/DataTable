-- chunkname: @modules/logic/voice/VoiceChooseModel.lua

module("modules.logic.voice.VoiceChooseModel", package.seeall)

local VoiceChooseModel = class("VoiceChooseModel", ListScrollModel)

function VoiceChooseModel:initModel(chooseLang)
	local list = {}
	local allLocalLang = ResCheckMgr.instance:getAllLocalLang()

	for i = 1, #allLocalLang do
		local lang = allLocalLang[i]

		table.insert(list, {
			lang = lang,
			choose = lang == chooseLang
		})
	end

	self:setList(list)
end

function VoiceChooseModel:getChoose()
	local list = self:getList()

	for _, mo in ipairs(list) do
		if mo.choose then
			return mo.lang
		end
	end
end

function VoiceChooseModel:choose(lang)
	local list = self:getList()

	for _, mo in ipairs(list) do
		mo.choose = mo.lang == lang
	end

	self:onModelUpdate()
end

VoiceChooseModel.instance = VoiceChooseModel.New()

return VoiceChooseModel
