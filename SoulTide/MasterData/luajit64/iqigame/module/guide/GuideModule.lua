-- chunkname: @IQIGame\\Module\\Guide\\GuideModule.lua

GuideModule = {
	isInitData = false
}

function GuideModule.Start()
	GuideModule.triggerGuideCfgList = {}

	for i, cfgGuide in pairsCfg(CfgGuideTable) do
		if GuideModule.IsGuideEnabled(cfgGuide) then
			table.insert(GuideModule.triggerGuideCfgList, cfgGuide)
		end
	end

	table.sort(GuideModule.triggerGuideCfgList, function(a, b)
		return a.Order < b.Order
	end)

	GuideModule.isInitData = true

	GameEntry.LuaEvent:Subscribe(OpenUIFormSuccessEventArgs.EventId, GuideModule.OnOpenUI)
	EventDispatcher.AddEventListener(EventID.CustomGuideTriggerEvent, GuideModule.CustomGuideTrigger)
end

function GuideModule.End()
	GuideModule.isInitData = false
	GuideModule.triggerGuideCfgList = nil

	GameEntry.LuaEvent:Unsubscribe(OpenUIFormSuccessEventArgs.EventId, GuideModule.OnOpenUI)
	EventDispatcher.RemoveEventListener(EventID.CustomGuideTriggerEvent, GuideModule.CustomGuideTrigger)
end

function GuideModule.HasGuide()
	return GuideModule.currentGuide ~= nil or GuideModule.recoveryGuideID ~= nil
end

function GuideModule.ReloadServerGuideData(currentGuide, finishGuide)
	GuideModule.finishGuide = finishGuide

	if currentGuide ~= nil then
		for k, v in pairs(currentGuide) do
			local cfgGuide = CfgGuideTable[k]

			if GuideModule.IsGuideEnabled(cfgGuide) and cfgGuide.ReturnScene ~= 0 then
				GuideModule.recoveryGuideID = k

				break
			end
		end
	end

	if not GuideModule.isInitData then
		GuideModule.Start()
	end

	if GuideModule.recoveryGuideID ~= nil then
		if GameEntry.Base.DevMode then
			log("有恢复引导 " .. GuideModule.recoveryGuideID)
		end

		local cfgGuide = CfgGuideTable[GuideModule.recoveryGuideID]

		GuideModule.isOpenRecoveryUI = false

		if cfgGuide.ReturnUI ~= "" and cfgGuide.ReturnUI ~= nil then
			GuideModule.recoveryUI = {}

			local arr = string.split(cfgGuide.ReturnUI, "|")

			for i, uiName in pairs(arr) do
				if uiName ~= nil and uiName ~= "" then
					table.insert(GuideModule.recoveryUI, uiName)
				end
			end
		end

		PlayerModule.InitSceneID = cfgGuide.ReturnScene
		GuideModule.timer = Timer.New(GuideModule.CheckRecoverGuide, 0.1, -1)

		GuideModule.timer:Start()
	end
end

function GuideModule.CheckRecoverGuide()
	if PlayerModule.InitSceneID ~= PlayerModule.CurrSceneID or PlayerModule.CurrSceneID == 0 then
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
				if GameEntry.Base.DevMode then
					log("需要恢复的UI " .. v)
				end

				return
			end
		end
	end

	if GameEntry.Base.DevMode then
		log("引导恢复完成 开启引导界面")
	end

	GuideModule.timer:Stop()

	GuideModule.timer = nil

	GuideModule.ExecuteRecoveryGuide()
end

