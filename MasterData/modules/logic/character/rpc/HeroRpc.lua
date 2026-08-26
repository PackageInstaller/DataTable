-- chunkname: @modules/logic/character/rpc/HeroRpc.lua

module("modules.logic.character.rpc.HeroRpc", package.seeall)

local HeroRpc = class("HeroRpc", BaseRpc)

function HeroRpc:onInit()
	self:reInit()
end

function HeroRpc:reInit()
	self:set_onReceiveHeroGainPushOnce(nil, nil)
end

function HeroRpc:sendHeroInfoListRequest(callback, callbackObj)
	local req = HeroModule_pb.HeroInfoListRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroRpc:onReceiveHeroInfoListReply(resultCode, msg)
	if resultCode == 0 then
		HeroModel.instance:onGetHeroList(msg.heros)
		HeroModel.instance:onGetSkinList(msg.allHeroSkin)
		HeroModel.instance:setTouchHeadNumber(msg.touchCountLeft)
		SignInModel.instance:setHeroBirthdayInfos(msg.birthdayInfos)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroInfoListReply)
	end
end

function HeroRpc:sendHeroLevelUpRequest(heroid, expectlevel, callback, callbackObj)
	local req = HeroModule_pb.HeroLevelUpRequest()

	req.heroId = heroid
	req.expectLevel = expectlevel

	self:sendMsg(req, callback, callbackObj)
end

function HeroRpc:onReceiveHeroLevelUpReply(resultCode, msg)
	if resultCode == 0 then
		CharacterModel.instance:setFakeLevel()
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroLevelUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute)
	end
end

function HeroRpc:onReceiveHeroLevelUpUpdatePush(resultCode, msg)
	if resultCode == 0 then
		HeroModel.instance:setHeroLevel(msg.heroId, msg.newLevel)
		HeroModel.instance:setHeroRank(msg.heroId, msg.newRank)
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroLevelUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute)
	end
end

function HeroRpc:sendHeroRankUpRequest(heroid, callback, callbackObj)
	local req = HeroModule_pb.HeroRankUpRequest()

	req.heroId = heroid

	self:sendMsg(req, callback, callbackObj)
end

function HeroRpc:onReceiveHeroRankUpReply(resultCode, msg)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroRankUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)

		local param = {}

		param.heroId = msg.heroId
		param.newRank = msg.newRank
		param.isRank = true

		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, param)

		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) and msg.newRank == CharacterEnum.TalentRank then
			CharacterController.instance:stateTalent(msg.heroId)
		end
	end
end

function HeroRpc:onReceiveHeroSkinGainPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if not CharacterEnum.SkinOpen then
		return
	end

	local param = {}

	param.skinId = msg.skinId
	param.firstGain = msg.firstGain

	if not param.firstGain then
		self:_showTipsGainSkinRedundantly(msg.skinId)
	end

	HeroModel.instance:onGainSkinList(msg.skinId)

	if param.firstGain then
		HandbookController.instance:onGainHandbookSkin(msg.skinId)
	end

	if ItemApproachHelper.isTaskApproach(msg.getApproach) then
		TaskController.instance:getRewardByLine(msg.getApproach, ViewName.CharacterSkinGainView, param)
	elseif msg.getApproach == MaterialEnum.GetApproach.AutoChessRankReward then
		AutoChessController.instance:addPopupView(ViewName.CharacterSkinGainView, param)
	elseif msg.getApproach ~= MaterialEnum.GetApproach.NoviceStageReward then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainSkinView, ViewName.CharacterSkinGainView, param)
	else
		TaskModel.instance:setTaskNoviceStageHeroParam(param)
	end
end

