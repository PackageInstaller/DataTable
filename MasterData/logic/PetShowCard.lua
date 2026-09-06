-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetShowCard.lua

module("logic.extensions.bag.panel.PetShowCard", package.seeall)

local PetShowCard = class("PetShowCard")

function PetShowCard.AddOnce(go)
	return GameUtil.AddLuaOnce(go, PetShowCard)
end

function PetShowCard.Remove(go)
	local obj = GameUtil.GetLua(go, PetShowCard)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, PetShowCard)
end

function PetShowCard:ctor(go)
	self.mainGO = go.gameObject
	self.isGray = false

	self:buildUI()
	self:initEvent()
end

function PetShowCard:dispose()
	uGuiUtil.clearImage(self.con.gameObject)
	self:removeEvent()

	self._petview = nil

	if self._frontEff then
		UIEffectManager.instance:stopEffect(self._frontEff)

		self._frontEff = nil
	end

	self.maskImg.color = Framework.ColorUtil.ParseColor("#FFFFFFFF")
end

function PetShowCard:removeEvent()
	GameUtil.asBtn(self.mainGO):RemoveClickListener()
end

function PetShowCard:initEvent()
	GameUtil.asBtn(self.mainGO):AddClickListener(function()
		GameUtil.callBack(self.callBack)
	end)
end

function PetShowCard:buildUI()
	self.cover = goutil.findChild(self.mainGO, "cover")
	self.txtLvl = goutil.findChildTextComponent(self.cover, "txtLvl")
	self._imgTeam = goutil.findChild(self.cover, "imgTeam")

	GameUtil.SetActive(self._imgTeam, false)

	local bg = goutil.findChild(self.mainGO, "bg")

	self._bgS = bg:GetComponent("UIImageSpriteChange")
	self._qualitybg = GameUtil.getUIImageSpriteChange(goutil.findChild(self.cover, "qualitybg"))
	self.con = goutil.findChildImageComponent(self.mainGO, "mask/con")
	self.maskImg = goutil.findChildImageComponent(self.mainGO, "mask")

	local goAttr = goutil.findChild(self.cover, "layout/Nego_Attr/Img_attr")

	self._attrIcon = goAttr:GetComponent("UIImageSpriteChange")

	local goJob = goutil.findChild(self.cover, "layout/Nego_Job/ImgC_Job")

	self._ImgC_Job = goJob:GetComponent("UIImageSpriteChange")
	self._Nego_Job1 = goutil.findChild(self.cover, "layout/Nego_Job1")

	local goJob1ImgC = goutil.findChild(self.cover, "layout/Nego_Job1/ImgC_Job")

	self._ImgC_Job1 = goJob1ImgC:GetComponent("UIImageSpriteChange")
	self._redPoint = goutil.findChild(self.cover, "imgPoint")
	self._attrTxt = goutil.findChildTextComponent(self.cover, "txtAttr")
	self.txtLvl.text = ""
	self._goPower = goutil.findChild(self.cover, "imgPower")
	self.starsGo = goutil.findChild(self.cover, "starLv")

	GameUtil.SetActive(self.starsGo, false)

	self._starItem = PetStarItem.New(self.starsGo)
	self._lock = goutil.findChildComponent(self.cover, "lock", typeof(UIImageSpriteChange))
	self._lockBtn = Framework.ButtonAdapter.Get(self._lock.gameObject)

	self._lockBtn:AddClickListener(self._onClickLock, self)

	self._goBorrow = goutil.findChild(self.cover, "imgBorrow")
end

function PetShowCard:setClickCallBack(cb)
	self.callBack = cb
end

