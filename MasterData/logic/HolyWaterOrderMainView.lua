-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderMainView.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderMainView", package.seeall)

local HolyWaterOrderMainView = class("HolyWaterOrderMainView", ViewComponent)
local RedPointKey = "HolyWaterOrderMainView"

function HolyWaterOrderMainView:ctor()
	HolyWaterOrderMainView.super.ctor(self)
end

function HolyWaterOrderMainView:buildUI()
	HolyWaterOrderMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnShenYao = self:getBtn("btnShenYao")
	self._btnShenYaoMat = self:getBtn("btnShenYaoMat")
	self._btnCultivate = self:getBtn("btnCultivate")
	self._btnRank = self:getBtn("btnRank")
	self._btnStart = self:getBtn("btnStart")
	self._btnChallengeRank = self:getBtn("btnChallengeRank")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._txtStar = self:getTxt("btnStart/txtStar")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._redPoint = self:getGo("btnStart/redpoint")
end

function HolyWaterOrderMainView:bindEvents()
	HolyWaterOrderMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnShenYao:AddClickListener(self._onClickShenYao, self)
	self._btnShenYaoMat:AddClickListener(self._onClickShenYaoMat, self)
	self._btnCultivate:AddClickListener(self._onClickCultivate, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnChallengeRank:AddClickListener(self._onClickChallengeRank, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function HolyWaterOrderMainView:unbindEvents()
	HolyWaterOrderMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnShenYao:RemoveClickListener()
	self._btnShenYaoMat:RemoveClickListener()
	self._btnCultivate:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnChallengeRank:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function HolyWaterOrderMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "holywaterordermainview_rule")
end

function HolyWaterOrderMainView:_onClickShenYao()
	GotoMgr.gotoByString(self._cfgActivity.jumpShenYao)
end

function HolyWaterOrderMainView:_onClickShenYaoMat()
	GotoMgr.gotoByString(self._cfgActivity.jumpShenYaoMat)
end

function HolyWaterOrderMainView:_onClickCultivate()
	GotoMgr.gotoByString(self._cfgActivity.jumpCultivate)
end

function HolyWaterOrderMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpRank)
end

function HolyWaterOrderMainView:_onClickStart()
	if self._isClick then
		if not HolyWaterOrderModel.instance:isSelectedPet() then
			UIStateManager.instance:push(ViewName.HolyWaterOrderSelectView, self._activityId, HolyWaterOrderModel.SelectPet)
		else
			UIStateManager.instance:push(ViewName.HolyWaterOrderChallengeView, self._activityId)
		end

		local isClickRed = GameUtil.getUserDayData(RedPointKey)

		if not isClickRed then
			goutil.setActive(self._redPoint, false)
			GameUtil.saveUserDayData(RedPointKey, true)
		end
	end
end

function HolyWaterOrderMainView:_onClickChallengeRank()
	UIStateManager.instance:push(ViewName.HolyWaterOrderRankView, self._activityId)
end

function HolyWaterOrderMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function HolyWaterOrderMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId, self._skinId)
	end
end

function HolyWaterOrderMainView:onEnter()
	HolyWaterOrderMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HolyWaterOrderInfoRes, self._onInfoRes, self)

	self._activityId = HolyWaterOrderModel.instance:getActivityId()
	self._activityType = HolyWaterOrderModel.instance:getActivityType()
	self._isClick = false

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:_showCloseTip()

		return
	end

	self._cfgActivity = HolyWaterOrderConfig.instance:getActivityCfg(self._activityId)
	self._raceId = self._cfgActivity.showRaceId
	self._skinId = 0

	local isClickRed = GameUtil.getUserDayData(RedPointKey)

	goutil.setActive(self._redPoint, not isClickRed)
	self:_initActivityTime()
	self:_showRoleModel()
	self:_initPetInfo()
	HolyWaterOrderAgent.instance:sendPM_HolyWaterOrderInfoReq(self._activityId)
end

function HolyWaterOrderMainView:onExit()
	HolyWaterOrderMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyWaterOrderInfoRes, self._onInfoRes, self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function HolyWaterOrderMainView:_onInfoRes()
	self._isClick = true

	self:_updateStarNum()
	self:_initHistoryRecordView()
end

function HolyWaterOrderMainView:_showCloseTip()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func)
end

function HolyWaterOrderMainView:_initActivityTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function HolyWaterOrderMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function HolyWaterOrderMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function HolyWaterOrderMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function HolyWaterOrderMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function HolyWaterOrderMainView:_updateStarNum()
	self._txtStar.text = string.format("累计获得：%d", HolyWaterOrderModel.instance:getTotalStarNum())
end

function HolyWaterOrderMainView:_initHistoryRecordView()
	if HolyWaterOrderModel.instance:isFirstGetRank() then
		local text = ""
		local dailyRankIndex = HolyWaterOrderModel.instance:getDailyRankIndex()
		local historyMaxStars = HolyWaterOrderModel.instance:getHistoryMaxStars()
		local isInRank = dailyRankIndex > 0

		text = isInRank and string.format("已继承历史最高星级，当前星级为%d星，暂居今日排行榜第%d名。", historyMaxStars, dailyRankIndex) or string.format("已继承历史最高星级，当前星级为%d星，今日暂未上榜。", historyMaxStars)
		text = text .. string.format("\n\n<color=#%s>温馨提示：每日星级继承为历史最高星级，排名为继承记录的实时排名，最终排名以排行为准。</color>", ColorConst.Green)

		TipsFacade.instance:openTipWindowNoX(lang("tip"), text)
	end
end

return HolyWaterOrderMainView
