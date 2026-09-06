-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSignView.lua

module("logic.extensions.contract.view.ContractSignView", package.seeall)

local ContractSignView = class("ContractSignView", ViewComponent)
local Enum = {
	Signable = 2,
	Removable = 3,
	OnlySummoner = 1
}
local AnimEnum = {
	PlayPartEnd = 3,
	PlayPartFirst = 2,
	None = 1
}

function ContractSignView:ctor()
	ContractSignView.super.ctor(self)
end

function ContractSignView:buildUI()
	ContractSignView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._leftRoleGo = self:getGo("leftRole/con")
	self._txtName = self:getTxt("left/info/txtName")
	self._txtLevel = self:getTxt("left/info/txtLevel")
	self._skillIcon = self:getGo("left/summonSkill/skillIcon")
	self._txtSkillName = self:getTxt("left/summonSkill/txtName")
	self._txtSkillDesc = self:getTxt("left/summonSkill/txtDesc")
	self._leftPower = self:getGo("left/summonSkill/power/powerTxt"):GetComponent(typeof(UIImgNumeralText))
	self._btnSelect = self:getBtn("btnSelect")
	self._goTip = self:getGo("tip")
	self._right = self:getGo("right")
	self._rightRoleGo = self:getGo("rightRole/con")
	self._rightTxtName = self:getTxt("right/info/txtName")
	self._rightTxtLevel = self:getTxt("right/info/txtLevel")
	self._rightSkillIcon = self:getGo("right/summonSkill/skillIcon")
	self._rightDefaultIcon = self:getGo("right/summonSkill/defaultIcon")
	self._rightTxtSkillName = self:getTxt("right/summonSkill/txtName")
	self._rightTxtSkillDesc = self:getTxt("right/summonSkill/txtDesc")
	self._btnChange = self:getBtn("right/btnChange")
	self._rightPower = self:getGo("right/summonSkill/power/powerTxt"):GetComponent(typeof(UIImgNumeralText))
	self._middleGo = self:getGo("middle")
	self._btnOk = self:getBtn("middle/btnOk")
	self._btnCancel = self:getBtn("middle/btnCancel")
	self._btnSkillPreview = self:getBtn("right/summonSkill/btnSkillPreview")
	self._btnSkillReset = self:getBtn("right/summonSkill/btnSkillReset")
	self._animNode = self:getGo("animNode")
	self._bgEffectRect = self:getGo("animNode/bgEffect"):GetComponent(goutil.Type_RectTransform)
	self._goSignAnim = self:getResInstance(ContractSignViewPresentor.SignAnimPath)

	goutil.addChildToParent(self._goSignAnim, self._animNode)

	self._btnAnimMask = self:getBtn("btnAnimMask")
	self._skeletonGraphic = self._goSignAnim:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
end

function ContractSignView:bindEvents()
	ContractSignView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnSkillPreview:AddClickListener(self._onClickSkillPreview, self)
	self._btnSkillReset:AddClickListener(self._onClickSkillReset, self)
	self._btnAnimMask:AddClickListener(self._onClickAnimMask, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
end

function ContractSignView:unbindEvents()
	ContractSignView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnOk:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSkillPreview:RemoveClickListener()
	self._btnSkillReset:RemoveClickListener()
	self._btnAnimMask:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function ContractSignView:onEnter()
	ContractSignView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetChanged, self._onBagPetChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_MakeContractRes, self._onMakeContractRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_CancelContractRes, self._onCancelContractRes, self)

	local params = self:getOpenParam()

	self._summonMasterId = params[1]
	self._summonId = params[2]

	printInfo("test 参数", self._summonMasterId, self._summonId)
	self:_setSummonId()
	self:_setSummonerInfo()
	self:_updateState()
	self:_initContractAnimation()
end

function ContractSignView:onExit()
	ContractSignView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetChanged, self._onBagPetChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MakeContractRes, self._onMakeContractRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_CancelContractRes, self._onCancelContractRes, self)
	self:_resetAllRole()
	self:_resetAllIcon()
	self:_removeBgEffect()
