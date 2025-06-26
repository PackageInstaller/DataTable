-- chunkname: @IQIGame\\Module\\Guide\\GuideModule.lua

GuideModule = {
	CheckDelayNextUIOpen = false,
	isInitData = false,
	simpleGuideList = {}
}

local this = GuideModule

function GuideModule.Init()
	GuideModule.triggerGuideCfgList = {}
	this.simpleGuideList = {}

	for _, cfgGuide in pairsCfg(CfgGuideTable) do
		if GuideModule.IsGuideEnabled(cfgGuide) then
			if cfgGuide.GuideType == 1 then
				table.insert(GuideModule.triggerGuideCfgList, cfgGuide)
			elseif cfgGuide.GuideType == 2 then
				this.simpleGuideList[cfgGuide.Id] = cfgGuide
			end
		end
	end

	table.sort(GuideModule.triggerGuideCfgList, function(a, b)
		return a.Order < b.Order
	end)

	GuideModule.isInitData = true

	GameEntry.LuaEvent:Subscribe(CloseUIFormCompleteEventArgs.EventId, GuideModule.OnCloseUI)
	EventDispatcher.AddEventListener(EventID.CustomGuideTriggerEvent, GuideModule.CustomGuideTrigger)
end

function GuideModule.End()
	GuideModule.isInitData = false
	GuideModule.triggerGuideCfgList = nil

	GameEntry.LuaEvent:Unsubscribe(CloseUIFormCompleteEventArgs.EventId, GuideModule.OnCloseUI)
	EventDispatcher.RemoveEventListener(EventID.CustomGuideTriggerEvent, GuideModule.CustomGuideTrigger)
end

