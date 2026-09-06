-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/pet/PetSkinCell.lua

module("logic.extensions.material.proxy.pet.PetSkinCell", package.seeall)

local PetSkinCell = class("PetSkinCell", MaterialCell)

function PetSkinCell:ctor(target)
	PetSkinCell.super.ctor(self, target)

	self.container = goutil.findChild(target.gameObject, "container")
	self.imgQua = goutil.findChildComponent(self.container, "imgQua", "UIImageSpriteChange")
	self.imgIcon = goutil.findChild(self.container, "imgIcon/con")
	self.hasPet = goutil.findChild(self.container, "hasPet")
	self.imgRare = goutil.findChild(self.container, "imgRare")
	self.imgSelected = goutil.findChild(self.container, "selected")
	self._txtBg = goutil.findChild(self.container, "txtBg")
	self.skinTime = goutil.findChild(self.container, "skinTime")
	self.txtSkinTime = goutil.findChildTextComponent(self.container, "skinTime/txt")
	self._txtNum = goutil.findChild(self.container, "txtNum"):GetComponent(goutil.Type_UIText)
	self._tagGo = goutil.findChild(self.container, "tag")
	self._txtTag = goutil.findChild(self.container, "tag/txt"):GetComponent(goutil.Type_UIText)
	self.withTag = goutil.findChild(self.container, "withTag")
end

function PetSkinCell:setCfgData(data)
	PetSkinCell.super.setCfgData(self, data)
	self:setTagVisible(true)
	GameUtil.SetActive(self.skinTime, false)
	GameUtil.addClickHandler(self.container, self._OnClick, self)
	GameUtil.SetActive(self.hasPet, false)

	local raceId = 0
	local cfg = PetSkinConfig.instance:getPetSkinCfg(data.skinId)

	if cfg then
		raceId = cfg.raceId

		local isHasPet = false

		if cfg.skinGroup > 0 then
			local checkRaceIds = {}
			local skinCfgs = PetSkinConfig.instance:getPetSkinListBySkinGroup(cfg.skinGroup)

			for i, v in ipairs(skinCfgs) do
				checkRaceIds[v.raceId] = true
			end

			for checkRaceId, v in pairs(checkRaceIds) do
				if BagModel.instance:isExistRaceId(checkRaceId) == true then
					isHasPet = true

					break
				end
			end
		elseif BagModel.instance:isExistRaceId(cfg.raceId) == true then
			isHasPet = true
		end

		GameUtil.SetActive(self.hasPet, not isHasPet)
	end

	local rare = CharacterConfig.instance:getRareByAwakenLv(data.initAwakenLv, raceId)

	self.imgQua:SetState(rare + 1)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))

	uGuiUtil.setSpriteToImage(self.imgIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	self:setNum(0)
	GameUtil.SetActive(self.skinTime, false)

	if raceId > 0 then
		self._txtTag.text = raceId == data.skinId and "精灵" or "皮肤"
	end

	local isWith = MaterialMgr.isWithInSkinPrize(self.type, self.id)
	local withState = isWith and 1 or 0

	self:setWithTag(withState)
end

function PetSkinCell:_OnClick()
	print(">>>>>>>>>>> click PetSkinCell")

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.imgIcon, self.type, self.id, self.num)
	end

	GameUtil.callBack(self.callback)
end

function PetSkinCell:setSelected(isSelected)
	GameUtil.SetActive(self.imgSelected, isSelected)
end

function PetSkinCell:setNum(num)
	if num <= 0 then
		self._txtBg:SetActive(false)
		self._txtNum.gameObject:SetActive(false)
	else
		self._txtBg:SetActive(true)
		self._txtNum.gameObject:SetActive(true)

		self._txtNum.text = num
	end
end

function PetSkinCell:setWithTag(state)
	GameUtil.SetActive(self.withTag, state == 1)
end

function PetSkinCell:setTagVisible(isVisible)
	GameUtil.SetActive(self._tagGo, isVisible)
end

function PetSkinCell:updateTimes()
	GameUtil.SetActive(self.skinTime, false)
	self:stopTimer()

	local skinStatus = PetskinController.instance:checkHasSkinStatus(self.cfg)

	if skinStatus == PetskinController.SKIN_STATUS_HAD then
		-- block empty
	elseif skinStatus == PetskinController.SKIN_STATUS_ORIGINAL then
		-- block empty
	elseif skinStatus == PetskinController.SKIN_STATUS_NOT then
		-- block empty
	else
		GameUtil.SetActive(self.skinTime, true)

		local time = checknumber(skinStatus)

		self:startTimer(time)
	end
end

function PetSkinCell:startTimer(time)
	self:stopTimer()

	self.limitTime = time

	self:onTimer()
	settimer(1, self.onTimer, self, true)
end

function PetSkinCell:stopTimer()
	self.limitTime = nil

	removetimer(self.onTimer, self)
end

function PetSkinCell:onTimer()
	local time = checknumber(self.limitTime)
	local now = ServerTime.now()
	local limit = math.max(0, time - now)

	self.txtSkinTime.text = GameUtil.FormatTimeSymbol(limit, true)

	if limit <= 0 then
		GameUtil.SetActive(self.skinTime, false)
		self:stopTimer()
	end
end

function PetSkinCell:dispose()
	PetSkinCell.super.dispose(self)

	self.callback = nil

	self:setSelected(false)
	MaterialMgr.resetAll(self.imgRare)
	GameUtil.rmClickHandler(self.container)
	self:stopTimer()
	self:setWithTag(0)
end

return PetSkinCell
