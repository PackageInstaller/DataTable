-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/MainPerformEditorCamSelectTipsComp.lua

module("logic.extensions.mainui.view.performeditor.comp.MainPerformEditorCamSelectTipsComp", package.seeall)

local M = class("MainPerformEditorCamSelectTipsComp")
local errorState = "--无--"

function M:ctor(mainGo)
	self.mainGO = mainGo.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()

	self._btnCancel = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "ui/btnCancel").gameObject)
	self._btnConfirm = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "ui/btnConfirm").gameObject)
	self._dropDownID = goutil.findChildComponent(mainGO, "ui/dropDown_id", UIComponentType.Dropdown)
	self._dropAdapterID = goutil.findChildComponent(mainGO, "ui/dropDown_id", UIComponentType.DropdownApapter)
	self._txtDropID = goutil.findChildComponent(mainGO, "ui/dropDown_id/Label", UIComponentType.Text)
	self._dropDownName = goutil.findChildComponent(mainGO, "ui/dropDown_name", UIComponentType.Dropdown)
	self._dropAdapterName = goutil.findChildComponent(mainGO, "ui/dropDown_name", UIComponentType.DropdownApapter)
	self._txtDropName = goutil.findChildComponent(mainGO, "ui/dropDown_name/Label", UIComponentType.Text)
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
	self._callBackFunc = nil
	self._callBackHandler = nil
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._dropAdapterID:AddListener(self._onDropDownID, self)
	self._dropAdapterName:AddListener(self._onDropDownName, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._dropAdapterID:RemoveClickListener()
	self._dropAdapterName:RemoveClickListener()
end

function M:getMainGo()
	return self.mainGO
end

function M:onEnter()
	goutil.setActive(self:getMainGo(), true)
end

function M:onExit()
	self._callBackFunc = nil
	self._callBackHandler = nil

	goutil.setActive(self:getMainGo(), false)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:_onClickCancel()
	if self._callBackFunc then
		if self._callBackHandler then
			self._callBackFunc(self._callBackHandler, nil)
		else
			self._callBackFunc(nil)
		end
	end

	self:onExit()
end

function M:_onClickConfirm()
	if self._callBackFunc then
		if self._callBackHandler then
			self._callBackFunc(self._callBackHandler, self._selectState)
		else
			self._callBackFunc(self._selectState)
		end
	end

	self:onExit()
end

function M:show(camCode, callBackFunc, callBackHandler)
	camCode = tonumber(camCode)
	self._callBackFunc = callBackFunc
	self._callBackHandler = callBackHandler
	self._selectState = nil
	self._nameTable = {}
	self._stateTable = {}

	local cfgLst = MainPerformConfig.instance:getConfigList(ConfigName.MainPerformCameraR) or {}

	if #cfgLst > 0 then
		for _, cfg in ipairs(cfgLst) do
			if cfg.id >= 0 then
				table.insert(self._stateTable, cfg.id)
				table.insert(self._nameTable, cfg.name)
			end
		end
	else
		table.insert(self._stateTable, errorState)
		table.insert(self._nameTable, errorState)
	end

	local selectIndex = 0

	for index, nameStr in ipairs(self._stateTable) do
		if tonumber(nameStr) == camCode then
			selectIndex = index - 1
		end
	end

	MainScenePerformUtil.updateDropDownLst(self._dropDownID, self._stateTable)
	MainScenePerformUtil.updateDropDownLst(self._dropDownName, self._nameTable)

	self._callOtherDrop = false
	self._dropDownID.value = selectIndex
	self._dropDownName.value = selectIndex

	self:onEnter()
	self:_onDropDownID(selectIndex)
	self:_onDropDownName(selectIndex)

	self._callOtherDrop = true
end

function M:_onDropDownID(index)
	local state = self._stateTable[index + 1]

	self._txtDropID.text = self._stateTable[index + 1]

	if state == errorState then
		self._selectState = nil
	else
		self._selectState = state
	end

	if self._callOtherDrop then
		self._callOtherDrop = false

		settimer(0, function()
			self._dropDownName.value = index
			self._callOtherDrop = true
		end, self, false)
	end
end

function M:_onDropDownName(index)
	local state = self._stateTable[index + 1]
	local stateName = self._nameTable[index + 1]

	self._txtDropName.text = stateName

	if state == errorState then
		self._selectState = nil
	else
		self._selectState = state
	end

	if self._callOtherDrop then
		self._callOtherDrop = false

		settimer(0, function()
			self._dropDownID.value = index
			self._callOtherDrop = true
		end, self, false)
	end
end

return M
