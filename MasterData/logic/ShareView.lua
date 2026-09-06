-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/ShareView.lua

module("logic.extensions.share.view.ShareView", package.seeall)

local ShareView = class("ShareView", ViewComponent)

function ShareView:ctor()
	ShareView.super.ctor(self)
end

function ShareView:destroyUI()
	ShareView.super.destroyUI(self)
end

function ShareView:onExitFinished()
	ShareView.super.onExitFinished(self)
end

function ShareView:onEnterFinished()
	ShareView.super.onEnterFinished(self)
end

function ShareView:unbindEvents()
	ShareView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnZone:RemoveClickListener()
	self._btAll:RemoveClickListener()
	self._btnWorld:RemoveClickListener()
	self._btnFamily:RemoveClickListener()
	self._btnFriend:RemoveClickListener()
	self._btnShare:RemoveClickListener()
end

function ShareView:bindEvents()
	ShareView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btAll:AddClickListener(self._onClickAll, self)
	self._btnZone:AddClickListener(self._onClickZone, self)
	self._btnWorld:AddClickListener(self._onClickWorld, self)
	self._btnFamily:AddClickListener(self._onClickFamily, self)
	self._btnFriend:AddClickListener(self._onClickFriend, self)
	self._btnShare:AddClickListener(self._onClickShare, self)
end

function ShareView:onExit()
	ShareView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendSelected, self._onFriendSelected, self)
end

function ShareView:buildUI()
	ShareView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtContent")
	self._btnZone = self:getBtn("zone/btn")
	self._btAll = self:getBtn("all/btn")
	self._btnWorld = self:getBtn("world/btn")
	self._btnFamily = self:getBtn("family/btn")
	self._btnFriend = self:getBtn("friend/btn")
	self._imgZone = goutil.findChild(self.mainGO, "zone/myNum/imgIcon")
	self._txtZoneNum = goutil.findChildTextComponent(self.mainGO, "zone/myNum/txtNum")
	self._imgWorld = goutil.findChild(self.mainGO, "world/myNum/imgIcon")
	self._txtWorldNum = goutil.findChildTextComponent(self.mainGO, "world/myNum/txtNum")
	self._world = self:getGo("world")
	self._share = self:getGo("share")
	self._zone = self:getGo("zone")
	self._all = self:getGo("all")
	self._family = self:getGo("family")
	self._btnShare = self:getBtn("share/btn")
end

