-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MainMenuHoldDlg.lua

local ModelTool = require("Entity/ModelTool")
local MainMenuHoldConfig = require("DesignerScript/MainMenuHoldConfig")
local CustomShadowManager = require("System/CustomShadowManager")
local strClassName = "MainMenuHoldDlg"
local MainMenuHoldDlg = Class(strClassName, UIControls.Window)

function MainMenuHoldDlg:ctor(...)
	self:initUI()
end

function MainMenuHoldDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "BgPanel/BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.modelViewport = UIControls.RawImage(self, "BgPanel/ModelPanel/ModelViewport")

	self.modelViewport:setVisible(false)

	self.modelStageReady = nil

	coroutine.start(Slot(self._coModelStageCreate, self))
end

function MainMenuHoldDlg:_coModelStageCreate()
	coroutine.step()

	local homeBg = UIManager.getUI("homeBg", nil, false)

	if homeBg then
		homeBg.stage:setLightHide(true)
	end

	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/CleanttModelStage01")
	self.modelControl = UIControls.Panel(self, "BgPanel/ModelPanel/ModelControl")

	self.modelStage:initOperationDefault(self.modelControl)

	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)
	self.modelStage.mEventOprDrag = Slot(self.onDrag, self)
	self.modelStage.mEventOprClick = Slot(self.onClick, self)
	self.modelStage.mEventOprPinch = Slot(self.onPinch, self)

	self.modelStage:connectImage(self.modelViewport)

	if self.delayLoadHero then
		self:_realSetHoldHero()

		self.delayLoadHero = nil
	end

	coroutine.step()
	self.modelViewport:setVisible(true)

	self.modelStageReady = true

	homeBg.stage:pauseRender()
end

function MainMenuHoldDlg:windowBeginnerReady()
	return self:getVisible() and not self:getHide() and not self.mOpening and self.modelStageReady
end

local HandModelData = {
	prefabPath = "Characters/Heros/NoviceStory/Avatars/Hand_home",
	animator = "Animators/Home/Home_Hero_LeftHandClean.controller"
}

function MainMenuHoldDlg:setHoldHero(hero)
	self.hero = hero

	if self.modelStage then
		self:_realSetHoldHero()
	else
		self.delayLoadHero = true
	end
end

function MainMenuHoldDlg:_realSetHoldHero()
	if not self.hero then
		return
	end

	self.loadedNum = 0

	local modelId = self.hero:getShowModelId()
	local baseModelId = self.hero:getShowBaseModelId()
	local modelType = Const.MODEL_TYPE.ShowMain
	local lodLv = Const.MODEL_LOD_LV1

	self.modelStage:showHeroByModId(modelId, modelType, nil, Slot(self._onHeroLoaded, self), lodLv, baseModelId)
	self:_addModel(HandModelData, Slot(self._onHandLoaded, self))
end

function MainMenuHoldDlg:_addModel(modelData, callBack)
	self.modelStage:showModelByModelData(modelData.prefabPath, modelData.animator, nil, nil, nil, nil, callBack)
end

function MainMenuHoldDlg:_onHeroLoaded(modelInstId)
	self.loadedNum = self.loadedNum + 1
	self.heroData = self:_getCommonData(modelInstId)

	self:checkAllLoad()
end

function MainMenuHoldDlg:_onHandLoaded(modelInstId)
	self.loadedNum = self.loadedNum + 1

	self.modelStage:jumpModel(modelInstId, nil, nil, nil, nil)

	self.handData = self:_getCommonData(modelInstId)

	self:checkAllLoad()
end

