-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/page/MainPerformEditorSubViewBase.lua

module("logic.extensions.mainui.view.performeditor.page.MainPerformEditorSubViewBase", package.seeall)

local M = class("MainPerformEditorSubViewBase")
local Input = Astral.ToLuaFramework.AsInputSystem.InputSystemToLua
local defaultSliderVal = 0.5

function M:ctor(mainGo)
	self.mainGO = mainGo
end

function M:init(viewRegistry)
	self._viewRegistry = viewRegistry

	self:buildUI()
	self:bindEvents()

	self._isInit = true
end

function M:Awake()
	return
end

function M:OnEnable()
	if not self._isInit then
		return
	end
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._viewRegistry
end

function M:buildUI()
	local registry = self:getRegistry()

	self._isSupport = UnityEngine.SystemInfo.supportsGyroscope
	self._toggleGyrosActive = registry:findUIElement("main_perform_editor_view_1052083976", UIComponentType.SpaceXToggle)

	goutil.setActive(self._toggleGyrosActive.gameObject, false)

	self._toggleGyrosSim = registry:findUIElement("main_perform_editor_view_-42208892", UIComponentType.SpaceXToggle)
	self._btnResetGyrosSimVal = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_1414880558"))
	self._toggleGyrosKeyBoard = registry:findUIElement("main_perform_editor_view_1724652191", UIComponentType.SpaceXToggle)
	self._inputGyroKeyBoardVal = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_-1256699568"))
	self._btnSaveGyroKeyBoardVal = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_-991942779"))
	self._toggleGyrosAuto = registry:findUIElement("main_perform_editor_view_-1848692923", UIComponentType.SpaceXToggle)
	self._inputGyrosAutoSmall = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_-1305502678"))

	self._inputGyrosAutoSmall:SetText("0")

	self._inputGyrosAutoBig = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_-1404261371"))

	self._inputGyrosAutoBig:SetText("1")

	self._inputGyrosAutoTime = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_-1338472988"))

	self._inputGyrosAutoTime:SetText("1")

	self._sliderX = UIComponentType.SliderAdapter(registry:findUIElement("main_perform_editor_view_1570682076"))
	self._sliderY = UIComponentType.SliderAdapter(registry:findUIElement("main_perform_editor_view_1232657224"))
	self._btnGyroCfgHelp = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_243640247"))
	self._goGyroCfgHelp = registry:findUIElement("main_perform_editor_view_-1553717512")
	self._goGyroCfgHelpEcho = registry:findUIElement("main_perform_editor_view_30013765")
	self._dropDownGyro = registry:findUIElement("main_perform_editor_view_-1118524229", UIComponentType.Dropdown)
	self._dropAdapterGyro = registry:findUIElement("main_perform_editor_view_-1118524229", UIComponentType.DropdownApapter)
	self._txtDropGyro = registry:findUIElement("main_perform_editor_view_1950107813", UIComponentType.Text)

	MainScenePerformUtil.updateDropDownLst(self._dropDownGyro, MainPerformEnum.GyrosEventName)

	self._inputGyroMaxAngleX = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_-1610074583"))
	self._inputGyroMaxAngleY = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_113700269"))
	self._btnSaveGyroMaxAngle = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_-715546919"))
	self._inputGyroFilterX = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_-545914661"))
	self._inputGyroFilterY = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_1800979537"))
	self._btnSaveGyroFilter = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_864255237"))
	self._inputGyroFrameTime = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_1560830726"))
	self._btnSaveGyroFrameTime = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_598677232"))
	self._inputGyroDuration = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_324078477"))
	self._btnSaveGyroDuration = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_-1157864730"))
	self._goEchoGyroRoot = registry:findUIElement("main_perform_editor_view_-1984375510")
	self._inputEchoGyroChangeRate = UIComponentType.InputFieldAdapter(registry:findUIElement("main_perform_editor_view_1822031297"))
	self._btnSaveEchoGyroChangeRate = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_9929388"))
	self._sliderEchoRotateLeft = UIComponentType.SliderAdapter(registry:findUIElement("main_perform_editor_view_970992188"))
	self._sliderEchoRotateRight = UIComponentType.SliderAdapter(registry:findUIElement("main_perform_editor_view_-1470364451"))
	self._txtEchoRotateLeft = registry:findUIElement("main_perform_editor_view_1916302217", UIComponentType.Text)
	self._txtEchoRotateRight = registry:findUIElement("main_perform_editor_view_-827600032", UIComponentType.Text)
	self._btnSaveEchoRotateLR = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_view_808179642"))
	self._sliderEchoTextureRotatePreview = UIComponentType.SliderAdapter(registry:findUIElement("main_perform_editor_view_37133991"))
	self._toggleListenAngleChange = registry:findUIElement("main_perform_editor_view_1704718824", UIComponentType.SpaceXToggle)
	self._txtBaseAngle = registry:findUIElement("main_perform_editor_view_-1144815687", UIComponentType.Text)
	self._txtGyrosAngle = registry:findUIElement("main_perform_editor_view_-259235006", UIComponentType.Text)
	self._txtGyrosPosMobile = registry:findUIElement("main_perform_editor_view_-395218543", UIComponentType.Text)
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
	self._viewRegistry = nil

	self._sliderX.slider:DOKill(false)

	self._dropDownGyro = nil
	self._dropAdapterGyro = nil
	self._txtDropGyro = nil
	self._toggleGyrosActive = nil
	self._toggleGyrosSim = nil
	self._btnResetGyrosSimVal = nil
	self._sliderX = nil
	self._sliderY = nil
	self._toggleListenAngleChange = nil
	self._txtBaseAngle = nil
	self._txtGyrosAngle = nil
	self._toggleGyrosKeyBoard = nil
	self._toggleGyrosAuto = nil
	self._inputGyroKeyBoardVal = nil
	self._btnSaveGyroKeyBoardVal = nil

	if Astral.OSDef.isEditor then
		self:_addKeyBoardListener(false)
	end
