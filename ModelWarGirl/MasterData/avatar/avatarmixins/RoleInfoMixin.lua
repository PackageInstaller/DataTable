-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\RoleInfoMixin.lua

local RoleInfo = require("UI/RoleInfo/RoleInfo")
local ResHero = require("ClientData/ResHero")
local ResCommonHardCode = require("ClientData/ResCommonHardCode")
local ResChatDynamicIcon = require("ClientData/ResChatDynamicIcon")
local ResRoleHead = require("ClientData/ResRoleHead")
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local UserData = require("Helper/UserData")
local LoginHelper = require("UI/Login/LoginHelper")
local PVPCommon = require("Logic/PVP/PVPCommon")
local EventConst = require("EventConst")
local SDKConst = require("SDK/SDKConst")
local SDKCore = require("SDK/SDKCore")
local RoleInfoMixin = {}

function RoleInfoMixin:initRoleInfoMixin(baseData, syncData)
	ClientUtils.record.roleInfoDic = ClientUtils.record.roleInfoDic or {}
	self.roleInfoDic = ClientUtils.record.roleInfoDic
	ClientUtils.record.roleSimpleInfoDic = ClientUtils.record.roleSimpleInfoDic or {}
	self.roleSimpleInfoDic = ClientUtils.record.roleSimpleInfoDic
	ClientUtils.record.roleSimplePowerInfoDic = ClientUtils.record.roleSimplePowerInfoDic or {}
	self.roleSimplePowerInfoDic = ClientUtils.record.roleSimplePowerInfoDic

	self:initMyRoleInfo()
	self:initRoleInfoData(baseData.necessary.misc)
	self:initDressData(syncData.other)
	self:initDynamicIcon(syncData.other.dynamic_expression)
	self:initNewEmojiData()
	self:initRoleConsigneeData(baseData.necessary.misc)
end

function RoleInfoMixin:postinitRoleInfoMixin(baseData, syncData)
	self:checkNewHead(nil)

	self.startRecordHeadFrame = true

	self:checkNewHeadFrame(nil)
	self:checkNewHeadPendant(nil)
	self:checkVowSignNew()
	self:initChatBubbleRed()
end

function RoleInfoMixin:initRoleConsigneeData(data)
	self.consigneeName = data.role_consignee.name
	self.consigneePhone = data.role_consignee.phone
	self.consigneeAddress = data.role_consignee.address
end

function RoleInfoMixin:initDressData(data)
	self.headIds = {}

	for _, info in ipairs(data.dress.head) do
		self.headIds[info.id] = true
	end

	self.headFrameIds = {}

	for _, info in ipairs(data.dress.head_frame) do
		self.headFrameIds[info.id] = {
			endTime = info.end_time,
			achiAward = info.collect_award
		}
	end

	self.headPendantIds = {}

	for _, info in ipairs(data.dress.head_pendant) do
		self.headPendantIds[info.id] = {
			endTime = info.end_time
		}
	end

	self.chatBubbleIds = {}

	for _, info in ipairs(data.dress.chat_bubble) do
		self.chatBubbleIds[info.id] = {
			endTime = info.end_time
		}
	end
end

function RoleInfoMixin:initRoleInfoData(data)
	self.nextChangeNameTime = data.next_rename_tick or 0
	self.nextChangeGenderTime = data.next_regender_tick or 0
	self.editedSignTimes = data.edit_signature_times or 0
	self.nextEditSignTime = (data.edit_signature_tick or 0) + Const.EDIT_SIGN_INTERVAL

	if not ClientUtils.isTickToday(data.edit_signature_tick or 0) then
		self.editedSignTimes = 0
	end

	ServerDownloadUtils.init()
	HeadHelper.init()

	if HeadHelper.isNeedLoginRefresh(Slot(self.refreshNameUI, self)) == true then
		-- block empty
	else
		self:refreshNameUI()
	end
end

function RoleInfoMixin:newDayRoleInfo(...)
	self.editedSignTimes = 0
end

function RoleInfoMixin:initDynamicIcon(data)
	local map = ClientUtils.getBitsDictFromByteString(data.item)

	self.dynamicIcons = {}

	for itemId, info in pairs(ResChatDynamicIcon) do
		if map[info.id] then
			self.dynamicIcons[itemId] = true
		end
	end
end

