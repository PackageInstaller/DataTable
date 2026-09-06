-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianExtremeFmtTwoView.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianExtremeFmtTwoView", package.seeall)

local DivineDiShiTianExtremeFmtTwoView = class("DivineDiShiTianExtremeFmtTwoView", ViewComponent)

function DivineDiShiTianExtremeFmtTwoView:ctor()
	DivineDiShiTianExtremeFmtTwoView.super.ctor(self)
end

function DivineDiShiTianExtremeFmtTwoView:buildUI()
	DivineDiShiTianExtremeFmtTwoView.super.buildUI(self)

	self._tagList = {}

	for i = 1, 9 do
		local element = {}

		element.tagGo = self:getGo("tag" .. i)

		table.insert(self._tagList, element)
	end
end

function DivineDiShiTianExtremeFmtTwoView:bindEvents()
	DivineDiShiTianExtremeFmtTwoView.super.bindEvents(self)
end

function DivineDiShiTianExtremeFmtTwoView:unbindEvents()
	DivineDiShiTianExtremeFmtTwoView.super.unbindEvents(self)
end

function DivineDiShiTianExtremeFmtTwoView:onEnter()
	DivineDiShiTianExtremeFmtTwoView.super.onEnter(self)

	self._customFmtMo = self:getFirstParam()

	self:_initTags()
end

function DivineDiShiTianExtremeFmtTwoView:onExit()
	DivineDiShiTianExtremeFmtTwoView.super.onExit(self)
end

function DivineDiShiTianExtremeFmtTwoView:_initTags()
	self:_clearTags()

	local creepsMasterId = self._customFmtMo:getCreepsMasterId()
	local cfgCreeps = DivineDiShiTianClgConfig.instance:getCreeps(creepsMasterId)

	for i, cfgEnemy in ipairs(cfgCreeps) do
		local item = self._tagList[cfgEnemy.posId]

		if item then
			goutil.setActive(item.tagGo, true)
			GameUtil.SetActive(item.tagGo, cfgEnemy.sign > 0)
		end
	end
end

function DivineDiShiTianExtremeFmtTwoView:_clearTags()
	for i, v in ipairs(self._tagList) do
		goutil.setActive(v.tagGo, false)
	end
end

return DivineDiShiTianExtremeFmtTwoView
