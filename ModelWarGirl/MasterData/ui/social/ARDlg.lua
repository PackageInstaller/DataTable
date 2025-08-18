-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Social\\ARDlg.lua

local ARUtils = Framework.AR.ARUtils
local ModelTool = require("Entity/ModelTool")
local Model = require("Entity/Model")
local DeviceHelper = require("Helper/DeviceHelper")
local ModelFactory = Framework.Entity.ModelFactory
local LoadUtils = require("Entity/LoadUtils")
local LoaderUtils = Framework.Tools.LoaderUtils
local ResArConfig = require("ClientData/ResArConfig")
local ARAnimBtn = require("UI/Social/ARAnimBtn")
local GameSettings = require("Helper/GameSettings")
local ResCommonModel = require("ClientData/ResCommonModel")
local PerformManager = require("Logic/perform/PerformManager")
local ResClientNotice = require("ClientData/ResClientNotice")
local SubpackageHelper = require("Helper/SubpackageHelper")
local LoaderMode = Framework.Resource.LoaderMode
local VEC3_SCALE = Vector3(1, 1, 1)
local VEC3_ZERO = Vector3(0, 0, 0)
local VEC3_ROT = Vector3(0, 180, 0)
local SHOW_MODEL_NORMAL = 1
local SHOW_MODEL_WITH_BASE = 2
local SHOW_MODEL_HIGH = 3
local SHOW_MODEL_MID = 4
local MULTI_SHOW_POS = {
	{
		0.4,
		0.25
	},
	{
		0.2,
		0.3
	},
	{
		0.6,
		0.3
	}
}
local MULTI_MAX_NUM = 3
local ACT_MODE_STATIC = 1
local ACT_MODE_DANCE = 2
local POSE_MAX_NUM = 6
local DANCE_MAX_NUM = 5
local DANCE_AR_LIST = {
	7,
	8,
	9
}
local HIGH_QUALITY_SHOW_ACT = 1
local BONE_SHOW_ACT = 6
local CAMERA_NEAR_CLIP = 0.05
local HIDE_REASON_TOO_CLOSE = ResClientNotice[317] and ResClientNotice[317].notice
local HIDE_REASON_TOO_LOW = ResClientNotice[318] and ResClientNotice[318].notice
local ARHeroHeadCell = Class("ARHeroHeadCell", UIControls.GridHeroInfoLoop)

function ARHeroHeadCell:ctor()
	self.panelOther = UIControls.Panel(self, "OtherInfo")

	self.panelOther:setVisible(false)

	self.imgSelect = UIControls.Panel(self, "ImgSel")
	self.imgSelectMulti = UIControls.Panel(self, "ImgSelMulti")
end

function ARHeroHeadCell:onBtnHeroHeadClick()
	self.mParent:onClickHero(self)
end

function ARHeroHeadCell:setSelected(selected, multiMode)
	if selected then
		if multiMode then
			self.imgSelectMulti:setVisible(true)
			self.imgSelect:setVisible(false)
		else
			self.imgSelectMulti:setVisible(false)
			self.imgSelect:setVisible(true)
		end
	else
		self.imgSelectMulti:setVisible(false)
		self.imgSelect:setVisible(false)
	end
end

local strClassName = "ARDlg"
local ARDlg = Class(strClassName, UIControls.Window)

function ARDlg:ctor()
	self:initGameAR()
	self:initUI()
	MsgManager.showMsgOnScreen(false)
end

local function _sortHeroData(a, b)
	local aHero = a[1]
	local bHero = b[1]

	for _, sortData in ipairs(UIConst.HERO_DEFAULT_SORT_MAP) do
		local vA = aHero[sortData.name]
		local vB = bHero[sortData.name]

		if vA and vB then
			if vA ~= vB then
				return vB < vA
			end
		elseif vA or vB then
			return vA ~= nil
		end
	end

	if aHero.id ~= bHero.id then
		return aHero.id > bHero.id
	elseif aHero.gid ~= bHero.gid then
		return aHero.gid > bHero.gid
	end
end

