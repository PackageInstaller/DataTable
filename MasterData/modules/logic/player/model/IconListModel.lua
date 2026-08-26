-- chunkname: @modules/logic/player/model/IconListModel.lua

module("modules.logic.player.model.IconListModel", package.seeall)

local IconListModel = class("IconListModel", ListScrollModel)

function IconListModel:setIconList(infos)
	self._moList = {}

	if infos then
		self._moList = infos

		table.sort(self._moList, function(a, b)
			return a.id < b.id
		end)
	end

	self:setList(self._moList)
end

IconListModel.instance = IconListModel.New()

return IconListModel
