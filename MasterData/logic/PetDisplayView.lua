-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petdisplay/view/PetDisplayView.lua

module("logic.extensions.petdisplay.view.PetDisplayView", package.seeall)

local PetDisplayView = class("PetDisplayView", ViewComponent)
local DebugDefaultRaceId = 10005

function PetDisplayView:ctor()
	PetDisplayView.super:ctor()

	self._Character = nil
	self._CharacterId = nil
end

local effPaths = {
	{
		goPath = "point_dian",
		path = "fx_ui_huodejingling/fx_ui_dian.prefab"
	},
	{
		goPath = "point_fenwei",
		path = "fx_ui_huodejingling/fx_ui_fenwei.prefab"
	}
}

function PetDisplayView:_createEffects()
	self._effs = {}

	for _, effPath in ipairs(effPaths) do
		local parent = self:getGo(effPath.goPath)
		local eff = UIEffectManager.instance:playHUDEffect(effPath.path, parent, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		end, nil, false)

		eff:setActive(false)
		table.insert(self._effs, eff)
	end
end

function PetDisplayView:buildUI()
	self.info = self:getGo("info")
	self._txtName = goutil.findChildTextComponent(self.info, "name/txt_name")
	self._txtPos1 = goutil.findChildTextComponent(self.info, "txt_pos1")
	self._txtPos2 = goutil.findChildTextComponent(self.info, "txt_pos2")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txt_desc")
	self._imgJob = goutil.findChildComponent(self.info, "attrs/job/icon", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.info, "attrs/job1/icon", "UIImageSpriteChange")
	self._imgAttr = goutil.findChildComponent(self.info, "attrs/attr/icon", "UIImageSpriteChange")
	self._goJob1 = self._imgJob1.transform.parent.gameObject
	self._btnClose = self:getBtn("bomCanvas/btnClose")
	self._btnSkip = self:getBtn("btnSkip")
	self._rolePoint = self:getGo("point_role/point")
	self._rarePoint = goutil.findChild(self.info, "point_rare")
	self._yewuyou = self:getGo("point_role/point/yewuyou")
	self._yewuyou2 = self:getGo("point_role/point/yewuyou2")
	self._animator = self.mainGO:GetComponent("Animator")
	self._animationListener = Framework.AnimationEventListener.Get(self.mainGO)
	self._cv = goutil.findChild(self._txtName.gameObject, "CV")
	self._txtCvName = goutil.findChildTextComponent(self._cv, "txtName")
	self._hireGO = goutil.findChild(self._txtName.gameObject, "CV/hire")
	self._txtHire = goutil.findChildTextComponent(self._hireGO.gameObject, "txt")
	self._stargodGo = self:getGo("binding/stargod")
	self._equipGo = self:getGo("binding/equip")
	self._bond = self:getGo("binding/bond")
	self._petListInBond = {}

	for i = 1, 4 do
		local petItem = {}

		petItem.go = self:getGo("binding/bond/pet_" .. i)
		petItem.iconHead = goutil.findChild(petItem.go, "iconHead")
		petItem.bg = goutil.findChildComponent(petItem.go, "bg", typeof(UIImageSpriteChange))
		self._petListInBond[i] = petItem
	end

	self._imgRareBg = goutil.findChildComponent(self._rarePoint, "imgRareBg", typeof(UIImageSpriteChange))
	self._imgNew = self:getGo("img_new")
	self._shareBtn = self:getBtn("shareBtn")
	self._bomCanvas = self:getGo("bomCanvas"):GetComponent(typeof(UnityEngine.Canvas))
	self._topCanvas = self:getGo("topCanvas"):GetComponent(typeof(UnityEngine.Canvas))
	self._pointCommonBg = self:getGo("bomCanvas/point_common_bg")
	self._pointLightBg = self:getGo("bomCanvas/point_rare_light_bg")
	self._pointLight = self:getGo("point_guang")
	self._pointRare = self:getGo("point_rare")
	self._pointDrop = self:getGo("bomCanvas/point_drop")
	self._pointNew = self:getGo("img_new/point_new")

	if enableDebug then
		self._debugTestGo = self:getGo("test")
		self._debugSearchGo = self:getGo("test/InputC_Search")
		self._debugSearchBtnClear = self:getGo("test/InputC_Search/BtnClear")
		self._debugInputSearch = self:getInput("test/InputC_Search")
		self._debugBtnPut = self:getGo("test/btnPut")

		GameUtil.SetActive(self._debugTestGo, true)
	else
		local testGo = goutil.findChild(self.mainGO, "test")

		GameUtil.SetActive(testGo, false)
	end