function GuideModule.GuideSubEnd(guideSubID)
	if GameEntry.Base.DevMode then
		log("引导完成.." .. guideSubID)
	end

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

	if cfgSubGuide.OpenDialog and cfgSubGuide.OpenDialog > 0 then
		DialogModule.OpenDialog(cfgSubGuide.OpenDialog, false, false)
	end

	if guideSubID == GuideModule.currentGuideSubID then
		GuideModule.guideSubIndex = GuideModule.guideSubIndex + 1
	end

	local tab = GuideModule.currentGuide.SubIDList

	if GuideModule.guideSubIndex <= #tab then
		if GameEntry.Base.DevMode then
			log("完成关键ID 表示大步骤完成 guideSubID = " .. guideSubID)
		end

		if guideSubID == GuideModule.currentGuide.KeyID then
			if GameEntry.Base.DevMode then
				log("完成关键点 " .. GuideModule.currentGuide.KeyID .. " 大引导完成")
			end

			GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 3)
		else
			GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 2)
		end
	else
		local guideID = GuideModule.currentGuide.Id

		if GameEntry.Base.DevMode then
			log("大步骤引导完成.." .. guideID)
		end

		GuideModule.currentGuide = nil

		GuideModule.UpdateGuide(guideID, guideSubID, 3)

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
	if GuideModule.currentGuide == nil and GuideModule.isInitData then
		GuideModule.TriggerGuide(Constant.GuideTriggerType.SceneTrigger, sceneId)
	end
end

function GuideModule.OnOpenUI(sender, args)
	if GuideModule.currentGuide == nil and GuideModule.isInitData then
		local uiName = string.gsub(args.UIForm.Logic.Name, "%(Clone%)", "")

		GuideModule.TriggerGuide(Constant.GuideTriggerType.OpenUI, uiName)
	end
end

function GuideModule.CustomGuideTrigger(param)
	if GameEntry.Base.DevMode then
		log(" 引导模块收到CustomGuideTrigger 事件" .. param)
	end

	if GuideModule.currentGuide == nil and GuideModule.isInitData then
		if GameEntry.Base.DevMode then
			log(" 成功收到CustomGuideTrigger事件")
		end

		GuideModule.TriggerGuide(Constant.GuideTriggerType.CustomTrigger, tostring(param))
	end
end

function GuideModule.TriggerGuide(triggerType, param)
	if not GuideModule.isInitData then
		return false
	end

	if GuideModule.currentGuide ~= nil then
		return false
	end

	if GuideModule.recoveryGuideID ~= nil then
		return false
	end

	local guideCfg = GuideModule.CheckTriggerGuide(triggerType, param)

	if guideCfg == nil then
		return false
	end

	GuideModule.guideSubIndex = 1
	GuideModule.currentGuide = guideCfg

	GuideModule.OpenGuidePanel(GuideModule.guideSubIndex, 1)
end

function GuideModule.PredictGuide(triggerType, param)
	if not GuideModule.isInitData then
		return nil
	end

	if GuideModule.currentGuide ~= nil then
		return GuideModule.currentGuide
	end

	if GuideModule.recoveryGuideID ~= nil then
		return CfgGuideTable[GuideModule.recoveryGuideID]
	end

	local guideCfg = GuideModule.CheckTriggerGuide(triggerType, param)

	if guideCfg ~= nil then
		return guideCfg
	end

	return nil
end

function GuideModule.CheckTriggerGuide(triggerType, param)
	for i = 1, #GuideModule.triggerGuideCfgList do
		local cfgGuide = GuideModule.triggerGuideCfgList[i]

		if GuideModule.CheckGuideFinish(cfgGuide.Id) == false and cfgGuide.TriggerType == triggerType and tostring(param) == cfgGuide.TriggerValues and GuideModule.CheckCondition(cfgGuide) then
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
	local result = true
	local conditions = string.split(cfgGuide.Conditions, "|")

	for i, v in pairs(conditions) do
		result = GuideConditionModule.CheckGuideCondition(string.split(v, ","))

		if result == false then
			return false
		end
	end

	return result
end