function HeroRpc:_showTipsGainSkinRedundantly(skinId)
	local skinCO = lua_skin.configDict[skinId]
	local compensate = skinCO.compensate
	local extra = {
		skinCO.characterSkin,
		[2] = "",
		[3] = ""
	}
	local toastId = ToastEnum.GainSkinRedundantly

	if not string.nilorempty(compensate) then
		local numList = string.splitToNumber(compensate, "#")
		local materialType = numList[1]
		local materialId = numList[2]
		local quntity = numList[3]
		local itemCO = ItemConfig.instance:getItemConfig(materialType, materialId)

		extra[2] = itemCO.name
		extra[3] = quntity

		local icon = ResUrl.getCurrencyItemIcon(itemCO.icon)

		GameFacade.showIconToastWithTableParam(toastId, icon, extra)
	else
		GameFacade.showToastWithTableParam(toastId, extra)
	end
end

function HeroRpc:set_onReceiveHeroGainPushOnce(cb, cbObj)
	self._heroGainPushOnceCb = cb
	self._heroGainPushOnceCbObj = cbObj
end

function HeroRpc:onReceiveHeroGainPush(resultCode, msg)
	local onceCb = self._heroGainPushOnceCb

	if onceCb then
		local onceCbObj = self._heroGainPushOnceCbObj

		self:set_onReceiveHeroGainPushOnce(nil, nil)
		self._heroGainPushOnceCb(onceCbObj, resultCode, msg)

		return
	end

	if resultCode ~= 0 then
		self._onReceiveHeroGainPushMsg = nil

		return
	end

	self:_onReceiveHeroGainPush(msg)
end

function HeroRpc:_onReceiveHeroGainPush(msg)
	local param = {}

	param.heroId = msg.heroId
	param.duplicateCount = msg.duplicateCount or 0
	param.items = {}

	if msg.items then
		for i = 1, #msg.items do
			local _item = msg.items[i]
			local item = {
				materilType = _item.materilType,
				materilId = _item.materilId,
				quantity = _item.quantity
			}

			table.insert(param.items, item)
		end
	end

	local hideView = CharacterModel.instance:getGainHeroViewShowState()
	local hideNoNewView = CharacterModel.instance:getGainHeroViewShowNewState()

	param.hideToast = CharacterModel.instance:getGainHeroViewToastState()

	CharacterModel.instance:setGainHeroViewToastState(false)

	if not hideView then
		if hideNoNewView and msg.duplicateCount > 0 then
			return
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, param)
	end
end

function HeroRpc:sendHeroTalentUpRequest(heroid)
	local req = HeroModule_pb.HeroTalentUpRequest()

	req.heroId = heroid

	self:sendMsg(req)
end

function HeroRpc:onReceiveHeroTalentUpReply(resultCode, msg)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroTalentUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function HeroRpc:onReceiveHeroUpdatePush(resultCode, msg)
	if resultCode == 0 then
		HeroModel.instance:onSetHeroChange(msg.heroUpdates)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroUpdatePush)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroUpdatePushData, msg.heroUpdates)
	end
end

function HeroRpc:sendHeroUpgradeSkillRequest(heroid, skilltype, consume)
	local req = HeroModule_pb.HeroUpgradeSkillRequest()

	req.heroId = heroid
	req.type = skilltype
	req.consume = consume

	self:sendMsg(req)
end

function HeroRpc:onReceiveHeroUpgradeSkillReply(resultCode, msg)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroExSkillUp)
	end
end

function HeroRpc:sendItemUnlockRequest(heroId, itemId)
	local req = HeroModule_pb.ItemUnlockRequest()

	req.heroId = heroId
	req.itemId = itemId

	self:sendMsg(req)
end

function HeroRpc:onReceiveItemUnlockReply(resultCode, msg)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddUnlockItem, msg.heroId, msg.itemId)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddUnlockItemFail)
	end
end

function HeroRpc:sendUnMarkIsNewRequest(id)
	local req = HeroModule_pb.UnMarkIsNewRequest()

	req.heroId = id

	self:sendMsg(req)
end

function HeroRpc:onReceiveUnMarkIsNewReply(resultCode, msg)
	if resultCode == 0 then
		logNormal("更新角色" .. tostring(msg.heroId) .. tostring("新旧标记成功！"))
	end
end

