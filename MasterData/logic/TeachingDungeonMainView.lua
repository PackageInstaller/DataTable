-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingDungeonMainView.lua

module("logic.extensions.teachingdungeon.view.TeachingDungeonMainView", package.seeall)

local TeachingDungeonMainView = class("TeachingDungeonMainView", TableViewComponent)
local itemSpace = 90

function TeachingDungeonMainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function TeachingDungeonMainView:ctor()
	TeachingDungeonMainView.super.ctor(self)

	self.model = TeachingDungeonModel.instance
	self._currStageId = false
end

function TeachingDungeonMainView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._levelBtn1:AddClickListener(self._onClickLevel1, self)
	self._levelBtn2:AddClickListener(self._onClickLevel2, self)
	self._levelBtn3:AddClickListener(self._onClickLevel3, self)
end

function TeachingDungeonMainView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._levelBtn1:RemoveClickListener()
	self._levelBtn2:RemoveClickListener()
	self._levelBtn3:RemoveClickListener()
end

function TeachingDungeonMainView:buildUI()
	TeachingDungeonMainView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnEnter = self:getBtn("btnEnter")
	self._txtTeaching = goutil.findChildTextComponent(self.mainGO, "ScrollView/Nego_Viewport/Nego_Content")
	self._trTxtTeaching = self._txtTeaching.transform
	self._rewardConGo = self:getGo("rewardCon")
	self._rewardCell = self:getGo("rewardCon/cell")
	self._pfRewardConGo = self:getGo("pfRewardCon")
	self._pfRewardCell = self:getGo("pfRewardCon/cell")
	self._enemyPetConGo = self:getGo("enemyPetCon")
	self._enemyPetCell = self:getGo("enemyPetCon/cell")
	self._myCurViewDatas = {}
	self._myPetConGo = self:getGo("myPetCon")
	self._myPetTableview = self:getGo("myPetCon/ScrollView"):GetComponent(ComponentType.UITableview)
	self._myPetCell = self:getGo("myPetCon/cell")

	self._myPetTableview:RegisterCallback(self._mynumInView, self._mycellSize, self._mycellAtIndex, self)

	self._rewadGroup = ItemGroup.New(self._rewardConGo, self._rewardCell, nil, nil, true)
	self._pfrewadGroup = ItemGroup.New(self._pfRewardConGo, self._pfRewardCell, nil, nil, true)
	self._enemyPetGroup = ItemGroup.New(self._enemyPetConGo, self._enemyPetCell, nil, nil, true)
	self._levelBtn1 = self:getBtn("levelBtns/levelBtn1")
	self._levelBtn2 = self:getBtn("levelBtns/levelBtn2")
	self._levelBtn3 = self:getBtn("levelBtns/levelBtn3")
	self._levelBtnChange1 = self._levelBtn1.gameObject:GetComponent(typeof(UIChangeGroup))
	self._levelBtnChange2 = self._levelBtn2.gameObject:GetComponent(typeof(UIChangeGroup))
	self._levelBtnChange3 = self._levelBtn3.gameObject:GetComponent(typeof(UIChangeGroup))
	self._imgPerfect1 = goutil.findChild(self._levelBtn1, "imgPerfect")
	self._imgPerfect2 = goutil.findChild(self._levelBtn2, "imgPerfect")
	self._imgPerfect3 = goutil.findChild(self._levelBtn3, "imgPerfect")
	self._imgYtg1 = goutil.findChild(self._levelBtn1, "imgYtg")
	self._imgYtg2 = goutil.findChild(self._levelBtn2, "imgYtg")
	self._imgYtg3 = goutil.findChild(self._levelBtn3, "imgYtg")
	self._imgLock1 = goutil.findChild(self._levelBtn1, "imgLock")
	self._imgLock2 = goutil.findChild(self._levelBtn2, "imgLock")
	self._imgLock3 = goutil.findChild(self._levelBtn3, "imgLock")
	self._tipsText = goutil.findChildTextComponent(self.mainGO, "tipsText")
end

function TeachingDungeonMainView:destroyUI()
	return
end

function TeachingDungeonMainView:onEnter()
	TeachingDungeonMainView.super.onEnter(self)

	local is_require = self.model.is_require

	if is_require then
		self:_initLevelBtnData()
	else
		GlobalDispatcher:addListener(TeachingDungeonModel.RefreshBitInfo, self._initLevelBtnData, self)
		TeachingDungeonController.instance:sendBC_ProcessInfoReq()
	end

	if TeachingDungeonController.instance.failedStageId then
		UIStateManager.instance:push(ViewName.TeachingDungeonTip, {
			tag = 1,
			isFail = true,
			stageId = TeachingDungeonController.instance.failedStageId
		})

		TeachingDungeonController.instance.failedStageId = false
	end

	self._tipsText.text = TeachingDungeonConfig.instance:getTitleDesc()

	TeachingDungeonModel.instance:clearDailyRed()
