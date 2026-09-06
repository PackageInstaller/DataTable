-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonfmttabextView.lua

module("logic.extensions.season.view.SeasonfmttabextView", package.seeall)

local SeasonfmttabextView = class("SeasonfmttabextView", ViewComponent)

function SeasonfmttabextView:ctor()
	SeasonfmttabextView.super.ctor(self)
end

function SeasonfmttabextView:unbindEvents()
	SeasonfmttabextView.super.unbindEvents(self)

	for i, go in ipairs(self.teamsGoList) do
		GameUtil.rmClickHandler(go)

		local dragTrigger = Framework.UIDragTrigger.Get(go)

		dragTrigger:RemoveDragListener()
		dragTrigger:RemoveBeginDragListener()
		dragTrigger:RemoveEndDragListener()
	end

	if self.btnJump then
		GameUtil.rmClickHandler(self.btnJump)
	end
end

function SeasonfmttabextView:bindEvents()
	SeasonfmttabextView.super.bindEvents(self)

	for i, go in ipairs(self.teamsGoList) do
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickJumpOtherTab, self, i))

		local dragTrigger = Framework.UIDragTrigger.Get(go)

		dragTrigger:AddBeginDragListener(self._OnDragPetBegin, self, i)
		dragTrigger:AddDragListener(self._OnDragPetMoved, self, i)
		dragTrigger:AddEndDragListener(self._OnDragPetEnded, self, i)
	end

	if self.btnJump then
		GameUtil.addClickHandler(self.btnJump, self.onJump, self)
	end
end

function SeasonfmttabextView:buildUI()
	SeasonfmttabextView.super.buildUI(self)

	self.emptyGo = self:getGo("emptyGo")
	self.btnJump = self:getGo("emptyGo/btnJump")
	self.teamsGo = self:getGo("teams")
	self.teamsGoList = {}

	for i = 1, 3 do
		local go = self:getGo("teams/btnTeam_" .. i)

		table.insert(self.teamsGoList, go)
	end

	self.dragCon = self:getGo("dragCon")
	self.txtDrag = self:getTxt("dragCon/btnTeam/txt")

	GameUtil.SetActive(self.dragCon, false)
	self:_initPowerCostNode()
end

function SeasonfmttabextView:_initPowerCostNode()
	self._powerNode = self:getGo("NodePower")
	self._powerCostNum = self:getTxt("NodePower/Power")

	if self._powerNode then
		self._powerNode:SetActive(false)
	end
end

function SeasonfmttabextView:onExit()
	SeasonfmttabextView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onTabChange, self)
end

function SeasonfmttabextView:onEnter()
	SeasonfmttabextView.super.onEnter(self)

	self.customFmtMo = self:getFirstParam()

	GameUtil.SetActive(self.teamsGo, false)

	for i, go in ipairs(self.teamsGoList) do
		GameUtil.SetActive(go, false)
	end

	self:checkBossFight()
	GameUtil.SetActive(self._powerNode, false)

	if self.customFmtMo:getCostNum() > 0 then
		GameUtil.SetActive(self._powerNode, true)

		if self._powerCostNum then
			self._powerCostNum.text = self.customFmtMo:getCostNum()
		end
	end

	local list = self.customFmtMo:getAllShowPetList()

	GameUtil.SetActive(self.emptyGo, list == nil or #list == 0)
	GlobalDispatcher:addListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onTabChange, self)
end

function SeasonfmttabextView:checkBossFight()
	self.isCanDragTab = false

	if self.customFmtMo:isBossChallenge() then
		self.isCanDragTab = true

		self:showTabs()

		local sortList = self.customFmtMo:getBossTeamSortList()

		self:sortByKeyList(sortList)
	end
end

