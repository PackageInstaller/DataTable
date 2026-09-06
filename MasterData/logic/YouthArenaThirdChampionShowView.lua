-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionShowView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionShowView", package.seeall)

local YouthArenaThirdChampionShowView = class("YouthArenaThirdChampionShowView", ViewComponent)
local CHAMPION_PLAYER_COUNT = 3

function YouthArenaThirdChampionShowView:ctor()
	YouthArenaThirdChampionShowView.super.ctor(self)
end

function YouthArenaThirdChampionShowView:buildUI()
	YouthArenaThirdChampionShowView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._btnPk1 = self:getGo("btnPk1")
	self._btnPk2 = self:getGo("btnPk2")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnRank = self:getGo("btns/btnRank")
	self._btnRankPrize = self:getGo("btns/btnRankPrize")
	self._btnShop = self:getGo("btns/btnShop")
	self._txtPrizeTimes = self:getTxt("prizeTimes/txt1")
	self._roleCellList = {}

	for i = 1, CHAMPION_PLAYER_COUNT do
		self._roleCellList[i] = self:_buildRoleCell(i)
	end
end

function YouthArenaThirdChampionShowView:bindEvents()
	YouthArenaThirdChampionShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPk1, GameUtil.handler(self._onClickBtnPk, self, YouthArenaThirdEnum.BattleMode.One))
	GameUtil.addClickHandler(self._btnPk2, GameUtil.handler(self._onClickBtnPk, self, YouthArenaThirdEnum.BattleMode.Three))
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnRankPrize, self._onClickBtnRankPrize, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)

	for i, cell in ipairs(self._roleCellList or {}) do
		GameUtil.addClickHandler(cell.btnShow, GameUtil.handler(self._onClickRole, self, i))
	end
end

function YouthArenaThirdChampionShowView:unbindEvents()
	YouthArenaThirdChampionShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPk1)
	GameUtil.rmClickHandler(self._btnPk2)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnRankPrize)
	GameUtil.rmClickHandler(self._btnShop)

	for _, cell in ipairs(self._roleCellList or {}) do
		GameUtil.rmClickHandler(cell.btnShow)
	end
end

function YouthArenaThirdChampionShowView:onEnter()
	YouthArenaThirdChampionShowView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetDisplayInfoRes, self._handleDisplayInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetQualifierInfoRes, self._handleQualifierInfoRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabData = params[2]
	self._actData = YouthArenaThirdConfig.instance:getActivityData(self._activityId)

	self:_clearRoleList()
	self:_refreshDisplayInfo()
	self:_refreshPrizeTimes()
	self:_sendDisplayInfoReq()
	self:_sendQualifierInfoReq()
end

function YouthArenaThirdChampionShowView:onExit()
	YouthArenaThirdChampionShowView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	self:_clearRoleList()
end

function YouthArenaThirdChampionShowView:destroyUI()
	YouthArenaThirdChampionShowView.super.destroyUI(self)

	for _, cell in ipairs(self._roleCellList or {}) do
		if cell.avatar then
			AvatarsMgrNew.instance:removeAvatar(cell.avatar)

			cell.avatar = nil
		end
	end
end

function YouthArenaThirdChampionShowView:_buildRoleCell(index)
	local go = self:getGo(string.format("roleList/role_%s", index))
	local rolePoint = self:getGo(string.format("modelCam/rolePoint_%s", index))
	local cell = {
		go = go,
		rolePoint = rolePoint,
		txtName = goutil.findChildTextComponent(go, "infoCom/txtNameShow"),
		txtPower = goutil.findChildTextComponent(go, "infoCom/txtPower"),
		btnShow = goutil.findChild(go, "btnShow")
	}

	cell.avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	cell.avatar:setParent(rolePoint.transform)
	cell.avatar:setLayer(SceneLayer.UI3D_Value)

	return cell
end

function YouthArenaThirdChampionShowView:_handleDisplayInfoRes()
	self:_refreshDisplayInfo()
end

function YouthArenaThirdChampionShowView:_handleQualifierInfoRes()
	self:_refreshPrizeTimes()
end

function YouthArenaThirdChampionShowView:_refreshDisplayInfo()
	local subMo = self:_getSubMo()
	local displayInfo = subMo and subMo:getDisplayInfo()

	if displayInfo then
		if not displayInfo.playerList then
			local playerList = {}

			for i = 1, CHAMPION_PLAYER_COUNT do
				self:_refreshRoleCell(self._roleCellList[i], playerList[i])
			end
		end
	end
end

