-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\SignetMixin.lua

local ResSignet = require("ClientData/ResSignet")
local ResSignetMisc = require("ClientData/ResSignetMisc")
local ResAchieve = require("ClientData/ResAchieve")
local UserData = require("Helper/UserData")
local SignetMixin = {}

function SignetMixin:initBaseSignetMixin()
	self.maxSelectSigentNum = 5
	UIConst.SIGNET_HORIZONTAL_FILTER_MAP = {
		{
			name = 0,
			text = Lang.get(370)
		}
	}
	self.sigentConfigGroup2IdListDic = {}
	self.signetConfigType2GroupListDic = {
		[0] = {}
	}

	local typeDic = {}
	local typeList = {}
	local groupDic = {}

	for id, config in pairs(ResSignet) do
		local type = config.type
		local group = config.group

		if not typeDic[type] then
			typeDic[type] = config.type_name

			table.insert(typeList, type)
		end

		self.sigentConfigGroup2IdListDic[group] = self.sigentConfigGroup2IdListDic[group] or {}

		table.insert(self.sigentConfigGroup2IdListDic[group], id)

		if not groupDic[group] then
			groupDic[group] = config.index

			local type = config.type

			self.signetConfigType2GroupListDic[type] = self.signetConfigType2GroupListDic[type] or {}

			table.insert(self.signetConfigType2GroupListDic[type], group)
			table.insert(self.signetConfigType2GroupListDic[0], group)
		end
	end

	table.sort(typeList)

	for _, type in ipairs(typeList) do
		table.insert(UIConst.SIGNET_HORIZONTAL_FILTER_MAP, {
			name = type,
			text = typeDic[type]
		})
	end

	for _, list in pairs(self.sigentConfigGroup2IdListDic) do
		table.sort(list)
	end

	for _, list in pairs(self.signetConfigType2GroupListDic) do
		table.sort(list, function(group1, group2)
			return groupDic[group1] < groupDic[group2]
		end)
	end

	self.newSignetGroupList = {}
	self.newSignetGroupDic = {}
end

function SignetMixin:initSignetMixin(baseData, syncData)
	self:loadNewSignetGroupList()

	self.signetIdList = {}
	self.signetDataDic = {}
	self.signetGroup2IdListDic = {}

	local signetData = syncData.other.signet

	if not signetData then
		return
	end

	local signetList = signetData.signet

	if signetList and #signetList > 0 then
		for _, signet in ipairs(signetList) do
			self:addSignetData(signet)
		end

		for k, v in pairs(self.signetGroup2IdListDic) do
			table.sort(v)
		end
	end
end

function SignetMixin:addSignetData(signet, checkNew)
	local id = signet.id
	local config = ResSignet[id]

	if config then
		table.insert(self.signetIdList, id)

		self.signetDataDic[id] = signet

		local group = config.group

		self.signetGroup2IdListDic[group] = self.signetGroup2IdListDic[group] or {}

		table.insert(self.signetGroup2IdListDic[group], id)

		if checkNew and not self.newSignetGroupDic[group] then
			self.newSignetGroupDic[group] = true

			table.insert(self.newSignetGroupList, group)
			self:saveNewSignetGroupList()
			self:refreshRedDot()
		end
	end
end

function SignetMixin:refreshRedDot()
	local check = self:checkSignetOpen()

	if check then
		check = false

		for _, group in pairs(self.newSignetGroupList) do
			if self:checkSignetGroupOpen(group) then
				check = true

				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_SIGNET, check)
end

function SignetMixin:lookSignetGroup(group)
	if self.newSignetGroupDic[group] then
		self.newSignetGroupDic[group] = nil

		for i = #self.newSignetGroupList, 1, -1 do
			if self.newSignetGroupList[i] == group then
				table.remove(self.newSignetGroupList, i)

				break
			end
		end

		self:saveNewSignetGroupList()
		self:refreshRedDot()
	end
end

function SignetMixin:checkSignetGroupRedDot(group)
	return self:checkSignetGroupOpen(group) and self.newSignetGroupDic[group] or false
end

function SignetMixin:checkSignetTypeRedDot(type)
	local groupList = self.signetConfigType2GroupListDic[type]

	if groupList and #groupList > 0 then
		for _, group in ipairs(groupList) do
			if self:checkSignetGroupRedDot(group) then
				return true
			end
		end
	end

	return false
end

function SignetMixin:saveNewSignetGroupList()
	UserData.saveCommonDataIntList(CurAvatar.uid .. "newSignetGroupList", self.newSignetGroupList)
