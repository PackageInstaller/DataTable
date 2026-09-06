-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/controller/PetskinController.lua

module("logic.extensions.petskin.controller.PetskinController", package.seeall)

local PetskinController = class("PetskinController", BaseController)

PetskinController.SKIN_STATUS_NOT = -3
PetskinController.SKIN_STATUS_ORIGINAL = -2
PetskinController.SKIN_STATUS_HAD = -1
PetskinController.SKIN_STATUS_OUTDATE = 0
PetskinController.USER_POSTER_KEY = "user_poster_key"
PetskinController.SKIN_POSTER_MAP_KEY = "skin_poster_map_key"
PetskinController.ChangePetSkinBodyType = "PetskinController.ChangePetSkinBodyType"

function PetskinController:ctor()
	PetskinController.super.ctor(self)
end

function PetskinController:onReset()
	self.callBackList = {}
	self.callBackIdx = 0
	self.petSkinDisplayList = {}
	self.skins_pool = {}
	self.rcdPool = nil
	self._changeBodySkinId = nil
end

function PetskinController:onInit()
	PetSkinAgent.instance:addHandler(PetSkinAgent.PM_NotifySkinInfoChangedRes, self.onSkinInfoChange, self)
	self:onReset()
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.onRedPointChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self.onMatCountChange, self)
end

function PetskinController:onMatCountChange(mo)
	local type = mo:getMatType()
	local num = mo:GetCount()

	if type == MatType.PET_SKIN and num > 0 then
		local id = mo:getDefineId()

		self:addSkinRedPoint(id)
	end
end

function PetskinController:deleteSkinRedPoint(skinId)
	if RedPointModel.instance:isActive(RedPointModel.ID_PETSKIN_PRE .. skinId) then
		self.skins_pool[skinId .. ""] = 2

		self:updateSkinRedPoint()
	end
end

function PetskinController:addSkinRedPoint(skinId)
	if self.skins_pool[skinId .. ""] == nil then
		self.skins_pool[skinId .. ""] = 1
	end

	self:updateSkinRedPoint()
end

function PetskinController:updateSkinRedPoint()
	if self.rcdPool then
		for k, v in pairs(self.skins_pool) do
			if self.rcdPool[k] == nil or self.rcdPool[k] == 1 then
				self.rcdPool[k] = v
			end
		end

		local hasNewSkin = false

		for k, v in pairs(self.rcdPool) do
			local key = RedPointModel.ID_PETSKIN_PRE .. k

			if v == 1 then
				local id = checknumber(k)
				local raceId = PetSkinConfig.instance:getPetSkinRaceId(id)

				if BagModel.instance:isExistRaceId(raceId) then
					RedPointController.instance:setRedPointInfo(key, true)

					hasNewSkin = true
				end
			elseif v == 2 then
				RedPointController.instance:setRedPointInfo(key, false)
			end
		end

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETSKIN, hasNewSkin)

		local jsonStr = GameUtil.jsonToString(self.rcdPool)

		GameUtil.saveUserData(RedPointModel.ID_PETSKIN_PRE, jsonStr)
	end
end

function PetskinController:onRedPointChange(msg, status)
	GameUtil.getUserData(RedPointModel.ID_PETSKIN_PRE, function(str)
		local pool = GameUtil.jsonToTable(str)

		self.rcdPool = pool or {}

		self:updateSkinRedPoint()
	end)
end

function PetskinController:onSkinInfoChange(msg, status)
	local skinInfos = msg.skinInfos
	local deletedSkins = msg.deletedSkins

	PetskinModel.instance:addSkins(skinInfos)
	PetskinModel.instance:deletedSkins(deletedSkins)
end

function PetskinController:getCanShowPoster(skinId)
	return GameUtil.getUserData(PetskinController.USER_POSTER_KEY .. skinId) ~= 1
end

function PetskinController:setCanShowPoster(skinId, boo)
	if boo then
		GameUtil.saveUserData(PetskinController.USER_POSTER_KEY .. skinId, 0)
	else
		GameUtil.saveUserData(PetskinController.USER_POSTER_KEY .. skinId, 1)
	end
end

function PetskinController:saveSkinPosterId(skinId, posterId)
	GameUtil.saveUserData(PetskinController.SKIN_POSTER_MAP_KEY .. skinId, posterId)
end

function PetskinController:getPosterCfg(skinId)
	local posterId = GameUtil.getUserData(PetskinController.SKIN_POSTER_MAP_KEY .. skinId)

	if checknumber(posterId) > 0 then
		local cfg = PetSkinConfig.instance:getPosterModelCo(checknumber(posterId))

		if cfg then
			return cfg
		end
	end

	local list = PetSkinConfig.instance:getPosterList(skinId)

	if list then
		for i, cfg in ipairs(list) do
			local isHas = self:getPosterActive(cfg)

			if isHas then
				return cfg
			end
		end
	end

	return nil
