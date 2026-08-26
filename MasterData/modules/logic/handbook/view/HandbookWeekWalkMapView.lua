-- chunkname: @modules/logic/handbook/view/HandbookWeekWalkMapView.lua

module("modules.logic.handbook.view.HandbookWeekWalkMapView", package.seeall)

local HandbookWeekWalkMapView = class("HandbookWeekWalkMapView", BaseView)

function HandbookWeekWalkMapView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goleftarrow = gohelper.findChild(self.viewGO, "#go_leftarrow")
	self._gorightarrow = gohelper.findChild(self.viewGO, "#go_rightarrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookWeekWalkMapView:addEvents()
	return
end

function HandbookWeekWalkMapView:removeEvents()
	return
end

function HandbookWeekWalkMapView:_editableInitView()
	self.goweekList = {}

	for i = 1, 3 do
		local goweek = self:getUserDataTb_()

		goweek.go = gohelper.findChild(self.viewGO, "weekwalkContainer/#go_week" .. i)
		goweek.name = gohelper.findChildText(goweek.go, "txt_name")
		goweek.click = gohelper.getClickWithAudio(goweek.go)

		goweek.click:AddClickListener(self.onClickGoWeek, self, i)
		table.insert(self.goweekList, goweek)
	end

	self.leftClick = gohelper.getClickWithAudio(self._goleftarrow)
	self.rightClick = gohelper.getClickWithAudio(self._gorightarrow)

	self.leftClick:AddClickListener(self.leftPageOnClick, self)
	self.rightClick:AddClickListener(self.rightPageOnClick, self)
	self._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))
end

function HandbookWeekWalkMapView:onClickGoWeek(index)
	ViewMgr.instance:openView(ViewName.HandbookWeekWalkView, self:getMapCoByPageNumAndIndex(self.pageNum, index))
end

function HandbookWeekWalkMapView:leftPageOnClick()
	if self.pageNum <= 1 then
		return
	end

	self.pageNum = self.pageNum - 1

	self:refreshMapElements(self.pageNum)
end

function HandbookWeekWalkMapView:rightPageOnClick()
	if self.pageNum >= self.maxPageNum then
		return
	end

	self.pageNum = self.pageNum + 1

	self:refreshMapElements(self.pageNum)
end

function HandbookWeekWalkMapView:onUpdateParam()
	self:onOpen()
end

function HandbookWeekWalkMapView:onOpen()
	self.pageNum = 1
	self.pageSize = 3
	self.maxPageNum = math.ceil(#lua_weekwalk.configList / 3)

	self:refreshMapElements(self.pageNum)
end

function HandbookWeekWalkMapView:refreshMapElements(pageNum)
	self.mapCoList = self:getMapCoListByPageNum(pageNum)

	local count = #self.mapCoList

	for i = 1, count do
		self.goweekList[i].name.text = self.mapCoList[i].name

		gohelper.setActive(self.goweekList[i].go, true)
	end

	for i = count + 1, 3 do
		gohelper.setActive(self.goweekList[i].go, false)
	end

	gohelper.setActive(self._goleftarrow, self.pageNum > 1)
	gohelper.setActive(self._gorightarrow, self.pageNum < self.maxPageNum)
end

function HandbookWeekWalkMapView:getMapCoListByPageNum(pageNum)
	local startIndex = (pageNum - 1) * 3
	local coList = {}
	local co

	for i = 1, 3 do
		if not lua_weekwalk.configList[startIndex + i] then
			break
		end

		table.insert(coList, lua_weekwalk.configList[startIndex + i])
	end

	return coList
end

function HandbookWeekWalkMapView:getMapCoByPageNumAndIndex(pageNum, index)
	local startIndex = (pageNum - 1) * 3

	return lua_weekwalk.configList[startIndex + index]
end

function HandbookWeekWalkMapView:onClose()
	self.leftClick:RemoveClickListener()
	self.rightClick:RemoveClickListener()
	self._simagebg:UnLoadImage()

	for _, goweek in ipairs(self.goweekList) do
		goweek.click:RemoveClickListener()
	end
end

function HandbookWeekWalkMapView:onDestroyView()
	return
end

return HandbookWeekWalkMapView
