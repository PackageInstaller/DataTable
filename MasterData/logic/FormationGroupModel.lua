-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FormationGroupModel.lua

module("logic.extensions.formation.model.FormationGroupModel", package.seeall)

local FormationGroupModel = class("FormationGroupModel", BaseModel)

function FormationGroupModel:onInit()
	self:onReset()
end

function FormationGroupModel:onReset()
	self._isDataInited = false
	self._petInTeamMap = {}
	self._lastTabId = -1
	self._curNewTabId = -1
	self._maxGroupId = 0
	self._isChange = false
	self.curTabId = 0
	self.groups = {}
end

function FormationGroupModel:getIsInited()
	return self._isDataInited
end

function FormationGroupModel:setIsChange()
	self._isChange = true
end

function FormationGroupModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg) or {}

	self.curTabId = pb.curTabId
	self.groups = pb.groups or {}
	self._isDataInited = true

	self:_updateMaxGroupId()
	self:setIsChange()
end

function FormationGroupModel:onPresetsFormationChanged(msg)
	local pb = GameUtil.pbToTable(msg) or {}

	if not pb.form then
		local form = {}
		local map = {}

		for i, v in ipairs(form) do
			local tabId = v.tabId

			map[tabId] = v.simpleForm
		end

		for i, group in ipairs(self.groups) do
			for j, tab in ipairs(group.presetsForm or {}) do
				local sf = map[tab.tabId]

				if sf then
					tab.simpleForm = sf
				end
			end
		end

		self:setIsChange()
	end
end

function FormationGroupModel:onModifyOrAddGroup(msg)
	local groupId = msg.groupId
	local newGroupName = msg.newGroupName
	local isNew = true

	for i, v in ipairs(self.groups) do
		if groupId == v.groupId then
			isNew = false
			v.groupName = newGroupName
		end
	end

	if isNew then
		local obj = {}

		obj.groupId = groupId
		obj.groupName = newGroupName

		table.insert(self.groups, obj)

		self._maxGroupId = math.max(self._maxGroupId, groupId)
	end

	return groupId
end

function FormationGroupModel:onDeleteGroup(groupId)
	for i, v in ipairs(self.groups) do
		if groupId == v.groupId then
			table.remove(self.groups, i)
		end
	end
end

function FormationGroupModel:getTabInfo(tabId)
	tabId = checknumber(tabId)

	if tabId > 0 then
		for i, group in ipairs(self.groups) do
			if not group.presetsForm then
				for j, tabInfo in ipairs(group.presetsForm) do
					if tabInfo.tabId == tabId then
						return tabInfo
					end
				end
			end
		end
	end

	return nil
end

function FormationGroupModel:onDeleteTab(tabId)
	local isFound = false

	for i, group in ipairs(self.groups) do
		if not group.presetsForm then
			for j, tabInfo in ipairs(group.presetsForm) do
				if tabInfo.tabId == tabId then
					table.remove(group.presetsForm, j)

					isFound = true

					break
				end
			end

			group.presetsForm = group.presetsForm

			if isFound then
				break
			end
		end
	end
end

function FormationGroupModel:onTabChangeGroup(msg)
	local pb = GameUtil.pbToTable(msg)
	local form = pb.presetsForm

	for i, group in ipairs(self.groups) do
		if not group.presetsForm then
			local presetsForm = {}

			if form.groupId == group.groupId then
				table.insert(presetsForm, form)
			else
				for j, tabInfo in ipairs(presetsForm) do
					if tabInfo.tabId == form.tabId then
						table.remove(presetsForm, j)

						break
					end
				end
			end

			group.presetsForm = presetsForm
		end
	end
end

