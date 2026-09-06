-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/mibaogoodsitem/PayShopSellPetGoodsItem.lua

module("logic.extensions.payshop.view.mibaogoodsitem.PayShopSellPetGoodsItem", package.seeall)

local PayShopSellPetGoodsItem = class("PayShopSellPetGoodsItem", PayShopMibaoGoodsItemBase)

function PayShopSellPetGoodsItem:buildUI()
	PayShopSellPetGoodsItem.super.buildUI(self)

	self._goPetImg = goutil.findChild(self.mainGO, "sellPet/petImg")
	self._goSellPet = goutil.findChild(self.mainGO, "sellPet")
	self._goLeftTime = goutil.findChild(self.mainGO, "limitTime")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "limitTime/txt")
	self._txtPetName = goutil.findChildTextComponent(self.mainGO, "sellPet/txtPetName")
	self._txtJump = self:getTxt("txtJump")
	self._txtTagDesc = self:getTxt("tagImg/txtTagDesc")
	self._goTagImg = self:getGo("tagImg")
	self._qualityImgChange = self:getGo("sellPet/qualityImg"):GetComponent(ComponentType.UIImageSpriteChange)
end

function PayShopSellPetGoodsItem:onEnter(refTarget, scrollRect, data, showLeftTime)
	self._sellType = data.sellType
	self._sellKey = data.sellKey

	self:_resetValue()
	PayShopSellPetGoodsItem.super.onEnter(self, refTarget, scrollRect, data, showLeftTime)
	self:_showGoodsLeftTime()
	self:_setTagDesc()
end

function PayShopSellPetGoodsItem:onExit()
	PayShopSellPetGoodsItem.super.onExit(self)
	uGuiUtil.clearImage(self._goPetImg)

	self._mountActiveItems = nil

	removetimer(self._updateTimer, self)
	removetimer(self._updateLimitSellTime, self)
end

function PayShopSellPetGoodsItem:_resetValue()
	removetimer(self._updateTimer, self)
	removetimer(self._updateLimitSellTime, self)
	goutil.setActive(self._goTagImg, false)
end

function PayShopSellPetGoodsItem:_onClickBuy(showTips)
	if PayShopModel.GoodsIdNeedJump[self._goodsCfg.id] then
		GotoMgr.gotoByString(PayShopModel.GoodsIdNeedJump[self._goodsCfg.id])

		return
	end

	if not string.nilorempty(self._sellKey) then
		local bestPlanId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._goodsCfg.id)

		UIStateManager.instance:push(ViewName.PayshoppetdetailView, self._sellKey, self._goodsCfg.id, bestPlanId, self._showLeftTime, true)
		UIStateManager.instance:popByName(ViewName.PayShopMainView)
	else
		if self:_isJumpGoods() then
			GotoMgr.gotoByString(self._goodsCfg.jumpTo)

			return
		end

		PayShopSellPetGoodsItem.super._onClickBuy(self)
	end
end

function PayShopSellPetGoodsItem:_checkGoodsSellOut(goodsCfg)
	local isSellOut = PayShopSellPetGoodsItem.super._checkGoodsSellOut(self, goodsCfg)

	isSellOut = isSellOut or self:_checkSellKeySellOut(goodsCfg.content)

	return isSellOut
end

function PayShopSellPetGoodsItem:setIcon(goodsCfg)
	if self._sellKey == GameEnum.PayShopTabSellType.SellPet then
		self:_setSellPetIcon(goodsCfg)
	elseif self._sellKey == GameEnum.PayShopTabSellType.SellSkin then
		self:_setSellSkinIcon(goodsCfg)
	elseif self._sellKey == GameEnum.PayShopTabSellType.SellMount then
		self:_setSellMountIcon(goodsCfg)
	end
end

function PayShopSellPetGoodsItem:_setSellPetIcon(goodsCfg)
	local temp = string.split(goodsCfg.content, "#")

	for i, v in ipairs(temp) do
		local arr = string.split(v, ":")
		local matType = checknumber(arr[1])

		if matType == MatType.Pet then
			local raceId = checknumber(arr[2])
			local modelCo = CharacterConfig.instance:getModelCo(raceId)

			if modelCo then
				uGuiUtil.setSpriteToImage(self._goPetImg, nil, GameUrl.getPetImgUrl(modelCo.cardName))
			end

			break
		end
	end
