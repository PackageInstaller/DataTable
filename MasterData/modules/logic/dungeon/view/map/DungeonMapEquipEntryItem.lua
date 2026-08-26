-- chunkname: @modules/logic/dungeon/view/map/DungeonMapEquipEntryItem.lua

module("modules.logic.dungeon.view.map.DungeonMapEquipEntryItem", package.seeall)

local DungeonMapEquipEntryItem = class("DungeonMapEquipEntryItem", LuaCompBase)

function DungeonMapEquipEntryItem:ctor(param)
	self._index = param[1]
	self._chapterId = param[2]
	self._readyChapterId = nil
end

function DungeonMapEquipEntryItem:init(go)
	self.viewGO = go
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._imagefull = gohelper.findChildImage(self.viewGO, "progress/#image_full")
	self._txtprogressNum = gohelper.findChildText(self.viewGO, "progress/#txt_progressNum")

	local equipChapterConfig = lua_equip_chapter.configDict[self._chapterId]
	local url = string.format("entry/bg_fuben_tesurukou_%s", equipChapterConfig.group)

	self._simageicon:LoadImage(ResUrl.getDungeonIcon(url))

	local list = DungeonConfig.instance:getChapterEpisodeCOList(self._chapterId)
	local count = #list
	local index = 0

	for i, v in ipairs(list) do
		local info = DungeonModel.instance:getEpisodeInfo(v.id)

		if DungeonModel.instance:hasPassLevel(v.id) and info.challengeCount == 1 then
			index = index + 1
		else
			self._readyChapterId = v.id

			break
		end
	end

	self._txtprogressNum.text = string.format("%s/%s", index, count)
	self._txtnum.text = "0" .. self._index
	self._imagefull.fillAmount = index / count
end

function DungeonMapEquipEntryItem:addEventListeners()
	self._click = gohelper.getClickWithAudio(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function DungeonMapEquipEntryItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function DungeonMapEquipEntryItem:_onClick()
	DungeonController.instance:openDungeonEquipEntryView(self._chapterId)
end

function DungeonMapEquipEntryItem:onStart()
	return
end

function DungeonMapEquipEntryItem:onDestroy()
	return
end

return DungeonMapEquipEntryItem
