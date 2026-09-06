-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleEggView.lua

module("logic.extensions.freescuffle.view.FreeScuffleEggView", package.seeall)

local FreeScuffleEggView = class("FreeScuffleEggView", ViewComponent)

function FreeScuffleEggView:ctor()
	FreeScuffleEggView.super.ctor(self)
end

function FreeScuffleEggView:buildUI()
	FreeScuffleEggView.super.buildUI(self)

	self._bouns = self:getGo("bouns")
	self._egg = self:getGo("egg")
	self._items = self:getGo("items")
	self._btnEgg = self:getGo("egg/btnEgg")
	self._txtCountDown = self:getTxt("countdown/txtTime")
	self._countdown = self:getGo("countdown")
	self._imgNumGo = self:getGo("egg/imgNum")
	self._imgNum = self:getGo("egg/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._eggPoint = self:getGo("egg/eggPoint")
	self._dandaEffRoot = self:getGo("dandaEffRoot")

	local prizeScrCell = self:getGo("prizeCol/scrCell")
	local prizeScrView = self:getGo("prizeCol/scrView")

	self._prizeScrollList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollList:setCenterMode(true)
	GameUtil.SetActive(self._egg, false)
	GameUtil.SetActive(self._countdown, false)
end

function FreeScuffleEggView:bindEvents()
	FreeScuffleEggView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnEgg, self._onClickEgg, self)
end

function FreeScuffleEggView:unbindEvents()
	FreeScuffleEggView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnEgg)
end

function FreeScuffleEggView:onEnter()
	FreeScuffleEggView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._totalTime = 5
	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._coinItem = self._subMo:getCostCoinItem()

	self:_onResetGame()
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleStartEasterEggGameRes, self._handlePM_FreeScuffleStartEasterEggGameRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleEndEasterEggGameRes, self._handlePM_FreeScuffleEndEasterEggGameRes, self)
	self:addGEvent(GlobalNotify.ItemGetViewDoClosed, self._itemGetViewDoClosed)
	FreeScuffleController.instance:sendPM_FreeScuffleStartEasterEggGameReq(self._activityId)
end

function FreeScuffleEggView:onExit()
	FreeScuffleEggView.super.onExit(self)
	removetimer(self._onTicking, self)
	removetimer(self._onStartGame, self)
	self:_unloadSpine()
	self._prizeScrollList:dispose()
	GlobalDispatcher:dispatch(GlobalNotify.FreeScuffleFinishEggEvent)
end

function FreeScuffleEggView:destroyUI()
	FreeScuffleEggView.super.destroyUI(self)
	self:_onDestorySpine()
end

function FreeScuffleEggView:_handlePM_FreeScuffleStartEasterEggGameRes(status)
	if status ~= 0 then
		self:close()

		return
	end

	settimer(2, self._onStartGame, self, false)
end

function FreeScuffleEggView:_handlePM_FreeScuffleEndEasterEggGameRes(status, msg)
	if status ~= 0 then
		self:close()

		return
	end

	if not msg:HasField("changeSetId") then
		self:close()

		return
	end

	local coinNum = checknumber(msg.curGainCoin)

	if coinNum > 0 then
		local moList = MaterialController.instance:getItemsByChangeSetId(msg.changeSetId) or {}
		local mo = MaterialModel.instance:createMo(self._coinItem.matType, self._coinItem.matId, coinNum)

		table.insert(moList, mo)

		if #moList > 0 then
			local clientChangeSetId = MaterialController.instance:getClientChangeSetId(true)

			MaterialController.instance:showChangeSetItemMo(moList, clientChangeSetId)
		end
	end
end

function FreeScuffleEggView:_itemGetViewDoClosed()
	self:close()
end

function FreeScuffleEggView:_onResetGame()
	self._isGameing = false
	self._hitNum = 0
	self._curPrizeId = 0

	self._imgNum:SetText(self._hitNum)
	GameUtil.SetActive(self._bouns, true)
	GameUtil.SetActive(self._countdown, false)
	GameUtil.SetActive(self._imgNumGo, false)
	self:_onUpdatePrizeUI()
	self:_loadSpine()
end

function FreeScuffleEggView:_onStartGame()
	removetimer(self._onStartGame, self)
	GameUtil.SetActive(self._bouns, false)
	GameUtil.SetActive(self._countdown, true)
	GameUtil.SetActive(self._egg, true)
	GameUtil.SetActive(self._imgNumGo, true)

	self._curTime = 0
	self._isGameing = true

	settimer(0, self._onTicking, self)
	self:_onTicking()
end

function FreeScuffleEggView:_onTicking()
	if not self._isGameing then
		return
	end

	self._curTime = self._curTime + UnityEngine.Time.deltaTime

	local leftTime = Mathf.Max(self._totalTime - self._curTime, 0)

	self._txtCountDown.text = Mathf.Ceil(leftTime)

	if leftTime <= 0 then
		removetimer(self._onTicking, self)

		self._isGameing = false

		FreeScuffleController.instance:sendPM_FreeScuffleEndEasterEggGameReq(self._activityId, self._hitNum)
	end
end

function FreeScuffleEggView:_onClickEgg()
	if not self._isGameing then
		return
	end

	self:_playEggHitAnim()

	self._hitNum = self._hitNum + 1

	self._imgNum:SetText(self._hitNum)
	self:_onUpdatePrizeUI()
end

function FreeScuffleEggView:_onUpdatePrizeUI()
	local data = FreeScuffleConfig.instance:getGuestEventPrizeDataByHit(self._activityId, self._hitNum)

	if data then
		if data.prizeId ~= self._curPrizeId then
			self._curPrizeId = data.prizeId

			if not string.nilorempty(data.prize) then
				local arr = string.split(data.prize, "#")

				if checknumber(data.increaseCoin) > 0 then
					local matStr = string.format("%s:%s:%s", self._coinItem.matType, self._coinItem.matId, data.increaseCoin)

					table.insert(arr, matStr)
				end

				self._prizeScrollList:reloadData(arr)
			else
				self._prizeScrollList:dispose()
			end
		end
	else
		self._prizeScrollList:dispose()
	end
end

function FreeScuffleEggView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function FreeScuffleEggView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function FreeScuffleEggView:_loadSpine()
	local spineRoot = self._eggPoint
	local view = self
	local spinePath = "effect/prefabs/ui/fx_ui_yirenzhixia/yirenzhixia_dan/dan-ui_p.prefab"

	self._spineCtrl = self._spineCtrl or FreeScuffleEggSpineCtrl.New()

	self._spineCtrl:onInit(spineRoot, view, spinePath)
end

function FreeScuffleEggView:_unloadSpine()
	if self._spineCtrl then
		self._spineCtrl:onClear()
	end
end

function FreeScuffleEggView:_onDestorySpine()
	if self._spineCtrl then
		self._spineCtrl:onDestory()

		self._spineCtrl = nil
	end
end

local DandaEffUrl = "fx_ui_yirenzhixia/yirenzhixia_dan/fx_ui_yirenzhixia_danda.prefab"

function FreeScuffleEggView:_playEggHitAnim()
	if self._spineCtrl then
		self._spineCtrl:_playAnim("2", false, function(animName)
			self._spineCtrl:playDefaultAnim()
		end)
	end

	self:stopViewEffectUniGo(self._dandaEffRoot)
	self:playViewEffectUniGo(DandaEffUrl, self._dandaEffRoot, self.mainGO, false, nil, nil)
end

return FreeScuffleEggView
