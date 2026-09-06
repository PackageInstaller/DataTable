-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/FamilytpsmallgameView.lua

module("logic.extensions.familyteamplay.view.FamilytpsmallgameView", package.seeall)

local FamilytpsmallgameView = class("FamilytpsmallgameView", FlyTweenBase)

function FamilytpsmallgameView:ctor()
	FamilytpsmallgameView.super.ctor(self)
end

function FamilytpsmallgameView:buildUI()
	FamilytpsmallgameView.super.buildUI(self)

	self._btnStart = self:getBtn("btnStart")
	self._btnClose = self:getBtn("btnClose")
	self._btnRight = self:getBtn("btnRight")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnTips = self:getBtn("btnPrize")
	self._txtRule = goutil.findChildTextComponent(self.mainGO, "rule/txtRule")
	self._btnPrize = self:getBtn("btnPrize")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._timeGo = self:getGo("time")
	self._kjtBgGo = self:getGo("kjtBg")
	self._otherBgGo = self:getGo("otherBg")
	self._btnPrizeChange = self:getGo("btnPrize"):GetComponent(ComponentType.UIChangeGroup)
end

function FamilytpsmallgameView:bindEvents()
	FamilytpsmallgameView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
	self._btnPrize:AddClickListener(self._onClickbtnPrize, self)
end

function FamilytpsmallgameView:unbindEvents()
	FamilytpsmallgameView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnPrize:RemoveClickListener()
end

function FamilytpsmallgameView:onEnter()
	FamilytpsmallgameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlaySmallGameStart, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._updateView, self)

	self._baseInfo = FamilyteamplayModel.instance:getBaseProgressInfo()

	self:_initData()

	local position = self:getFirstParam()

	if position then
		local uiFlyParam = UIFlyTweenParam.New()

		uiFlyParam.endPosition = position

		self:_setUIFlyTweenParam(uiFlyParam)
	end
end

function FamilytpsmallgameView:onExit()
	FamilytpsmallgameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlaySmallGameStart, self.close, self)
	GlobalDispatcher:removeListener(GlobalNotify.ApplicationResume, self._updateView, self)
	removetimer(self._updateLeftTime, self)
	uGuiUtil.clearImage(self._otherBgGo)
end

function FamilytpsmallgameView:_onClickbtnStart()
	if self._baseInfo and checknumber(self._baseInfo.periodId) > 0 and self._curData then
		if self._leftTime <= 0 then
			FloatWordMgr.instance:show("活动已过期")

			return
		end

		FamilyteamplayController.instance:csSendTeamPlaySmallGameStartReq(self._baseInfo.periodId, self._curData.gameId)
	end
end

function FamilytpsmallgameView:_onClickbtnClose()
	local function closeCallback()
		self:close()
	end

	self:_doCloseCallback(closeCallback)
end

function FamilytpsmallgameView:_onClickbtnLeft()
	if self._currGroupIndex <= 1 then
		return
	end

	self._currGroupIndex = self._currGroupIndex - 1

	self:_updateView()
	self:_setChangePageBtnShowState()
end

function FamilytpsmallgameView:_onClickbtnRight()
	if self._currGroupIndex >= self._MaxGroupIndex then
		return
	end

	self._currGroupIndex = self._currGroupIndex + 1

	self:_updateView()
	self:_setChangePageBtnShowState()
end

function FamilytpsmallgameView:_onClickbtnPrize()
	if self._gameId > 0 then
		local cfg = FamilyteamplayConfig.instance:getSmallGameCfg(self._gameId)

		if cfg.typeId == GameEnum.FamilyTpSmallGame.KJT then
			UIStateManager.instance:push(ViewName.FamilytpsamallgamerewardView, self._gameId)
		else
			UIStateManager.instance:push(ViewName.FamilytpscoretorewardView, self._gameId)
		end
	end
end

function FamilytpsmallgameView:_initData()
	self._dataList = FamilyteamplayModel.instance:getAvailableGames()

	local newGameId = FamilyteamplayModel.instance:getNewSmallGameId()

	self._currGroupIndex = 1

	if newGameId > 0 then
		FamilyteamplayModel.instance:resetNewSmallGameId()

		for i, v in ipairs(self._dataList) do
			if v.gameId == newGameId then
				self._currGroupIndex = i

				break
			end
		end
	end

	self._MaxGroupIndex = #self._dataList

	self:_setChangePageBtnShowState()
	self:_updateView()
end

function FamilytpsmallgameView:_updateView()
	self._curData = self._dataList[self._currGroupIndex]
	self._leftTime = 0
	self._gameId = 0

	local isKjtGame = false

	if self._curData then
		self._gameId = self._curData.gameId
		self._leftTime = checknumber(self._curData.expiredTimeMillis) - ServerTime.nowMs()
		self._leftTime = math.ceil(self._leftTime / 1000)

		if self._leftTime > 0 then
			settimer(1, self._updateLeftTime, self, true)
		end

		local cfg = FamilyteamplayConfig.instance:getSmallGameCfg(self._curData.gameId)

		self._txtRule.text = cfg.des

		if cfg.gameTime > 0 then
			self._txtTime.text = cfg.gameTime .. "秒" or "不限时"
		end

		isKjtGame = cfg.typeId == GameEnum.FamilyTpSmallGame.KJT

		if not isKjtGame then
			local folder = "familyteamplay"

			if cfg.typeId == GameEnum.FamilyTpSmallGame.Flynuo then
				uGuiUtil.setSpriteToImage(self._otherBgGo, nil, GameUrl.getBigbgFolderUrl(folder, "board_jztb_yongchuanglongcheng"))
			elseif cfg.typeId == GameEnum.FamilyTpSmallGame.ZSM then
				uGuiUtil.setSpriteToImage(self._otherBgGo, nil, GameUrl.getBigbgFolderUrl(folder, "board_jztb_zhuashuimu"))
			end
		end
	end

	self._btnPrizeChange:SetState(isKjtGame and 0 or 1)
	goutil.setActive(self._timeGo, isKjtGame)
	goutil.setActive(self._kjtBgGo, isKjtGame)
	goutil.setActive(self._otherBgGo, not isKjtGame)
	self:_updateLeftTime()
end

function FamilytpsmallgameView:_updateLeftTime()
	removetimer(self._updateLeftTime, self)
end

function FamilytpsmallgameView:_setChangePageBtnShowState()
	goutil.setActive(self._btnLeft.gameObject, self._currGroupIndex > 1)
	goutil.setActive(self._btnRight.gameObject, self._currGroupIndex < self._MaxGroupIndex)
end

return FamilytpsmallgameView