function ShareView:onEnter()
	ShareView.super.onEnter(self)

	local params = self:getOpenParam()
	local shareType = checknumber(params[1])

	self._shareType = shareType

	self._family:SetActive(true)
	self._world:SetActive(true)
	self._share:SetActive(false)

	if shareType == GameEnum.ShareType.Pet then
		self._msgType = GameEnum.ChatType.Pet

		local petId = checknumber(params[2])
		local petMo = BagModel.instance:getPet(petId)

		if petMo then
			self._txtTitle.text = "展示精灵"

			local cfg = ChatConfig.instance:getSystemMsgT(7)
			local content = cfg.template

			content = string.gsub(content, "{raceId}", petMo.name)
			content = string.gsub(content, "{rare}", ConstString.PetRareLang[petMo.rare])
			self._txtContent.text = content
			self._content = string.format("{\"tpId\":%s,\"params\":{\"raceId\":%s,\"petId\":%s,\"rare\":%s}}", 7, petMo.raceId, petMo.petId, petMo.rare)
		end
	elseif shareType == GameEnum.ShareType.Formation then
		self._msgType = GameEnum.ChatType.Form

		local tabId = checknumber(params[2])

		self._txtTitle.text = "展示阵型"

		local cfg = ChatConfig.instance:getSystemMsgT(8)

		self._txtContent.text = cfg.template
		self._content = string.format("{\"tpId\":%s,\"params\":{\"tabId\":%s}}", 8, tabId)
	elseif shareType == GameEnum.ShareType.ShareBoss then
		self._world:SetActive(false)
		self._share:SetActive(true)

		self._msgType = GameEnum.ChatType.Share

		local bossId = checknumber(params[2])
		local bossTypeId = checknumber(params[3])

		self._txtTitle.text = "求助"

		local cfg = ChatConfig.instance:getSystemMsgT(13)
		local content = cfg.template
		local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(bossTypeId)

		content = string.gsub(content, "{bossName}", (bossCfg or nil) and (bossCfg.name or ""))
		content = string.gsub(content, "{bossLv}", (bossCfg or nil) and (bossCfg.monsterLevel or 1))
		content = string.gsub(content, "点击前往>>", "")
		self._txtContent.text = content

		local name = "\"" .. bossCfg.name .. "\""

		self._content = string.format("{\"tpId\":%s,\"params\":{\"bossId\":%s,\"bossTypeId\":%s,\"bossLv\":%s,\"bossName\":%s}}", 13, bossId, bossTypeId, bossCfg.monsterLevel, name)
	elseif shareType == GameEnum.ShareType.SharePk then
		self._msgType = GameEnum.ChatType.System

		local userId = checknumber(params[2])
		local recordId = checknumber(params[3])
		local cfg = ChatConfig.instance:getSystemMsgT(params[4])
		local content = cfg.template

		content = string.gsub(content, "{userName}", params[5])
		content = string.gsub(content, "{score}", params[6])
		self._txtTitle.text = "战绩分享"
		self._txtContent.text = content
		self._content = string.format("{\"tpId\":%s,\"params\":{\"userName\":%s,\"score\":%s,\"userId\":%s,\"recordId\":%s}}", params[4], "\"" .. params[5] .. "\"", "\"" .. params[6] .. "\"", userId, recordId)
	elseif shareType == GameEnum.ShareType.Zoo then
		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "宠物分享"

		local animalMo = params[2]
		local cfg = ChatConfig.instance:getSystemMsgT(21)
		local content = cfg.template

		content = string.gsub(content, "{name}", animalMo.name)
		self._txtContent.text = content

		local contentNew = {
			tpId = 21,
			params = {
				Zoo = 1,
				id = animalMo.id,
				name = animalMo.name,
				race = animalMo.raceId,
				quality = animalMo.quality
			}
		}
		local json = require("cjson")

		self._content = json.encode(contentNew)
	elseif shareType == GameEnum.ShareType.PowerCheck then
		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = lang("战力检测分享")

		local obj = params[2]
		local tpId = 24
		local cfg = ChatConfig.instance:getSystemMsgT(tpId)
		local content = cfg.template

		content = string.gsub(content, "{petName}", obj.petName)
		content = string.gsub(content, "{zdl}", obj.zdl)
		content = string.gsub(content, "{overPercent}", obj.overPercent)
		self._txtContent.text = content

		local contentNew = {
			params = {
				petName = obj.petName,
				zdl = obj.zdl,
				overPercent = obj.overPercent
			},
			tpId = tpId
		}

		self._content = GameUtil.jsonToString(contentNew)
	elseif shareType == GameEnum.ShareType.ShareRecall then
		self._world:SetActive(false)
		self._share:SetActive(true)

		self._msgType = GameEnum.ChatType.Recall

		local taskId = checknumber(params[2])

		self._txtTitle.text = "任务邀请"

		local cfg = ChatConfig.instance:getSystemMsgT(25)
		local content = cfg.template
		local desc, str = RecallTaskModel.instance:getRecallTaskShare(taskId)

		content = string.gsub(content, "{taskName}", desc or "召唤任务")
		content = string.gsub(content, "{scoreCount}", str or "10积分")
		content = string.gsub(content, "点击前往>>", "")
		self._txtContent.text = content
		desc = "\"" .. desc .. "\""
		str = "\"" .. str .. "\""
		self._content = string.format("{\"tpId\":%s,\"params\":{\"taskId\":%s,\"taskName\":%s,\"scoreCount\":%s}}", 25, taskId, desc, str)
	elseif shareType == GameEnum.ShareType.ShareFood then
		self._world:SetActive(false)
		self._share:SetActive(true)

		self._msgType = GameEnum.ChatType.System

		local activityId = checknumber(params[2])
		local dishId = checknumber(params[3])

		self._txtTitle.text = lang("text_goddess_desc_28")

		local actCfg = GoddessDelicacyConfig.instance:getGoddessActivityCfg(activityId)
		local cfg = ChatConfig.instance:getSystemMsgT(actCfg.templateId)
		local content = cfg.template
		local name, peifang = GoddessDelicacyModel.instance:getShareFoodInfo(activityId, dishId, true)

		content = string.gsub(content, "{foodName}", name)
		content = string.gsub(content, "{foodFormula}", peifang)
		self._txtContent.text = content

		local str = tostring(1000 + dishId) .. tostring(activityId)

		self._content = string.format("{\"tpId\":%s,\"params\":{\"foodName\":%s,\"foodFormula\":%s}}", 29, str, str)
	elseif shareType == GameEnum.ShareType.ShareHonor then
		self._world:SetActive(false)
		self._share:SetActive(true)

		self._msgType = GameEnum.ChatType.Honor

		local familyId = checknumber(params[2])
		local wallId = checknumber(params[3])

		self._txtTitle.text = "勋章分享"

		local cfg = ChatConfig.instance:getSystemMsgT(32)

		self._txtContent.text = string.gsub(cfg.template, "，点击查看详情>>", "。")
		self._content = string.format("{\"tpId\":%s,\"params\":{\"familyId\":%s,\"wallId\":%s}}", 32, familyId, wallId)
	elseif shareType == GameEnum.ShareType.ShareFirePowerGame then
		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "火焰力量分享"

		local cfg = ChatConfig.instance:getSystemMsgT(33)
		local content = cfg.template

		content = string.gsub(content, "{score}", checknumber(params[2].score))
		content = string.gsub(content, "{winTimes}", checknumber(params[2].winTimes))
		self._txtContent.text = content

		local dataT = {
			tpId = 33,
			params = params[2]
		}

		self._content = GameUtil.jsonToString(dataT)
	elseif shareType == GameEnum.ShareType.BountyPKCompete then
		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "分享"

		local cfg = ChatConfig.instance:getSystemMsgT(43)

		self._txtContent.text = cfg.template

		local dataT = {
			tpId = 43,
			params = params[2]
		}

		self._content = GameUtil.jsonToString(dataT)
	elseif shareType == GameEnum.ShareType.FalLandlords then
		local tpId = 50

		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "分享"

		local cfg = ChatConfig.instance:getSystemMsgT(tpId)
		local content = cfg.template

		content = string.gsub(content, "{identity}", params[2].identity)
		content = string.gsub(content, "{landlordWin}", params[2].landlordWin)
		content = string.gsub(content, "{goldValue}", params[2].goldValue)
		self._txtContent.text = content

		local dataT = {
			tpId = tpId,
			params = params[2]
		}

		self._content = GameUtil.jsonToString(dataT)
	elseif shareType == GameEnum.ShareType.GoldendTen then
		local tpId = 60

		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "邀请"

		self._family:SetActive(false)
		self._world:SetActive(false)
		self._share:SetActive(true)

		local cfg = ChatConfig.instance:getSystemMsgT(tpId)
		local content = cfg.template

		content = string.gsub(content, "{gtactId}", lang("次元十周年"))
		content = string.gsub(content, "{code}", GoldendTenModel.instance:getCurCode(GoldendTenModel.instance:getCurActId()))
		self._txtContent.text = content

		local dataT = {
			tpId = tpId,
			params = {
				gtactId = GoldendTenModel.instance:getCurActId(),
				code = GoldendTenModel.instance:getCurCode(GoldendTenModel.instance:getCurActId())
			}
		}

		self._content = GameUtil.jsonToString(dataT)
	elseif shareType == GameEnum.ShareType.LotusBattle then
		local tpId = 62
		local shareData = params[2]

		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "排名分享"

		self._family:SetActive(true)
		self._world:SetActive(true)
		self._share:SetActive(false)

		local cfg = ChatConfig.instance:getSystemMsgT(tpId)
		local content = cfg.template

		content = string.gsub(content, "{rank}", tostring(shareData.rank))
		content = string.gsub(content, "{memberNum}", tostring(shareData.memberNum))
		self._txtContent.text = content

		local dataT = {
			tpId = tpId,
			params = shareData
		}

		self._content = GameUtil.jsonToString(dataT)
	elseif shareType == GameEnum.ShareType.MasterForm then
		local tpId = 64

		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "展示阵型"

		local cfg = ChatConfig.instance:getSystemMsgT(tpId)

		self._txtContent.text = cfg.template

		local dataT = {
			tpId = tpId,
			params = params[2]
		}

		self._content = GameUtil.jsonToString(dataT)
	elseif shareType == GameEnum.ShareType.Luyngarde then
		local tpId = 86

		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "求助"

		self._family:SetActive(true)
		self._share:SetActive(true)
		self._world:SetActive(false)

		local cfg = ChatConfig.instance:getSystemMsgT(tpId)
		local content = cfg.template
		local dataT = {
			tpId = tpId,
			params = params[2]
		}

		content = string.gsub(content, "{star}", tostring(params[2].star))
		content = string.gsub(content, "{typeId}", tostring(params[2].typeId))
		content = string.gsub(content, "{helpScore}", tostring(params[2].helpScore))
		self._txtContent.text = content
		self._content = GameUtil.jsonToString(dataT)
	elseif shareType == GameEnum.ShareType.LiYangKing then
		local tpId = 89

		self._msgType = GameEnum.ChatType.System
		self._txtTitle.text = "求助"

		self._family:SetActive(true)
		self._share:SetActive(true)
		self._world:SetActive(false)

		local cfg = ChatConfig.instance:getSystemMsgT(tpId) or {}
		local content = cfg.template
		local dataT = {
			tpId = tpId,
			params = params[2]
		}

		content = string.gsub(content, "{star}", tostring(params[2].star))
		content = string.gsub(content, "{typeId}", tostring(params[2].typeId))
		self._txtContent.text = content
		self._content = GameUtil.jsonToString(dataT)
	end

	self:_updateChannel(self._world, GameEnum.ChatChannel.World)
	self:_updateChannel(self._share, GameEnum.ChatChannel.Share)
	self:_updateChannel(self._zone, GameEnum.ChatChannel.Zone)
	self:_updateChannel(self._all, GameEnum.ChatChannel.All)
	GlobalDispatcher:addListener(GlobalNotify.FriendSelected, self._onFriendSelected, self)

	if shareType == GameEnum.ShareType.Luyngarde then
		self:_updateChannel(self._share, GameEnum.ChatChannel.Luyngarde)
	end

	if shareType == GameEnum.ShareType.LiYangKing then
		self:_updateChannel(self._share, GameEnum.ChatChannel.Share)
	end
