-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/preview/MainPerformEditorPreviewCamComp.lua

module("logic.extensions.mainui.view.performeditor.comp.preview.MainPerformEditorPreviewCamComp", package.seeall)

local M = class("MainPerformEditorPreviewCamComp", MainPerformEditorCompBase)
local kCameraConfigName = ConfigName.CharacterPreviewCamInfo

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	local compGo = self:getMainGo()
	local mainGo = goutil.findChild(compGo, "select")

	self._dropDownID = goutil.findChildComponent(mainGo, "dropDown_id", UIComponentType.Dropdown)
	self._dropAdapterID = goutil.findChildComponent(mainGo, "dropDown_id", UIComponentType.DropdownApapter)
	self._txtDropID = goutil.findChildComponent(mainGo, "dropDown_id/Label", UIComponentType.Text)
	self._dropDownName = goutil.findChildComponent(mainGo, "dropDown_name", UIComponentType.Dropdown)
	self._dropAdapterName = goutil.findChildComponent(mainGo, "dropDown_name", UIComponentType.DropdownApapter)
	self._txtDropName = goutil.findChildComponent(mainGo, "dropDown_name/Label", UIComponentType.Text)
	self._btnGet = UIComponentType.ButtonAdapter(goutil.findChild(mainGo, "btnGet"))
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(mainGo, "btnSave"))
	self._btnDelete = UIComponentType.ButtonAdapter(goutil.findChild(mainGo, "btnDelete"))

	local goPos = goutil.findChild(mainGo, "position")
	local goRot = goutil.findChild(mainGo, "rotation")

	self._posCell = Astral.SimpleLuaComponentContainer.Add(goPos, MainPerformEditorVec3Cell)
	self._rotCell = Astral.SimpleLuaComponentContainer.Add(goRot, MainPerformEditorVec3Cell)
	self._textFov = UIComponentType.InputFieldAdapter(goutil.findChild(mainGo, "fov/fov"))
	self._inputSaveCamCode = UIComponentType.InputFieldAdapter(goutil.findChild(mainGo, "btnSave/input_camCode"))
	self._inputSaveCamName = UIComponentType.InputFieldAdapter(goutil.findChild(mainGo, "btnSave/input_name"))
end

function M:bindEvents()
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._dropAdapterID:AddListener(self._onDropDownID, self)
	self._dropAdapterName:AddListener(self._onDropDownName, self)
end

function M:unbindEvents()
	self._btnGet:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._dropAdapterID:RemoveClickListener()
	self._dropAdapterName:RemoveClickListener()
end

function M:onEnter()
	self:refreshView()
end

function M:onExit()
	return
end

function M:refreshView()
	local selectIndex = 0

	self._codeLst = {}
	self._nameLst = {}
	self._camConfig = CharacterPreviewConfig.instance:getConfig(kCameraConfigName)
	self._camCoList = CharacterPreviewConfig.instance:getConfigList(kCameraConfigName) or {}

	for _, camCo in ipairs(self._camCoList) do
		table.insert(self._codeLst, camCo.id)
		table.insert(self._nameLst, camCo.name)
	end

	MainScenePerformUtil.updateDropDownLst(self._dropDownID, self._codeLst)
	MainScenePerformUtil.updateDropDownLst(self._dropDownName, self._nameLst)

	self._dropDownID.value = selectIndex
	self._dropDownName.value = selectIndex

	self:_onDropDownID(selectIndex)
	self:_onDropDownName(selectIndex)
end

function M:_onDropDownID(index)
	self:_onSelectChange(index)
end

function M:_onDropDownName(index)
	self:_onSelectChange(index)
end

function M:_onSelectChange(index)
	local realIndex = index + 1

	self._camCode = self._codeLst[realIndex]

	local camName = self._nameLst[realIndex]

	self._txtDropID.text = self._camCode
	self._txtDropName.text = camName

	self._inputSaveCamCode:SetText(self._camCode)
	self._inputSaveCamName:SetText(camName)

	local camCo = self:_getCamCo(realIndex)

	self._posCell:setVec3(camCo.pos)
	self._rotCell:setVec3(camCo.rot)
	self._textFov:SetText(camCo.fov)
	GlobalDispatcher:dispatchEvent(EventType.HERO_PREVIEW_CAM_CTRL, camCo)
end

function M:_getCamCo(index)
	local code = self._codeLst[index]

	return self:_getCamCoById(code)
end

function M:_getCamCoById(code)
	return self._camConfig[code]
end

function M:_onClickGet()
	local cameraUnit = MainScenePerformUtil.getPreviewCameraUnit()

	if cameraUnit == nil then
		FloatWordMgr.instance:show("请在角色预览界面中编辑")

		return
	end

	local goCam = cameraUnit:getMainGO()
	local cameraFollow = VirtualCameraMgr.instance:internal_getCameraFollow()
	local pos = Vector3.New(cameraFollow:getTargetPosition())

	pos = MainScenePerformUtil.formatVec3(pos, false)

	local rot = MainScenePerformUtil.formatVec3(goCam.transform.localEulerAngles, true)
	local fov = cameraUnit:getFieldOfView()

	self._posCell:setVec3(pos)
	self._rotCell:setVec3(rot)
	self._textFov:SetText(fov)
end

function M:_onClickSave()
	local id = self._inputSaveCamCode:GetText()

	if string.nilorempty(id) then
		FloatWordMgr.instance:show("请先输入ID")

		return
	end

	id = tonumber(id)

	local name = self._inputSaveCamName:GetText() or ""
	local dialogContent
	local camCo = self:_getCamCoById(id)

	if camCo == nil then
		dialogContent = string.format("新建镜头[%s] 名字[%s] 的配置?", id, name)
	else
		dialogContent = string.format("覆盖镜头[%s] 名字[%s] 的配置?", id, camCo.name)
	end

	local dialog = Dialog.showMessage("提示", dialogContent)

	dialog:setConfirmListener(function()
		local pos = self._posCell:getVec3()
		local rot = self._rotCell:getVec3()
		local fov = self._textFov:GetText()

		MainScenePerformUtil.changeOrCreateLuaCfg(kCameraConfigName, CharacterPreviewConfig.instance, id, {
			pos = pos,
			rot = rot,
			fov = fov,
			name = name
		})
		self:refreshView()
	end, self)
end

function M:_onClickDelete()
	local id = self._inputSaveCamCode:GetText()

	if string.nilorempty(id) then
		FloatWordMgr.instance:show("请先输入删除ID")

		return
	end

	id = tonumber(id)

	local camName = self._inputSaveCamName:GetText()

	if id <= 1 then
		FloatWordMgr.instance:show(string.format("镜头[%s] 名字[%s] 为默认镜头，不能删除", id, camName))

		return
	end

	local dialog = Dialog.showMessage("提示", string.format("删除镜头[%s] 名字[%s]的配置？", id, camName))

	dialog:setConfirmListener(function()
		MainScenePerformUtil.deleteLuaCfg(kCameraConfigName, CharacterPreviewConfig.instance, id)
		self:refreshView()
	end, self)
end

return M
