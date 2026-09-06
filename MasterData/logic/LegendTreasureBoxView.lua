-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/treasure/LegendTreasureBoxView.lua

module("logic.extensions.legend.view.treasure.LegendTreasureBoxView", package.seeall)

local LegendTreasureBoxView = class("LegendTreasureBoxView", ViewComponent)

function LegendTreasureBoxView:ctor()
	return
end

function LegendTreasureBoxView:buildUI()
	local parent = self:getGo("scrollview/Viewport/Content/petContent")

	self._petCell = goutil.findChild(parent, "petCell")
	self._boxCell = goutil.findChild(parent, "boxCell")
	self._petParent = goutil.findChild(parent, "petParent")
	self._boxParent = goutil.findChild(parent, "boxParent")
	self._petParentRecord = self._petParent:GetComponent("TestRecordPos")
	self._boxParentRecord = self._boxParent:GetComponent("TestRecordPos")

	goutil.setActive(self._petCell, false)
	goutil.setActive(self._boxCell, false)

	self._petItemList = {}
end

function LegendTreasureBoxView:bindEvents()
	return
end

function LegendTreasureBoxView:unbindEvents()
	return
end

function LegendTreasureBoxView:onEnter()
	GlobalDispatcher:addListener(MopupModel.SweepSuccessed, self._setChallengeCount, self)
	GlobalDispatcher:addListener(GlobalNotify.LegendChallengeTimesInfoRes, self._updateChallengeTimes, self)
	GlobalDispatcher:addListener(GlobalNotify.LegendChallengeTimesInfoRes, self._updateChallengeTimes, self)
	self.addGEvent(self, GlobalNotify.LegendSwitchMap, self._onSwitchMap, self)
	self:_onSwitchMap()
end

function LegendTreasureBoxView:onExit()
	self:_clearItems()
	GlobalDispatcher:removeListener(MopupModel.SweepSuccessed, self._setChallengeCount, self)
	GlobalDispatcher:removeListener(GlobalNotify.LegendChallengeTimesInfoRes, self._updateChallengeTimes, self)
end

function LegendTreasureBoxView:_initVariable()
	self._boxItemList = {}
end

function LegendTreasureBoxView:_initPetItems()
	local dealType = LegendController.instance:getCurMapDealType()
	local cfgPets = LegendConfig.instance:getLegendChallengeCfgs()
	local curMapId = LegendController.instance:getCurLegendMapId()
	local curMapCfg = LegendConfig.instance:getMapListCfg(curMapId)

	if dealType ~= LegendController.MapDealType.Original then
		cfgPets = LegendConfig.instance:getMapDetailCfg(curMapId)
	end

	for i, v in ipairs(cfgPets) do
		local petItem, go

		if self._petItemList[i] == nil then
			local go = goutil.cloneAndSetParent(self._petCell, self._petParent.transform, "pet" .. i)

			goutil.setActive(go, true)

			local petItem = GameUtil.AddLuaOnce(go, LegendPetItem)

			petItem:init(go, v)

			self._petItemList[i] = petItem
		else
			local go = self._petParent.transform:GetChild(i - 1).gameObject

			petItem = self._petItemList[i]

			self._petItemList[i]:reset()
			petItem:init(go, v)
			goutil.setActive(go, true)
		end
	end

	self._petParentRecord:LoadPlan(curMapCfg.petPlan)

	local childCount = self._petParent.transform.childCount

	for i = #cfgPets + 1, childCount do
		local go = self._petParent.transform:GetChild(i - 1).gameObject

		goutil.setActive(go, false)
	end
end

function LegendTreasureBoxView:_setChallengeCount(challId)
	if self._petItemList == nil or self._petItemList[challId] == nil then
		return
	end

	local petItem = self._petItemList[challId]

	petItem:_setText()
end

function LegendTreasureBoxView:_initBoxItems()
	goutil.clearChildren(self._boxParent)

	local dealType = LegendController.instance:getCurMapDealType()

	if dealType == LegendController.MapDealType.Original then
		local cfgTreasures = LegendConfig.instance:getTreasureCfgs()

		for i, v in ipairs(cfgTreasures) do
			local go = goutil.cloneAndSetParent(self._boxCell, self._boxParent.transform, "box" .. i)

			goutil.setActive(go, true)

			local boxItem = GameUtil.AddLuaOnce(go, LegendBoxItem)

			boxItem:init(go, v, self)
			table.insert(self._boxItemList, boxItem)
		end

		self._boxParentRecord:LoadPlan(0)
	end
end

function LegendTreasureBoxView:_clearItems()
	if self._petItemList then
		for i, v in ipairs(self._petItemList) do
			v:reset()
		end
	end

	if self._boxItemList then
		for i, v in ipairs(self._boxItemList) do
			v:reset()
		end

		table.clear(self._boxItemList)
	end

	goutil.clearChildren(self._boxParent)
end

function LegendTreasureBoxView:_updateChallengeTimes()
	if self._petItemList == nil then
		return
	end

	printInfo("test 更新扫荡次数")

	for i, v in ipairs(self._petItemList) do
		v:_setText()
	end
end

function LegendTreasureBoxView:_onSwitchMap()
	self:_clearItems()
	self:_initVariable()
	self:_initPetItems()
	self:_initBoxItems()
end

return LegendTreasureBoxView
