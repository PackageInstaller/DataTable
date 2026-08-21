-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseCleanDlg.lua

local ModelTool = require("Entity/ModelTool")
local ModelFactory = Framework.Entity.ModelFactory
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local CustomShadowManager = require("System/CustomShadowManager")
local strClassName = "RearHouseCleanDlg"
local RearHouseCleanDlg = Class(strClassName, UIControls.Window)
local DUST_MAT_PATH = "Drag/RearHouse/RearHouse_Dust.mat"
local TOTAL_DRAG = 5
local FINGER_PATH = "Effects/UI/efx_Ui_AvgFingeRoll.prefab"
local HAND_MODEL_ID = 40008
local REMIND_INTERVAL = 2
local CLEAN_STATE = {
	PAUSE = "PAUSE",
	ENTER = "ENTER",
	FINISH = "LEAVE",
	MOVE = "MOVE"
}
local HAND_ANI = {
	IDLE = "LeftHand_idle",
	ENTER = "LeftHand_enter"
}
local PEN_ANI = {
	ENTER = {
		crossTime = 0,
		offset = 0,
		ani = "Pen_enter"
	},
	MOVE = {
		crossTime = 0.4,
		offset = 0.7,
		ani = "Pen_move"
	},
	PAUSE = {
		crossTime = 0.4,
		offset = 0,
		ani = "Pen_pause"
	},
	LEAVE = {
		crossTime = 0.4,
		offset = 0,
		ani = "Pen_leave"
	}
}
local OPRATION = {
	UP = 2,
	DOWN = 1,
	DRAG = 3
}
local handModelData = {
	prefabPath = "Characters/Heros/NoviceStory/Avatars/Hand_home",
	animator = "Animators/Home/Home_Hero_LeftHandClean.controller"
}
local penModelData = {
	prefabPath = "Characters/Heros/NoviceStory/Avatars/Pen",
	animator = "Animators/Home/Home_Hero_PenClean.controller"
}

function RearHouseCleanDlg:ctor(...)
	self:initUI()
end

function RearHouseCleanDlg:initUI(...)
	self.modelViewport = UIControls.RawImage(self, "BgPanel/ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/CleanModelStage")
	self.optModelControl = UIControls.Panel(self, "BgPanel/OperatingPanel/ModelControl")

	self.modelStage:initOperationDefault(self.optModelControl)

	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)
	self.modelStage.mEventOprDrag = Slot(self.onDrag, self)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTip = UIControls.Button(self, "BgPanel/BtnTips")

	self.btnTip:addEventClick(self.onBtnTipClick)

	self.optPanel = UIControls.Panel(self, "BgPanel/OperatingPanel")
	self.optSliderBg = UIControls.Panel(self, "BgPanel/OperatingPanel/BgSlider")
	self.optSliderEndEfx = UIControls.Panel(self, "BgPanel/OperatingPanel/EfxHeartDis")
	self.optSlider = UIControls.RateEffectPlayer(self, "BgPanel/OperatingPanel/BallBlue")
	self.optEfxPanel = UIControls.LazyEffectPlayer(self, "BgPanel/OperatingPanel/Efx")

	self.modelStage:connectImage(self.modelViewport)
	self.optSlider:setVisible(false)
	self.optSliderBg:setVisible(false)

	self.dragRate = 0
	self.isCleanFinish = false
	self.cleanState = nil
	self.penEnterFinish = false
	self.allLoadEnd = false

	self:startRemindCheck()
	self.optModelControl:setVisible(false)
end

function RearHouseCleanDlg:setData(hero)
	self.hero = hero
	self.needClean = self:_isNeedClean()

	self:initHero()
end

function RearHouseCleanDlg:_isNeedClean(...)
	ClientUtils.record.cleanRecord = ClientUtils.record.cleanRecord or {}

	if ClientUtils.record.cleanRecord[self.hero.gid] == true then
		return false
	end

	if RearHouseCommon.isMaxCleanToday() == true then
		return false
	end

	return true
end

