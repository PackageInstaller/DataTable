-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleMainDlg.lua

local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local ResClanBattleOrder = require("ClientData/ResClanBattleOrder")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local DragUtils = Framework.Drag.DragUtils
local UIUtils = require("Framework.UI.UIUtils")
local strClassName = "CircleBattleMainDlg"
local CircleBattleMainDlg = Class(strClassName, UIControls.Window)

MixinClass(CircleBattleMainDlg, ActivityPanelMixin)

local strSetFlagTitle = Lang.get(74323)
local strOriginalTitle

function CircleBattleMainDlg:ctor(...)
	self:_initUI()
end

function CircleBattleMainDlg:destroy()
	self:stopMarkGridTimer()

	CircleControlCenter.checkOpenMarkGridPanel = nil
	CircleControlCenter.onCameraNearAction = nil

	CircleBattleMainDlg.super.destroy(self)
end

function CircleBattleMainDlg:_initUI()
	self.btnZoom = UIControls.Button(self, "MainInfoPanel/SceneFuncPanel/BtnZoom")

	self.btnZoom:addEventClick(self.onBtnZoomClick)

	self.btnZoomNear = UIControls.Button(self, "ModeFarPanel/BtnZoom")

	self.btnZoomNear:addEventClick(self.onBtnZoomNearClick)

	self.btnChat = UIControls.Button(self, "MainInfoPanel/SceneFuncPanel/BtnChat")

	self.btnChat:addEventClick(self.onBtnChatClick)

	self.btnSetModel = UIControls.Button(self, "MainInfoPanel/SceneFuncPanel/BtnSetModel")

	self.btnSetModel:addEventClick(self.onBtnSetModelClick)

	self.btnTalent = UIControls.Button(self, "MainInfoPanel/SelfFuncPanel/BtnTalent")

	self.btnTalent:addEventClick(self.onBtnTalentClick)

	self.btnHero = UIControls.Button(self, "MainInfoPanel/SelfFuncPanel/BtnHero")

	self.btnHero:addEventClick(self.onBtnHeroClick)

	self.btnProgress = UIControls.Button(self, "MainInfoPanel/CirclFuncPanel/BtnProgress")

	self.btnProgress:addEventClick(self.onBtnProgressClick)

	self.btnRune = UIControls.Button(self, "MainInfoPanel/CirclFuncPanel/BtnRune")

	self.btnRune:addEventClick(self.onBtnRuneClick)

	self.btnCircleSkill = UIControls.Button(self, "MainInfoPanel/CirclFuncPanel/BtnCircleSkill")

	self.btnCircleSkill:addEventClick(self.onBtnCircleSkillClick)

	self.btnMore = UIControls.Button(self, "MainInfoPanel/CirclFuncPanel/BtnMore")

	self.btnMore:addEventClick(self.onBtnMoreClick)

	self.btnEditOrder = UIControls.Button(self, "MainInfoPanel/CirclFuncPanel/StratagePanel/BtnEdit")

	self.btnEditOrder:addEventClick(self.onBtnEditOrderClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtClose = UIControls.Label(self, "BtnClose/Text")
	strOriginalTitle = self.txtClose:getText()
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnHonor = UIControls.Button(self, "MainInfoPanel/CirclFuncPanel/BtnHonor")

	self.btnHonor:addEventClick(self.onBtnHonorClick)

	self.btnRankBoss = UIControls.Button(self, "MainInfoPanel/CirclFuncPanel/BtnRankBoss")

	self.btnRankBoss:addEventClick(self.onBtnRankBossClick)

	self.btnRankCircle = UIControls.Button(self, "MainInfoPanel/CirclFuncPanel/BtnRankCircle")

	self.btnRankCircle:addEventClick(self.onBtnRankCircleClick)

	self.btnPointAward = UIControls.Button(self, "MainInfoPanel/SelfFuncPanel/BtnPointAward")

	self.btnPointAward:addEventClick(self.onBtnPointAwardClick)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/SelfFuncPanel/BtnStore")

	self.btnStore:addEventClick(self.onBtnStoreClick)

	self.btnActionPoint = UIControls.Button(self, "MainInfoPanel/BtnCircleAction", "Text")

	self.btnActionPoint:addEventClick(self.onBtnActionPointClick)

	self.panelUIAni = UIControls.UIAni(self, "MainInfoPanel/CirclFuncPanel")
	self.imgScore = UIControls.Image(self, "MainInfoPanel/SelfFuncPanel/BtnPointAward/PointPanel/Icon")
	self.txtScore = UIControls.Label(self, "MainInfoPanel/SelfFuncPanel/BtnPointAward/PointPanel/TextNum")
	self.pointAwardRD = UIControls.RedDot(self, "MainInfoPanel/SelfFuncPanel/BtnPointAward/IconNew")

	self.pointAwardRD:addHint({
		UIConst.RD_HINT_CIRCLE_BATTLE_POINT_ACHIEVE
	})

	self.imgTalentNew = UIControls.Image(self, "MainInfoPanel/SelfFuncPanel/BtnTalent/IconNew")
	self.imgHeroNew = UIControls.Image(self, "MainInfoPanel/SelfFuncPanel/BtnHero/IconNew")
	self.txtCurLayer = UIControls.Label(self, "MainInfoPanel/CirclFuncPanel/BtnProgress/TextNum")
	self.sliderCurLayerProgress = UIControls.Slider(self, "MainInfoPanel/CirclFuncPanel/BtnProgress/Slider")
	self.txtCurLayerProgress = UIControls.Label(self, "MainInfoPanel/CirclFuncPanel/BtnProgress/Slider/TextNum")
	self.imgIconOrder = UIControls.Image(self, "MainInfoPanel/CirclFuncPanel/StratagePanel/OrderPanel/IconOrder")
	self.txtOrder = UIControls.Label(self, "MainInfoPanel/CirclFuncPanel/StratagePanel/OrderPanel/TextOrder")
	self.txtGoal = UIControls.Label(self, "MainInfoPanel/CirclFuncPanel/StratagePanel/GoalPanel/TextGoal")
	self.btnMoreFuncPanel = UIControls.Button(self, "MainInfoPanel/MoreFuncPanel")

	self.btnMoreFuncPanel:addEventClick(self.onBtnMoreFuncPanelClick)

	self.txtTime = UIControls.Label(self, "MainInfoPanel/CirclFuncPanel/StratagePanel/TextTime")
	self.anilLuck = UIControls.UIAni(self, "LuckyPanel")

	self.anilLuck:addEventFinish(self.onLuckAniFinish)

	self.txtLuckNum = UIControls.Label(self, "LuckyPanel/TextNum")
	self.panelBossLocation = UIControls.Panel(self, "BossLocationPanel")
	self.panelLocation = UIControls.Panel(self, "BossLocationPanel/LocationPanel")

	self.panelLocation:setVisible(false)

	self.panelArrow = UIControls.Panel(self, "BossLocationPanel/LocationPanel/IconArrow")
	self.panelSelf = UIControls.Panel(self, "")
	self.panelBlock = UIControls.Panel(self, "FullRaycast")
	self.aniSlider = UIControls.UIAni(self, "MainInfoPanel/CirclFuncPanel/BtnProgress/Slider")
	self.panelBg = UIControls.DragClickPanel(self, "DragBg")

	self.panelBg:setDragFunc(Slot(self.onDragFunc, self))
	self.panelBg:setClickFunc(Slot(self.onClickFunc, self))
	self.panelBg:setPinchFunc(Slot(self.onPinchFunc, self))
	self.panelBg:setDragEndFunc(Slot(self.onDragEndFunc, self))
	self.panelBg:setTouchEndFunc(Slot(self.onTouchEndFunc, self))
	self.btnStore:setVisible(false)

	self.btnMarkGrid = UIControls.Button(self, "MainInfoPanel/SceneFuncPanel/BtnSetFlag")

	self.btnMarkGrid:addEventClick(self.onClickBtnMarkGrid)

	self.btnCancelMarkGrid = UIControls.Button(self, "SetFlagPanel/BgPanel/FuncPanel/BtnCancel")

	self.btnCancelMarkGrid:addEventClick(self.onClickCancelMarkGrid)

	self.btnSaveMarkGrid = UIControls.Button(self, "SetFlagPanel/BgPanel/FuncPanel/BtnSave")

	self.btnSaveMarkGrid:addEventClick(self.onClickSaveMarkGrid)

	self.txtMarkGridDes = UIControls.Label(self, "SetFlagPanel/BgPanel/SetPanel/TextDec")
	self.tipId = Const.INFO_NOTICE_CIRCLE_BATTLE_MAIN
end

function CircleBattleMainDlg:onOpen(...)
	CircleBattleMainDlg.super.onOpen(self)

	if not GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		GameFsm.translateState(Const.STATE_MAIN_CIRCLE)
	end

	self:checkZoomState()
	self:initCircleMainBattleShow()

	if not CurAvatar.myCircle then
		self:showDlg(false)

		return
	end

	self:refreshCirleBattleInfo()
	CircleControlCenter.checkEvent()
end

function CircleBattleMainDlg:initCircleMainBattleShow()
	local pointIconPath = UIConst.CIRCLE_BATTLE_SCORE_PATH

	if pointIconPath then
		self.imgScore:setImage(pointIconPath[1], pointIconPath[2])
	end

	self:refreshTime()

	local permission = CurAvatar:getMyDutyPermission()

	self.btnEditOrder:setVisible(permission.battle_set_target == 1)
end

function CircleBattleMainDlg:refreshCirleBattleInfo()
	if CurAvatar.myCircle then
		local circle = CurAvatar.myCircle
		local battleData = circle:getBattleData()

		if battleData then
			self.txtCurLayer:setText(CircleControlCenter.getShowLayer())

			if ResClanBattleOrder[battleData.order] then
				local orderResData = ResClanBattleOrder[battleData.order]

				self.txtOrder:setText(orderResData.name)

				if orderResData.icon_path and orderResData.icon then
					self.imgIconOrder:setImage(orderResData.icon_path, orderResData.icon)
				end
			end

			local achieveData = circle:getCircleAchieveData(battleData.target)

			achieveData = CurAvatar:analyCircleAchieveData(achieveData.resData.action_type, achieveData.progress)

			if achieveData then
				self.txtGoal:setText(achieveData.resData.desc)
			end

			local curScoreGearData = circle:getCurScoreGearData()

			self.txtScore:setText(curScoreGearData.score .. "/" .. curScoreGearData.resData.score)

			local conditionDataList = circle:getLayerProConditionDataList()
			local totalProgress = CurAvatar:calTotalConditionProgress(conditionDataList)

			self.sliderCurLayerProgress:setValue(totalProgress / 100)
			self.txtCurLayerProgress:setText(math.floor(totalProgress))

			local actionLimit = ResClanBattleMisc[1].action_point[1].times_limit

			self.btnActionPoint:setText(circle:getActionPoint() .. "/" .. actionLimit)
			self.imgTalentNew:setVisible(CurAvatar:isHintTalent())
			self.imgHeroNew:setVisible(CurAvatar:isHintCircleBattleHeroRelicWear())
		end
	end

	self:refreshBtnMarkGrid()
end

function CircleBattleMainDlg:refreshTime(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local leftTime = 0
	local actObj = CurAvatar:getCircleBattleActivity()

	if actObj then
		leftTime = actObj.actData:getLeftTimeToFreeze()

		if leftTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48657), nil, nil)
		else
			leftTime = actObj.actData:getLeftTimeToEnd()

			if leftTime > 0 then
				ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48654), nil, nil)
			else
				self.txtTime:setText(Lang.get(30121))
			end
		end
	end