end

function M:bindEvents()
	self._toggleGyrosActive:AddListener(self._onGyrosActive, self)
	self._toggleGyrosSim:AddListener(self._onGyrosSimulate, self)
	self._btnResetGyrosSimVal:AddClickListener(self._onClickResetGyrosSimVal, self)
	self._sliderX:AddOnValueChanged(self._onSliderGyroX, self)
	self._sliderY:AddOnValueChanged(self._onSliderGyroY, self)
	self._toggleListenAngleChange:AddListener(self._onListenAngleChange, self)
	self._btnSaveGyroMaxAngle:AddClickListener(self._onClickSaveGyroMaxAngle, self)
	self._btnSaveGyroFilter:AddClickListener(self._onClickSaveGyroFilter, self)
	self._btnSaveGyroFrameTime:AddClickListener(self._onClickSaveGyroFrameTime, self)
	self._btnSaveGyroDuration:AddClickListener(self._onClickSaveGyroDuration, self)
	self._dropAdapterGyro:AddListener(self._onDropDownGyroEvent, self)
	self._btnSaveEchoGyroChangeRate:AddClickListener(self._onClickSaveEchoGyroChangeRate, self)
	self._sliderEchoRotateLeft:AddOnValueChanged(self._onSliderEchoRotateLeft, self)
	self._sliderEchoRotateRight:AddOnValueChanged(self._onSliderEchoRotateRight, self)
	self._btnSaveEchoRotateLR:AddClickListener(self._onClickSaveEchoRotateLR, self)
	self._sliderEchoTextureRotatePreview:AddOnValueChanged(self._onSliderEchoTextureRotatePreview, self)
	self._btnGyroCfgHelp:AddClickListener(self._onClickGyroCfgHelp, self)
	self._toggleGyrosKeyBoard:AddListener(self._onGyrosKeyBoard, self)
	self._toggleGyrosAuto:AddListener(self._onGyrosAuto, self)
	self._btnSaveGyroKeyBoardVal:AddClickListener(self._onClickSaveGyroKeyBoardVal, self)
end

