-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMSettingView.lua

module("logic.extensions.gm.view.GMSettingView", package.seeall)

local GMSettingView = class("GMSettingView", ViewComponent)

function GMSettingView:ctor()
	GMSettingView.super.ctor(self)
end

function GMSettingView:buildUI()
	self._btnClose = self:getBtn("bg/btnClose")
	self._shadowGo = self:getGo("bg/shadow")
	self._lightGo = self:getGo("bg/light")
	self._otherGo = self:getGo("bg/other")
	self._btnShadowTab = self:getBtn("bg/btnShadowTab")
	self._btnLightTab = self:getBtn("bg/btnLightTab")
	self._btnOtherTab = self:getBtn("bg/btnOtherTab")
	self._lblQuality = self:getGo("bg/lblQuality"):GetComponent("Text")
	self._lblShadow = self:getGo("bg/lblShadow"):GetComponent("Text")
	self._lblAntiAlias = self:getGo("bg/lblAntiAlias"):GetComponent("Text")
	self._lblShadowDisValue = self:getGo("bg/shadow/lblShadowDistance/lblShadowDisValue"):GetComponent("Text")
	self._lblShadowDisValuePro = Framework.SliderAdapter.GetFrom(self.mainGO, "bg/shadow/lblShadowDistance/Slider")
	self._lblCascade2Value = self:getGo("bg/shadow/lblCascade2Setting/lblCascade2Value"):GetComponent("Text")
	self._lblCascade2ValuePro = Framework.SliderAdapter.GetFrom(self.mainGO, "bg/shadow/lblCascade2Setting/Slider")
	self._lblCascade4Value_1 = self:getGo("bg/shadow/lblCascade4Setting/lblCascade4Value_1"):GetComponent("Text")
	self._lblCascade4ValueSlider1 = Framework.SliderAdapter.GetFrom(self.mainGO, "bg/shadow/lblCascade4Setting/Slider")
	self._lblCascade4Value_2 = self:getGo("bg/shadow/lblCascade4Setting/lblCascade4Value_2"):GetComponent("Text")
	self._lblCascade4ValueSlider2 = Framework.SliderAdapter.GetFrom(self.mainGO, "bg/shadow/lblCascade4Setting/Slider_2")
	self._lblCascade4Value_3 = self:getGo("bg/shadow/lblCascade4Setting/lblCascade4Value_3"):GetComponent("Text")
	self._lblCascade4ValueSlider3 = Framework.SliderAdapter.GetFrom(self.mainGO, "bg/shadow/lblCascade4Setting/Slider_3")
	self._lblLightValue = self:getGo("bg/light/lblLight/lblLightValue"):GetComponent("Text")
	self._lblLightValuePro = Framework.SliderAdapter.GetFrom(self.mainGO, "bg/light/lblLight/Slider")
	self._btnHuiGuangBk = self:getBtn("bg/other/lblHuiGuang/btnHuiGuangBk")
	self._checkHuiGuangImg = self:getGo("bg/other/lblHuiGuang/btnHuiGuangBk/checkHuiGuang")
	self._btnAA0 = self:getBtn("bg/other/lblantiAliasing/lblAA0/btnAA0")
	self._checkAA0 = self:getGo("bg/other/lblantiAliasing/lblAA0/btnAA0/checkAA0")
	self._btnAA2 = self:getBtn("bg/other/lblantiAliasing/lblAA2/btnAA2")
	self._checkAA2 = self:getGo("bg/other/lblantiAliasing/lblAA2/btnAA2/checkAA2")
	self._btnAA4 = self:getBtn("bg/other/lblantiAliasing/lblAA4/btnAA4")
	self._checkAA4 = self:getGo("bg/other/lblantiAliasing/lblAA4/btnAA4/checkAA4")
	self._btnAA8 = self:getBtn("bg/other/lblantiAliasing/lblAA8/btnAA8")
	self._checkAA8 = self:getGo("bg/other/lblantiAliasing/lblAA8/btnAA8/checkAA8")
end

