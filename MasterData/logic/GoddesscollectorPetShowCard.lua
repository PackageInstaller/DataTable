-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorPetShowCard.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorGoddesscollectorPetShowCard", package.seeall)

local GoddesscollectorPetShowCard = class("GoddesscollectorPetShowCard")

function GoddesscollectorPetShowCard.AddOnce(go)
	return GameUtil.AddLuaOnce(go, GoddesscollectorPetShowCard)
end

function GoddesscollectorPetShowCard.Remove(go)
	local obj = GameUtil.GetLua(go, GoddesscollectorPetShowCard)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, GoddesscollectorPetShowCard)
end

function GoddesscollectorPetShowCard:ctor(go)
	self.mainGO = go.gameObject
	self.isGray = false

	self:buildUI()
	self:initEvent()
end

function GoddesscollectorPetShowCard:dispose()
	uGuiUtil.clearImage(self.con.gameObject)
	self:removeEvent()
end

function GoddesscollectorPetShowCard:removeEvent()
	GameUtil.asBtn(self.mainGO):RemoveClickListener()
end

function GoddesscollectorPetShowCard:initEvent()
	GameUtil.asBtn(self.mainGO):AddClickListener(function()
		GameUtil.callBack(self.callBack)
	end)
end

function GoddesscollectorPetShowCard:buildUI()
	local bg = goutil.findChild(self.mainGO, "bg")

	self._bgS = bg:GetComponent("UIImageSpriteChange")
	self._qualitybg = GameUtil.getUIChangeGroup(goutil.findChild(self.mainGO, "qualitybg"))
	self.con = goutil.findChildImageComponent(self.mainGO, "mask/con")

	local goAttr = goutil.findChild(self.mainGO, "layout/Nego_Attr/Img_attr")

	self._attrIcon = goAttr:GetComponent("UIImageSpriteChange")

	local goJob = goutil.findChild(self.mainGO, "layout/Nego_Job/ImgC_Job")

	self._ImgC_Job = goJob:GetComponent("UIImageSpriteChange")
	self._Nego_Job = goutil.findChild(self.mainGO, "layout/Nego_Job")
	self._Nego_Job1 = goutil.findChild(self.mainGO, "layout/Nego_Job1")

	local goJob1ImgC = goutil.findChild(self.mainGO, "layout/Nego_Job1/ImgC_Job")

	self._ImgC_Job1 = goJob1ImgC:GetComponent("UIImageSpriteChange")
	self._redPoint = goutil.findChild(self.mainGO, "imgPoint")
	self._attrTxt = goutil.findChildTextComponent(self.mainGO, "txtAttr")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._lockGo = goutil.findChild(self.mainGO, "lock")
end

function GoddesscollectorPetShowCard:setClickCallBack(cb)
	self.callBack = cb
end

function GoddesscollectorPetShowCard:setPetCfg(cfg, viewType)
	self._viewType = viewType
	self._cfg = cfg

	local raceId = cfg.raceId

	self._skinId = cfg.skinId or raceId

	if self:_isSkin() then
		local pcfg = PetSkinConfig.instance:getPetSkinCfg(cfg.skinId)

		raceId = pcfg.raceId
	end

	local hasRed = false

	GameUtil.SetActive(self._redPoint, hasRed)
	self:setModelImg(self._skinId)
	self:_setCardRare(raceId)
	self:_setName(raceId)
	self:_setLockStatus()
end

function GoddesscollectorPetShowCard:setModelImg(faceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(faceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(faceId)

	GameUtil.SetActive(self._Nego_Job, false)
	GameUtil.SetActive(self._Nego_Job1, false)

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
end

function GoddesscollectorPetShowCard:_setCardRare(raceId)
	if self._bgS then
		self._bgS:SetState(self:_isSkin() and 1 or 0)
	end

	self._qualitybg:SetState(self:_isSkin() and 1 or 0)
end

function GoddesscollectorPetShowCard:_setName(raceId)
	self._txtName.text = self._cfg.name
end

function GoddesscollectorPetShowCard:_setLockStatus()
	local isUnLock = false

	isUnLock = self:_isSkin() and GoddesscollectorModel.instance:isSkinCollect(self._cfg.id) or GoddesscollectorModel.instance:isPetCollect(self._cfg.id)

	goutil.setActive(self._lockGo, false)
	GameUtil.SetGray(self.mainGO, not isUnLock)
end

function GoddesscollectorPetShowCard:_isSkin()
	return self._viewType == GoddesscollectorpetsView.ViewType.PetSkins
end

return GoddesscollectorPetShowCard
