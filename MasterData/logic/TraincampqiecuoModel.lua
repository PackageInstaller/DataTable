-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/model/TraincampqiecuoModel.lua

module("logic.extensions.traincampqiecuo.view.TraincampqiecuoModel", package.seeall)

local TraincampqiecuoModel = class("TraincampqiecuoModel", BaseModel)

function TraincampqiecuoModel:ctor()
	return
end

function TraincampqiecuoModel:onInit()
	self:onReset()
end

function TraincampqiecuoModel:onReset()
	self._teamviews = nil
	self._pkRoomNewAddPlayers = {}
	self._pkSwitch = nil
	self._pkStranger = nil
	self._myForm = nil
	self._pets = {}
	self._defenseForm = nil
	self._defenseFormPet = nil
	self._pkRoomCommonAttrState = false
	self._myPVEForm = nil
	self._otherPVEForm = nil
	self._pkRoomReadyPlayerIds = {}
	self._invatingId = nil
	self._tempLeftheadInfo = nil

	self:getMyPVEFormation():ResetPosition()

	self._isInPkState = false

	self:clearBack2ReformUserIds()

	self._defenseFormExtParams = nil
end

function TraincampqiecuoModel:setTeamViews(teamviews)
	self._teamviews = teamviews
end

function TraincampqiecuoModel:getTeamViews()
	return self._teamviews
end

function TraincampqiecuoModel:setPkRoomData(msg)
	self._pkRoomData = msg
	self._pkRoomPlayerIds = msg.teamView.playerIds
	self._pkRoomCommonAttrState = msg.settings.fullPublicStrengthens

	for i, playerId in ipairs(msg.teamView.readyPlayerIds) do
		self:setReadyPlayerId(playerId)
	end

	self:_modReady()
	self:_saveNewAddPlayers(msg.teamView.newAddPlayers)
	self:_fliterNewAddPlayers(msg.teamView.playerIds)

	self._pkBack2ReformUserIds = GameUtil.pbToTable(msg.back2ReformUserIds)
end

function TraincampqiecuoModel:getPkRoomCommonAttrState()
	return self._pkRoomCommonAttrState
end

function TraincampqiecuoModel:_saveNewAddPlayers(newAddPlayers)
	for i, v in ipairs(newAddPlayers) do
		self._pkRoomNewAddPlayers[v.headInfo.userId] = v
	end
end

function TraincampqiecuoModel:_fliterNewAddPlayers(playerIds)
	local newPlayers = {}

	for i, userId in ipairs(playerIds) do
		local d = self._pkRoomNewAddPlayers[userId]

		if d then
			newPlayers[userId] = d
		end
	end

	self._pkRoomNewAddPlayers = newPlayers
end

function TraincampqiecuoModel:getPkRoomData()
	return self._pkRoomData
end

function TraincampqiecuoModel:getPkRoomPlayerIds()
	return self._pkRoomPlayerIds
end

function TraincampqiecuoModel:isMyRoom()
	return self._pkRoomPlayerIds and checknumber(self._pkRoomPlayerIds[1]) == checknumber(RoleModel.instance:getUserId())
end

function TraincampqiecuoModel:getPkRoomNewAddPlayers()
	return self._pkRoomNewAddPlayers
end

function TraincampqiecuoModel:getNewAddPlayerData(userId)
	return self._pkRoomNewAddPlayers[userId]
end

function TraincampqiecuoModel:teamChangeData(msg)
	self._pkRoomPlayerIds = msg.playerIds

	self:_modReady()
	self:_saveNewAddPlayers(msg.newAddPlayers)
	self:_fliterNewAddPlayers(msg.playerIds)
end

function TraincampqiecuoModel:clearReadyPlayerIds()
	self._pkRoomReadyPlayerIds = {}
end

function TraincampqiecuoModel:_modReady()
	local readys = {}

	for i, playerId in ipairs(self._pkRoomPlayerIds) do
		if self:isReady(playerId) then
			readys[playerId] = true
		end
	end

	self._pkRoomReadyPlayerIds = readys
end

