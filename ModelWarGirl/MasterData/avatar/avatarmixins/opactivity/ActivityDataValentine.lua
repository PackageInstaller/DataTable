-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataValentine.lua

local ResOpActivityChatGameMisc = require("ClientData/ResOpActivityChatGameMisc")
local ResOpActivityChatGameFormula = require("ClientData/ResOpActivityChatGameFormula")
local ResOpActivityChatGamePlot = require("ClientData/ResOpActivityChatGamePlot")
local ResOpActivityChatGameSection = require("ClientData/ResOpActivityChatGameSection")
local ResOpActivityChatGameSectionConfig = require("ClientData/ResOpActivityChatGameSectionConfig")
local UserData = require("Helper/UserData")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ActivityDataValentine = Class("ActivityDataValentine", ActivityDataBase)

function ActivityDataValentine:ctor()
	self.serverData = {}
	self.clientData = {}
	self.hasGetItem = {}
end

function ActivityDataValentine:updateClientData(actId)
	self.actId = actId
	self.miscData = ResOpActivityChatGameMisc[actId] or {}
	self.formulaData = ResOpActivityChatGameFormula[actId] or {}

	local choclateItemList = {}

	for itemId, _ in pairs(self.formulaData) do
		table.insert(choclateItemList, itemId)
	end

	self.miscData.choclateItemList = choclateItemList
end

function ActivityDataValentine:updateRoleData(roleData)
	self.hasGetItem = {}
	self.nowLikeAbility = roleData.chat_game.likeability
	self.curBranch = roleData.chat_game.curbranch
	self.curNode = roleData.chat_game.curnode
	self.branch = roleData.chat_game.branch

	for _, info in ipairs(roleData.chat_game.gift_unlock) do
		self.hasGetItem[info.id] = true
	end
end

function ActivityDataValentine:checkChatNew()
	if self.curBranch and self.curBranch.result and self.curBranch.result > 0 and self.branch and #self.branch < 4 then
		return true
	end

	local function getSectionrogress(sectionId)
		local sectionDatas = UserData.getClientData(CurAvatar.uid .. "chat_section")

		if sectionDatas then
			local sectionData = sectionDatas[self.actObject.opId]

			if sectionData and sectionData[sectionId] then
				local curSectionDatas = ResOpActivityChatGameSection[self.actId][sectionId]

				if sectionData[sectionId] == #curSectionDatas then
					return false, true
				else
					return sectionData[sectionId] < #curSectionDatas
				end
			else
				return false, true
			end
		else
			return false, true
		end
	end

	local sectionConfigs = ResOpActivityChatGameSectionConfig[self.actId]
	local curLikeAbility = self.nowLikeAbility or 0

	if self.curNode and self.curNode > 0 then
		local plotDate = ResOpActivityChatGamePlot[self.actId][self.curNode]

		if not plotDate.section_id then
			local userDataSectionData = UserData.getClientData(CurAvatar.uid .. "chat_section_id") or {}

			if next(userDataSectionData) then
				local forgeId = self.actId .. plotDate.id

				if userDataSectionData[forgeId] and userDataSectionData[forgeId][1] then
					return false
				end
			end

			return true
		end

		if curLikeAbility >= sectionConfigs[plotDate.section_id].need_favorability then
			if plotDate.branch then
				return true
			end

			local isHaveResidue, isEnd = getSectionrogress(plotDate.section_id)

			if isEnd then
				local nextPlotDate = ResOpActivityChatGamePlot[self.actId][plotDate.next_id]

				if nextPlotDate then
					if nextPlotDate.branch then
						return true
					end

					if curLikeAbility >= sectionConfigs[nextPlotDate.section_id].need_favorability then
						return true
					end
				end
			else
				return isHaveResidue
			end
		end
	else
		local plotDate = ResOpActivityChatGamePlot[self.actId][1]

		if curLikeAbility >= sectionConfigs[plotDate.section_id].need_favorability then
			return true
		end
	end
end

function ActivityDataValentine:getHasGetGift()
	return self.hasGetItem
end

