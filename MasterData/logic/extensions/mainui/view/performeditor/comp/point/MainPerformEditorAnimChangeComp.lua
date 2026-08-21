-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/point/MainPerformEditorAnimChangeComp.lua

module("logic.extensions.mainui.view.performeditor.comp.point.MainPerformEditorAnimChangeComp", package.seeall)

local M = class("MainPerformEditorAnimChangeComp", MainPerformEditorCompBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self:getMainGo()

	self._goPrefabItem = goutil.findChild(mainGO, "item_aniSelect").gameObject

	goutil.setActive(self._goPrefabItem, false)

	self._btnExcute = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnExcute").gameObject)
	self._btnAdd = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnAdd").gameObject)
end

function M:destroyUI()
	M.super.destroyUI(self)
	removetimer(self.refreshView, self)

	self._btnExcute = nil
	self._btnAdd = nil
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnExcute:AddClickListener(self._onClickExcute, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnExcute:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)
	self:refreshView()
end

function M:onExit()
	M.super.onExit(self)
	removetimer(self.refreshView, self)
end

function M:canShow()
	return self:getPoint() == 0
end

function M:IsDataDirty()
	return false
end

function M:onEditHeroChange(heroId)
	settimer(0.3, self.refreshView, self, false)
end

function M:getHeroUnit()
	local point = self:getPoint()

	return MainScenePerformUtil.getUnitHeroByPoint(point)
end

function M:refreshView()
	local point = self:getPoint()

	if point ~= MainPerformEnum.ElementPointAdjutant then
		return
	end

	if self:getMainGo() and self:getMainGo().activeSelf then
		self:_clearItems()
	end
end

function M:_onClickExcute()
	local unitHero = self:getHeroUnit()

	if unitHero then
		local heroId = unitHero:getHeroId()
		local len = self._animStep and #self._animStep or 0

		if len > 0 then
			local animationPlayer = unitHero.meshModel:getAnimationPlayer()
			local isForceRestart = true
			local mixDuration

			unitHero.meshModel:playFullNameAni(self._animStep[1].name, mixDuration, isForceRestart)

			local finalLst = {}

			for _index, value in ipairs(self._animStep) do
				if _index > 1 then
					table.insert(finalLst, value.name)
				end
			end

			table.insert(finalLst, self._animStep[1].name)

			local animStepStr = table.concat(finalLst, "#")

			printWarn("animStepStr:", animStepStr)

			if not string.nilorempty(animStepStr) then
				unitHero.animCtrl:setAnimStepStr(animStepStr)
			end

			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_EDITOR_HIDE, true)
		end
	end
end

function M:_onClickAdd()
	local point = self:getPoint()
	local unitHero = self:getHeroUnit()

	if unitHero then
		local heroId = unitHero:getHeroId()
		local handler = self:getHandler()

		if handler then
			handler:openAniSelectTips(point, heroId, nil, false, nil, function(handler, animState)
				if animState then
					local _animState = animState

					if not self._animStep then
						self._animStep = {}
					end

					table.insert(self._animStep, {
						name = _animState,
						mixDuration = MainPerformEnum.AnimDefaultMixDuration
					})

					if not self._itemLst then
						self._itemLst = {}
					end

					local newIndex = #self._itemLst + 1

					self:_addItem(newIndex)
					self._itemLst[newIndex].updateData(newIndex, self._animStep[newIndex])
				else
					printWarn("取消")
				end
			end, self)
		end
	end
end

function M:_refreshItemLst()
	self:_clearItems()

	local len = #self._animStep

	if len > 0 then
		local mainGO = self:getMainGo()

		for i = 1, len do
			self:_addItem(#self._itemLst + 1)
		end
	end

	for index, value in ipairs(self._animStep or {}) do
		self._itemLst[index].updateData(index, value)
	end
end

function M:_addItem(index)
	if self._itemLst[index] then
		printError("已有index:", index)
	else
		local mainGO = self:getMainGo()
		local go = goutil.cloneAndSetParent(self._goPrefabItem, mainGO.transform)
		local cell = self:_buildItem(go, index)

		goutil.setActive(go, true)

		self._itemLst[index] = cell
	end
end

function M:_clearItems()
	for index, cell in ipairs(self._itemLst or {}) do
		cell.destroyUI()
		goutil.destroy(cell.go)
	end

	self._itemLst = {}
end

function M:_buildItem(go, index)
	local data = {}

	data.go = go
	data.index = index
	data.txtIndex = goutil.findChildTextComponent(go, "step")
	data.txtAniName = goutil.findChildTextComponent(go, "btnAni/txt")
	data.btnPlayAni = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnPlayAni").gameObject)
	data.btnAni = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnAni").gameObject)
	data.btnMinus = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnMinus"))
	data.inputDuration = UIComponentType.InputFieldAdapter(goutil.findChild(go, "input_animMixDuration"))
	data.txtIndex.text = index

	data.btnPlayAni:AddClickListener(function()
		self:_onCellClickPlayAni(index)
	end, self)
	data.btnAni:AddClickListener(function()
		self:_onCellClickAni(index)
	end, self)
	data.btnMinus:AddClickListener(function()
		self:_onCellClickMinus(index)
	end, self)
	data.inputDuration:AddOnEndEdit(function(handler, str)
		self:_onInputEndCellDuration(index, str)
	end, self)

	function data.destroyUI()
		data.btnPlayAni:RemoveClickListener()
		data.btnAni:RemoveClickListener()
		data.btnMinus:RemoveClickListener()
		data.inputDuration:RemoveOnEndEdit()
	end

	function data.updateData(_index, animStepData)
		data.index = _index
		data.txtIndex.text = _index
		data.txtAniName.text = animStepData.name

		data.inputDuration:SetText(animStepData.weightCount)
	end

	function data.updateAniState(animState)
		data.txtAniName.text = animState
	end

	function data.changeDuration(duration)
		duration = tonumber(duration)
		duration = duration or MainPerformEnum.AnimDefaultMixDuration
		duration = duration < 0 and 0 or duration

		data.inputDuration:SetText(duration)

		return duration
	end

	return data
end

function M:_onCellClickPlayAni()
	return
end

function M:_onCellClickAni(index)
	local point = self:getPoint()
	local unitHero = self:getHeroUnit()

	if unitHero then
		local heroId = unitHero:getHeroId()
		local handler = self:getHandler()

		if handler then
			local stateName = self._animStep[index].name

			handler:openAniSelectTips(point, heroId, stateName, false, nil, function(handler, animState)
				if animState then
					local _animState = animState

					self._itemLst[index].updateAniState(_animState)

					self._animStep[index].name = _animState
				else
					printWarn("取消")
				end
			end, self)
		end
	end
end

function M:_onCellClickMinus(index)
	local t = {}

	for i, value in ipairs(self._animStep) do
		if i ~= index then
			table.insert(t, value)
		end
	end

	self._animStep = t

	self:_refreshItemLst()
end

function M:_onInputEndCellDuration(index, str)
	local mixDuration = self._itemLst[index].changeDuration(str)

	self._animStep[index].mixDuration = mixDuration
end

return M