end

function PetDisplayView:destroyUI()
	return
end

function PetDisplayView:_onClickSkip()
	PetDisplayModel.instance:ClearList()
	self:_onClickBtnClose(true)
end

function PetDisplayView:onEnter()
	self:_createEffects()

	local canvas = UGUIToolHelper.FindCanvas(self.mainGO)

	self._bomCanvas.sortingOrder = canvas.sortingOrder - 3
	self._topCanvas.sortingOrder = canvas.sortingOrder + 3

	local pet = self:getFirstParam() or self:_getDefaultDisplayPet()
	local prize = ShareController.instance.activeByTimes(1, goutil.findChild(self._shareBtn.gameObject, "bubble"))

	self._shareProxy = MaterialMgr.setCellByCfg(prize, goutil.findChild(self._shareBtn.gameObject, "bubble/reward"))

	self:_start(pet)
end

function PetDisplayView:_getDefaultDisplayPet()
	return FightingPowerPetMo.getMaxPetMo(DebugDefaultRaceId)
end

local lightEffUrl = {
	[GameEnum.PetRare.N] = "fx_ui_huodejingling_lanse",
	[GameEnum.PetRare.R] = "fx_ui_huodejingling_lanse",
	[GameEnum.PetRare.SR] = "fx_ui_huodejingling_zise",
	[GameEnum.PetRare.SSR] = "fx_ui_huodejingling_jinse"
}
local lightEffBgUrl = {
	[GameEnum.PetRare.N] = "fx_ui_huodejingling_lanse_bg",
	[GameEnum.PetRare.R] = "fx_ui_huodejingling_lanse_bg",
	[GameEnum.PetRare.SR] = "fx_ui_huodejingling_zise_bg",
	[GameEnum.PetRare.SSR] = "fx_ui_huodejingling_jinse_bg01"
}
local rareEffUrl = {
	[GameEnum.PetRare.SR] = "fx_ui_huodejinging_chaoneng",
	[GameEnum.PetRare.SSR] = "fx_ui_huodejinging_chuanshuo"
}
local dropEffUrl = {
	[GameEnum.PetRare.N] = "fx_ui_huodejinglingg_huode_baise",
	[GameEnum.PetRare.R] = "fx_ui_huodejinglingg_huode_lanse",
	[GameEnum.PetRare.SR] = "fx_ui_huodejinglingg_huode_zise",
	[GameEnum.PetRare.SSR] = "fx_ui_huodejinglingg_huode_jinse"
}

function PetDisplayView:_loadEffsByRare(rare, raceId)
	print("rare = " .. rare)

	local url = "fx_ui_huodejingling_tongyongbeijing"

	if self._commonBgEff == nil then
		self._commonBgEff = self:_loadEff(url, self._pointCommonBg, true)
	end

	if self._lightBgEff ~= nil then
		UIEffectManager.instance:stopEffect(self._lightBgEff)

		self._lightBgEff = nil
	end

	url = lightEffBgUrl[rare]
	self._lightBgEff = self:_loadEff(lightEffBgUrl[rare], self._pointLightBg, true)

	if self._lightEff ~= nil then
		UIEffectManager.instance:stopEffect(self._lightEff)

		self._lightEff = nil
	end

	url = lightEffUrl[rare]
	self._lightEff = self:_loadEff(lightEffUrl[rare], self._pointLight, true)

	if self._newEff == nil then
		url = "fx_ui_huodejingling_xinhuode"
		self._newEff = self:_loadEff("fx_ui_huodejingling_xinhuode", self._pointNew, true)
	end

	if self._rareEff ~= nil then
		UIEffectManager.instance:stopEffect(self._rareEff)

		self._rareEff = nil
	end

	if PetSkinConfig.instance:checkHasJob(raceId, GameEnum.JobZhDefine.SourceTrace) then
		url = "fx_ui_huodejinging_chuanshuo_yq/fx_ui_huodejinging_chuanshuo_yq.prefab"
		self._rareEff = self:loadFullPathEff("fx_ui_huodejinging_chuanshuo_yq/fx_ui_huodejinging_chuanshuo_yq.prefab", self._pointRare, true)
	else
		url = rareEffUrl[rare]

		if not string.nilorempty(rareEffUrl[rare]) then
			self._rareEff = self:_loadEff(url, self._pointRare, true)
		end
	end

	url = dropEffUrl[rare]

	if self._dropEff ~= nil then
		UIEffectManager.instance:stopEffect(self._dropEff)

		self._dropEff = nil
	end

	self._dropEff = self:_loadEff(url, self._pointDrop, true)