function HeroRpc:sendUnlockVoiceRequest(heroId, voiceId)
	local req = HeroModule_pb.UnlockVoiceRequest()

	req.heroId = heroId
	req.voiceId = voiceId

	self:sendMsg(req)
end

function HeroRpc:onReceiveUnlockVoiceReply(resultCode, msg)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddVoice)
	end
end

function HeroRpc:sendUseSkinRequest(heroId, skinId)
	local req = HeroModule_pb.UseSkinRequest()

	req.heroId = heroId
	req.skinId = skinId

	self:sendMsg(req)
end

function HeroRpc:onReceiveUseSkinReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.successDressUpSkin, {
		heroId = msg.heroId,
		skinId = msg.skinId
	})
end

function HeroRpc:sendTouchHeadRequest(heroId, callback, callbackObj)
	local req = HeroModule_pb.HeroTouchRequest()

	req.heroId = heroId

	self:sendMsg(req, callback, callbackObj)
end

function HeroRpc:onReceiveHeroTouchReply(resultCode, msg)
	if resultCode == 0 then
		local touchCountLeft = msg.touchCountLeft
		local success = msg.success

		HeroModel.instance:setTouchHeadNumber(touchCountLeft)
		MainController.instance:dispatchEvent(MainEvent.OnReceiveAddFaithEvent, success)
	end
end

HeroRpc.CubePut = "putCubeInfo"
HeroRpc.CubeGet = "getCubeInfo"

function HeroRpc:PutTalentCubeRequest(heroId, action_type, cubeId, direction, posX, posY)
	local proto = HeroModule_pb.PutTalentCubeRequest()

	if action_type == HeroResonanceEnum.PutCube then
		if not HeroRpc.CubePut then
			local action_type = HeroRpc.CubeGet

			proto.heroId = heroId
			proto[action_type].cubeId = cubeId
			proto[action_type].direction = direction
			proto[action_type].posX = posX
			proto[action_type].posY = posY
			proto.templateId = HeroModel.instance:getCurTemplateId(heroId)

			self:sendMsg(proto)
		end
	end
end

function HeroRpc:onReceivePutTalentCubeReply(resultCode, recv_proto)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnPutTalentCubeReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function HeroRpc:RenameTalentTemplateRequest(heroId, templateId, name)
	local proto = HeroModule_pb.RenameTalentTemplateRequest()

	proto.heroId = heroId
	proto.templateId = templateId
	proto.name = name

	self:sendMsg(proto)
end

function HeroRpc:onReceiveRenameTalentTemplateReply(resultCode, recv_proto)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.RenameTalentTemplateReply)
	end
end

function HeroRpc:UseTalentTemplateRequest(heroId, templateId)
	local proto = HeroModule_pb.UseTalentTemplateRequest()

	proto.heroId = heroId
	proto.templateId = templateId

	self:sendMsg(proto)
end

function HeroRpc:onReceiveUseTalentTemplateReply(resultCode, recv_proto)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.UseTalentTemplateReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function HeroRpc:TakeoffAllTalentCubeRequest(heroId)
	local proto = HeroModule_pb.TakeoffAllTalentCubeRequest()

	proto.heroId = heroId
	proto.templateId = HeroModel.instance:getCurTemplateId(heroId)

	self:sendMsg(proto)
end

function HeroRpc:onReceiveTakeoffAllTalentCubeReply(resultCode, recv_proto)
	if resultCode == 0 then
		HeroModel.instance:takeoffAllTalentCube(recv_proto.heroId)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList, recv_proto.heroId)
	end
end

function HeroRpc:PutTalentSchemeRequest(heroId, talentId, talentMould, starMould)
	local proto = HeroModule_pb.PutTalentSchemeRequest()

	proto.heroId = heroId
	proto.talentId = talentId
	proto.talentMould = talentMould
	proto.starMould = starMould
	proto.templateId = HeroModel.instance:getCurTemplateId(heroId)

	self:sendMsg(proto)
end