function RoleInfoMixin:onDynamicExpressionGetNotify(new_list)
	MsgManager.clientNotice(430)

	if self.dynamicIcons then
		for i, serverId in ipairs(new_list) do
			for id, info in pairs(ResChatDynamicIcon) do
				if serverId == info.id then
					if not self.dynamicIcons[id] then
						self.remindNewIconMap[info.item_id] = true
					end

					self.dynamicIcons[id] = true

					break
				end
			end
		end
	end

	self:saveRemindNewIcon()
	self:checkNewEmojiIconRedHint()
end

function RoleInfoMixin:checkNewEmojiIconRedHint(...)
	if next(self.remindNewIconMap) ~= nil then
		RedDotManager.setKeyState(UIConst.RD_HINT_CHAT_DYNAMIC_ICON_NEW, true)
	end
end

function RoleInfoMixin:initNewEmojiData(...)
	self.remindNewIconMap = {}

	local s = UserData.loadCommonData("newIcon" .. self.uid)

	if s and s ~= "" then
		local list = utils.splitString(s, ",")

		for _, sid in ipairs(list) do
			if sid ~= "" then
				self.remindNewIconMap[tonumber(sid)] = true
			end
		end
	end

	self:checkNewEmojiIconRedHint()
end

function RoleInfoMixin:saveRemindNewIcon(...)
	local s = ""

	if self.remindNewIconMap and next(self.remindNewIconMap) ~= nil then
		for id, _ in pairs(self.remindNewIconMap) do
			s = s .. id
		end
	end

	if s ~= "" then
		UserData.saveCommonData("newIcon" .. self.uid, s)
	else
		UserData.clearCommonData("newIcon" .. self.uid)
	end
end

local function sortHero(heroA, heroB)
	if heroA.star ~= heroB.star then
		return heroA.star > heroB.star
	elseif heroA.level ~= heroB.level then
		return heroA.level > heroB.level
	end

	return heroA.id < heroB.id
end

function RoleInfoMixin:refreshMyRoleInfoHeros(gid_list)
	local info = self.roleInfoDic[self.uid]

	if info then
		for i = #info.heros, 1, -1 do
			for _, gid in ipairs(gid_list) do
				if gid == info.heros[i].gid then
					table.remove(info.heros, i)

					break
				end
			end
		end

		if #info.heros == 0 then
			local heroGids = self:getNowFormation()
			local tempHeros = {}

			for gid, pos in pairs(heroGids) do
				local hero = self.heroDic[gid]

				if hero then
					table.insert(tempHeros, hero)
				end
			end

			info.heros = tempHeros

			self:initMyRoleInfo(true)
		end
	end
end

function RoleInfoMixin:refreshMyRoleInfoHerosFormationChange(heros, use_pos)
	if use_pos ~= Const.FORMATION_MAIN_STAGE then
		return
	end

	local info = self.roleInfoDic[self.uid]

	if info and not info.isEditHero then
		local _heros = {}

		for gid, _ in pairs(heros or {}) do
			table.insert(_heros, self.heroDic[gid])
		end

		table.sort(_heros, sortHero)

		info.heros = _heros
	end
end

function RoleInfoMixin:getMyCommInfo(...)
	return self:_refreshSelfRoleInfo()
end

local dicNames = {
	"roleInfoDic",
	"roleSimplePowerInfoDic",
	"roleSimpleInfoDic"
}

function RoleInfoMixin:onRoleCommGetResp(role_comm, personal, power, mask, signet, newVow)
	local _comm, _personal, _power, _signet, _vow, info
	local index = 1

	if mask == Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL then
		index = 1
	elseif mask == Const.ROLECOMM_GET_TPYE.SIMPLE_POWER then
		index = 2
	elseif mask == Const.ROLECOMM_GET_TPYE.SIMPLE then
		index = 3
	end

	for i, data in ipairs(role_comm) do
		_comm = role_comm[i] or {}
		_personal = personal[i]
		_power = power[i]
		_signet = signet[i] and signet[i].item or {}
		_vow = newVow[i] and newVow[i].vow
		info = nil

		for j = 1, #dicNames do
			local name = dicNames[j]

			if info == nil then
				info = self[name][_comm.uid]
			end

			if info then
				info:refreshData(_comm, _personal, _power, _vow, _signet)
			else
				info = RoleInfo(_comm, _personal, _power, _vow, _signet)
			end

			if index <= j then
				if not self[name][_comm.uid] then
					local count = utils.getTableElemCount(self[name], true)

					if count >= Const.ROLEINFO_CACHE_COUNT then
						utils.removeTableElements(self[name], math.floor(count * 0.25), Slot(self._sortForRoleInfos, self))
					end
				end

				self[name][_comm.uid] = info
			end
		end

		if _comm.uid then
			EventCenter.sendEvent(EventConst.UPDATE_PLAYER_INFO, _comm.uid)
		end
	end

	self.roleInfoReqMap = self.roleInfoReqMap or {}

	if self.roleInfoNoTip then
		self.roleInfoNoTip = false
	elseif next(self.roleInfoReqMap) ~= nil then
		local completeCbs = {}

		for cb, uids in pairs(self.roleInfoReqMap) do
			local infos = {}
			local total = #uids

			for i = #uids, 1, -1 do
				local info = self:getRoleInfoByUid(uids[i], mask)

				if info then
					table.insert(infos, info)
					table.remove(uids, i)
				end
			end

			if cb and #infos > 0 then
				cb(infos)
			end

			if total == #infos then
				table.insert(completeCbs, cb)
			end
		end

		for i, cb in ipairs(completeCbs) do
			self.roleInfoReqMap[cb] = nil
		end
	elseif mask == Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL then
		self:_showPlayerTips(info)
	end