function FormationGroupModel:onMontifyTab(msg)
	local pb = GameUtil.pbToTable(msg)

	self.curTabId = pb.curTabId

	if not pb.presetsForm then
		for i, form in ipairs(pb.presetsForm) do
			for i, group in ipairs(self.groups) do
				if form.groupId == group.groupId then
					local isNew = true

					if not group.presetsForm then
						for j, tem in ipairs(group.presetsForm) do
							if form.tabId == tem.tabId then
								isNew = false
								group.presetsForm[j] = form

								break
							end
						end

						if isNew then
							table.insert(group.presetsForm, form)

							self._curNewTabId = form.tabId
						end

						group.presetsForm = group.presetsForm
					end
				end
			end
		end

		self:setIsChange()
	end
end

function FormationGroupModel:onModifyTabName(msg)
	local tabId = msg.tabId
	local newTabName = msg.newTabName

	for i, group in ipairs(self.groups) do
		for j, tab in ipairs(group.presetsForm or {}) do
			if tab.tabId == tabId then
				tab.tabName = newTabName

				return
			end
		end
	end
end

function FormationGroupModel:onTopPresetsTab(msg)
	local tabId = msg.tabId
	local topId = msg.topId

	for i, group in ipairs(self.groups) do
		for j, tab in ipairs(group.presetsForm or {}) do
			if tab.tabId == tabId then
				tab.topId = topId

				return
			end
		end
	end
end

function FormationGroupModel:getGroupList()
	return self.groups
end

function FormationGroupModel:getSorttingGroup()
	local list = {}

	for i, v in ipairs(self.groups) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, {
		"topId",
		"groupId"
	}, {
		ArraySort.DESCENDING,
		ArraySort.NUMERIC
	})

	return list
end

function FormationGroupModel:getNewGroupName()
	return "分组"
end

function FormationGroupModel:getNewTabName(groupId)
	return "预设"
end

function FormationGroupModel:_updateMaxGroupId()
	self._maxGroupId = 0

	for i, v in ipairs(self.groups) do
		self._maxGroupId = math.max(self._maxGroupId, v.groupId)
	end
end

function FormationGroupModel:getMatchTabIdByFmo(formationMO)
	if formationMO and not formationMO:isEmpty() then
		local pos = formationMO:GetPositions() or {}
		local preStr = table.concat(pos, "_")

		for i, group in ipairs(self.groups) do
			for j, tab in ipairs(group.presetsForm or {}) do
				if tab.simpleForm and tab.simpleForm.pos then
					local comStr = table.concat(tab.simpleForm.pos, "_")

					if preStr == comStr then
						return tab
					end
				end
			end
		end
	end

	return nil
end

function FormationGroupModel:getTabCount()
	local count = 0

	for i, group in ipairs(self.groups) do
		for j, tab in ipairs(group.presetsForm or {}) do
			count = count + 1
		end
	end

	return count
end

function FormationGroupModel:getOtherGroupList(tabId)
	local list = {}
	local tabInfo = self:getTabInfo(tabId)

	if tabInfo then
		local groupId = tabInfo.groupId

		for i, v in ipairs(self.groups) do
			if v.groupId ~= groupId then
				table.insert(list, v)
			end
		end
	end

	return list
end

function FormationGroupModel:getCurNewTabId()
	self._curNewTabId = -1

	return self._curNewTabId
end

function FormationGroupModel:getGroupCount()
	return #self.groups
end

function FormationGroupModel.checkIsInTeamByMo(petMo)
	if petMo and FormationGroupModel.instance:checkIsInTeam(petMo.petId) then
		return 1
	else
		return 0
	end
end

function FormationGroupModel:checkIsInTeam(petId)
	self._petInTeamMap = self._petInTeamMap or {}

	if self._lastTabId ~= self.curTabId or self._isChange then
		local tabInfo = self:getTabInfo(self.curTabId)

		if tabInfo then
			if not tabInfo.simpleForm then
				if not tabInfo.simpleForm.pos then
					local pos = {}

					self._petInTeamMap = {}

					for i, v in ipairs(pos) do
						if v > 0 then
							self._petInTeamMap[v] = true
						end
					end

					self._lastTabId = self.curTabId
					self._isChange = false
				end
			end
		end
	end

	return self._petInTeamMap[petId]
end

FormationGroupModel.instance = FormationGroupModel.New()

return FormationGroupModel
