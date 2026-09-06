-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetShowCardExt.lua

module("logic.extensions.bag.panel.PetShowCardExt", package.seeall)

local PetShowCardExt = class("PetShowCardExt")
local kejuexingPath = "20250228/jinglingjiemian/fx_jingling_kejuexing.prefab"
local zhidingPath = "20250228/jinglingjiemian/fx_jingling_zhiding.prefab"
local downImageResWithJob = {
	[GameEnum.CareerType.SourceTrace] = "board_yuanqi_12"
}
local downImagePosWithJob = {
	[GameEnum.CareerType.SourceTrace] = {
		1,
		-117
	}
}

function PetShowCardExt.AddOnce(go)
	return GameUtil.AddLuaOnce(go, PetShowCardExt)
end

function PetShowCardExt.Remove(go)
	local obj = GameUtil.GetLua(go, PetShowCardExt)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, PetShowCardExt)
end

function PetShowCardExt:ctor(go)
	self.mainGO = go.gameObject
	self.isGray = false
	self._isGainAllSkin = false

	self:buildUI()
	self:initEvent()
end

function PetShowCardExt:dispose()
	self:removeEvent()

	self._petview = nil

	if self._frontEff then
		UIEffectManager.instance:stopEffect(self._frontEff)

		self._frontEff = nil
	end

	if self._petAnim then
		self._petAnim:dispose()

		self._petAnim = nil
	end

	self.maskImg.color = Framework.ColorUtil.ParseColor("#FFFFFFFF")

	if self._effectGainAllSkin then
		UIEffectManager.instance:stopEffect(self._effectGainAllSkin)
	end
end

function PetShowCardExt:removeEvent()
	GameUtil.asBtn(self.mainGO):RemoveClickListener()
end

function PetShowCardExt:initEvent()
	GameUtil.asBtn(self.mainGO):AddClickListener(function()
		GameUtil.callBack(self.callBack)
	end)
end

function PetShowCardExt:buildUI()
	self._effmidGo = goutil.findChild(self.mainGO, "effmid")
	self.cover = goutil.findChild(self.mainGO, "cover")
	self.txtLvl = goutil.findChildTextComponent(self.cover, "txtLvl")
	self._imgTeam = goutil.findChild(self.cover, "imgTeam")
	self._imgTempTeam = goutil.findChild(self.cover, "imgTempTeam")

	GameUtil.SetActive(self._imgTeam, false)
	GameUtil.SetActive(self._imgTempTeam, false)

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
	self._imgChangeDown = goutil.findChildComponent(self.cover, "imgDown", ComponentType.UIImageSpriteChange)
	self._attrBg = goutil.findChild(self.cover, "attrbg")

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

	self._awakeTextGo = goutil.findChild(self.cover, "awakeImg")
	self._topGo = goutil.findChild(self.cover, "topImg")
	self._goBorrow = goutil.findChild(self.cover, "imgBorrow")
	self._frame = goutil.findChild(self.cover, "frame")
	self._effectGainAllSkinGo = goutil.findChild(self.mainGO, "effGainAllSkin")
end

function PetShowCardExt:setClickCallBack(cb)
	self.callBack = cb
end

function PetShowCardExt:setPetMo(petMo, petView)
	self.txtLvl.text = petMo.level .. lang("")
	self._petview = petView

	local hasRed = BagModel.instance:getPetRedStatus(petMo.petId)

	hasRed = hasRed or PetTitleModel.instance:checkPetIsRed(petMo.raceId)

	GameUtil.SetActive(self._redPoint, hasRed)

	if self._awakeTextGo then
		local isShowAwake = BagModel.instance:getPetAwakeStatus(petMo.petId)

		if isShowAwake then
			self._petview:playViewEffectUniGo(kejuexingPath, self._awakeTextGo, self._petview._viewportGo)
		else
			self._petview:stopViewEffectUniGo(self._awakeTextGo)
		end
	end

	if self._topGo then
		if BagPetsController.instance:getPetIsTop(petMo.petId) then
			self._petview:playViewEffectUniGo(zhidingPath, self._topGo, self._petview._viewportGo)
		else
			self._petview:stopViewEffectUniGo(self._topGo)
		end
	end

	local isTempTeam = BagModel.instance:isPetViewTempTopPet(petMo.petId)

	if self._imgTempTeam then
		GameUtil.SetActive(self._imgTempTeam, isTempTeam)
	end

	if self._imgTeam then
		local boo = FormationGroupModel.instance:checkIsInTeam(petMo.petId)

		GameUtil.SetActive(self._imgTeam, not isTempTeam and boo and not petMo:isBorrowPet())
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

	local isGainAll = PetskinController.instance:isGainAllSkinWithSkinId(petMo.curFaceId)
	local isEquipRedStarGod = petMo:isAllEquipRedStarGodMaxSlot()

	self._isGainAllSkin = isGainAll == true and isEquipRedStarGod == true

	if self._effectGainAllSkin then
		UIEffectManager.instance:stopEffect(self._effectGainAllSkin)

		self._effectGainAllSkin = nil
	end

	if self._isGainAllSkin and self._isGainAllSkin == true then
		local effPath = "20260724/banshenxiang/fx_ui_biankuang01.prefab"

		self._effectGainAllSkin = UIEffectManager.instance:playEffect(self._petview, effPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self._effectGainAllSkinGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScrollRectClipping(self._petview._scrollRect)
			eff:setScaleXYZ(1)
		end)
	end

	GameUtil.SetActive(self._goBorrow, not isTempTeam and petMo:isBorrowPet())

	local downImageName = "com_pinzhi00_1"

	for careerType, name in pairs(downImageResWithJob) do
		if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, careerType) == true then
			downImageName = name

			break
		end
	end

	local downImagePos = {
		3,
		-115
	}

	for careerType, pos in pairs(downImagePosWithJob) do
		if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, careerType) == true then
			downImagePos = pos

			break
		end
	end

	self._imgChangeDown:ChangeSprite(downImageName)
	GameUtil.setAnchoredPos(self._imgChangeDown.gameObject, downImagePos[1], downImagePos[2])
	self._imgChangeDown.gameObject:GetComponent(goutil.Type_UIImage):SetNativeSize()
