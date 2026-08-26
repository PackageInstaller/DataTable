-- chunkname: @modules/logic/gm/model/GMLangTxtModel.lua

module("modules.logic.gm.model.GMLangTxtModel", package.seeall)

local GMLangTxtModel = class("GMLangTxtModel", ListScrollModel)

function GMLangTxtModel:ctor()
	GMLangTxtModel.super.ctor(self)

	self._allText = {}
	self._txtIndex = 1
	self.search = ""
end

function GMLangTxtModel:reInit()
	self._hasInit = nil
end

function GMLangTxtModel:setSearch(text)
	self.search = text

	self:reInit()
	self:updateModel()
end

function GMLangTxtModel:getSearch()
	return self.search
end

function GMLangTxtModel:clearAll(txt)
	self._allText = {}
	self._txtIndex = 1

	self:setList({})
end

function GMLangTxtModel:addLangTxt(txt)
	if self._allText[txt] then
		return
	end

	self._allText[txt] = {
		id = self._txtIndex,
		txt = txt
	}
	self._txtIndex = self._txtIndex + 1

	self:addAtLast(self._allText[txt])
end

function GMLangTxtModel:updateModel()
	if not self._hasInit then
		self._hasInit = true

		local list = {}

		for txt, mo in pairs(self._allText) do
			if (self.search or nil) and string.find(txt, self.search) then
				table.insert(list, mo)
			end
		end

		table.sort(list, function(mo1, mo2)
			return mo1.id < mo2.id
		end)
		self:setList(list)
	else
		self:onModelUpdate()
	end
end

GMLangTxtModel.instance = GMLangTxtModel.New()

return GMLangTxtModel