end

function SignetMixin:loadNewSignetGroupList()
	self.newSignetGroupList = UserData.loadCommonDataIntList(CurAvatar.uid .. "newSignetGroupList", self.newSignetGroupList) or {}
	self.newSignetGroupDic = {}

	for _, group in ipairs(self.newSignetGroupList) do
		self.newSignetGroupDic[group] = true
	end

	self:refreshRedDot()
end

function SignetMixin:getSignetData(signetId)
	return self.signetDataDic[signetId]
end

function SignetMixin:getSignetConfigGroupListByType(type)
	local resList = {}
	local groupList = self.signetConfigType2GroupListDic[type] or {}

	for _, group in pairs(groupList) do
		local checkGroupOpen = self:checkSignetGroupOpen(group)

		if checkGroupOpen then
			table.insert(resList, group)
		end
	end

	return resList
end

function SignetMixin:getSignetConfigIdListByGroup(group)
	local resList = {}
	local idList = self.sigentConfigGroup2IdListDic[group] or {}

	for _, id in pairs(idList) do
		if self:checkSignetIdOpen(id) then
			table.insert(resList, id)
		end
	end

	return resList
end

function SignetMixin:checkSignetOpen()
	if not Const.SIGNET_OPEN then
		return false
	end

	for k, v in pairs(ResSignetMisc) do
		return not ConditionLimitManager.inLimitState(v.condition_id)
	end

	return true
end

function SignetMixin:getCurSignetNum()
	local num = 0

	if self.signetIdList then
		for _, signetId in pairs(self.signetIdList) do
			if self:checkSignetIdOpen(signetId) then
				num = num + 1
			end
		end
	end

	return num
end

function SignetMixin:getMaxSignetNum()
	local num = 0

	for id, _ in pairs(ResSignet) do
		if self:checkSignetIdOpen(id) then
			num = num + 1
		end
	end

	return num
end

function SignetMixin:getShowSignetIdByGroup(group)
	local id
	local checkHave = false
	local idList = self.signetGroup2IdListDic[group]

	if idList and #idList > 0 then
		id = idList[#idList]
		checkHave = true
	else
		local list = self.sigentConfigGroup2IdListDic[group]

		if list and #list > 0 then
			id = list[1]
		end
	end

	return id, checkHave
end

function SignetMixin:getSignetProcess(signetId, signetData)
	local checkData = signetData ~= nil
	local config = ResSignet[signetId]
	local achieveId = config.condition
	local progress, needProgress = CurAvatar:getAchieveProcess(achieveId)

	if checkData then
		progress = needProgress
	else
		local achieveConfig = ResAchieve[achieveId]

		if achieveConfig and achieveConfig.award_limit then
			local check = CurAvatar:checkActivityConditionLimit(achieveConfig.award_limit)

			if not check then
				progress = 0
			end
		end
	end

	return progress, needProgress
end

function SignetMixin:checkSignetIdOpen(signetId)
	local config = ResSignet[signetId]
	local checkOpen = not config.time_id or ClientUtils.isTimeConfigPassed(config.time_id)

	return checkOpen
end

function SignetMixin:checkSignetGroupOpen(group)
	local checkGroupOpen = false
	local idList = self.sigentConfigGroup2IdListDic[group] or {}

	for _, id in pairs(idList) do
		if self:checkSignetIdOpen(id) then
			checkGroupOpen = true

			break
		end
	end

	return checkGroupOpen
end

function SignetMixin:onSignetNotify(signetList)
	if signetList and signetList.signet then
		for _, signet in ipairs(signetList.signet) do
			self:addSignetData(signet, true)
		end

		for k, v in pairs(self.signetGroup2IdListDic) do
			table.sort(v)
		end
	end
end

function SignetMixin:onRoleCommEditSignetResp(signetIdList)
	local info = CurAvatar:getRoleInfoByUid(CurAvatar.uid, Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL)

	if info then
		info.signet = {}

		if signetIdList then
			for i = 1, #signetIdList do
				local id = signetIdList[i]
				local data = self.signetDataDic[id]

				if data then
					table.insert(info.signet, data)
				end
			end
		end

		local ui = UIManager.tryGetUI("roleInfoPersonalDlg")

		if ui then
			ui:onRoleCommEditSignetResp()
		end
	end
end

function SignetMixin:onRoleCommEditSignetRespError()
	local ui = UIManager.tryGetUI("roleInfoPersonalDlg")

	if ui then
		ui:onRoleCommEditSignetResp()
	end
end

return SignetMixin