end

function CircleBattleMainDlg:showLuckAni(num)
	self.txtLuckNum:setText("*" .. num)
	self.anilLuck:setVisible(true)
	self.anilLuck:startAni("ShowLuckyNum")
end

function CircleBattleMainDlg:onLuckAniFinish(...)
	self.anilLuck:setVisible(false)
end

function CircleBattleMainDlg:checkShowBossPos(isShow, bossUIPos)
	if not isShow then
		self.panelLocation:setVisible(false)
	else
		if not self.bossPosRange then
			self.panelLocation:setPosition(0, 0)

			local luPos = self.panelLocation:getAbsPosition()
			local rect = self.panelBossLocation:getComObj().transform

			if rect then
				local w = UIUtils.GetCurDesignWidth() * (1 - 2 * rect.anchorMin.x) + rect.sizeDelta.x
				local h = -(UIUtils.GetCurDesignHeight() + rect.sizeDelta.y)

				self.panelLocation:setPosition(w, h)
			end

			local rdPos = self.panelLocation:getAbsPosition()

			self.bossPosRange = Vector4(luPos.x, rdPos.x, rdPos.y, luPos.y)
		end

		if self.bossPosRange.x < bossUIPos.x and self.bossPosRange.y > bossUIPos.x and self.bossPosRange.z < bossUIPos.y and self.bossPosRange.w > bossUIPos.y then
			self.panelLocation:setVisible(false)
		else
			self.panelLocation:setVisible(true)

			local x = math.min(self.bossPosRange.y, math.max(self.bossPosRange.x, bossUIPos.x))
			local y = math.min(self.bossPosRange.w, math.max(self.bossPosRange.z, bossUIPos.y))

			self.panelLocation:setAbsPosition(x, y)

			local checkVec = Vector3(x - bossUIPos.x, y - bossUIPos.y, 0)
			local angle = Vector3.Angle(Vector3.up, checkVec)
			local vec = Vector3.Cross(Vector3.up, checkVec)
			local a = vec.z > 0 and angle or -angle

			self.panelArrow:setRotate(a)
		end
	end