end

function PetskinController:getPosterActive(cfg)
	local skinIds = cfg.skinId
	local isHas = true

	for j, skinId in ipairs(skinIds) do
		isHas = isHas and self:checkHasForeverSkinBySkinId(skinId)

		if isHas == false then
			break
		end
	end

	if isHas and not string.nilorempty(cfg.unlockItems) then
		local unlockItems = string.split(cfg.unlockItems, "#")

		for _, cfgStr in ipairs(unlockItems) do
			local matType, matId, matNum = MaterialMgr.getMatParams(cfgStr)

			isHas = isHas and matNum <= checknumber(MaterialModel.instance:getMaterialsNumber(matType, matId))

			if isHas == false then
				break
			end
		end
	end

	return isHas
end

function PetskinController:_onNewPet(mo)
	table.insert(self.petSkinDisplayList, mo)
end

function PetskinController:checkAndOpenDisplay()
	if self:checkHasNext() then
		self:onOpenDisplay()
	end
end

function PetskinController:checkHasNext()
	return self.petSkinDisplayList and #self.petSkinDisplayList > 0
end

function PetskinController:clearMo()
	self.petSkinDisplayList = {}
end

function PetskinController:getNextShowMo()
	if self:checkHasNext() then
		return (table.remove(self.petSkinDisplayList, 1))
	end
end

function PetskinController:getNextShowMoWithNoRemove()
	if self:checkHasNext() then
		return self.petSkinDisplayList[1]
	end
end

function PetskinController:onOpenDisplay()
	if ViewMgr.instance:isOpen(ViewName.PetskindisplayView) then
		return
	end

	if SceneMgr.instance.isGogingToEnterBattleScene then
		print("判断在战斗中 SceneMgr.instance.isGogingToEnterBattleScene=false  不弹【精灵】获得面板")

		return
	end

	if TaskFacade.instance:isTaskStepFinished(1, 2) then
		local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_Effect)

		if branch and not branch:isFinished() then
			print("判断在 新手引导 5神兽引导之前   不弹【精灵】获得面板")

			return
		end
	end

	ViewAutoShowController.instance:saveCurModalView()

	local mo = PetskinController.instance:getNextShowMoWithNoRemove()
	local skinId = checknumber(mo:getDefineId())
	local posterCfg = PetskinController:getPosterCfg(skinId)

	if (posterCfg or nil) and PetskinController.instance:getPosterActive(posterCfg) then
		UIStateManager.instance:push(ViewName.PetskinposterpopView, posterCfg.posterId, posterCfg.skinId, skinId)
	end

	UIStateManager.instance:push(ViewName.PetskindisplayView)
end

function PetskinController:rmCallbackByIdx()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_PET_HAIBAO)

	local mo = BagPetsController.instance:GetCurPetMo()
	local skinId = mo.curFaceId
	local list = PetSkinConfig.instance:getPosterList(skinId)

	if list and #list > 0 then
		local posterList = {}

		for i, posterCfg in ipairs(list) do
			table.insert(posterList, posterCfg.posterId)
		end

		local posterCfg = PetskinController.instance:getPosterCfg(skinId)

		if posterCfg then
			UIStateManager.instance:push(ViewName.PetskinposterView, posterCfg.posterId, posterList, skinId)
		elseif #posterList > 0 then
			UIStateManager.instance:push(ViewName.PetskinposterView, posterList[1], posterList, skinId)
		end
	end
end

function PetskinController:rmCallbackByIdx(idx)
	if idx and self.callBackList[idx] then
		self.callBackList[idx] = nil
	end
end

function PetskinController:callBackAll()
	for k, v in pairs(self.callBackList) do
		GameUtil.callBack(v)
	end

	self.callBackList = {}
end

function PetskinController:sendGetInfo(callBack, otherUserId)
	if otherUserId then
		self.callBackIdx = self.callBackIdx + 1
		self.callBackList[self.callBackIdx] = callBack

		PetSkinAgent.instance:sendPM_LoadAllPetSkinInfoReq(otherUserId, function(msg)
			PetskinModel.instance:initOtherUserSkin(msg)
			self:callBackAll()
			GlobalDispatcher:dispatch(GlobalNotify.PetSkinDataInited)
		end)

		return self.callBackIdx
	elseif PetskinModel.instance.isInited then
		GameUtil.callBack(callBack)
		GlobalDispatcher:dispatch(GlobalNotify.PetSkinDataInited)
	else
		self.callBackIdx = self.callBackIdx + 1
		self.callBackList[self.callBackIdx] = callBack

		PetSkinAgent.instance:sendPM_LoadAllPetSkinInfoReq(nil, function(msg)
			forcePrint("=====RoleDataRequestor:_loadPetSkinInfo===back")

			local skinInfos = msg.skinInfos

			PetskinModel.instance:init(skinInfos)
			self:callBackAll()
			GlobalDispatcher:dispatch(GlobalNotify.PetSkinDataInited)
		end)

		return self.callBackIdx
	end
