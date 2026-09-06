-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wushenshou/view/WuShenFormationLeftView.lua

module("logic.extensions.wushenshou.view.WuShenFormationLeftView", package.seeall)

local WuShenFormationLeftView = class("WuShenFormationLeftView", FormationLeftView)

WuShenFormationLeftView._forbidSeats = {
	[3] = {
		true,
		true,
		true,
		false,
		false,
		false,
		true,
		true,
		true
	},
	[8] = {
		true,
		true,
		true,
		false,
		false,
		false,
		true,
		true,
		true
	},
	[21] = {
		true,
		true,
		true,
		true,
		false,
		true,
		true,
		true,
		true
	},
	[22] = {
		true,
		true,
		true,
		false,
		false,
		true,
		true,
		true,
		true
	},
	[23] = {
		true,
		true,
		true,
		false,
		false,
		false,
		true,
		true,
		true
	}
}
WuShenFormationLeftView.FORBID_PET = {}
WuShenFormationLeftView.FORBID_TIPS = {}
WuShenFormationLeftView.POS_RACE = {}
WuShenFormationLeftView.RACE_TIP = {}
WuShenFormationLeftView.RACE_TIPSTATE = {}

function WuShenFormationLeftView:ctor()
	WuShenFormationLeftView.super.ctor(self)

	self._forbidTag = {}

	for i = 1, 9 do
		self._forbidTag[i] = false
	end

	self._tipPos = {
		[4] = Vector3.New(0, 46, 0),
		[5] = Vector3.New(0, -55, 0),
		[6] = Vector3.New(0, -165, 0)
	}
	self._selTag = 0
end

function WuShenFormationLeftView:onEnterFinished()
	WuShenFormationLeftView.super.onEnterFinished(self)

	self._shenshouType = self:getFirstParam() or 1
	self._forbidPet = WuShenFormationLeftView.FORBID_PET[self._shenshouType]
	self._posRace = WuShenFormationLeftView.POS_RACE[self._shenshouType]
	self._raceTip = WuShenFormationLeftView.RACE_TIP[self._shenshouType]
	self._raceTipState = WuShenFormationLeftView.RACE_TIPSTATE[self._shenshouType]
end

function WuShenFormationLeftView:bindEvents()
	WuShenFormationLeftView.super.bindEvents(self)
	GlobalDispatcher:addListener(GlobalNotify.FormationClickPet, self._onClickRightPetView, self)
end

function WuShenFormationLeftView:unbindEvents()
	WuShenFormationLeftView.super.unbindEvents(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationClickPet, self._onClickRightPetView, self)
end

function WuShenFormationLeftView:_RefreshView()
	WuShenFormationLeftView.super._RefreshView(self)
	self:_forbidSeat()
end

function WuShenFormationLeftView:_forbidSeat()
	self._shenshouType = self:getFirstParam() or 1
end

function WuShenFormationLeftView:_OnDropBg(go, eventData)
	if self._dragSeat then
		local petId = self._dragSeat:GetData()

		if self._dragSeat:IsOpen() and petId > 0 then
			local pos = self._dragSeat:GetPosition()

			if not self._forbidTag[pos] then
				FormationController.instance:ChangePosition(pos, 0)

				self._dragSeat = nil
			else
				TipsFacade.instance:openFlyTips("该位置本关卡未开放！")
			end
		end
	end
end

function WuShenFormationLeftView:_OnDropSeat(go, eventData)
	local curItemSeat = ItemSeat.Get(go)

	if not curItemSeat then
		return
	end

	self:_setSelectEffectState(false)

	local pos = curItemSeat:GetPosition()

	if self._forbidTag[pos] then
		TipsFacade.instance:openFlyTips("该位置本关卡未开放！")

		return
	end

	local itemPet = ItemPet.Get(eventData.pointerDrag)

	if itemPet then
		local raceId = itemPet:GetData().raceId

		if self._forbidPet ~= nil and not TableUtil.isHad(self._forbidPet, raceId) then
			TipsFacade.instance:openFlyTips(WuShenFormationLeftView.FORBID_TIPS[self._shenshouType])

			return
		end
	end

	local curItemSeat = ItemSeat.Get(go)

	if not curItemSeat then
		return
	end

	local itemSeat = ItemSeat.Get(eventData.pointerDrag)

	if itemSeat and curItemSeat:IsOpen() ~= itemSeat:IsOpen() or not itemSeat and curItemSeat:GetData() == -1 then
		return
	end

	local pos = curItemSeat:GetPosition()
	local itemPet = ItemPet.Get(eventData.pointerDrag)
	local petId

	if itemPet then
		petId = itemPet:GetData().petId

		self._RightView:_OnDropSeat()
	elseif itemSeat then
		petId = itemSeat:GetData()
		self._dragSeat = nil
	end

	if not petId then
		return
	end

	FormationController.instance:ChangePosition(pos, petId)

	if self._forbidPet ~= nil then
		local raceId = BagPetsController.instance:getPet(petId).raceId

		self:_showTip(raceId, pos)
	end
