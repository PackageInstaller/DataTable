-- chunkname: @modules/logic/gm/view/GMPostProcessItem.lua

module("modules.logic.gm.view.GMPostProcessItem", package.seeall)

local GMPostProcessItem = class("GMPostProcessItem", MixScrollCell)

function GMPostProcessItem:init(go)
	self._ppvolumeWrap = gohelper.findChildComponent(CameraMgr.instance:getUnitCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)
	self._ppvolumeWrap.refresh = true
	self._go = go
	self._tr = go.transform
	self._togglePrefab = gohelper.findChild(go, "toggle")
	self._sliderPrefab = gohelper.findChild(go, "slider")
	self._vector2Prefab = gohelper.findChild(go, "vector2")
	self._colorPrefab = gohelper.findChild(go, "color")

	gohelper.setActive(self._togglePrefab, false)
	gohelper.setActive(self._sliderPrefab, false)
	gohelper.setActive(self._vector2Prefab, false)
	gohelper.setActive(self._colorPrefab, false)

	self._typePrefabs = {
		bool = self._togglePrefab,
		float = self._sliderPrefab,
		int = self._sliderPrefab,
		Vector2 = self._vector2Prefab,
		Color = self._colorPrefab
	}
	self._itemGOs = {}
end

function GMPostProcessItem:removeEventListeners()
	for _, itemGO in ipairs(self._itemGOs) do
		local toggle = gohelper.findChildToggle(itemGO, "Toggle")
		local slider = gohelper.findChildSlider(itemGO, "Slider")
		local inpx = gohelper.findChildTextMeshInputField(itemGO, "inpx")
		local inpy = gohelper.findChildTextMeshInputField(itemGO, "inpy")
		local inp = gohelper.findChildTextMeshInputField(itemGO, "inp")

		if toggle then
			toggle:RemoveOnValueChanged()
		end

		if slider then
			slider:RemoveOnValueChanged()
		end

		if inpx then
			inpx:RemoveOnValueChanged()
		end

		if inpy then
			inpy:RemoveOnValueChanged()
		end

		if inp then
			inp:RemoveOnValueChanged()
		end
	end
end

function GMPostProcessItem:onUpdateMO(mo, mixType, param)
	recthelper.setHeight(self._tr, param)

	self._mo = mo

	for i, interfaceMO in ipairs(mo) do
		local func = GMPostProcessItem["_update" .. interfaceMO.type]

		if func then
			local itemGO = self._itemGOs[i]

			if not itemGO then
				itemGO = gohelper.cloneInPlace(self._typePrefabs[interfaceMO.type], i)

				table.insert(self._itemGOs, itemGO)
				gohelper.setActive(itemGO, true)
			end

			func(self, i, itemGO, interfaceMO)

			local splitGO = gohelper.findChild(itemGO, "split")

			gohelper.setActive(splitGO, i ~= #mo)
		else
			logError("fuck no type function: " .. interfaceMO.type)
		end
	end
end

function GMPostProcessItem:_updatebool(index, itemGO, mo)
	local toggle = gohelper.findChildToggle(itemGO, "Toggle")

	local function toggleValueChanged(self, params, isOn)
		self:_setPPValue(mo.val, isOn)
	end

	toggle:AddOnValueChanged(toggleValueChanged, self)

	local text = gohelper.findChildText(itemGO, "Text")

	text.text = mo.name
	toggle.isOn = self:_getPPValue(mo.val)
end

function GMPostProcessItem:_updatefloat(index, itemGO, mo)
	local slider = gohelper.findChildSlider(itemGO, "Slider")
	local sliderText = gohelper.findChildText(itemGO, "Slider/Text")

	local function sliderChangeFunc(self, params, value)
		self:_setPPValue(mo.val, value)

		sliderText.text = string.format("%.2f", value)
	end

	slider:AddOnValueChanged(sliderChangeFunc, self)

	slider.slider.wholeNumbers = false
	slider.slider.minValue = mo.min
	slider.slider.maxValue = mo.max

	local text = gohelper.findChildText(itemGO, "Text")

	text.text = mo.name

	local value = self:_getPPValue(mo.val)

	slider:SetValue(value)

	sliderText.text = string.format("%.2f", value)
end

function GMPostProcessItem:_updateint(index, itemGO, mo)
	local slider = gohelper.findChildSlider(itemGO, "Slider")
	local sliderText = gohelper.findChildText(itemGO, "Slider/Text")

	local function sliderChangeFunc(self, params, value)
		self:_setPPValue(mo.val, value)

		sliderText.text = string.format("%d", value)
	end

	slider:AddOnValueChanged(sliderChangeFunc, self)

	slider.slider.wholeNumbers = true
	slider.slider.minValue = mo.min
	slider.slider.maxValue = mo.max

	local text = gohelper.findChildText(itemGO, "Text")

	text.text = mo.name

	local value = self:_getPPValue(mo.val)

	slider:SetValue(value)

	sliderText.text = string.format("%d", value)
end

function GMPostProcessItem:_updateVector2(index, itemGO, mo)
	local inpx = gohelper.findChildTextMeshInputField(itemGO, "inpx")
	local inpy = gohelper.findChildTextMeshInputField(itemGO, "inpy")

	local function inputChangeFunc(self, value)
		local x = tonumber(inpx:GetText()) or 0
		local y = tonumber(inpy:GetText()) or 0

		self:_setPPValue(mo.val, Vector2.New(x, y))
	end

	inpx:AddOnValueChanged(inputChangeFunc, self)
	inpy:AddOnValueChanged(inputChangeFunc, self)

	local text = gohelper.findChildText(itemGO, "Text")

	text.text = mo.name

	local value = self:_getPPValue(mo.val)

	inpx:SetText(value.x)
	inpy:SetText(value.y)
end

function GMPostProcessItem:_updateColor(index, itemGO, mo)
	local inp = gohelper.findChildTextMeshInputField(itemGO, "inp")

	local function inputChangeFunc(self, value)
		local colorStr = inp:GetText()

		self:_setPPValue(mo.val, GameUtil.parseColor(colorStr))
	end

	inp:AddOnValueChanged(inputChangeFunc, self)

	local text = gohelper.findChildText(itemGO, "Text")

	text.text = mo.name

	local value = self:_getPPValue(mo.val)

	inp:SetText(GameUtil.colorToHex(value))
end

function GMPostProcessItem:_getPPValue(key)
	key = string.upper(string.sub(key, 1, 1)) .. string.sub(key, 2)

	return self._ppvolumeWrap[key]
end

function GMPostProcessItem:_setPPValue(key, value)
	key = string.lower(string.sub(key, 1, 1)) .. string.sub(key, 2)
	self._ppvolumeWrap[key] = value
end

return GMPostProcessItem