function HeroRpc:setPutTalentCubeBatchRequest(heroId, putCubeInfo, templateId, style)
	local req = HeroModule_pb.PutTalentCubeBatchRequest()

	req.heroId = heroId
	req.templateId = templateId
	req.style = style

	for _, info in pairs(putCubeInfo) do
		local _info = req.putCubeInfo:add()

		_info.cubeId = info.cubeId
		_info.direction = info.direction
		_info.posX = info.posX
		_info.posY = info.posY
	end

	self:sendMsg(req)
end

function HeroRpc:onReceivePutTalentCubeBatchReply(resultCode, msg)
	if resultCode == 0 then
		HeroResonanceController.instance:dispatchEvent(HeroResonanceEvent.UseShareCode, msg)
	end
end

function HeroRpc:onReceivePutTalentSchemeReply(resultCode, recv_proto)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnPutTalentCubeReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function HeroRpc:setHeroDefaultEquipRequest(heroId, equipUid)
	local req = HeroModule_pb.HeroDefaultEquipRequest()

	req.heroId = heroId
	req.defaultEquipUid = equipUid

	self:sendMsg(req)

	local group_list = HeroGroupModel.instance:getList()
	local hero_uid = HeroModel.instance:getByHeroId(heroId).uid

	for i, group in ipairs(group_list) do
		local hero_list = group:_getHeroListBackup()

		for index, uid in ipairs(hero_list) do
			if uid == hero_uid then
				HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(group.groupId, index - 1, {
					equipUid
				})
			end
		end
	end
end

function HeroRpc:onReceiveHeroDefaultEquipReply(resultCode, msg)
	if resultCode == 0 then
		local uid = msg.defaultEquipUid

		CharacterController.instance:dispatchEvent(CharacterEvent.successSetDefaultEquip, uid)

		if msg.heroId == CharacterEnum.TwinssychubeHeroId then
			EquipModel.instance:refreshShowActivateDoubleTip()
		end
	end
end

function HeroRpc:setUnlockTalentStyleRequest(heroId, style)
	local req = HeroModule_pb.UnlockTalentStyleRequest()

	req.heroId = heroId
	req.style = style

	self:sendMsg(req)
end

function HeroRpc:onReceiveUnlockTalentStyleReply(resultCode, msg)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onUnlockTalentStyleReply, msg)
	end
end

function HeroRpc:setUseTalentStyleRequest(heroId, templateId, style)
	local req = HeroModule_pb.UseTalentStyleRequest()

	req.heroId = heroId
	req.templateId = templateId
	req.style = style

	self:sendMsg(req)
end

function HeroRpc:onReceiveUseTalentStyleReply(resultCode, msg)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onUseTalentStyleReply, msg)
	end
end

function HeroRpc:setTalentStyleReadRequest(heroId)
	local req = HeroModule_pb.TalentStyleReadRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function HeroRpc:onReceiveTalentStyleReadReply(resultCode, msg)
	if resultCode == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onTalentStyleRead, msg.heroId)
	end
end

function HeroRpc:setHeroTalentStyleStatRequest(heroId)
	local req = HeroModule_pb.HeroTalentStyleStatRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function HeroRpc:onReceiveHeroTalentStyleStatReply(resultCode, msg)
	if resultCode == 0 then
		TalentStyleModel.instance:setHeroTalentStyleStatInfo(msg)
		CharacterController.instance:dispatchEvent(CharacterEvent.onHeroTalentStyleStatReply, msg)
	end
end

function HeroRpc:setMarkHeroFavorRequest(heroId, isFavor)
	local req = HeroModule_pb.MarkHeroFavorRequest()

	req.heroId = heroId
	req.isFavor = isFavor

	self:sendMsg(req)
end

function HeroRpc:onReceiveMarkHeroFavorReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroModel.instance:setHeroFavorState(msg.heroId, msg.isFavor)

	if msg.isFavor then
		GameFacade.showToast(ToastEnum.HeroFavorMarked)
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.OnMarkFavorSuccess, msg.heroId)
end