function ARDlg:initUI()
	self.panelMain = UIControls.Panel(self, "BgPanel")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self._onClickClose)

	self.heroCells = {}
	self.heroData = {}

	for heroGid, hero in pairs(CurAvatar.heroDic) do
		local modelId = hero:getShowModelId()

		if ResCommonModel[modelId] and ResCommonModel[modelId].disable_ar ~= 1 then
			table.insert(self.heroData, {
				hero,
				ResCommonModel[modelId]
			})
		end
	end

	table.sort(self.heroData, _sortHeroData)

	self.heroHeadScroll = UIControls.ScrollViewLoopV(self, "BgPanel/HeroList")

	self.heroHeadScroll:addEventCellChanged(self.onHeroHeadChanged)

	self.panelStaticMode = UIControls.Panel(self, "BgPanel/PoseModePanel")
	self.btnStaticMode = UIControls.Button(self, "BgPanel/PoseModePanel/BtnMode")

	self.btnStaticMode:addEventClick(self.onClickStaticMode)

	self.panelDanceMode = UIControls.Panel(self, "BgPanel/MoveModePanel")
	self.btnDanceMode = UIControls.Button(self, "BgPanel/MoveModePanel/BtnMode")

	self.btnDanceMode:addEventClick(self.onClickDanceMode)

	self.btnCapture = UIControls.Button(self, "BgPanel/BtnCapture")

	self.btnCapture:addEventClick(self._onClickCapture)

	self.btnVoice = UIControls.Button(self, "BgPanel/BtnVoice")

	self.btnVoice:addEventClick(self.onVoiceClick)

	self.panelNumChoose = UIControls.Panel(self, "BgPanel/NumModePanel")
	self.btnSingleMode = UIControls.Button(self, "BgPanel/NumModePanel/BtnSingle")

	self.btnSingleMode:addEventClick(self.onSingleModeClick)

	self.btnMultiHero = UIControls.Button(self, "BgPanel/NumModePanel/BtnMulti")

	self.btnMultiHero:addEventClick(self.onMultiHero)

	self.panelAlert = UIControls.Panel(self, "BgPanel/AlertPanel")
	self.lableAlert = UIControls.Label(self, "BgPanel/AlertPanel/Text")
	self.poseBtns = {}

	for index = 1, POSE_MAX_NUM do
		local newBtn = ARAnimBtn(self, "BgPanel/PoseModePanel", "System/AR/BtnPose")

		newBtn.poseMode = true

		table.insert(self.poseBtns, newBtn)
	end

	self.danceBtns = {}

	for index = 1, DANCE_MAX_NUM do
		local newBtn = ARAnimBtn(self, "BgPanel/MoveModePanel", "System/AR/BtnMove")

		newBtn.danceMode = true

		table.insert(self.danceBtns, newBtn)
	end

	self:_onInitUI()
end

function ARDlg:onHeroHeadChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ARHeroHeadCell(sender, "System/Common/Grid/GridHeroAR", newIdx, 0, 0)
	else
		self.heroCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local heroInfo = self.heroData[newIdx]

	if heroInfo then
		targetCell:setHero(heroInfo[1], Const.PAINT_HERO_GRID)

		targetCell.heroInfo = heroInfo

		targetCell:setSelected(self.selectHeros[heroInfo[1]], self.multiMode)
	end

	self.heroCells[newIdx] = targetCell
end

function ARDlg:_onInitUI()
	if GameSettings.isAllVoiceClosed() then
		self.btnVoice:setImage("Atlas/ArAtlas", "BtnSilence")
	else
		self.btnVoice:setImage("Atlas/ArAtlas", "BtnSound")
		GameSettings.openAllVoice(true)
	end

	local ui = UIManager.getUI("click", nil, false)

	if ui then
		ui:enableClickEfx(false)
	end
end

function ARDlg:destroy()
	local ui = UIManager.getUI("click", nil, false)

	if ui then
		ui:enableClickEfx(true)
	end

	TouchManager.clearAll()
	TouchManager.enabled(false)
	self.timerInit:Stop()
	self.timerEnterAnim:Stop()
	self.timerCheckSafty:Stop()
	LoaderUtils.unLoadPrefab(self.gameARPrefab)
	GameSettings.revertVoiceSetting()
	self:clearModels()
	CueManager.stopAvgBGM()

	if GameFsm.isInState(Const.STATE_MAIN_STAGE) then
		PerformManager.start()
	end

	MsgManager.showMsgOnScreen(true)
	ARDlg.super.destroy(self)
end

function ARDlg:onSingleModeClick()
	CueManager.stopAvgBGM()

	self.enterModels = nil

	self:clearModels()

	self.multiMode = false

	self.btnSingleMode:setEnable(false)
	self.btnMultiHero:setEnable(true)
	self:onClickDanceMode()
end

function ARDlg:onMultiHero()
	CueManager.stopAvgBGM()

	self.enterModels = nil

	self:clearModels()

	self.multiMode = true

	self.btnSingleMode:setEnable(true)
	self.btnMultiHero:setEnable(false)
	self:onClickDanceMode()
end

function ARDlg:clearModels()
	if self.posModels then
		for index = 1, MULTI_MAX_NUM do
			if self.posModels[index] then
				self.posModels[index].model:destroy()
			end
		end
	end

	self.posModels = {}
	self.posCache = {}

	for index, cell in pairs(self.heroCells) do
		cell:setSelected(false)
	end

	self.selectHeros = {}

	self:setSelectedHeroPos(nil)

	self.nowHeroNum = 0

	self:refreshSelectUI()
end

function ARDlg:onClickHero(sender)
	if not self.arReady then
		MsgManager.notice(Lang.get(30759))
	end

	if self.multiMode then
		self:onMultiHeroClick(sender)
	else
		self:onSingleHeroClick(sender)
	end
end

