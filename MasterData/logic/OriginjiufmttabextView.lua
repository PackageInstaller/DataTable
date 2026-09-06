-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginjiufmttabextView.lua

module("logic.extensions.originjiu.view.OriginjiufmttabextView", package.seeall)

local OriginjiufmttabextView = class("OriginjiufmttabextView", ViewComponent)

function OriginjiufmttabextView:ctor()
	OriginjiufmttabextView.super.ctor(self)
end

function OriginjiufmttabextView:unbindEvents()
	OriginjiufmttabextView.super.unbindEvents(self)

	for i, go in ipairs(self.teamsGoList) do
		GameUtil.rmClickHandler(go)

		local dragTrigger = Framework.UIDragTrigger.Get(go)

		dragTrigger:RemoveDragListener()
		dragTrigger:RemoveBeginDragListener()
		dragTrigger:RemoveEndDragListener()
	end
end

function OriginjiufmttabextView:bindEvents()
	OriginjiufmttabextView.super.bindEvents(self)

	for i, go in ipairs(self.teamsGoList) do
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickJumpOtherTab, self, i))

		local dragTrigger = Framework.UIDragTrigger.Get(go)

		dragTrigger:AddBeginDragListener(self._OnDragPetBegin, self, i)
		dragTrigger:AddDragListener(self._OnDragPetMoved, self, i)
		dragTrigger:AddEndDragListener(self._OnDragPetEnded, self, i)
	end
end

function OriginjiufmttabextView:buildUI()
	OriginjiufmttabextView.super.buildUI(self)

	self.teamsGo = self:getGo("teams")
	self.teamsGoList = {}

	for i = 1, 3 do
		local go = self:getGo("teams/btnTeam_" .. i)

		table.insert(self.teamsGoList, go)
	end

	self.dragCon = self:getGo("dragCon")
	self.txtDrag = self:getTxt("dragCon/btnTeam/txt")

	GameUtil.SetActive(self.dragCon, false)
end

function OriginjiufmttabextView:onExit()
	OriginjiufmttabextView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onTabChange, self)
end

function OriginjiufmttabextView:onEnter()
	OriginjiufmttabextView.super.onEnter(self)

	self.customFmtMo = self:getFirstParam()

	GameUtil.SetActive(self.teamsGo, false)

	for i, go in ipairs(self.teamsGoList) do
		GameUtil.SetActive(go, false)
	end

	self:checkFight()

	local list = self.customFmtMo:getAllShowPetList()

	GlobalDispatcher:addListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onTabChange, self)
end

function OriginjiufmttabextView:checkFight()
	self.isCanDragTab = true

	self:showTabs()

	local sortList = self.customFmtMo:getTeamSortList()

	self:sortByKeyList(sortList)
end

function OriginjiufmttabextView:showTabs()
	local len = self.customFmtMo.maxTabCount

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

function OriginjiufmttabextView:sortByKeyList(sortList)
	for i, v in ipairs(sortList) do
		local go = self.teamsGoList[v]

		go.transform:SetSiblingIndex(i - 1)
	end
end

function OriginjiufmttabextView:_onTabChange()
	MissionModel.instance:setForceResetOneKey(true)

	local curTab = self.customFmtMo:getCurFormTab()

	self:_updateTabs(curTab)
end

function OriginjiufmttabextView:_onClickJumpOtherTab(idx)
	if self.draging then
		return
	end

	if FastFormation.instance.isLocking then
		return
	end

	self.customFmtMo:jumpToTabIndex(idx)
end

function OriginjiufmttabextView:_updateTabs(curTab)
	if self.curTabIdx == curTab then
		return
	end

	self.curTabIdx = curTab

	for i, go in ipairs(self.teamsGoList) do
		local imgSelect = goutil.findChild(go, "imgSelect")

		GameUtil.SetActive(imgSelect, i == curTab)
	end
end

function OriginjiufmttabextView:_onFormationChanged()
	return
end

function OriginjiufmttabextView:_OnDragPetBegin(data, idx)
	if self.isCanDragTab then
		self.draging = true

		GameUtil.SetActive(self.dragCon, true)

		self.txtDrag.text = idx

		self:changePosition()
	end
end

function OriginjiufmttabextView:_OnDragPetMoved(data, idx)
	if self.isCanDragTab then
		self:changePosition()
	end
end

function OriginjiufmttabextView:_OnDragPetEnded(data, idx)
	if self.isCanDragTab then
		GameUtil.SetActive(self.dragCon, false)

		local toIdx = self:changePosition()
		local go = self.teamsGoList[idx]

		go.transform:SetSiblingIndex(toIdx - 1)

		self.draging = false
	end

	self:refreshSortList()
end

function OriginjiufmttabextView:refreshSortList()
	local list = {}
	local parent = self.teamsGo.transform
	local childCount = parent.childCount

	for i = 1, childCount do
		local trans = parent:GetChild(i - 1)
		local go = trans.gameObject
		local idx = table.indexof(self.teamsGoList, go)

		table.insert(list, idx)
	end

	self.customFmtMo:setTeamSortList(list)
end

function OriginjiufmttabextView:changePosition()
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

return OriginjiufmttabextView
