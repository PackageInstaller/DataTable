-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/pet/PetCell.lua

module("logic.extensions.material.proxy.pet.PetCell", package.seeall)

local PetCell = class("PetCell", MaterialCell)

PetCell.ResPath = "ui/views/common/item_pet.prefab"

function PetCell:ctor(target)
	PetCell.super.ctor(self, target)
	NotifyDispatcher.extend(self)

	self._Nego_Info = self.target:GetComponent("UIChangeGroup")
	self._Nego_Attr = goutil.findChild(self.target, "Nego_Attr")
	self._ImgC_HeadIcon = goutil.findChild(self.target, "ImgC_HeadIcon/con"):GetComponent("Image")
	self._ImgC_Frame = goutil.findChild(self.target, "ImgC_Frame")
	self._ImgC_Selected = goutil.findChild(self.target, "ImgC_Selected")
	self._levelBg = goutil.findChild(self.target, "bg")
	self._TxtC_Level = goutil.findChildTextComponent(self.target, "TxtC_Level")
	self._ImgC_Bg = goutil.findChild(self.target, "ImgC_Bg"):GetComponent("UIImageSpriteChange")
	self._hireGo = goutil.findChild(self.target, "hire")
	self._txtHire = goutil.findChildTextComponent(self.target, "hire/txt")
	self._ImgC_InTeam = goutil.findChild(self.target, "ImgC_InTeam")

	self._ImgC_InTeam.gameObject:SetActive(false)

	self._ImgC_Support = goutil.findChild(self.target, "ImgC_Support")

	self._ImgC_Support.gameObject:SetActive(false)

	self.ImgC_Lease = goutil.findChild(self.target, "ImgC_Lease")

	self.ImgC_Lease.gameObject:SetActive(false)

	self._ImgC_Dead = goutil.findChild(self.target, "ImgC_Dead")

	self._ImgC_Dead.gameObject:SetActive(false)

	self.imgLocked = goutil.findChild(self.target, "imgLocked")
	self._atkTypeBg = goutil.findChild(self.target, "atkType"):GetComponent("UIImageSpriteChange")
	self._formConditionGo = goutil.findChild(self.target, "formCondition")
	self._formConditionTxt = goutil.findChildTextComponent(self.target, "formCondition/txt")

	GameUtil.SetActive(self.imgLocked, false)
	GameUtil.SetActive(self._atkTypeBg.gameObject, false)
	GameUtil.SetActive(self._formConditionGo, false)

	self.tag = goutil.findChild(self.target, "tag")
	self.topGo = goutil.findChild(self.target, "topGo")
	self.contract = goutil.findChild(self.target, "contract")
	self.txtContract = goutil.findChildTextComponent(self.target, "contract/txt")

	GameUtil.SetActive(self.contract, false)

	self._btn = Framework.ButtonAdapter.GetFrom(self.target, "ImgC_Bg")

	self:setLvl(0)
	self._btn:AddClickListener(self._OnClick, self)
	self:setSelected(false)

	self._isInTeam = false
	self._useLock = true
	self.starsGo = goutil.findChild(self.target, "stars")

	GameUtil.SetActive(self.starsGo, false)

	self._starItem = PetStarItem.New(self.starsGo, true)
	self._lock = goutil.findChild(self.target, "lock")

	goutil.setActive(self._lock, false)

	self.skinId = nil
	self._effectGainAllSkinGo = goutil.findChild(self.target, "effectGainAllSkin")
end

function PetCell:setData(petMo)
	self.data = petMo

	self.target:SetActive(checkbool(petMo))

	if petMo then
		self:setExtData(petMo)
		self:setLvl(petMo.level)
		self:setStars(petMo.awakeLevel)
		self:_setAtkType(petMo.curFaceId)
		self:setSkin(petMo.curFaceId)
		self:setEffGainAllSkin(petMo)
	end
end

function PetCell:setStars(awakeLevel)
	self._starItem:updateStar(awakeLevel)

	local rare = CharacterConfig.instance:getRareByAwakenLv(awakeLevel, self.cfg.raceId)

	self._ImgC_Bg:SetState(rare + 1)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	self._effSSR = self:playRareEffect(rare + 1, self.topGo)
	self._awakenLv = awakeLevel
