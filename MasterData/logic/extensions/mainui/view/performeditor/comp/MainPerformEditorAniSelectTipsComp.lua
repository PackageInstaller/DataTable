-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/MainPerformEditorAniSelectTipsComp.lua

module("logic.extensions.mainui.view.performeditor.comp.MainPerformEditorAniSelectTipsComp", package.seeall)

local M = class("MainPerformEditorAniSelectTipsComp")
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
	self._dropDown = goutil.findChildComponent(mainGO, "ui/dropDown", UIComponentType.Dropdown)
	self._dropAdapter = goutil.findChildComponent(mainGO, "ui/dropDown", UIComponentType.DropdownApapter)
	self._txtDrop = goutil.findChildComponent(mainGO, "ui/dropDown/Label", UIComponentType.Text)
	self._txtTitle = goutil.findChildComponent(mainGO, "ui/txtTitle", UIComponentType.Text)
	self._txtOtherName = goutil.findChildComponent(mainGO, "ui/txtOtherName", UIComponentType.Text)
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
	self._dropAdapter:AddListener(self._onDropDownAni, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._dropAdapter:RemoveClickListener()
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

function M:show(point, heroId, defaultState, onlyFliterElement, filterMatchStr, callBackFunc, callBackHandler)
	heroId = heroId or -1
	self._txtTitle.text = "请选择动画"
	self._callBackFunc = callBackFunc
	self._callBackHandler = callBackHandler
	self._selectState = nil

	if heroId <= 0 then
		self:_onClickCancel()
		FloatWordMgr.instance:show(string.format("交互点[%s]无有效角色，无需操作", point))

		return
	end

	local hasfilterMatchStr = not string.nilorempty(filterMatchStr)

	local function isFilterStrMatch(str)
		if hasfilterMatchStr then
			return string.match(str, filterMatchStr)
		end

		return true
	end

	self._nameTable = {}
	self._stateTable = {}

	local tag = point == 0 and UnitTag.Player or UnitTag.Npc
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local unitHero = curSceneFlow.unitFactory:getUnitHero(tag, heroId)

	if unitHero then
		local tmpAniNames = {}
		local meshModel = unitHero.meshModel
		local animPlayer = meshModel:getAnimationPlayer()

		animPlayer:GetAnimationNamesLua(tmpAniNames)

		for _, animState in ipairs(tmpAniNames or {}) do
			if isFilterStrMatch(animState) then
				if onlyFliterElement then
					if string.match(animState, meshModel:getAnimPrefix()) then
						local arrStep = string.split(animState, "_")
						local stateWithoutPrefix = arrStep[2]

						table.insert(self._nameTable, stateWithoutPrefix)
						table.insert(self._stateTable, animState)
					end
				else
					local arrStep = string.split(animState, "_")
					local stateWithoutPrefix = arrStep[2]

					table.insert(self._nameTable, stateWithoutPrefix)
					table.insert(self._stateTable, animState)
				end
			end
		end
	else
		table.insert(self._nameTable, errorState)
		table.insert(self._stateTable, errorState)
		printError(string.format("无法找到交互点[%s] 角色[%s]", point, heroId))
	end

	local selectIndex = 0

	if not string.nilorempty(defaultState) then
		for index, stateStr in ipairs(self._nameTable or {}) do
			if stateStr == defaultState then
				selectIndex = index - 1
			end
		end
	end

	MainScenePerformUtil.updateDropDownLst(self._dropDown, self._stateTable)

	self._dropDown.value = selectIndex

	self:onEnter()
	self:_onDropDownAni(selectIndex)
end

function M:_onDropDownAni(index)
	local state = self._stateTable[index + 1]
	local stateName = self._nameTable[index + 1]

	self._txtDrop.text = state
	self._txtOtherName.text = state

	if state == errorState then
		self._selectState = nil
	else
		self._selectState = state
	end
end

return M
