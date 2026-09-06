-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/copy/DivinesqyltagView.lua

module("logic.extensions.xiayin.view.copy.DivinesqyltagView", package.seeall)

local DivinesqyltagView = class("DivinesqyltagView", ViewComponent)

function DivinesqyltagView:ctor()
	DivinesqyltagView.super.ctor(self)
end

function DivinesqyltagView:buildUI()
	DivinesqyltagView.super.buildUI(self)

	self._tagList = {}

	for i = 1, 9 do
		local element = {}
		local go = self:getGo("tag" .. i)

		element.tagGo = go
		element.tagChange = go:GetComponent(ComponentType.UIImageSpriteChange)
		element.txtTag = goutil.findChildTextComponent(element.tagGo, "txt")

		table.insert(self._tagList, element)
	end
end

function DivinesqyltagView:bindEvents()
	DivinesqyltagView.super.bindEvents(self)
end

function DivinesqyltagView:unbindEvents()
	DivinesqyltagView.super.unbindEvents(self)
end

function DivinesqyltagView:onEnter()
	DivinesqyltagView.super.onEnter(self)

	self._customFmtMo = self:getFirstParam()

	self:_initTags()
end

function DivinesqyltagView:onExit()
	DivinesqyltagView.super.onExit(self)
end

function DivinesqyltagView:_initTags()
	self:_clearTags()

	local creepsMasterId = self._customFmtMo:getCreepsMasterId()
	local cfgCreeps = XiaYinConfig.instance:getCreeps(creepsMasterId)

	for i, cfgEnemy in ipairs(cfgCreeps) do
		local item = self._tagList[cfgEnemy.posId]

		if item then
			goutil.setActive(item.tagGo, true)

			if cfgEnemy.buffMark ~= "" then
				if not XiaYinTagView.Word2Index[cfgEnemy.buffMark] then
					local buffMark = 0

					item.tagChange:SetState(Mathf.Clamp(buffMark, 0, 2))

					item.txtTag.text = cfgEnemy.buffMark

					GameUtil.SetActive(item.tagGo, buffMark > 0)
				end
			end
		end
	end
end

function DivinesqyltagView:_clearTags()
	for i, v in ipairs(self._tagList) do
		goutil.setActive(v.tagGo, false)
	end
end

return DivinesqyltagView
