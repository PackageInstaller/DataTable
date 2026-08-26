-- chunkname: @modules/logic/necrologiststory/view/item/V3A8NecrologistStoryLeftStyle.lua

module("modules.logic.necrologiststory.view.item.V3A8NecrologistStoryLeftStyle", package.seeall)

local V3A8NecrologistStoryLeftStyle = class("V3A8NecrologistStoryLeftStyle", NecrologistStoryBaseItem)

function V3A8NecrologistStoryLeftStyle:onInit()
	self.typeList = {}

	for i = 1, 3 do
		self:initTypeList(i)
	end
end

function V3A8NecrologistStoryLeftStyle:onAddEvent()
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeWeather, self.refreshView, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeTime, self.refreshView, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePlace, self.refreshView, self)
end

function V3A8NecrologistStoryLeftStyle:onRemoveEvent()
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeWeather, self.refreshView, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeTime, self.refreshView, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePlace, self.refreshView, self)
end

function V3A8NecrologistStoryLeftStyle:initTypeList(type)
	local item = self:getUserDataTb_()

	item.styleType = type
	item.go = gohelper.findChild(self.viewGO, string.format("type%d", type))
	item.txtPlace = gohelper.findChildTextMesh(item.go, "Title/#txt_place")
	item.txtTime = gohelper.findChildTextMesh(item.go, "Title/#txt_time")
	item.txtWeather = gohelper.findChildTextMesh(item.go, "Title/#txt_weather")
	item.imgWeather = gohelper.findChildImage(item.go, "Title/#image_weather")
	item.txtNum = gohelper.findChildTextMesh(item.go, "Title/#txt_num")
	item.txtChapterName = gohelper.findChildTextMesh(item.go, "Title/#txt_chapterName")

	gohelper.setActive(item.go, false)

	self.typeList[type] = item
end

function V3A8NecrologistStoryLeftStyle:onPlayStory(isSkip)
	self:refreshView()
	self:onPlayFinish(true)
end

function V3A8NecrologistStoryLeftStyle:refreshTypeItem(item, curType)
	local isShow = item.styleType == curType

	gohelper.setActive(item.go, isShow)

	if not isShow then
		return
	end

	local mo = NecrologistStoryModel.instance:getCurStoryMO()
	local success, y, m1, d = NecrologistStoryHelper.stringTotimeData(mo.time)

	item.txtTime.text = success and string.format("%02d.%02d.%d", d, m1, y) or ""
	item.txtPlace.text = mo.place or ""

	NecrologistStoryHelper.setWeatherTxt(item.txtWeather, mo.showWeather)
	NecrologistStoryHelper.setWeatherWihteIcon(item.imgWeather, mo.showWeather)

	item.txtNum.text = string.format("%02d", NecrologistStoryHelper.getStoryGroupIndex(mo.id))
	item.txtChapterName.text = mo.config.storyName

	if curType == 3 then
		item.simage = gohelper.findChildSingleImage(item.go, "")

		if item.simage then
			local resPath = string.format("singlebg/dungeon/rolestory_singlebg/3020/rolestory_3020_leftbg_%s.png", tonumber(y) == 1992 and "3" or "4")

			item.simage:LoadImage(resPath)
		end
	end
end

function V3A8NecrologistStoryLeftStyle:refreshView()
	self.storyView:setLeftStyleVisible(false)

	local storyConfig = self:getStoryConfig()
	local curType = tonumber(storyConfig.param)

	for _, item in pairs(self.typeList) do
		self:refreshTypeItem(item, curType)
	end
end

function V3A8NecrologistStoryLeftStyle:onDestroy()
	for _, item in pairs(self.typeList) do
		if item.simage then
			item.simage:UnLoadImage()
		end
	end
end

function V3A8NecrologistStoryLeftStyle.getResPath()
	return "ui/viewres/dungeon/rolestory/v3a8/v3a8_rolestorynotebookview.prefab"
end

return V3A8NecrologistStoryLeftStyle
