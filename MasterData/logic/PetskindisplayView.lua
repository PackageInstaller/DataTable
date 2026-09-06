-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetskindisplayView.lua

module("logic.extensions.petskin.view.PetskindisplayView", package.seeall)

local PetskindisplayView = class("PetskindisplayView", ViewComponent)

function PetskindisplayView:ctor()
	PetskindisplayView.super.ctor(self)
end

function PetskindisplayView:buildUI()
	PetskindisplayView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.skin = self:getGo("skin")
	self.rare = self:getGo("rare")
	self.quality = self:getGo("quality")
	self.imgSex = self:getGo("imgSex")
	self.passive = self:getGo("passive")
	self.txtPassiveDesc = self:getTxt("passive/txtDesc")
	self.btnWear = self:getGo("btnWear")
	self.cell = self:getGo("cell")
	self.txtName = self:getTxt("txtName")
	self.txtDesc = self:getTxt("ScrollView/Viewport/txtDesc")
	self.txtAttr = self:getTxt("txtAttr")
	self.txtTime = self:getTxt("txtTime")
	self.btnShare = self:getBtn("btnShare")
	self._petQualityNumTextComp = self:getGo("petQualityNum"):GetComponent(typeof(UIImgNumeralText))
	self._petNumTextComp = self:getGo("petNum"):GetComponent(typeof(UIImgNumeralText))
	self._getQualityChangeComp = self:getGo("getQuality"):GetComponent("UIImageSpriteChange")
end

function PetskindisplayView:bindEvents()
	PetskindisplayView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.onClickClose, self)
	GameUtil.addClickHandler(self.btnWear, self.onWearClick, self)
	GameUtil.addClickHandler(self.btnShare, self.onShareClick, self)
end

function PetskindisplayView:unbindEvents()
	PetskindisplayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnWear)
	GameUtil.rmClickHandler(self.btnShare)
end

function PetskindisplayView:destroyUI()
	PetskindisplayView.super.destroyUI(self)
end

function PetskindisplayView:onEnter()
	PetskindisplayView.super.onEnter(self)

	self._isPlaying = false

	self:showNext()
end

function PetskindisplayView:onEnterFinished()
	PetskindisplayView.super.onEnterFinished(self)
end

function PetskindisplayView:onExit()
	PetskindisplayView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._isPlaying = false

	ViewBlockMgr.instance:blockClick(false, self)

	local icon = goutil.findChild(self.cell, "mask/skin")

	uGuiUtil.clearImage(icon.gameObject)
end

function PetskindisplayView:onExitFinished()
	PetskindisplayView.super.onExitFinished(self)
end

function PetskindisplayView:showNext()
	if self.currMo == nil then
		self.currMo = PetskinController.instance:getNextShowMo()
	end

	if self.currMo == nil then
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.OnMaterialPopEnd)

		return
	end

	local isSuccessPlay = false

	if not self._isPlaying then
		local skinId = checknumber(self.currMo:getDefineId())
		local modelCo = CharacterConfig.instance:getModelCo(skinId)

		if modelCo then
			local path = modelCo.enterAnimPath

			if not string.nilorempty(path) then
				local animPath = path .. ".txt"

				local function onAnimPlayStart()
					self._isPlaying = true

					ViewBlockMgr.instance:blockClick(true, self)
				end

				local function onAnimPlayFinish()
					self._isPlaying = false

					ViewBlockMgr.instance:blockClick(false, self)
					self:showPetskinMo(self.currMo)
				end

				AnimationPlayer.play(animPath, onAnimPlayFinish, onAnimPlayStart, self)

				isSuccessPlay = true
			end
		end
	end

	if not isSuccessPlay then
		self:showPetskinMo(self.currMo)
	end
end

