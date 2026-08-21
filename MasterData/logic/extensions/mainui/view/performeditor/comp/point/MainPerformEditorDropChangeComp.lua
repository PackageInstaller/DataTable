-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/point/MainPerformEditorDropChangeComp.lua

module("logic.extensions.mainui.view.performeditor.comp.point.MainPerformEditorDropChangeComp", package.seeall)

local M = class("MainPerformEditorDropChangeComp", MainPerformEditorCompBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self:getMainGo()

	self._goPrefabItem = goutil.findChild(mainGO, "item_ani").gameObject
	self._dropDownHero = goutil.findChildComponent(mainGO, "content/hero/dropDown", UIComponentType.Dropdown)
	self._dropAdapterHero = goutil.findChildComponent(mainGO, "content/hero/dropDown", UIComponentType.DropdownApapter)
	self._txtDropHero = goutil.findChildComponent(mainGO, "content/hero/dropDown/Label", UIComponentType.Text)
	self._inputAnimMixDuration = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "title2/input_animMixDuration").gameObject)

	self._inputAnimMixDuration:SetText(MainPerformEnum.AnimDefaultMixDuration)
	goutil.setActive(self._goPrefabItem, false)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._dropDownHero = nil
	self._dropAdapterHero = nil
	self._txtDropHero = nil

	self:_clearItems()
	self:setEvent(false)
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._dropAdapterHero:AddListener(self._onDropDownHero, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._dropAdapterHero:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)
	self:refreshDropHero()
	self:refreshAniItems()
	self:setEvent(true)
end

function M:onExit()
	M.super.onExit(self)
	self:startPlayAniSliderAutoUpdate(false)
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._handleAnimPlay, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._handleAnimPlay, self)
	end
end

function M:canShow()
	return self:getPoint() >= 0
end

function M:onEditHeroChange(heroId)
	self:startPlayAniSliderAutoUpdate(false)

	if self:getMainGo().activeSelf then
		settimer(0.1, function()
			self:refreshDropHero()
			self:refreshAniItems()
		end, self, false)
	end
end

function M:dispatcherHeroChange(heroId)
	local handler = self:getHandler()

	if handler then
		handler:handleMainSceneUnitLoad(nil, self:getPoint(), heroId)
	end
end

function M:_handleAnimPlay(e, pointId, elementId, heroId, animState, isInterrupt)
	if self:getPoint() ~= pointId then
		return
	end

	if not self._sliderAutoUpdateIndex then
		return
	end

	local index = self._sliderAutoUpdateIndex or -1

	self:startPlayAniSliderAutoUpdate(false)

	local item = self._itemLst[index]

	if item then
		local unitHero = self:_getUnitHero()

		if unitHero then
			item.blockSliderEvent = true

			self:setPlayingAniProgress(0)
			item.sliderFrame:SetValue(self:getPlayingAniProgress())

			item.blockSliderEvent = false
		end
	end
end

function M:refreshDropHero()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local point = self:getPoint()
	local heroId = 0
	local modelId = 0
	local unitHero = self:_getUnitHero()

	if unitHero then
		heroId = unitHero:getHeroId()
		modelId = unitHero:getModelId()
	end

	local selectIndex = 1

	self._heroNamesDrop = {}
	self._heroIds, self._heroNames, self._modelIds, self._skinIds, self._skinNames = MainScenePerformUtil.getHeroDropLstData(point)

	for _index, _str in ipairs(self._heroNames) do
		local _modelId = self._modelIds[_index]
		local _skinName = self._skinNames[_index]
		local _name = string.nilorempty(_skinName) and string.format("%s %s", _modelId, _str) or string.format("%s %s-%s", _modelId, _str, _skinName)

		table.insert(self._heroNamesDrop, _name)
	end

	MainScenePerformUtil.updateDropDownLst(self._dropDownHero, self._heroNamesDrop)

	if modelId and modelId > 0 then
		selectIndex = table.indexof(self._modelIds, modelId) or 1
	end

	self._dropAdapterHero:RemoveClickListener()

	self._dropDownHero.value = selectIndex - 1

	self._dropAdapterHero:AddListener(self._onDropDownHero, self)

	self._txtDropHero.text = self._heroNamesDrop[selectIndex]