end

function RoleInfoMixin:onRoleCommGetRespError()
	self.showPlayerTipsCb = nil
end

function RoleInfoMixin:refreshRoleInfo(comm, mask)
	if comm == nil then
		return
	end

	if mask == nil then
		mask = Const.ROLECOMM_GET_TPYE.SIMPLE
	end

	local isFind = false
	local indexs = self:_getRoleInfoNameIndexByMask(mask)

	for _, i in ipairs(indexs) do
		local name = dicNames[i]

		if self[name] and self[name][comm.uid] then
			isFind = true

			self[name][comm.uid]:refreshData(comm)
		end
	end

	if not isFind then
		local info = RoleInfo(comm)
		local name = dicNames[3]

		self[name][comm.uid] = info
	end
end

function RoleInfoMixin:getRoleInfoByUid(uid, mask)
	if mask == nil then
		mask = Const.ROLECOMM_GET_TPYE.SIMPLE
	end

	local indexs = self:_getRoleInfoNameIndexByMask(mask)

	for _, i in ipairs(indexs) do
		local name = dicNames[i]

		if self[name] and self[name][uid] then
			return self[name][uid]
		end
	end
end

function RoleInfoMixin:_getRoleInfoNameIndexByMask(mask)
	if mask == Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL then
		return {
			1
		}
	elseif mask == Const.ROLECOMM_GET_TPYE.SIMPLE_POWER then
		return {
			2
		}
	elseif mask == Const.ROLECOMM_GET_TPYE.SIMPLE then
		return {
			1,
			2,
			3
		}
	else
		return {
			1
		}
	end
end

function RoleInfoMixin:getRoleCommInfosNoTip(uids, stepRefreshCb)
	self:_getRoleInfosCheck(uids, Const.ROLECOMM_GET_TPYE.SIMPLE, stepRefreshCb)
end

function RoleInfoMixin:getRoleCommInfoPowersNoTip(uids, stepRefreshCb)
	self:_getRoleInfosCheck(uids, Const.ROLECOMM_GET_TPYE.SIMPLE_POWER, stepRefreshCb)
end