function ARDlg:destroyOneModel(pos)
	if self.posModels[pos] then
		local hero = self.posModels[pos].hero

		self.posModels[pos].model:destroy()

		self.nowHeroNum = self.nowHeroNum - 1
		self.selectHeros[hero] = nil
		self.posModels[pos] = nil

		for nIndex, cell in pairs(self.heroCells) do
			if hero == cell.hero then
				cell:setSelected(false)
			end
		end
	end

	if self.selectHeroPos == pos then
		self:setSelectedHeroPos()
	end

	self:refreshSelectUI()
end

function ARDlg:setSelectedHeroPos(heroPos)
	self.selectHeroPos = heroPos

	if self.multiMode then
		for pos = 1, MULTI_MAX_NUM do
			local posModelData = self.posModels[pos]

			if posModelData and posModelData.model then
				if self.selectHeroPos and pos ~= self.selectHeroPos then
					posModelData.model:setModelGray(true)
				else
					posModelData.model:setModelGray(false)
				end
			end
		end

		if heroPos and self.posModels[heroPos] then
			self:_refreshBtnState(self.posModels[heroPos].preActBtn)
		end
	end
end

function ARDlg:refreshSelectUI()
	local allActKey = {}
	local hasActKey = {}
	local btns = {}
	local actDataKey = ""

	if self.actMode == ACT_MODE_STATIC then
		table.insert(allActKey, HIGH_QUALITY_SHOW_ACT)

		hasActKey[HIGH_QUALITY_SHOW_ACT] = true
		actDataKey = "ar_static_act"
		btns = self.poseBtns
	else
		allActKey = utils.deepcopy(DANCE_AR_LIST)
		actDataKey = "ar_dance_act"
		btns = self.danceBtns
	end

	if self.selectHeroPos and self.posModels[self.selectHeroPos] then
		local arActData = self.posModels[self.selectHeroPos].arActData

		for _, arId in ipairs(arActData[actDataKey] or {}) do
			hasActKey[arId] = true

			local has = false

			for _, exsistId in ipairs(allActKey) do
				if exsistId == arId then
					has = true

					break
				end
			end

			if not has then
				table.insert(allActKey, arId)
			end
		end
	else
		for pos, posModelData in pairs(self.posModels) do
			local arActData = posModelData.arActData

			for _, arId in ipairs(arActData[actDataKey] or {}) do
				hasActKey[arId] = true

				local has = false

				for _, exsistId in ipairs(allActKey) do
					if exsistId == arId then
						has = true

						break
					end
				end

				if not has then
					table.insert(allActKey, arId)
				end
			end
		end
	end

	if self.nowHeroNum == 0 then
		allActKey = {}
	end

	table.sort(allActKey)

	for index, btn in ipairs(btns) do
		if allActKey[index] then
			btn:setVisible(true)
			btn:setData(allActKey[index], not hasActKey[allActKey[index]])
		else
			btn:setVisible(false)
		end
	end
end

function ARDlg:onClickStaticMode()
	if not self.arReady then
		return
	end

	self.actMode = ACT_MODE_DANCE

	self.panelDanceMode:setVisible(true)
	self.panelStaticMode:setVisible(false)
	self:refreshSelectUI()
end

function ARDlg:onClickDanceMode()
	if not self.arReady then
		return
	end

	self.actMode = ACT_MODE_STATIC

	self.panelDanceMode:setVisible(false)
	self.panelStaticMode:setVisible(true)
	self:refreshSelectUI()

	if self.nowHeroNum > 0 then
		self:onBtnActClick(self.poseBtns[1])
	end
end

function ARDlg:onMultiHeroClick(sender)
	if self:_selectMultiHero(sender.heroInfo[1], sender.heroInfo[2]) then
		sender:setSelected(true, self.multiMode)
	end
end

function ARDlg:_selectMultiHero(hero, heroInfo)
	for index = 1, MULTI_MAX_NUM do
		if self.posModels[index] and self.posModels[index].hero == hero then
			self:savePosCache(index)
			self:destroyOneModel(index)

			self.enterModels[index] = nil

			return
		end
	end

	local emptyIndex = 1

	for index = 1, MULTI_MAX_NUM do
		if not self.posModels[index] then
			emptyIndex = index

			break
		end
	end

	if self.posModels[emptyIndex] then
		MsgManager.notice(Lang.get(30760))
	else
		local preNum = self.nowHeroNum

		self.nowHeroNum = self.nowHeroNum + 1

		local newModelData = {}

		newModelData.hero = hero
		self.selectHeros[newModelData.hero] = true
		newModelData.arActData = heroInfo
		newModelData.pos = emptyIndex
		self.posModels[emptyIndex] = newModelData

		if preNum == 0 then
			self:onClickDanceMode()
		else
			self:refreshSelectUI()
			self:confirmAllModel(SHOW_MODEL_HIGH, nil, emptyIndex)
		end

		return true
	end
end