end

function WuShenFormationLeftView:_OnClickSeat(go, eventData)
	local itemSeat = ItemSeat.Get(go)

	if not itemSeat then
		return
	end

	local pos = itemSeat:GetPosition()

	if self._forbidPet ~= nil and self._RightView._selectedPetId then
		local raceId = BagPetsController.instance:getPet(self._RightView._selectedPetId).raceId

		if not TableUtil.isHad(self._forbidPet, raceId) then
			TipsFacade.instance:openFlyTips(WuShenFormationLeftView.FORBID_TIPS[self._shenshouType])

			return
		end

		self:_showTip(raceId, pos)
	end

	WuShenFormationLeftView.super._OnClickSeat(self, go, eventData)
end

function WuShenFormationLeftView:_showTip(raceId, pos)
	self._arrowGo:SetActive(true)

	if self._co then
		coroutine.stop(self._co)
	end

	self._co = coroutine.start(function()
		coroutine.wait(2)

		if not self._arrowGo:Equals(nil) then
			self._arrowGo:SetActive(false)
		end
	end)

	uGuiUtil.setLocalPosition(self._arrowGo, self._tipPos[pos])

	local rightObj = goutil.findChild(self._arrowGo, "ImgRight")
	local wrongObj = goutil.findChild(self._arrowGo, "ImgWrong")
	local arrowImg = goutil.findChild(self._arrowGo, "ImgRight/Arrow"):GetComponent("UIImageSpriteChange")
	local tipText = goutil.findChild(self._arrowGo, "ImgRight/TxtCan"):GetComponent("Text")

	rightObj:SetActive(self._posRace[pos] == raceId)
	wrongObj:SetActive(self._posRace[pos] ~= raceId)

	if self._posRace[pos] == raceId then
		tipText.text = self._raceTip[raceId]

		local state = self._raceTipState[raceId]

		arrowImg:SetState(state)
	end
end

function WuShenFormationLeftView:_onBagBeginDrag(data)
	WuShenFormationLeftView.super._onBagBeginDrag(self, data)

	if self._shenshouType == ShenShouType.XUANWU then
		if data.raceId == 10057 then
			self:_setSeatHightLightIdx(5, true)
		elseif data.raceId == 10059 then
			self:_setSeatHightLightIdx(8, true)
		end
	elseif self._forbidPet ~= nil then
		self:_setRestrain(data.raceId)
	end
end

function WuShenFormationLeftView:_OnClickBtnFormation()
	if self._shenshouType == ShenShouType.BAIHU or self._shenshouType == ShenShouType.TIANBINGSHENHU_1 or self._shenshouType == ShenShouType.XUANMINGTIANLONG then
		TipsFacade.instance:openFlyTips("本关卡不能设置阵型")

		return
	end

	WuShenFormationLeftView.super._OnClickBtnFormation(self)
end

function WuShenFormationLeftView:_onClickOneKey()
	if self._shenshouType == ShenShouType.BAIHU or self._shenshouType == ShenShouType.TIANBINGSHENHU_1 or self._shenshouType == ShenShouType.XUANMINGTIANLONG then
		TipsFacade.instance:openFlyTips("本关卡不能使用一键布阵")

		return
	end

	WuShenFormationLeftView.super._onClickOneKey(self)
end

function WuShenFormationLeftView:_onClickRightPetView()
	if self._forbidPet ~= nil then
		if self._selTag > 0 then
			self:_setSeatHightLightIdx(self._selTag, false)
			self:_setRestrainTxt(self._selTag, lang("放这里克制敌方"), false)
		end

		if self._RightView._selectedPetId then
			local raceId = BagPetsController.instance:getPet(self._RightView._selectedPetId).raceId

			self:_setRestrain(raceId)
		end
	end
end

function WuShenFormationLeftView:_setRestrain(raceId)
	for k, v in pairs(self._posRace) do
		if v == raceId then
			self._selTag = checknumber(k)

			self:_setSeatHightLightIdx(self._selTag, true)
			self:_setRestrainTxt(self._selTag, lang("放这里克制敌方"), true)
		end
	end
end

return WuShenFormationLeftView