function RearHouseCleanDlg:coRemindFinger(...)
	while true do
		coroutine.wait(0.5)

		if os.time() - self.stopTime >= REMIND_INTERVAL and self.allLoadEnd == true then
			self:fingerRemind(true)

			break
		end
	end
end

function RearHouseCleanDlg:startRemindCheck(...)
	if self.needClean == false then
		return
	end

	self.stopTime = os.time()
	self.coRemind = coroutine.start(self.coRemindFinger, self)
end

function RearHouseCleanDlg:endRemindCheck(...)
	if self.coRemind then
		coroutine.stop(self.coRemind)
		self:fingerRemind(false)

		self.coRemind = nil
	end
end

function RearHouseCleanDlg:checkFirstIn(...)
	self.optSliderBg:setVisible(true)
	self.optSlider:setVisible(true)
	self.optSlider:setRate(0, 0)
end

function RearHouseCleanDlg:initHero(...)
	self.loadedNum = 0

	local modelId = self.hero:getShowModelId()
	local baseModelId = self.hero:getShowBaseModelId()
	local modelType = Const.MODEL_TYPE.RearHouse
	local lodLv = Const.MODEL_LOD_LV1

	self.modelStage:showHeroByModId(modelId, modelType, nil, Slot(self._onHeroLoaded, self), lodLv, baseModelId)
	self:_addModel(penModelData, Slot(self._onPenLoaded, self))
	self:_addModel(handModelData, Slot(self._onHandLoaded, self))
end

function RearHouseCleanDlg:_addModel(modelData, callBack)
	self.modelStage:showModelByModelData(modelData.prefabPath, modelData.animator, nil, nil, nil, nil, callBack)
end

function RearHouseCleanDlg:_getCommonData(modelInstId)
	local data = {}
	local modelAux = ModelFactory.GetModelAux(modelInstId)

	data.modelAux = modelAux
	data.go = modelAux.gameObject
	data.instId = modelInstId

	data.go:SetActive(false)

	return data
end

function RearHouseCleanDlg:_onHeroLoaded(modelInstId)
	self.loadedNum = self.loadedNum + 1

	if self.needClean == true then
		self.addMaterialCom = ModelFactory.AddMaterialComponent(modelInstId)

		if self.addMaterialCom then
			self.addMaterialCom:AddMaterial(DUST_MAT_PATH)
			self:setProgress(0)
		end
	end

	self.heroData = self:_getCommonData(modelInstId)

	self:checkAllLoad()
end

function RearHouseCleanDlg:_onHandLoaded(modelInstId)
	self.loadedNum = self.loadedNum + 1

	self.modelStage:jumpModel(modelInstId, nil, nil, nil, nil)

	self.handData = self:_getCommonData(modelInstId)

	self:checkAllLoad()
end

function RearHouseCleanDlg:_onPenLoaded(modelInstId)
	self.loadedNum = self.loadedNum + 1

	self.modelStage:jumpModel(modelInstId, nil, nil, nil, nil)

	self.PenData = self:_getCommonData(modelInstId)

	self:checkAllLoad()
end

function RearHouseCleanDlg:checkAllLoad(...)
	if self.loadedNum < 3 then
		return
	end

	self.allLoadEnd = true

	self.optModelControl:setVisible(true)

	local childTran = self.heroData.go.transform
	local parentTran = self.handData.go.transform
	local penTran = self.PenData.go.transform

	childTran.parent = parentTran:Find("Bone_Base")
	childTran.localPosition = Vector3(0, 0.073, 0)
	childTran.localRotation = Quaternion.Euler(0, 0, 0)

	ModelTool.addBaseModel(self.heroData.instId, self.hero:getShowBaseModelId(), 1, Const.HERO_BASE_TYPE.Battle, function(...)
		self.handData.modelAux:SetAnimatorNoCulling()
		self.handData.go:SetActive(true)
		self.heroData.go:SetActive(true)

		penTran.localPosition = penTran.localPosition + Vector3(0, 0, 0.4)

		CustomShadowManager.registerModelStageGameObject(self.handData.go, true)
		CustomShadowManager.registerModelStageGameObject(self.heroData.go, true)
	end)
end

