-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateChessTipView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessTipView", package.seeall)

local EliminateChessTipView = class("EliminateChessTipView", ListScrollCellExtend)

function EliminateChessTipView:onInitView()
	self._gochessTip = gohelper.findChild(self.viewGO, "#go_chessTip")
	self._imageChessQualityBG = gohelper.findChildImage(self.viewGO, "#go_chessTip/Info/#image_ChessQualityBG")
	self._imageChess = gohelper.findChildSingleImage(self.viewGO, "#go_chessTip/Info/#image_Chess")
	self._goResource = gohelper.findChild(self.viewGO, "#go_chessTip/Info/#go_Resource")
	self._goResourceItem = gohelper.findChild(self.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem")
	self._imageResourceQuality = gohelper.findChildImage(self.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	self._txtResourceNum = gohelper.findChildText(self.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	self._txtFireNum = gohelper.findChildText(self.viewGO, "#go_chessTip/Info/image_Fire/#txt_FireNum")
	self._goStar1 = gohelper.findChild(self.viewGO, "#go_chessTip/Info/Stars/#go_Star1")
	self._goStar2 = gohelper.findChild(self.viewGO, "#go_chessTip/Info/Stars/#go_Star2")
	self._goStar3 = gohelper.findChild(self.viewGO, "#go_chessTip/Info/Stars/#go_Star3")
	self._goStar4 = gohelper.findChild(self.viewGO, "#go_chessTip/Info/Stars/#go_Star4")
	self._goStar5 = gohelper.findChild(self.viewGO, "#go_chessTip/Info/Stars/#go_Star5")
	self._goStar6 = gohelper.findChild(self.viewGO, "#go_chessTip/Info/Stars/#go_Star6")
	self._txtChessName = gohelper.findChildText(self.viewGO, "#go_chessTip/Info/#txt_ChessName")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_chessTip/Scroll View/Viewport/#txt_Descr")
	self._gochessResourceTip = gohelper.findChild(self.viewGO, "#go_chessResourceTip")
	self._goTipsBG = gohelper.findChild(self.viewGO, "#go_chessResourceTip/#go_TipsBG")
	self._btnsell = gohelper.findChildButtonWithAudio(self.viewGO, "#go_chessResourceTip/#btn_sell")
	self._txtopt = gohelper.findChildText(self.viewGO, "#go_chessResourceTip/#txt_opt")
	self._goResource2 = gohelper.findChild(self.viewGO, "#go_chessResourceTip/#go_Resource_2")
	self._goResourceItem2 = gohelper.findChild(self.viewGO, "#go_chessResourceTip/#go_Resource_2/#go_ResourceItem_2")
	self._txtConfirm = gohelper.findChildText(self.viewGO, "#go_chessResourceTip/#txt_Confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateChessTipView:addEvents()
	self._btnsell:AddClickListener(self._btnsellOnClick, self)
end

function EliminateChessTipView:removeEvents()
	self._btnsell:RemoveClickListener()
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function EliminateChessTipView:_btnsellOnClick()
	if not EliminateLevelModel.instance:sellChessIsUnLock() then
		GameFacade.showToast(ToastEnum.EliminateChessSellLocked)

		return
	end

	if not self:canSell() then
		return
	end

	if self._uid == nil and self._strongholdId == nil then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_bank_open)
	WarChessRpc.instance:sendWarChessPieceSellRequest(self._uid, self._strongholdId, self._onSellChess, self)
end

function EliminateChessTipView:_onSellChess()
	if self._sellCb and self._sellCbTarget then
		self._sellCb(self._sellCbTarget)
	end
end

function EliminateChessTipView:_editableInitView()
	self.sellUIEffect = ZProj_UIEffectsCollection.Get(self._btnsell.gameObject)
	self._gochessTipAni = self._gochessTip:GetComponent(typeof(UnityEngine.Animator))
	self._gochessResourceTipAni = self._gochessResourceTip:GetComponent(typeof(UnityEngine.Animator))
end

function EliminateChessTipView:onUpdateParam()
	return
end

function EliminateChessTipView:onOpen()
	return
end

function EliminateChessTipView:onClose()
	return
end

function EliminateChessTipView:hideView(cb, cbTarget)
	self._lastState = nil
	self._hideCb = cb
	self._hideCbTarget = cbTarget

	if self._gochessTipAni and self._gochessResourceTipAni then
		self._gochessTipAni:Play("close")
		self._gochessResourceTipAni:Play("close")
		TaskDispatcher.runDelay(self.hideViewGo, self, 0.33)
	else
		self:hideViewGo()
	end
end

function EliminateChessTipView:hideViewGo()
	self:setViewActive(false)

	if self._hideCb then
		self._hideCb(self._hideCbTarget)
	end
end

function EliminateChessTipView:setViewActive(active)
	local isShowResourceTip = self._showType == EliminateTeamChessEnum.ChessTipType.showDragTip or self._showType == EliminateTeamChessEnum.ChessTipType.showSell
	local isShowChessTip = self._showType == EliminateTeamChessEnum.ChessTipType.showDesc or self._showType == EliminateTeamChessEnum.ChessTipType.showSell

	gohelper.setActive(self._gochessResourceTip, isShowResourceTip and active)
	gohelper.setActive(self._gochessTip, isShowChessTip and active)
end

function EliminateChessTipView:setSoliderIdAndShowType(id, showType)
	self._soliderId = id
	self._showType = showType
	self._config = EliminateConfig.instance:getSoldierChessConfig(self._soliderId)
	self._cost, self._costNumber = EliminateConfig.instance:getSoldierChessConfigConst(self._soliderId)

	if self._config then
		SurvivalUnitIconHelper.instance:setNpcIcon(self._imageChess, self._config.resPic)
		UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. self._config.level, false)
	end

	self:refreshInfo()
	self:refreshResource()
	self:refreshSellResource()
	self:refreshViewState()
end

function EliminateChessTipView:canSell()
	if not EliminateLevelModel.instance:sellChessIsUnLock() then
		return false
	end

	local sell = self._config.sell

	if sell and sell == 1 then
		return false
	end

	return true
end

function EliminateChessTipView:setSellCb(cb, cbTarget)
	self._sellCb = cb
	self._sellCbTarget = cbTarget
end

function EliminateChessTipView:setChessUidAndStrongHoldId(uid, strongholdId)
	self._uid = uid
	self._strongholdId = strongholdId
end

function EliminateChessTipView:refreshViewState()
	local isShowDragTip = self._showType == EliminateTeamChessEnum.ChessTipType.showDragTip
	local isShowSell = self._showType == EliminateTeamChessEnum.ChessTipType.showSell
	local isShowResourceTip = self._showType == EliminateTeamChessEnum.ChessTipType.showDragTip or self._showType == EliminateTeamChessEnum.ChessTipType.showSell
	local isShowChessTip = self._showType == EliminateTeamChessEnum.ChessTipType.showDesc or self._showType == EliminateTeamChessEnum.ChessTipType.showSell

	gohelper.setActive(self._btnsell.gameObject, isShowSell)
	gohelper.setActive(self._goConfirm, isShowDragTip)
	gohelper.setActive(self._goTipsBG, isShowDragTip)

	if isShowSell and self.sellUIEffect then
		self.sellUIEffect:SetGray(not self:canSell())
	end

	self._txtopt.text = isShowSell and "＋" or "－"

	gohelper.setActive(self._txtConfirm.gameObject, isShowDragTip)
	gohelper.setActive(self._goResource2, isShowResourceTip)
	gohelper.setActive(self._gochessResourceTip, isShowResourceTip)
	gohelper.setActive(self._gochessTip, isShowChessTip)

	if self._showType == EliminateTeamChessEnum.ChessTipType.showSell then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.SoliderChessSellViewOpen)
	end
end

function EliminateChessTipView:updateViewPositionByEntity(entity, offset, showAdd)
	if entity == nil or self._config == nil then
		return
	end

	if offset then
		if not offset.soliderTipOffsetX then
			local soliderTipOffsetX = EliminateTeamChessEnum.soliderTipOffsetX

			if offset then
				if not offset.soliderTipOffsetY then
					local soliderTipOffsetY = EliminateTeamChessEnum.soliderTipOffsetY
					local worldPosX, worldPosY, worldPosZ = entity:getPosXYZ()

					if isTypeOf(entity, TeamChessEmptyUnit) then
						worldPosX, worldPosY, worldPosZ = entity:getTopPosXYZ()
					end

					if self._showType == EliminateTeamChessEnum.ChessTipType.showSell then
						transformhelper.setPos(self._gochessResourceTip.transform, worldPosX + soliderTipOffsetX, worldPosY + soliderTipOffsetY, worldPosZ)
						transformhelper.setPos(self._gochessTip.transform, worldPosX + EliminateTeamChessEnum.soliderSellTipOffsetX, worldPosY + EliminateTeamChessEnum.soliderSellTipOffsetY, worldPosZ)
					end

					if self._showType == EliminateTeamChessEnum.ChessTipType.showDragTip then
						soliderTipOffsetX = EliminateTeamChessEnum.soliderItemDragTipOffsetX
						soliderTipOffsetY = EliminateTeamChessEnum.soliderItemDragTipOffsetY

						transformhelper.setPos(self._gochessResourceTip.transform, worldPosX + EliminateTeamChessEnum.soliderItemDragTipOffsetX, worldPosY + EliminateTeamChessEnum.soliderItemDragTipOffsetY, worldPosZ)
						self:refreshAddState(showAdd)
					end

					if self._showType == EliminateTeamChessEnum.ChessTipType.showDesc then
						transformhelper.setPos(self._gochessTip.transform, worldPosX + soliderTipOffsetX, worldPosY + soliderTipOffsetY, worldPosZ)
					end
				end
			end
		end
	end
end

function EliminateChessTipView:refreshAddState(showAdd)
	if showAdd == nil then
		showAdd = true
	end

	if self._lastState == nil or self._lastState ~= showAdd then
		self._txtopt.text = showAdd and "－" or ""

		gohelper.setActive(self._goResource2, showAdd)

		self._txtConfirm.text = showAdd and "松手确定" or "无法放置"
		self._lastState = showAdd
	end
end

function EliminateChessTipView:refreshInfo()
	self._txtFireNum.text = self._config.defaultPower
	self._txtChessName.text = self._config.name

	local desc = EliminateConfig.instance:getSoldierChessDesc(self._soliderId)

	self._txtDescr.text = EliminateLevelModel.instance.formatString(desc)
end

function EliminateChessTipView:refreshResource()
	if not self._cost then
		return
	end

	if self._resourceItem == nil then
		self._resourceItem = self:getUserDataTb_()
	end

	for i = 1, #self._resourceItem do
		local data = self._resourceItem[i]

		gohelper.setActive(data.item, false)
	end

	for index, cost in ipairs(self._cost) do
		local resourceId = cost[1]
		local num = cost[2]
		local data = self._resourceItem[index]

		if data == nil then
			local item = gohelper.clone(self._goResourceItem, self._goResource, resourceId)
			local resourceImage = gohelper.findChildImage(item, "#image_ResourceQuality")
			local resourceNumberText = gohelper.findChildText(item, "#image_ResourceQuality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

			resourceNumberText.text = num
			data = {
				item = item,
				resourceImage = resourceImage,
				resourceNumberText = resourceNumberText
			}

			table.insert(self._resourceItem, data)
		else
			data.resourceNumberText.text = num

			UISpriteSetMgr.instance:setV2a2EliminateSprite(data.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)
		end

		local data = self._resourceItem[index]

		gohelper.setActive(data.item, true)
	end
end

function EliminateChessTipView:refreshSellResource()
	if not self._cost then
		return
	end

	local cost = self._cost

	if self._showType == EliminateTeamChessEnum.ChessTipType.showSell then
		cost = EliminateTeamChessModel.instance:getSellResourceData(self._cost)
	end

	if self._resourceItem2 == nil then
		self._resourceItem2 = self:getUserDataTb_()
	end

	for i = 1, #self._resourceItem2 do
		local data = self._resourceItem2[i]

		gohelper.setActive(data.item, false)
	end

	for index, cost in ipairs(cost) do
		local resourceId = cost[1]
		local num = tonumber(cost[2])
		local data = self._resourceItem2[index]

		if data == nil then
			local item = gohelper.clone(self._goResourceItem2, self._goResource2, resourceId)
			local resourceImage = gohelper.findChildImage(item, "#image_ResourceQuality")
			local resourceNumberText = gohelper.findChildText(item, "#image_ResourceQuality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

			resourceNumberText.text = num
			data = {
				item = item,
				resourceImage = resourceImage,
				resourceNumberText = resourceNumberText
			}

			table.insert(self._resourceItem2, data)
		else
			data.resourceNumberText.text = num

			UISpriteSetMgr.instance:setV2a2EliminateSprite(data.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)
		end

		local data = self._resourceItem2[index]

		gohelper.setActive(data.item, true)
	end
end

function EliminateChessTipView:onDestroyView()
	TaskDispatcher.cancelTask(self.hideViewGo, self)

	self._sellCb = nil
	self._sellCbTarget = nil
end

return EliminateChessTipView