end

function M:_onDropDownHero(index)
	local newHeroId = self._heroIds and self._heroIds[index + 1] or nil
	local newModelId = self._modelIds and self._modelIds[index + 1] or nil
	local newSkinId = self._skinIds and self._skinIds[index + 1] or nil

	if not newHeroId then
		printWarn(string.format("无法定位index[%s]对应的heroId", index))

		return
	end

	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)
	local heroId = unitHero and unitHero:getHeroId() or 0
	local modelId = unitHero and unitHero:getModelId() or 0

	if modelId == newModelId then
		return
	end

	if newHeroId and newHeroId > 0 then
		self:_clearItems()

		local forceSet = true
		local prefix, mixDuration
		local isChange = false

		MainScenePerformUtil.changeHeroReq(point, newHeroId, newSkinId, forceSet, prefix, mixDuration, isChange)

		if ViewMgr.instance:isOpen(ViewName.CharacterMainSystemViewNew) then
			local subPageIndex = CharacterSystemModel.instance:getPageIndex()

			MainScenePerformUtil.viewCamCtrl(ViewName.CharacterMainSystemViewNew, subPageIndex, true, true, newHeroId, newModelId)
		elseif ViewMgr.instance:isOpen(ViewName.CharacterDepotMainViewNew) then
			MainScenePerformUtil.viewCamCtrl(ViewName.CharacterDepotMainViewNew, 1, true, true, newHeroId, newModelId)
		end
	else
		local curSceneFlow = SceneFace.instance:getCurSceneFlow()

		curSceneFlow.unitFactory:removeUnitHeroByPoint(point)
		self:_clearItems()
	end

	self._txtDropHero.text = self._heroNamesDrop[index + 1]
end