function ARDlg:savePosCache(pos)
	if self.posModels[pos] and self.posModels[pos].model and self.posModels[pos].model.modelGameObject then
		if not self.posCache[pos] then
			self.posCache[pos] = {}
		end

		self.posCache[pos].prePosition = self.posModels[pos].model.modelGameObject.transform.localPosition
		self.posCache[pos].scale = self.posModels[pos].model.modelGameObject.transform.localScale
		self.posCache[pos].rotate = self.posModels[pos].model.modelGameObject.transform.localRotation
	end
end

function ARDlg:onSingleHeroClick(sender)
	if self:_selectSingleHero(sender.heroInfo[1], sender.heroInfo[2]) then
		for _, cell in pairs(self.heroCells) do
			cell:setSelected(sender == cell)
		end
	end
end

function ARDlg:_selectSingleHero(hero, heroInfo)
	if self.posModels[1] and self.posModels[1].hero == hero then
		return
	end

	CueManager.stopAvgBGM()

	if self.posModels[1] and self.posModels[1].model then
		self.selectHeros[self.posModels[1].hero] = nil

		self.posModels[1].model:destroy()

		self.posModels[1] = nil
		self.enterModels = nil
	end

	local preNum = self.nowHeroNum

	self.nowHeroNum = 1

	local newModelData = {}

	newModelData.hero = hero
	self.selectHeros[newModelData.hero] = true
	newModelData.arActData = heroInfo
	newModelData.pos = 1
	self.posModels[1] = newModelData

	if preNum == 0 or self.actMode == ACT_MODE_STATIC then
		self:onClickDanceMode()
	else
		self:refreshSelectUI()

		local preBtn

		if self.targetAniBtn then
			for _, arId in ipairs(newModelData.arActData.ar_dance_act or {}) do
				if arId == self.targetAniBtn.arActId then
					preBtn = self.targetAniBtn

					break
				end
			end
		end

		if preBtn then
			self:onBtnActClick(preBtn)
		else
			self:confirmAllModel(SHOW_MODEL_HIGH, nil, 1)
			self:_refreshBtnState(nil)
		end
	end

	return true
end

function ARDlg:onBtnActClick(sender)
	if self.actMode == ACT_MODE_DANCE and sender.isLocked then
		return
	end

	CueManager.stopAvgBGM()

	local targets = self.selectHeroPos

	if self.actMode == ACT_MODE_DANCE then
		self:confirmAllModel(SHOW_MODEL_NORMAL, sender)

		for index = 1, MULTI_MAX_NUM do
			if self.posModels[index] then
				self.posModels[index].preActBtn = sender
			end
		end
	else
		if self.selectHeroPos and self.posModels[self.selectHeroPos] then
			self.posModels[self.selectHeroPos].preActBtn = sender
		else
			for index = 1, MULTI_MAX_NUM do
				if self.posModels[index] then
					self.posModels[index].preActBtn = sender
				end
			end
		end

		if sender.arActId == HIGH_QUALITY_SHOW_ACT then
			self:confirmAllModel(SHOW_MODEL_HIGH, sender, targets)
		elseif sender.arActId == BONE_SHOW_ACT then
			self:confirmAllModel(SHOW_MODEL_WITH_BASE, sender, targets)
		else
			self:confirmAllModel(SHOW_MODEL_MID, sender, targets)
		end
	end

	self:_refreshBtnState(sender)
end

function ARDlg:_refreshBtnState(sender)
	for index, btn in ipairs(self.poseBtns) do
		btn:setSelected(sender == btn)
	end

	for index, btn in ipairs(self.danceBtns) do
		btn:setSelected(sender == btn)
	end
end

