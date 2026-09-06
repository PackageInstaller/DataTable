-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetFilterView.lua

module("logic.extensions.bag.panel.PetFilterView", package.seeall)

local PetFilterView = class("PetFilterView", ViewComponent)

function PetFilterView:ctor()
	PetFilterView.super.ctor(self)
end

function PetFilterView:destroyUI()
	PetFilterView.super.destroyUI(self)
end

function PetFilterView:onExitFinished()
	PetFilterView.super.onExitFinished(self)
end

function PetFilterView:onEnterFinished()
	PetFilterView.super.onEnterFinished(self)
end

function PetFilterView:unbindEvents()
	PetFilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	self._rareFilter:unbindEvents()
	self._raceFilter:unbindEvents()
	self._jobFilter:unbindEvents()
	self._jobAgeFilter:unbindEvents()
	self._atkFilter:unbindEvents()
	self._defenceFilter:unbindEvents()
	self._skillFilter:unbindEvents()
	self._posFilter:unbindEvents()
end

function PetFilterView:bindEvents()
	PetFilterView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._rareFilter:bindEvents()
	self._raceFilter:bindEvents()
	self._jobFilter:bindEvents()
	self._jobAgeFilter:bindEvents()
	self._atkFilter:bindEvents()
	self._defenceFilter:bindEvents()
	self._skillFilter:bindEvents()
	self._posFilter:bindEvents()
	self._rareFilter:setValueChanged(self._updateList, self)
	self._raceFilter:setValueChanged(self._updateList, self)
	self._jobFilter:setValueChanged(self._updateList, self)
	self._jobAgeFilter:setValueChanged(self._updateList, self)
	self._atkFilter:setValueChanged(self._updateList, self)
	self._defenceFilter:setValueChanged(self._updateList, self)
	self._skillFilter:setValueChanged(self._updateList, self)
	self._posFilter:setValueChanged(self._updateList, self)
end

function PetFilterView:onExit()
	PetFilterView.super.onExit(self)
	removetimer(self.showMainGo, self)
end

function PetFilterView:buildUI()
	PetFilterView.super.buildUI(self)

	self._content = goutil.findChild(self.mainGO, "content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._content)

	local RareFilterGo = self:getGo("content/RareFilter")

	self._rareFilter = ItemFilterExt.New(RareFilterGo, 1, 4, false, "Cell", "Mark")

	local RaceFilterGo = self:getGo("content/RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 8, false, "Cell", "Mark")

	local JobFilterGo = self:getGo("content/JobFilter")

	self._jobFilter = ItemFilterExt.New(JobFilterGo, 1, PetFilterMgr.MAX_PET_JOB_INDEX, false, "Cell", "Mark")

	local JobAgeFilterGo = self:getGo("content/JobAgeFilter")

	self._jobAgeFilter = ItemFilterExt.New(JobAgeFilterGo, 1, PetFilterMgr.JOB_AGE_OTHER_INDEX, false, "Cell", "Mark")

	local AtkFilterGo = self:getGo("content/AtkFilter")

	self._atkFilter = ItemFilterExt.New(AtkFilterGo, 1, 2, false, "Cell", "Mark")

	local DefenceFilterGo = self:getGo("content/DefenceFilter")

	self._defenceFilter = ItemFilterExt.New(DefenceFilterGo, 3, 4, false, "Cell", "Mark")

	local SkillFilterGo = self:getGo("content/SkillFilter")

	self._skillFilter = ItemFilterExt.New(SkillFilterGo, 1, 20, false, "Cell", "Mark")

	local labelCfgs = BattleConfig.instance:getSkillLabelList()

	for i, v in ipairs(labelCfgs) do
		self._skillFilter:updateTxtLabel(v.labelId, v.labelName, "txt")
		self._skillFilter:updateTxtLabel(v.labelId, v.labelName, "Mark/txt")
	end

	local PosFilterGo = self:getGo("content/PosFilter")

	self._posFilter = ItemFilterExt.New(PosFilterGo, 1, 2, false, "Cell", "Mark")
end

function PetFilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function PetFilterView:onEnter()
	PetFilterView.super.onEnter(self)

	local params = self._viewPresentor._openParam

	if params then
		self:_adjustView()

		self.parentPresentor = params[3]
		self.type = params[4]
		self.updateCallBack = params[5]

		self:_reinitAllItem()
		self:checkPresentor()
	end
end

function PetFilterView:checkPresentor(callback)
	if not self.parentPresentor or not self.parentPresentor:isOpen() then
		self:close()

		return
	end

	GameUtil.callBack(callback)
end

function PetFilterView:_reinitAllItem()
	local data = PetFilterMgr.instance:getFilterData(self.type)

	self._rareFilter:initData(data.rareSelectList)
	self._raceFilter:initData(data.raceSelectList)
	self._jobFilter:initData(data.jobSelectList)
	self._jobAgeFilter:initData(data.jobAgeSelectList)
	self._atkFilter:initData(data.atkSelectList)
	self._defenceFilter:initData(data.defenceSelectList)
	self._skillFilter:initData(data.skillSelectList)
	self._posFilter:initData(data.posSelectList)
	self._rareFilter:initActiveList(data.rareActiveList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._jobFilter:initActiveList(data.jobActiveList)
	self._jobAgeFilter:initActiveList(data.jobAgeActiveList)
	self._atkFilter:initActiveList(data.atkActiveList)
	self._defenceFilter:initActiveList(data.defenceActiveList)
	self._skillFilter:initActiveList(data.skillActiveList)
	self._posFilter:initActiveList(data.posActiveList)
	self._rareFilter:initClickAble(data.rareClickAble)
	self._raceFilter:initClickAble(data.raceClickAble)
	self._jobFilter:initClickAble(data.jobClickAble)
	self._jobAgeFilter:initClickAble(data.jobAgeClickAble)
	self._atkFilter:initClickAble(data.atkClickAble)
	self._defenceFilter:initClickAble(data.defenceClickAble)
	self._skillFilter:initClickAble(data.skillClickAble)
	self._posFilter:initClickAble(data.posClickAble)
end

function PetFilterView:_updateList()
	self:checkPresentor(function()
		local data = PetFilterMgr.instance:getFilterData(self.type)

		data.rareSelectList = self._rareFilter:getData()
		data.raceSelectList = self._raceFilter:getData()
		data.jobSelectList = self._jobFilter:getData()
		data.jobAgeSelectList = self._jobAgeFilter:getData()
		data.atkSelectList = self._atkFilter:getData()
		data.defenceSelectList = self._defenceFilter:getData()
		data.skillSelectList = self._skillFilter:getData()
		data.posSelectList = self._posFilter:getData()

		GameUtil.callBack(self.updateCallBack)
	end)
end

function PetFilterView:_adjustView()
	local pos = self._viewPresentor._openParam[1]

	self.pos = pos
	self.sizeDelta = self._viewPresentor._openParam[2]

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, self.showMainGo, self, false)
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

function PetFilterView:showMainGo()
	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])
	self:checkPresentor()
end

return PetFilterView
