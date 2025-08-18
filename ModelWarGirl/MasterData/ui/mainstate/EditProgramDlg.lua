-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\EditProgramDlg.lua

local ResPlanWithPlayModeConfig = require("ClientData/ResPlanWithPlayModeConfig")
local strClassName = "EditProgramDlg"
local EditProgramDlg = Class(strClassName, UIControls.Window)

function EditProgramDlg:ctor()
	self:initUI()
end

function EditProgramDlg:initUI()
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.txtRule = UIControls.Label(self, "Bg/TextRule")
	self.inputName = UIControls.Input(self, "Bg/NameInputField")
	self.btnCancel = UIControls.Button(self, "Bg/BtnDeny")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function EditProgramDlg:setPlan(plan, func, battleType)
	self.plan = plan

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self.formationIdx = battleState:getFormationIndex()

	self.txtRule:setVisible(self.plan.id == Const.EQUIP_PLAN_CREATE_ID)

	if self.plan.id == Const.EQUIP_PLAN_CREATE_ID then
		local maxPlanCount = utils.getTableElemCount(CurAvatar.equipPlanDic) + 1

		for i = 1, maxPlanCount do
			if not CurAvatar.equipPlanDic[i] then
				self.opPlanId = i

				break
			end
		end

		if Const.OPEN_PLAN_DEFAULT_NAME and battleType and self.formationIdx then
			local defaultName = Lang.get(50887)

			for i, battleInfo in pairs(ResPlanWithPlayModeConfig) do
				if utils.tableIsContainsElement(battleInfo.battle_type, battleType) and utils.tableIsContainsElement(battleInfo.battle_array_id, self.formationIdx) and battleInfo.plan_default_name then
					defaultName = battleInfo.plan_default_name

					break
				end

				if utils.tableIsContainsElement(battleInfo.battle_type, battleType) and (battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP or battleType == BattleConst.BATTLE_TYPE_OPACT_PVP) then
					defaultName = battleInfo.plan_default_name

					break
				end
			end

			local maxNum = 0

			for i, planData in pairs(CurAvatar.equipPlanDic or {}) do
				local a = string.find(planData.name, defaultName)
				local b = string.find(planData.name, "%d")

				if a ~= nil then
					maxNum = 1

					if b ~= nil then
						local num = string.sub(planData.name, b)

						if num and maxNum <= tonumber(num) then
							maxNum = num + 1

							if maxNum > 9 then
								maxNum = 9
							end
						end
					end
				end
			end

			if maxNum > 0 then
				self.inputName:setText(defaultName .. maxNum)
			else
				self.inputName:setText(defaultName)
			end
		else
			self.inputName:setText(string.format(Lang.get(30469), utils.formatNumber(self.opPlanId) or ""))
		end

		self.txtTitle:setText(Lang.get(30470))
	else
		self.inputName:setText(self.plan.name)
		self.txtTitle:setText(Lang.get(565))
	end

	if func then
		self.func = func
	end
end

function EditProgramDlg:onBtnCancelClick()
	self:setVisible(false)
end

function EditProgramDlg:onBtnConfirmClick()
	if utils.replaceString(self.inputName:getText(), "\n", "") == utils.replaceString(self.plan.name, "\n", "") then
		MsgManager.clientNotice(235)

		return
	end

	local name = utils.replaceString(self.inputName:getText(), "\n", "")
	local failMsg = ClientUtils.checkEquipPlanName(name)

	if failMsg ~= "" then
		MsgManager.notice(failMsg)

		return
	end

	if self.plan.id == Const.EQUIP_PLAN_CREATE_ID then
		local planData = CurAvatar:genNewPlanData(name)
		local planItem = CurAvatar:getPlanItembyPlanData(planData)
		local rpcData = {
			{
				item_id = self.opPlanId,
				item = planItem,
				name = planItem.name
			}
		}
		local update = 1

		RPC.equipSchemeUpdate(rpcData, CurAvatar.equipPlanVersion, update)

		CurAvatar.oldCurWearData = CurAvatar:genNewPlanData(Lang.get(551))

		if self.func ~= nil then
			self.func()
		end
	else
		RPC.equipSchemeRename(self.plan.id, name, CurAvatar.equipPlanVersion)
	end
end

return EditProgramDlg