function MainMenuHoldDlg:checkAllLoad(...)
	if self.loadedNum < 2 then
		return
	end

	self.allLoadEnd = true

	self.modelControl:setVisible(true)

	local childTran = self.heroData.transform
	local parentTran = self.handData.transform

	childTran.parent = parentTran:Find("Bone_Base")
	childTran.localPosition = Vector3(0, 0.073, 0)
	childTran.localRotation = Quaternion.Euler(0, 0, 0)

	ModelTool.addBaseModel(self.heroData.instId, self.hero:getShowBaseModelId(), 1, Const.HERO_BASE_TYPE.Battle, function(...)
		self.handData.modelAux:SetAnimatorNoCulling()
		self.handData.go:SetActive(true)
		self.heroData.go:SetActive(true)
		CustomShadowManager.registerModelStageGameObject(self.handData.go, true)
		CustomShadowManager.registerModelStageGameObject(self.heroData.go, true)

		self.startShowTick = Time.time
	end)
end

function MainMenuHoldDlg:_getCommonData(modelInstId)
	local data = {}
	local modelAux = ModelTool.getModelAuxByInsId(modelInstId)

	if modelAux then
		data.modelAux = modelAux
		data.go = modelAux.gameObject

		data.go:SetActive(false)

		data.transform = modelAux.transform
	end

	data.instId = modelInstId

	return data
end

function MainMenuHoldDlg:onClose(...)
	local homeBg = UIManager.getUI("homeBg", nil, false)

	if homeBg then
		homeBg.stage:resumeRender()
		homeBg.stage:setLightHide(false)
		homeBg.stage:manualActiveShadow(true)
		homeBg:reshowHoldModel()
		homeBg:onRefresh()
	end

	MainMenuHoldDlg.super.onClose(self)
end

local STAGE_CAMERA_MOVE_DUR = 0.8
local DRAG_UP_LIMIT = 3
local DRAG_DOWN_LIMIT = -3
local DRAG_ANCHOR_DISTANCE = 0
local CAMERA_ZOOM_POS = {
	1.778198,
	-14.2106,
	4.693964
}
local DRAG_ROTATE_SPEED = 240
local DRAG_CAM_ROTATE_SPEED = 60
local HENTAI_ACTION_CD = 60
local SINGLE_CLICK_CD = 0.1
local HAND_UP_LONG = 3
local COMBO_DELAY_TIME = 0.2
local COMBO_TRIGGER_COUNT = 3
local COMBO_CD = 2

function MainMenuHoldDlg:onClick(...)
	if self.clickTick and Time.time - self.clickTick < SINGLE_CLICK_CD then
		return
	end

	self.clickTick = Time.time

	if not self.actTimer then
		self.actTimer = Timer.New(Slot(self._actTimerBeat, self), COMBO_DELAY_TIME)
	end

	local nowTime = Time.time

	if self.lastComboTime and nowTime - self.lastComboTime < COMBO_CD then
		return
	end

	if self:_judgeCombo(nowTime) then
		self:_interact("Click02")
		self.actTimer:Stop()
		self:checkBeginnerStep("PointPanel02")
	else
		self.actTimer:Restart()
	end
end

function MainMenuHoldDlg:_judgeCombo(nowTime)
	if not self.comboCount then
		self.comboCount = 0
	end

	if not self.lastClickTime then
		self.lastClickTime = nowTime
	end

	if nowTime - self.lastClickTime > COMBO_DELAY_TIME then
		self.comboCount = 1
	else
		self.comboCount = self.comboCount + 1
	end

	local comboThisTime = false

	if self.comboCount >= COMBO_TRIGGER_COUNT then
		comboThisTime = true
		self.comboCount = 0
	end

	self.lastClickTime = nowTime

	return comboThisTime
end

function MainMenuHoldDlg:_actTimerBeat()
	self:_interact("Click01")
	self:checkBeginnerStep("PointPanel01")
end

function MainMenuHoldDlg:_interact(animName)
	if self.heroData and self.heroData.modelAux then
		self.heroData.modelAux:PlayAnimator(animName)

		self.lastComboTime = Time.time
	end
end

local ZOOM_FOV_RANGE = MainMenuHoldConfig.CAM_DEFAULT_FOV - MainMenuHoldConfig.CAM_MAX_FOV