function GMSettingView:bindEvents()
	self._btnClose:AddClickListener(function()
		self:close()
	end, self)
	self._btnShadowTab:AddClickListener(function()
		self._shadowGo.gameObject:SetActive(true)
		self._lightGo.gameObject:SetActive(false)
		self._otherGo.gameObject:SetActive(false)
	end, self)
	self._btnLightTab:AddClickListener(function()
		if self._dirLight then
			self.rotX, self.rotY, self.rotZ = Framework.TransformUtil.GetLocalRotation(self._dirLight.transform, 0, 0, 0)
			self._lblLightValue.text = string.format("%.2f", self.rotY)

			self._lblLightValuePro:SetValue(string.format("%.2f", self.rotY))
		end

		self._shadowGo.gameObject:SetActive(false)
		self._lightGo.gameObject:SetActive(true)
		self._otherGo.gameObject:SetActive(false)
	end, self)
	self._btnOtherTab:AddClickListener(function()
		self._shadowGo.gameObject:SetActive(false)
		self._lightGo.gameObject:SetActive(false)
		self._otherGo.gameObject:SetActive(true)
	end, self)
	self._btnHuiGuangBk:AddClickListener(function()
		self:_operHuiGuang()
	end, self)
	self._btnAA0:AddClickListener(function()
		self._checkAA0.gameObject:SetActive(true)
		self._checkAA2.gameObject:SetActive(false)
		self._checkAA4.gameObject:SetActive(false)
		self._checkAA8.gameObject:SetActive(false)

		UnityEngine.QualitySettings.antiAliasing = 0
	end, self)
	self._btnAA2:AddClickListener(function()
		self._checkAA0.gameObject:SetActive(false)
		self._checkAA2.gameObject:SetActive(true)
		self._checkAA4.gameObject:SetActive(false)
		self._checkAA8.gameObject:SetActive(false)

		UnityEngine.QualitySettings.antiAliasing = 2
	end, self)
	self._btnAA4:AddClickListener(function()
		self._checkAA0.gameObject:SetActive(false)
		self._checkAA2.gameObject:SetActive(false)
		self._checkAA4.gameObject:SetActive(true)
		self._checkAA8.gameObject:SetActive(false)

		UnityEngine.QualitySettings.antiAliasing = 4
	end, self)
	self._btnAA8:AddClickListener(function()
		self._checkAA0.gameObject:SetActive(false)
		self._checkAA2.gameObject:SetActive(false)
		self._checkAA4.gameObject:SetActive(false)
		self._checkAA8.gameObject:SetActive(true)

		UnityEngine.QualitySettings.antiAliasing = 8
	end, self)
end

function GMSettingView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnHuiGuangBk:RemoveClickListener()
	self._btnShadowTab:RemoveClickListener()
	self._btnLightTab:RemoveClickListener()
	self._btnOtherTab:RemoveClickListener()
	self._btnAA0:RemoveClickListener()
	self._btnAA2:RemoveClickListener()
	self._btnAA4:RemoveClickListener()
	self._btnAA8:RemoveClickListener()
end

function GMSettingView:destroyUI()
	return
end

function GMSettingView:_operHuiGuang()
	self._huiGuangCheck = not self._huiGuangCheck

	if self._huiGuangCheck then
		local _quality = HardwareQuality.getQualityLevel()

		if _quality == HardwareQuality.QualityLevelType.Low then
			FloatWordMgr.instance:show("目前设置不支持辉光，请提高质量设置")

			return
		end
	end

	if self._postBattle then
		self._postBattle.enabled = self._huiGuangCheck

		FloatWordMgr.instance:show(self._huiGuangCheck and "辉光已启用" or "辉光已关闭")
		self._checkHuiGuangImg.gameObject:SetActive(self._huiGuangCheck)
	end
end

function GMSettingView:onEnter()
	self:_showAllSetting()

	self._dirLight = goutil.find("Directional light")

	if self._dirLight then
		self.rotX, self.rotY, self.rotZ = Framework.TransformUtil.GetLocalRotation(self._dirLight.transform, 0, 0, 0)
		self._lblLightValue.text = string.format("%.2f", self.rotY)

		self._lblLightValuePro:SetValue(string.format("%.2f", self.rotY))
	end

	self._lblLightValuePro:AddOnValueChanged(function(val)
		if self._dirLight then
			self._lblLightValue.text = string.format("%.2f", val)

			Framework.TransformUtil.SetLocalRotation(self._dirLight.transform, self.rotX, val, self.rotZ)
		end
	end)
	self._lblShadowDisValuePro:AddOnValueChanged(function(val)
		self._lblShadowDisValue.text = string.format("%.4f", val)
		UnityEngine.QualitySettings.shadowDistance = val
	end)
	self._lblCascade2ValuePro:AddOnValueChanged(function(val)
		self._lblCascade2Value.text = string.format("%.4f", val)
		UnityEngine.QualitySettings.shadowCascades = 2

		self:_setShadowCascadesStr()

		UnityEngine.QualitySettings.shadowCascade2Split = val
	end)
	self._lblCascade4ValueSlider1:AddOnValueChanged(function(val)
		self._lblCascade4Value_1.text = string.format("%.4f", val)
		UnityEngine.QualitySettings.shadowCascades = 4

		self:_setShadowCascadesStr()

		UnityEngine.QualitySettings.shadowCascade4Split = Vector3.New(self._lblCascade4Value_1.text, self._lblCascade4Value_2.text, self._lblCascade4Value_3.text)
	end)
	self._lblCascade4ValueSlider2:AddOnValueChanged(function(val)
		self._lblCascade4Value_2.text = string.format("%.4f", val)
		UnityEngine.QualitySettings.shadowCascades = 4

		self:_setShadowCascadesStr()

		UnityEngine.QualitySettings.shadowCascade4Split = Vector3.New(self._lblCascade4Value_1.text, self._lblCascade4Value_2.text, self._lblCascade4Value_3.text)
	end)
	self._lblCascade4ValueSlider3:AddOnValueChanged(function(val)
		self._lblCascade4Value_3.text = string.format("%.4f", val)
		UnityEngine.QualitySettings.shadowCascades = 4

		self:_setShadowCascadesStr()

		UnityEngine.QualitySettings.shadowCascade4Split = Vector3.New(self._lblCascade4Value_1.text, self._lblCascade4Value_2.text, self._lblCascade4Value_3.text)
	end)

	self._mainCameraGO = goutil.find("createrolecamera") or goutil.find("MainCamera")

	if self._mainCameraGO then
		self._postBattle = self._mainCameraGO:GetComponent(typeof(UnityEngine.PostProcessing.PostProcessingBehaviour))

		if self._postBattle then
			self._huiGuangCheck = self._postBattle.enabled
		end
	end

	local _antiAliasing = UnityEngine.QualitySettings.antiAliasing

	if _antiAliasing == 0 then
		self._checkAA0.gameObject:SetActive(true)
		self._checkAA2.gameObject:SetActive(false)
		self._checkAA4.gameObject:SetActive(false)
		self._checkAA8.gameObject:SetActive(false)
	elseif _antiAliasing == 2 then
		self._checkAA0.gameObject:SetActive(false)
		self._checkAA2.gameObject:SetActive(true)
		self._checkAA4.gameObject:SetActive(false)
		self._checkAA8.gameObject:SetActive(false)
	elseif _antiAliasing == 4 then
		self._checkAA0.gameObject:SetActive(false)
		self._checkAA2.gameObject:SetActive(false)
		self._checkAA4.gameObject:SetActive(true)
		self._checkAA8.gameObject:SetActive(false)
	elseif _antiAliasing == 8 then
		self._checkAA0.gameObject:SetActive(false)
		self._checkAA2.gameObject:SetActive(false)
		self._checkAA4.gameObject:SetActive(false)
		self._checkAA8.gameObject:SetActive(true)
	end

	self._shadowGo.gameObject:SetActive(true)
	self._lightGo.gameObject:SetActive(false)
	self._otherGo.gameObject:SetActive(false)