end

function PetDisplayView:_clearEffs()
	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}

	MaterialMgr.resetAll(self._rarePoint)
	UIEffectManager.instance:stopEffect(self._commonBgEff)
	UIEffectManager.instance:stopEffect(self._lightBgEff)
	UIEffectManager.instance:stopEffect(self._lightEff)
	UIEffectManager.instance:stopEffect(self._newEff)
	UIEffectManager.instance:stopEffect(self._rareEff)
	UIEffectManager.instance:stopEffect(self._dropEff)

	self._commonBgEff = nil
	self._lightBgEff = nil
	self._lightEff = nil
	self._newEff = nil
	self._rareEff = nil
	self._dropEff = nil
end

function PetDisplayView:_loadEff(url, parent, loop)
	local prefix = "fx_ui_huodejingling/"
	local suffix = ".prefab"

	url = prefix .. url .. suffix

	local eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, loop, false, nil, function(target, eff)
		local trans = eff.effGo.transform

		goutil.addChildToParent(trans, parent)
		Framework.TransformUtil.SetLocalPos(trans, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(trans, 1, 1, 1)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
	end)

	eff.hideEffWhileNotOnTop = false

	return eff
end

function PetDisplayView:loadFullPathEff(url, parent, loop)
	local eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, loop, false, nil, function(target, eff)
		local trans = eff.effGo.transform

		goutil.addChildToParent(trans, parent)
		Framework.TransformUtil.SetLocalPos(trans, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(trans, 1, 1, 1)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
	end)

	eff.hideEffWhileNotOnTop = false

	return eff
end

function PetDisplayView:_onEffLoaded(eff)
	return
end

function PetDisplayView:_showBtnSkip()
	self.allow_close = true

	if self._btnSkip then
		self._btnSkip.gameObject:SetActive(true)
	end
end

function PetDisplayView:_showInfo()
	if self.info then
		goutil.setActive(self.info.gameObject, true)
	end
end

function PetDisplayView:_showBond()
	if self.info then
		GameUtil.SetActive(self._bond, true)
	end
end

function PetDisplayView:_onAnimationEvent(animEvent)
	if animEvent.stringParameter == "playAudio" then
		self._30211VcEvent = AudioPlayerEx.instance:playEffect(30211)
	end
end

