-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderChallengeView.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderChallengeView", package.seeall)

local HolyWaterOrderChallengeView = class("HolyWaterOrderChallengeView", ViewComponent)

function HolyWaterOrderChallengeView:ctor()
	HolyWaterOrderChallengeView.super.ctor(self)
end

function HolyWaterOrderChallengeView:buildUI()
	HolyWaterOrderChallengeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnLookStar = self:getBtn("progress/btnLookStar")
	self._btnReset = self:getBtn("btnReset")
	self._btnLookPet = self:getBtn("btnLookPet")
	self._btnChallenge = self:getBtn("info/btnChallenge")

	local imgFillGo = self:getGo("progress/slider/imgFill")

	self._imgFill = imgFillGo:GetComponent(goutil.Type_UIImage)
	self._fillHeight = imgFillGo:GetComponent(goutil.Type_RectTransform).rect.height
	self._txtStar = self:getTxt("progress/txtStar")
	self._txtCurLevel = self:getTxt("progress/slider/handle/txtCurLevel")
	self._txtNum = self:getTxt("progress/slider/txtNum")
	self._handleRect = self:getGo("progress/slider/handle"):GetComponent(goutil.Type_RectTransform)
	self._txtTime = self:getTxt("time/txt")
	self._con = self:getGo("con")
	self._img3 = self:getGo("progress/slider/handle/img3")
	self._fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("info/fmt/cell_%d", i))
		item.con = self:getGo(string.format("info/fmt/cell_%d/con", i))

		table.insert(self._fmtList, item)
	end
end

function HolyWaterOrderChallengeView:bindEvents()
	HolyWaterOrderChallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnLookStar:AddClickListener(self._onClickLookStar, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnLookPet:AddClickListener(self._onClickLookPet, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function HolyWaterOrderChallengeView:unbindEvents()
	HolyWaterOrderChallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnLookStar:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnLookPet:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function HolyWaterOrderChallengeView:onEnter()
	HolyWaterOrderChallengeView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._cfgStages = HolyWaterOrderConfig.instance:getStageCfgList(self._activityId)
	self._maxStageNum = #self._cfgStages

	local passNum = HolyWaterOrderModel.instance:getPassStageNum()

	self._curStage = Mathf.Min(passNum + 1, self._maxStageNum)
	self._cfgActivity = HolyWaterOrderConfig.instance:getActivityCfg(self._activityId)
	self._raceId = self._cfgActivity.raceId

	self:_initActivityTime()
	self:_initCloseTime()
	self:_updateSlider()
	self:_updateFmtHead()
end

function HolyWaterOrderChallengeView:onExit()
	HolyWaterOrderChallengeView.super.onExit(self)
	self:_clearHeadIcon()
	self:_resetRoleModel()
	HeadItemController.instance:resetHeadCell(self._img3)
end

function HolyWaterOrderChallengeView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "holywaterordechallengeview_rule")
end

function HolyWaterOrderChallengeView:_onClickLookStar()
	UIStateManager.instance:push(ViewName.HolyWaterOrderStarView, self._activityId)
end

function HolyWaterOrderChallengeView:_onClickReset()
	local text = "是否确定重置挑战？重置挑战可以重新选择精灵，同时重置关卡星级和挑战进度。"

	text = text .. string.format("\n\n<color=#%s>温馨提示：重置挑战不会影响已获得最大星级记录</color>", ColorConst.Green)

	local function okFunc()
		HolyWaterOrderAgent.instance:sendPM_HolyWaterOrderResetReq(self._activityId)
		self:close()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function HolyWaterOrderChallengeView:_onClickLookPet()
	UIStateManager.instance:push(ViewName.HolyWaterOrderSelectView, self._activityId, HolyWaterOrderModel.LookOverPet)
end

function HolyWaterOrderChallengeView:_onClickChallenge()
	if not HolyWaterOrderModel.instance:isStagePass(self._stageId) then
		local curDate = GameUtil.time2date(ServerTime.now())

		if curDate.hour >= self._startHour and curDate.hour < self._endHour then
			FloatWordMgr.instance:show(self._cfgActivity.closeRange .. " 无法进入挑战")
		else
			HolyWaterOrderController.instance:openMissionView(self._activityId, self._stageId)
		end
	else
		FloatWordMgr.instance:show("已通关")
	end
end

function HolyWaterOrderChallengeView:_updateSlider()
	local curStage = self._curStage
	local totalStarNum = HolyWaterOrderModel.instance:getTotalStarNum()

	self._txtCurLevel.text = string.format("第%s层", curStage)
	self._txtStar.text = string.format("累计：%d", totalStarNum)
	self._txtNum.text = self._maxStageNum .. "层"

	local percent = Mathf.Clamp01(curStage / self._maxStageNum)

	self._handleRect.anchoredPosition = Vector2.New(self._handleRect.anchoredPosition.x, self._fillHeight * percent)
	self._imgFill.fillAmount = percent
	self._stageId = curStage

	HeadItemController.instance:setMyHeadCellWithoutVip(self._img3)
end

function HolyWaterOrderChallengeView:_initActivityTime()
	local activityType = HolyWaterOrderModel.instance:getActivityType()

	self._txtTime.text = GameUtil.getActTimeDesc(activityType, self._activityId)
end

function HolyWaterOrderChallengeView:_updateFmtHead()
	self:_clearHeadIcon()

	local cfgTarget
	local cfgStage = HolyWaterOrderConfig.instance:getStageCfg(self._activityId, self._curStage)

	if cfgStage then
		local cfgCreeps = HolyWaterOrderConfig.instance:getCreepsCfgList(cfgStage.creepsMasterId)

		for i, cfgEnemy in ipairs(cfgCreeps) do
			local item = self._fmtList[cfgEnemy.posId]

			if item and item.go then
				goutil.setActive(item.go, true)
				GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)
				MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, item.con)
			end

			if not cfgTarget then
				cfgTarget = cfgEnemy
			elseif cfgTarget.posId > cfgEnemy.posId then
				cfgTarget = cfgEnemy
			end
		end
	end

	if cfgTarget then
		self:_showRoleModel(cfgTarget.raceId)
	end
end

function HolyWaterOrderChallengeView:_clearHeadIcon()
	for i, v in ipairs(self._fmtList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.go, false)
	end
end

function HolyWaterOrderChallengeView:_showRoleModel(raceId)
	local curFaceId = raceId
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

function HolyWaterOrderChallengeView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function HolyWaterOrderChallengeView:_initCloseTime()
	self._startHour = 0
	self._endHour = 23

	local timeRange = self._cfgActivity.closeRange

	self._startHour, self._endHour = string.match(timeRange, "(%d+):%d+:%d+-(%d+):%d+:%d+")
	self._startHour = checknumber(self._startHour)
	self._endHour = checknumber(self._endHour)
end

return HolyWaterOrderChallengeView