function HeroRpc:setDestinyLevelUpRequest(heroId, level)
	local req = HeroModule_pb.DestinyLevelUpRequest()

	req.heroId = heroId
	req.level = level

	self:sendMsg(req)
end

function HeroRpc:onReceiveDestinyLevelUpReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterDestinyController.instance:onLevelUpReply(msg.heroId, msg.level)
end

function HeroRpc:setDestinyRankUpRequest(heroId)
	local req = HeroModule_pb.DestinyRankUpRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function HeroRpc:onReceiveDestinyRankUpReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterDestinyController.instance:onRankUpReply(msg.heroId)
end

function HeroRpc:setDestinyStoneUnlockRequest(heroId, stoneId)
	local req = HeroModule_pb.DestinyStoneUnlockRequest()

	req.heroId = heroId
	req.stoneId = stoneId

	self:sendMsg(req)
end

function HeroRpc:onReceiveDestinyStoneUnlockReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterDestinyController.instance:onUnlockStoneReply(msg.heroId, msg.stoneId)
end

function HeroRpc:setDestinyStoneUseRequest(heroId, stoneId)
	local req = HeroModule_pb.DestinyStoneUseRequest()

	req.heroId = heroId
	req.stoneId = stoneId

	self:sendMsg(req)
end

function HeroRpc:onReceiveDestinyStoneUseReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterDestinyController.instance:onUseStoneReply(msg.heroId, msg.stoneId)
end

function HeroRpc:setHeroRedDotReadRequest(heroId, redDotType)
	local req = HeroModule_pb.HeroRedDotReadRequest()

	req.heroId = heroId
	req.redDotType = redDotType

	self:sendMsg(req)
end

function HeroRpc:onReceiveHeroRedDotReadReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterDestinyController.instance:onHeroRedDotReadReply(msg.heroId, msg.redDot)
end

function HeroRpc:setChoiceHero3124TalentTreeRequest(heroId, subId, level)
	local req = HeroModule_pb.ChoiceHero3124TalentTreeRequest()

	req.heroId = heroId
	req.subId = subId
	req.level = level

	self:sendMsg(req)
end

function HeroRpc:onReceiveChoiceHero3124TalentTreeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.onChoiceHero3124TalentTreeReply, msg.extraStr)
	CharacterController.instance:dispatchEvent(CharacterEvent.onRefreshCharacterSkill)
end

function HeroRpc:setCancelHero3124TalentTreeRequest(heroId, subId, level)
	local req = HeroModule_pb.CancelHero3124TalentTreeRequest()

	req.heroId = heroId
	req.subId = subId
	req.level = level

	self:sendMsg(req)
end

function HeroRpc:onReceiveCancelHero3124TalentTreeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.onCancelHero3124TalentTreeReply, msg.extraStr)
	CharacterController.instance:dispatchEvent(CharacterEvent.onRefreshCharacterSkill)
end

function HeroRpc:setResetHero3124TalentTreeRequest(heroId)
	local req = HeroModule_pb.ResetHero3124TalentTreeRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function HeroRpc:onReceiveResetHero3124TalentTreeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.onResetHero3124TalentTreeReply, msg.extraStr)
	CharacterController.instance:dispatchEvent(CharacterEvent.onRefreshCharacterSkill)
end

function HeroRpc:setChoiceHero3123WeaponRequest(heroId, mainId, subId)
	local req = HeroModule_pb.ChoiceHero3123WeaponRequest()

	req.heroId = heroId
	req.mainId = mainId
	req.subId = subId

	self:sendMsg(req)
end

function HeroRpc:onReceiveChoiceHero3123WeaponReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.onChoiceHero3123WeaponReply, msg.heroId, msg.mainId, msg.subId)
	CharacterController.instance:dispatchEvent(CharacterEvent.onRefreshCharacterSkill)
end

function HeroRpc:onReceiveHeroTalentUpUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute)
end

HeroRpc.instance = HeroRpc.New()

return HeroRpc