function PetDisplayView:_start(pet)
	if pet == nil then
		self:showNextOrExit()
	else
		self._curPet = pet
		self._animator.enabled = true

		self._animator:Update(0)

		self._animator.enabled = false
		self._30209VcEvent = AudioPlayerEx.instance:playEffect(30209)

		Framework.AnimationEventListener.Get(self.mainGO)
		goutil.setActive(self._pointRare, false)
		goutil.setActive(self._pointLight, false)
		goutil.setActive(self._pointLightBg, false)
		goutil.setActive(self._hireGO, false)

		local info = PetHireModel.instance:getPetInfoByPetId(pet.petId)

		if pet.isHirePet and info and info:GetCount() > 0 then
			goutil.setActive(self._hireGO, true)

			self._txtHire.text = langPara("可用次数：%s", info:GetCount())
		end

		self:_loadEffsByRare(pet.rare, pet.raceId)
		removetimer(self._delayPlayCv, self)

		if self._btnSkip then
			self._btnSkip.gameObject:SetActive(false)
			settimer(2, self._showBtnSkip, self, false)
		end

		local petCo = CharacterConfig.instance:getPetCo(pet.raceId)

		self._faceId = pet.curFaceId

		if self.info then
			goutil.setActive(self.info.gameObject, false)
			settimer(0.5, self._showInfo, self, false)
		end

		self._txtName.text = petCo.name

		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(pet.curFaceId)

		self._imgJob:SetState(firstJobIdx - 1)

		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(pet.curFaceId)

		self._imgAttr:SetState(race - 1)
		self:_setPetCv(pet.raceId)
		self:_setPetBond(pet.raceId)
		self:_setBindEquip(pet.raceId)
		self:_setBindStargod(pet.raceId)
		self:_setPetExtraInfo(pet.raceId)
		goutil.setActive(self._goJob1, false)

		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(pet.curFaceId)

		if secondJobIdx > 20 then
			goutil.setActive(self._goJob1, true)
			self._imgJob1:SetState(secondJobIdx - 1 - 20)
		end

		MaterialMgr.resetAll(self._rarePoint)

		local rare = pet.rare

		rare = math.max(1, rare)
		rare = math.min(4, rare)

		if string.nilorempty(rareEffUrl[rare]) then
			goutil.setActive(self._imgRareBg.gameObject, true)
			self._imgRareBg:SetState(rare - 1)

			local proxy = MaterialMgr.setCell(MatType.Rare, pet.raceId, self._rarePoint)

			proxy.binder:setRare(pet.rare)
			proxy.binder:playEffect()
		else
			goutil.setActive(self._imgRareBg.gameObject, false)
		end

		goutil.setActive(self._imgNew, PetDisplayModel.instance:isPetIdNew(pet.petId))
		self:_setPetUIPrefab(pet.raceId, pet.curFaceId)

		local isYewuyou = pet.raceId == 10086

		if not goutil.isNil(self._yewuyou) then
			self:setChildrenActive(self._yewuyou, isYewuyou)
		end

		if not goutil.isNil(self._yewuyou2) then
			self:setChildrenActive(self._yewuyou2, isYewuyou)
		end

		self._effs[2]:setActive(isYewuyou)
		self._effs[1]:setActive(isYewuyou)
	end
end

function PetDisplayView:setChildrenActive(root, isActive)
	for i = 0, root.transform.childCount - 1 do
		local child = root.transform:GetChild(i)

		child.gameObject:SetActive(isActive)
	end
end

function PetDisplayView:_setPetCv(id)
	local word, cvCfg = PetCvController.instance:playPetCv(id, GameEnum.PetCvType.Default, nil, nil, false)

	self._cvCfg = cvCfg
	self._txtDesc.text = word

	settimer(1.7, self._delayPlayCv, self, false)

	local cvName = PetSkinConfig.instance:getSkinCvName(id)

	self._txtCvName.text = cvName

	goutil.setActive(self._cv, not string.nilorempty(cvName))
end

function PetDisplayView:_delayPlayCv()
	if self._cvCfg then
		PetCvController.instance:_playPetCvByCfg(self._cvCfg)
	end
end

function PetDisplayView:playCvAudio()
	if checknumber(self._lastAudioId) > 0 then
		AudioPlayerEx.instance:stopVoice(self._lastAudioId)
	end

	if self._cvCfg and self._cvCfg.audioId > 0 then
		AudioPlayerEx.instance:playVoice(self._cvCfg.audioId)

		self._lastAudioId = self._cvCfg.audioId
	else
		self._lastAudioId = nil
	end
end

function PetDisplayView:_setPetExtraInfo(id)
	local petInfoCfg = CharacterConfig.instance:getPetInfoCo(id)

	if petInfoCfg ~= nil then
		local t = string.split(petInfoCfg.stragegy, "\n")

		if #t >= 1 then
			self._txtPos1.text = t[1] or "待定"
		end

		if #t >= 2 then
			self._txtPos2.text = t[2] or ""
		end
	else
		self._txtPos1.text = "待定"
		self._txtPos2.text = ""
	end
end