end

function ContractSignView:_onClickClose()
	self:close()
end

function ContractSignView:_onClickSelect()
	local summonerId = self._summonMasterId

	local function callback(selectSummonPetId)
		UIStateManager.instance:updateParms(ViewName.ContractSignView, {
			summonerId,
			selectSummonPetId
		})
		printInfo("test _onClickSelect2", summonerId, selectSummonPetId)
	end

	UIStateManager.instance:push(ViewName.ContractSummonPetView, summonerId, callback)
end

function ContractSignView:_onClickChange()
	local summonerId = self._summonMasterId

	local function callback(selectSummonPetId)
		UIStateManager.instance:updateParms(ViewName.ContractSignView, {
			summonerId,
			selectSummonPetId
		})
		printInfo("test _onClickChange2", summonerId, selectSummonPetId)
	end

	UIStateManager.instance:push(ViewName.ContractSummonPetView, self._summonMasterId, callback)
end

function ContractSignView:_onClickOk()
	ContractController.instance:sendMakeContract(self._summonMasterId, self._summonId)
end

function ContractSignView:_onClickCancel()
	local content = "是否确定解除当前精灵契约，解除后将不能在战斗中召唤"

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		ContractController.instance:sendCancelContract(self._summonMasterId, self._summonId)
	end)
end

function ContractSignView:_onClickSkillPreview()
	UIStateManager.instance:push(ViewName.ContractSkillBrowseView, self._summonMasterId, self._summonId)
end

function ContractSignView:_onClickSkillReset()
	UIStateManager.instance:push(ViewName.ContractSkillResetView, self._summonMasterId, self._summonId)
end

function ContractSignView:_onClickAnimMask()
	if self._animState == AnimEnum.None then
		-- block empty
	elseif self._animState == AnimEnum.PlayPartFirst then
		self:_playContractAnimPart2()
	else
		self:_closeAllAnimNode()
	end
end

function ContractSignView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "contractsign")
end

function ContractSignView:_onBagPetChanged()
	printInfo("test 背包信息改变，即契约信息改变了")

	self._curState = self:_getCurState()

	self:_setObj(self._curState)
	self:_setInfo(self._curState, false)
end

function ContractSignView:_onMakeContractRes(summonerMasterId, summonedPetId)
	if summonedPetId ~= -1 then
		self:_playContractAnimPart1()
	end
end

function ContractSignView:_onCancelContractRes()
	FloatWordMgr.instance:show("可以重新建立契约")
end

function ContractSignView:_updateState()
	self._curState = self:_getCurState()

	self:_changeState(self._curState)
end

function ContractSignView:_setSummonId()
	if not self._summonId or self._summonId <= 0 then
		local petMo = BagPetsController.instance:getPet(self._summonMasterId)

		self._summonId = petMo.summonedPetId
	end
end

function ContractSignView:_getCurState()
	if self._summonId and self._summonId > 0 then
		local summonPetMo = BagPetsController.instance:getPet(self._summonId)

		if summonPetMo and summonPetMo.summonMasterId and summonPetMo.summonMasterId > 0 and summonPetMo.summonMasterId == self._summonMasterId then
			return Enum.Removable
		else
			return Enum.Signable
		end
	else
		return Enum.OnlySummoner
	end
end

function ContractSignView:_changeState(state)
	self:_setObj(state)
	self:_setInfo(state, true)
end

function ContractSignView:_setObj(state)
	if state == Enum.OnlySummoner then
		self._btnSelect.gameObject:SetActive(true)
		self._goTip:SetActive(true)
		self._right:SetActive(false)
		self._middleGo:SetActive(false)
		self._rightRoleGo:SetActive(false)
	elseif state == Enum.Signable then
		self._btnSelect.gameObject:SetActive(false)
		self._goTip:SetActive(false)
		self._right:SetActive(true)
		self._middleGo:SetActive(true)
		self._btnOk.gameObject:SetActive(true)
		self._btnCancel.gameObject:SetActive(false)
		self._btnSkillPreview.gameObject:SetActive(true)
		self._btnSkillReset.gameObject:SetActive(false)
		self._rightRoleGo:SetActive(true)
	elseif state == Enum.Removable then
		self._btnSelect.gameObject:SetActive(false)
		self._goTip:SetActive(false)
		self._right:SetActive(true)
		self._middleGo:SetActive(true)
		self._btnOk.gameObject:SetActive(false)
		self._btnCancel.gameObject:SetActive(true)
		self._btnSkillPreview.gameObject:SetActive(false)
		self._btnSkillReset.gameObject:SetActive(true)
		self._rightRoleGo:SetActive(true)
	end