end

function PetskinController:sendWearSkin(petId, skinId)
	PetSkinAgent.instance:sendPM_UsePetSkinReq(skinId, petId, function(msg)
		print(">>>>>>>>> 皮肤穿上了", petId, skinId)
	end)
end

function PetskinController:sendChangeBody(petId, bodyType)
	self._changeBodySkinId = petId

	PetSkinAgent.instance:sendPM_ChangePetSkinBodyTypeReq(petId, bodyType)
end

function PetskinController:changeBody(newSkinId)
	if self._changeBodySkinId then
		GlobalDispatcher:dispatch(PetskinController.ChangePetSkinBodyType, self._changeBodySkinId, newSkinId)

		self._changeBodySkinId = nil
	end
end

function PetskinController:getConditionDesc(cfg)
	local str = cfg.presentCondition

	if cfg.presentType == "talent" then
		return langPara("天赋等级达到%s", str)
	end

	return lang("无")
end

function PetskinController:checkHasForeverSkinBySkinId(skinId)
	local cfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, skinId)
	local status = PetskinController.instance:checkHasSkinStatus(cfg)

	return status == PetskinController.SKIN_STATUS_HAD or status == PetskinController.SKIN_STATUS_ORIGINAL
end

function PetskinController:checkIsOriginalSkinBySkinId(skinId)
	local cfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, skinId)

	return cfg.presentType == "original"
end

function PetskinController:checkHasSkinStatus(cfg)
	if PetSkinConfig.instance:isExistSkinGroup(cfg.skinId) then
		cfg = PetSkinConfig.instance:getMainSkinGroupCfgBySkinId(cfg.skinId)
	end

	if cfg.presentType == "original" then
		local raceId = cfg.raceId

		if HandbookModel.instance:isHasPet(raceId) then
			return PetskinController.SKIN_STATUS_ORIGINAL
		else
			return PetskinController.SKIN_STATUS_NOT
		end
	else
		local data = PetskinModel.instance:getSkinInfoById(cfg.skinId)

		if data then
			GameUtil.SetActive(self.tagBuy, true)

			if data:HasField("expireTimeMillis") then
				local time = checknumber(data.expireTimeMillis)

				time = time / 1000

				local now = ServerTime.now()
				local limit = math.max(0, time - now)

				if limit > 0 then
					return time
				else
					return PetskinController.SKIN_STATUS_OUTDATE
				end
			else
				return PetskinController.SKIN_STATUS_HAD
			end
		else
			if PetskinModel.instance:isForeverSkin(cfg.skinId) then
				return PetskinController.SKIN_STATUS_HAD
			end

			return PetskinController.SKIN_STATUS_NOT
		end
	end
end

function PetskinController:isClientNotShow(skinId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(checknumber(skinId))

	if skinCfg then
		local clientNotShow

		if skinCfg.clientNotShow then
			clientNotShow = skinCfg.clientNotShow
		elseif skinCfg.skinGroup > 0 then
			local groupSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinCfg.skinGroup)

			clientNotShow = groupSkinCfg.clientNotShow
		end

		if clientNotShow then
			local cochannelId = checknumber(LoginModel.instance:getCoChannelId())

			for _, v in ipairs(clientNotShow) do
				if v == cochannelId then
					return true
				end
			end
		end
	end

	return false
end

function PetskinController:isClientNotShowIfNotForever(skinId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	return not PetskinModel.instance:isForeverSkin((skinCfg and skinCfg.skinGroup > 0 or nil) and skinCfg.skinGroup) and self:isClientNotShow(skinId)
end

function PetskinController:isGainAllSkinWithSkinId(skinId)
	local skinList = PetSkinConfig.instance:getPetSkinListBySkinId(skinId) or {}
	local result = {}

	for i, v in ipairs(skinList) do
		if v.isHide <= 0 and not PetskinController.instance:isClientNotShowIfNotForever(v.skinId) then
			if string.nilorempty(v.showTime) then
				table.insert(result, v)
			else
				local time = GameUtil.string2time(v.showTime)

				if time <= ServerTime.now() then
					table.insert(result, v)
				end
			end
		end
	end

	local hasAll = true

	for i, v in ipairs(result) do
		local status = PetskinController.instance:checkHasSkinStatus(v)

		if status ~= PetskinController.SKIN_STATUS_HAD and status ~= PetskinController.SKIN_STATUS_ORIGINAL and status <= 0 then
			hasAll = false

			break
		end
	end

	return hasAll
end

PetskinController.instance = PetskinController.New()

return PetskinController
