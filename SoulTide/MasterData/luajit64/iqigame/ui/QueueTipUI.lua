-- chunkname: @IQIGame\\UI\\QueueTipUI.lua

local QueueTipUI = Base:Extend("QueueTipUI", "IQIGame.Onigao.UI.QueueTipUI", {})
local tweenPosFun = {
	"Button_Mall",
	"Button_Library",
	"Button_Task",
	"Button_Bag",
	"Button_Equip",
	"Button_Formation",
	"Button_Soul"
}
local twoNodePoint = {
	"Btn_WorldMaze",
	"Btn_Wish",
	"Btn_Home",
	"Button_Girl"
}

function QueueTipUI:OnInit()
	self:Initialize()
end

function QueueTipUI:GetPreloadAssetPaths()
	return nil
end

function QueueTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function QueueTipUI:OnOpen(userData)
	self:Refresh(userData)
end

function QueueTipUI:OnClose(userData)
	self:OnHide()
end

function QueueTipUI:OnAddListeners()
	return
end

function QueueTipUI:OnRemoveListeners()
	return
end

function QueueTipUI:OnPause()
	return
end

function QueueTipUI:OnResume()
	return
end

function QueueTipUI:OnCover()
	return
end

function QueueTipUI:OnReveal()
	return
end

function QueueTipUI:OnRefocus(userData)
	return
end

function QueueTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function QueueTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function QueueTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function QueueTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function QueueTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function QueueTipUI:Initialize()
	self.tweenPosition = self.EffectFly:GetComponent("TweenPosition")
	self.tweenSpeed = self.tweenPosition.duration
	self.startPos = self.EffectFly.transform.anchoredPosition
	self.tfTitle = self.goTitle:GetComponent("Text")

	function self.delegatePositionTween()
		self:OnFinishedTweenPosition()
	end
end

function QueueTipUI:Refresh(userData)
	NoticeModule.QueueTip.isShowing = true

	self:RefreshView()
end

function QueueTipUI:OnHide()
	NoticeModule.QueueTip.isShowing = false

	if self.timer1 ~= nil then
		self.timer1:Stop()

		self.timer1 = nil
	end

	if self.timer2 ~= nil then
		self.timer2:Stop()

		self.timer2 = nil
	end

	if self.timer3 ~= nil then
		self.timer3:Stop()

		self.timer3 = nil
	end

	if self.timer4 ~= nil then
		self.timer4:Stop()

		self.timer4 = nil
	end
end

function QueueTipUI:RefreshText()
	if self.tipType == 1 then
		self.tfTitle.text = QueueTipUIApi:GetString("achievementTitle")

		local cfgData = CfgMainQuestTable[self.data]

		self.goName:GetComponent("Text").text = QueueTipUIApi:GetString("achievementViewName", cfgData.Name)
		self.goEnglishName:GetComponent("Text").text = ""
	else
		self.tfTitle.text = QueueTipUIApi:GetString("unlockFunctionTitle")

		local cfgData = CfgFunctionTypeTable[self.data]

		self.goName:GetComponent("Text").text = QueueTipUIApi:GetString("achievementViewName", cfgData.Name)
		self.goEnglishName:GetComponent("Text").text = cfgData.EngName
	end
end

function QueueTipUI:RefreshView()
	if #NoticeModule.QueueTip.tipQueue > 0 then
		self.goPanel:SetActive(true)
		self.goContent:SetActive(false)
		self.EffectStar:SetActive(false)
		self.EffectFly:SetActive(false)
		self.EffectEnd:SetActive(false)

		self.data = NoticeModule.QueueTip.tipQueue[1][1]
		self.tipType = NoticeModule.QueueTip.tipQueue[1][2]

		table.remove(NoticeModule.QueueTip.tipQueue, 1)
		self:RefreshText()

		local tweenHeight = self.goTweenHeight:GetComponent("TweenHeight")
		local cd = tweenHeight.duration

		tweenHeight:ResetToBeginning()

		tweenHeight.enabled = true

		if self.timer1 ~= nil then
			self.timer1:Stop()

			self.timer1 = nil
		end

		self.timer1 = Timer.New(function()
			self.goContent:SetActive(true)
		end, cd)

		self.timer1:Start()

		if self.timer2 ~= nil then
			self.timer2:Stop()

			self.timer2 = nil
		end

		self.timer2 = Timer.New(function()
			self.goPanel:SetActive(false)
			self.EffectStar:SetActive(true)
		end, cd + 1)

		self.timer2:Start()

		self.EffectFly.transform.anchoredPosition = Vector2.zero

		if self.timer3 ~= nil then
			self.timer3:Stop()

			self.timer3 = nil
		end

		self.timer3 = Timer.New(function()
			self:StartTweenPosition()
		end, cd + 1 + 0.5)

		self.timer3:Start()
	else
		UIModule.Close(Constant.UIControllerName.QueueTipUI)
	end