end

function CircleBattleMainDlg:enableOpration(v)
	self.panelBlock:setVisible(not v)
end

function CircleBattleMainDlg:showDlg(v)
	if v then
		self.panelSelf:setCanvasGroupAlpha(1)
		self:enableOpration(true)
	else
		self.panelSelf:setCanvasGroupAlpha(0)
		self:enableOpration(false)
	end
end

function CircleBattleMainDlg:showProcessAni(v)
	if v then
		self.aniSlider:startAni("ChangeMainProgress")
	end
end

function CircleBattleMainDlg:checkZoomState(...)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state and state:isFarMode() then
		self:playAni("ChangeModeToFar", nil, true)
	end
end

function CircleBattleMainDlg:onBtnStoreClick(...)
	UIManager.createAndFunc("mallDlg", "showShop", Const.JUMPSHOPTYPE_CIRCLESHOP)
end

function CircleBattleMainDlg:onCameraShowStart(...)
	self.panelBossLocation:setVisible(false)
end

function CircleBattleMainDlg:onCameraShowEnd(...)
	self.panelBossLocation:setVisible(true)
end

function CircleBattleMainDlg:getScoreUI(...)
	return self.imgScore
end

function CircleBattleMainDlg:getProficientUI(...)
	return self.btnTalent
end

