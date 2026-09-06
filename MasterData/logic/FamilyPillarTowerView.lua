-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyPillarTowerView.lua

module("logic.extensions.newfamily.view.war.FamilyPillarTowerView", package.seeall)

local FamilyPillarTowerView = class("FamilyPillarTowerView", ViewComponent)

function FamilyPillarTowerView:ctor()
	FamilyPillarTowerView.super.ctor(self)

	self._curBattleInfo = nil
	self._curPlayerView = nil
end

function FamilyPillarTowerView:bindEvents()
	FamilyPillarTowerView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "familypillartower")
	end, self)
	self._challengeBtn:AddClickListener(self._onClickChallengBtn, self)
end

function FamilyPillarTowerView:unbindEvents()
	FamilyPillarTowerView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._challengeBtn:RemoveClickListener()
end

function FamilyPillarTowerView:onExit()
	FamilyPillarTowerView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyWarPillarChanglleInfo, self._updataViewInfoShow, self)
	LightMgr.instance:setUseModelLight(false)
	WaitingView.instance:hide(self)
	removetimer(self._closeWatingView, self)
	self._modelCam.transform:SetParent(self.mainGO.transform)
	GlobalModel.instance:visibleSceneHUDs(true)
	LightMgr.instance:setLightForNormalScene()
	uGuiUtil.clearImage(self._rightProgGo)

	self._nowModel = RoleObjectPool.instance:removeRole(self._nowModel)
	self._upModel = RoleObjectPool.instance:removeRole(self._upModel)

	self:_removeAvatar()

	self._curBattleInfo = nil
	self._curPlayerView = nil
end

function FamilyPillarTowerView:destroyUI()
	FamilyPillarTowerView.super.destroyUI(self)
end

function FamilyPillarTowerView:_closeWatingView()
	removetimer(self._closeWatingView, self)
	WaitingView.instance:hide(self)
end

function FamilyPillarTowerView:buildUI()
	FamilyPillarTowerView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._uRoleGo = goutil.findChild(self._modelCam, "uRoleGo")
	self._nRoleGo = goutil.findChild(self._modelCam, "nRoleGo")

	local upItemGo = self:getGo("upItemGo")

	self._upRoleGo = goutil.findChild(upItemGo, "upRoleGo")
	self._uSprineGo = goutil.findChild(self._upRoleGo, "uSprineGo")
	self._uNameTxt = goutil.findChildTextComponent(self._upRoleGo, "uInfoGo/uNameTxt")
	self._upAwardGo = goutil.findChild(upItemGo, "upAwardGo")
	self._uGoodsList = {
		goutil.findChild(self._upAwardGo, "goodsItem_1"),
		goutil.findChild(self._upAwardGo, "goodsItem_2"),
		goutil.findChild(self._upAwardGo, "goodsItem_3"),
		goutil.findChild(self._upAwardGo, "goodsItem_4"),
		goutil.findChild(self._upAwardGo, "goodsItem_5"),
		goutil.findChild(self._upAwardGo, "goodsItem_6"),
		goutil.findChild(self._upAwardGo, "goodsItem_7"),
		goutil.findChild(self._upAwardGo, "goodsItem_8"),
		goutil.findChild(self._upAwardGo, "goodsItem_9"),
		goutil.findChild(self._upAwardGo, "goodsItem_10")
	}
	self._allPassGo = goutil.findChild(upItemGo, "allPassGo")

	local nowItemGo = self:getGo("nowItemGo")

	self._nSprineGo = goutil.findChild(nowItemGo, "nowRoleGo/nSprineGo")
	self._nPassGo = goutil.findChild(nowItemGo, "nowRoleGo/nPassGo")
	self._nNameTxt = goutil.findChildTextComponent(nowItemGo, "nowRoleGo/nInfoGo/nNameTxt")
	self._nBloodSid = goutil.findChildComponent(nowItemGo, "nowRoleGo/nInfoGo/nBloodSid", "Slider")
	self._nGoodsList = {
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_1"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_2"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_3"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_4"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_5"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_6"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_7"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_8"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_9"),
		goutil.findChild(nowItemGo, "nAwardGo/goodsItem_10")
	}
	self._nLevelTxt = goutil.findChildTextComponent(nowItemGo, "nLevelGo/nLevelTxt")
	self._rightProgGo = self:getGo("rightProgGo")
	self._progSid = goutil.findChildComponent(self._rightProgGo, "progSid", "Slider")
	self._levelTxt = goutil.findChildTextComponent(self._rightProgGo, "progSid/progInfoGo/levelTxt")
	self._headIma = goutil.findChild(self._rightProgGo, "progSid/progInfoGo/headIma"):GetComponent("UIImageSpriteChange")
	self._challengeBtn = self:getBtn("challengeBtn")
	self._maxTxt = goutil.findChildTextComponent(self._rightProgGo, "maxTxt")
	self._challengeTxt = goutil.findChildTextComponent(self.mainGO, "challengeGo/challengeTxt")
	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._viewNameTxt = goutil.findChildTextComponent(self.mainGO, "viewNameTxt")