function M:unbindEvents()
	self._toggleGyrosActive:RemoveListener()
	self._toggleGyrosSim:RemoveListener()
	self._btnResetGyrosSimVal:RemoveClickListener()
	self._sliderX:RemoveOnValueChanged()
	self._sliderY:RemoveOnValueChanged()
	self._toggleListenAngleChange:RemoveListener()
	self._btnSaveGyroMaxAngle:RemoveClickListener()
	self._btnSaveGyroFilter:RemoveClickListener()
	self._btnSaveGyroFrameTime:RemoveClickListener()
	self._btnSaveGyroDuration:RemoveClickListener()
	self._dropAdapterGyro:RemoveClickListener()
	self._btnSaveEchoGyroChangeRate:RemoveClickListener()
	self._sliderEchoRotateLeft:RemoveOnValueChanged()
	self._sliderEchoRotateRight:RemoveOnValueChanged()
	self._btnSaveEchoRotateLR:RemoveClickListener()
	self._sliderEchoTextureRotatePreview:RemoveOnValueChanged()
	self._btnGyroCfgHelp:RemoveClickListener()
	self._toggleGyrosKeyBoard:RemoveListener()
	self._toggleGyrosAuto:RemoveListener()
	self._btnSaveGyroKeyBoardVal:RemoveClickListener()

	if Astral.OSDef.isEditor then
		self:_addKeyBoardListener(false)
	end
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getActiveSubPageDirty()
	return false
end

function M:onEnter()
	self:setEvent(true)

	self._x, self._y, self._z = 0, 0, 0
	self._toggleGyrosActive.IsOn = true
	self._toggleGyrosSim.IsOn = false
	self._toggleListenAngleChange.IsOn = false
	self._toggleGyrosKeyBoard.IsOn = false
	self._toggleGyrosAuto.IsOn = false

	self._inputGyroKeyBoardVal:SetText("0.1")
	self:refreshGyroCfgStatus()

	self._dropDownGyro.value = 0
end

function M:onExit()
	self:setEvent(false)
	removetimer(self._updateAngleChange, self)

	self._curGyroEvent = nil
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickGyroCfgHelp()
	local show = not self._goGyroCfgHelp.activeSelf

	if show then
		local gyroEventId = self:getGyroEventId()

		goutil.setActive(self._goGyroCfgHelpEcho, gyroEventId == MainPerformEnum.GyrosEventTyp.Echo)
	end

	goutil.setActive(self._goGyroCfgHelp, show)
end

function M:_onDropDownGyroEvent(index)
	self:_getDataCallBack(nil)

	self._toggleListenAngleChange.IsOn = false
	self._curGyroEvent = index + 1
	self._txtDropGyro.text = MainPerformEnum.GyrosEventName[self._curGyroEvent] or self._curGyroEvent

	self:refreshGyroCfgStatus()
	self:_onClickResetGyrosSimVal()
end

function M:getGyroEventId()
	return self._curGyroEvent
end

function M:getGyroCfgData()
	if not self._cacheGyroCfgData then
		self._cacheGyroCfgData = MainScenePerformUtil.createGyroPerformData()
	end

	return self._cacheGyroCfgData
end

function M:_onGyrosActive(_, isOn)
	local sceneType = SceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		-- block empty
	else
		printWarn("非主场景，不响应操作")
	end
end

function M:_onGyrosSimulate(_, isOn)
	local gyroEventId = self:getGyroEventId()

	self._sliderX:SetValue(defaultSliderVal)
	self._sliderY:SetValue(defaultSliderVal)

	if not isOn then
		self._toggleGyrosKeyBoard.IsOn = false
	end

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_SIMULATE, gyroEventId, isOn, self._x, self._y, self._z)
end

function M:_onGyrosKeyBoard(_, isOn)
	if not Astral.OSDef.isEditor then
		if isOn then
			self._toggleGyrosKeyBoard.IsOn = false
		end

		return
	end

	if not self._toggleGyrosSim.IsOn then
		FloatWordMgr.instance:show("请先开启,陀螺仪模拟")
		self:_addKeyBoardListener(false)

		if isOn then
			self._toggleGyrosKeyBoard.IsOn = false
		end

		return
	end

	local setIsOn = isOn

	if setIsOn then
		self:_addKeyBoardListener(true)
	else
		self:_addKeyBoardListener(false)
	end