end

function PetCell:_setAtkType(skinId)
	GameUtil.SetActive(self._atkTypeBg.gameObject, true)

	local careerClassify = PetSkinConfig.instance:getFirstJobClassify(skinId)
	local stateIndex = careerClassify - 1

	self._atkTypeBg:SetState(stateIndex)
end

function PetCell:setCfgData(petCo)
	PetCell.super.setCfgData(self, petCo)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	if self._effectGainAllSkin then
		UIEffectManager.instance:stopEffect(self._effectGainAllSkin)

		self._effectGainAllSkin = nil
	end

	self:setContractVisible(false)
	self:setGray(false)
	self:setTagShow(false)
	self:setEffGainAllSkin()

	if petCo then
		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petCo.raceId)

		race = math.fmod(race, 10)

		local targetValue = race - 1

		self._Nego_Info:SetState(targetValue)
		self:setStars(petCo.initAwakenLv)
		self:setSkin(petCo.faceIds)
		self:_setAtkType(petCo.raceId)
	else
		error("不存在的精灵配置")
	end
end

function PetCell:setSkin(skinId)
	local tem = checknumber(skinId)

	if self.skinId ~= tem then
		self.skinId = tem

		MaterialMgr.setIcon(self._ImgC_HeadIcon.gameObject, MatType.PET_SKIN, skinId)

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(self.skinId))

		if string.nilorempty(modelCo.headFrameName) then
			uGuiUtil.clearImage(self._ImgC_Frame)
			GameUtil.SetActive(self._ImgC_Frame, false)
		else
			uGuiUtil.setSpriteToImage(self._ImgC_Frame, uGuiUtil.SpriteType.BigBg, GameUrl.getPetHeadIconFrameUrl(modelCo.headFrameName))
			GameUtil.SetActive(self._ImgC_Frame, true)
		end
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	self._Nego_Info:SetState(targetValue)

	local eleIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(self.skinId)
	local isYuan = eleIdx and eleIdx == GameEnum.RaceType.Yuan or false

	GameUtil.setUIImageSpriteIdx(self.tag, 0)

	if isYuan then
		GameUtil.setUIImageSpriteIdx(self.tag, 1)
	end

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if skinCfg and checknumber(skinCfg.oracleSkillId) > 0 then
		GameUtil.setUIImageSpriteIdx(self.tag, 2)
	end

	local hasBookSpirit = ContractConfig.instance:getBookSpiritCfgs(self.cfg.raceId) ~= nil

	if hasBookSpirit == true then
		GameUtil.setUIImageSpriteIdx(self.tag, 2)
	end
end

function PetCell:setIconDirection(isNormal)
	local x, y, z = Framework.TransformUtil.GetLocalScale(self._ImgC_HeadIcon.transform, 0, 0, 0)

	x = isNormal and math.abs(x) or -math.abs(x)

	Framework.TransformUtil.SetLocalScale(self._ImgC_HeadIcon.transform, x, y, z)
end

function PetCell:setLvl(lvl)
	lvl = lvl or 0
	self.level = lvl

	if lvl > 0 then
		self._TxtC_Level.text = lvl .. "级"

		self._levelBg:SetActive(true)
	else
		self._TxtC_Level.text = ""

		self._levelBg:SetActive(false)
	end
end

function PetCell:showHireInfo()
	GameUtil.SetActive(self._hireGo, false)

	local pet = self.data

	if pet then
		local info = PetHireModel.instance:getPetInfoByPetId(pet.petId)

		if pet.isHirePet and info and info:GetCount() > 0 then
			GameUtil.SetActive(self._hireGo, true)

			self._txtHire.text = langPara("%s次", info:GetCount())
		end
	end
end

function PetCell:setExtData(pet)
	GameUtil.SetActive(self._ImgC_Support, pet.isSupportedPet or false)
	GameUtil.SetActive(self.ImgC_Lease, pet:isBorrowPet() or pet.isHirePet or false)

	if pet.isHirePet then
		GameUtil.setUIImageSpriteIdx(self.ImgC_Lease, 0)

		do
			local info = PetHireModel.instance:getPetInfoByPetId(pet.petId)

			if info and info.subType == PetHireMo.SUB_TYPE_BUDDY then
				GameUtil.setUIImageSpriteIdx(self.ImgC_Lease, 1)
			end
		end
	elseif pet:isBorrowPet() then
		GameUtil.setUIImageSpriteIdx(self.ImgC_Lease, 2)
	end

	GameUtil.SetActive(self._ImgC_Dead, pet.isDead or false)
	self:_updateIconsPosition()