function PetskindisplayView:showPetskinMo(mo)
	self.txtName.text = ""
	self.txtDesc.text = ""

	local skinId = checknumber(mo:getDefineId())
	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self.skin, scale, nil, true, x, y)

	self:updateCell(skinId)

	self.txtTime.text = ""

	GameUtil.SetActive(self.quality, false)
	GameUtil.SetActive(self.imgSex, false)

	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		self.txtName.text = cfg.skinName
		self.txtDesc.text = cfg.desc

		GameUtil.SetActive(self.passive, not string.nilorempty(cfg.buffDes))

		self.txtPassiveDesc.text = cfg.buffDes

		local arr = GameUtil.propToList({
			cfg.propertyApp
		})
		local str = ""

		for k, v in pairs(arr) do
			local tem = GameUtil.getValueOrPercent(v.value)

			str = str .. v.name .. ":<color=#00ff00>+" .. tem .. "</color>\t"
		end

		self.txtAttr.text = langPara("属性加成：%s", str)

		if cfg.quality > 0 then
			GameUtil.SetActive(self.quality, true)
			GameUtil.setUIImageSpriteIdx(self.quality, cfg.quality)
		end

		if checknumber(cfg.isChangeSex) == 1 then
			GameUtil.SetActive(self.imgSex, true)
			GameUtil.SetActive(self.quality, false)
		end
	end

	local data = PetskinModel.instance:getSkinInfoById(skinId)

	if data then
		local time = checknumber(data.expireTimeMillis)

		if time > 0 then
			time = time / 1000

			local now = ServerTime.now()
			local limit = math.max(0, time - now)

			self.txtTime.text = langPara("剩余体验时间:<color=#00ff00>%s</color>", GameUtil.FormatTimeSymbol(limit, true))
		end

		PetbookModel.instance:setSkinQuality(nil)

		local list, skinNum = PetbookModel.instance:getFilterSkinList()
		local qualityNum = PetskinModel.instance:getUserOwnSkinNumByQuality(cfg.quality)
		local qualityCfgList = PetSkinConfig.instance:getPetSkinListByQuality(cfg.quality)

		if qualityCfgList then
			if not #qualityCfgList then
				local owned = 0

				PetbookModel.instance:setSkinQuality(cfg.quality)

				self._allPet, owned = PetbookModel.instance:getFilterSkinList()

				PetbookModel.instance:setSkinQuality(nil)
				self._petNumTextComp:SetNum(skinNum)
				self._petQualityNumTextComp:SetNum(owned)
				self._getQualityChangeComp:SetState(cfg.quality)
			end
		end
	end
end

function PetskindisplayView:updateCell(skinId)
	local cell = self.cell
	local icon = goutil.findChild(cell, "mask/skin")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtState = goutil.findChildTextComponent(cell, "txtState")
	local top = goutil.findChild(cell, "top")
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		txtName.text = cfg.skinName
	end
end

function PetskindisplayView:onWearClick()
	if self.currMo then
		local skinId = checknumber(self.currMo:getDefineId())
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			if not PetSkinConfig.instance:isExistSkinGroup(skinId) then
				local raceId = cfg.raceId
				local targetPetId = BagModel.instance:getPetIdByRaceId(raceId)

				if targetPetId then
					BagPetsController.instance:SetCurPetId(targetPetId)

					self.currMo = nil

					PetskinController.instance:clearMo()
					self:close()

					local mo = BagPetsController.instance:GetCurPetMo()

					UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_PET_MO, mo, skinId)
				else
					local tip = lang("暂未获得此精灵")

					FloatWordMgr.instance:show(tip)
				end
			else
				local function onWearSuccessCallback()
					self:onClickClose()
				end

				UIStateManager.instance:push(ViewName.PetSkinWearView, skinId, onWearSuccessCallback)
			end
		end
	end
end

function PetskindisplayView:onClickClose()
	self.currMo = nil

	self:showNext()
end

function PetskindisplayView:onShareClick()
	ShareController.instance:share(1, {
		self.btnShare.gameObject
	})
end

return PetskindisplayView
