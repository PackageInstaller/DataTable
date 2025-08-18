-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeAwardDlg.lua

local ResAchieve = require("ClientData/ResAchieve")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "LayerAwardCell"
local LayerAwardCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function LayerAwardCell:ctor(...)
	self:initUI()
end

function LayerAwardCell:initUI(...)
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.textRule = UIControls.Label(self, "ContentPanel/TextRule")
	self.textState = UIControls.Label(self, "ContentPanel/TextState")
	self.awardCells = {}
end

function LayerAwardCell:setData(layerData)
	self.layerData = layerData

	self.textRule:setText(self.layerData.desc)
	ClientUtils.CreateBonusGrid(self, self.awardCells, "ContentPanel/AwardPanel", self.layerData.award)

	if self.isTalentAchieve then
		local progress = self.mParent.actData:getNewMazeAchieveProgress(self.layerData.type)

		if progress >= self.layerData.param then
			self.textState:setText(Lang.get(98))
			self.panelContent:playStateAnimator("RogueLayerAwardCellSel")
		else
			self.textState:setText(Lang.get(99))
			self.panelContent:playStateAnimator("RogueLayerAwardCellNml")
		end
	elseif self.mParent.layerIndex >= self.mIndex then
		self.textState:setText(Lang.get(98))
		self.panelContent:playStateAnimator("RogueLayerAwardCellSel")
	else
		self.textState:setText(Lang.get(99))
		self.panelContent:playStateAnimator("RogueLayerAwardCellNml")
	end
end

local strClassName = "AchiAwardCell"
local AchiAwardCell = Class(strClassName, UIControls.Child)

function AchiAwardCell:ctor(...)
	self:initUI()
end

function AchiAwardCell:initUI(...)
	self.AniAchiCell = UIControls.UIAni(self, "")

	self.AniAchiCell:addEventFinish(self._introAnimEnd)

	self.image = UIControls.Image(self, "")
	self.textRule = UIControls.Label(self, "TextRule")
	self.slider = UIControls.Slider(self, "Slider")
	self.textProgress = UIControls.Label(self, "Slider/TextProgress")
	self.textState = UIControls.Label(self, "TextState")
	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.awardCells = {}
end

function AchiAwardCell:setData(data)
	self.data = data

	self.textRule:setText(self.data.desc_name)
	ClientUtils.CreateBonusGrid(self, self.awardCells, "AwardPanel", self.data.award, true, nil, true)

	self.actObj = CurAvatar:getActivityObj(self.data.detail_id)

	if self.actObj then
		self.state = self.actObj.actData:getAchieveState(self.data.type, self.data.index)

		local _pro, maxPro = self.actObj.actData:getAchieveShowProgress(self.data)

		self.textProgress:setText(string.format("%d/%d", _pro, maxPro))
		self.slider:setValue(_pro / maxPro)
		self.slider:setVisible(true)
		self.btnConfirm:setVisible(self.state == Const.ACT_ACHIEVE_STATE_ENOUGH)

		if self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			self.image:setImage("Atlas/RogueAtlas/RogueAtlas", "BgEntry")
			self.textState:setVisible(false)
		elseif self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			self.image:setImage("Atlas/RogueAtlas/RogueAtlas", "BgNml")
			self.textState:setText(Lang.get(99))
			self.textState:setVisible(true)
		else
			self.image:setImage("Atlas/RogueAtlas/RogueAtlas", "BgNml")
			self.slider:setVisible(false)
			self.textState:setText(Lang.get(74))
			self.textState:setVisible(true)

			for _, item in ipairs(self.awardCells) do
				item:setGet(true)
			end
		end
	end
end

function AchiAwardCell:onBtnConfirmClick(sender)
	if self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.btnConfirm:setVisible(false)
		self.AniAchiCell:startAni("ChangeRogueAimAwardCell", true)
	end
end

function AchiAwardCell:_introAnimEnd()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, self.data.index, self.data.type), self.actObj.opId)
end

local strClassName = "NewMazeAwardDlg"
local NewMazeAwardDlg = Class(strClassName, UIControls.Window)

function NewMazeAwardDlg:ctor(...)
	self:initUI()
end

function NewMazeAwardDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.tabPoint = UIControls.Button(self, "BgPanel/TabPoint")

	self.tabPoint:addEventClick(self.onTabPointClick)

	self.iconActiveNew = UIControls.Image(self, "BgPanel/TabPoint/IconNew")
	self.tabAim = UIControls.Button(self, "BgPanel/TabAim")

	self.tabAim:addEventClick(self.onTabAimClick)

	self.iconAchiNew = UIControls.Image(self, "BgPanel/TabAim/IconNew")
	self.tabSkill = UIControls.Button(self, "BgPanel/TabSkill")

	self.tabSkill:addEventClick(self.onTabSkillClick)

	self.textTimePoint = UIControls.Label(self, "BgPanel/TextTimePoint")
	self.textTimeAim = UIControls.Label(self, "BgPanel/TextTimeAim")
	self.activeAwardPanel = UIControls.Panel(self, "BgPanel/PointAwardPanel/ActiveAwardPanel")
	self.bgTextActive = UIControls.Panel(self, "BgPanel/PointAwardPanel/BgTextActive")
	self.layerAwardList = UIControls.Panel(self, "BgPanel/PointAwardPanel/LayerAwardList")
	self.aimAwardPanel = UIControls.Panel(self, "BgPanel/AimAwardList")
	self.pointAwardPanel = UIControls.Panel(self, "BgPanel/PointAwardPanel")
	self.skillAwardPanel = UIControls.Panel(self, "BgPanel/SkillAwardList")
	self.scrollLayer = UIControls.ScrollViewLoopV(self, "BgPanel/PointAwardPanel/LayerAwardList", 0, self.onLayerCellChanged)
	self.layerCells = {}
	self.scrollAchi = UIControls.ScrollViewLoopV(self, "BgPanel/AimAwardList", 0, self.onAchiCellChanged)
	self.achiCells = {}
	self.skillAwardList = UIControls.ScrollViewLoopV(self, "BgPanel/SkillAwardList", 0, self.onSkillCellChanged)
	self.skillAwardCell = {}
	self.page = 1
end