function RearHouseCleanDlg:setProgress(rate)
	self.optSlider:setRate(rate, 0)

	if self.addMaterialCom then
		self.addMaterialCom:SetFloat("_AlphaRange", 1 - math.min(1, rate))
	end
end

function RearHouseCleanDlg:fingerRemind(isOn)
	if self.needClean == true then
		self:_switchNoticeEfx(isOn, {
			0,
			58
		})
	end
end

function RearHouseCleanDlg:_switchNoticeEfx(turnOn, noticeEfxPos)
	if turnOn then
		self.optEfxPanel:setVisible(true)
		self.optEfxPanel:playEffectByPath(FINGER_PATH)

		noticeEfxPos = noticeEfxPos or {
			0,
			0
		}

		self.optEfxPanel:setPosition(noticeEfxPos[1], noticeEfxPos[2])
	else
		self.optEfxPanel:setVisible(false)
	end
end

function RearHouseCleanDlg:changeOpration(opration)
	if self.cleanState == CLEAN_STATE.FINISH then
		return
	end

	if opration == OPRATION.DOWN then
		if self.cleanState == nil then
			self:checkFirstIn()
			self:changePenState(CLEAN_STATE.ENTER)

			local enterAniTime = 0.6

			self.enterTimer = Timer.New(function(...)
				self.penEnterFinish = true
			end, enterAniTime, 1)
		elseif self.cleanState == CLEAN_STATE.PAUSE then
			self:changePenState(CLEAN_STATE.MOVE)
		end
	elseif opration == OPRATION.UP then
		self:changePenState(CLEAN_STATE.PAUSE)
	elseif self.cleanState ~= CLEAN_STATE.MOVE then
		self:changePenState(CLEAN_STATE.MOVE)
	end
end

function RearHouseCleanDlg:changePenState(state)
	if self.cleanState == CLEAN_STATE.FINISH then
		return
	end

	self.cleanState = state

	if self.cleanState == CLEAN_STATE.ENTER then
		self.PenData.go:SetActive(true)
		CustomShadowManager.registerModelStageGameObject(self.PenData.go, true)
	end

	local info = PEN_ANI[self.cleanState]

	self.PenData.modelAux:PlayAnimatorByDuration(info.ani, info.crossTime, info.offset)
end

function RearHouseCleanDlg:onDrag(delta)
	if self.isCleanFinish == true then
		return
	end

	self:changeOpration(OPRATION.DRAG)

	self.dragRate = math.abs(delta.x) + math.abs(delta.y) + self.dragRate

	self:setProgress(self.dragRate / TOTAL_DRAG)

	if self.dragRate >= TOTAL_DRAG then
		self:onCleanFinish()
	end
end

function RearHouseCleanDlg:onCleanFinish(...)
	self.isCleanFinish = true

	self.optSliderEndEfx:setVisible(true)
	self.optSlider:setVisible(false)
	self.optSliderBg:setVisible(false)
	self:changePenState(CLEAN_STATE.FINISH)

	if RearHouseCommon.isMaxCleanToday() == false then
		self.timer = Timer.New(function(...)
			UIManager.getUI("rearHouseCleanAwardDlg", true):setData(self.hero)
		end, 1, 1)

		self.timer:Start()
	else
		CueManager.playHeroVocal(self.hero.id, Const.HERO_VOCAL_CLEAN)
	end
end

function RearHouseCleanDlg:onDragEnd(...)
	if self.isCleanFinish == false then
		self:startRemindCheck()
		self:changeOpration(OPRATION.UP)
	end
end

function RearHouseCleanDlg:onDragStart(...)
	self:endRemindCheck()
	self:changeOpration(OPRATION.DOWN)
end

function RearHouseCleanDlg:onBtnTipClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_CLEAN)
end

function RearHouseCleanDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function RearHouseCleanDlg:destroy(...)
	RearHouseCleanDlg.super.destroy(self)
	self:endRemindCheck()

	self.addMaterialCom = nil

	if self.enterTimer ~= nil then
		self.enterTimer:Stop()

		self.enterTimer = nil
	end

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	if state then
		state:setRearHouseShadow()
	end
end

return RearHouseCleanDlg
