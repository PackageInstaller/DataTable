-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mofang/view/MofangLockTipView.lua

module("logic.extensions.mofang.view.MofangLockTipView", package.seeall)

local MofangLockTipView = class("MofangLockTipView", ViewComponent)

function MofangLockTipView:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
end

function MofangLockTipView:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._btnCollect:RemoveClickListener()
	self._btnTask:RemoveClickListener()
end

function MofangLockTipView:buildUI()
	self._closeBtn = self:getBtn("btnClose")
	self._txt = goutil.findChild(self.mainGO, "Nego_Main/txtTitle"):GetComponent("Text")
	self._btnTask = self:getBtn("Nego_Main/task/btnTask")
	self._txtTask = goutil.findChildComponent(self.mainGO, "Nego_Main/task/Text", "Text")
	self._pets = {}

	for i = 1, 2 do
		local pet = {}

		pet.mainGO = goutil.findChild(self.mainGO, "Nego_Main/collect/pets/pet" .. i)
		pet.txtName = goutil.findChildComponent(pet.mainGO, "txtName", "Text")
		pet.icon = goutil.findChildComponent(pet.mainGO, "icon", "Image")
		pet.btnGet = Framework.ButtonAdapter.GetFrom(pet.mainGO, "btnGet")
		pet.goReceived = goutil.findChild(pet.mainGO, "received")

		table.insert(self._pets, pet)
	end

	self._goPets = goutil.findChild(self.mainGO, "Nego_Main/collect")
	self._goTask = goutil.findChild(self.mainGO, "Nego_Main/task")
end

function MofangLockTipView:destroyUI()
	return
end

function MofangLockTipView:onExit()
	printInfo("MofangLockTipView:onExit")
end

local magicLockType = {
	"挑战",
	"任务",
	"场景",
	"功能"
}
local taskTypeLang = {
	[GameEnum.TaskType.Main] = lang("task_main_shortcut"),
	[GameEnum.TaskType.Branch] = lang("task_branch_shortcut"),
	[GameEnum.TaskType.Guide] = lang("task_guide_shortcut"),
	[GameEnum.TaskType.Daily] = lang("task_daily_shortcut")
}
local taskTypeToTaskViewTab = {
	[GameEnum.TaskType.Main] = GameEnum.TaskViewTab.Main,
	[GameEnum.TaskType.Branch] = GameEnum.TaskViewTab.Branch,
	[GameEnum.TaskType.Guide] = GameEnum.TaskViewTab.Guide,
	[GameEnum.TaskType.Daily] = GameEnum.TaskViewTab.Daily
}

function MofangLockTipView:onEnter()
	printInfo("MofangLockTipView:onEnter")

	local param = self._viewPresentor:getFirstParam()
	local curLv = MofangModel.instance:getCurLv()
	local cfg = MofangConfig.instance:getCfgById(curLv)

	self._txt.text = langPara("人物等级达到<color=#ffdd3c>%s级</color>后解锁%s<color=#ffa92e>%s</color>", param.lv, magicLockType[param.lockType] or "", param.name)

	local str = ""

	self._jumpToTaskType = cfg.taskType[#cfg.taskType]

	for i = 1, #cfg.taskType do
		str = string.nilorempty(str) and str .. taskTypeLang[cfg.taskType[i]] or string.format("%s、%s", str, taskTypeLang[cfg.taskType[i]])
	end

	local len = 0

	self._txtTask.text = len > 0 and string.format("1.去完成%s任务", str) or string.format("升阶途径：去完成%s任务", str)

	goutil.setActive(self._goPets, len > 0)
	Framework.TransformUtil.SetLocalPos(self._goTask.transform, len > 0 and -170 or 0, 105, 0)

	for i = 1, 2 do
		if i <= len then
			local petId = checknumber(cfg.onekeyIdList[i])
			local modelCo = CharacterConfig.instance:getModelCo(petId)

			if modelCo ~= nil then
				uGuiUtil.setSpriteToImage(self._pets[i].icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
			end

			local petCfg = CharacterConfig.instance:getPetCo(petId)

			if petCfg ~= nil then
				self._pets[i].txtName.text = petCfg.name
			end

			self._pets[i].btnGet:RemoveClickListener()
			self._pets[i].btnGet:AddClickListener(function()
				self:_onClickCollect(petId)
			end)
			goutil.setActive(self._pets[i].mainGO, true)
			Framework.TransformUtil.SetLocalPos(self._pets[i].mainGO.transform, (len >= 2 or nil) and (140 * i - 210 or 0), 0, 0)

			local isHas = PetsHandBookModel.instance:isHasPet(petId)

			goutil.setActive(self._pets[i].goReceived, isHas)
			uGuiUtil.setGoGrayState(self._pets[i].btnGet.gameObject, isHas)
		else
			goutil.setActive(self._pets[i].mainGO, false)
		end
	end
end

function MofangLockTipView:_onClickClose()
	printInfo("MofangLockTipView _onClickClose")
	self:close()
end

function MofangLockTipView:_onClickTask()
	self:close()
	UIStateManager.instance:closeAllModalViews()
	UIStateManager.instance:push("diamondtask", taskTypeToTaskViewTab[self._jumpToTaskType])
end

function MofangLockTipView:_onClickCollect(petId)
	local isHas = PetsHandBookModel.instance:isHasPet(petId)

	if isHas then
		FloatWordMgr.instance:show("精灵已经获得")

		return
	end

	local isExist = PetsHandbookFacade.instance:getDefaultWays(petId, nil, ViewName.MofangLockTip)

	if not isExist then
		FloatWordMgr.instance:show("该精灵配置不存在")
	end
end

return MofangLockTipView