function ARDlg:confirmAllModel(targetShowType, aniBtn, targetPos)
	self:_adjustShadowPlane(targetShowType ~= SHOW_MODEL_NORMAL)

	if targetPos then
		targetPos = {
			targetPos
		}
	else
		targetPos = {
			1,
			2,
			3
		}
	end

	self.targetAniBtn = aniBtn
	self.waitingModels = {}

	if not self.enterModels then
		self.enterModels = {}
	end

	for index, pos in ipairs(targetPos) do
		local posModelData = self.posModels[pos]

		if posModelData then
			local hasAnim = true

			if aniBtn and aniBtn.danceMode then
				hasAnim = false

				for _, arId in ipairs(posModelData.arActData.ar_dance_act or {}) do
					if arId == aniBtn.arActId then
						hasAnim = true

						break
					end
				end

				if not hasAnim then
					MsgManager.notice(string.format(Lang.get(30758), posModelData.hero.name))
				end
			elseif aniBtn and aniBtn.poseMode and aniBtn.arActId ~= HIGH_QUALITY_SHOW_ACT then
				hasAnim = false

				for _, arId in ipairs(posModelData.arActData.ar_static_act or {}) do
					if arId == aniBtn.arActId then
						hasAnim = true

						break
					end
				end
			end

			if hasAnim then
				self:savePosCache(pos)
				table.insert(self.waitingModels, pos)

				local createModel = true

				if posModelData.showType then
					if posModelData.showType == targetShowType then
						posModelData.modelReady = true
						createModel = false
					elseif posModelData.showType == SHOW_MODEL_WITH_BASE and targetShowType == SHOW_MODEL_NORMAL then
						posModelData.modelReady = true

						local modelInsId = posModelData.model:getModelInsId()

						ModelTool.delBaseModel(modelInsId)

						createModel = false

						posModelData.model:setAllVisible(false)

						self.enterModels[pos] = true
					elseif posModelData.showType == SHOW_MODEL_NORMAL and targetShowType == SHOW_MODEL_WITH_BASE then
						posModelData.modelReady = false

						local modelInsId = posModelData.model:getModelInsId()

						createModel = false

						ModelTool.addBaseModel(modelInsId, posModelData.hero:getShowBaseModelId(), 1, Const.HERO_BASE_TYPE.Battle, Functor(self._onBaseLoaded, self, pos))

						self.enterModels[pos] = true

						posModelData.model:setAllVisible(false)
					end
				end

				posModelData.showType = targetShowType

				if createModel then
					posModelData.modelReady = false
					self.enterModels[pos] = true

					if posModelData.model then
						posModelData.model:destroy()
					end

					posModelData.model = Model(Functor(self._onModelLoaded, self, pos))

					if targetShowType == SHOW_MODEL_HIGH then
						posModelData.model:setModelDataShow(posModelData.hero:getShowModelId(), Const.MODEL_TYPE.ShowStepOne)
					elseif targetShowType == SHOW_MODEL_MID then
						posModelData.model:setModelDataShow(posModelData.hero:getShowModelId(), Const.MODEL_TYPE.ShowMain, Const.MODEL_LOD_LV1)
					else
						posModelData.model:setModelDataShow(posModelData.hero:getShowModelId(), Const.MODEL_TYPE.ARAct)
					end

					posModelData.model:loadGameObject()
				end
			end
		end
	end

	self:onCheckAllModelReady()
end

function ARDlg:_onModelLoaded(pos, loadedModel)
	local posModelData = self.posModels[pos]

	if posModelData then
		if posModelData.model then
			local anim = posModelData.model:getAnimator()

			if anim then
				anim.keepAnimatorControllerStateOnDisable = true
			end
		end

		if posModelData.showType == SHOW_MODEL_NORMAL then
			posModelData.model:setAllVisible(false)

			posModelData.modelReady = true

			self:initModelSensor(pos)
		else
			local modelInsId = posModelData.model:getModelInsId()

			ModelTool.addBaseModel(modelInsId, posModelData.hero:getShowBaseModelId(), 1, Const.HERO_BASE_TYPE.Battle, Functor(self._onBaseLoaded, self, pos))
		end
	end
end

function ARDlg:_onBaseLoaded(pos)
	self:initModelSensor(pos)
end

local CAMERA_MIN_DIST = 0.8
local CAMERA_MAX_DIST = 3

function ARDlg:initModelSensor(pos)
	local posModelData = self.posModels[pos]

	if posModelData and posModelData.model then
		local model = posModelData.model
		local transform = model.modelGameObject.transform

		transform.parent = self.arModelAnchor

		local nowScale = transform.localScale.x

		transform.localScale = Vector3(nowScale * 0.2, nowScale * 0.2, nowScale * 0.2)
		transform.localPosition = VEC3_ZERO
		transform.localRotation = VEC3_ROT

		model:setModelLayer(Const.LAYER_AR)

		local modelInsId = model:getModelInsId()
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:SetTonemapping(true)
		end

		local funcReceiver = {}

		funcReceiver.pos = pos
		funcReceiver.OnClick = Slot(self.onClickModel, self)

		local rotateSensor = Framework.Tools.LuaToolkit.SetCommonDragSensor(model.modelGameObject)

		rotateSensor:InitRotateMode(model.modelGameObject, funcReceiver)

		rotateSensor.boxCollider.center = Vector3(0, 1, 0)
		rotateSensor.boxCollider.size = Vector3(1, 1.24, 1)
		model.rotateSensor = rotateSensor

		if posModelData.showType ~= SHOW_MODEL_NORMAL then
			local baseGameObject = ModelFactory.GetBaseGO(modelInsId)
			local dragSensor = Framework.Tools.LuaToolkit.SetCommonDragSensor(baseGameObject)

			dragSensor:InitARPositionMode(MULTI_SHOW_POS[pos][1], MULTI_SHOW_POS[pos][2], model.modelGameObject, funcReceiver)

			dragSensor.boxCollider.center = Vector3(0, 0, 0)
			dragSensor.boxCollider.size = Vector3(1.5, 1, 1.5)
			model.dragSensor = dragSensor
		end

		if self.posCache[pos] then
			transform.localScale = self.posCache[pos].scale
			transform.localPosition = self.posCache[pos].prePosition
			transform.localRotation = self.posCache[pos].rotate
		else
			local modelPosition = model.modelGameObject.transform.localPosition
			local cameraPosition = self.MainCameraGo.transform.localPosition
			local distVec = modelPosition - cameraPosition

			distVec.y = 0

			local dis = distVec:Magnitude()

			if dis > CAMERA_MAX_DIST then
				local sca = 1 - CAMERA_MAX_DIST / dis
				local newVec = modelPosition - distVec * sca

				model.modelGameObject.transform.localPosition = newVec
			elseif dis < CAMERA_MIN_DIST then
				distVec:SetNormalize()

				if distVec.x ~= 0 or distVec.z ~= 0 then
					local newVec = cameraPosition + distVec * CAMERA_MIN_DIST

					newVec.y = 0
					model.modelGameObject.transform.localPosition = newVec
				end
			end
		end

		posModelData.modelReady = true

		posModelData.model:setAllVisible(false)
		self:onCheckAllModelReady()
	end