function GuideModule.ReloadServerGuideData(currentGuide, finishGuide)
	if PlayerModule.disableGuide then
		return
	end

	if not GuideModule.isInitData then
		GuideModule.Init()
	end

	GuideModule.guides = {}
	GuideModule.finishGuide = finishGuide

	for k, v in pairs(GuideModule.finishGuide) do
		local cfgGuide = CfgGuideTable[k]

		if GuideModule.IsGuideEnabled(cfgGuide) then
			local endStep = cfgGuide.SubIDList[#cfgGuide.SubIDList]

			GuideModule.guides[k] = endStep
		end
	end

	GuideModule.needRecoverGuide = nil

	if currentGuide then
		local minOrder

		for k, _ in pairs(currentGuide) do
			local cfgGuide = CfgUtil.GetCfgGuideDataWithID(k)

			if cfgGuide.RelinkRevert and (not minOrder or minOrder > cfgGuide.Order) then
				GuideModule.needRecoverGuide = cfgGuide
				minOrder = cfgGuide.Order
			end
		end
	end
end

function GuideModule.CheckRecoverGuide()
	if PlayerModule.InitSceneID ~= PlayerModule.CurrSceneID or PlayerModule.CurrSceneID == 0 then
		log("恢复引导检测 要恢复场景 " .. PlayerModule.InitSceneID .. " 当前场景 " .. PlayerModule.CurrSceneID)

		return
	end

	if GuideModule.recoveryUI ~= nil and GuideModule.isOpenRecoveryUI == false then
		GuideModule.isOpenRecoveryUI = true

		for i, uiName in pairs(GuideModule.recoveryUI) do
			if uiName ~= nil and uiName ~= "" then
				UIModule.Open(uiName, Constant.UILayer.UI)
			end
		end

		return
	end

	if GuideModule.recoveryUI ~= nil then
		for i, v in pairs(GuideModule.recoveryUI) do
			if v ~= nil and v ~= "" and UIModule.HasUI(v) == false then
				return
			end
		end
	end

	GuideModule.timer:Stop()

	GuideModule.timer = nil

	GuideModule.ExecuteRecoveryGuide()
end

function GuideModule.GuideSubEnd(guideSubID)
	log("引导完成.." .. guideSubID)

	GuideModule.lastGuideId = guideSubID

	local cfgSubGuide = GuideModule.GetSubGuide(guideSubID)

	for i, v in pairs(cfgSubGuide.DisableUI) do
		GameEntry.UI:ChangeDisableUIFormByName(v, true)
	end

	for i, v in pairs(cfgSubGuide.CloseUI) do
		UIModule.Close(v)
	end

	if cfgSubGuide.FunctionID and cfgSubGuide.FunctionID > 0 then
		JumpModule.Jump(cfgSubGuide.FunctionID)
	end

	if guideSubID == GuideModule.currentGuideSubID then
		GuideModule.guideSubIndex = GuideModule.guideSubIndex + 1
	end

	local tab = GuideModule.currentGuide.SubIDList
	local tempSubID = GuideModule.currentGuide.SubIDList[GuideModule.guideSubIndex]
	local TempGuideSub = GuideModule.GetSubGuide(tempSubID)

	if GuideModule.guideSubIndex <= #tab and TempGuideSub.PlotCheck then
		-- block empty
	end

	if GuideModule.guideSubIndex <= #tab and TempGuideSub.EquippedSkipCheck and EquipModule.GetHasWearEquip() then
		GuideModule.currentGuideSubID = GuideModule.currentGuide.SubIDList[GuideModule.guideSubIndex]

		return GuideModule.GuideSubEnd(GuideModule.currentGuideSubID)
	end

	if GuideModule.guideSubIndex <= #tab then
		GuideModule.currentGuideSubID = GuideModule.currentGuide.SubIDList[GuideModule.guideSubIndex]

		local cfgGuideSub = GuideModule.GetSubGuide(GuideModule.currentGuideSubID)

		if cfgGuideSub.OpenNewUI then
			GuideModule.CheckDelayNextUIOpen = true

			return
		end

		if cfgGuideSub.WaitDispatch then
			function GuideModule.GoNextSubEvent()
				GuideModule.GoNextSub()
			end

			return
		end

		if guideSubID == GuideModule.currentGuide.KeyID then
			GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 3)
		else
			GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 2)
		end
	else
		local guideID = GuideModule.currentGuide.Id

		if GuideModule.GetSubGuide(GuideModule.currentGuideSubID).DelayTrigger then
			log("引导-->>延迟通知服务器")

			function GuideModule.DelayTriggerEvent()
				GuideModule.UpdateGuide(guideID, guideSubID, 3)

				GuideModule.currentGuide = nil

				local cfgGuide = CfgGuideTable[guideID]

				if cfgGuide.NextGuide > 0 and GuideConditionModule.CheckInactivatedGuide(cfgGuide.NextGuide) then
					GuideModule.guideSubIndex = 1
					GuideModule.currentGuide = CfgGuideTable[cfgGuide.NextGuide]

					GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 1)
				else
					GuideModule.TriggerGuide(Constant.GuideTriggerType.GuideFinish, guideID)
				end
			end

			return
		end

		log("大步骤引导完成.." .. guideID)
		GuideModule.UpdateGuide(guideID, guideSubID, 3)

		GuideModule.currentGuide = nil

		local cfgGuide = CfgGuideTable[guideID]

		if cfgGuide.NextGuide > 0 and GuideConditionModule.CheckInactivatedGuide(cfgGuide.NextGuide) then
			GuideModule.guideSubIndex = 1
			GuideModule.currentGuide = CfgGuideTable[cfgGuide.NextGuide]

			GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 1)
		else
			GuideModule.TriggerGuide(Constant.GuideTriggerType.GuideFinish, guideID)
		end
	end
end

function GuideModule.OnEnterScene(sceneId, isAddScene)
	return
end

function GuideModule.OnCloseUI(sender, args)
	local uiName = string.match(args.UIFormAssetName, "([^/]+)%.prefab")

	GuideModule.TriggerGuide(Constant.GuideTriggerType.CloseUI, uiName)
end

function GuideModule.CustomGuideTrigger(param)
	if GuideModule.currentGuide == nil and GuideModule.isInitData then
		log(" 引导模块收到CustomGuideTrigger 事件" .. param)
		GuideModule.TriggerGuide(Constant.GuideTriggerType.CustomTrigger, tostring(param))
	end