function RoleInfoMixin:_getRoleInfosCheck(uids, mask, stepRefreshCb)
	self.roleInfoReqMap = self.roleInfoReqMap or {}

	local needRequestUids = {}
	local infos = {}

	for _, uid in ipairs(uids) do
		local info = self:_isNoNeedRequest(uid, mask)

		if info == nil then
			table.insert(needRequestUids, uid)
		else
			table.insert(infos, info)
		end
	end

	if stepRefreshCb then
		if #infos > 0 then
			stepRefreshCb(infos)
		end

		if #infos ~= #uids then
			self.roleInfoReqMap[stepRefreshCb] = self.roleInfoReqMap[stepRefreshCb] or {}

			for i, uid in ipairs(needRequestUids) do
				table.insert(self.roleInfoReqMap[stepRefreshCb], uid)
			end

			while #needRequestUids > 0 do
				local uids = {}

				for j = 1, 15 do
					if #needRequestUids > 0 then
						table.insert(uids, needRequestUids[#needRequestUids])
						table.remove(needRequestUids, #needRequestUids)
					else
						break
					end
				end

				RPC.roleCommGet(uids, mask)
			end
		end
	elseif #needRequestUids > 0 then
		RPC.roleCommGet(needRequestUids, mask)
	end
end

function RoleInfoMixin:initMyRoleInfo(force)
	if not self.roleInfoDic[self.uid] or force then
		self.roleInfoNoTip = true

		RPC.roleCommGet({
			self.uid
		})
	end
end

function RoleInfoMixin:getMyRoleInfoHeros(...)
	local info = self.roleInfoDic[self.uid]

	if info and info.isEditHero then
		return info.heros
	end
end

function RoleInfoMixin:showPlayerTips(uid, orderCell, canEdit, robotType, cb)
	self.orderCell = orderCell
	self.canEdit = canEdit
	self.tipUid = uid
	self.showPlayerTipsCb = cb

	if utils.isRobot(uid) then
		local comm = PVPCommon.getRobotCommInfoByType(uid, robotType)
		local personal = PVPCommon.getRobotPersonalInfoByType(uid, robotType)

		self:_showPlayerTips(RoleInfo(comm, personal))
	elseif not self:_isNoNeedRequest(uid, Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL) then
		RPC.roleCommGet({
			uid
		}, Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL)
	else
		self:_showPlayerTips(self.roleInfoDic[uid])
	end
end

function RoleInfoMixin:applyGetRoleInfo(uid, needRpc)
	if self:_isNoNeedRequest(uid, Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL) then
		return self.roleInfoDic[uid]
	elseif needRpc then
		self.roleInfoNoTip = true

		RPC.roleCommGet({
			uid
		}, Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL)
	end
end

function RoleInfoMixin:_refreshSelfRoleInfo(...)
	local info = self.roleInfoDic[self.uid]

	info = info or {}
	info.commInfo = info.commInfo or {}

	local curData = self.mainStageCur

	info.stage = ClientUtils.getMainStageLevelStr(curData.season, curData.chapter, curData.level)
	info.commInfo.level = self:getLevel()
	info.commInfo.gender = self.gender
	info.commInfo.head = self.head
	info.commInfo.vip = self.vipLevel
	info.commInfo.vip_hide = self:getVipShowState()
	info.commInfo.headFrameId = self.headFrameId
	info.commInfo.head_frame_end_time = self:getHeadFrameEndTimeForInfo(self.headFrameId)
	info.commInfo.uid = self.uid
	info.commInfo.name = self.name

	if self.myCircle then
		info.commInfo.clangid = self.myCircle.gid
	end

	return info.commInfo
end

function RoleInfoMixin:getMyRoleSimpleComm()
	local info = {}

	info.level = self:getLevel()
	info.gender = self.gender
	info.head = self.head
	info.vip = self.vipLevel
	info.vip_hide = self:getVipShowState()
	info.headFrameId = self.headFrameId
	info.head_frame_end_time = self:getHeadFrameEndTimeForInfo(self.headFrameId)
	info.uid = self.uid

	if self.myCircle then
		info.clangid = self.myCircle.gid
	end

	info.name = self.serverFormatName

	return info
end

function RoleInfoMixin:getHeadFrameEndTimeForInfo(id)
	if not self.headFrameIds then
		return 1
	end

	local info = self.headFrameIds[id]

	if info then
		return info.endTime
	end

	return 1
end

function RoleInfoMixin:getHeadFrameEndTime(id)
	if not self.headFrameIds then
		return 0
	end

	local info = self.headFrameIds[id]

	if info then
		return info.endTime
	end

	return 0
end

function RoleInfoMixin:getHeadPendantEndTimeForInfo(id)
	if not self.headPendantIds then
		return 1
	end

	local info = self.headPendantIds[id]

	if info then
		return info.endTime
	end

	return 1
end

function RoleInfoMixin:getHeadPendantEndTime(id)
	if not self.headPendantIds then
		return 0
	end

	local info = self.headPendantIds[id]

	if info then
		return info.endTime
	end

	return 0
end

function RoleInfoMixin:refreshMyAttr(attrName, value)
	local role = self.roleInfoDic[self.uid]

	if role then
		role.commInfo[attrName] = value

		if attrName == "headFrameId" then
			role.commInfo.head_frame_end_time = self:getHeadFrameEndTimeForInfo(value)
		end

		if attrName == "headPendantId" then
			role.commInfo.head_pendant_end_time = self:getHeadPendantEndTimeForInfo(value)
		end
	end

	self[attrName] = value
end

function RoleInfoMixin:_sortForRoleInfos(v1, v2)
	if v1.commInfo.uid == self.uid then
		return false
	elseif v2.commInfo.uid == self.uid then
		return true
	else
		return v1.refreshTime < v2.refreshTime
	end
end

function RoleInfoMixin:_isNoNeedRequest(uid, mask)
	local indexs = self:_getRoleInfoNameIndexByMask(mask)

	for _, i in ipairs(indexs) do
		local name = dicNames[i]
		local info = self[name][uid]

		if info and os.time() - info.refreshTime < Const.ROLEINFO_REFRESH_INTERVAL then
			return info
		end
	end

	return nil
end

function RoleInfoMixin:_showPlayerTips(roleInfo)
	local cb = self.showPlayerTipsCb

	self.showPlayerTipsCb = nil

	if self.tipUid ~= roleInfo.uid then
		return
	end

	if roleInfo.uid == self.uid then
		self:_refreshSelfRoleInfo()
	end

	if self.canEdit and roleInfo.uid == self.uid then
		UIManager.getUI("roleInfoPersonalDlg"):setRoleInfo(roleInfo, self.orderCell)
	else
		UIManager.getUI("roleInfoOtherDlg"):setRoleInfo(roleInfo, self.orderCell)
	end

	if cb then
		cb()
	end
end

function RoleInfoMixin:onRoleCommEditFormationResp()
	MsgManager.clientNotice(240)

	local info = self.roleInfoDic[self.uid]

	if info then
		info.isEditHero = true
	end

	local ui = UIManager.getUI("mainMenu", nil, false)

	if ui then
		ui:onRefresh()
	end

	self:refreshRoleInfoUI()
end

local RESIGN_MSG_MAP = {
	[2] = Lang.get(1902),
	[5] = Lang.get(1903)
}

function RoleInfoMixin:onRoleCommEditSignatureResp(reason, hint)
	self.nextEditSignTime = ClientUtils.getServerTime() + Const.EDIT_SIGN_INTERVAL

	local ui = UIManager.tryGetUI("editSignDlg")

	if #hint > 0 and ui then
		ui:markInputIllegal(hint)
	end

	if reason == 0 then
		local role = self.roleInfoDic[self.uid]

		if role then
			role.signature = self.cacheSign
		end

		MsgManager.notice(Lang.get(1904))
		self:refreshRoleInfoUI()

		if ui then
			ui:setVisible(false)
		end

		self.editedSignTimes = self.editedSignTimes + 1
	else
		MsgManager.notice(self:getSignErrorMsg(reason))
	end
end

function RoleInfoMixin:getSignErrorMsg(reason)
	local hint = RESIGN_MSG_MAP[reason]

	if hint then
		return hint
	end

	return Lang.get(1889)
end

function RoleInfoMixin:onRoleCommChangeHeadResp()
	self:refreshMyAttr("head", self.cacheHeadId)
	SvrListManager.changedLvOrHeadId(nil, self.head)

	if HeadHelper.isCustomHead(self.head) then
		HeadHelper.getMyHeadTexture(true, function(...)
			local ui = UIManager.getUI("editHeadDlg", nil, false)

			if ui then
				ui:setCustomHeadSelectState()
			end

			self:refreshRoleInfoUI()
			self:refreshNameUI()
		end)
	else
		self:refreshRoleInfoUI()
		self:refreshNameUI()
	end

	if self.noNeedTipChangeHeadOk == true then
		self.noNeedTipChangeHeadOk = nil
	else
		MsgManager.notice(Lang.get(1905))
		LoginHelper.headBuriedPoint(false)
	end
end

function RoleInfoMixin:onRoleCommChangeHeadFrameResp()
	MsgManager.notice(Lang.get(1906))
	self:refreshMyAttr("headFrameId", self.cacheHeadFrameId)

	local ui = UIManager.getUI("editHeadDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	self:refreshRoleInfoUI()
	self:refreshNameUI()
end

function RoleInfoMixin:onRoleCommChangeHeadPendantResp()
	MsgManager.notice(Lang.get(66212))
	self:refreshMyAttr("headPendantId", self.cacheHeadPendantId)

	local ui = UIManager.getUI("editHeadDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RoleInfoMixin:onRoleRenameResp(resp_code, next_rename_tick, name, hint)
	self.serverFormatName = name
	name = utils.GetPlayerName(name, self.uid)

	local ui = UIManager.getUI("editNameDlg", nil, false)

	if #hint > 0 and ui then
		ui:markInputIllegal(hint)
	end

	self:sendByteLog(name)

	if resp_code == Const.RENAME_NO_ERROR then
		self:refreshMyAttr("name", name)
		self:refreshNameUI()
	else
		MsgManager.notice(self:getNameErrorMsg(resp_code))

		return
	end

	MsgManager.notice(Lang.get(1907))

	local dataUpdate = {}

	dataUpdate[SDKConst.AttName.ROLE_NAME] = name

	SDKCore.addUserData(dataUpdate)
	SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.RENAME)

	if ui then
		ui:setVisible(false)
	end

	self.nextChangeNameTime = next_rename_tick

	self:refreshRoleInfoUI()
end

function RoleInfoMixin:onRoleCommEditVowHeroResp()
	local roleInfoPersonalDlg = UIManager.tryGetUI("roleInfoPersonalDlg")

	if roleInfoPersonalDlg and roleInfoPersonalDlg.tabPanel then
		roleInfoPersonalDlg.tabPanel:refreshVowSing()
	end
end

function RoleInfoMixin:sendByteLog(name)
	if RegionUtils.isJP() then
		local Analytics = require("SDK/Analytics")
		local data = Analytics.getByteSendLogPubParameter()

		data.rename_type = 1
		data.original_name = self.name
		data.after_name = name

		Analytics.sendLogByted("rename_flow", ClientUtils.table2String(data))
	end
end

local RENAME_MSG_MAP = {
	[Const.RENAME_ERROR_DUPLICATE] = Lang.get(1883),
	[Const.RENAME_ERROR_INVALID_NAME] = Lang.get(1884),
	[Const.RENAME_ERROR_NOT_ENOUGH_ITEM] = Lang.get(1908),
	[Const.RENAME_ERROR_CD] = Lang.get(1909),
	[Const.RENAME_ERROR_NOT_ENOUGH_DIAMOND] = Lang.get(1910),
	[Const.RENAME_ERROR_INVALID_NAME_LENGTH] = Lang.get(1884),
	[Const.RENAME_ERROR_DIRTY_WORD] = Lang.get(1885),
	[Const.RENAME_ERROR_INVALIDUTF8] = Lang.get(1886),
	[Const.RENAME_ERROR_INVALIDRULE] = Lang.get(1887),
	[Const.RENAME_ERROR_INVALIDLANG] = Lang.get(1888)
}

if RegionUtils.isKR() then
	RENAME_MSG_MAP[Const.RENAME_ERROR_INVALIDLANG] = Lang.get(49883)
end

function RoleInfoMixin:getNameErrorMsg(resp_code)
	local hint = RENAME_MSG_MAP[resp_code]

	if hint then
		return hint
	end

	return Lang.get(1889)
end

function RoleInfoMixin:onRoleCommChangeGenderResp(next_change_tick)
	self.nextChangeGenderTime = next_change_tick

	local role = self.roleInfoDic[self.uid]

	if role then
		self.gender = role.commInfo.gender
	end

	MsgManager.notice(Lang.get(1911))
	self:refreshRoleInfoUI()
end

function RoleInfoMixin:refreshRoleInfoUIs(circle)
	local ui = UIManager.getUI("roleInfoOtherDlg", nil, false)

	if ui then
		ui:setCircleData(circle)
	end
end

function RoleInfoMixin:refreshRoleInfoUI(...)
	local ui = UIManager.getUI("roleInfoPersonalDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	ui = UIManager.getUI("editHeadDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RoleInfoMixin:onDressHeadGetNotify(id)
	MsgManager.notice(Lang.get(1912))

	self.headIds[id] = true

	self:checkNewHead(nil, id)
end

function RoleInfoMixin:onDressHeadFrameGetNotify(id, end_time)
	if self.headFrameIds[id] then
		MsgManager.notice(Lang.get(1913))
	else
		MsgManager.notice(Lang.get(1914))
		self:onCollectAchieveProgressNotify(Const.CRYSTAL_TYPE_HEADFRAME, id, 1, {})
	end

	self.headFrameIds[id] = {
		endTime = end_time
	}

	self:checkNewHeadFrame(id)
end

function RoleInfoMixin:onDressHeadFrameSetNotify(id)
	self:refreshMyAttr("headFrameId", id)
	self:refreshNameUI()
end

function RoleInfoMixin:onDressHeadPendantGetNotify(id, end_time)
	if self.headPendantIds[id] then
		MsgManager.notice(Lang.get(66213))
	else
		MsgManager.notice(Lang.get(66214))
	end

	self.headPendantIds[id] = {
		endTime = end_time
	}

	self:checkNewHeadPendant(id)
end

function RoleInfoMixin:onRoleMiscConsigneeResp(name, phone, address)
	self.consigneeName = name
	self.consigneePhone = phone
	self.consigneeAddress = address

	local gfPanel = UIManager.tryGetUI("giftExchangeDlg")

	if gfPanel then
		gfPanel:refreshAdressUI()
	end

	local editAdressDlg = UIManager.tryGetUI("editAdressDlg")

	if editAdressDlg then
		MsgManager.notice(Lang.get(30695))
		editAdressDlg:setVisible(false)
	end
end

function RoleInfoMixin:checkNewHead(heroList, headId)
	if self.newHeadRecord == nil then
		local saveInfo = UserData.loadCommonData(CurAvatar.uid .. "new_head")

		if saveInfo == nil then
			saveInfo = {}
		else
			saveInfo = utils.unserialize(saveInfo)
		end

		self.newHeadRecord = saveInfo
	end

	for _, svrData in ipairs(heroList or {}) do
		if not ResHero[svrData.resid] or self.handBookHeroDic[svrData.resid] then
			-- block empty
		else
			local id = self:_getHeadIdByHeroId(svrData.resid)

			if id then
				self.newHeadRecord[id] = os.time()
			end
		end
	end

	if headId then
		self.newHeadRecord[headId] = os.time()
	end

	for _, data in pairs(self.newHeadRecord) do
		if data ~= nil then
			RedDotManager.setKeyState(UIConst.RD_HINT_NEW_HEAD, true)

			break
		end
	end

	local info = utils.serialize(self.newHeadRecord)

	UserData.saveCommonData(CurAvatar.uid .. "new_head", info)
end

function RoleInfoMixin:_getHeadIdByHeroId(heroId)
	for id, info in pairs(ResRoleHead) do
		if info.heroid == heroId then
			return id
		end
	end
end

function RoleInfoMixin:setNewHeadState(key)
	self.newHeadRecord[key] = nil

	local find = false

	for _, data in pairs(self.newHeadRecord) do
		if data ~= nil then
			find = true

			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_HEAD, find)
end

function RoleInfoMixin:refreshNewHeadRecord(...)
	self.newHeadRecord = {}

	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_HEAD, false)
	UserData.saveCommonData(CurAvatar.uid .. "new_head", utils.serialize(self.newHeadRecord))
end

function RoleInfoMixin:checkNewHeadFrame(id)
	if not self.startRecordHeadFrame then
		return
	end

	if self.newHeadFrameRecord == nil then
		local saveInfo = UserData.loadCommonData(CurAvatar.uid .. "new_head_frame")

		if saveInfo == nil then
			saveInfo = {}
		else
			saveInfo = utils.unserialize(saveInfo)
		end

		self.newHeadFrameRecord = saveInfo
	end

	if id then
		self.newHeadFrameRecord[id] = os.time()
	end

	for _, data in pairs(self.newHeadFrameRecord) do
		if data ~= nil then
			RedDotManager.setKeyState(UIConst.RD_HINT_NEW_HEAD_FRAME, true)

			break
		end
	end

	local info = utils.serialize(self.newHeadFrameRecord)

	UserData.saveCommonData(CurAvatar.uid .. "new_head_frame", info)
end

function RoleInfoMixin:setNewHeadFrameState(key)
	self.newHeadFrameRecord[key] = nil

	local find = false

	for _, data in pairs(self.newHeadFrameRecord) do
		if data ~= nil then
			find = true

			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_HEAD_FRAME, find)
end

function RoleInfoMixin:refreshNewHeadFrameRecord(...)
	self.newHeadFrameRecord = {}

	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_HEAD_FRAME, false)
	UserData.saveCommonData(CurAvatar.uid .. "new_head_frame", utils.serialize(self.newHeadFrameRecord))
end

function RoleInfoMixin:checkNewHeadPendant(id)
	if self.newHeadPendantRecord == nil then
		local saveInfo = UserData.loadCommonData(CurAvatar.uid .. "new_head_pendant")

		if saveInfo == nil then
			saveInfo = {}
		else
			saveInfo = utils.unserialize(saveInfo)
		end

		self.newHeadPendantRecord = saveInfo
	end

	if id then
		self.newHeadPendantRecord[id] = os.time()
	end

	for _, data in pairs(self.newHeadPendantRecord) do
		if data ~= nil then
			RedDotManager.setKeyState(UIConst.RD_HINT_NEW_PENDANT, true)

			break
		end
	end

	local info = utils.serialize(self.newHeadPendantRecord)

	UserData.saveCommonData(CurAvatar.uid .. "new_head_pendant", info)
end

function RoleInfoMixin:setNewHeadPendantState(key)
	self.newHeadPendantRecord[key] = nil

	local find = false

	for _, data in pairs(self.newHeadPendantRecord) do
		if data ~= nil then
			find = true

			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_PENDANT, find)