function NewMazeAwardDlg:setData()
	self.layerAwardData = {}
	self.actData = CurAvatar:getNewMazeActData()
	self.layerAwardData = self.actData:getLayerAwardData()
	self.achiAwardData = self.actData:getAchiAwardData()
	self.activeAwardData = self.actData:getActiveAwardData()
	self.skillAwardData = self.actData:getSkillAwardData()

	self.tabAim:setVisible(#self.achiAwardData > 0)

	local leftTime = self.actData:getResetTime()
	local afterStr = string.format(ResNewMazeDisplay[13060020].desc, self.actData.cycle or 1)

	ClientTimerManager.RemoveSecondTickUI(self.textTimePoint)
	ClientTimerManager.AddSecondTickUI(self.textTimePoint, leftTime, nil, "", afterStr, nil, nil)

	if self.page == 1 then
		self:onTabPointClick()
	elseif self.page == 2 then
		self:onTabAimClick()
	else
		self:onTabSkillClick()
	end

	self.iconActiveNew:setVisible(self:checkActiveRedNew())
	self.iconAchiNew:setVisible(self:checkAchiRedNew())
end

function NewMazeAwardDlg:checkActiveRedNew()
	if self.activeAwardData[1] then
		local actObj = CurAvatar:getActivityObj(self.activeAwardData[1].detail_id)

		if actObj then
			local state = actObj.actData:getAchieveState(self.activeAwardData[1].type, self.activeAwardData[1].index)

			return state == Const.ACT_ACHIEVE_STATE_ENOUGH
		end
	end

	return false
end

function NewMazeAwardDlg:checkAchiRedNew()
	for i, data in ipairs(self.achiAwardData) do
		local actObj = CurAvatar:getActivityObj(data.detail_id)

		if actObj then
			local state = actObj.actData:getAchieveState(data.type, data.index)

			if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
				return true
			end
		end
	end

	return false
end

function NewMazeAwardDlg:refreshLayerList(...)
	if self.layerIndex == nil then
		self.layerIndex = self:getMyIndex(self.layerAwardData, self.actData.bestGradeLevel, self.actData.bestGradeLayer)
	end

	self.scrollLayer:setTotalCount(#self.layerAwardData, math.max(1, self.layerIndex - 1))
end

function NewMazeAwardDlg:refreshActiveList()
	if self.activeAwardCell == nil then
		self.activeAwardCell = AchiAwardCell(self, "BgPanel/PointAwardPanel/ActiveAwardPanel", "System/Rogue/RogueAimAwardCell")
	end

	if self.activeAwardData[1] then
		self.activeAwardCell:setData(self.activeAwardData[1])
		self.activeAwardCell:setVisible(true)
		self.activeAwardPanel:setVisible(true)
		self.bgTextActive:setVisible(true)
	else
		self.activeAwardCell:setVisible(false)
		self.activeAwardPanel:setVisible(false)
		self.bgTextActive:setVisible(false)
		self.layerAwardList:setRectSize(self.layerAwardList:getRectSize().width, 584)
	end
end

function NewMazeAwardDlg:onLayerCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = LayerAwardCell(sender, "System/Rogue/RogueLayerAwardCell", newIdx, 0, 0)
	else
		self.layerCells[targetCell.mIndex] = nil
	end

	self.layerCells[newIdx] = targetCell
	targetCell.mIndex = newIdx

	targetCell:setData(self.layerAwardData[newIdx])
end

function NewMazeAwardDlg:onSkillCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = LayerAwardCell(sender, "System/Rogue/RogueLayerAwardCell", newIdx, 0, 0)
	else
		self.skillAwardCell[targetCell.mIndex] = nil
	end

	self.skillAwardCell[newIdx] = targetCell
	targetCell.mIndex = newIdx
	targetCell.isTalentAchieve = true

	targetCell:setData(self.skillAwardData[newIdx])
end

function NewMazeAwardDlg:refreshAchiData()
	for i, data in ipairs(self.achiAwardData) do
		local cell = self.achiCells[i]

		if cell == nil then
			cell = AchiAwardCell(self, "BgPanel/AimAwardList/Content", "System/Rogue/RogueAimAwardCell", 0, 0, true)
		end

		cell:setData(data)

		self.achiCells[i] = cell
	end
end

function NewMazeAwardDlg:refreshSkillData()
	self.skillAwardList:setTotalCount(#self.skillAwardData)
end

function NewMazeAwardDlg:onTabPointClick()
	self.page = 1

	self.tabPoint:setEnable(false)
	self.tabAim:setEnable(true)
	self.tabSkill:setEnable(true)
	self:refreshLayerList()
	self:refreshActiveList()
	self.aimAwardPanel:setVisible(false)
	self.pointAwardPanel:setVisible(true)
	self.skillAwardPanel:setVisible(false)
end

function NewMazeAwardDlg:onTabAimClick()
	self.page = 2

	self.tabPoint:setEnable(true)
	self.tabAim:setEnable(false)
	self.tabSkill:setEnable(true)
	self:refreshAchiData()
	self.aimAwardPanel:setVisible(true)
	self.pointAwardPanel:setVisible(false)
	self.skillAwardPanel:setVisible(false)
end

function NewMazeAwardDlg:onTabSkillClick()
	self.page = 3

	self.tabPoint:setEnable(true)
	self.tabAim:setEnable(true)
	self.tabSkill:setEnable(false)
	self:refreshSkillData()
	self.aimAwardPanel:setVisible(false)
	self.pointAwardPanel:setVisible(false)
	self.skillAwardPanel:setVisible(true)
end

function NewMazeAwardDlg:getMyIndex(infos, level, layer)
	local myIndex = 0

	for i = 1, #infos do
		if level == infos[i].level then
			if layer >= infos[i].layer then
				myIndex = i
			else
				myIndex = i - 1

				break
			end
		end
	end

	return myIndex
end

function NewMazeAwardDlg:updateActivityData()
	if self.page == 1 then
		self:refreshActiveList()
	elseif self.page == 2 then
		self:refreshAchiData()
	else
		self:refreshSkillData()
	end

	self.iconActiveNew:setVisible(self:checkActiveRedNew())
	self.iconAchiNew:setVisible(self:checkAchiRedNew())
end

function NewMazeAwardDlg:onBtnCloseClick()
	self:setVisible(false)
end

return NewMazeAwardDlg