end

function GMSettingView:onEnterFinished()
	return
end

function GMSettingView:onExit()
	return
end

function GMSettingView:onExitFinished()
	return
end

function GMSettingView:_showAllSetting()
	self._lblAntiAlias.text = ""

	local _quality = HardwareQuality.getQualityLevel()

	self._lblQuality.text = "_quality:" .. _quality
	self._lblShadowDisValue.text = UnityEngine.QualitySettings.shadowDistance

	local _shadowCascade2Split = UnityEngine.QualitySettings.shadowCascade2Split

	self._lblCascade2Value.text = string.format("%.4f", _shadowCascade2Split)

	self._lblCascade2ValuePro:SetValue(string.format("%.4f", _shadowCascade2Split))

	local _shadowCascade4Split = UnityEngine.QualitySettings.shadowCascade4Split

	self._lblCascade4Value_1.text = string.format("%.4f", _shadowCascade4Split.x)
	self._lblCascade4Value_2.text = string.format("%.4f", _shadowCascade4Split.y)
	self._lblCascade4Value_3.text = string.format("%.4f", _shadowCascade4Split.z)

	self._lblCascade4ValueSlider1:SetValue(string.format("%.4f", _shadowCascade4Split.x))
	self._lblCascade4ValueSlider2:SetValue(string.format("%.4f", _shadowCascade4Split.y))
	self._lblCascade4ValueSlider3:SetValue(string.format("%.4f", _shadowCascade4Split.z))
	self:_setShadowStr()
end

function GMSettingView:_setShadowStr()
	local _shadowQuality = UnityEngine.QualitySettings.shadows
	local _shadowQualityStr = "nil"

	if _shadowQuality == UnityEngine.ShadowQuality.Disable then
		_shadowQualityStr = "Disable"
	elseif _shadowQuality == UnityEngine.ShadowQuality.HardOnly then
		_shadowQualityStr = "HardOnly"
	elseif _shadowQuality == UnityEngine.ShadowQuality.All then
		_shadowQualityStr = "All"
	end

	local _shadowResolution = UnityEngine.QualitySettings.shadowResolution
	local _shadowResolutionStr = "nil"

	if _shadowResolution == UnityEngine.ShadowResolution.Low then
		_shadowResolutionStr = "Low"
	elseif _shadowResolution == UnityEngine.ShadowResolution.Medium then
		_shadowResolutionStr = "Medium"
	elseif _shadowResolution == UnityEngine.ShadowResolution.High then
		_shadowResolutionStr = "High"
	elseif _shadowResolution == UnityEngine.ShadowResolution.VeryHigh then
		_shadowResolutionStr = "VeryHigh"
	end

	self._shadowBaseStr = "_shadowQuality:" .. _shadowQualityStr .. ",  Resolution:" .. _shadowResolutionStr

	self:_setShadowCascadesStr()
end

function GMSettingView:_setShadowCascadesStr()
	local _shadowCascades = UnityEngine.QualitySettings.shadowCascades

	self._shadowCascadesStr = "\nCascades:" .. _shadowCascades
	self._lblShadow.text = self._shadowBaseStr .. self._shadowCascadesStr
end

return GMSettingView
