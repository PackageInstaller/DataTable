-- chunkname: @modules/logic/college/view/comp/CollegeSceneAreaItem.lua

module("modules.logic.college.view.comp.CollegeSceneAreaItem", package.seeall)

local CollegeSceneAreaItem = class("CollegeSceneAreaItem", CollegeSceneBaseItem)

function CollegeSceneAreaItem:onInitView()
	self._uiRoot = gohelper.findChild(self.root, "ui")
	self._txtname = gohelper.findChildTextMesh(self.root, "ui/bg/#txt_name")
	self._btnClick = gohelper.findChildButtonWithAudio(self.root, "ui/#btn_click")
	self.heroItems = gohelper.findChild(self.root, "ui/#go_items/#go_heroItem")

	self.addClickCb(self, self._btnClick, self.onClick, self)

	self._exploreComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._uiRoot, CollegeAreaExploreComp)
end

function CollegeSceneAreaItem:addEventListeners()
	CollegeSceneAreaItem.super.addEventListeners(self)
	CollegeController.instance:registerCallback(CollegeEvent.UpdateArea, self.updateData, self)
end

function CollegeSceneAreaItem:removeEventListeners()
	CollegeSceneAreaItem.super.removeEventListeners(self)
	CollegeController.instance:unregisterCallback(CollegeEvent.UpdateArea, self.updateData, self)
end

function CollegeSceneAreaItem:updateData(data)
	data = data or self.data

	CollegeSceneAreaItem.super.updateData(self, data)
	gohelper.setActive(self._uiRoot, data.unlock)
	gohelper.setActive(self.arrow, data.unlock)

	if not data.unlock then
		return
	end

	self._txtname.text = data.co.name

	self:_refreshHero()
	self._exploreComp:onUpdateMO(data)
end

function CollegeSceneAreaItem:_refreshHero()
	local datas = {}
	local sceneMo = CollegeModel.instance:getSceneMo()

	for i = 1, self.data.co.slots do
		datas[i] = sceneMo.characterBox:getCharacterMo(self.data.slotCharacterUid[i]) or true
	end

	gohelper.CreateObjList(self, self._createHero, datas, nil, self.heroItems)
end

function CollegeSceneAreaItem:_createHero(obj, data, index)
	local simageHero = gohelper.findChildSingleImage(obj, "#simage_hero")
	local goadd = gohelper.findChild(obj, "#go_add")

	gohelper.setActive(simageHero, data ~= true)
	gohelper.setActive(goadd, data == true)

	if data ~= true then
		simageHero:LoadImage(ResUrl.getCollegeSingleBg(data.co.avatar, "headicon_small"))
	end
end

function CollegeSceneAreaItem:onClick()
	CollegeHelper.instance:focusTo(self.data, self.finishCallback, self)
end

function CollegeSceneAreaItem:finishCallback()
	ViewMgr.instance:openView(ViewName.CollegeAreaView, {
		data = self.data
	})
end

return CollegeSceneAreaItem