end

function RoleInfoMixin:refreshNewHeadPendantRecord(...)
	self.newHeadPendantRecord = {}

	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_PENDANT, false)
	UserData.saveCommonData(CurAvatar.uid .. "new_head_pendant", utils.serialize(self.newHeadPendantRecord))
end

function RoleInfoMixin:checkVowSignNew()
	local isHadNew = UserData.loadCommonDataInt(CurAvatar.uid .. "new_vow_sign") == 1

	RedDotManager.setKeyState(UIConst.RD_HINT_SIGN, isHadNew)
end

function RoleInfoMixin:canRename(...)
	local result, desc = ClientUtils.isForbideModifyInfo()

	if result then
		MsgManager.notice(desc)

		return
	end

	if self:checkRoleInfoOpen() == false then
		return
	end

	local renameCD = ResCommonHardCode[30].value[1]
	local day = math.ceil(renameCD / 86400)
	local timeOffset = self.nextChangeNameTime - ClientUtils.getServerTime()

	if timeOffset > 0 then
		local content = utils.format(Lang.get(1900), day, ClientUtils.CeilToDayOrHour(timeOffset))

		MsgManager.notice(content)

		return false
	else
		UIManager.getUI("editNameDlg", true):setData(self.name)

		return true
	end
end

function RoleInfoMixin:canResex(...)
	local resexCD = ResCommonHardCode[38].value[1]
	local day = math.ceil(resexCD / 86400)
	local timeOffset = self.nextChangeGenderTime - ClientUtils.getServerTime()

	if timeOffset > 0 then
		return false, utils.format(Lang.get(1901), day, ClientUtils.CeilToDayOrHour(timeOffset))
	else
		return true
	end