function M:refreshAniItems()
	self._stateTable = {}
	self._stateDuration = {}
	self._stateTotalFrameLst = {}

	if SceneFace.instance:isCurScene(SceneType.Room) then
		local unitHero = self:_getUnitHero()

		if unitHero then
			local tmpAniNames = {}
			local meshModel = unitHero.meshModel
			local animPlayer = meshModel:getAnimationPlayer()

			if animPlayer then
				animPlayer:GetAnimationNamesLua(tmpAniNames)

				for _, animState in ipairs(tmpAniNames or {}) do
					table.insert(self._stateTable, animState)

					local duration = animPlayer:GetAnimationDuration(animState) or 0

					table.insert(self._stateDuration, duration)

					local totalFrame = math.ceil(duration * MainPerformEnum.AnimFPS)

					table.insert(self._stateTotalFrameLst, totalFrame)
				end
			end
		end
	end

	self:_clearItems()

	local len = #self._stateTable

	if len > 0 then
		for i = 1, len do
			self:_addItem(#self._itemLst + 1)
		end
	end

	for index, value in ipairs(self._stateTable or {}) do
		local cell = self._itemLst[index]

		cell.updateData(index, value)

		cell.blockSliderEvent = true

		cell.sliderFrame:SetValue(0)

		cell.blockSliderEvent = false
		cell.txtSliderFrame.text = string.format("0/%s", self._stateTotalFrameLst[index] or 0)
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
	self:startPlayAniSliderAutoUpdate(false)

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
	data.blockSliderEvent = false
	data.txtName = goutil.findChildTextComponent(go, "txt")
	data.btnPlayAni = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnPlayAni").gameObject)
	data.sliderFrame = UIComponentType.SliderAdapter(goutil.findChild(go, "Slider").gameObject)
	data.txtSliderFrame = goutil.findChildTextComponent(go, "Slider/txtFrame")

	data.btnPlayAni:AddClickListener(function()
		self:_onCellClickPlayAni(index)
	end, self)
	data.sliderFrame:AddOnValueChanged(function(handler, val)
		self:_onCellAniOnValueChanged(index, val)
	end, self)

	function data.destroyUI()
		data.btnPlayAni:RemoveClickListener()
		data.sliderFrame:RemoveOnValueChanged()
	end

	function data.updateData(_index, animState)
		data.index = _index
		data.txtName.text = animState
	end

	return data
end

function M:resetItemSlider(exceptIndex)
	for index, cell in ipairs(self._itemLst or {}) do
		if index ~= exceptIndex then
			cell.blockSliderEvent = true

			cell.sliderFrame:SetValue(0)

			cell.blockSliderEvent = false
		end
	end
end

function M:_onCellClickPlayAni(index)
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local unitHero = self:_getUnitHero()

	if unitHero then
		local heroId = unitHero:getHeroId()
		local animName = self._stateTable[index]
		local isLoop = false
		local isForceRestart = false
		local mixDuration = self:_getInputNum(self._inputAnimMixDuration, MainPerformEnum.AnimDefaultMixDuration)

		MainScenePerformUtil.heroAnimPlay(heroId, animName, isLoop, isForceRestart, mixDuration)
		self:setPlayingAniProgress(0)
		self:resetItemSlider()
		self:startPlayAniSliderAutoUpdate(true, index)
	end
end

function M:startPlayAniSliderAutoUpdate(active, index)
	removetimer(self._timerAutoUpdateSlider, self)

	if active then
		self._sliderAutoUpdateIndex = index

		settimer(0.1, self._timerAutoUpdateSlider, self, true)
	else
		self._sliderAutoUpdateIndex = nil
	end
end

function M:_timerAutoUpdateSlider()
	local index = self._sliderAutoUpdateIndex or -1
	local item = self._itemLst[index]

	if item then
		local unitHero = self:_getUnitHero()

		if unitHero then
			local curTime = unitHero.meshModel:getTime()
			local totalTime = self._stateDuration[index]

			totalTime = totalTime <= 0 and 1 or totalTime

			self:setPlayingAniProgress(curTime / totalTime)

			local progress = self:getPlayingAniProgress()

			item.sliderFrame:SetValue(self:getPlayingAniProgress())

			if progress >= 1 then
				self:startPlayAniSliderAutoUpdate(false)
			end
		end
	end
end

function M:getPlayingAniProgress()
	return self._playingProgress or 0
end

function M:setPlayingAniProgress(val)
	self._playingProgress = val
end

function M:_onCellAniOnValueChanged(index, val)
	local totalFrame = self._stateTotalFrameLst[index] or 0
	local sliderFrame = math.ceil(val * totalFrame)
	local item = self._itemLst[index]

	if item then
		self._itemLst[index].txtSliderFrame.text = string.format("%s/%s", sliderFrame, totalFrame)
	else
		return
	end

	if item.blockSliderEvent then
		return
	end

	local playingProgress = self:getPlayingAniProgress()

	if math.abs(math.floor(val * 10000) - math.floor(playingProgress * 10000)) > 1 then
		self:startPlayAniSliderAutoUpdate(false)
		self:resetItemSlider(index)
	end

	if self._sliderAutoUpdateIndex then
		return
	end

	local unitHero = self:_getUnitHero()

	if unitHero then
		local meshModel = unitHero.meshModel
		local animPlayer = meshModel:getAnimationPlayer()
		local curTime = val * self._stateDuration[index]
		local animState = self._stateTable[index]
		local curPlayAnimState = unitHero.animCtrl:getCurPlayingAniStateFullName()

		if not curPlayAnimState or curPlayAnimState ~= animState then
			animPlayer:SetFrozen(false)

			local isSpAniState = true
			local isInterrupt = true

			unitHero.animCtrl:playFullNameAni(animState, isSpAniState, isInterrupt)
		end

		meshModel:jumpToTime(curTime)
	end
end

function M:_getUnitHero()
	local point = self:getPoint()

	return MainScenePerformUtil.getUnitHeroByPoint(point)
end

function M:_getInputNum(input, fallBackNum)
	local num = fallBackNum

	if input then
		local str = input:GetText()

		if not string.nilorempty(str) then
			num = tonumber(str)
		end
	end

	return num
end

return M