end

function ARDlg:onCheckAllModelReady()
	self.timerEnterAnim:Stop()

	for index, pos in ipairs(self.waitingModels) do
		if self.posModels[pos] and not self.posModels[pos].modelReady then
			return
		end
	end

	for pos, _ in pairs(self.enterModels) do
		if self.posModels[pos] and self.posModels[pos].model and self.posModels[pos].modelReady then
			self.posModels[pos].model:setAllVisible(true)

			if self.targetAniBtn == nil or self.targetAniBtn.arActId == HIGH_QUALITY_SHOW_ACT then
				self.posModels[pos].model:playAnimation("Newshow_idle", true)
				self.poseBtns[1]:startAction(self.posModels[pos].hero)
			end

			if self.multiMode then
				if self.selectHeroPos and pos ~= self.selectHeroPos then
					self.posModels[pos].model:setModelGray(true)
				else
					self.posModels[pos].model:setModelGray(false)
				end
			end

			self.enterModels[pos] = nil
		end
	end

	self:onPlayCachedAnim()
end

function ARDlg:onPlayCachedAnim()
	local downloadPaths = {}
	local jobName = tostring(self.targetAniBtn)

	if self.targetAniBtn then
		jobName = tostring(self.targetAniBtn.arActData.ani_name)
	end

	if self.actMode == ACT_MODE_DANCE then
		for index, pos in ipairs(self.waitingModels) do
			if self.posModels[pos] and self.posModels[pos].model then
				local id = self.posModels[pos].model._modelData.model_id
				local match = "_lazy_" .. tostring(id) .. "_dance"

				jobName = jobName .. tostring(id)

				table.insert(downloadPaths, match)
			end
		end
	end

	local allLoaded, subJob = SubpackageHelper.checkDownloadFileByMultiPath(jobName, downloadPaths)

	if not allLoaded then
		local desc = Lang.get(42729)

		SubpackageHelper.tryDownloadJob(subJob, Slot(self._realPlayCachedAnim, self), nil, desc)
	else
		coroutine.start(self._ensureAllDanceAnimatorCo, self)
	end
end

function ARDlg:_ensureAllDanceAnimatorCo()
	coroutine.step()
	self:_ensureAllDanceAnimator()
end

function ARDlg:_ensureAllDanceAnimator()
	if self.targetAniBtn and self.targetAniBtn.arActId ~= HIGH_QUALITY_SHOW_ACT and self.waitingModels then
		if self.actMode == ACT_MODE_DANCE then
			self.allDanceAnimatorLoaded = {}

			for index, pos in ipairs(self.waitingModels) do
				if self.posModels[pos] and self.posModels[pos].model then
					local id = self.posModels[pos].model._modelData.model_id
					local heroInfo = ResCommonModel[id]
					local danceAnimator = heroInfo.dance_animator

					if danceAnimator then
						danceAnimator = "Animators/Home/" .. danceAnimator .. ".overrideController"

						local partPathDict = {}

						partPathDict.animator = danceAnimator

						local model = self.posModels[pos].model

						ModelFactory.ChangeModelParts(model._modelInsId, partPathDict, false, Functor(self._checkDanceAnimatorCallback, self, pos), LoaderMode.Async)
					else
						self:_checkDanceAnimatorCallback(pos)
					end
				end
			end
		else
			self:_realPlayCachedAnimCallback()
		end
	end
end

function ARDlg:_checkDanceAnimatorCallback(pos)
	self.allDanceAnimatorLoaded[pos] = true

	self:_ensureAllDanceAnimatorCallback()
end

function ARDlg:_ensureAllDanceAnimatorCallback()
	local allLoaded = true

	if self.targetAniBtn and self.targetAniBtn.arActId ~= HIGH_QUALITY_SHOW_ACT and self.waitingModels then
		for index, pos in ipairs(self.waitingModels) do
			if self.posModels[pos] and self.posModels[pos].model and self.actMode == ACT_MODE_DANCE and not self.allDanceAnimatorLoaded[pos] then
				allLoaded = false

				break
			end
		end
	end

	if not allLoaded then
		return
	end

	self:_realPlayCachedAnimCallback()
end

