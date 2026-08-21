-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/preview/MainPerformEditorPreviewPosComp.lua

module("logic.extensions.mainui.view.performeditor.comp.preview.MainPerformEditorPreviewPosComp", package.seeall)

local M = class("MainPerformEditorPreviewPosComp", MainPerformEditorCompBase)
local kPositionConfigName = ConfigName.CharacterPreviewPosInfo

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	local compGo = self:getMainGo()
	local mainGo = goutil.findChild(compGo, "content")

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
	self._inputSavePosCode = UIComponentType.InputFieldAdapter(goutil.findChild(mainGo, "btnSave/input_camCode"))
	self._inputSavePosName = UIComponentType.InputFieldAdapter(goutil.findChild(mainGo, "btnSave/input_name"))
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
	self._posConfig = CharacterPreviewConfig.instance:getConfig(kPositionConfigName)
	self._posCoList = CharacterPreviewConfig.instance:getConfigList(kPositionConfigName) or {}

	for _, posCo in ipairs(self._posCoList) do
		table.insert(self._codeLst, posCo.id)
		table.insert(self._nameLst, posCo.name)
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

	self._posCode = self._codeLst[realIndex]

	local posName = self._nameLst[realIndex]

	self._txtDropID.text = self._posCode
	self._txtDropName.text = posName

	self._inputSavePosCode:SetText(self._posCode)
	self._inputSavePosName:SetText(posName)

	local posCo = self:_getPosCo(realIndex)

	self._posCell:setVec3(posCo.pos)
	self._rotCell:setVec3(posCo.rot)
	GlobalDispatcher:dispatchEvent(EventType.HERO_PREVIEW_POS_CTRL, posCo)
end

function M:_getPosCo(index)
	local code = self._codeLst[index]

	return self:_getPosCoById(code)
end

function M:_getPosCoById(code)
	return self._posConfig[code]
end

function M:_onClickGet()
	local goHero = MainScenePerformUtil.getPreviewHero()

	if goHero == nil then
		FloatWordMgr.instance:show("请在角色预览界面中编辑")

		return
	end

	local pos = MainScenePerformUtil.formatVec3(goHero.transform.localPosition, false)
	local rot = MainScenePerformUtil.formatVec3(goHero.transform.localEulerAngles, true)

	self._posCell:setVec3(pos)
	self._rotCell:setVec3(rot)
end

function M:_onClickSave()
	local id = self._inputSavePosCode:GetText()

	if string.nilorempty(id) then
		FloatWordMgr.instance:show("请先输入ID")

		return
	end

	id = tonumber(id)

	local name = self._inputSavePosName:GetText() or ""
	local dialogContent
	local posCo = self:_getPosCoById(id)

	if posCo == nil then
		dialogContent = string.format("新建位置[%s] 名字[%s] 的配置?", id, name)
	else
		dialogContent = string.format("覆盖位置[%s] 名字[%s] 的配置?", id, posCo.name)
	end

	local dialog = Dialog.showMessage("提示", dialogContent)

	dialog:setConfirmListener(function()
		local pos = self._posCell:getVec3()
		local rot = self._rotCell:getVec3()

		MainScenePerformUtil.changeOrCreateLuaCfg(kPositionConfigName, CharacterPreviewConfig.instance, id, {
			pos = pos,
			rot = rot,
			name = name
		})
		self:refreshView()
	end, self)
end

function M:_onClickDelete()
	local id = self._inputSavePosCode:GetText()

	if string.nilorempty(id) then
		FloatWordMgr.instance:show("请先输入删除ID")

		return
	end

	id = tonumber(id)

	local posName = self._inputSavePosName:GetText()

	if id <= 1 then
		FloatWordMgr.instance:show(string.format("位置[%s] 名字[%s] 为默认位置，不能删除", id, posName))

		return
	end

	local dialog = Dialog.showMessage("提示", string.format("删除位置[%s] 名字[%s]的配置？", id, posName))

	dialog:setConfirmListener(function()
		MainScenePerformUtil.deleteLuaCfg(kPositionConfigName, CharacterPreviewConfig.instance, id)
		self:refreshView()
	end, self)
end

return M
