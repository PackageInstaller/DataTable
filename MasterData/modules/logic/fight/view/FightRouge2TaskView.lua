-- chunkname: @modules/logic/fight/view/FightRouge2TaskView.lua

module("modules.logic.fight.view.FightRouge2TaskView", package.seeall)

local FightRouge2TaskView = class("FightRouge2TaskView", FightBaseView)

function FightRouge2TaskView:onInitView()
	self.btnLevel = gohelper.findChildButton(self.viewGO, "root/#btn_level")
	self.animator = self.btnLevel:GetComponent(gohelper.Type_Animator)
	self.imageRare = gohelper.findChildImage(self.viewGO, "root/#btn_level/#image_rare")
	self.imageLevelBg = gohelper.findChildImage(self.viewGO, "root/#btn_level/#image_levelbg")
	self.imageLevel = gohelper.findChildImage(self.viewGO, "root/#btn_level/#image_level")
	self.goTip = gohelper.findChild(self.viewGO, "root/#go_Tips")
	self.btnCloseTip = gohelper.findChildClickWithDefaultAudio(self.goTip, "#btn_click")
	self.txtTitle = gohelper.findChildText(self.goTip, "tips/#scroll_dec/viewport/content/#txt_title")
	self.txtDesc = gohelper.findChildText(self.goTip, "tips/#scroll_dec/viewport/content/#txt_descitem")
	self.goDesc = self.txtDesc.gameObject
	self.descItemList = self:getUserDataTb_()
end

function FightRouge2TaskView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.TaskDataUpdate, self.onTaskDataUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnIndicatorChange, self.onIndicatorChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.AfterCorrectData, self.onAfterCorrectData, self)
	self.btnLevel:AddClickListener(self.onClick, self)
	self.btnCloseTip:AddClickListener(self.hideDesc, self)
end

function FightRouge2TaskView:removeEvents()
	self.btnLevel:RemoveClickListener()
	self.btnCloseTip:RemoveClickListener()
end

function FightRouge2TaskView:onAfterCorrectData()
	self:refreshUI()
end

function FightRouge2TaskView:onIndicatorChange(indicatorId, effectNum)
	self.animator:Play("add", 0, 0)
	self:refreshUI()
end

function FightRouge2TaskView:onTaskDataUpdate()
	self.animator:Play("add", 0, 0)
	self:refreshUI()
end

function FightRouge2TaskView:onClick()
	self:showDesc()
end

function FightRouge2TaskView:onOpen()
	self:hideDesc()
	self:refreshUI()
end

function FightRouge2TaskView:refreshUI()
	local level, taskId, progress = FightHelper.getRouge2FunnyTaskCurLevelAndTaskIdAndProgress()

	self:refreshIcon(level, progress)
	self:refreshDesc()

	if self.preLevel ~= level then
		self.animator:Play("switch", 0, 0)
	end

	self.preLevel = level
end

FightRouge2TaskView.Duration = 0.3

function FightRouge2TaskView:refreshIcon(curLevel, progress)
	local levelName = curLevel and FightEnum.Rouge2FunnyTaskLevelName[curLevel]
	local co = levelName and lua_fight_rouge2_level.configDict[levelName]

	if not co then
		logError("评级配置不存在 level ：" .. tostring(levelName))

		co = lua_fight_rouge2_level.configList[1]
	end

	UISpriteSetMgr.instance:setRouge7Sprite(self.imageRare, co.rare)
	UISpriteSetMgr.instance:setRouge7Sprite(self.imageLevelBg, co.bgIcon)
	UISpriteSetMgr.instance:setRouge7Sprite(self.imageLevel, co.icon)
	self:clearTweenId()

	self.tweenId = ZProj.TweenHelper.DOFillAmount(self.imageLevel, progress, FightRouge2TaskView.Duration)
end

function FightRouge2TaskView:clearTweenId()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FightRouge2TaskView:refreshDesc()
	local startTaskId = FightHelper.getRouge2FunnyTaskStartId()
	local co = startTaskId and lua_rouge2_funnyfight_event.configDict[startTaskId]

	if not co then
		logError(string.format("肉鸽趣味任务配置不存在 funnyTaskId = %s", startTaskId))

		co = lua_rouge2_funnyfight_event.configList[1]
	end

	self.txtTitle.text = co.fightTaskDesc

	local indicatorId = co.idIndicator
	local value = FightDataHelper.fieldMgr:getIndicatorNum(indicatorId)

	self.txtDesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(co.fightTaskDetail, value)

	for _, descItem in ipairs(self.descItemList) do
		gohelper.setActive(descItem.gameObject, false)
	end

	local taskId = co.nextTask

	for index = 1, 10 do
		if not taskId or taskId == 0 then
			return
		end

		local taskCo = lua_rouge2_funnyfight_event.configDict[taskId]

		if not taskCo then
			logError(string.format("肉鸽趣味任务配置不存在 funnyTaskId = %s", taskId))

			return
		end

		local descItem = self.descItemList[index]

		if not descItem then
			local goDescItem = gohelper.cloneInPlace(self.goDesc)

			descItem = goDescItem:GetComponent(gohelper.Type_TextMesh)

			table.insert(self.descItemList, descItem)
		end

		gohelper.setActive(descItem.gameObject, true)

		descItem.text = taskCo.fightTaskDetail
		taskId = taskCo.nextTask
	end
end

function FightRouge2TaskView:showDesc()
	gohelper.setActive(self.goTip, true)
end

function FightRouge2TaskView:hideDesc()
	gohelper.setActive(self.goTip, false)
end

function FightRouge2TaskView:onDestroyView()
	self:clearTweenId()
end

return FightRouge2TaskView