end

function FamilyPillarTowerView:onEnter()
	FamilyPillarTowerView.super.onEnter(self)
	LightMgr.instance:setUseModelLight(true)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	WaitingView.instance:show(nil, self)
	settimer(0.5, self._closeWatingView, self, false)
	GlobalModel.instance:visibleSceneHUDs(false)

	self._params = self:getFirstParam()

	if self._params == nil or checknumber(self._params.planId) <= 0 then
		printError("sr---家族战  FamilyPillarTowerView:onEnter()   未传入参数！！")

		return
	end

	self._modelCam.transform:SetParent(nil)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyWarPillarChanglleInfo, self._updataViewInfoShow, self)
	self:_startInitViewShow()
	self:_updataViewInfoShow()
	FamilyWarController.instance:csRequestFamilyBattleGetDivinePillarChanglleInfoReq(self._params.familyId)
end

function FamilyPillarTowerView:_startInitViewShow()
	local baseInfo = FamilyWarModel.instance:getFamilyWarBaseInfo()

	self._isMyPillar = self._params.familyId == baseInfo.myFamilyId

	GameUtil.SetActive(self._challengeBtn, not self._isMyPillar)

	self._maxCount = checknumber(FamilyWarConfig.instance:getFamilyWarCommonParam("DIVINE_PILLAR_TIER_NUM"))
	self._maxTxt.text = "第" .. self._maxCount .. "层"
	self._progSid.value = 0
	self._levelTxt.text = "当前：1层"
	self._allAttack = checknumber(FamilyWarConfig.instance:getFamilyWarCommonParam("DIVINE_PILLAR_ATTACK_TIMES_LIMIT"))
	self._useAttack = baseInfo.pillarAttackTimes
	self._challengeTxt.text = string.format("剩余挑战次数：%s/%s", self._allAttack - self._useAttack, self._allAttack)

	local cfg = FamilyWarConfig.instance:getFamilyPillarInfoCfgs(self._params.curIndex)

	if cfg then
		local path = string.format("ui/bigbg/familynesttower/%s.png", cfg.bigIcon or "board_llzz_10")

		uGuiUtil.setSpriteToImage(self._rightProgGo, uGuiUtil.SpriteType.BigBg, path)

		if cfg then
			self._viewNameTxt.text = cfg.name or "神柱之塔"
		end
	end
end

function FamilyPillarTowerView:_updataViewInfoShow(data)
	local curTier = 1
	local challengeInfos = {}

	self._curPlayerView = {}

	local num = 0

	if data and data.challengeInfos then
		self._curPlayerView = data.curTierPlayerView
		curTier = checknumber(data.targetFamilyCurTier)
		challengeInfos = data.challengeInfos
		num = checknumber(data.targetFamilyIconId)
	end

	self._isAllPass = curTier > self._maxCount
	self._nowCount = math.min(curTier, self._maxCount)

	local isShowUp = false

	for i = 1, #challengeInfos do
		if challengeInfos[i] and challengeInfos[i].tier then
			if checknumber(challengeInfos[i].tier) == self._nowCount then
				self:_updataShowNowItemInfo(challengeInfos[i])
			elseif checknumber(challengeInfos[i].tier) == self._nowCount + 1 then
				isShowUp = true

				self:_updataShowUpItemInfo(challengeInfos[i])
			end
		end
	end

	if not isShowUp then
		self:_updataShowUpItemInfo()
	end

	self._headIma:SetState(num)

	if self._isMyPillar or self._isAllPass then
		GameUtil.SetActive(self._challengeBtn, false)
	else
		GameUtil.SetActive(self._challengeBtn, true)
	end

	self._progSid.value = self._nowCount / self._maxCount
	self._levelTxt.text = string.format("当前：%s层", self._nowCount)
end

