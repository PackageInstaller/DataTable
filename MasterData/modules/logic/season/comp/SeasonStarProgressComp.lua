-- chunkname: @modules/logic/season/comp/SeasonStarProgressComp.lua

module("modules.logic.season.comp.SeasonStarProgressComp", package.seeall)

local SeasonStarProgressComp = class("SeasonStarProgressComp", LuaCompBase)

function SeasonStarProgressComp:init(go)
	self.go = go
	self.transform = go.transform
	self.starCount = 7
end

function SeasonStarProgressComp:refreshStar(starName, curStage, maxStage)
	self:initItemList(starName)
	self:refreshItemList(curStage, maxStage)
end

function SeasonStarProgressComp:initItemList(starName)
	if self.itemList then
		return
	end

	self.itemList = {}

	for i = 1, self.starCount do
		self.itemList[i] = self:createItem(i, starName)
	end
end

function SeasonStarProgressComp:createItem(index, starName)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = type(starName) == "string" and gohelper.findChild(self.go, string.format("%s%s", starName, index)) or gohelper.cloneInPlace(starName, string.format("star%s", starName, index))
	item.goDark = gohelper.findChild(item.go, "dark")
	item.goLight = gohelper.findChild(item.go, "light")
	item.imgDark = gohelper.findChildImage(item.go, "dark")
	item.imgLight = gohelper.findChildImage(item.go, "light")

	return item
end

function SeasonStarProgressComp:refreshItemList(curStage, maxStage)
	if self.itemList then
		for i, v in ipairs(self.itemList) do
			self:updateItem(v, curStage, maxStage)
		end
	end
end

function SeasonStarProgressComp:updateItem(item, stage, maxStage)
	if not item then
		return
	end

	local index = item.index
	local isMaxStage = index == maxStage
	local isNotShow = maxStage < index or isMaxStage and stage < index

	if isNotShow then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local showLight = index <= stage

	gohelper.setActive(item.goLight, showLight)
	gohelper.setActive(item.goDark, not showLight)

	if showLight then
		local color = isMaxStage and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(item.imgLight, color)
	end
end

return SeasonStarProgressComp
