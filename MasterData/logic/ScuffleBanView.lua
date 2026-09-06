-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleBanView.lua

module("logic.extensions.scuffle.view.ScuffleBanView", package.seeall)

local ScuffleBanView = class("ScuffleBanView", ViewComponent)
local Enum = {
	Ban = 2,
	Default = 1,
	StartSetFmt = 4,
	RandomSet = 3
}

function ScuffleBanView:ctor()
	ScuffleBanView.super.ctor(self)

	self._scufflePetCellList = {}
	self._countDown = 0
	self._curState = Enum.Default
	self._isCountdown = false
	self._banTimeCountdown = 0
	self._isBanCountdown = false
end

function ScuffleBanView:buildUI()
	ScuffleBanView.super.buildUI(self)

	local petCard = self:getGo("petCard")

	petCard:SetActive(false)

	self._playerInfo1 = ScuffleBanPlayer.New(true)
	self._playerInfo2 = ScuffleBanPlayer.New(false)

	self._playerInfo1:buildUI(self:getGo("playerInfo1"), petCard)
	self._playerInfo2:buildUI(self:getGo("playerInfo2"), petCard)

	self._scrollRect = self:getGo("tableview"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._petListGo = self:getGo("tableview/viewport/content")
	self._petCell = self:getGo("petCell")

	self._petCell:SetActive(false)

	self._rangeRect = self._scrollRect.gameObject:GetComponent(goutil.Type_RectTransform)
	self._txtBanNum = self:getTxt("txtBanNum")
	self._btnSure = self:getBtn("btnSure")
	self._txtTime = self:getTxt("txtTime")
	self._txtDesc = self:getTxt("txtDesc")
	self._tipBoard = self:getGo("tipBoard")
	self._imgChangeTip = self:getGo("tipBoard/imgTip"):GetComponent(typeof(UIImageSpriteChange))
	self._maskGo = self:getGo("mask")
	self._waitShow = self:getGo("waitShow")
	self._txtWait = self:getTxt("waitShow/txtWait")
	self._imgGo = self:getGo("img")
end

function ScuffleBanView:destroyUI()
	ScuffleBanView.super.destroyUI(self)
	self._playerInfo1:destroyUI()
	self._playerInfo2:destroyUI()
end

function ScuffleBanView:bindEvents()
	ScuffleBanView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ScuffleBanView:unbindEvents()
	ScuffleBanView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function ScuffleBanView:onEnter()
	ScuffleBanView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SF_NotfiyStartSetFormRes, self._onStartSetFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SF_NotifyGameEndRes, self._onGameEndRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ScuffleSelectPet, self._onClickSelectPet, self)
	self:_endWaitShow()
	settimer(1, self._onSecond, self)
	self:_resetView()
	self:_startDefaultState()
end

function ScuffleBanView:onExit()
	ScuffleBanView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_NotfiyStartSetFormRes, self._onStartSetFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_NotifyGameEndRes, self._onGameEndRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScuffleSelectPet, self._onClickSelectPet, self)
	removetimer(self._onSecond, self)
	self._playerInfo1:onExit()
	self._playerInfo2:onExit()
	self:_removePetCellList()
	self:_resetView()
	self:_removeTween()
	self:_endWaitShow()
end

function ScuffleBanView:_onClickClose()
	self:close()
end

function ScuffleBanView:_onClickSure()
	if ScuffleModel.instance:isCanSelectBanPet() then
		self._isBanCountdown = false

		self:_closeBtnSure()
		ScuffleModel.instance:setIsCanSelectBanPet(false)
		ScuffleController.instance:sendSF_BanPetReq()
		self:_startWaitShow(self._banTimeCountdown)
	else
		FloatWordMgr.instance:show("禁用已完成")
	end
end

function ScuffleBanView:_onStartSetFormRes()
	self:_onBanFinish()
	self:_endWaitShow()
	self:_showTipBoard(Enum.RandomSet)
end

function ScuffleBanView:_onGameEndRes()
	ScuffleController.instance:onGameEndRes(function()
		self:_onClickClose()
	end)
end

function ScuffleBanView:_onClickSelectPet()
	self:_updateBanNum()
end

function ScuffleBanView:_updateBanNum()
	local curCount = ScuffleModel.instance:getMyBanPetCount()
	local maxCount = ScuffleModel.instance:getMaxBanPetCount()

	self._txtBanNum.text = string.format("%d/%d", curCount, maxCount)
end

function ScuffleBanView:_onSecond()
	if self._isCountdown then
		if self._countDown > 0 then
			self._countDown = self._countDown - 1
		else
			self._isCountdown = false

			self:_closeTipBoard()
			self:_changeState()
		end
	end

	if self._isBanCountdown then
		if self._banTimeCountdown >= 0 then
			self:_showTxtTime(self._banTimeCountdown)

			self._banTimeCountdown = self._banTimeCountdown - 1
		else
			self:_onClickSure()
		end
	end

	if self._isStartWaitShow then
		if self._waitCountdown > 0 then
			self._waitCountdown = self._waitCountdown - 1

			self:_showWaitLeftTime(self._waitCountdown)
		else
			self:_stopWaitShow()
		end
	end
end

function ScuffleBanView:_resetView()
	self._maskGo:SetActive(false)
	self._tipBoard:SetActive(false)
	self._maskGo:SetActive(false)
	self._txtBanNum.gameObject:SetActive(true)
	self._txtDesc.gameObject:SetActive(false)
	self._btnSure.gameObject:SetActive(false)
	self._imgGo:SetActive(false)
	self._txtTime.gameObject:SetActive(false)
	uGuiUtil.setImageGrayStateRecursive(self._btnSure.gameObject, false)