function FamilyPillarTowerView:_updataShowNowItemInfo(info)
	self._curBattleInfo = info
	self._nowModel = RoleObjectPool.instance:removeRole(self._nowModel)

	for _, item in pairs(self._nGoodsList or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	GameUtil.SetActive(self._nPassGo, self._isAllPass)

	self._nBloodSid.value = checknumber(info.surplusHp) / checknumber(info.maxHp)
	self._nLevelTxt.text = string.format("第%s关", info.tier)

	local cp, pp = FamilyWarConfig.instance:getFamilyPillarLayersAwards(self._params.planId, info.tier)

	if cp and #cp > 0 then
		for i = 1, #cp do
			if not string.nilorempty(cp[i]) and self._nGoodsList[i] then
				MaterialMgr.setCellByCfg(cp[i], self._nGoodsList[i])
			end
		end
	end

	if pp and #pp > 0 then
		for i = 1, #pp do
			if not string.nilorempty(pp[i]) and self._nGoodsList[i + 5] then
				MaterialMgr.setCellByCfg(pp[i], self._nGoodsList[i + 5])
			end
		end
	end

	if checknumber(info.userId) <= 0 then
		if self._nowAvatar then
			self._nowAvatar:setVisible(false)
		end

		local pillarCfg = FamilyWarConfig.instance:getFamilyPillarLayersCfgs(self._params.planId, info.tier)

		if pillarCfg then
			self._nNameTxt.text = pillarCfg.name or "守阵怪"
		end

		if pillarCfg then
			if not pillarCfg.faceId then
				local faceId = 10050
				local offset = CharactorFacade.instance:getFamilyWarUIPosAndScale(faceId)
				local x, y, scale = 0, 0, 1

				if offset then
					x = checknumber(offset[1])
					y = checknumber(offset[2])
					scale = offset[3] or 1
				end

				scale = scale * 0.3
				self._nowModel = RoleObjectPool.instance:addRoleToParent(self._nowModel, faceId, self._nSprineGo, scale, nil, false, x, y)

				return
			end
		end
	end

	self._nNameTxt.text = info.name

	if self._nowAvatar == nil then
		self._nowAvatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)
		self._nowAvatar.useType = AvatarUseType.Scene

		self._nowAvatar:setParent(self._nRoleGo.transform)
		self._nowAvatar:setLayer(SceneLayer.UI3D_Value)
		self._nowAvatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end

	local avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(info.gender, info.clothes)

	self._nowAvatar:updateByMo(avatarMo)
end

function FamilyPillarTowerView:_updataShowUpItemInfo(info)
	self._upModel = RoleObjectPool.instance:removeRole(self._upModel)

	for _, item in pairs(self._uGoodsList or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	if info == nil or info.userId == nil then
		if self._upAvatar then
			self._upAvatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
			AvatarsMgrNew.instance:removeAvatar(self._upAvatar)

			self._upAvatar = nil
		end

		GameUtil.SetActive(self._upRoleGo, false)
		GameUtil.SetActive(self._upAwardGo, false)
		GameUtil.SetActive(self._allPassGo, true)

		return
	end

	GameUtil.SetActive(self._allPassGo, false)
	GameUtil.SetActive(self._upRoleGo, true)
	GameUtil.SetActive(self._upAwardGo, true)

	local cp, pp = FamilyWarConfig.instance:getFamilyPillarLayersAwards(self._params.planId, info.tier)

	if cp and #cp > 0 then
		for i = 1, #cp do
			if not string.nilorempty(cp[i]) and self._uGoodsList[i] then
				MaterialMgr.setCellByCfg(cp[i], self._uGoodsList[i])
			end
		end
	end

	if pp and #pp > 0 then
		for i = 1, #pp do
			if not string.nilorempty(pp[i]) and self._uGoodsList[i + 5] then
				MaterialMgr.setCellByCfg(pp[i], self._uGoodsList[i + 5])
			end
		end
	end

	if checknumber(info.userId) <= 0 then
		if self._upAvatar then
			self._upAvatar:setVisible(false)
		end

		local pillarCfg = FamilyWarConfig.instance:getFamilyPillarLayersCfgs(self._params.planId, info.tier)

		if pillarCfg then
			self._uNameTxt.text = pillarCfg.name or "守阵怪"
		end

		if pillarCfg then
			if not pillarCfg.faceId then
				local faceId = 10050
				local offset = CharactorFacade.instance:getFamilyWarUIPosAndScale(faceId)
				local x, y, scale = 0, 0, 1

				if offset then
					x = checknumber(offset[1])
					y = checknumber(offset[2])
					scale = offset[3] or 1
				end

				scale = scale * 0.3
				self._upModel = RoleObjectPool.instance:addRoleToParent(self._upModel, faceId, self._uSprineGo, scale, nil, false, x, y)

				return
			end
		end
	end

	self._uNameTxt.text = info.name

	if self._upAvatar == nil then
		self._upAvatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)
		self._upAvatar.useType = AvatarUseType.UI

		self._upAvatar:setParent(self._uRoleGo.transform)
		self._upAvatar:setLayer(SceneLayer.UI3D_Value)
		self._upAvatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end

	local avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(info.gender, info.clothes)

	self._upAvatar:updateByMo(avatarMo)