function ActivityDataValentine:checkNew()
	self:onGiftItemChanged()

	if self:checkMakeNew() then
		return true
	end

	if self:checkGiftNew() then
		return true
	end

	if self:checkChatNew() then
		return true
	end
end

function ActivityDataValentine:onGiftItemChanged()
	local activityValentineSendGiftDlg = UIManager.tryGetUI("activityValentineSendGiftDlg")

	if activityValentineSendGiftDlg and activityValentineSendGiftDlg.updateActivityData then
		activityValentineSendGiftDlg:updateActivityData()

		local activityValentineDlg = UIManager.tryGetUI("activityValentineDlg")

		if activityValentineDlg then
			activityValentineDlg:updateActivityData()
		end
	end
end

function ActivityDataValentine:checkMakeNew()
	if self:checkHandBookNew() then
		return true
	end

	if CurAvatar:getItemNumById(self.miscData.make_cost_id) >= self.miscData.make_cost_num then
		return true
	end
end

function ActivityDataValentine:checkGiftNew()
	for itemId, _ in pairs(self.formulaData) do
		if CurAvatar:getItemNumById(itemId) > 0 then
			return true
		end
	end
end

function ActivityDataValentine:checkHandBookNew()
	local clientActCachedData = CurAvatar:getClientActivityCachedData(self.actObject.opId)
	local handBookRecord = clientActCachedData.handBook or {}

	for itId, _ in pairs(self.hasGetItem) do
		if not handBookRecord[itId] then
			return true
		end
	end
end

function ActivityDataValentine:saveHandBookNew()
	local clientActCachedData = CurAvatar:getClientActivityCachedData(self.actObject.opId)
	local handBookRecord = clientActCachedData.handBook or {}

	for itId, _ in pairs(self.hasGetItem) do
		handBookRecord[itId] = 1
	end

	clientActCachedData.handBook = handBookRecord

	CurAvatar:saveClientActivityCachedData(self.actObject.opId, clientActCachedData)
	self.actObject:checkNew()

	local activityValentineDlg = UIManager.tryGetUI("activityValentineDlg")

	if activityValentineDlg then
		activityValentineDlg:onSaveHandBook()
	end

	local activityValentineMakeDlg = UIManager.tryGetUI("activityValentineMakeDlg")

	if activityValentineMakeDlg then
		activityValentineMakeDlg:onSaveHandBook()
	end
end

function ActivityDataValentine:onShareMakeMaterial(makeItem)
	if not self.sharePreTick or self.sharePreTick + self.miscData.share_time_limit <= ClientUtils.getServerTime() then
		self.sharePreTick = ClientUtils.getServerTime()

		RPC.opActChatGameFormulaShare(self.actObject.opId, makeItem)
		MsgManager.notice(Lang.get(1813))
		UIManager.getUI("chatDlg", true)
	else
		MsgManager.notice(string.format(Lang.get(65525), self.sharePreTick + self.miscData.share_time_limit - ClientUtils.getServerTime()))
	end
end

function ActivityDataValentine:checkHadEnd(resultId)
	if self.branch and next(self.branch) then
		for _, branchData in ipairs(self.branch) do
			if branchData.result == resultId then
				return true
			end
		end
	end
end

function ActivityDataValentine:isThisBranchOver(bId)
	local curNode = {}

	curNode[bId] = true

	for layer = 1, #ResOpActivityChatGamePlot[self.actId] do
		if next(curNode) then
			local layerNode = curNode

			curNode = {}

			for contentId, _ in pairs(layerNode) do
				local contentData = ResOpActivityChatGamePlot[self.actId][contentId] or {}

				if contentData.next_id then
					curNode[contentData.next_id] = true
				end

				if contentData.branch then
					for _, bInfo in ipairs(contentData.branch) do
						curNode[bInfo.id] = true
					end
				end

				if contentData.result and not self:checkHadEnd(contentData.result) then
					return false
				end
			end
		else
			break
		end
	end

	return true
end

function ActivityDataValentine:checkHadOneEnd(...)
	if self.branch and next(self.branch) then
		for _, branchData in ipairs(self.branch) do
			if branchData.result ~= 0 then
				return true
			end
		end
	end
end

return ActivityDataValentine
