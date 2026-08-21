-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationTeamComp.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationTeamComp", package.seeall)

local M = class("HandbookRelationTeamComp", UIReusableLuaBehavior)

function M:buildUI()
	local registry = self:getRegistry()

	self._txtName = registry:findUIElement("handbook_relationship_team_1289125378", UIComponentType.Text)
	self._rootLeader = registry:findUIElement("handbook_relationship_team_1761172735")

	local rootMembers = registry:findUIElement("handbook_relationship_team_870463529", UIComponentType.RectTransform)
	local line = registry:findUIElement("handbook_relationship_team_1728255816", UIComponentType.RectTransform)

	self._rootMembers = {}
	self._line = {}

	for i = 0, rootMembers.childCount - 1 do
		local tmpTr = rootMembers:GetChild(i).gameObject

		goutil.clearChildren(tmpTr)

		self._rootMembers[i] = tmpTr
		tmpTr = line:GetChild(i).gameObject
		self._line[i] = tmpTr
	end

	goutil.clearChildren(self._rootLeader)
end

function M:destroyUI()
	self:clearRegistry()

	self._txtName = nil
	self._rootLeader = nil
	self._rootMembers = nil
	self._line = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:getMainGO()
	return self.mainGO
end

function M:getRegistry()
	if not self._registry then
		self._registry = ViewElementsRegistry.New(self:getMainGO())
	end

	return self._registry
end

function M:clearRegistry()
	if self._registry then
		self._registry:cleanRegistry()
	end

	self._registry = false
end

function M:setName(nameStr)
	self._txtName.text = nameStr
end

function M:updateMembersRootShow(uiPattern)
	return
end

function M:getLeaderRoot()
	return self._rootLeader
end

function M:getMembersRoot(uiPattern)
	local root = self._rootMembers[uiPattern]

	if root == nil then
		printError(string.format("无法找到uiPattern[%s]", uiPattern))
	end

	return root
end

function M:updateMembersVisible(uiPattern)
	local maxn = tonumber(uiPattern)

	for idx = 0, 4 do
		goutil.setActive(self._line[idx], idx < maxn)
		goutil.setActive(self._rootMembers[idx], idx < maxn)
	end
end

function M:getMembersPosRoot(uiPattern, uiIndex)
	local root = self._rootMembers[uiIndex]

	if not root then
		printError(string.format("无法找到uiPattern[%s] uiIndex[%s]的节点", uiPattern, uiIndex))
	end

	return root
end

return M