end

function ShareView:_updateChannel(go, channel)
	local cfg = ChatConfig.instance:getSendCfg(channel)
	local imgIcon = goutil.findChild(go, "myNum/imgIcon")
	local txtNum = goutil.findChildTextComponent(go, "myNum/txtNum")
	local myNum = goutil.findChild(go, "myNum")

	if cfg and not GameUtil.isEmptyString(cfg.sendDecMaterial) then
		myNum:SetActive(true)

		local matType, matId, matNum = unpack(string.splitToNumber(cfg.sendDecMaterial, ":"))

		MaterialMgr.setIcon(imgIcon, matType, matId)

		txtNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)
	else
		myNum:SetActive(false)
	end
end

function ShareView:_onClickClose()
	self:close()
end

function ShareView:_onClickAll()
	local channel = GameEnum.ChatChannel.All

	self:_checkAndSend(channel)
end

function ShareView:_onClickZone()
	local channel = GameEnum.ChatChannel.Zone

	self:_checkAndSend(channel)
end

function ShareView:_onClickShare()
	local channel = GameEnum.ChatChannel.Share
	local params = self:getOpenParam()
	local shareType = checknumber(params[1])

	if shareType == GameEnum.ShareType.Luyngarde then
		channel = GameEnum.ChatChannel.Luyngarde
	elseif shareType == GameEnum.ShareType.LiYangKing then
		channel = GameEnum.ChatChannel.Share
	end

	self:_checkAndSend(channel)
