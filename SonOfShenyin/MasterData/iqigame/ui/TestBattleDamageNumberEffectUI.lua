-- chunkname: @IQIGame\\UI\\TestBattleDamageNumberEffectUI.lua

local TestBattleDamageNumberEffectUI = {}

TestBattleDamageNumberEffectUI = Base:Extend("TestBattleDamageNumberEffectUI", "IQIGame.Onigao.UI.TestBattleDamageNumberEffectUI", TestBattleDamageNumberEffectUI)

function TestBattleDamageNumberEffectUI:OnInit()
	self.CloseBtn = self.CloseBtnObj:GetComponent("Button")

	self.CloseBtn.onClick:AddListener(function()
		UIModule.CloseSelf(self)
	end)

	self.Input1 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/InputComs/InputCom1/InputField"):GetComponent("UnityEngine.UI.InputField")
	self.Input2 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/InputComs/InputCom2/InputField"):GetComponent("UnityEngine.UI.InputField")
	self.Btn1 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/Btns/Button1"):GetComponent("Button")

	UGUIUtil.SetTextInChildren(self.Btn1.gameObject, "直接伤害/治疗")
	self.Btn1.onClick:AddListener(function()
		local showNum = self.Input1 ~= nil and self.Input1.text ~= "" and tonumber(self.Input1.text) or math.random(-1000, 1000)
		local elementType

		if self.Input2 ~= nil and self.Input2.text ~= "" then
			local elementTypeNum = tonumber(self.Input2.text)

			if elementTypeNum >= 1 and elementTypeNum <= 4 then
				elementType = elementTypeNum
			else
				logError("元素反应类型只能为 [1,4] 的值.")
			end
		end

		self.battleDamageCom:ShowBattleDamageEffect(showNum, Constant.BattleDamageShowType.Normal, false, elementType)
	end)

	self.Btn2 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/Btns/Button2"):GetComponent("Button")

	UGUIUtil.SetTextInChildren(self.Btn2.gameObject, "间接伤害/治疗")
	self.Btn2.onClick:AddListener(function()
		local showNum = self.Input1 ~= nil and self.Input1.text ~= "" and tonumber(self.Input1.text) or math.random(-1000, 1000)

		self.battleDamageCom:ShowBattleDamageEffect(showNum, Constant.BattleDamageShowType.Indirect)
	end)

	self.Btn3 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/Btns/Button3"):GetComponent("Button")

	UGUIUtil.SetTextInChildren(self.Btn3.gameObject, "暴击(非连击状态)")
	self.Btn3.onClick:AddListener(function()
		local showNum = self.Input1 ~= nil and self.Input1.text ~= "" and tonumber(self.Input1.text) or math.random(0, 1000)
		local elementType

		if self.Input2 ~= nil and self.Input2.text ~= "" then
			local elementTypeNum = tonumber(self.Input2.text)

			if elementTypeNum >= 1 and elementTypeNum <= 4 then
				elementType = elementTypeNum
			else
				logError("元素反应类型只能为 [1,4] 的值.")
			end
		end

		self.battleDamageCom:ShowBattleDamageEffect(showNum, Constant.BattleDamageShowType.Critical, false, elementType)
	end)

	self.Btn4 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/Btns/Button4"):GetComponent("Button")

	UGUIUtil.SetTextInChildren(self.Btn4.gameObject, "暴击(连击状态)")
	self.Btn4.onClick:AddListener(function()
		local showNum = self.Input1 ~= nil and self.Input1.text ~= "" and tonumber(self.Input1.text) or math.random(0, 1000)
		local elementType

		if self.Input2 ~= nil and self.Input2.text ~= "" then
			local elementTypeNum = tonumber(self.Input2.text)

			if elementTypeNum >= 1 and elementTypeNum <= 4 then
				elementType = elementTypeNum
			else
				logError("元素反应类型只能为 [1,4] 的值.")
			end
		end

		self.battleDamageCom:ShowBattleDamageEffect(showNum, Constant.BattleDamageShowType.Critical, true, elementType)
	end)

	self.Btn5 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/Btns/Button5"):GetComponent("Button")

	UGUIUtil.SetTextInChildren(self.Btn5.gameObject, "元素反应")
	self.Btn5.onClick:AddListener(function()
		local showNum = self.Input1 ~= nil and self.Input1.text ~= "" and tonumber(self.Input1.text) or math.random(0, 1000)
		local elementType

		if self.Input2 ~= nil and self.Input2.text ~= "" then
			local elementTypeNum = tonumber(self.Input2.text)

			if elementTypeNum >= 1 and elementTypeNum <= 4 then
				elementType = elementTypeNum
			else
				logError("元素反应类型只能为 [1,4] 的值.")
			end
		end

		self.battleDamageCom:ShowBattleDamageEffect(showNum, Constant.BattleDamageShowType.Element, false, elementType == nil and math.random(1, 4) or elementType)
	end)

	self.Btn6 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/Btns/Button6"):GetComponent("Button")

	UGUIUtil.SetTextInChildren(self.Btn6.gameObject, "Dot")
	self.Btn6.onClick:AddListener(function()
		local showNum = self.Input1 ~= nil and self.Input1.text ~= "" and tonumber(self.Input1.text) or math.random(-1000, 1000)

		self.battleDamageCom:ShowBattleDamageEffect(showNum, Constant.BattleDamageShowType.Dot)
	end)

	self.Btn7 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/Btns/Button7"):GetComponent("Button")

	UGUIUtil.SetTextInChildren(self.Btn7.gameObject, "合计")
	self.Btn7.onClick:AddListener(function()
		local showNum = self.Input1 ~= nil and self.Input1.text ~= "" and tonumber(self.Input1.text) or math.random(-1000, 1000)

		self.battleDamageCom:ShowBattleDamageEffect(showNum, Constant.BattleDamageShowType.Total)
	end)

	self.Btn8 = self.gameObject.transform:Find("Root/Panel_UI/Right_Center/Btns/Button8"):GetComponent("Button")

	UGUIUtil.SetTextInChildren(self.Btn8.gameObject, "护盾削减")
	self.Btn8.onClick:AddListener(function()
		local showNum = self.Input1 ~= nil and self.Input1.text ~= "" and tonumber(self.Input1.text) or math.random(0, 1000)

		self.battleDamageCom:ShowBattleDamageEffect(showNum, Constant.BattleDamageShowType.Shield)
	end)