function PetDisplayView:_setPetUIPrefab(id, faceId)
	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(id)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self:_clearCurRole()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, faceId, self._rolePoint, scale, function(go)
		if go ~= nil then
			local graphic = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

			self._roleGo = go

			GameUtil.updateSpineLihuiEffOrder(go)
		end

		if not goutil.isNil(self._yewuyou) then
			self._yewuyou.transform:SetAsFirstSibling()
		end

		if not goutil.isNil(self._yewuyou2) then
			self._yewuyou2.transform:SetAsLastSibling()
		end

		self._animator.enabled = false
		self._animator.enabled = true

		self._animator:Rebind()
	end, true, x, y)
end

function PetDisplayView:_onDebugSearchTextChanged()
	local text = self._debugInputSearch:GetText()

	if text ~= self._debugCurrSearching then
		self._debugCurrSearching = text

		local modelId = checknumber(self._debugCurrSearching)
		local cfg = CharacterConfig.instance:getModelCo(modelId)

		if cfg then
			self:_setPetUIPrefab(modelId, modelId)
		end
	end
end

function PetDisplayView:_onDebugClearSearch()
	self._debugInputSearch.input.text = ""
end

function PetDisplayView:_onDebugClickPut()
	if self._role then
		local asset = self._role.asset

		if goutil.isNil(asset) then
			return
		end

		local scale = GameUtil.getLocalScale(asset)
		local pos = GameUtil.getLocalPos(asset)
		local name = self._curPet and self._curPet:getName() or ""
		local str = string.format("%s[%.2f, %.2f, %.2f]", name, pos.x, pos.y, scale.x)

		printInfo(str)
	end
end

function PetDisplayView:_clearCurRole()
	if self._role ~= nil then
		RoleObjectPool.instance:removeRole(self._role)
	end

	self._role = nil

	self:_revertMaterial()
end

function PetDisplayView:_revertMaterial()
	if not goutil.isNil(self._roleGo) and self._cacheMat ~= nil then
		local graphic = goutil.findChildComponent(self._roleGo, "skeleton", "SkeletonGraphic")

		graphic.material = self._cacheMat
	end

	self._roleGo = nil
	self._cacheMat = nil
end