end

function PayShopSellPetGoodsItem:_setSellSkinIcon(goodsCfg)
	local temp = string.split(goodsCfg.content, "#")

	for i, v in ipairs(temp) do
		local arr = string.split(v, ":")
		local matType = checknumber(arr[1])

		if matType == MatType.PET_SKIN then
			local raceId = checknumber(arr[2])
			local modelCo = CharacterConfig.instance:getModelCo(raceId)

			if modelCo then
				uGuiUtil.setSpriteToImage(self._goPetImg, nil, GameUrl.getPetImgUrl(modelCo.cardName))
			end

			break
		end
	end
end

function PayShopSellPetGoodsItem:_setSellMountIcon(goodsCfg)
	goutil.setActive(self._goSellPet, true)

	local temp = string.split(goodsCfg.content, "#")

	for i, v in ipairs(temp) do
		local arr = string.split(v, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])
		local mountId = MountConfig.instance:getMountInMap(matType, matId)
		local mountCfg

		if mountId then
			mountCfg = MountConfig.instance:getMountCo(mountId)
		end

		if mountCfg then
			uGuiUtil.setSpriteToImage(self._goPetImg, nil, GameUrl.getBigbgFolderUrl("mount", mountCfg.cardName))

			return
		end
	end
end

function PayShopSellPetGoodsItem:_isSellPet()
	return self._sellKey == GameEnum.PayShopTabSellType.SellPet
end

function PayShopSellPetGoodsItem:_isSellPetSkin()
	return self._sellKey == GameEnum.PayShopTabSellType.SellSkin
end

function PayShopSellPetGoodsItem:_isSellMount()
	return self._sellKey == GameEnum.PayShopTabSellType.SellMount
end

function PayShopSellPetGoodsItem:_checkSellKeySellOut(content)
	local isSellOut = false

	if not self.isSellOut then
		if self:_isSellMount() then
			local arr = string.split(content, "#")

			for i, str in ipairs(arr) do
				local type, id, num = MaterialMgr.getMatParams(str)
				local mountId = MountConfig.instance:getMountInMap(type, id)

				if mountId ~= nil and (MaterialModel.instance:getMaterialsNumber(type, id) > 0 or MountModel.instance:getLockmountsById(mountId) ~= false) then
					isSellOut = true

					break
				end
			end
		elseif self:_isSellPetSkin() and (string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":")) then
			local arr1 = string.split(content, "#")

			for i, v in ipairs(arr1) do
				if string.find(v, "^" .. MatType.PET_SKIN .. ":") then
					local arr2 = string.split(v, ":")
					local matId = checkint(arr2[2])
					local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(matId)
					local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

					isSellOut = skinStatus == PetskinController.SKIN_STATUS_HAD

					break
				end
			end
		end
	end

	return isSellOut
end

function PayShopSellPetGoodsItem:_setLimitContent(goodsCfg)
	return
end

function PayShopSellPetGoodsItem:_showGoodsLeftTime()
	self._showLeftTime = false

	local showLeftTime = false

	self._showLeftTime = showLeftTime

	goutil.setActive(self._goLeftTime, showLeftTime)
end

function PayShopSellPetGoodsItem:_setActLeftTime(time)
	self._destTime = time

	if self._destTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function PayShopSellPetGoodsItem:_updateTimer()
	self._leftTime = self._destTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtLeftTime.text = self._leftTime > 86400 and string.format("剩余:%s", GameUtil.FormatTimeWordsNoSec(self._leftTime)) or string.format("剩余:%s", GameUtil.FormatTimeWords(self._leftTime))
	else
		self:_actEndOp()
	end
end