end

function ShareView:_onClickWorld()
	local channel = GameEnum.ChatChannel.World

	self:_checkAndSend(channel)
end

function ShareView:_checkAndSend(channel)
	if (channel == GameEnum.ChatChannel.World or channel == GameEnum.ChatChannel.All) and NewChatModel.instance:getUsedWorldChatFreeTimes() < VipModel.instance:getFreeTimesOfChatOnWorld() then
		self:sendMsg(channel)

		return
	end

	local cfg = ChatConfig.instance:getSendCfg(channel)

	if cfg and not string.nilorempty(cfg.sendDecMaterial) then
		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.sendDecMaterial)

		if matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
			FloatWordMgr.instance:show(langPara("%s数量不够了，到商城补给一下吧！", MaterialMgr.getMaterialsName(matType, matId)))

			return
		end
	end

	self:sendMsg(channel)
end

function ShareView:_onClickFamily()
	if FamilyController.instance:checkFamilyOpen(true) then
		self:sendMsg(GameEnum.ChatChannel.League)
	end
end

function ShareView:_onClickFriend()
	UIStateManager.instance:open(ViewName.FriendSelect, self._shareType)
end

function ShareView:_onFriendSelected(friendIds)
	self._cacheFriendIds = friendIds

	ChatAgent.instance:sendBatchSendMsgToBuddyReq(GameEnum.ChatChannel.Private, self._msgType, self._content, self:getTop5FriendsIdsFromCache(), self._onBatchSendMsgToBuddyRes, self)