function CircleBattleMainDlg:getProcessUI(...)
	return self.sliderCurLayerProgress
end

function CircleBattleMainDlg:onDoubleMoveFunc(delta)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:onDoubleMove(delta)
	end
end

function CircleBattleMainDlg:onTouchEndFunc(...)
	if Const.CIRCLE_BATTLE_DEBUG_MODE then
		-- block empty
	end

	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:onTouchEnd()
	end
end

function CircleBattleMainDlg:onRotateFunc(delta)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:onRotateAround(delta)
	end
end

function CircleBattleMainDlg:onDragFunc(delta)
	if Const.CIRCLE_BATTLE_DEBUG_MODE then
		-- block empty
	end

	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:onDrag(delta)
	end
end

function CircleBattleMainDlg:onPinchFunc(delta)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:onPinch(delta)
	end
end

function CircleBattleMainDlg:onDragEndFunc(delta)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:onDragEnd(delta)
	end
end

function CircleBattleMainDlg:onClickFunc(...)
	if Const.CIRCLE_BATTLE_DEBUG_MODE then
		-- block empty
	end

	local indexStr = DragUtils.GetHitSimpleStringData(-1)

	if indexStr and indexStr ~= "" then
		local index = tonumber(indexStr)

		if index then
			CircleControlCenter.onClickGridByIndex(index)

			return
		end
	end

	local pos = DragUtils.GetHitPos(Const.LAYER_DRAG_FIELD)

	if pos.x < -999 and pos.y < -999 and pos.z < -999 and (not Const.CIRCLE_BATTLE_DEBUG_MODE or true) then
		-- block empty
	else
		CircleControlCenter.onClickGrid(pos)
	end