function ARDlg:_realPlayCachedAnimCallback()
	if self.targetAniBtn and self.targetAniBtn.arActId ~= HIGH_QUALITY_SHOW_ACT and self.waitingModels then
		self.allDanceAnimatorLoaded = {}

		for index, pos in ipairs(self.waitingModels) do
			if self.posModels[pos] and self.posModels[pos].model then
				self.posModels[pos].model:playAnimation(self.targetAniBtn.arActData.ani_name, true)
				self.targetAniBtn:startAction(self.posModels[pos].hero)
			end
		end
	end
end

function ARDlg:onClickModel(funcReceiver)
	if self.multiMode and funcReceiver and funcReceiver.pos then
		self:setSelectedHeroPos(funcReceiver.pos)
		self:refreshSelectUI()
	end
end

function ARDlg:onSimpleTap(gesture)
	if self.multiMode and self.selectHeroPos then
		self:setSelectedHeroPos(nil)
		self:refreshSelectUI()
	end
end

function ARDlg:onPinchIn(gesture)
	self:setBoxColliderEnable(false)

	local scale = 1 - gesture.deltaPinch / 1000

	self:_realScaleModels(scale)
end

function ARDlg:onPinchOut(gesture)
	self:setBoxColliderEnable(false)

	local scale = 1 + gesture.deltaPinch / 1000

	self:_realScaleModels(scale)
end

function ARDlg:onTouchUp(gesture)
	self:setBoxColliderEnable(true)
end

function ARDlg:setBoxColliderEnable(value)
	for index, posModelData in pairs(self.posModels) do
		if posModelData.model and posModelData.model:isLoaded() then
			local model = posModelData.model

			if model then
				if model.dragSensor then
					model.dragSensor.enabled = value
				end

				if model.rotateSensor then
					model.rotateSensor.enabled = value
				end
			end
		end
	end
end

function ARDlg:_realScaleModels(scale)
	if self.selectHeroPos and self.multiMode then
		local posModelData = self.posModels[self.selectHeroPos]

		if posModelData and posModelData.model and posModelData.model:isLoaded() then
			local transform = posModelData.model.modelGameObject.transform
			local nowScale = transform.localScale.x

			nowScale = nowScale * scale
			transform.localScale = Vector3(nowScale, nowScale, nowScale)
		end
	else
		for index, posModelData in pairs(self.posModels) do
			if posModelData.model and posModelData.model:isLoaded() then
				local transform = posModelData.model.modelGameObject.transform
				local nowScale = transform.localScale.x

				nowScale = nowScale * scale
				transform.localScale = Vector3(nowScale, nowScale, nowScale)
			end
		end
	end
end

function ARDlg:_adjustShadowPlane(hasBase)
	if not self.shadowPlane then
		return
	end

	local yPos = hasBase and -0.02 or 0

	self.shadowPlane.localPosition = Vector3(0, yPos, 0)
end

function ARDlg:checkSafety()
	local hideReason

	if self.posModels then
		local localRotation = self.MainCameraGo.transform.localRotation
		local cameraPosition = self.MainCameraGo.transform.localPosition
		local cameraHeight = cameraPosition.y

		for index, posModelData in pairs(self.posModels) do
			if posModelData.model and posModelData.model:isLoaded() then
				local transform = posModelData.model.modelGameObject.transform
				local nowScale = transform.localScale.x
				local distVec = transform.localPosition - cameraPosition

				distVec.y = 0

				local dis = distVec:Magnitude()

				dis = dis - CAMERA_NEAR_CLIP

				local hideHeight = posModelData.arActData.ar_height or 1

				if dis <= nowScale * 0.8 then
					posModelData.model:setVisible(false)

					hideReason = HIDE_REASON_TOO_CLOSE
				elseif cameraHeight < nowScale * hideHeight and RegionUtils.isCN() then
					posModelData.model:setVisible(false)

					hideReason = HIDE_REASON_TOO_LOW
				else
					posModelData.model:setVisible(true)
				end
			end
		end

		self:setHideReason(hideReason)
	end
end

function ARDlg:setHideReason(hideReason)
	local same = hideReason == self._hideReason

	if not same then
		if hideReason then
			self.lableAlert:setText(hideReason)
		end

		self.panelAlert:setVisible(hideReason ~= nil)

		self._hideReason = hideReason
	end
end

function ARDlg:initGameAR(arMode)
	self.posModels = {}

	if PerformManager.running then
		PerformManager.stop()
	end

	MsgManager.notice(Lang.get(30761))

	self.arReady = false
	self.gameARPrefab = LoaderUtils.LoadPrefabSync("Scenes/AR/EasyARStage.prefab")
	self.gameARAnchor = LoaderUtils.GetGoByLoadId(self.gameARPrefab)

	self:_initARConfig()

	self.timerInit = Timer.New(Slot(self.onCheckARReady, self), 0.5, -1)

	self.timerInit:Start()

	self.timerEnterAnim = Timer.New(Slot(self.onPlayCachedAnim, self), 1.2, 1)
	self.timerCheckSafty = Timer.New(Slot(self.checkSafety, self), 0.2, -1)

	self.timerCheckSafty:Start()
	TouchManager.enabled(true)
	TouchManager.register(Const.TOUCH_SIMPLETAP, Slot(self.onSimpleTap, self))
	TouchManager.register(Const.TOUCH_PINCHIN, Slot(self.onPinchIn, self))
	TouchManager.register(Const.TOUCH_PINCHOUT, Slot(self.onPinchOut, self))
	TouchManager.register(Const.TOUCH_UP, Slot(self.onTouchUp, self))