end

function TeachingDungeonMainView:onEnterFinished()
	return
end

function TeachingDungeonMainView:onExit()
	TeachingDungeonMainView.super.onExit(self)
	GlobalDispatcher:removeListener(TeachingDungeonModel.RefreshBitInfo, self._initLevelBtnData, self)

	self._curViewDatas = nil

	self._rewadGroup:dispose(function(item)
		local component = TeachingRewardItem.AddOnce(item.mainGO)

		component:onExit()
	end)
	self._pfrewadGroup:dispose(function(item)
		local component = TeachingRewardItem.AddOnce(item.mainGO)

		component:onExit()
	end)
	self._enemyPetGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
	self._myPetTableview:Travel(self._clearMypetTableview, self)
end

function TeachingDungeonMainView:onExitFinished()
	return
end

function TeachingDungeonMainView:_cellSize()
	return 100, 85
end

function TeachingDungeonMainView:_updateCell(view, cell, data)
	local function clickCall(stageId)
		self:_switchTab(stageId)
	end

	local item = TeachingDungeonTabItem.AddOnce(cell)

	item:setData(data, self._currStageId, clickCall)
end

function TeachingDungeonMainView:_clearTableview(cell)
	return
end

function TeachingDungeonMainView:_clearMypetTableview(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function TeachingDungeonMainView:_onReloadFinish()
	self:_switchTab(self._currStageId, true)
end

function TeachingDungeonMainView:_onClickClose()
	self:close()
end

function TeachingDungeonMainView:_onClickEnter()
	if not self.model.is_require then
		FloatWordMgr.instance:show("数据加载中，请稍后再试")

		return
	end

	UIStateManager.instance:push(ViewName.TeachingMissionView)
end

function TeachingDungeonMainView:_switchTab(stageId, force)
	if not self.model.is_require then
		return
	end

	if self._currStageId == stageId and not force then
		return
	end

	if not self.model:isStageOpen(stageId) then
		local str = self.model:getStageOpenDesc(stageId)

		FloatWordMgr.instance:show(str)

		return
	end

	self._currStageId = stageId

	self.model:setCurrStageId(stageId)
	self:_updateView()
	self._tableview:Refresh()

	if not self.forset then
		self.forset = true

		for i, v in ipairs(self._curViewDatas) do
			if v.stageId == stageId then
				self._tableview:ForceMoveCellToCenter(i - 1)
			end
		end
	end
end

function TeachingDungeonMainView:_updateView()
	if not self._currStageId then
		return
	end

	self:_updateDesc()
	self:_updateMyPet()
	self:_updateEnemyPet()
	self:_updateReward()
end

function TeachingDungeonMainView:_updateDesc()
	self._txtTeaching.text = TeachingDungeonConfig.instance:getStageDesc()
	self._trTxtTeaching.sizeDelta = Vector2.New(self._trTxtTeaching.sizeDelta.x, self._txtTeaching.preferredHeight)
end

function TeachingDungeonMainView:_updateMyPet()
	self._myCurViewDatas = self.model:getAllPets()

	self._myPetTableview:ReloadData()
end

function TeachingDungeonMainView:_updateMyPetItem(item, index)
	local space = itemSpace

	GameUtil.setLocalPos(item.mainGO, space * (index - 1), 0, 0)

	local petData = self._myPetList[index]

	if petData then
		MaterialMgr.setCellByData(MatType.Pet, petData, item.mainGO)
	end
end

function TeachingDungeonMainView:_mynumInView()
	if not self._myCurViewDatas then
		return 0
	end

	return #self._myCurViewDatas
end

function TeachingDungeonMainView:_mycellSize()
	return 90, 90
end

function TeachingDungeonMainView:_mycellAtIndex(view, idx)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._myPetCell)

	local data = self._myCurViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateMyCell(view, cell, data)

	return cell
end

function TeachingDungeonMainView:_updateMyCell(view, cell, data)
	local petData = self._myCurViewDatas[cell.data]

	if petData then
		MaterialMgr.setCellByData(MatType.Pet, petData, cell.gameObject)
	end