function TraincampqiecuoModel:setReadyPlayerId(playerId, ready)
	if ready == nil then
		ready = true
	end

	self._pkRoomReadyPlayerIds[playerId] = ready
end

function TraincampqiecuoModel:isReady(playerId)
	return self._pkRoomReadyPlayerIds[playerId]
end

function TraincampqiecuoModel:setPkSwitch(all, stranger)
	self._pkSwitch = all
	self._pkStranger = stranger
end

function TraincampqiecuoModel:getPkSwitch()
	return self._pkSwitch, self._pkStranger
end

function TraincampqiecuoModel:getMyFormation()
	self._myForm = self._myForm or clone(FormationNewModel.instance:GetCurTeam():GetCurFormation())

	return self._myForm
end

function TraincampqiecuoModel:getPetMo(petId)
	if petId <= 0 then
		return nil
	end

	local petMo = self._pets[petId]

	if not petMo then
		local creepsCfg = TraincampqiecuoConfig.instance:getCreepsCfg(petId)
		local temp = FightingPowerPetMo.New()

		temp:fromChallengeCreepCo(creepsCfg)

		petMo = temp:toBaseBagPetMo()
		petMo = petMo:usePublicStrengths()
		self._pets[petId] = petMo
	end

	return petMo
end

function TraincampqiecuoModel:getPetList()
	if self._allPetList then
		return self._allPetList
	end

	self._allPetList = {}

	local creepsCfgs = TraincampqiecuoConfig.instance:getCreepsCfgs()
	local nowTime = ServerTime.now()
	local isOpen = false

	for i, v in ipairs(creepsCfgs) do
		isOpen = false

		if not string.nilorempty(v.openTime) then
			local time = GameUtil.string2time(v.openTime)

			if time <= nowTime then
				isOpen = true
			end
		else
			isOpen = true
		end

		if isOpen then
			local mo = self:getPetMo(v.creepsId)

			table.insert(self._allPetList, mo)
		end
	end

	return self._allPetList
end

function TraincampqiecuoModel:setDefenseForm(form, petSimple)
	self._defenseFormExtParams = nil

	if form then
		local list = {}
		local pool = {}

		for i, v in ipairs(petSimple) do
			local bagPet = BagPetMo.New()

			bagPet:initBaseView(v)
			table.insert(list, bagPet)

			pool[bagPet.petId] = bagPet
		end

		self._defenseFormPet = petSimple
		self._defenseForm = FormationMO.New(function(petId)
			return pool[petId]
		end)

		self._defenseForm:SetData(form)

		self._defenseFormExtParams = form.extParams
	else
		self._defenseForm = nil
		self._defenseFormPet = nil
	end
end

function TraincampqiecuoModel:getDefenseForm()
	return self._defenseForm
end

function TraincampqiecuoModel:getDefensePetSimple()
	return self._defenseFormPet
end

function TraincampqiecuoModel:getDefenseFormExtParams()
	return self._defenseFormExtParams or {}
end

function TraincampqiecuoModel:getMyUserHeadInfo()
	return self._myHeadInfo or RoleModel.instance:getHeadInfo()
end

function TraincampqiecuoModel:getOpUserHeadInfo()
	return self._opHeadInfo
end

function TraincampqiecuoModel:setHeadInfo(myheadInfo, opHeadInfo)
	self._myHeadInfo = myheadInfo
	self._opHeadInfo = opHeadInfo
end

function TraincampqiecuoModel:setOpHeadInfo(opHeadInfo)
	self._opHeadInfo = opHeadInfo
end

function TraincampqiecuoModel:setPkResult(state, attackVideo, defenseVideo, myPetLeftCount, opPetLeftCount, myForm, opForm, recordId)
	self._attackVideo = attackVideo
	self._pkResult = {
		state = state,
		attackVideo = attackVideo,
		defenseVideo = defenseVideo,
		myPetLeftCount = myPetLeftCount,
		opPetLeftCount = opPetLeftCount or 0,
		myForm = myForm,
		opForm = opForm,
		recordId = recordId
	}
end