end

function M:_onGyrosAuto(_, isOn)
	if not Astral.OSDef.isEditor then
		if isOn then
			self._toggleGyrosKeyBoard.IsOn = false
		end

		return
	end

	if not self._toggleGyrosSim.IsOn then
		FloatWordMgr.instance:show("请先开启,陀螺仪模拟")

		if isOn then
			self._toggleGyrosKeyBoard.IsOn = false
		end

		return
	end

	self._sliderX.slider:DOKill(false)

	if isOn then
		local smallVal = self:_getInputNum(self._inputGyrosAutoSmall)
		local maxVal = self:_getInputNum(self._inputGyrosAutoBig)
		local time = self:_getInputNum(self._inputGyrosAutoTime)

		self._sliderX:SetValue(smallVal)
		self._sliderX.slider:DOValue(maxVal, time):SetEase(DG.Tweening.Ease.Linear):SetLoops(-1, DG.Tweening.LoopType.Yoyo):SetAutoKill(false)
	end
end

function M:_onClickSaveGyroKeyBoardVal()
	local num = self._inputGyroKeyBoardVal:GetText()

	if string.nilorempty(num) then
		num = 0
	end

	num = tonumber(num)

	if num == 0 then
		FloatWordMgr.instance:show("键盘模拟变化量，必须不为0")

		return
	end

	num = math.abs(num)
	self._gyrosKeyBoardChangeVal = num
end

function M:_getGyrosKeyBoardChangeVal()
	return self._gyrosKeyBoardChangeVal or 0.1
end

function M:_addKeyBoardListener(add)
	if not Astral.OSDef.isEditor then
		add = false
	end

	local inst = KeycodeListener.instance

	if add then
		inst:addEventListener(UnityEngine.KeyCode.LeftArrow, self._onKeycodeChange, self, 0)
		inst:addEventListener(UnityEngine.KeyCode.RightArrow, self._onKeycodeChange, self, 0)
		inst:addEventListener(UnityEngine.KeyCode.UpArrow, self._onKeycodeChange, self, 0)
		inst:addEventListener(UnityEngine.KeyCode.DownArrow, self._onKeycodeChange, self, 0)
		inst:addEventListener(UnityEngine.KeyCode.R, self._onKeycodeChange, self, 0)
	else
		inst:removeEventListener(UnityEngine.KeyCode.LeftArrow, self._onKeycodeChange, self)
		inst:removeEventListener(UnityEngine.KeyCode.RightArrow, self._onKeycodeChange, self)
		inst:removeEventListener(UnityEngine.KeyCode.UpArrow, self._onKeycodeChange, self, 0)
		inst:removeEventListener(UnityEngine.KeyCode.DownArrow, self._onKeycodeChange, self, 0)
		inst:removeEventListener(UnityEngine.KeyCode.R, self._onKeycodeChange, self)
	end
end

function M:_onKeycodeChange(keycode, isOn)
	if isOn then
		if keycode == "LeftArrow" then
			local val = self._sliderX:GetValue()

			val = tonumber(val) - self:_getGyrosKeyBoardChangeVal()
			val = val < 0 and 0 or val

			self._sliderX:SetValue(val)
		elseif keycode == "RightArrow" then
			local val = self._sliderX:GetValue()

			val = tonumber(val) + self:_getGyrosKeyBoardChangeVal()
			val = val > 1 and 1 or val

			self._sliderX:SetValue(val)
		elseif keycode == "UpArrow" then
			local val = self._sliderY:GetValue()

			val = tonumber(val) + self:_getGyrosKeyBoardChangeVal()
			val = val > 1 and 1 or val

			self._sliderY:SetValue(val)
		elseif keycode == "DownArrow" then
			local val = self._sliderY:GetValue()

			val = tonumber(val) - self:_getGyrosKeyBoardChangeVal()
			val = val < 0 and 0 or val

			self._sliderY:SetValue(val)
		elseif keycode == "R" then
			self:_onClickResetGyrosSimVal()
		end
	end