end

function TeachingDungeonMainView:_updateEnemyPet()
	self._enemyPetList = self.model:getAllPets(true)

	local list = self._enemyPetList

	if list then
		self._enemyPetGroup:updateWithLen(#list, self._updateEnemyPetItem, self)
	end
end

function TeachingDungeonMainView:_updateEnemyPetItem(item, index)
	local space = itemSpace

	GameUtil.setLocalPos(item.mainGO, space * (index - 1), 0, 0)

	local petData = self._enemyPetList[index]

	if petData then
		MaterialMgr.setCellByData(MatType.Pet, petData, item.mainGO)
	end
end

function TeachingDungeonMainView:_updateReward()
	self._reward_list = TeachingDungeonConfig.instance:getRewardListByStageId(self._currStageId)

	local list = self._reward_list

	if list then
		self._rewadGroup:updateWithLen(#list, self._updateRewardItem, self)
	end

	self:_updatePfReward()
end

function TeachingDungeonMainView:_updatePfReward()
	self._pfRewardList = TeachingDungeonConfig.instance:getPfRewardListByStageId(self._currStageId)

	if self._pfRewardList then
		self._pfrewadGroup:updateWithLen(#self._pfRewardList, self._updatePfRewardItem, self)
	end
end

function TeachingDungeonMainView:_updateRewardItem(item, index)
	local component = TeachingRewardItem.AddOnce(item.mainGO)

	GameUtil.setLocalPos(item.mainGO, itemSpace * (index - 1), 0, 0)
	component:setData(self._reward_list[index], false)
end

function TeachingDungeonMainView:_updatePfRewardItem(item, index)
	local component = TeachingRewardItem.AddOnce(item.mainGO)

	GameUtil.setLocalPos(item.mainGO, itemSpace * (index - 1), 0, 0)
	component:setData(self._pfRewardList[index], true)
end

function TeachingDungeonMainView:_initLevelBtnData()
	GlobalDispatcher:removeListener(TeachingDungeonModel.RefreshBitInfo, self._initLevelBtnData, self)

	self._currLevel = false

	local prePass = true
	local isSwitch = false

	for level = 1, 3 do
		local hasCfg = TeachingDungeonModel.instance:hasLevelCfg(level)
		local isPass = TeachingDungeonModel.instance:isLevelPass(level)
		local isPerfect = TeachingDungeonModel.instance:isLevelPerfect(level)

		GameUtil.SetActive(self["_imgPerfect" .. level], isPerfect)
		GameUtil.SetActive(self["_imgYtg" .. level], not isPerfect and isPass)
		GameUtil.SetActive(self["_imgLock" .. level], not hasCfg or not prePass)

		if not isPass and not self._currLevel then
			if hasCfg then
				isSwitch = true

				self:_switchLevel(level)
			else
				isSwitch = true

				self:_switchLevel(level - 1)
			end
		end

		prePass = isPass

		if level == 3 and hasCfg and not isSwitch then
			self:_switchLevel(level)
		end
	end
end

function TeachingDungeonMainView:_switchLevel(level, force)
	if not self.model.is_require then
		return
	end

	if self._currLevel == level and not force then
		return
	end

	local lastLevelIsPass = level == 1

	lastLevelIsPass = lastLevelIsPass or TeachingDungeonModel.instance:isLevelPass(level - 1)

	if not TeachingDungeonModel.instance:hasLevelCfg(level) then
		FloatWordMgr.instance:show("敬请期待")

		return
	elseif not lastLevelIsPass then
		FloatWordMgr.instance:show("先通关上一阶段所有关卡")

		return
	end

	self._currLevel = level

	self._levelBtnChange1:SetState(level == 1 and 1 or 0)
	self._levelBtnChange2:SetState(level == 2 and 1 or 0)
	self._levelBtnChange3:SetState(level == 3 and 1 or 0)

	self._curViewDatas = TeachingDungeonConfig.instance:getStageCfgByLevel(level)

	for i, v in ipairs(self._curViewDatas) do
		self._currStageId = v.stageId

		if not TeachingDungeonModel.instance:isStagePass(v.stageId) then
			break
		end
	end

	self.forset = false

	self:reloadData()
end

function TeachingDungeonMainView:_onClickLevel1()
	self:_switchLevel(1)
end

function TeachingDungeonMainView:_onClickLevel2()
	self:_switchLevel(2)
end

function TeachingDungeonMainView:_onClickLevel3()
	self:_switchLevel(3)
end

return TeachingDungeonMainView