function PetDisplayView:_setBindStargod(raceId)
	GameUtil.SetActive(self._stargodGo, false)

	local cfg = CharacterConfig.instance:getInitStrengthCfg(raceId)

	if cfg then
		if not cfg.starGodDefineIds then
			local starGodDefineIds = {}

			GameUtil.SetActive(self._stargodGo, #starGodDefineIds > 0)

			for i = 1, 4 do
				local go = goutil.findChild(self._stargodGo, "pet_" .. i)
				local id = checknumber(starGodDefineIds[i])

				if id > 0 then
					GameUtil.SetActive(go, true)

					local icon = goutil.findChild(go, "iconHead")

					MaterialMgr.setCell(MatType.StarGodPlus, id, icon)
				else
					GameUtil.SetActive(go, false)
				end
			end
		end
	end
end

function PetDisplayView:_setBindEquip(raceId)
	GameUtil.SetActive(self._equipGo, false)
end

function PetDisplayView:_setPetBond(id)
	GameUtil.SetActive(self._bond, false)

	for i = 1, 4 do
		uGuiUtil.clearImage(self._petListInBond[i].iconHead)
		GameUtil.SetActive(self._petListInBond[i].go, false)
	end

	local cfg = CharacterConfig.instance:getBondCfgsOnForm(id, true)

	if cfg then
		local petlist = {}
		local petlistInCfg = cfg.relativeRaceIds

		table.insert(petlist, 1, id)

		for i = 1, #petlistInCfg do
			table.insert(petlist, petlistInCfg[i])
		end

		for i = 1, #petlist do
			local petCo = CharacterConfig.instance:getPetCo(petlist[i])
			local rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, petCo.raceId)
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

			if modelCo == nil then
				printError(">>>>>>>>>> _setPetBond error ", petCo.raceId, petCo.faceIds)
			end

			self._petListInBond[i].bg:SetState(rare + 1)
			uGuiUtil.setSpriteToImage(self._petListInBond[i].iconHead, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
			GameUtil.SetActive(self._petListInBond[i].go, true)
		end

		settimer(0.5, self._showBond, self, false)
	end
end

function PetDisplayView:onExit()
	self:_clearCurRole()
	self:_clearEffs()

	self._30211VcEvent = nil
	self._30209VcEvent = nil

	removetimer(self._showBtnSkip, self)
	removetimer(self._showInfo, self)
	removetimer(self._delayPlayCv, self)
	removetimer(self._showBond, self)
	GameUtil.SetActive(self._bond, false)

	for i = 1, 4 do
		uGuiUtil.clearImage(self._petListInBond[i].iconHead)
		GameUtil.SetActive(self._petListInBond[i].go, false)
	end

	MaterialMgr.resetAll(self._shareProxy)
	GlobalDispatcher:dispatch(GlobalNotify.LotteryAniContinue)

	for i = 1, 4 do
		local go = goutil.findChild(self._stargodGo, "pet_" .. i)
		local icon = goutil.findChild(go, "iconHead")

		MaterialMgr.resetAll(icon)
	end
end

function PetDisplayView:onViewShowByHigherPriority()
	self._30209VcEvent = AudioPlayerEx.instance:playEffect(30209)

	self:playCvAudio()
end

function PetDisplayView:onViewHideByLowerPriority()
	AudioVoicePlayer.instance:stopVoice(true)
	removetimer(self._delayPlayCv, self)

	if self._30211VcEvent then
		AudioPlayerEx.instance:stopEvent(self._30211VcEvent)

		self._30211VcEvent = nil
	end

	if self._30209VcEvent then
		AudioPlayerEx.instance:stopEvent(self._30209VcEvent)

		self._30209VcEvent = nil
	end
end

function PetDisplayView:_ShowPetBg(race)
	self._ImgC_Bg:SetState(race - 1)
end

function PetDisplayView:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnSkip:AddClickListener(self._onClickSkip, self)
	self._shareBtn:AddClickListener(function()
		ShareController.instance:share(1, {
			self._shareBtn.gameObject
		}, nil, 200291)
	end)
	self._animationListener:AddListener(self._onAnimationEvent, self)

	if enableDebug then
		GameUtil.addClickHandler(self._debugSearchGo, self._onDebugSearchTextChanged, self)
		GameUtil.addClickHandler(self._debugSearchBtnClear, self._onDebugClearSearch, self)
		self._debugInputSearch:AddOnValueChanged(self._onDebugSearchTextChanged, self)
		GameUtil.addClickHandler(self._debugBtnPut, self._onDebugClickPut, self)
	end
end

function PetDisplayView:unbindEvents()
	self._animationListener:RemoveListener()
	self._btnClose:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	self._shareBtn:RemoveClickListener()

	if enableDebug then
		GameUtil.rmClickHandler(self._debugSearchGo)
		GameUtil.rmClickHandler(self._debugSearchBtnClear)
		self._debugInputSearch:RemoveOnValueChanged()
		GameUtil.rmClickHandler(self._debugBtnPut)
	end
end

function PetDisplayView:_onClickBtnClose(forceJump)
	if not self.allow_close then
		return
	end

	if GoUtil.IsAnimatorPlaying(self._animator) then
		GoUtil.SkipAnimator(self._animator)

		if not forceJump then
			return
		end
	end

	PetCvController.instance:turnOffCurCv()
	self:showNextOrExit()
end

function PetDisplayView:showNextOrExit()
	if not PetDisplayModel.instance:hasNewPet() then
		self:realExit()
	else
		local pet = PetDisplayController.instance:getNextPetMo()

		self:_start(pet)
	end
end

function PetDisplayView:realExit()
	GlobalDispatcher:dispatch(GlobalNotify.OnMaterialPopEnd, MatType.Pet)
	GlobalDispatcher:dispatch(GlobalNotify.OnPetPopEnd, 9)
	PetDisplayModel.instance:excuteCallback()
	GlobalDispatcher:dispatch(GlobalNotify.PetDisplayEnd, self._faceId)
	self:close()
end

function PetDisplayView:onExitFinished()
	PetDisplayView.super:onExitFinished()
	PetDisplayController.instance:tryShowNext(true)
end

return PetDisplayView
