-- chunkname: @modules/logic/college/view/comp/CollegeAreaExploreComp.lua

module("modules.logic.college.view.comp.CollegeAreaExploreComp", package.seeall)

local CollegeAreaExploreComp = class("CollegeAreaExploreComp", ListScrollCellExtend)

function CollegeAreaExploreComp:onInitView()
	self._imageexplore = gohelper.findChildImage(self.viewGO, "explore")
	self._txtunexplore = gohelper.findChildTextMesh(self.viewGO, "explore/#txt_unexplore")
	self._goexplored = gohelper.findChild(self.viewGO, "explore/#txt_explored")
	self._txtexplored = gohelper.findChildTextMesh(self.viewGO, "explore/#txt_explored")
	self._iconexplored = gohelper.findChildImage(self.viewGO, "explore/#txt_explored/icon")
	self._goexploring = gohelper.findChild(self.viewGO, "explore/exploring")
	self._txtexploringround = gohelper.findChildTextMesh(self.viewGO, "explore/exploring/#txt_num")
	self._sliderexploring = gohelper.findChildImage(self.viewGO, "explore/exploring/linebg/#img_line2")
	self._sliderexploring2 = gohelper.findChildImage(self.viewGO, "explore/exploring/linebg/#img_line")
	self._txtexploringnum2 = gohelper.findChildTextMesh(self.viewGO, "explore/exploring/#txt_num2")
	self._txtexploringnum3 = gohelper.findChildTextMesh(self.viewGO, "explore/exploring/#txt_num3")
	self._gosuspend = gohelper.findChild(self.viewGO, "explore/suspend")
	self._slidersuspend = gohelper.findChildImage(self.viewGO, "explore/suspend/linebg/#img_line")
	self._txtsuspendnum = gohelper.findChildTextMesh(self.viewGO, "explore/suspend/#txt_num")
	self._txtunexplore.text = luaLang("college_explore_unexplore")
end

function CollegeAreaExploreComp:addEvents()
	return
end

function CollegeAreaExploreComp:removeEvents()
	return
end

function CollegeAreaExploreComp:onUpdateMO(data)
	self.data = data

	self:_refreshStatus()
end

function CollegeAreaExploreComp:_refreshStatus()
	if not self.data or not self.data.unlock then
		return
	end

	gohelper.setActive(self._txtunexplore, self.data.status == CollegeEnum.AreaStatus.Unexplore)
	gohelper.setActive(self._goexplored, self.data.status == CollegeEnum.AreaStatus.Explored)
	gohelper.setActive(self._goexploring, self.data.status == CollegeEnum.AreaStatus.Exploring)
	gohelper.setActive(self._gosuspend, self.data.status == CollegeEnum.AreaStatus.Suspend)

	if self.data.status == CollegeEnum.AreaStatus.Explored then
		local itemId, val = self.data:getCurProduceItem()

		if not itemId then
			gohelper.setActive(self._goexplored, false)
		else
			self._txtexplored.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_res_produce"), val)

			CollegeIconHelper.setItemIcon(itemId, self._iconexplored)
		end

		if self._imageexplore then
			self._imageexplore.enabled = not not itemId
		end
	elseif self.data.status == CollegeEnum.AreaStatus.Exploring then
		self._txtexploringround.text = self.data.explorationProp.remainRound

		local percent = self.data.explorationProp.progress / self.data.co.requiredProgress
		local nextPercent = (self.data.explorationProp.progress + self.data.co.progressPerStep * #self.data.slotCharacterUid) / self.data.co.requiredProgress

		nextPercent = math.min(nextPercent, 1)
		self._sliderexploring2.fillAmount = percent
		self._sliderexploring.fillAmount = nextPercent
		self._txtexploringnum2.text = string.format("%d%%", percent * 100)
		self._txtexploringnum3.text = string.format("%d%%", nextPercent * 100)
	elseif self.data.status == CollegeEnum.AreaStatus.Suspend then
		local percent = self.data.explorationProp.progress / self.data.co.requiredProgress

		self._slidersuspend.fillAmount = percent
		self._txtsuspendnum.text = string.format("%d%%", percent * 100)
	end
end

return CollegeAreaExploreComp
