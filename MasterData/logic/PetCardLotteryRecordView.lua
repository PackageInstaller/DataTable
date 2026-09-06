-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/view/PetCardLotteryRecordView.lua

module("logic.extensions.petcardlottery.view.PetCardLotteryRecordView", package.seeall)

local PetCardLotteryRecordView = class("PetCardLotteryRecordView", ViewComponent)

function PetCardLotteryRecordView:ctor()
	PetCardLotteryRecordView.super.ctor(self)
end

function PetCardLotteryRecordView:unbindEvents()
	PetCardLotteryRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._tipsCustomInput:RemoveListener()
end

function PetCardLotteryRecordView:bindEvents()
	PetCardLotteryRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._tipsCustomInput:AddListener(self._onCustomInputCallback, self)
end

function PetCardLotteryRecordView:buildUI()
	PetCardLotteryRecordView.super.buildUI(self)

	self._detailTip = self:getGo("detailTip")
	self._tableviewGo = self:getGo("recordView")
	self._cell = self:getGo("recordCell")
	self._btnClose = self:getBtn("btnClose")
	self._tableView = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._optionalEmpty = self:getGo("detailTip/optional/empty")
	self._optionalPetGroup = self:getGo("detailTip/optional/petGroup")
	self._optionalPetGroupList = {}

	for i = 1, 5 do
		local pet = self:getGo("detailTip/optional/petGroup/headCell_" .. i .. "/head")

		table.insert(self._optionalPetGroupList, pet)
	end

	self._tipsCustomInput = UICustomInput.Get(self._detailTip)
	self._resultPetGroupList = {}
	self._resultPetGroup = self:getGo("detailTip/result/petGroup")
	self._resultEmpty = self:getGo("detailTip/result/empty")

	for i = 1, 5 do
		local pet = self:getGo("detailTip/result/petGroup/headCell_" .. i .. "/head")

		table.insert(self._resultPetGroupList, pet)
	end
end

function PetCardLotteryRecordView:onExit()
	PetCardLotteryRecordView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PetCardLotteryGainPrizeRes, self._sendGetInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetCardLotteryGetInfoRes, self._refreshInfos, self)

	for _, effCell in pairs(self._effectList) do
		if effCell then
			for _, eff in pairs(effCell) do
				UIEffectManager.instance:stopEffect(eff)
			end
		end
	end

	self._tableView:dispose()
end

function PetCardLotteryRecordView:onEnter()
	PetCardLotteryRecordView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PetCardLottery)
	self._cardCfg = PetCardLotteryConfig.instance:getCardCfg(self._activityId)
	self._effectList = {}

	GlobalDispatcher:addListener(GlobalNotify.PetCardLotteryGainPrizeRes, self._sendGetInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.PetCardLotteryGetInfoRes, self._refreshInfos, self)
	GameUtil.SetActive(self._detailTip, false)
	self:_refreshInfos()
end

function PetCardLotteryRecordView:_sendGetInfoReq()
	PetCardLotteryController.instance:sendPM_PetCardLotteryGetInfoReq(self._activityId)
end

function PetCardLotteryRecordView:_refreshInfos()
	self._recordList = PetCardLotteryModel.instance:getRecordList()

	self._tableView:reloadData(self._recordList)
end