end

function GuideModule.TriggerGuide(triggerType, param)
	if PlayerModule.disableGuide then
		return
	end

	if not GuideModule.isInitData then
		return false
	end

	if GuideModule.IsGuiding then
		return
	end

	local guideCfg = GuideModule.CheckTriggerGuide(triggerType, param)

	if not guideCfg then
		return false
	end

	this.GuideStart(false, guideCfg)

	return true
end

function GuideModule.CheckTriggerGuide(triggerType, param)
	local len = #GuideModule.triggerGuideCfgList

	for i = 1, len do
		local cfgGuide = GuideModule.triggerGuideCfgList[i]

		if cfgGuide.TriggerType == triggerType and cfgGuide.TriggerValues == param and GuideModule.CheckCondition(cfgGuide) then
			return cfgGuide
		end
	end

	return nil
end

function GuideModule.ExecuteRecoveryGuide()
	local cfgGuide = CfgGuideTable[GuideModule.recoveryGuideID]

	GuideModule.recoveryGuideID = nil
	GuideModule.guideSubIndex = 1
	GuideModule.currentGuide = cfgGuide

	GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 0)
end

function GuideModule.CheckCondition(cfgGuide)
	local conditions = string.split(cfgGuide.Conditions, "|")

	for _, v in pairs(conditions) do
		if not GuideConditionModule.CheckGuideCondition(string.split(v, ","), cfgGuide) then
			return false
		end
	end

	return true
end

function GuideModule.OpenGuidePanel(subIndex, type)
	if PlayerModule.disableGuide then
		return
	end

	if GuideModule.currentGuide ~= nil then
		GameEntry.UI:DisableAllLoadedUIFormsRaycast()

		GuideModule.currentGuideSubID = GuideModule.currentGuide.SubIDList[subIndex]

		local cfgGuideSub = GuideModule.GetSubGuide(GuideModule.currentGuideSubID)

		GuideModule.UpdateGuide(GuideModule.currentGuide.Id, GuideModule.currentGuideSubID, type)

		if GuideModule.currentGuide.KeyID == -1 then
			GuideModule.UpdateGuide(GuideModule.currentGuide.Id, GuideModule.currentGuideSubID, 3)
		end

		if cfgGuideSub == nil then
			logError("引导子步骤配置错误 " .. GuideModule.currentGuideSubID)
		else
			log("执行引导子步骤.." .. cfgGuideSub.GuideSubID)
			UIModule.Open(Constant.UIControllerName.GuideUI, Constant.UILayer.Top, {
				cfgGuideSub,
				GuideModule.currentGuide.Id
			})
		end
	end
end

function GuideModule.GetSubGuide(subID)
	for _, v in pairs(GuideSub) do
		if v.GuideSubID == subID then
			return v
		end
	end

	logError("没有找到引导子步骤 = " .. subID)

	return nil
end

function GuideModule.Shutdown()
	GuideModule.End()

	GuideModule.recoveryGuide = nil
	GuideModule.currentGuide = nil
	GuideModule.guideSubIndex = nil
	GuideModule.currentGuideSubID = nil
	GuideModule.recoveryUI = nil
	this.IsGuiding = false

	if GuideModule.timer ~= nil then
		GuideModule.timer:Stop()

		GuideModule.timer = nil
	end
end

function GuideModule.CmdOmpenGuide(id)
	GuideModule.recoveryGuideID = id

	GuideModule.ExecuteRecoveryGuide()
end

function GuideModule.IsGuideEnabled(cfgGuideData)
	if cfgGuideData == nil then
		logError("GuideModule.IsGuideEnabled错误：参数cfgGuideData不能为空。")

		return false
	end

	return cfgGuideData.Enable
end