function SeasonfmttabextView:showTabs()
	local list = SeasonTeamsModel.instance:getTeams() or {}
	local len = #list

	GameUtil.SetActive(self.teamsGo, false)

	for i, go in ipairs(self.teamsGoList) do
		if len > 1 then
			GameUtil.SetActive(go, i <= len)
			GameUtil.SetActive(self.teamsGo, true)
		else
			GameUtil.SetActive(go, false)
		end
	end

	local curTab = self.customFmtMo:getCurFormTab()

	self:_updateTabs(curTab)
end

function SeasonfmttabextView:sortByKeyList(sortList)
	for i, v in ipairs(sortList) do
		local go = self.teamsGoList[v]

		go.transform:SetSiblingIndex(i - 1)
	end
end

function SeasonfmttabextView:_onTabChange()
	MissionModel.instance:setForceResetOneKey(true)

	local curTab = self.customFmtMo:getCurFormTab()

	self:_updateTabs(curTab)
end

function SeasonfmttabextView:_onClickJumpOtherTab(idx)
	if self.draging then
		return
	end

	if FastFormation.instance.isLocking then
		return
	end

	self.customFmtMo:jumpToTabIndex(idx)
end

function SeasonfmttabextView:_updateTabs(curTab)
	if self.curTabIdx == curTab then
		return
	end

	self.curTabIdx = curTab

	for i, go in ipairs(self.teamsGoList) do
		local imgSelect = goutil.findChild(go, "imgSelect")

		GameUtil.SetActive(imgSelect, i == curTab)
	end
end

function SeasonfmttabextView:_onFormationChanged()
	return
end

function SeasonfmttabextView:onJump()
	local curTab = self.customFmtMo:getCurFormTab()

	SeasonFmtController.instance:showFormationView(curTab)
end

function SeasonfmttabextView:_OnDragPetBegin(data, idx)
	if self.isCanDragTab then
		self.draging = true

		GameUtil.SetActive(self.dragCon, true)

		self.txtDrag.text = idx

		self:changePosition()
	end
end

function SeasonfmttabextView:_OnDragPetMoved(data, idx)
	if self.isCanDragTab then
		self:changePosition()
	end
end

function SeasonfmttabextView:_OnDragPetEnded(data, idx)
	if self.isCanDragTab then
		GameUtil.SetActive(self.dragCon, false)

		local toIdx = self:changePosition()
		local go = self.teamsGoList[idx]

		go.transform:SetSiblingIndex(toIdx - 1)

		self.draging = false
	end

	self:refreshBossSortList()
end

function SeasonfmttabextView:refreshBossSortList()
	local list = {}
	local parent = self.teamsGo.transform
	local childCount = parent.childCount

	for i = 1, childCount do
		local trans = parent:GetChild(i - 1)
		local go = trans.gameObject
		local idx = table.indexof(self.teamsGoList, go)

		table.insert(list, idx)
	end

	self.customFmtMo:setBossTeamSortList(list)
end

function SeasonfmttabextView:changePosition()
	local dragPos = uGuiUtil.GetTouchWorldPosition()
	local posList = {}
	local goList = {}

	table.insert(posList, -99999)

	local parent = self.teamsGo.transform
	local childCount = parent.childCount

	for i = 1, childCount do
		local trans = parent:GetChild(i - 1)
		local go = trans.gameObject

		if go.activeSelf then
			if i == 1 then
				-- block empty
			else
				local x, y, z = Framework.TransformUtil.GetPos(trans, 0, 0, 0)

				table.insert(posList, x)
			end

			table.insert(goList, go)
		end
	end

	table.insert(posList, 99999)

	local curIdx = 1
	local len = #posList

	for i = 1, len - 1 do
		local nextX = posList[i + 1]
		local go = goList[i]

		if dragPos.x > posList[i] and nextX >= dragPos.x then
			local x, y, z = Framework.TransformUtil.GetPos(go.transform, 0, 0, 0)

			GameUtil.setPos(self.dragCon.transform, x, y + 0.2, z)

			curIdx = i
		end
	end

	return curIdx
end

return SeasonfmttabextView
