-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\EditPlanListDlg.lua

local ResPlanWithPlayModeConfig = require("ClientData/ResPlanWithPlayModeConfig")
local strClassName = "BtnEquipPlanWithPlayMode"
local BtnEquipPlanWithPlayMode = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnEquipPlanWithPlayMode:ctor()
	self:initUI()
end

function BtnEquipPlanWithPlayMode:initUI()
	self.bgNew = UIControls.Panel(self, "BgNew")
	self.bgPlan = UIControls.Panel(self, "BgPlan")
	self.txtPlanName = UIControls.Label(self, "BgPlan/TextPlanName")
	self.imgLast = UIControls.Image(self, "BgPlan/ImgLastEdit")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function BtnEquipPlanWithPlayMode:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function BtnEquipPlanWithPlayMode:onBtnSelfClick()
	if self.plan and self.selectCallback then
		self.selectCallback(self)
	end
end

function BtnEquipPlanWithPlayMode:setPlan(plan)
	self.plan = plan

	self.bgNew:setVisible(plan.id == Const.EQUIP_PLAN_CREATE_ID)
	self.bgPlan:setVisible(plan.id ~= Const.EQUIP_PLAN_CREATE_ID)
	self.txtPlanName:setText(self.plan.name)
	self.imgLast:setVisible(CurAvatar.lastUsePlanID == plan.id)
end

UIConst.BtnEquipPlanWithPlayMode = BtnEquipPlanWithPlayMode

local UserData = require("Helper/UserData")
local strClassName = "EditPlanListDlg"
local EditPlanListDlg = Class(strClassName, UIControls.Window)

function EditPlanListDlg:ctor()
	self:initUI()
end

function EditPlanListDlg:initUI()
	self.btnTips = UIControls.Button(self, "Bg/TextTitle/BtnTips")

	self.btnTips:addEventClick(self.onTipClick)

	self.scrollPlanList = UIControls.ScrollViewLoopV(self, "Bg/PlanList")

	self.scrollPlanList:addEventCellChanged(self.onPlanListChanged)

	self.btnEquipPlanList = {}
end

local function sortPlanList(planA, planB)
	if CurAvatar.lastUsePlanID and planA.id == CurAvatar.lastUsePlanID ~= (planB.id == CurAvatar.lastUsePlanID) then
		return planA.id == CurAvatar.lastUsePlanID
	else
		return planA.id < planB.id
	end
end

function EditPlanListDlg:setData(battleType)
	self.battleType = battleType
	self.planDataList = {}

	for _, plan in pairs(CurAvatar.equipPlanDic) do
		table.insert(self.planDataList, plan)
	end

	table.sort(self.planDataList, sortPlanList)

	local canCreatePlan = CurAvatar:checkPlanCountNotOverMax()

	if canCreatePlan then
		table.insert(self.planDataList, 1, {
			name = Lang.get(30467),
			id = Const.EQUIP_PLAN_CREATE_ID
		})
	end

	self.scrollPlanList:setTotalCount(#self.planDataList)
end

function EditPlanListDlg:onPlanListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or BtnEquipPlanWithPlayMode(sender, "System/Bag/WearingPlanCell", newIdx)

	if not self.planDataList or #self.planDataList == 0 then
		return
	end

	if self.planDataList[newIdx] ~= nil then
		targetCell:setPlan(self.planDataList[newIdx])
		targetCell:setSelectCallback(Slot(self.selectPlanCallBack, self))
	end

	self.btnEquipPlanList[newIdx] = targetCell
end

function EditPlanListDlg:selectPlanCallBack(btnEquipPlanWithPlayMode)
	self.selectPlan = btnEquipPlanWithPlayMode.plan

	self:onBtnConfirm()
end

function EditPlanListDlg:onBtnDeny()
	self:setVisible(false)
end

function EditPlanListDlg:onBtnConfirm()
	if self.selectPlan.id == Const.EQUIP_PLAN_CREATE_ID then
		local editProgramDlg = UIManager.getUI("editProgramDlg", true)

		if self.battleType then
			editProgramDlg:setPlan(self.planDataList[1], nil, self.battleType)
		else
			editProgramDlg:setPlan(self.planDataList[1])
		end

		self:setVisible(false)
	else
		self.opPlanId = self.selectPlan.id

		local oldPlanData = CurAvatar.equipPlanDic[self.opPlanId]

		self.newPlanData = CurAvatar:genNewPlanData(oldPlanData.name)
		self.syncPlans = CurAvatar:getNeedUpdateHeroInAllProgram(oldPlanData, self.newPlanData)
		self.isShowSync = false

		if utils.getTableElemCount(self.syncPlans) > 0 then
			self.isShowSync = true
		end

		local function yesFunc()
			local planItem = CurAvatar:getPlanItembyPlanData(self.newPlanData)
			local rpcData = {
				{
					item_id = self.opPlanId,
					item = planItem,
					name = planItem.name
				}
			}
			local update = 1
			local isSync = UserData.loadCommonData("DefaultSync")

			if isSync == "1" and self.isShowSync then
				for i, plan in pairs(self.syncPlans or {}) do
					table.insert(rpcData, plan)
				end
			end

			RPC.equipSchemeUpdate(rpcData, CurAvatar.equipPlanVersion, update)

			CurAvatar.oldCurWearData = CurAvatar:genNewPlanData(Lang.get(551))
			CurAvatar.coverPlanID = self.opPlanId
		end

		local coverPlanPanel = UIManager.getUI("coverAndSyncPlan", true)

		coverPlanPanel:show(self.selectPlan.id, 1059, yesFunc, nil, nil, nil, self.isShowSync)
		self:setVisible(false)
	end
end

function EditPlanListDlg:onTipClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_ASYNCPVP)
end

return EditPlanListDlg