function GuideModule.GoNextSub()
	local tab = GuideModule.currentGuide.SubIDList

	if GuideModule.guideSubIndex <= #tab then
		if GuideModule.lastGuideId == GuideModule.currentGuide.KeyID then
			GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 3)
		else
			GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 2)
		end
	else
		local guideID = GuideModule.currentGuide.Id

		if GuideModule.GetSubGuide(GuideModule.currentGuideSubID).DelayTrigger then
			log("引导-->>延迟通知服务器")

			function GuideModule.DelayTriggerEvent()
				GuideModule.UpdateGuide(guideID, GuideModule.lastGuideId, 3)

				GuideModule.currentGuide = nil

				local cfgGuide = CfgGuideTable[guideID]

				if cfgGuide.NextGuide > 0 and GuideConditionModule.CheckInactivatedGuide(cfgGuide.NextGuide) then
					GuideModule.guideSubIndex = 1
					GuideModule.currentGuide = CfgGuideTable[cfgGuide.NextGuide]

					GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 1)
				else
					GuideModule.TriggerGuide(Constant.GuideTriggerType.GuideFinish, guideID)
				end
			end

			return
		end

		log("大步骤引导完成.." .. guideID)
		GuideModule.UpdateGuide(guideID, GuideModule.currentGuideSubID, 3)

		GuideModule.currentGuide = nil

		local cfgGuide = CfgGuideTable[guideID]

		if cfgGuide.NextGuide > 0 and GuideConditionModule.CheckInactivatedGuide(cfgGuide.NextGuide) then
			GuideModule.guideSubIndex = 1
			GuideModule.currentGuide = CfgGuideTable[cfgGuide.NextGuide]

			GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 1)
		else
			GuideModule.TriggerGuide(Constant.GuideTriggerType.GuideFinish, guideID)
		end
	end
end

function GuideModule.SkipCurGuide()
	if GuideModule.currentGuide == nil then
		return
	end

	local SubID = GuideModule.currentGuide.SubIDList[GuideModule.guideSubIndex]
	local cfgGuideSub = GuideModule.GetSubGuide(SubID)

	if not cfgGuideSub.CanSkip then
		return
	end

	log("引导--》执行跳过步骤，当前步骤" .. GuideModule.currentGuide.SubIDList[GuideModule.guideSubIndex])

	GuideModule.guideSubIndex = GuideModule.guideSubIndex + 1

	GuideModule.GoNextSubEventDispatch()
end

function GuideModule.GoNextSubEventDispatch()
	if GuideModule.GoNextSubEvent ~= nil then
		GuideModule.GoNextSubEvent()

		GuideModule.GoNextSubEvent = nil
	end
end

function GuideModule.DelayTriggerEventDispatch()
	if GuideModule.DelayTriggerEvent ~= nil then
		GuideModule.DelayTriggerEvent()

		GuideModule.DelayTriggerEvent = nil

		log("通知服务端同步延迟引导数据")
	end
end

function GuideModule.MaskShow(show)
	return
end

function this.GuideStart(isRecover, guideCfg)
	if PlayerModule.disableGuide then
		return
	end

	if this.IsGuiding then
		return
	end

	this.guideSubIndex = 1
	this.currentGuide = guideCfg
	this.CurrentGuideSubCfg = this.GetSubGuide(this.currentGuide.SubIDList[this.guideSubIndex])

	if not UIModule.HasUI(Constant.UIControllerName.GuideUI) then
		UIModule.Open(Constant.UIControllerName.GuideUI, Constant.UILayer.Top, {
			this.CurrentGuideSubCfg,
			this.currentGuide.Id
		})
	else
		EventDispatcher.Dispatch(EventID.GuideUIStartEvent, this.CurrentGuideSubCfg, this.currentGuide.Id)
	end

	if not isRecover then
		this.UpdateGuide(this.currentGuide.Id, this.CurrentGuideSubCfg.GuideSubID, 1)
	end

	this.IsGuiding = true
end

function this.GuideNext()
	this.guideSubIndex = this.guideSubIndex + 1

	if this.guideSubIndex > #this.currentGuide.SubIDList then
		this.GuideEnd()

		return
	end

	if this.currentGuide.KeyID == this.CurrentGuideSubCfg.GuideSubID then
		this.UpdateGuide(this.currentGuide.Id, this.CurrentGuideSubCfg.GuideSubID, 3)
	else
		this.UpdateGuide(this.currentGuide.Id, this.CurrentGuideSubCfg.GuideSubID, 2)
	end

	this.CurrentGuideSubCfg = this.GetSubGuide(this.currentGuide.SubIDList[this.guideSubIndex])

	EventDispatcher.Dispatch(EventID.GuideUIStartEvent, this.CurrentGuideSubCfg, this.currentGuide.Id)