end

function CircleBattleMainDlg:onBtnZoomClick()
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state and state:isOprateEnable() then
		self:playAni("ChangeModeToFar", nil, true)
		state:changeToFarMode()
	end
end

function CircleBattleMainDlg:onBtnZoomNearClick(...)
	CircleControlCenter.onCameraNearAction = Slot(self.onCameraNearAction, self)

	self.btnMarkGrid:setEnable(false)
	self:playAni("ChangeModeToClose", nil, true)

	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:changeToNearMode()
	end
end

function CircleBattleMainDlg:onCameraNearAction()
	self.btnMarkGrid:setEnable(true)
end

function CircleBattleMainDlg:onBtnChatClick(...)
	UIManager.getUI("chatDlg", true):openChannelOnly(Const.CHANNEL_GUILD)
end

function CircleBattleMainDlg:onBtnEditOrderClick()
	local permission = CurAvatar:getMyDutyPermission()

	if not permission.battle_set_target then
		MsgManager.notice(Lang.get(37086))

		return
	end

	local circleBattleStratageDlg = UIManager.getUI("circleBattleStratageDlg", true)
end

function CircleBattleMainDlg:onBtnSetModelClick()
	UIManager.getUI("circleBattleChangeModelDlg", true)
end

function CircleBattleMainDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(self.tipId)
end

function CircleBattleMainDlg:onBtnActionPointClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_CIRCLE_BATTLE_ACTION_POINT)
end

function CircleBattleMainDlg:onBtnTalentClick()
	local circleBattleTalentDlg = UIManager.getUI("circleBattleTalentDlg", true)
end

function CircleBattleMainDlg:onBtnHeroClick()
	local circleBattleHeroListDlg = UIManager.getUI("circleBattleHeroListDlg", true)
end

function CircleBattleMainDlg:onBtnProgressClick()
	local circleBattleProgressDlg = UIManager.getUI("circleBattleProgressDlg", true)
end

function CircleBattleMainDlg:onBtnRuneClick()
	local circleBattleRuneDlg = UIManager.getUI("circleBattleRuneDlg", true)
end

function CircleBattleMainDlg:onBtnHonorClick()
	if CurAvatar.myCircle then
		local circleBattleHonorDlg = UIManager.getUI("circleBattleHonorDlg", true)

		circleBattleHonorDlg:setHonorInfoData(CurAvatar.myCircle:getHonorInfoDataList())
	end
end

function CircleBattleMainDlg:onBtnRankBossClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_CIRCLE_BATTLE_FEAT)
end

function CircleBattleMainDlg:onBtnPointAwardClick()
	local circleBattlePointAwardDlg = UIManager.getUI("circleBattlePointAwardDlg", true)
end

function CircleBattleMainDlg:onBtnRankCircleClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_CIRCLE_BATTLE_LAYER)
end

function CircleBattleMainDlg:onBtnCircleSkillClick()
	local circleBattleCircleSkillDlg = UIManager.getUI("circleBattleCircleSkillDlg", true)
end

function CircleBattleMainDlg:onBtnCircleActionClick(...)
	MsgManager.notice(Lang.get(39267))
end

function CircleBattleMainDlg:onBtnMoreClick()
	if not self.isOpenPanel then
		self.panelUIAni:startAni("OpenMoreFunc", true)

		self.isOpenPanel = true
	else
		self.panelUIAni:startAni("CloseMoreFunc", true)

		self.isOpenPanel = false
	end
end

function CircleBattleMainDlg:onBtnMoreFuncPanelClick()
	self.btnMoreFuncPanel:setVisible(false)
end

function CircleBattleMainDlg:onBtnCloseClick()
	local ui = UIManager.tryGetUI("mallDlg")

	if ui then
		ui:setVisible(false)
	end

	self:setVisible(false)
	GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()

	if CurAvatar.myCircle then
		local member = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)

		if member then
			local layer = CurAvatar.myCircle:getCurBattleLayer()

			if member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.FORMATION then
				CurAvatar:tryCallCircleBattleRpc("clanBattleCancelMonster", layer, member.battle_data.oppos)
			elseif member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.SEARCH then
				CurAvatar:tryCallCircleBattleRpc("clanBattleCancelGrid", layer, member.battle_data.oppos)
			end
		end
	end