end

function RoleInfoMixin:checkRoleInfoOpen(...)
	if not self:playerNameInited() then
		local desc = ConditionLimitManager.getLimitUnlockDesc(63)

		MsgManager.notice(desc)

		return false
	end

	return true
end

function RoleInfoMixin:getChatBubbleEndTime(id)
	local info = self.chatBubbleIds[id]

	if info then
		return info.endTime
	end

	return 0
end

function RoleInfoMixin:onDressChatBubbleGetNotify(id, end_time)
	if self.chatBubbleIds[id] then
		MsgManager.notice(Lang.get(107916))
	else
		MsgManager.notice(Lang.get(107917))
	end

	self.chatBubbleIds[id] = {
		endTime = end_time
	}

	self:addChatBubbleRed(id)
end

function RoleInfoMixin:onRoleCommChangeBubbleResp(id)
	MsgManager.clientNotice(799)

	self.chatBubbleId = id == 0 and Const.DEFAULT_CHAT_BUBBLE_ID or id

	local ui = UIManager.getUI("editHeadDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RoleInfoMixin:initChatBubbleRed()
	local key = CurAvatar.uid .. "new_chat_bubble_list"

	self.newChatBubbleRecord = UserData.loadCommonDataIntList(key)

	self:refreshChatBubbleRed()
end

function RoleInfoMixin:addChatBubbleRed(id)
	local idx = utils.getIndexByValue(self.newChatBubbleRecord, id)

	if idx <= 0 then
		table.insert(self.newChatBubbleRecord, id)

		local key = CurAvatar.uid .. "new_chat_bubble_list"

		UserData.saveCommonDataIntList(key, self.newChatBubbleRecord)
		self:refreshChatBubbleRed()
	end
end

function RoleInfoMixin:clearChatBubbleRed(id)
	if id == 0 then
		self.newChatBubbleRecord = {}
	else
		local idx = utils.getIndexByValue(self.newChatBubbleRecord, id)

		if idx > 0 then
			table.remove(self.newChatBubbleRecord, idx)
		end
	end

	local key = CurAvatar.uid .. "new_chat_bubble_list"

	if #self.newChatBubbleRecord > 0 then
		UserData.saveCommonDataIntList(key, self.newChatBubbleRecord)
	else
		UserData.clearCommonData(key)
	end

	self:refreshChatBubbleRed()
end

function RoleInfoMixin:refreshChatBubbleRed()
	local check = #self.newChatBubbleRecord > 0

	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_CHAT_BUBBLE, check)
end

return RoleInfoMixin