end

function M:_onSliderGyroX(val)
	if not self._toggleGyrosSim.IsOn then
		return
	end

	local gyroEventId = self:getGyroEventId()
	local gyroVal = 0

	if val ~= defaultSliderVal then
		gyroVal = val - defaultSliderVal
	end

	self._x = gyroVal * 2

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_SIMULATE, gyroEventId, true, self._x, self._y, self._z)
end

function M:_onSliderGyroY(val)
	if not self._toggleGyrosSim.IsOn then
		return
	end

	local gyroEventId = self:getGyroEventId()
	local gyroVal = 0

	if val ~= defaultSliderVal then
		gyroVal = val - defaultSliderVal
	end

	self._y = gyroVal * 2

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_SIMULATE, gyroEventId, true, self._x, self._y, self._z)
end

function M:_onClickResetGyrosSimVal()
	self._sliderX:SetValue(defaultSliderVal)
	self._sliderY:SetValue(defaultSliderVal)
end

function M:_onListenAngleChange(_, isOn)
	if isOn then
		local sceneType = SceneMgr.instance:getCurSceneType()

		if sceneType == SceneType.Room then
			settimer(0.1, self._updateAngleChange, self, true)
		else
			printWarn("非主场景，不响应操作")
		end
	else
		removetimer(self._updateAngleChange, self)
	end
end

function M:_updateAngleChange()
	local gyroEventId = self:getGyroEventId()
	local bx, by, bz = 0, 0, 0
	local gx, gy, gz = 0, 0, 0
	local mobilePosX, mobilePosY, mobilePosZ = self:_getMobilePos()

	if gyroEventId == MainPerformEnum.GyrosEventTyp.MainCam then
		local sceneType = SceneMgr.instance:getCurSceneType()

		if sceneType == SceneType.Room then
			local scene = SceneMgr.instance:getCurScene()

			bx, by, bz = scene.camera:getBaseAngleSplit()
			gx, gy, gz = scene.camera:getGyrosAngleSplit()
		end
	end

	local factor = 10000

	bx = math.floor(bx * factor) / factor
	by = math.floor(by * factor) / factor
	bz = math.floor(bz * factor) / factor
	mobilePosX = math.floor(mobilePosX * factor) / factor
	mobilePosY = math.floor(mobilePosY * factor) / factor
	mobilePosZ = math.floor(mobilePosZ * factor) / factor
	self._txtBaseAngle.text = string.format("%s,%s,%s", bx, by, bz)
	self._txtGyrosAngle.text = string.format("%s,%s,%s", gx, gy, gz)
	self._txtGyrosPosMobile.text = string.format("%s,%s,%s", mobilePosX, mobilePosY, mobilePosZ)
end

function M:_getMobilePos()
	if self._isSupport then
		local curMobilePos = Input.acceleration

		return curMobilePos:Get()
	else
		return 0, 0, 0
	end
end

function M:refreshGyroCfgStatus()
	local gyroEventId = self:getGyroEventId()

	goutil.setActive(self._goEchoGyroRoot, gyroEventId == MainPerformEnum.GyrosEventTyp.Echo)
	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_DATA_GET, gyroEventId, self._getDataCallBack, self)
end