end

function ShareView:_onBatchSendMsgToBuddyRes()
	if #self._cacheFriendIds == 0 then
		self:_onShareSuccess()
	else
		ChatAgent.instance:sendBatchSendMsgToBuddyReq(GameEnum.ChatChannel.Private, self._msgType, self._content, self:getTop5FriendsIdsFromCache(), self._onBatchSendMsgToBuddyRes, self)
	end
end

function ShareView:getTop5FriendsIdsFromCache()
	local maxCount = FriendConfig.instance:getCommonValue("MAX_BATCH_SEND_TO_BUDDY_COUNT", true)

	print("maxCount = " .. maxCount)

	local len = math.min(maxCount, #self._cacheFriendIds)
	local t = {}

	for i = 1, len do
		table.insert(t, self._cacheFriendIds[1])
		table.remove(self._cacheFriendIds, 1)
	end

	return t
end

function ShareView:sendMsg(channel)
	ChatAgent.instance:sendSendMsgReq(channel, self._msgType, self._content, nil, nil, function()
		self:_onShareSuccess()
	end)
end

function ShareView:_onShareSuccess()
	FloatWordMgr.instance:show("发送成功")
	self:close()

	local behaviorId

	if self._shareType == GameEnum.ShareType.Pet then
		behaviorId = SurveyBehaviorID.CLICK_SEND_FRIEND_PET
	elseif self._shareType == GameEnum.ShareType.Formation then
		behaviorId = SurveyBehaviorID.CLICK_SEND_FRIEND_FORMAT
	end

	if behaviorId then
		SurveyController.instance:reportBehavior(behaviorId)
	end
end

return ShareView