end

function ContractSignView:_setInfo(state, isLoadRole)
	if state == Enum.Signable or state == Enum.Removable then
		self:_setSummonInfo(isLoadRole)
	end
end

function ContractSignView:_setSummonerInfo()
	local petMo = BagPetsController.instance:getPet(self._summonMasterId)

	if petMo then
		self._txtName.text = petMo:getName()
		self._txtLevel.text = petMo:getOriginLevel()

		self._leftPower:SetNum(petMo:getFightingPower())

		self._summonerRoleLoader = self:_showRoleModel(true, petMo, petMo:getDefineId(), self._leftRoleGo, self._summonerRoleLoader)
		self._txtSkillName.text = ""
		self._txtSkillDesc.text = ""

		local petCfg = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

		if checknumber(petCfg.summonSkillId) > 0 then
			MaterialMgr.setCell(MatType.Skill, petCfg.summonSkillId, self._skillIcon)

			local cfg = BattleConfig.instance:getSkillCo(petCfg.summonSkillId, petMo.curFaceId)

			if cfg then
				self._txtSkillName.text = cfg.name
				self._txtSkillDesc.text = cfg.desc
			end
		end
	end
end

function ContractSignView:_setSummonInfo(isLoadRole)
	self._rightDefaultIcon:SetActive(true)

	local petMo = BagPetsController.instance:getPet(self._summonId)

	if petMo then
		self._rightTxtName.text = petMo:getName()
		self._rightTxtLevel.text = petMo:getOriginLevel()

		self._rightPower:SetNum(petMo:getFightingPower())

		if isLoadRole then
			self._summonRoleLoader = self:_showRoleModel(false, petMo, petMo:getDefineId(), self._rightRoleGo, self._summonRoleLoader)
		end

		if self._curState == Enum.Signable then
			MaterialMgr.resetAll(self._rightSkillIcon)
			self._rightDefaultIcon:SetActive(true)

			self._rightTxtSkillName.text = "契约技"
			self._rightTxtSkillDesc.text = "成功签订契约后随机获得新的契约技"
		elseif self._curState == Enum.Removable then
			self._rightDefaultIcon:SetActive(false)

			local summonerPetMo = BagPetsController.instance:getPet(self._summonMasterId)
			local contractCfg = ContractConfig.instance:getGroupCfg(summonerPetMo:getDefineId(), petMo:getDefineId())

			if contractCfg then
				local skillId = ContractModel.instance:getSkillIdByGroupId(contractCfg.groupId)

				if skillId > 0 then
					MaterialMgr.setCell(MatType.Skill, skillId, self._rightSkillIcon)

					local cfg = BattleConfig.instance:getSkillCo(skillId)

					if cfg then
						self._rightTxtSkillName.text = cfg.name
						self._rightTxtSkillDesc.text = cfg.desc
					end
				end
			end
		end
	end
end

function ContractSignView:_resetAllIcon()
	MaterialMgr.resetAll(self._skillIcon)
	MaterialMgr.resetAll(self._rightSkillIcon)
	self._rightDefaultIcon:SetActive(true)
end

function ContractSignView:_showRoleModel(isLeft, petMo, raceId, parentGo, loader)
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(petMo.curFaceId)

	if not modelCfg[1] then
		local x = 0

		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self:_resetRoleModel(loader)

				local isAuto = true
				local callback

				return (RoleObjectPool.instance:addRoleToParent(loader, petMo.curFaceId, parentGo, scale, function(go)
					self:_changeMaterial(go)
				end, isAuto, x, y))
			end
		end
	end