function YouthArenaThirdChampionShowView:_refreshPrizeTimes()
	local subMo = self:_getSubMo()
	local qualifierInfo = subMo and subMo:getQualifierInfo(YouthArenaThirdEnum.MatchStepId.Fun, YouthArenaThirdEnum.BattleMode.One)

	if qualifierInfo then
		if not qualifierInfo.dailyFightTimes then
			local dailyFightTimes = 0

			if self._actData then
				if not self._actData.dailyMatchPrizeTimes then
					local dailyMatchPrizeTimes = 0
					local leftTimes = math.max(checknumber(dailyMatchPrizeTimes) - checknumber(dailyFightTimes), 0)

					self._txtPrizeTimes.text = string.format("今日剩余奖励次数：%s", leftTimes)
				end
			end
		end
	end
end

function YouthArenaThirdChampionShowView:_refreshRoleCell(cell, playerInfo)
	if not cell then
		return
	end

	self:_clearRoleCell(cell)

	cell.playerInfo = playerInfo

	local headInfo = self:_getHeadInfo(playerInfo)

	if not headInfo or checknumber(headInfo.userId) <= 0 then
		goutil.setActive(cell.go, false)

		return
	end

	goutil.setActive(cell.go, true)

	cell.txtName.text = string.format("s%03d-%s", checknumber(headInfo.areaId), headInfo.userName or "")
	cell.txtPower.text = tostring(checknumber(playerInfo.zdl))

	local skId = DressModel.instance:getSkeIdByGender(playerInfo.gender)
	local mo = DressModel.instance:getAvatarPlayerMo(skId, (not playerInfo.clothes or nil) and {}, 0)

	cell.avatar:updateByMo(mo)
	cell.avatar:setVisible(true)
end

function YouthArenaThirdChampionShowView:_clearRoleList()
	for _, cell in ipairs(self._roleCellList or {}) do
		self:_clearRoleCell(cell)
	end
end

function YouthArenaThirdChampionShowView:_clearRoleCell(cell)
	if not cell then
		return
	end

	cell.playerInfo = nil

	if cell.txtName then
		cell.txtName.text = ""
	end

	if cell.txtPower then
		cell.txtPower.text = "0"
	end

	if cell.avatar then
		cell.avatar:setVisible(false)
	end
end

function YouthArenaThirdChampionShowView:_sendDisplayInfoReq()
	if self._activityId <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetDisplayInfoReq(self._activityId)
end

function YouthArenaThirdChampionShowView:_sendQualifierInfoReq()
	if self._activityId <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetQualifierInfoReq(self._activityId, YouthArenaThirdEnum.MatchStepId.Fun, YouthArenaThirdEnum.BattleMode.One)
end

function YouthArenaThirdChampionShowView:_getSubMo()
	if self._activityId <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

function YouthArenaThirdChampionShowView:_getHeadInfo(playerInfo)
	local playerHeadInfo = playerInfo and playerInfo.headInfo

	return playerHeadInfo and playerHeadInfo.headInfo
end

function YouthArenaThirdChampionShowView:_onClickBtnPk(mode)
	if self._tabData then
		if self._tabData then
			self._tabData.onClickFun(mode)

			return
		end

		UIStateManager.instance:push(ViewName.YouthArenaThirdMatchHallView, self._activityId, YouthArenaThirdEnum.MatchStepId.Fun, mode)
	end
end

function YouthArenaThirdChampionShowView:_onClickBtnTip()
	if self._actData then
		if string.nilorempty(self._actData) then
			return
		end

		TipsFacade.instance:openRulesView(self._actData)
	end
end

function YouthArenaThirdChampionShowView:_onClickBtnRank()
	YouthArenaThirdController.instance:openRankView(self._activityId, YouthArenaThirdEnum.RankStage.ChampionScore, YouthArenaThirdEnum.RankType.PlayerScore)
end

function YouthArenaThirdChampionShowView:_onClickBtnRankPrize()
	UIStateManager.instance:push(ViewName.YouthArenaThirdRankPrizeView, self._activityId)
end

function YouthArenaThirdChampionShowView:_onClickBtnShop()
	if self._actData then
		if not string.nilorempty(self._actData) then
			GotoMgr.gotoByString(self._actData)
		end
	end
end

function YouthArenaThirdChampionShowView:_onClickRole(index)
	if self._roleCellList then
		local cell = self._roleCellList[index]
		local headInfo = self:_getHeadInfo(cell and cell.playerInfo)
		local userId = checknumber(headInfo and headInfo.userId)

		if userId <= 0 then
			return
		end

		FriendController.instance:showInfoView(userId, cell.btnShow)
	end
end

return YouthArenaThirdChampionShowView