end

function QueueTipUI:StartTweenPosition()
	self.endPos = nil

	local mainUI = GameEntry.UI:GetUIFormByName(Constant.UIControllerName.MainUI)

	if mainUI ~= nil and self.data ~= nil and self.data ~= 0 and self.tipType == NoticeModule.QueueTip.tipTypeEnum.UnlockFunction then
		local cfgFunctionTypeData = CfgFunctionTypeTable[self.data]
		local mainFun = cfgFunctionTypeData.IsMainButtion

		if cfgFunctionTypeData.IsMainButtion == false and cfgFunctionTypeData.BelongWho ~= 0 and cfgFunctionTypeData.BelongWho ~= nil then
			cfgFunctionTypeData = CfgFunctionTypeTable[cfgFunctionTypeData.BelongWho]
		end

		self.endPos = self:GetMainButtonPos(mainUI, cfgFunctionTypeData, mainFun)
	end

	if self.endPos == nil then
		self:RefreshView()

		return
	end

	self.EffectFly:SetActive(true)

	self.tweenPosition = TweenPosition.Begin(self.EffectFly, self.tweenSpeed, self.endPos)

	self.tweenPosition:SetOnFinished(self.delegatePositionTween)
end

function QueueTipUI:OnFinishedTweenPosition()
	self.tweenPosition:RemoveOnFinished(self.delegatePositionTween)

	if self.targetObject then
		if self.targetObject.name == "ToggleTown" then
			self.targetObject.transform:Find("On").gameObject:SetActive(false)
			self.targetObject.transform:Find("Off").gameObject:SetActive(true)
			self.targetObject.transform:Find("Off/Image_Red").gameObject:SetActive(false)

			self.targetObject:GetComponent("Toggle").isOn = TownModule.inTown
		else
			for i = 0, self.targetObject.transform.childCount - 1 do
				local obj = self.targetObject.transform:GetChild(i).gameObject

				if obj.name ~= "Image_RedPoint" and obj.name ~= "Notice" then
					obj:SetActive(true)
				end
			end
		end

		if table.indexOf(twoNodePoint, self.targetObject.transform.parent.gameObject.name) ~= -1 then
			self.targetObject.transform.parent.transform:Find("Lock").gameObject:SetActive(false)
		end
	end

	EventDispatcher.Dispatch(EventID.UnlockFunEffectEnd, self.data)

	self.EffectEnd.transform.anchoredPosition = self.endPos

	self.EffectEnd:SetActive(true)

	if self.timer4 ~= nil then
		self.timer4:Stop()

		self.timer4 = nil
	end

	self.timer4 = Timer.New(function()
		self:RefreshView()
	end, 0.9)

	self.timer4:Start()
end

function QueueTipUI:GetIndex(name)
	for i = 1, #tweenPosFun do
		if tweenPosFun[i] == name then
			return i
		end
	end

	return 0
end

function QueueTipUI:CheckAndBeginTweenPosition(parentTransform, isNewOpen)
	local index = self:GetIndex(self.targetObject.name)
	local beforeObj = {}
	local position = Vector2.New(-50, -5)

	for i = 0, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(i).gameObject

		if obj.activeInHierarchy == true and obj ~= self.targetObject then
			local p = tonumber(self:GetIndex(obj.name))

			if p < index then
				if obj.transform.anchoredPosition.x <= position.x then
					position = obj.transform.anchoredPosition - Vector2.New(obj.transform.sizeDelta.x)
				end
			elseif index < p then
				table.insert(beforeObj, obj)
			end
		end
	end

	if isNewOpen then
		for k, v in pairs(beforeObj) do
			local tween = TweenPosition.Begin(v, 0.8, v.transform.anchoredPosition - Vector2.New(self.targetObject.transform.sizeDelta.x, 0))

			tween:SetOnFinished(function()
				UnityEngine.GameObject.DestroyImmediate(tween)
			end)
		end
	end

	return position
end