function GuideModule.OpenGuidePanel(subIndex, type)
	if GuideModule.currentGuide ~= nil then
		GuideModule.currentGuideSubID = GuideModule.currentGuide.SubIDList[subIndex]

		local cfgGuideSub = GuideModule.GetSubGuide(GuideModule.currentGuideSubID)

		GuideModule.UpdateGuide(GuideModule.currentGuide.Id, GuideModule.currentGuideSubID, type)
		SDKLoginModule.UserGuide(GuideModule.currentGuide.Id, GuideModule.currentGuideSubID)

		if GuideModule.currentGuide.KeyID == -1 then
			GuideModule.UpdateGuide(GuideModule.currentGuide.Id, GuideModule.currentGuideSubID, 3)
		end

		if cfgGuideSub == nil then
			logError("引导子步骤配置错误 " .. GuideModule.currentGuideSubID)
		else
			for i, v in pairs(cfgGuideSub.DisableUI) do
				GameEntry.UI:ChangeDisableUIFormByName(v, false)
			end

			if GameEntry.Base.DevMode then
				log("执行引导子步骤.." .. cfgGuideSub.GuideSubID)
			end

			UIModule.Open(Constant.UIControllerName.GuideUI, Constant.UILayer.Top, {
				cfgGuideSub,
				GuideModule.currentGuide.Id
			})
		end
	end
end

function GuideModule.GetSubGuide(subID)
	for i, v in pairs(GuideSub) do
		if v.GuideSubID == subID then
			return v
		end
	end

	return nil
end

function GuideModule.Shutdown()
	GuideModule.End()

	GuideModule.recoveryGuide = nil
	GuideModule.currentGuide = nil
	GuideModule.guideSubIndex = nil
	GuideModule.currentGuideSubID = nil
	GuideModule.recoveryUI = nil

	if GuideModule.timer ~= nil then
		GuideModule.timer:Stop()

		GuideModule.timer = nil
	end
end

function GuideModule.CmdOpenGuide(id)
	GuideModule.recoveryGuideID = id

	GuideModule.ExecuteRecoveryGuide()
end

function GuideModule.IsGuideEnabled(cfgGuideData)
	if cfgGuideData == nil then
		logError("GuideModule.IsGuideEnabled错误：参数cfgGuideData不能为空。")

		return false
	end

	if PlayerModule.PlayerInfo.disableGuide then
		return false
	end

	return cfgGuideData.Enable and GmListModule.EnableGuide()
end

function GuideModule.CheckGuideFinish(guideID)
	return GuideModule.finishGuide[guideID] ~= nil
end

function GuideModule.CheckInactivatedGuide(guideID)
	if GuideModule.CheckGuideFinish(guideID) then
		return false
	end

	if GuideModule.currentGuide ~= nil and GuideModule.currentGuide.Id == guideID then
		return false
	end

	if GuideModule.recoveryGuideID == guideID then
		return false
	end

	return true
end

function GuideModule.UpdateGuide(id, step, type)
	if GameEntry.Base.DevMode then
		log("引导数据,.. id=" .. id .. " step=" .. step .. "type=" .. type)
	end

	if type == 0 then
		return
	end

	if not CfgGuideTable[id].Unlimited then
		if type == 3 then
			GuideModule.finishGuide[id] = step
		end

		net_player.triggerGuide(id, step, type)

		if GameEntry.Base.DevMode then
			log("通知服务端同步引导数据,(type 1.接取 2.修改 3.完成).. id=" .. id .. " step=" .. step .. " type=" .. type)
		end
	elseif GameEntry.Base.DevMode then
		log("修改无限触发的引导,(type 1.接取 2.修改 3.完成).. id=" .. id .. " step=" .. step .. " type=" .. type)
	end
end

function GuideModule.JumpGuide(id)
	local jumpGuide = CfgGuideTable[id]

	if not jumpGuide.Unlimited then
		net_player.triggerGuide(id, 0, 4)
	end

	for i, v in pairsCfg(CfgGuideTable) do
		if v.GuideGroupId == jumpGuide.GuideGroupId then
			GuideModule.finishGuide[v.Id] = v.SubIDList[#v.SubIDList]
		end
	end
end

function GuideModule.TriggerGuideResult(id, step, type)
	EventDispatcher.Dispatch(EventID.GuideChangeState, id, step, type)
end