function MainMenuHoldDlg:onPinch(delta)
	local deltaX = delta.x

	if deltaX == 0 then
		return
	end

	local zoomIn = deltaX > 0

	if not self.zoomPercent then
		self.zoomPercent = 0
	end

	self.zoomPercent = math.min(1, math.max(0, self.zoomPercent + deltaX))

	self.modelStage:setCameraFov(MainMenuHoldConfig.CAM_DEFAULT_FOV - self.zoomPercent * ZOOM_FOV_RANGE)
	self:_rotateCamX()
	self:checkBeginnerStep("PinchPanel")
end

function MainMenuHoldDlg:checkBeginnerStep(path)
	local rookieMainDlg = UIManager.tryGetUI("rookieMainDlg")

	if rookieMainDlg and rookieMainDlg.extraChildPath == path then
		rookieMainDlg:onMaskClick()
	end
end

function MainMenuHoldDlg:_inZoomState()
	return self.zoomPercent ~= nil and self.zoomPercent > 0
end

function MainMenuHoldDlg:onDragStart(...)
	return
end

function MainMenuHoldDlg:onDragEnd(...)
	if self.dragDirection == "x" then
		self:checkBeginnerStep("SlideHPanel")
	elseif self.dragDirection == "y" then
		self:checkBeginnerStep("SlideVPanel")
	end

	self.dragDirection = nil
end

local CAM_ROTATE_MAX_RANGE = MainMenuHoldConfig.CAM_ROTATE_NEAR_MAX - MainMenuHoldConfig.CAM_ROTATE_FAR_MAX
local CAM_ROTATE_MIN_RANGE = MainMenuHoldConfig.CAM_ROTATE_NEAR_MIN - MainMenuHoldConfig.CAM_ROTATE_FAR_MIN

function MainMenuHoldDlg:onDrag(delta)
	if not self.startShowTick or Time.time - self.startShowTick < HAND_UP_LONG then
		return
	end

	local deltaX = math.abs(delta.x)
	local deltaY = math.abs(delta.y)

	if not self.dragDirection then
		if deltaX < deltaY then
			self.dragDirection = "y"
		else
			self.dragDirection = "x"
		end
	end

	if not self.heroData.transform then
		return
	end

	if self.dragDirection == "x" then
		local angles = self.heroData.transform.eulerAngles

		angles.y = angles.y - delta.x * DRAG_ROTATE_SPEED
		self.heroData.transform.eulerAngles = angles
	else
		if not self.camRotateX then
			self.camRotateX = 0
		end

		self.camRotateX = self.camRotateX + delta.y * MainMenuHoldConfig.CAM_ROTATE_SPEED

		self:_rotateCamX()
	end
end

function MainMenuHoldDlg:_rotateCamX(...)
	if not self.zoomPercent then
		self.zoomPercent = 0
	end

	if not self.camRotateX then
		self.camRotateX = 0
	end

	local maxRotate = MainMenuHoldConfig.CAM_ROTATE_FAR_MAX + self.zoomPercent * CAM_ROTATE_MAX_RANGE
	local minRotate = MainMenuHoldConfig.CAM_ROTATE_FAR_MIN + self.zoomPercent * CAM_ROTATE_MIN_RANGE

	self.camRotateX = math.min(maxRotate, math.max(minRotate, self.camRotateX))

	self.modelStage:moveRotateCameraSmooth({}, {
		self.camRotateX + MainMenuHoldConfig.CAM_DEFAULT_ROTATE[1],
		MainMenuHoldConfig.CAM_DEFAULT_ROTATE[2],
		MainMenuHoldConfig.CAM_DEFAULT_ROTATE[3]
	}, 0)
end

function MainMenuHoldDlg:_onClickClose(...)
	self:setVisible(false)
end

function MainMenuHoldDlg:beginnerTriggerActOnce()
	self:_interact("Click01")
end

function MainMenuHoldDlg:beginnerTriggerActMulti()
	self:_interact("Click02")
end

function MainMenuHoldDlg:clearActionCD()
	self.lastComboTime = nil
end

return MainMenuHoldDlg