function QueueTipUI:GetMainButtonPos(targetUI, cfgFunctionTypeData, mainFun)
	if targetUI == nil or cfgFunctionTypeData == nil then
		return nil
	end

	local pos, target

	self.targetObject = nil

	if cfgFunctionTypeData.Id == Constant.UnlockType.MAZE then
		target = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Btn_WorldMaze/FlyEndPoint")
		self.targetObject = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Btn_WorldMaze").gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.HOME then
		target = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Btn_Home/FlyEndPoint")
		self.targetObject = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Btn_Home").gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.TOWN then
		target = targetUI.transform:Find("Outer/ToggleTown/FlyEndPoint")
		self.targetObject = targetUI.transform:Find("Root/ToggleTown").gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.GIRLS then
		target = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Button_Girl/FlyEndPoint")
		self.targetObject = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Button_Girl").gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.MALL then
		target = targetUI.transform:Find("Outer/PanelMainCity/MainUIBottomFunction/Grid_01/Button_Mall")
		self.targetObject = target.gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.LOTTERY then
		target = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Btn_Wish/FlyEndPoint")
		self.targetObject = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Btn_Wish").gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.FORMATION then
		target = targetUI.transform:Find("Outer/PanelMainCity/MainUIBottomFunction/Grid_01/Button_Formation")
		self.targetObject = target.gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.SOUL_PAINTING then
		target = targetUI.transform:Find("Outer/PanelMainCity/MainUIBottomFunction/Grid_01/Button_Equip")
		self.targetObject = target.gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.SIGN then
		-- block empty
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.CHALLENGE then
		target = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Btn_WorldMaze/FlyEndPoint")
		self.targetObject = targetUI.transform:Find("Outer/PanelMainCity/Function/Button_Project/Btn_WorldMaze").gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.MAIN_TASK then
		target = targetUI.transform:Find("Outer/PanelMainCity/MainUIBottomFunction/Grid_01/Button_Task")
		self.targetObject = target.gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.CHAT then
		target = targetUI.transform:Find("Outer/PanelMainCity/Talk/FlyEndPoint")
		self.targetObject = targetUI.transform:Find("Outer/Talk/Button").gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.NAVIGATION then
		target = targetUI.transform:Find("Outer/PanelMainCity/Active/ScrollArea")
		self.targetObject = targetUI.transform:Find("Outer/PanelMainCity/Active").gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.FRIEND then
		target = targetUI.transform:Find("Outer/PanelMainCity/FunctionRight/Grid_01/Button_02")
		self.targetObject = target.gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.SOUL then
		target = targetUI.transform:Find("Outer/PanelMainCity/MainUIBottomFunction/Grid_01/Button_Soul")
		self.targetObject = target.gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.WAREHOUSE then
		target = targetUI.transform:Find("Outer/PanelMainCity/MainUIBottomFunction/Grid_01/Button_Bag")
		self.targetObject = target.gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.ACTIVE_ROOKIE then
		-- block empty
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.LIBRARY then
		target = targetUI.transform:Find("Outer/PanelMainCity/MainUIBottomFunction/Grid_01/Button_Library")
		self.targetObject = target.gameObject
	elseif cfgFunctionTypeData.Id == Constant.UnlockType.GUILD then
		target = targetUI.transform:Find("Outer/PanelMainCity/MainUIBottomFunction/Grid_01/Button_Guild")
		self.targetObject = target.gameObject
	end

	if not mainFun and self.targetObject and self.targetObject.activeInHierarchy == false then
		return pos
	end

	local index = table.indexOf(Constant.MainFunShowRank, cfgFunctionTypeData.Id)

	if self.targetObject then
		local isNewOpen = false

		if self.targetObject.activeInHierarchy == false then
			isNewOpen = true

			if target ~= nil then
				for i = 0, self.targetObject.transform.childCount - 1 do
					local obj = self.targetObject.transform:GetChild(i).gameObject

					obj:SetActive(false)
				end

				self.targetObject:SetActive(true)
			end
		end

		local parentTransform = self.targetObject.transform.parent

		if mainFun and index ~= -1 then
			local targetPos = self:CheckAndBeginTweenPosition(parentTransform, isNewOpen)

			self.targetObject.transform.anchoredPosition = targetPos
			target = self.targetObject.transform
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(parentTransform)
	end

	if target then
		local canvas = targetUI.gameObject:GetComponent("Canvas")

		pos = inverseTransformPoint(canvas, target.position)

		if index ~= -1 then
			pos.x = pos.x
			pos.y = pos.y + target.sizeDelta.y / 2
		end
	end

	return pos
end

return QueueTipUI
