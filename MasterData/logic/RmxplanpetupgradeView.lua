-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanpetupgradeView.lua

module("logic.extensions.richmanxplan.view.RmxplanpetupgradeView", package.seeall)

local RmxplanpetupgradeView = class("RmxplanpetupgradeView", ViewComponent)

function RmxplanpetupgradeView:ctor()
	RmxplanpetupgradeView.super.ctor(self)
end

function RmxplanpetupgradeView:unbindEvents()
	RmxplanpetupgradeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnFliterType:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnOneKeyCancel:RemoveClickListener()
end

function RmxplanpetupgradeView:bindEvents()
	RmxplanpetupgradeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnFliterType:AddClickListener(self._onClickbtnFliterType, self)
	self._btnOneKey:AddClickListener(self._onClickbtnOneKey, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnOneKeyCancel:AddClickListener(self._onClickbtnOneKeyCancel, self)
end

function RmxplanpetupgradeView:buildUI()
	RmxplanpetupgradeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnFliterType = self:getBtn("root/btnFliterType")
	self._btnOneKey = self:getBtn("root/btnOneKey")
	self._btnSure = self:getBtn("root/btnSure")
	self._btnCancel = self:getBtn("root/btnCancel")
	self._btnOneKeyCancel = self:getBtn("root/btnOneKeyCancel")
	self._tableviewGo = self:getGo("root/tableview")
	self._tablecellGo = self:getGo("root/tablecell")
	self._emptyGo = self:getGo("empty")
	self._rootGo = self:getGo("root")
	self._txtSelectDesc = self:getTxt("root/txtSelectDesc")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	goutil.setActive(self._btnFliterType.gameObject, false)
end

function RmxplanpetupgradeView:onExit()
	RmxplanpetupgradeView.super.onExit(self)
	self._scrollerList:dispose()
end

function RmxplanpetupgradeView:onEnter()
	RmxplanpetupgradeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanWorkPetStarLevelUpRes, self._RichManXPlanWorkPetStarLevelUpRes, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanWorkInfoRes, self._updateUI, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._petId = params[2]
	self._maxStarLevel = RichmanxplanConfig.instance:getPetMaxStarLevel(self._activityId)
	self._needPetNum = RichmanxplanConfig.instance:getPetLevelUpUseNumber(self._activityId)
	self._selectPetIds = {}

	self:_updateUI()
end

function RmxplanpetupgradeView:_onClickbtnClose()
	self:close()
end

function RmxplanpetupgradeView:_onClickbtnFliterType()
	return
end

function RmxplanpetupgradeView:_onClickbtnOneKey()
	local hasNum = table.nums(self._selectPetIds)

	if hasNum >= self._needPetNum then
		return
	end

	local needNum = self._needPetNum - hasNum

	for i, v in ipairs(self._petDatasFilterMe) do
		if not self._selectPetIds[v.petId] and v.starLevel == self._curStarLevel and self._raceId == v.raceId then
			needNum = needNum - 1
			self._selectPetIds[v.petId] = v.petId

			if needNum <= 0 then
				break
			end
		end
	end

	self._scrollerList:refresh()
	self:_updateDesc()
end

function RmxplanpetupgradeView:_onClickbtnSure()
	if table.nums(self._selectPetIds) < self._needPetNum then
		FloatWordMgr.instance:show("未满足升星条件，请重新选择！")

		return
	end

	local usePetIds = table.values(self._selectPetIds)

	RichManXPlanAgent.instance:sendPM_RichManXPlanWorkPetStarLevelUpReq(self._activityId, self._petId, usePetIds)
end

function RmxplanpetupgradeView:_onClickbtnCancel()
	self:close()
end

function RmxplanpetupgradeView:_onClickbtnOneKeyCancel()
	self._selectPetIds = {}

	self._scrollerList:refresh()
	self:_updateDesc()
end

function RmxplanpetupgradeView:_updateUI()
	self._petData = RichmanxplanModel.instance:getPetData(self._petId)
	self._raceId = self._petData.raceId

	local petCfg = RichmanxplanConfig.instance:getPetCfg(self._activityId, self._petData.raceId)

	self._petName = petCfg.name
	self._isMaxStarLevel = self._petData.starLevel >= self._maxStarLevel
	self._curStarLevel = self._petData.starLevel

	local petDatas = RichmanxplanModel.instance:getPetDatas()

	self._petDatasFilterMe = {}

	for i, v in ipairs(petDatas) do
		if v.petId ~= self._petId then
			table.insert(self._petDatasFilterMe, v)
		end
	end

	self._scrollerList:reloadData(self._petDatasFilterMe)
	self:_updateDesc()
	self:_updateEmpty()
end

function RmxplanpetupgradeView:_updateCell(view, cell, petData, tag)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local goStar = goutil.findChild(cell.gameObject, "star")
	local goStars = goutil.findChild(cell.gameObject, "stars")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txts/txtName")
	local txtStart = goutil.findChildTextComponent(cell.gameObject, "txts/txtStart")
	local starLayout = goStars:GetComponent(ComponentType.UILayoutSingleLine)
	local btnBg = Framework.ButtonAdapter.GetFrom(cell.gameObject, "bg")
	local petCfg = RichmanxplanConfig.instance:getPetCfg(self._activityId, petData.raceId)

	txtName.text = petCfg.name
	txtStart.text = petData.starLevel

	goutil.setActive(goSelect, self._selectPetIds[petData.petId])
	MaterialMgr.setIcon(goIcon, MatType.Pet, petCfg.linkRaceId)
	goutil.setActive(goStar, false)
	self:_updateStars(goStars, goStar, petData.starLevel)
	btnBg:AddClickListener(function()
		if self._selectPetIds[petData.petId] then
			self._selectPetIds[petData.petId] = nil
		else
			if table.nums(self._selectPetIds) >= self._needPetNum then
				FloatWordMgr.instance:show("已达上限")

				return
			end

			if self._curStarLevel ~= petData.starLevel or self._raceId ~= petData.raceId then
				FloatWordMgr.instance:show(string.format("需要选择%s星%s", self._curStarLevel, self._petName))

				return
			end

			self._selectPetIds[petData.petId] = petData.petId
		end

		self:_updateDesc()
		self._scrollerList:refresh()
	end)
end

function RmxplanpetupgradeView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(goIcon)
end

function RmxplanpetupgradeView:_updateDesc()
	local petCfg = RichmanxplanConfig.instance:getPetCfg(self._activityId, self._petData.raceId)

	self._txtSelectDesc.text = string.format("<color=red>%s星精灵%s</color>（%s/%s）", self._curStarLevel, petCfg.name, table.nums(self._selectPetIds), self._needPetNum)
end

function RmxplanpetupgradeView:_updateEmpty()
	local isEmpty = not self._petDatasFilterMe or #self._petDatasFilterMe <= 0

	goutil.setActive(self._emptyGo, isEmpty)
	goutil.setActive(self._rootGo, not isEmpty)
end

function RmxplanpetupgradeView:_RichManXPlanWorkPetStarLevelUpRes()
	self._selectPetIds = {}

	self:_updateUI()
end

function RmxplanpetupgradeView:_updateStars(goStars, goStar, starLevel)
	local childs = GameUtil.getChildren(goStars)
	local starLayout = goStars:GetComponent(ComponentType.UILayoutSingleLine)

	for i, v in ipairs(childs) do
		goutil.setActive(v, false)
	end

	for i = 1, starLevel do
		local go = childs[i]

		go = go or goutil.cloneAndSetParent(goStar, goStars.transform)

		goutil.setActive(go, true)
	end

	starLayout:Layout()
end

return RmxplanpetupgradeView