end

function PetCell:setPetIsDead(isDead)
	GameUtil.SetActive(self._ImgC_Dead, isDead or false)
	self:_updateIconsPosition()
end

function PetCell:setGray(isGray)
	self._isGray = isGray

	if self.target then
		uGuiUtil.setImageGrayStateRecursive(self.target, isGray)
	end

	GameUtil.SetActive(self.imgLocked, isGray and self._useLock)
	GameUtil.SetActive(self.topGo, not isGray)
end

function PetCell:setUseLock(useLock)
	self._useLock = useLock
end

function PetCell:setLock()
	goutil.setActive(self._lock, self.data and self.data:isLocked() or false)
end

function PetCell:resetMaterial()
	return
end

function PetCell:setTagShow(boo)
	GameUtil.SetActive(self.tag, boo)
end

function PetCell:setSupportPet(isShow)
	GameUtil.SetActive(self._ImgC_Support, isShow)
	self:_updateIconsPosition()
end

function PetCell:setEffGainAllSkin(petMo)
	if self._effectGainAllSkin then
		UIEffectManager.instance:stopEffect(self._effectGainAllSkin)

		self._effectGainAllSkin = nil
	end

	if petMo and petMo.isMyPackPet == true then
		local isGainAll = PetskinController.instance:isGainAllSkinWithSkinId(petMo.curFaceId)
		local isEquipRedStarGod = petMo:isAllEquipRedStarGodMaxSlot()
		local scale = GameUtil.getLocalScale(self.target)

		if isGainAll == true and isEquipRedStarGod == true then
			local effPath = "20260724/banshenxiang/fx_ui_biankuang02.prefab"

			self._effectGainAllSkin = self:playCellEffect(effPath, self._effectGainAllSkinGo, function(target, eff)
				eff:setScaleXYZ(scale.x * 0.64, scale.y * 0.64, scale.z * 0.64)
			end)
		end
	end
end

function PetCell:OnDestroy()
	PetCell.super.OnDestroy(self)
	self:dispose()

	self.target = nil
	self.data = nil
	self._isInTeam = false
	self.skinId = nil
end

function PetCell:setEffStatus(flag)
	GameUtil.SetActive(self.topGo, flag)
end

function PetCell:setShowName(b)
	self._bShowName = b
end

function PetCell:dispose()
	PetCell.super.dispose(self)

	if self._data then
		self._data:resetCellStatus()
	end

	self.callback = nil
	self._isInTeam = false
	self._useLock = true

	self:setGray(false)
	self:setLvl(0)
	self:setSelected(false)
	self:SetInTeam(false)
	goutil.setActive(self._lock, false)
	GameUtil.SetActive(self._Nego_Attr, true)
	GameUtil.SetActive(self._ImgC_Support, false)
	GameUtil.SetActive(self.ImgC_Lease, false)
	GameUtil.SetActive(self._ImgC_Dead, false)
	GameUtil.SetActive(self._atkTypeBg.gameObject, false)
	GameUtil.SetActive(self._formConditionGo, false)
	self:setContractVisible(false)
	self:setTagShow(false)
	GameUtil.SetActive(self._hireGo, false)
	self:setIconDirection(true)

	self.skinId = nil

	MaterialMgr.clearIcon(self._ImgC_HeadIcon.gameObject)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	if self._effectGainAllSkin then
		UIEffectManager.instance:stopEffect(self._effectGainAllSkin)

		self._effectGainAllSkin = nil
	end

	self:hideStar()
end

function PetCell:setAttrActive(boo)
	GameUtil.SetActive(self._Nego_Attr, boo)
end