function PetCardLotteryRecordView:_updateCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local empty = goutil.findChild(mainGo, "optional/headCell/empty")
	local head = goutil.findChild(mainGo, "optional/headCell/head")
	local resultEmpty = goutil.findChild(mainGo, "result/headCell/empty")
	local resultHead = goutil.findChild(mainGo, "result/headCell/head")
	local fail = goutil.findChild(mainGo, "fail")
	local prizeType = goutil.findChild(mainGo, "prizeType")
	local bgChange = goutil.findChild(mainGo, "recordBg"):GetComponent("UIImageColorChange")
	local detailTipPos = goutil.findChild(mainGo, "detailTipPos")
	local rewardCol = goutil.findChild(mainGo, "rewardCol")
	local txtDate = goutil.findChildTextComponent(mainGo, "txtDate")
	local txtPrizeType = goutil.findChildTextComponent(mainGo, "prizeType/txt")
	local btnDetail = goutil.findChildButtonComponent(mainGo, "result/btnDetail")
	local change = prizeType:GetComponent("UIImageSpriteChange")

	bgChange:SetState((cell.index + 1) % 2 == 0 and 1 or 0)

	local month, day, weekday = PetCardLotteryController.instance:timeDateToWday(data.dateInt)

	txtDate.text = string.format("%02d.%02d\n<size=22>%s</size>", month, day, weekday)

	if not data.selectedPetIds then
		local selectedPetIds = {}

		if not data.prizePetIds then
			local prizePetIds = {}
			local hasPetId = #selectedPetIds > 0
			local hasPrizeId = #prizePetIds > 0

			GameUtil.SetActive(empty, not hasPetId)
			GameUtil.SetActive(head, hasPetId)
			GameUtil.SetActive(resultEmpty, not hasPrizeId)
			GameUtil.SetActive(resultHead, hasPrizeId)

			if self._effectList[mainGo] then
				for _, eff in pairs(self._effectList[mainGo]) do
					UIEffectManager.instance:stopEffect(eff)
				end

				self._effectList[mainGo] = nil
			end

			for i = 1, 3 do
				local rewardCell = goutil.findChild(mainGo, "rewardCol/reward_" .. i)
				local recieve = goutil.findChild(rewardCell, "receive")

				GameUtil.SetActive(recieve, false)
			end

			if hasPetId then
				uGuiUtil.setSpriteToImage(head, uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl("2zhounian", self._cardCfg[selectedPetIds[1]].icon))
			end

			if hasPrizeId then
				txtPrizeType.text = "未开奖"

				uGuiUtil.setSpriteToImage(resultHead, uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl("2zhounian", self._cardCfg[prizePetIds[1]].icon))
			end

			local isLottery = PetCardLotteryController.instance:isLottery(data.dateInt)
			local isGainPrize = PetCardLotteryModel.instance:isGainPrize(data.dateInt)

			if isLottery then
				change:SetState(0)
				GameUtil.SetActive(fail, false)
				GameUtil.SetActive(prizeType, true)
				GameUtil.SetActive(rewardCol, true)

				local cfg = PetCardLotteryController.instance:lottryPrizeType(selectedPetIds, prizePetIds)

				txtPrizeType.text = cfg.dec

				local prizeStr = string.split(cfg.prize, "#")
				local prizeEffect = {}

				for i = 1, #prizeStr do
					local rewardCell = goutil.findChild(mainGo, "rewardCol/reward_" .. i)
					local recieve = goutil.findChild(rewardCell, "receive")
					local parent = goutil.findChild(rewardCell, "posGo")

					GameUtil.SetActive(recieve, false)

					local proxy = MaterialMgr.setCellByCfg(prizeStr[i], parent)

					if isGainPrize then
						GameUtil.SetActive(recieve, true)
					else
						local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
						local pmEff = UIEffectManager.instance:playEffect(self, effPath, parent, 0, 0, true, nil, nil, function(target, eff)
							eff:setClipping(goutil.findChild(self._tableviewGo, "Viewport").transform)
						end, self)

						pmEff:setParent(parent.transform)
						pmEff:setLocalPos(0, 0, 0)
						pmEff:setScale(1)
						table.insert(prizeEffect, pmEff)

						if proxy then
							proxy.binder:setAutoTips(false)
							proxy.binder:setCallBack(function()
								PetCardLotteryController.instance:sendPM_PetCardLotteryGainPrizeReq(self._activityId, data.dateInt)
							end)
						end
					end
				end

				self._effectList[mainGo] = prizeEffect
			else
				GameUtil.SetActive(rewardCol, false)
				change:SetState(1)
				GameUtil.SetActive(fail, hasPrizeId)

				txtPrizeType.text = "未开奖"

				GameUtil.SetActive(prizeType, not hasPrizeId)
			end

			GameUtil.addClickHandler(btnDetail, GameUtil.handler(self._onClickDetail, self, data.dateInt, detailTipPos, selectedPetIds, prizePetIds))
		end
	end
end

function PetCardLotteryRecordView:_clearCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "optional/headCell/head")

	uGuiUtil.clearImage(head)

	for i = 1, 3 do
		local rewardCell = goutil.findChild(mainGo, "rewardCol/reward_" .. i)

		MaterialMgr.resetAll(goutil.findChild(rewardCell, "posGo"))
	end
end

function PetCardLotteryRecordView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._detailTip, false)
	end
end

function PetCardLotteryRecordView:_onClickDetail(dateInt, detailTipPos, selectPetIds, prizePetIds)
	local isSelectPetId = #selectPetIds > 0

	GameUtil.SetActive(self._optionalEmpty, not isSelectPetId)
	GameUtil.SetActive(self._optionalPetGroup, isSelectPetId)

	if isSelectPetId then
		for i = 1, #self._optionalPetGroupList do
			uGuiUtil.setSpriteToImage(self._optionalPetGroupList[i], uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl("2zhounian", self._cardCfg[selectPetIds[i]].icon))
		end
	end

	local isHasResut = #prizePetIds > 0

	GameUtil.SetActive(self._resultEmpty, not isHasResut)
	GameUtil.SetActive(self._resultPetGroup, isHasResut)

	if isHasResut then
		for i = 1, #self._resultPetGroupList do
			uGuiUtil.setSpriteToImage(self._resultPetGroupList[i], uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl("2zhounian", self._cardCfg[prizePetIds[i]].icon))
		end
	end

	goutil.addChildToParent(self._detailTip, detailTipPos)
	GameUtil.setLocalPos(self._detailTip, 0, 0, 0)
	GameUtil.SetActive(self._detailTip, true)
end

return PetCardLotteryRecordView
