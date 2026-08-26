-- chunkname: @modules/logic/skin/model/SkinOffsetSkinListModel.lua

module("modules.logic.skin.model.SkinOffsetSkinListModel", package.seeall)

local SkinOffsetSkinListModel = class("SkinOffsetSkinListModel", ListScrollModel)

function SkinOffsetSkinListModel:onInit()
	self.selectSkinIndex = 0
	self.selectSkin = 0
end

function SkinOffsetSkinListModel:setScrollView(scrollView)
	self.scrollView = scrollView
end

function SkinOffsetSkinListModel:initOriginSkinList()
	self._originSkinCoList = {}

	for i, v in ipairs(lua_skin.configList) do
		if v.characterId > 0 then
			table.insert(self._originSkinCoList, v)
		end
	end
end

function SkinOffsetSkinListModel:initSkinList()
	self._skinList = {}

	for i, v in ipairs(self._originSkinCoList) do
		if v.characterId > 0 then
			if self.filterFunc then
				if self.filterFunc(v) then
					table.insert(self._skinList, {
						skinId = v.id,
						skinName = v.name
					})
				end
			else
				table.insert(self._skinList, {
					skinId = v.id,
					skinName = v.name
				})
			end
		end
	end

	self:refreshList()
	self.scrollView:setSkinScrollRectVertical(1 - self.selectSkinIndex / #self._originSkinCoList)
end

function SkinOffsetSkinListModel:slideNext()
	self.selectSkinIndex = self.selectSkinIndex + 1

	if self.selectSkinIndex > #self._skinList then
		self.selectSkinIndex = 1
	end

	self:refreshSelectByIndex(self.selectSkinIndex)
end

function SkinOffsetSkinListModel:slidePre()
	self.selectSkinIndex = self.selectSkinIndex - 1

	if self.selectSkinIndex < 1 then
		self.selectSkinIndex = #self._skinList
	end

	self:refreshSelectByIndex(self.selectSkinIndex)
end

function SkinOffsetSkinListModel:refreshSelectByIndex(index)
	self:setSelectSkin(self._skinList[index].skinId)
end

function SkinOffsetSkinListModel:setSelectSkin(skinId)
	for index, skinCo in ipairs(self._skinList) do
		if skinCo.skinId == skinId then
			self.selectSkinIndex = index
			self.selectSkin = skinId

			self.scrollView.viewContainer.skinOffsetAdjustView:refreshSkin({
				skinId = skinId,
				skinName = skinCo.skinName
			})
			SkinOffsetController.instance:dispatchEvent(SkinOffsetController.Event.OnSelectSkinChange)

			return
		end
	end

	logError(string.format("not found skinId : %s index", skinId))
end

function SkinOffsetSkinListModel:isSelect(skinId)
	return self.selectSkin == skinId
end

function SkinOffsetSkinListModel:filterById(idStr)
	self._skinList = {}

	for i, v in ipairs(self._originSkinCoList) do
		if v.characterId > 0 and string.match(tostring(v.id), idStr) then
			if self.filterFunc then
				if self.filterFunc(v) then
					table.insert(self._skinList, {
						skinId = v.id,
						skinName = v.name
					})
				end
			else
				table.insert(self._skinList, {
					skinId = v.id,
					skinName = v.name
				})
			end
		end
	end

	self:refreshList()
end

function SkinOffsetSkinListModel:filterByName(name)
	self._skinList = {}

	for i, v in ipairs(self._originSkinCoList) do
		if v.characterId > 0 and string.match(v.name, name) then
			if self.filterFunc then
				if self.filterFunc(v) then
					table.insert(self._skinList, {
						skinId = v.id,
						skinName = v.name
					})
				end
			else
				table.insert(self._skinList, {
					skinId = v.id,
					skinName = v.name
				})
			end
		end
	end

	self:refreshList()
end

function SkinOffsetSkinListModel:setInitFilterFunc(filterFunc)
	self.filterFunc = filterFunc
end

function SkinOffsetSkinListModel:getFirst()
	return self._skinList[1]
end

function SkinOffsetSkinListModel:refreshList()
	self:setList(self._skinList)
end

SkinOffsetSkinListModel.instance = SkinOffsetSkinListModel.New()

return SkinOffsetSkinListModel