end

local CameraDeviceType = typeof(easyar.VideoCameraDevice)

function ARDlg:_initARConfig()
	local configGo = self.gameARAnchor.transform:Find("SurfaceTracker/VideoCamera")

	self.MainCameraGo = self.gameARAnchor.transform:Find("Main Camera")

	local cameraDevice = configGo:GetComponent(CameraDeviceType)

	self.arModelAnchor = self.gameARAnchor.transform:Find("WorldRoot")

	if self.arModelAnchor and self.arModelAnchor.transform then
		self.shadowPlane = self.arModelAnchor.transform:Find("ARShadowReceiver")
	end

	self.gameARAnchor:SetActive(true)
end

function ARDlg:onCheckARReady()
	local ready = Framework.Tools.LuaToolkit.IsArSceneAvailble()

	if ready then
		MsgManager.notice(Lang.get(30762))

		self.arReady = true

		self.timerInit:Stop()

		if self.cacheShowMulti and self.cacheShowHeros then
			self:_realShowMultiHeros(self.cacheShowHeros)
		elseif self.cacheShowSingle and self.cacheShowHeros then
			self:_realShowSingleHero(self.cacheShowHeros[1])
		end
	end
end

function ARDlg:_onClickClose()
	self:setVisible(false)
end

ARDlg.shareTitle = "1/7のワタシでも、あなたへの想いは1/1です！\nフィギュアがこっそり動きだすRPG『フィギュアストーリー』好評配信中！\n▼DLはコチラ▼\nhttps://giasuto.onelink.me/jFuI/705583c"

function ARDlg:_onClickCapture()
	self.panelMain:setVisible(false)

	local captureDlg = UIManager.getUI("captureDlg", true)

	if captureDlg then
		captureDlg:capture(Slot(self.shareCallback, self), {
			frameType = 0,
			title = self.shareTitle
		})
	end
end

function ARDlg:shareCallback()
	self.panelMain:setVisible(true)
end

function ARDlg:onVoiceClick()
	if GameSettings.isAllVoiceClosed() then
		self.btnVoice:setImage("Atlas/ArAtlas", "BtnSound")
		GameSettings.openAllVoice()
		MsgManager.notice(Lang.get(31310))
	else
		self.btnVoice:setImage("Atlas/ArAtlas", "BtnSilence")
		GameSettings.closeAllVoice()
		MsgManager.notice(Lang.get(31311))
	end
end

function ARDlg:directShowSingleHero(heroId, hero)
	self.cacheShowMulti = nil

	if not hero and heroId and self.heroData then
		for _, heroInfo in ipairs(self.heroData) do
			if heroId == heroInfo[1].id then
				hero = heroInfo[1]

				break
			end
		end
	end

	hero = hero or self.heroData[1][1]

	if self.arReady then
		self.cacheShowSingle = nil

		self:_realShowSingleHero(hero)
	else
		self.cacheShowSingle = true
		self.cacheShowHeros = {
			hero
		}
	end
end

function ARDlg:_realShowSingleHero(hero)
	self:onSingleModeClick()

	local modelId = hero:getShowModelId()

	if ResCommonModel[modelId] and ResCommonModel[modelId].disable_ar ~= 1 then
		local heroInfo = ResCommonModel[modelId]

		self:_selectSingleHero(hero, heroInfo)
	end

	self.heroHeadScroll:setTotalCount(#self.heroData)

	self.cacheShowSingle = nil
	self.cacheShowHeros = nil
end

function ARDlg:directShowMainmenuHeros(heros)
	self.cacheShowSingle = nil

	if self.arReady then
		self.cacheShowMulti = nil

		self:_realShowMultiHeros(heros)
	else
		self.cacheShowMulti = true
		self.cacheShowHeros = heros
	end
end

function ARDlg:_realShowMultiHeros(heros)
	self:onMultiHero()
	coroutine.start(Functor(self._coLoadMultiHero, self, heros))
end

function ARDlg:_coLoadMultiHero(heros)
	coroutine.wait(0.5)

	for _, hero in ipairs(heros) do
		local modelId = hero:getShowModelId()

		if ResCommonModel[modelId] and ResCommonModel[modelId].disable_ar ~= 1 then
			local heroInfo = ResCommonModel[modelId]

			self:_selectMultiHero(hero, heroInfo)
		end
	end

	self.heroHeadScroll:setTotalCount(#self.heroData)

	self.cacheShowMulti = nil
	self.cacheShowHeros = nil
end

return ARDlg