end

function this.GuideEnd()
	this.UpdateGuide(this.currentGuide.Id, this.CurrentGuideSubCfg.GuideSubID, 3)

	this.currentGuide = nil
	this.currentGuideSubID = nil
	this.CurrentGuideSubCfg = nil
	this.IsGuiding = false

	UIModule.Close(Constant.UIControllerName.GuideUI)
end

function this.StoryGuide(plotID)
	this.currentGuide = nil
	this.currentGuideSubID = nil
	this.CurrentGuideSubCfg = nil
	this.IsGuiding = false

	net_plotStage.enterStaticStage(plotID)
	UIModule.Close(Constant.UIControllerName.GuideUI)
end

function this.GetIsGuiding()
	return this.IsGuiding
end

function this.GetCurrentGuideIsStoryGuide()
	if not this.CurrentGuideSubCfg or not this.CurrentGuideSubCfg.GuideUIType then
		return false
	end

	return this.CurrentGuideSubCfg.GuideUIType[1][1] == "StartStory"
end

function this.CheckEasyGuideTrigger(guidId)
	local cfgGuide = this.simpleGuideList[guidId]

	if not cfgGuide then
		return
	end

	local record = PlayerPrefsUtil.GetLuaTable("", Constant.PlayerPrefsConst.SimpleGuideRecord)

	if record and record[tostring(guidId)] then
		return
	end

	if GuideModule.CheckCondition(cfgGuide) then
		UIModule.Open(Constant.UIControllerName.SimpleGuideUI, Constant.UILayer.Top, {
			cfgGuide = cfgGuide
		})
	end
end

function this.SimpleGuideTriggerEnd(guidId, keyID)
	local record = PlayerPrefsUtil.GetLuaTable("", Constant.PlayerPrefsConst.SimpleGuideRecord)

	record = record or {}
	record[tostring(guidId)] = keyID

	PlayerPrefsUtil.SetLuaTable("", Constant.PlayerPrefsConst.SimpleGuideRecord, record)
	PlayerPrefsUtil.Save()
end

function GuideModule.UpdateGuide(id, step, type)
	if type == 0 then
		return
	end

	GuideModule.guides[id] = step

	local TempGuideSub = GuideModule.GetSubGuide(step)
	local CfgGuide = CfgUtil.GetCfgGuideDataWithID(id)

	if CfgGuide.Unlimited and (not TempGuideSub or not TempGuideSub.GuideName or true) then
		log("修改无限触发的引导,(type 1.接取 2.修改 3.完成).. id=" .. id .. " step=" .. step .. " type=" .. type)

		return
	end

	net_player.triggerGuide(id, step, type)

	if type == 3 then
		GuideModule.finishGuide[id] = step
	end

	if TempGuideSub and TempGuideSub.GuideName then
		-- block empty
	end

	log("通知服务端同步引导数据,(type 1.接取 2.修改 3.完成).. id=" .. id .. " step=" .. step .. " type=" .. type)
end

function GuideModule.JumpGuide(id)
	local jumpGuide = CfgGuideTable[id]

	if not jumpGuide.Unlimited then
		net_player.triggerGuide(id, 0, 4)
	end

	GuideModule.guides[id] = jumpGuide.SubIDList[#jumpGuide.SubIDList]

	for i, v in pairsCfg(CfgGuideTable) do
		if v.GuideGroupId == jumpGuide.GuideGroupId then
			GuideModule.finishGuide[v.Id] = v.SubIDList[#v.SubIDList]
		end
	end
end

function GuideModule.TriggerGuideResult(id, step, type)
	EventDispatcher.Dispatch(EventID.GuideChangeState, id, step, type)
end