end

function PetShowCardExt:setPetCfg(cfg)
	self.txtLvl.text = ""

	GameUtil.SetActive(self._redPoint, false)
	self:setPetRaceId(cfg.raceId)
	self:_setCardRare(CharacterConfig.instance:getInitRare(cfg.raceId))
end

function PetShowCardExt:setPetRaceId(rid)
	local cfg = CharacterConfig.instance:getPetCo(rid)

	if not cfg then
		printError("t_pet id not exist:" .. rid)

		return
	end

	if not cfg.starCount then
		-- block empty
	end
end

function PetShowCardExt:setModelImg(faceId)
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

	if self._petAnim then
		self._petAnim:dispose()

		self._petAnim = nil
	end

	self:updateCardImage(self.con.gameObject, modelCo)

	if self._frontEff then
		UIEffectManager.instance:stopEffect(self._frontEff)

		self._frontEff = nil
	end

	local frontEffPath = modelCo.cardEffect

	if not string.nilorempty(frontEffPath) then
		self._frontEff = UIEffectManager.instance:playEffect(self._petview, string.format("%s.prefab", frontEffPath), nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self._effmidGo.transform)
			eff:setLocalPos(0, 21, 0)
			eff:setScrollRectClipping(self._petview._scrollRect)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
		self.maskImg.color = Framework.ColorUtil.ParseColor("#FFFFFF00")
	else
		self.maskImg.color = Framework.ColorUtil.ParseColor("#FFFFFFFF")
	end

	local frameRes = modelCo.bagCardFrame

	uGuiUtil.clearImage(self._frame)

	if not string.nilorempty(frameRes) then
		GameUtil.SetActive(self._frame, true)
		GameUtil.SetActive(self._imgChangeDown, false)
		GameUtil.SetActive(self._attrBg, false)

		local frameResPath = GameUrl.getPetCarFrameUrl(frameRes)

		uGuiUtil.setSpriteToImage(self._frame, uGuiUtil.SpriteType.BigBg, frameResPath)
		self._frame.gameObject:GetComponent(goutil.Type_UIImage):SetNativeSize()
	else
		GameUtil.SetActive(self._frame, false)
		GameUtil.SetActive(self._imgChangeDown, true)
		GameUtil.SetActive(self._attrBg, true)
	end
end

function PetShowCardExt:_setCardRare(rare)
	if self._bgS then
		self._bgS:SetState(rare + 1)
	end

	self._qualitybg:SetState(rare)
end

function PetShowCardExt:setGray(isGray)
	self.isGray = isGray

	uGuiUtil.setGoGrayState(self.mainGO, isGray)
end

function PetShowCardExt:_onClickLock()
	local petId = self._mo.petId

	BagPetsController.instance:changePetLockState(petId, not self._mo:isLocked(), self._updateLock, self)
end

function PetShowCardExt:_updateLock(skipTip)
	local locked = self._mo:isLocked()
	local tip

	if skipTip ~= true then
		FloatWordMgr.instance:show(locked and "上锁成功~" or "解锁成功~")
	end

	self._lock:SetState(locked and 1 or 0)
end

function PetShowCardExt:updateCardImage(petCon, modelCo)
	if string.nilorempty(modelCo.cardFrameAnim) then
		uGuiUtil.setSpriteToImage(self.con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	else
		local count = 20
		local fps = 20

		if modelCo.cardFrameAnimParam then
			count = checknumber(modelCo.cardFrameAnimParam[1])
			fps = checknumber(modelCo.cardFrameAnimParam[2])
		end

		if count == 0 then
			count = 20
		end

		if fps == 0 then
			fps = 20
		end

		self:addPetAnimRes(self.con.gameObject, modelCo.cardFrameAnim, count, fps)
	end
end

function PetShowCardExt:addPetAnimRes(petCon, resPath, count, fps)
	local urlList = {}

	for i = 1, count do
		local url = GameUrl.getPetFrameAnimUrl(resPath, i)

		table.insert(urlList, url)
	end

	self._petAnim = ImageSpriteAnimComponent.New(petCon)

	self._petAnim:loadImageAnim(urlList)
	self._petAnim:setFps(fps)
end

return PetShowCardExt