end

function FamilyPillarTowerView:_showAnimalAvatar(imaGo, mo, camY, camsize)
	local animalShow = AvatarPhotoShow.Get(imaGo)

	animalShow:setRawWidthAndHeight(512, 512)

	local avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	avatar.useType = AvatarUseType.UI

	animalShow:addShowAvatarEffect(avatar, true, function(avatarPhotoShow)
		Framework.TransformUtil.SetLocalPos(avatarPhotoShow._photoEffect._photo.producer.rtCamera.transform.parent, 0, 10, 0)
	end)
	animalShow:setCameraPosition(0, camY, -30)
	animalShow:setCamSize(camsize)
	avatar:updateByMo(mo)

	return animalShow, avatar
end

function FamilyPillarTowerView:_onClickChallengBtn()
	if self._isMyPillar then
		FloatWordMgr.instance:show("不可挑战本家族神柱！")

		return
	end

	if self._allAttack <= self._useAttack then
		FloatWordMgr.instance:show("挑战次数不足")

		return
	end

	if self._curBattleInfo == nil or self._curBattleInfo.tier == nil then
		printError("sr---家族战   FamilyPillarTowerView:_onClickChallengBtn()  挑战的守卫信息空？")

		return
	end

	if self._curPlayerView == nil or self._curPlayerView.curForm == nil or checknumber(self._curBattleInfo.userId) <= 0 then
		UIStateManager.instance:push(ViewName.FWPNMission, {
			isNest = false,
			tempId = self._params.familyId,
			planId = self._params.planId,
			curTier = self._curBattleInfo.tier
		})

		return
	end

	UIStateManager.instance:push(ViewName.FWPNMission, {
		isNest = false,
		tempId = self._params.familyId,
		planId = self._params.planId,
		curTier = self._curBattleInfo.tier,
		userInfo = self._curPlayerView
	})
end

function FamilyPillarTowerView:_onAvatarLoaded(avatar)
	local animator = avatar.animatorCtrl:getAnimator()

	if animator then
		animator:SetBool("ui", false)
		self:_changePlayerNakeMat(avatar)
		self:_changePlayerFaceMat(avatar)
		self:_changePlayerHairMat(avatar)
	end
end

function FamilyPillarTowerView:_changePlayerNakeMat(avatar)
	for k, v in pairs(avatar.avatarmo:getOwnNakeParts()) do
		local nakeparts = avatar:getBoneByName(AvatarNakePartTypeName[v])

		if nakeparts then
			local skinedMeshRenderer = nakeparts:GetComponent(ComponentType.SkinnedMeshRenderer)

			if skinedMeshRenderer and skinedMeshRenderer.material then
				skinedMeshRenderer.material:SetFloat("_worldLight", 0)
			end
		end
	end
end

function FamilyPillarTowerView:_changePlayerFaceMat(avatar)
	local faceObje = avatar:getBoneByName(avatar and avatar.avatarmo and avatar.avatarmo.skeleton and avatar.avatarmo.skeleton == 2 and AnimatorHash.maleBlendShapeName or AnimatorHash.femaleBlendShapeName)

	if faceObje then
		local skinedMeshRenderer = faceObje:GetComponent(ComponentType.SkinnedMeshRenderer)

		if skinedMeshRenderer and skinedMeshRenderer.material then
			skinedMeshRenderer.material:SetFloat("_worldLight", 0)
		end
	end
end

function FamilyPillarTowerView:_changePlayerHairMat(avatar)
	if avatar then
		::label_20_0::

		local var_20_0 = avatar.pendantsCtrl

		if avatar.pendantsCtrl then
			local _pendants = avatar.pendantsCtrl._pendants

			if not _pendants then
				return
			end

			local hair = _pendants[AvatarPendantType.Hair]

			if not hair then
				return
			end

			local hairGo = hair:getGameObject()

			if not hairGo then
				return
			end

			local hairGoRender = hairGo:GetComponentsInChildren(ComponentType.SkinnedMeshRenderer)

			if not hairGoRender then
				return
			end

			for i = 0, hairGoRender.Length - 1 do
				if hairGoRender[i] and hairGoRender[i].material then
					hairGoRender[i].material:SetFloat("_worldLight", 0)
				end
			end
		end
	end
end

function FamilyPillarTowerView:_removeAvatar()
	if self._upAvatar then
		self._upAvatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._upAvatar)

		self._upAvatar = nil
	end

	if self._nowAvatar then
		self._nowAvatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._nowAvatar)

		self._nowAvatar = nil
	end
end

return FamilyPillarTowerView
