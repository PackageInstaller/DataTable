-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetFilterView.lua

module("logic.extensions.cutepet.view.CutePetFilterView", package.seeall)

local CutePetFilterView = class("CutePetFilterView", ViewComponent)

function CutePetFilterView:ctor()
	CutePetFilterView.super.ctor(self)
end

function CutePetFilterView:destroyUI()
	CutePetFilterView.super.destroyUI(self)
end

function CutePetFilterView:onExitFinished()
	CutePetFilterView.super.onExitFinished(self)
end

function CutePetFilterView:onEnterFinished()
	CutePetFilterView.super.onEnterFinished(self)
end

function CutePetFilterView:unbindEvents()
	CutePetFilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	self._rareFilter:unbindEvents()
	self._typeFilter:unbindEvents()
	self._talentFilter:unbindEvents()
	self._raceFilter:unbindEvents()
	self._jobFilter:unbindEvents()
	self._talentTypeFilter:unbindEvents()
end

function CutePetFilterView:bindEvents()
	CutePetFilterView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._rareFilter:bindEvents()
	self._typeFilter:bindEvents()
	self._talentFilter:bindEvents()
	self._raceFilter:bindEvents()
	self._jobFilter:bindEvents()
	self._talentTypeFilter:bindEvents()
	self._rareFilter:setValueChanged(self._updateList, self)
	self._typeFilter:setValueChanged(self._updateList, self)
	self._talentFilter:setValueChanged(self._updateList, self)
	self._raceFilter:setValueChanged(self._updateList, self)
	self._jobFilter:setValueChanged(self._updateList, self)
	self._talentTypeFilter:setValueChanged(self._updateList, self)
end

function CutePetFilterView:onExit()
	CutePetFilterView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetFilterClose)
	removetimer(self.showMainGo, self)
end

function CutePetFilterView:buildUI()
	CutePetFilterView.super.buildUI(self)

	self._content = goutil.findChild(self.mainGO, "content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._content)

	local RareFilterGo = self:getGo("content/RareFilter")

	self._rareFilter = ItemFilterExt.New(RareFilterGo, 1, 5, false, "Cell", "Mark")

	local TypeFilterGo = self:getGo("content/TypeFilter")

	self._typeFilter = ItemFilterExt.New(TypeFilterGo, 1, 4, false, "Cell", "Mark")

	local TalentFilterGo = self:getGo("content/TalentFilter")

	self._talentFilter = ItemFilterExt.New(TalentFilterGo, 1, 5, false, "Cell", "Mark")

	local RaceFilterGo = self:getGo("content/RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 8, false, "Cell", "Mark")

	local JobFilterGo = self:getGo("content/JobFilter")

	self._jobFilter = ItemFilterExt.New(JobFilterGo, 1, CutePetFilterMgr.MAX_PET_JOB_INDEX, false, "Cell", "Mark")

	local TalentTypeFilterGo = self:getGo("content/TalentTypeFilter")

	self._talentTypeFilter = ItemFilterExt.New(TalentTypeFilterGo, 1, 37, false, "Cell", "Mark")
end

function CutePetFilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function CutePetFilterView:onEnter()
	CutePetFilterView.super.onEnter(self)

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

function CutePetFilterView:_reinitAllItem()
	local data = CutePetFilterMgr.instance:getFilterData(self.type)

	self._rareFilter:initData(data.rareSelectList)
	self._raceFilter:initData(data.raceSelectList)
	self._jobFilter:initData(data.jobSelectList)
	self._typeFilter:initData(data.typeSelectList)
	self._talentFilter:initData(data.talentSelectList)
	self._talentTypeFilter:initData(data.talentTypeSelectList)
	self._rareFilter:initActiveList(data.rareActiveList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._jobFilter:initActiveList(data.jobActiveList)
	self._typeFilter:initActiveList(data.typeActiveList)
	self._talentFilter:initActiveList(data.talentActiveList)
	self._talentTypeFilter:initActiveList(data.talentTypeActiveList)
	self._rareFilter:initClickAble(data.rareClickAble)
	self._raceFilter:initClickAble(data.raceClickAble)
	self._jobFilter:initClickAble(data.jobClickAble)
	self._typeFilter:initClickAble(data.typeClickAble)
	self._talentFilter:initClickAble(data.talentClickAble)
	self._talentTypeFilter:initClickAble(data.talentTypeClickAble)
end

function CutePetFilterView:checkPresentor(callback)
	if not self.parentPresentor or not self.parentPresentor:isOpen() then
		self:close()

		return
	end

	GameUtil.callBack(callback)
end

function CutePetFilterView:_adjustView()
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

function CutePetFilterView:showMainGo()
	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])

	local pos = GameUtil.getLocalPos(self._content)

	GameUtil.setLocalPos(self._content, pos.x, 0, pos.z)
	self:checkPresentor()
end

function CutePetFilterView:_updateList()
	self:checkPresentor(function()
		local data = CutePetFilterMgr.instance:getFilterData(self.type)

		data.rareSelectList = self._rareFilter:getData()
		data.typeSelectList = self._typeFilter:getData()
		data.talentSelectList = self._talentFilter:getData()
		data.raceSelectList = self._raceFilter:getData()
		data.jobSelectList = self._jobFilter:getData()
		data.talentTypeSelectList = self._talentTypeFilter:getData()

		GameUtil.callBack(self.updateCallBack)
	end)
end

return CutePetFilterView