function TraincampqiecuoModel:getPkResult()
	return self._pkResult
end

function TraincampqiecuoModel:getPkAttackVideo()
	if self._attackVideo then
		print("xxxxxxxxxxxxxxxxxx")

		local str = self._attackVideo:SerializeToString()
		local msgClone = BattleExtension_pb.PM_BattleResult()

		msgClone:ParseFromString(str)

		return msgClone
	end
end

function TraincampqiecuoModel:getMyPVEFormation()
	self._myPVEForm = self._myPVEForm or FormationMO.New(function(petId)
		return BagPetsController.instance:getPet(petId)
	end)

	return self._myPVEForm
end

function TraincampqiecuoModel:getOtherPVEFormation()
	self._otherPVEForm = self._otherPVEForm or FormationMO.New(function(petId)
		return self:getPetMo(petId)
	end)

	return self._otherPVEForm
end

function TraincampqiecuoModel:setPVEOpTeamType(type)
	self._pveOpTeamType = type
end

function TraincampqiecuoModel:getPVEOpTeamType()
	return self._pveOpTeamType
end

function TraincampqiecuoModel:isMyPVEOPTeamType()
	return self._pveOpTeamType == GameEnum.TrainQiecuoTeamOpType.My
end

function TraincampqiecuoModel:setNewRoundsGenRes(newroundsresult)
	self._newroundsresult = newroundsresult
end

function TraincampqiecuoModel:getNewRoundsGenRes()
	return self._newroundsresult
end

function TraincampqiecuoModel:setInvateParams(invateUsePublicAttr)
	self._invateUsePublicAttr = invateUsePublicAttr
end

function TraincampqiecuoModel:getInvateParams()
	return self._invateUsePublicAttr
end

function TraincampqiecuoModel:setInvatingId(playerId)
	self._invatingId = playerId
end

function TraincampqiecuoModel:clearInvateId()
	self._invatingId = nil
end

function TraincampqiecuoModel:getInvatingId()
	return self._invatingId
end

function TraincampqiecuoModel:setTempLeftHeadInfo(headInfo)
	self._tempLeftheadInfo = headInfo
end

function TraincampqiecuoModel:getTempLeftHeadInfo()
	return self._tempLeftheadInfo
end

function TraincampqiecuoModel:isInPk()
	return self._isInPkState
end

function TraincampqiecuoModel:setIsInPk(state)
	self._isInPkState = state
end

function TraincampqiecuoModel:back2Reform(playerId)
	self._pkBack2ReformUserIds = self._pkBack2ReformUserIds or {}

	table.insert(self._pkBack2ReformUserIds, playerId)
end

function TraincampqiecuoModel:isInBack2Reform(playerId)
	if not self._pkBack2ReformUserIds then
		return false
	end

	return table.indexof(self._pkBack2ReformUserIds, playerId)
end

function TraincampqiecuoModel:getBack2Reform()
	return self._pkBack2ReformUserIds
end

function TraincampqiecuoModel:clearBack2ReformUserIds()
	self._pkBack2ReformUserIds = nil
end

function TraincampqiecuoModel:getOtherPVELinkForm()
	local otherForm = self:getOtherPVEFormation()
	local opForm = FormationExtension_pb.PM_CustomizeLinkForm()

	otherForm:createFormPb(opForm.form)

	local summonPetId = otherForm:GetSummonPetId()
	local positions = otherForm:GetPositions()

	for i, creepsId in ipairs(positions) do
		if creepsId > 0 then
			local creepsCfg = TraincampqiecuoConfig.instance:getCreepsCfg(creepsId)
			local heavenAwakenSummonPetId = checknumber(creepsCfg.heavenAwakenSummonPetId)

			if heavenAwakenSummonPetId > 0 then
				opForm.form.extParams.heavenAwakenMasterId = creepsId
				opForm.form.extParams.heavenAwakenSummonPetId = heavenAwakenSummonPetId

				break
			end
		end
	end

	return opForm
end

TraincampqiecuoModel.instance = TraincampqiecuoModel.New()

return TraincampqiecuoModel
