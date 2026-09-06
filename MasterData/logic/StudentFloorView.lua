-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/studenttask/StudentFloorView.lua

module("logic.extensions.tutorsystem.view.studenttask.StudentFloorView", package.seeall)

local StudentFloorView = class("StudentFloorView", ViewComponent)

function StudentFloorView:buildUI()
	StudentFloorView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._tabCol = goutil.findChild(self.mainGO, "tabCol")
	self._tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._ScrollRect = goutil.findChild(self.mainGO, "sliderCol/ScrollRect")
	self._progressBar = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/progressBar")
	self._content = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content")
	self._gridView = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridView")
	self._gridCell = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridCell")
	self._gridLayout = self._gridView:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

	local exParams = {
		Content = self._content,
		cellGroup = self._gridView,
		progressBar = self._progressBar
	}

	self._progressList = ProgressList.create(self._ScrollRect, self._gridCell, GameUtil.handler(self._updateProgressGrid, self), GameUtil.handler(self._clearProgressCell, self), exParams)
	self._txtTotalDesc = goutil.findChildTextComponent(self.mainGO, "sliderCol/totalCol/txtTotalDesc")
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._gridEffList = {}
end

function StudentFloorView:bindEvents()
	StudentFloorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StudentFloorView:unbindEvents()
	StudentFloorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function StudentFloorView:onEnter()
	StudentFloorView.super.onEnter(self)

	self._curTabIdx = self._curTabIdx or 1

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.TutorStuTaskFloorCloseSignal, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentGainGrowthTaskPrizeRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentGainProgressPrizeRes, self._handleGainProgressPrizeRes, self)
	self:_onUpdate()
end

function StudentFloorView:onExit()
	StudentFloorView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStuTaskFloorCloseSignal, self.close, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentGainGrowthTaskPrizeRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentGainProgressPrizeRes, self._handleGainProgressPrizeRes, self)
	self._tabScrollList:dispose()
	self._progressList:dispose()
end

function StudentFloorView:_handleGainProgressPrizeRes(msg)
	if msg.finish == true then
		self:close()
		TutorSystemController.instance:popTipByKey(GameEnum.TsNotifyKey.GraduatedOfMySelf)
	else
		self:_sendInfoReq()
	end
end

function StudentFloorView:_sendInfoReq()
	TutorSystemController.instance:sendTutorStudentTaskInfoReq()
end

function StudentFloorView:_onSetUI()
	return
end

function StudentFloorView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StudentFloorView:_onUpdateData()
	self:_updateTabData()
end

function StudentFloorView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_onUpdateSliderCol()
	self:_showTabAt()
end

function StudentFloorView:_updateTabData()
	local tutorRedData_1 = TutorSystemConfig.instance:getTsRedDataByType(1)
	local baseTaskRedId
	local tutorRedData_5 = TutorSystemConfig.instance:getTsRedDataByType(5)
	local growthTaskRedId

	self._tabDataList = {
		{
			name = "基础任务",
			viewName = ViewName.StudentBaseTaskView,
			redIdList = {
				(tutorRedData_1 and not string.nilorempty(tutorRedData_1.masterRedId) or nil) and tutorRedData_1.masterRedId
			}
		},
		{
			name = "老师任务",
			viewName = ViewName.StudentGrowthTaskView,
			redIdList = {
				(tutorRedData_5 and not string.nilorempty(tutorRedData_5.masterRedId) or nil) and tutorRedData_5.masterRedId
			}
		}
	}
end

function StudentFloorView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function StudentFloorView:_updateTabCell(view, cell, data, tag)
	local idx = cell.index + 1
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local UIChangeGroup = mainGo:GetComponent(typeof(UIChangeGroup))

	txtName.text = data.name

	if #data.redIdList == 0 then
		GameUtil.SetActive(redPoint, false)
	else
		RedPointController.instance:regRedPoint(redPoint, unpack(data.redIdList))
	end

	UIChangeGroup:SetState(self._curTabIdx == idx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, idx))
end

function StudentFloorView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
end

function StudentFloorView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function StudentFloorView:_showTabAt()
	local data = self._tabDataList[self._curTabIdx]

	if data.params then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.params))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function StudentFloorView:_onUpdateSliderCol()
	self:_onUpdateTotal()
	self:_updateProgressSlider()
	self:_updateProgressGrids()
end

function StudentFloorView:_onUpdateTotal()
	local curProgress = TutorSystemModel.instance:getProgressScoreInStuTask()
	local maxProgress = TutorSystemConfig.instance:getTsStuPrizeMaxProgress()

	self._txtTotalDesc.text = maxProgress <= curProgress and "活跃度已满" or curProgress
end

function StudentFloorView:_updateProgressSlider()
	return
end

function StudentFloorView:_updateProgressGrids()
	local prizeCfg = TutorSystemConfig.instance:getTsStuPrizeCfg()

	self._progressList:reloadDataList(prizeCfg)
	self._progressList:updateCell()

	local curProgress = TutorSystemModel.instance:getProgressScoreInStuTask()
	local proList = {}

	for _, data in ipairs(prizeCfg) do
		table.insert(proList, data.scoreLimit)
	end

	self._progressList:updateProgressByList(proList, curProgress)

	local index = 0

	for idx, data in ipairs(prizeCfg) do
		if TutorSystemController.instance:isCanGetScorePrizeInStuTask(data.prizeId) then
			index = idx

			break
		end
	end

	if index ~= 0 then
		self._progressList:rollToIdx(index)
	else
		self._progressList:rollToIdxNewest(proList, curProgress)
	end
end

function StudentFloorView:_updateProgressGrid(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local effectParent = goutil.findChild(mainGo, "effect")
	local isHasGain = TutorSystemController.instance:isHasGainScorePrizeInStuTask(data.prizeId)
	local isCanGet = TutorSystemController.instance:isCanGetScorePrizeInStuTask(data.prizeId)

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, item, urlOrGo, luaCls, isOne)
	end

	if txtNum then
		txtNum.text = data.scoreLimit
	end

	GameUtil.SetActive(receivedGo, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)
	UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._ScrollRect:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._gridEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGridCell, self, data))
end

function StudentFloorView:_clearAllProgressGrid()
	for _, mainGo in ipairs(self.gridList) do
		local item = goutil.findChild(mainGo, "item/itemcell")
		local btnGet = goutil.findChild(mainGo, "btnGet")

		MaterialMgr.resetAll(item)
		GameUtil.rmClickHandler(btnGet)
		UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])
	end
end

function StudentFloorView:_clearProgressCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])
end

function StudentFloorView:_onClickGridCell(data)
	if not TutorSystemController.instance:isHasGainPreScorePrizesInStuTask(data.prizeId) then
		FloatWordMgr.instance:show("前面的奖励未领取")

		return
	end

	if data.isFinishTutor == true and not TutorSystemController.instance:isAllEnoughBaseTaskInStuTask() then
		FloatWordMgr.instance:show("未完成所有基础任务")

		return
	end

	TutorSystemController.instance:sendTutorStudentGainProgressPrizeReq(data.prizeId)
end

return StudentFloorView