function M:_getDataCallBack(dataTable)
	dataTable = dataTable or MainScenePerformUtil.createGyroPerformData()

	if dataTable.angleMaxX ~= nil then
		self._inputGyroMaxAngleX:SetText(string.format("%s", dataTable.angleMaxX))
	end

	if dataTable.angleMaxY ~= nil then
		self._inputGyroMaxAngleY:SetText(string.format("%s", dataTable.angleMaxY))
	end

	if dataTable.filterX ~= nil then
		self._inputGyroFilterX:SetText(string.format("%s", dataTable.filterX))
	end

	if dataTable.filterY ~= nil then
		self._inputGyroFilterY:SetText(string.format("%s", dataTable.filterY))
	end

	if dataTable.durationGetDevice ~= nil then
		self._inputGyroFrameTime:SetText(string.format("%s", dataTable.durationGetDevice))
	end

	if dataTable.durationTween ~= nil then
		self._inputGyroDuration:SetText(string.format("%s", dataTable.durationTween))
	end

	if dataTable.changeRate ~= nil then
		self._inputEchoGyroChangeRate:SetText(string.format("%s", dataTable.changeRate))
	end

	if dataTable.echoTextureRotateLeft ~= nil then
		local progress = dataTable.echoTextureRotateLeft / 360

		self._sliderEchoRotateLeft:SetValue(progress)
	end

	if dataTable.echoTextureRotateRight ~= nil then
		local progress = dataTable.echoTextureRotateRight / 360

		self._sliderEchoRotateRight:SetValue(progress)
	end
end

function M:_getInputNum(input)
	local num = 0

	if input then
		local str = input:GetText()

		if not string.nilorempty(str) then
			num = tonumber(str)
		end
	end

	return num
end

function M:_onClickSaveGyroMaxAngle()
	local gyroEventId = self:getGyroEventId()
	local tableData = {}

	tableData.angleMaxX = self:_getInputNum(self._inputGyroMaxAngleX)
	tableData.angleMaxY = self:_getInputNum(self._inputGyroMaxAngleY)

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_DATA_SET, gyroEventId, tableData)
	settimer(0, function()
		self:refreshGyroCfgStatus()
	end, self, false)
end

function M:_onClickSaveGyroFilter()
	local gyroEventId = self:getGyroEventId()
	local tableData = {}

	tableData.filterX = self:_getInputNum(self._inputGyroFilterX)
	tableData.filterY = self:_getInputNum(self._inputGyroFilterY)

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_DATA_SET, gyroEventId, tableData)
	settimer(0, function()
		self:refreshGyroCfgStatus()
	end, self, false)
end

function M:_onClickSaveGyroFrameTime()
	local gyroEventId = self:getGyroEventId()
	local tableData = {}

	tableData.durationGetDevice = self:_getInputNum(self._inputGyroFrameTime)

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_DATA_SET, gyroEventId, tableData)
	settimer(0, function()
		self:refreshGyroCfgStatus()
	end, self, false)
end

function M:_onClickSaveGyroDuration()
	local gyroEventId = self:getGyroEventId()
	local tableData = {}

	tableData.durationTween = self:_getInputNum(self._inputGyroDuration)

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_DATA_SET, gyroEventId, tableData)
	settimer(0, function()
		self:refreshGyroCfgStatus()
	end, self, false)
end

function M:_onClickSaveEchoGyroChangeRate()
	local gyroEventId = self:getGyroEventId()
	local tableData = {}

	tableData.changeRate = self:_getInputNum(self._inputEchoGyroChangeRate)

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_DATA_SET, gyroEventId, tableData)
	settimer(0, function()
		self:refreshGyroCfgStatus()
	end, self, false)
end

function M:_onClickSaveEchoRotateLR()
	local gyroEventId = self:getGyroEventId()
	local tableData = {}

	tableData.echoTextureRotateLeft = tonumber(self._sliderEchoRotateLeft:GetValue()) * 360
	tableData.echoTextureRotateRight = tonumber(self._sliderEchoRotateRight:GetValue()) * 360

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_DATA_SET, gyroEventId, tableData)
	settimer(0, function()
		self:refreshGyroCfgStatus()
	end, self, false)
end

function M:_onSliderEchoRotateLeft(val)
	local angle = val * 360

	angle = math.floor(angle * 100) / 100
	self._txtEchoRotateLeft.text = string.format("左:%s", angle)
end

function M:_onSliderEchoRotateRight(val)
	local angle = val * 360

	angle = math.floor(angle * 100) / 100
	self._txtEchoRotateRight.text = string.format("右:%s", angle)
end

function M:_onSliderEchoTextureRotatePreview(val)
	local gyroEventId = self:getGyroEventId()

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_ECHO_TEXTURE_SIM, gyroEventId, val)
end

return M
