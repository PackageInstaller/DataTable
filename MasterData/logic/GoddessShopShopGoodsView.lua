-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopShopGoodsView.lua

module("logic.extensions.goddessshop.view.GoddessShopShopGoodsView", package.seeall)

local GoddessShopShopGoodsView = class("GoddessShopShopGoodsView", ViewComponent)
local EachGiftCd = 0.1
local GiftCount = 2

function GoddessShopShopGoodsView:buildUI()
	GoddessShopShopGoodsView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("mask/con")
	self._txtFeel = self:getTxt("txtFeel")
	self._strTxtFeel = self._txtFeel.text
	self._addGo = self:getGo("floatRoot/addGo")
	self._txtAddGo = self:getTxt("floatRoot/addGo/txt")

	GameUtil.SetActive(self._addGo, false)

	self._txtCount = self:getTxt("txtCount")
	self._goodsScrView = self:getGo("goodsCol/scrView")
	self._goodsScrCell = self:getGo("goodsCol/scrCell")
	self._goodsScrollerList = ScrollerList.create(self._goodsScrView, self._goodsScrCell, GameUtil.handler(self._updateGoodsCell, self), GameUtil.handler(self._clearGoodsCell, self))
end

function GoddessShopShopGoodsView:bindEvents()
	GoddessShopShopGoodsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoddessShopShopGoodsView:unbindEvents()
	GoddessShopShopGoodsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddessShopShopGoodsView:onEnter()
	GoddessShopShopGoodsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._girlId = checknumber(params[2])

	local isInTime = GoddessShopController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityType = GoddessShopController.instance:getActivityType()
	self._goddessShopMo = GoddessShopController.instance:getGoddessShopMo(self._activityId)
	self._actData = GoddessShopConfig.instance:getActData(self._activityId)
	self._girlData = GoddessShopConfig.instance:getGirlData(self._activityId, self._girlId)
	self._favouriteGiftId = self._girlData.favouriteGiftId
	self._btnLongPressHelpers = {}
	self._oldFetter = self._goddessShopMo:getFetterInShop(self._girlId)
	self._sendNum = 0
	self._giftCfg = GoddessShopConfig.instance:getGiftCfg(self._activityId) or {}
	self._matArrs = {}

	for _, data in ipairs(self._giftCfg) do
		local matType, matId = MaterialMgr.getMatParams(data.materialKey)

		self._matArrs[data.giftId] = {
			matType = matType,
			matId = matId,
			matNum = function()
				return MaterialModel.instance:getMaterialsNumber(matType, matId)
			end
		}
	end

	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlPresentGiftRes, self._handlePM_SurroundByDreamGirlPresentGiftRes, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onUpdate, self)

	local modelCo = CharacterConfig.instance:getModelCo(self._girlData.skinId)

	uGuiUtil.setSpriteToImage(self._con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(self._girlData.skinId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._girlData.skinId, self._pointRare)
	GameUtil.SetActive(self._txtCount.gameObject, false)
	self:_onUpdate()
end

function GoddessShopShopGoodsView:onExit()
	GoddessShopShopGoodsView.super.onExit(self)
	self:_clearFeelFloatAnim()
	MaterialMgr.resetAll(self._pointRare)
	uGuiUtil.clearImage(self._con)
	self:_onClearGoodsCol()
end

function GoddessShopShopGoodsView:_handlePM_SurroundByDreamGirlPresentGiftRes(msg)
	local cur = self._goddessShopMo:getFetterInShop(self._girlId)
	local diff = cur - self._oldFetter

	self._oldFetter = cur

	self:_playFeelFloatAnim(diff)
	GameUtil.SetActive(self._txtCount.gameObject, false)
	self:_onUpdate()
end

function GoddessShopShopGoodsView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GoddessShopShopGoodsView:_onUpdateData()
	self._oldFetter = self._goddessShopMo:getFetterInShop(self._girlId)
end

function GoddessShopShopGoodsView:_onUpdateUI()
	if self._strTxtFeel then
		local cur = self._goddessShopMo:getFetterInShop(self._girlId)
		local max = self._girlData.maxFetter

		self._txtFeel.text = string.format(self._strTxtFeel, cur, max)
	end

	self:_onUpdateGoodsCol()
end

function GoddessShopShopGoodsView:_onUpdateGoodsCol()
	local cfg = GoddessShopConfig.instance:getGiftCfg(self._activityId) or {}

	self._goodsScrollerList:reloadData(cfg)
end

function GoddessShopShopGoodsView:_onClearGoodsCol()
	self._goodsScrollerList:dispose()
end

function GoddessShopShopGoodsView:_updateGoodsCell(view, cell, data, tag)
	local giftId = data.giftId
	local matStr = data.materialKey
	local matNum = self._matArrs[data.giftId].matNum()
	local isFavourite = self._favouriteGiftId == giftId
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local txtFeel = goutil.findChildTextComponent(mainGo, "txtFeel")
	local countRoot = goutil.findChild(mainGo, "countRoot")
	local proxy = MaterialMgr.setCellByCfg(matStr, item)

	if proxy then
		proxy.binder:setNum(matNum)
	end

	GameUtil.SetGray(btnSure, matNum <= 0)

	txtFeel.text = string.format("好感+%s", (isFavourite or nil) and (data.favouriteAddFetter or data.addFetter))

	if not self._btnLongPressHelpers[btnSure] then
		local helper = BtnLongPressHelper.create(btnSure)

		self._btnLongPressHelpers[btnSure]:addClickHandler(function()
			self:_sendGoodsFetterReq(self._girlId, giftId, 1)
		end)
		self._btnLongPressHelpers[btnSure]:addPressStartHandler(function()
			self._deltaTime = 0
			self._sendNum = 0
		end)
		self._btnLongPressHelpers[btnSure]:addPressEndHandler(function()
			local sendNum = self._sendNum

			self._sendNum = 0

			self:_sendGoodsFetterReq(self._girlId, giftId, sendNum)
		end)
		self._btnLongPressHelpers[btnSure]:addPressUpdateHandler(function(deltaTime, pressTime)
			self._deltaTime = self._deltaTime + deltaTime

			if self._deltaTime >= EachGiftCd then
				self._deltaTime = 0

				local num = self._matArrs[giftId].matNum()

				if num <= self._sendNum then
					return
				end

				local maxFetter = self._girlData.maxFetter
				local curFetter = self._goddessShopMo:getFetterInShop(self._girlId)

				if maxFetter < curFetter then
					return
				end

				local diffFetter = Mathf.Max(maxFetter - curFetter, 0)
				local addValue = self:_getGoodsFetterAddValue(self._girlId, giftId)
				local diffNum = Mathf.Ceil(diffFetter / addValue)
				local addNum = Mathf.Min(Mathf.Min(GiftCount, diffNum), num)

				if addNum <= 0 then
					return
				end

				local sendNum = self._sendNum + addNum
				local result = self:_getTrySendGoodsFetterReqResultAndTips(false, self._girlId, giftId, sendNum)

				if result ~= GameEnum.ResultCode.Success then
					return
				end

				self._sendNum = sendNum
				self._txtCount.text = string.format("x%s", self._sendNum)

				local x, y, z = Framework.TransformUtil.GetPos(countRoot.transform, 0, 0, 0)

				GameUtil.setPos(self._txtCount.gameObject, x, y, z)
				GameUtil.SetActive(self._txtCount.gameObject, true)
			end
		end)
	end
end

function GoddessShopShopGoodsView:_clearGoodsCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSure = goutil.findChild(mainGo, "btnSure")

	MaterialMgr.resetAll(item)

	local helper = self._btnLongPressHelpers[btnSure]

	if helper then
		helper:clearAllHandlers()

		self._btnLongPressHelpers[btnSure] = nil
	end
end

function GoddessShopShopGoodsView:_getGoodsFetterValue(girlId, giftId, num)
	local add = self:_getGoodsFetterAddValue(girlId, giftId)

	return add * num
end

function GoddessShopShopGoodsView:_getGoodsFetterAddValue(girlId, giftId)
	local girlData = GoddessShopConfig.instance:getGirlData(self._activityId, girlId)

	if girlData then
		if not girlData.favouriteGiftId then
			local favouriteGiftId = 0
			local giftData = GoddessShopConfig.instance:getGiftData(self._activityId, giftId)

			return (giftData or nil) and (favouriteGiftId == giftId and giftData.favouriteAddFetter or giftData.addFetter)
		end
	end
end

function GoddessShopShopGoodsView:_sendGoodsFetterReq(girlId, giftId, sendNum)
	local result = self:_getTrySendGoodsFetterReqResultAndTips(true, girlId, giftId, sendNum)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	GoddessShopController.instance:sendPM_SurroundByDreamGirlPresentGiftReq(self._activityId, self._girlId, giftId, sendNum)
end

function GoddessShopShopGoodsView:_getTrySendGoodsFetterReqResultAndTips(isNeedTips, girlId, giftId, sendNum)
	local result = GameEnum.ResultCode.Success
	local tips

	if result == GameEnum.ResultCode.Success then
		local num = self._matArrs[giftId].matNum()

		if num < sendNum then
			tips = "数量不足"
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success and sendNum <= 0 then
		result = GameEnum.ResultCode.Error
	end

	if result == GameEnum.ResultCode.Success then
		local curFetter = self._goddessShopMo:getFetterInShop(girlId)
		local girlData = GoddessShopConfig.instance:getGirlData(self._activityId, girlId)
		local maxFetter = girlData.maxFetter
		local diffFetter = Mathf.Max(maxFetter - curFetter, 0)
		local addValue = self:_getGoodsFetterAddValue(girlId, giftId)
		local diffNum = Mathf.Ceil(diffFetter / addValue)

		if diffNum < sendNum then
			tips = "好感度已满，不用再送礼物，女神也对你死心塌地啦"
			result = GameEnum.ResultCode.Error
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function GoddessShopShopGoodsView:_playFeelFloatAnim(value)
	self._txtAddGo.text = value < 0 and string.format("%s", value) or string.format("+%s", value)

	self:_clearFeelFloatAnim()

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequence = sequence

	local targeGo = self._addGo

	GameUtil.setLocalPos(targeGo, 0, 0, 0)
	GameUtil.SetActive(targeGo, true)

	local toPos = GameUtil.getLocalPos(targeGo)

	toPos.y = toPos.y + 34

	local tweenerMove = targeGo.transform:DOLocalMove(toPos, 0.2)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	sequence:Join(tweenerMove)
	sequence:AppendInterval(1)
	sequence:OnComplete(function()
		GameUtil.SetActive(targeGo, false)
	end)
end

function GoddessShopShopGoodsView:_clearFeelFloatAnim()
	if self._sequence then
		self._sequence:Kill(true)

		self._sequence = nil
	end
end

return GoddessShopShopGoodsView