function PetShowCard:setPetMo(petMo, petView)
	self.txtLvl.text = petMo.level .. lang("")
	self._petview = petView

	local hasRed = BagModel.instance:getPetRedStatus(petMo.petId)

	hasRed = hasRed or PetTitleModel.instance:checkPetIsRed(petMo.raceId)

	GameUtil.SetActive(self._redPoint, hasRed)

	if self._imgTeam then
		local boo = FormationGroupModel.instance:checkIsInTeam(petMo.petId)

		GameUtil.SetActive(self._imgTeam, boo and not petMo:isBorrowPet())
	end

	GameUtil.SetActive(self._goPower, BagModel.instance:isPowerCrystalFollower(petMo.petId))
	self:setPetRaceId(petMo.raceId)
	self:setModelImg(petMo.curFaceId)
	self:_setCardRare(petMo.rare)

	local cfg = CharacterConfig.instance:getPetCo(petMo.raceId)
	local isFirst = checknumber(cfg.awakenCostStrategyId) < 0

	self._starItem:updateStar(petMo.awakeLevel, isFirst)
	self._lock:SetState(petMo:isLocked() and 1 or 0)

	self._mo = petMo

	GameUtil.SetActive(self._goBorrow, petMo:isBorrowPet())
end

function PetShowCard:setPetCfg(cfg)
	self.txtLvl.text = ""

	GameUtil.SetActive(self._redPoint, false)
	self:setPetRaceId(cfg.raceId)
	self:_setCardRare(CharacterConfig.instance:getInitRare(cfg.raceId))
end

function PetShowCard:setPetRaceId(rid)
	local cfg = CharacterConfig.instance:getPetCo(rid)

	if not cfg then
		printError("t_pet id not exist:" .. rid)

		return
	end

	if not cfg.starCount then
		-- block empty
	end
end

function PetShowCard:setModelImg(faceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(faceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(faceId)

	if self._ImgC_Job then
		self._ImgC_Job:SetState(firstJobIdx - 1)
		GameUtil.SetActive(self._Nego_Job1, false)

		if secondJobIdx > 20 then
			GameUtil.SetActive(self._Nego_Job1, true)
			self._ImgC_Job1:SetState(secondJobIdx - 1 - 20)
		end
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(faceId)
	local raceName = ConstString.Race[race]

	race = race % 10

	local targetValue = race - 1

	if self._attrIcon then
		self._attrIcon:SetState(targetValue)
	end

	if self._attrTxt then
		self._attrTxt.text = langPara("%s系", raceName)
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(faceId))

	if not modelCo then
		printError("t_model id not exist:" .. faceId)

		return
	end

	uGuiUtil.setSpriteToImage(self.con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	if self._frontEff then
		UIEffectManager.instance:stopEffect(self._frontEff)

		self._frontEff = nil
	end

	local frontEffPath = modelCo.cardEffect

	if not string.nilorempty(frontEffPath) then
		self._frontEff = UIEffectManager.instance:playEffect(self._petview, string.format("%s.prefab", frontEffPath), nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self.mainGO.transform)
			eff:setLocalPos(0, 21, 0)
			eff:setScrollRectClipping(self._petview._scrollRect)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
		self.maskImg.color = Framework.ColorUtil.ParseColor("#FFFFFF00")
	else
		self.maskImg.color = Framework.ColorUtil.ParseColor("#FFFFFFFF")
	end
end

function PetShowCard:_setCardRare(rare)
	if self._bgS then
		self._bgS:SetState(rare + 1)
	end

	self._qualitybg:SetState(rare)
end

function PetShowCard:setGray(isGray)
	self.isGray = isGray

	uGuiUtil.setGoGrayState(self.mainGO, isGray)
end

function PetShowCard:_onClickLock()
	local petId = self._mo.petId

	BagPetsController.instance:changePetLockState(petId, not self._mo:isLocked(), self._updateLock, self)
end

function PetShowCard:_updateLock(skipTip)
	local locked = self._mo:isLocked()
	local tip

	if skipTip ~= true then
		FloatWordMgr.instance:show(locked and "上锁成功~" or "解锁成功~")
	end

	self._lock:SetState(locked and 1 or 0)
end

return PetShowCard