function PetCell:_OnClick()
	print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            PetCell:_OnClick()   ", self.data, self.autoTips, self.callback)

	if not self.autoTips or self.data then
		-- block empty
	else
		CommonTipsMgr.instance:showMaxLvlPetTips(self.cfg.raceId, self.level, self._awakenLv)
	end

	GameUtil.callBack(self.callback, self)
end

function PetCell:setClickCallBack(callback)
	self.callback = callback
	self.autoTips = false
end

function PetCell:setSelected(isSelected)
	self._ImgC_Selected.gameObject:SetActive(isSelected)
end

function PetCell:SetInTeam(isInTeam)
	self._ImgC_InTeam.gameObject:SetActive(isInTeam)

	self._isInTeam = isInTeam

	self:_updateIconsPosition()
end

function PetCell:getIsInTeam()
	return self._isInTeam
end

function PetCell:setFormConditionLabel(str)
	GameUtil.SetActive(self._formConditionGo, false)

	if not string.nilorempty(str) then
		local list = string.split(str, ",")
		local raceId = self.data:getDefineId()
		local skinId = raceId

		if self.data.curFaceId > 0 then
			skinId = self.data.curFaceId
		end

		for k, v in pairs(list) do
			local isHasJob = PetSkinConfig.instance:checkHasJob(skinId, v)
			local isHasAttr = PetSkinConfig.instance:checkHasEleAttr(skinId, v)
			local isSign = CharacterConfig.instance:checkHasSigns(raceId, v)

			if isHasJob or isHasAttr or isSign then
				GameUtil.SetActive(self._formConditionGo, true)

				self._formConditionTxt.text = v

				break
			else
				local gerderId = GameEnum.SkinGenderId[v]

				if not string.nilorempty(gerderId) then
					local isSame = PetSkinConfig.instance:checkIsSameGender(skinId, gerderId)

					if isSame then
						GameUtil.SetActive(self._formConditionGo, true)

						self._formConditionTxt.text = ConstString.SkinGenderName[v]
					end
				end
			end
		end
	end
end

function PetCell:_updateIconsPosition()
	local posx = 42
	local posy = 22
	local delta = -28

	if self._ImgC_InTeam.activeSelf then
		Framework.TransformUtil.SetLocalPos(self._ImgC_InTeam.transform, posx, posy, 0)

		posy = posy + delta
	end

	if self._ImgC_Support.activeSelf then
		Framework.TransformUtil.SetLocalPos(self._ImgC_Support.transform, posx, posy, 0)

		posy = posy + delta
	end

	if self.ImgC_Lease.activeSelf then
		Framework.TransformUtil.SetLocalPos(self.ImgC_Lease.transform, posx, posy, 0)

		posy = posy + delta
	end

	if self._ImgC_Dead.activeSelf then
		Framework.TransformUtil.SetLocalPos(self._ImgC_Dead.transform, posx, posy, 0)

		posy = posy + delta
	end
end

function PetCell:onSetBaseView(baseView)
	local petCo = CharacterConfig.instance:getPetCo(baseView.raceId)

	self:setCfgData(petCo)
	self:setLvl(baseView.curLv)
	self:setStars(baseView.awakenLv)
end

function PetCell:hideStar()
	GameUtil.SetActive(self.starsGo, false)
end

function PetCell:showStarByCustom(starNum)
	self._starItem:showStarByCustom(starNum)
	GameUtil.SetActive(self.starsGo, true)
end

function PetCell:setContractVisible(boo)
	self:setContractTag(-1, -1)
end

function PetCell:setContractTag(masterId, summonId)
	GameUtil.SetActive(self.contract, false)

	self.txtContract.text = ""

	if self.data then
		if self.data.petId == masterId then
			GameUtil.SetActive(self.contract, true)

			self.txtContract.text = lang("召唤师")
		end

		if not self.data.isMyPackPet and checknumber(self.data.summonedPetId) > 0 then
			GameUtil.SetActive(self.contract, true)

			self.txtContract.text = lang("召唤师")
		end

		if self.data.petId == summonId then
			GameUtil.SetActive(self.contract, true)

			self.txtContract.text = lang("契约精灵")
		end
	end
end

function PetCell:hideEff()
	UIEffectManager.instance:stopEffect(self._effSSR)
	UIEffectManager.instance:stopEffect(self._effectGainAllSkin)
end

return PetCell