end

function TestBattleDamageNumberEffectUI:GetPreloadAssetPaths()
	return nil
end

function TestBattleDamageNumberEffectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TestBattleDamageNumberEffectUI:IsManualShowOnOpen(userData)
	return false
end

function TestBattleDamageNumberEffectUI:GetBGM(userData)
	return nil
end

function TestBattleDamageNumberEffectUI:OnOpen(userData)
	self.battleDamageCom = BattleDamageEffectComponent.New(self.BattleDamageEffectPanelObj)
end

function TestBattleDamageNumberEffectUI:OnClose(userData)
	self.battleDamageCom:Dispose()
end

function TestBattleDamageNumberEffectUI:OnAddListeners()
	return
end

function TestBattleDamageNumberEffectUI:OnRemoveListeners()
	return
end

function TestBattleDamageNumberEffectUI:OnPause()
	return
end

function TestBattleDamageNumberEffectUI:OnResume()
	return
end

function TestBattleDamageNumberEffectUI:OnCover()
	return
end

function TestBattleDamageNumberEffectUI:OnReveal()
	return
end

function TestBattleDamageNumberEffectUI:OnRefocus(userData)
	return
end

function TestBattleDamageNumberEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TestBattleDamageNumberEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TestBattleDamageNumberEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TestBattleDamageNumberEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TestBattleDamageNumberEffectUI:OnDestroy()
	return
end

return TestBattleDamageNumberEffectUI