function PayShopSellPetGoodsItem:_actEndOp()
	self._txtLeftTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function PayShopSellPetGoodsItem:_setGoodsName(goodsCfg)
	PayShopSellPetGoodsItem.super._setGoodsName(self, goodsCfg)

	self._txtPetName.text = ""

	if self:_isSellPetSkin() then
		local temp = string.split(goodsCfg.content, "#")

		for i, v in ipairs(temp) do
			local arr = string.split(v, ":")
			local matType = checknumber(arr[1])

			if matType == MatType.PET_SKIN then
				local skinId = checknumber(arr[2])
				local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

				if skinCfg then
					self._txtName.text = skinCfg.skinName
					self._txtPetName.text = skinCfg.name

					self:_setRareImg(skinCfg.quality)

					if self._showLeftTime then
						Framework.TransformUtil.SetAnchoredPos(self._txtPetName.transform, 0, -60)

						break
					end

					Framework.TransformUtil.SetAnchoredPos(self._txtPetName.transform, 0, -90)
				end

				break
			end
		end
	else
		self:_setRareImg()
	end
end

function PayShopSellPetGoodsItem:_getLimitTxt()
	return
end

function PayShopSellPetGoodsItem:_setTagDesc()
	self._txtTagDesc.text = ""

	local hasTag = false

	if not string.nilorempty(self._goodsCfg.tagParam) then
		local list = PayShopModel.instance:parseGoodsTagParam2Table(self._goodsCfg.tagParam)

		table.sort(list, function(a, b)
			return GameEnum.PayshopSellSkinTagRank[a.id] < GameEnum.PayshopSellSkinTagRank[b.id]
		end)

		for i, v in ipairs(list) do
			local id = v.id

			if id == GameEnum.PayshopSellSkinTagType.LimitSell then
				local endTime = GameUtil.string2time(self._goodsCfg.offlineTime)
				local leftTime = endTime - ServerTime.nowServerLook()

				if leftTime > 0 then
					self._limitSellEndTime = endTime

					settimer(1, self._updateLimitSellTime, self, true)
					self:_updateLimitSellTime()

					hasTag = true

					break
				else
					removetimer(self._updateLimitSellTime, self)
				end
			elseif id == GameEnum.PayshopSellSkinTagType.NewGoods then
				local startTime = GameUtil.string2time(self._goodsCfg.onlineTime)
				local endTime = startTime + 86400 * v.showDay

				if endTime > ServerTime.nowServerLook() then
					self._txtTagDesc.text = v.word
					hasTag = true

					break
				end
			elseif id == GameEnum.PayshopSellSkinTagType.Recommend then
				self._txtTagDesc.text = v.word
				hasTag = true

				break
			elseif id == GameEnum.PayshopSellSkinTagType.Discount then
				local planId = self:_getCurrDiscPlanId()

				if planId and planId > 0 then
					local dcfg = PayShopConfig.instance:getDiscountPlanCfg(planId)
					local originalGoodsId = self._goodsCfg.originalGoodsId
					local oriList = string.split(originalGoodsId, ":")
					local oriNum = checkint(oriList[#oriList])
					local discList = string.split(dcfg.discountPrice, ":")
					local discNum = checkint(discList[#discList])
					local percent = discNum / oriNum * 10
					local hasDecimals = percent - math.floor(percent) % percent > 0

					self._txtTagDesc.text = string.format(hasDecimals and "%.1f折" or "%s折", percent)
					hasTag = true

					break
				end
			end
		end
	end

	goutil.setActive(self._goTagImg, hasTag)
end

function PayShopSellPetGoodsItem:_updateLimitSellTime()
	local leftTime = self._limitSellEndTime - ServerTime.nowServerLook()

	if leftTime > 0 then
		if leftTime > 86400 then
			local day = math.ceil(leftTime / 86400)

			self._txtTagDesc.text = string.format("剩%s天", day)
		else
			local hour = math.ceil(leftTime / 3600)

			self._txtTagDesc.text = string.format("剩%s小时", hour)
		end
	else
		removetimer(self._updateLimitSellTime, self)
		self:_setTagDesc()
	end
end

function PayShopSellPetGoodsItem:_setRareImg(quality)
	local isEmpty = not quality

	goutil.setActive(self._qualityImgChange.gameObject, not isEmpty)

	if not isEmpty then
		self._qualityImgChange:SetState(quality)
	end
end

return PayShopSellPetGoodsItem
