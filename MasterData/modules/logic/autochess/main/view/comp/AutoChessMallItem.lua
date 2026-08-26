-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessMallItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessMallItem", package.seeall)

local AutoChessMallItem = class("AutoChessMallItem", LuaCompBase)

function AutoChessMallItem:ctor(mallView)
	self.mallView = mallView
end

function AutoChessMallItem:setPos(posX, posY)
	self.startX = posX
	self.startY = posY

	recthelper.setAnchor(self.transform, posX, posY)
end

function AutoChessMallItem:init(go)
	self.go = go
	self.transform = go.transform
	self.btnClick = gohelper.findChildButtonWithAudio(go, "")
	self.imageBg = gohelper.findChildImage(go, "bg")
	self.goEntity = gohelper.findChild(go, "Entity")
	self.goMesh = gohelper.findChild(go, "Entity/Mesh")
	self.goCost = gohelper.findChild(go, "cost")
	self.txtCost = gohelper.findChildText(go, "cost/txt_Cost")
	self.imageCost = gohelper.findChildImage(go, "cost/image_Cost")
	self.goAttack = gohelper.findChild(go, "go_Attack")
	self.txtAttack = gohelper.findChildText(go, "go_Attack/txt_Attack")
	self.goHp = gohelper.findChild(go, "go_Hp")
	self.txtHp = gohelper.findChildText(go, "go_Hp/txt_Hp")
	self.goLock = gohelper.findChild(go, "go_Lock")
	self.imageTag = gohelper.findChildImage(go, "image_Tag")
	self.golvup = gohelper.findChild(go, "go_lvup")

	self.addClickCb(self, self.btnClick, self.onClick, self)
	CommonDragHelper.instance:registerDragObj(self.go, self._beginDrag, self._onDrag, self._endDrag, self._checkDrag, self, nil, true)

	self.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goMesh, AutoChessMeshComp)
	self.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goEntity, AutoChessEffectComp)
end

function AutoChessMallItem:addEventListeners()
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.StartBuyStepFinih, self.refreshLvup, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.ImmediatelyFlowFinish, self.refreshLvup, self)
end

function AutoChessMallItem:onDestroy()
	CommonDragHelper.instance:unregisterDragObj(self.go)

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function AutoChessMallItem:setData(mallId, data, isFree)
	self.mallId = mallId
	self.isFree = isFree

	if data then
		self.data = data

		if self.isFree then
			self.cost = 0
			self.txtCost.text = self.cost

			gohelper.setActive(self.goCost, false)
		else
			self.costType, self.cost = AutoChessConfig.instance:getItemBuyCost(data.id)

			local name = "v2a5_autochess_cost" .. self.costType

			UISpriteSetMgr.instance:setAutoChessSprite(self.imageCost, name)

			local chessMo = AutoChessModel.instance:getChessMo()

			if self.cost >= 1 and chessMo.svrFight.mySideMaster.id == AutoChessEnum.SpecialMaster.Role37 and AutoChessHelper.isPrimeNumber(self.data.chess.battle) and AutoChessHelper.isPrimeNumber(self.data.chess.hp) then
				self.cost = self.cost - 1
			end

			self.cost = self.cost + self.data.fixCost
			self.txtCost.text = self.cost

			gohelper.setActive(self.goCost, self.costType ~= AutoChessStrEnum.CostType.Coin or self.cost ~= 3)
		end

		local chessData = data.chess

		self.config = AutoChessConfig.instance:getChessCfgById(chessData.id, chessData.star)

		if self.config then
			self.meshComp:setData(self.config.image)
			self:initBuffEffect()

			local imageName = AutoChessHelper.getChessQualityBg(self.config.type, self.config.levelFromMall)

			UISpriteSetMgr.instance:setAutoChessSprite(self.imageBg, imageName)

			if self.config.type == AutoChessStrEnum.ChessType.Attack then
				self.txtAttack.text = chessData.battle
				self.txtHp.text = chessData.hp
			end

			gohelper.setActive(self.goAttack, self.config.type == AutoChessStrEnum.ChessType.Attack)
			gohelper.setActive(self.goHp, self.config.type == AutoChessStrEnum.ChessType.Attack)

			local campCo = lua_auto_chess_translate.configDict[self.config.race]

			if campCo and not string.nilorempty(campCo.tagResName) then
				UISpriteSetMgr.instance:setAutoChessSprite(self.imageTag, campCo.tagResName)
				gohelper.setActive(self.imageTag, true)
			else
				gohelper.setActive(self.imageTag, false)
			end

			self:refreshLvup()
		else
			logError(string.format("异常:不存在棋子配置ID:%s星级:%s", chessData.id, chessData.star))
		end

		self:setLock(data.freeze)
	end

	gohelper.setActive(self.go, data)
end

function AutoChessMallItem:setLock(isLock)
	gohelper.setActive(self.goLock, isLock)
end

function AutoChessMallItem:onClick()
	if self.isDraging then
		return
	end

	if self.isFree then
		if not self.mallView.freeMall then
			local mall = self.mallView.chargeMall
			local param = {
				mall = mall,
				itemUId = self.data.uid
			}

			AutoChessController.instance:openCardInfoView(param)
		end
	end