end

function ScuffleBanView:_closeBtnSure()
	self._txtDesc.gameObject:SetActive(true)
	self._txtTime.gameObject:SetActive(false)
	self._imgGo:SetActive(false)
	uGuiUtil.setImageGrayStateRecursive(self._btnSure.gameObject, true)
end

function ScuffleBanView:_openBtnSure()
	self._txtDesc.gameObject:SetActive(false)
	self._btnSure.gameObject:SetActive(true)
	self._imgGo:SetActive(true)
	self._txtTime.gameObject:SetActive(true)
end

function ScuffleBanView:_onBanFinish()
	self._txtDesc.gameObject:SetActive(false)
end

function ScuffleBanView:_startDefaultState()
	self._isCountdown = false
	self._curState = Enum.Default

	self._playerInfo1:setPlayerInfo(true)
	self._playerInfo1:initCardList(ScuffleModel.instance:getMyInitPets())
	self._playerInfo2:setPlayerInfo(false)
	self._playerInfo2:initCardList(ScuffleModel.instance:getEnemyInitPets())
	self:_initPetList()
	self:_updateBanNum()
	self:_showTipBoard(Enum.Ban)
end

function ScuffleBanView:_startBanState()
	self._curState = Enum.Ban

	ScuffleModel.instance:setIsCanSelectBanPet(true)
	self:_openBtnSure()

	self._banTimeCountdown = checknumber(ScuffleConfig.instance:getCommonValueByKey("BAN_TIME"))
	self._isBanCountdown = true

	self:_showTxtTime(self._banTimeCountdown)
end

function ScuffleBanView:_startRandomSetPet()
	self._curState = Enum.RandomSet

	self._playerInfo1:addCardList(ScuffleModel.instance:getMyRandomPets())
	self._playerInfo2:addCardList(ScuffleModel.instance:getEnemyRandomPets())
	self:_updatePoolPetsState()

	self._tween = TweenUtil.DoDelay(6, function()
		self:_showTipBoard(Enum.StartSetFmt)
	end)
end

function ScuffleBanView:_startSetFormationState()
	self._curState = Enum.StartSetFmt

	self:_openFormationView()
	self:_onClickClose()
end

function ScuffleBanView:_openFormationView()
	UIStateManager.instance:push(ViewName.ScuffleMissionView)
end

function ScuffleBanView:_initPetList()
	self:_removePetCellList()

	self._scrollRect.horizontalNormalizedPosition = 0

	local creepsIdList = ScuffleModel.instance:getPoolPets()

	for index, id in ipairs(creepsIdList) do
		local go = goutil.cloneAndSetParent(self._petCell, self._petListGo.transform, "petCell" .. index)

		go:SetActive(true)

		local scufflePetCell = GameUtil.AddLuaOnce(go, ScufflePetCell)

		scufflePetCell:buildUI(go)
		scufflePetCell:init(index, id)
		table.insert(self._scufflePetCellList, scufflePetCell)
	end
end

function ScuffleBanView:_removePetCellList()
	for i, v in ipairs(self._scufflePetCellList) do
		v:onReset()
	end

	table.clear(self._scufflePetCellList)
	goutil.clearChildren(self._petListGo)
end

function ScuffleBanView:_showTipBoard(enumState)
	self._countDown = 1
	self._isCountdown = true

	self._tipBoard:SetActive(true)
	self._maskGo:SetActive(true)

	local txt

	if enumState == Enum.Ban then
		txt = "请选择本局禁用精灵"
		self._countDown = 1

		self._imgChangeTip:SetState(0)
	elseif enumState == Enum.RandomSet then
		txt = "开始随机分配精灵"

		self._imgChangeTip:SetState(1)
	elseif enumState == Enum.StartSetFmt then
		self._countDown = 1
		txt = "请开始布阵"

		self._imgChangeTip:SetState(2)
	end

	printInfo("test _showTipBoard", txt)
end

function ScuffleBanView:_closeTipBoard()
	self._tipBoard:SetActive(false)
	self._maskGo:SetActive(false)
end

function ScuffleBanView:_changeState()
	if self._curState == Enum.Default then
		self:_startBanState()
	elseif self._curState == Enum.Ban then
		self:_startRandomSetPet()
	elseif self._curState == Enum.RandomSet then
		self:_startSetFormationState()
	end
end

function ScuffleBanView:_updatePoolPetsState()
	local internalTime = 0

	for i, v in ipairs(self._scufflePetCellList) do
		if v:isRandomSelectPet() then
			internalTime = internalTime + 0.1

			v:setRandomSelect(internalTime, self, self._rangeRect)
		else
			v:setRandomSelect()
		end
	end
end

function ScuffleBanView:_showTxtTime(time)
	self._txtTime.text = string.format("剩余时间%ds", time)
end

function ScuffleBanView:_removeTween()
	if self._tween then
		self._tween:Kill()

		self._tween = nil
	end
end

function ScuffleBanView:_startWaitShow(time)
	self._isStartWaitShow = true
	self._waitCountdown = time

	self._waitShow:SetActive(true)
	self:_showWaitLeftTime(self._waitCountdown)
end

function ScuffleBanView:_stopWaitShow()
	self._isStartWaitShow = false
end

function ScuffleBanView:_endWaitShow()
	self:_stopWaitShow()
	self._waitShow:SetActive(false)
end

function ScuffleBanView:_showWaitLeftTime(second)
	self._txtWait.text = string.format("剩余<color=#ff0000>%d</color>秒", second)
end

return ScuffleBanView
