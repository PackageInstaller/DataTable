-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazyPartnerExtensionView.lua

module("logic.extensions.crazypartner.view.CrazyPartnerExtensionView", package.seeall)

local CrazyPartnerExtensionView = class("CrazyPartnerExtensionView", ViewComponent)

function CrazyPartnerExtensionView:ctor()
	CrazyPartnerExtensionView.super.ctor(self)
end

function CrazyPartnerExtensionView:unbindEvents()
	CrazyPartnerExtensionView.super.unbindEvents(self)
end

function CrazyPartnerExtensionView:bindEvents()
	CrazyPartnerExtensionView.super.bindEvents(self)
end

function CrazyPartnerExtensionView:buildUI()
	CrazyPartnerExtensionView.super.buildUI(self)

	self._standGo = self:getGo("stand")
	self._positionGo = self:getGo("stand/position")
	self._sequenceGo = self:getGo("stand/sequence")
end

function CrazyPartnerExtensionView:onExit()
	CrazyPartnerExtensionView.super.onExit(self)
end

function CrazyPartnerExtensionView:onEnter()
	CrazyPartnerExtensionView.super.onEnter(self)

	local fightInfo = CrazyPartnerModel.instance.fightInfo
	local buffConf = CrazyPartnerConfig.instance:getBuffConf(fightInfo.currentBuffId)

	if buffConf and buffConf.type == CrazyPartnerConfig.SequenceBuffType then
		self._standGo:SetActive(true)
		self:_initCreepPosition(buffConf)
	else
		self._standGo:SetActive(false)
	end
end

function CrazyPartnerExtensionView:_initCreepPosition(buffConf)
	local info = CrazyPartnerModel.instance.fightInfo
	local creepsConfs = CrazyPartnerConfig.instance:getTeamCreeps(info.currentCreepsMasterId)
	local requestPosSequence = string.splitToNumber(buffConf.params, ",")
	local positionMap = {}

	for _, creepConf in pairs(creepsConfs) do
		positionMap[creepConf.posId] = true
	end

	for i = 1, 9 do
		local posGo = goutil.findChild(self._positionGo, string.format("item%d", i))
		local sqGo = goutil.findChild(self._sequenceGo, string.format("txt%d", i))

		posGo:SetActive(false)
		sqGo:SetActive(false)

		if positionMap[i] then
			local index = table.indexof(requestPosSequence, i)

			if type(index) == "number" and index > 0 then
				posGo:SetActive(true)
				sqGo:SetActive(true)

				local sqTxt = sqGo:GetComponent(goutil.Type_UIText)

				sqTxt.text = tostring(index)
			end
		end
	end
end

return CrazyPartnerExtensionView