end

function AutoChessMallItem:_checkDrag()
	return false
end

function AutoChessMallItem:_beginDrag()
	self.isDraging = true

	gohelper.setAsLastSibling(self.go)
	gohelper.setActive(self.imageBg, false)

	local cost = tonumber(self.txtCost.text)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.DrageMallItem, self.config, cost)
end

function AutoChessMallItem:_onDrag(_, pointerEventData)
	local position = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(position, self.transform.parent)
	local trans = self.transform
	local curAnchorX, curAnchorY = recthelper.getAnchor(trans)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		self:forceEndAnim()

		self.tweenId = ZProj.TweenHelper.DOAnchorPos(trans, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(trans, anchorPos.x, anchorPos.y)
	end
end

function AutoChessMallItem:forceEndAnim()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function AutoChessMallItem:_endDrag(_, pointerEventData)
	self:forceEndAnim()

	self.isDraging = false

	self:checkBuy(pointerEventData.position)
	gohelper.setActive(self.imageBg, true)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.DrageMallItemEnd)
end

function AutoChessMallItem:checkBuy(screenPosition)
	local tempPos = recthelper.screenPosToAnchorPos(screenPosition, self.mallView.viewGO.transform)
	local tileX, tileY = AutoChessGameModel.instance:getNearestTileXY(tempPos.x, tempPos.y)

	if tileX then
		local chessMo = AutoChessModel.instance:getChessMo()

		if not self.isFree and self.cost ~= 0 then
			local enough, toastId = chessMo:checkCostEnough(self.costType, self.cost)

			if not enough then
				ZProj.TweenHelper.DOAnchorPos(self.transform, self.startX, self.startY, 0.2)
				GameFacade.showToast(toastId)

				return
			end
		end

		local chessPos = chessMo:getChessPosition(tileX, tileY)

		if tonumber(chessPos.chess.uid) == 0 then
			if self.config.type == AutoChessStrEnum.ChessType.Incubate and tileX ~= AutoChessEnum.WarZone.Four or self.config.type == AutoChessStrEnum.ChessType.Attack and tileX ~= AutoChessEnum.WarZone.One and tileX ~= AutoChessEnum.WarZone.Three or self.config.type == AutoChessStrEnum.ChessType.Support and tileX ~= AutoChessEnum.WarZone.Two then
				GameFacade.showToast(ToastEnum.AutoChessBuyWarZoneError)
				ZProj.TweenHelper.DOAnchorPos(self.transform, self.startX, self.startY, 0.2)

				return
			else
				AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
			end
		else
			if self.config.type == AutoChessStrEnum.ChessType.Incubate or tileX == AutoChessEnum.WarZone.Four then
				GameFacade.showToast(ToastEnum.AutoChessBuyWarZoneError)
				ZProj.TweenHelper.DOAnchorPos(self.transform, self.startX, self.startY, 0.2)

				return
			end

			local canMix, param = AutoChessHelper.canMix(chessPos.chess, self.data.chess)

			if canMix then
				local data = chessPos.chess

				if not param and data.exp == data.maxExpLimit then
					GameFacade.showToast(ToastEnum.AutoChessExpMax)
					ZProj.TweenHelper.DOAnchorPos(self.transform, self.startX, self.startY, 0.2)

					return
				else
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
				end
			else
				GameFacade.showToast(param)
				ZProj.TweenHelper.DOAnchorPos(self.transform, self.startX, self.startY, 0.2)

				return
			end
		end

		gohelper.setActive(self.go, false)
		recthelper.setAnchor(self.transform, self.startX, self.startY)

		local moduleId = AutoChessModel.instance.moduleId

		AutoChessRpc.instance:sendAutoChessBuyChessRequest(moduleId, self.mallId, self.data.uid, tileX, tileY - 1)
	else
		ZProj.TweenHelper.DOAnchorPos(self.transform, self.startX, self.startY, 0.2)
	end
end

function AutoChessMallItem:initBuffEffect()
	self.effectComp:hideAll()

	for _, buff in ipairs(self.data.chess.buffContainer.buffs) do
		local buffeffectID = lua_auto_chess_buff.configDict[buff.id].buffeffectID

		if buffeffectID ~= 0 then
			local effectCo = lua_auto_chess_effect.configDict[buffeffectID]

			if effectCo.loop == 1 then
				self.effectComp:playEffect(effectCo)
			end
		end
	end

	local effectTag = self.config.tag

	if not string.nilorempty(effectTag) then
		self.effectComp:playEffect(AutoChessEnum.Tag2EffectId[effectTag])
	end

	if self.data.chess.star ~= 0 and self.data.chess.star ~= 1 then
		self.effectComp:playEffect(50002)
	end
end

function AutoChessMallItem:refreshLvup()
	if not self.config then
		return
	end

	local fightMo = AutoChessModel.instance:getChessMo().svrFight

	if fightMo:hasUpgradeableChess(self.config.id) then
		gohelper.setActive(self.golvup, true)
	else
		gohelper.setActive(self.golvup, false)
	end
end

return AutoChessMallItem
