-- chunkname: @modules/logic/gm/model/GMGuideStatusModel.lua

module("modules.logic.gm.model.GMGuideStatusModel", package.seeall)

local GMGuideStatusModel = class("GMGuideStatusModel", ListScrollModel)

function GMGuideStatusModel:ctor()
	GMGuideStatusModel.super.ctor(self)

	self.showOpBtn = true
	self.idReverse = false
	self.search = ""
end

function GMGuideStatusModel:reInit()
	self._hasInit = nil
end

function GMGuideStatusModel:onClickShowOpBtn()
	self.showOpBtn = not self.showOpBtn

	self:updateModel()
end

function GMGuideStatusModel:onClickReverse()
	self.idReverse = not self.idReverse

	self:reInit()
	self:updateModel()
end

function GMGuideStatusModel:setSearch(text)
	self.search = text

	self:reInit()
	self:updateModel()
end

function GMGuideStatusModel:getSearch()
	return self.search
end

function GMGuideStatusModel:updateModel()
	if not self._hasInit then
		self._hasInit = true

		local list = {}

		for i, guideCO in ipairs(lua_guide.configList) do
			if guideCO.isOnline == 1 and (self.search or nil) and (string.find(tostring(guideCO.id), self.search) or string.find(guideCO.desc, self.search)) then
				table.insert(list, guideCO)
			end
		end

		table.sort(list, function(guideCfg1, guideCfg2)
			return guideCfg1.id < guideCfg2.id
		end)

		if self.idReverse then
			tabletool.revert(list)
		end

		self:setList(list)
	else
		self:onModelUpdate()
	end
end

GMGuideStatusModel.instance = GMGuideStatusModel.New()

return GMGuideStatusModel
