-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionLabelView.lua

module("logic.extensions.controlaction.view.ControlActionLabelView", package.seeall)

local M = class("ControlActionLabelView", ViewComponent)

function M:buildUI()
	self._textTitle = self:getText("regulatory_network_ram_tips_504931505")
	self._textDesc = self:getText("regulatory_network_ram_tips_357031152")
	self._btnBg = self:getBtn("regulatory_network_ram_tips_2015458631")
end

function M:bindEvents()
	self._btnBg:AddClickListener(self._onClickBg, self)
end

function M:unbindEvents()
	self._btnBg:RemoveClickListener()
end

function M:onEnter()
	local kLabelKey = self:getFirstParam()

	wordCo = WordConfig.instance:getWordCO(kLabelKey)

	if wordCo == nil then
		return
	end

	self._textTitle.text = wordCo.name
	self._textDesc.text = wordCo.desc
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_onClickBg()
	self:close()
end

return M