end

local shaderName = "Spine/SkeletonGraphic (Premultiply Alpha)"

function ContractSignView:_changeMaterial(go)
	local parent = go.transform
	local childCount = parent.childCount

	for i = 1, childCount do
		local trans = parent:GetChild(i - 1)
		local r = trans.gameObject:GetComponent("SkeletonGraphic")

		if not goutil.isNil(r) and r.material ~= nil and r.material.shader ~= nil and r.material.shader.name ~= shaderName then
			local tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find(shaderName))

			tempMat.mainTexture = r.material.mainTexture
			r.material = tempMat
		end

		self:_changeMaterial(trans.gameObject)
	end
end

function ContractSignView:_resetRoleModel(loader)
	return (RoleObjectPool.instance:removeRole(loader))
end

function ContractSignView:_resetAllRole()
	self._summonerRoleLoader = self:_resetRoleModel(self._summonerRoleLoader)
	self._summonRoleLoader = self:_resetRoleModel(self._summonRoleLoader)
end

function ContractSignView:_playAnimation(animName, loop, completeCallback)
	local graphic = self._skeletonGraphic
	local sk = graphic.skeletonDataAsset
	local data = sk:GetAnimationStateData()
	local skd = data.SkeletonData
	local ani = skd:FindAnimation(animName)

	if ani ~= nil then
		graphic.startingAnimation = animName

		graphic.AnimationState:SetAnimation(0, animName, loop)
		graphic:Update(0)

		local onComplete

		function onComplete()
			GameUtil.callBack(completeCallback)

			graphic.AnimationState.Complete = graphic.AnimationState.Complete - onComplete
		end

		graphic.AnimationState.Complete = graphic.AnimationState.Complete + onComplete
	end
end

function ContractSignView:_initContractAnimation()
	self._animNode:SetActive(false)
	self._btnAnimMask.gameObject:SetActive(false)
	self._bgEffectRect.gameObject:SetActive(false)

	self._animState = AnimEnum.None

	self:_playAnimation("1", false)
end

function ContractSignView:_playContractAnimPart1()
	self._animNode:SetActive(true)
	self._btnAnimMask.gameObject:SetActive(true)

	local function onCompleteCallBack()
		self._animState = AnimEnum.PlayPartFirst

		self:_showBgEffect()
		self:_playAnimation("3", true)
	end

	self:_playAnimation("2", false, onCompleteCallBack)
end

function ContractSignView:_playContractAnimPart2()
	self._animState = AnimEnum.None

	local function onCompleteCallBack()
		self._animState = AnimEnum.PlayPartEnd

		self:_showSuccessPanel()
		self:_closeAllAnimNode()
	end

	self:_playAnimation("4", false, onCompleteCallBack)
end

function ContractSignView:_initBgEffect()
	local ratio = UnityEngine.Screen.height / 720

	self._photoEffect = PhotoEffect.Get(self._bgEffectRect.gameObject)

	local effectPath = UIEffectManager.instance:getEffectPath(ContractSignViewPresentor.BgEffectPath)

	self._photoEffect:showEffectsFullScreen({
		effectPath
	}, self._bgEffectRect.rect.width * ratio, self._bgEffectRect.rect.height * ratio)
	self._photoEffect:setCameraPosition(0, 0, -20)
	self._photoEffect:setCameraSize(360)

	local camera = self._photoEffect._photo.producer.rtCamera

	camera.orthographic = true
end

function ContractSignView:_removeBgEffect()
	if self._photoEffect then
		self._photoEffect:clear()

		self._photoEffect = nil
	end
end

function ContractSignView:_showBgEffect()
	self._bgEffectRect.gameObject:SetActive(true)
	self:_initBgEffect()
end

function ContractSignView:_showSuccessPanel()
	UIStateManager.instance:push(ViewName.ContractSuccessView, self._summonMasterId, self._summonId)
end

function ContractSignView:_closeAllAnimNode()
	self:_initContractAnimation()
end

return ContractSignView