end

function CircleBattleMainDlg:onMarkGridDataChange()
	self:refreshBtnMarkGrid()
	self:refreshMarkGridPanel()
end

function CircleBattleMainDlg:refreshBtnMarkGrid()
	local checkCanMarkGrid = CurAvatar:getTotalMarkGridTimes() > 0

	self.btnMarkGrid:setVisible(checkCanMarkGrid)
end

function CircleBattleMainDlg:refreshMarkGridPanel()
	if not self.markGridTimer then
		self:refreshDes()
	end
end

function CircleBattleMainDlg:refreshDes()
	local left = CurAvatar.myCircle and CurAvatar.myCircle:getLeftMarkGridTimes() or 0

	self.txtMarkGridDes:setText(string.format(Lang.get(74324), left))
end

function CircleBattleMainDlg:markGridTimerAction()
	if self.cd and self.cd > 0 then
		self.cd = self.cd - 1

		self.txtMarkGridDes:setText(string.format(Lang.get(74325), utils.calcTimeTxt(self.cd)))
	else
		self:stopMarkGridTimer()
		self:refreshDes()
	end
end

function CircleBattleMainDlg:stopMarkGridTimer()
	if self.markGridTimer then
		self.markGridTimer:Stop()

		self.markGridTimer = nil
	end
end

function CircleBattleMainDlg:onClickBtnMarkGrid()
	local checkCanMarkGrid = CurAvatar:getTotalMarkGridTimes() > 0

	if not checkCanMarkGrid then
		self.btnMarkGrid:setVisible(false)

		return
	end

	self:playAni("OpenSetFlagPanel", nil, true)
	self.btnClose:clearEventClick()
	self.btnClose:addEventClick(self.onClickCancelMarkGrid)
	self.txtClose:setText(strSetFlagTitle)

	self.tipId = Const.INFO_NOTICE_CIRCLE_MARK_GRID

	CircleControlCenter.onOpenMarkGridPanel()

	self.cd = CurAvatar.myCircle:getMarkGridCd()

	if self.cd > 0 then
		self.txtMarkGridDes:setText(string.format(Lang.get(74325), utils.calcTimeTxt(self.cd)))

		self.markGridTimer = Timer.New(Slot(self.markGridTimerAction, self), 1, -1)

		self.markGridTimer:Start()
	else
		self:refreshDes()
	end
end

function CircleBattleMainDlg:onClickCancelMarkGrid()
	self:playAni("CloseSetFlagPanel", nil, true)
	self.btnClose:clearEventClick()
	self.btnClose:addEventClick(self.onBtnCloseClick)
	self.txtClose:setText(strOriginalTitle)

	self.tipId = Const.INFO_NOTICE_CIRCLE_BATTLE_MAIN

	self:stopMarkGridTimer()
	CircleControlCenter.onCloseMarkGridPanel()
end

function CircleBattleMainDlg:onClickSaveMarkGrid()
	if not CurAvatar.myCircle then
		self:onClickCancelMarkGrid()

		return
	end

	local res = CurAvatar.myCircle:getMarkGridResult()

	if self.markGridTimer and res.mark > 0 then
		MsgManager.notice(Lang.get(74326))
	else
		self:playAni("CloseSetFlagPanel", nil, true)
		self.btnClose:clearEventClick()
		self.btnClose:addEventClick(self.onBtnCloseClick)
		self.txtClose:setText(strOriginalTitle)

		self.TipId = Const.INFO_NOTICE_CIRCLE_BATTLE_MAIN

		self:stopMarkGridTimer()
		CircleControlCenter.onSaveMarkGridPanel()
	end
end

function CircleBattleMainDlg:checkMarkGidResultChange()
	if CurAvatar.myCircle then
		local res = CurAvatar.myCircle:getMarkGridResult()

		return res.unmark > 0 or res.mark > 0
	end

	return false
end

return CircleBattleMainDlg
