-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityAchieveChristmas.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local CommonBonusDlg = require("UI/Common/CommonBonusDlg")
local ResRandClient = require("ClientData/ResRandClient")
local AVT_ACHIEVE_TYPE_CHRISTMAS = 22
local ActivityChristmasCell = Class("ActivityChristmasCell", UIControls.ScrollViewLoopCell)

ActivityChristmasCell.awardState = {
	"ActivityTreeTaskCellDis",
	"ActivityTreeTaskCellHigh",
	"ActivityTreeTaskCellNml"
}

function ActivityChristmasCell:ctor()
	self.panel = UIControls.Panel(self, "")
	self.textProgress = UIControls.Label(self, "Bg/TextProgress")
	self.textRule = UIControls.Label(self, "Bg/TextRule")
	self.btnGo = UIControls.Button(self, "Bg/BtnGo")

	self.btnGo:addEventClick(self.onGoClick)
	self.btnGo:setVisible(false)

	self.textFinished = UIControls.Label(self, "Bg/TextState")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.textLimit = UIControls.Label(self, "Bg/TextLimit")
	self.textUnfinished = UIControls.Panel(self, "Bg/ImgUnfinished")

	self.textUnfinished:setVisible(false)

	self.cellGrids = {}
end

function ActivityChristmasCell:setCellData_task(data, opId)
	self.achData = data
	self.opId = opId

	local progress, maxProgress = self.mParent.actObj.actData:getAchieveShowProgress(self.achData)
	local state = self.achData.achieveState

	self.miscData = ResOpActivityAchieveMisc[self.achData.detail_id][self.achData.type]

	local round = self.achData.svrData and self.achData.svrData.round or 0

	if self.achData.type == 1 then
		if state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			state = Const.ACT_ACHIEVE_STATE_GOT
		end

		round = self.achData.svrData and self.achData.svrData.got[1] and self.miscData.max_round or round
		progress = 1
	end

	ClientUtils.CreateBonusGrid(self, self.cellGrids, "Bg/GridAward", self.achData.award)
	self.textProgress:setText(progress .. "/" .. maxProgress)
	self.textRule:setText(self.achData.desc_name)

	if state == Const.ACT_ACHIEVE_STATE_GOT then
		round = self.achData.type ~= 1 and self.miscData.max_round or round

		self.cellGrids[1].grid:setIconGray(true)
		self.textFinished:setVisible(true)
		self.textUnfinished:setVisible(false)
		self.btnGo:setVisible(false)
	elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.cellGrids[1].grid:setIconGray(false)
		self.textFinished:setVisible(false)
		self.textUnfinished:setVisible(false)
		self.btnGo:setVisible(false)
	elseif state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self.cellGrids[1].grid:setIconGray(false)
		self.textFinished:setVisible(false)

		if self.miscData.jump_id then
			self.textUnfinished:setVisible(false)
			self.btnGo:setVisible(true)
		else
			self.textUnfinished:setVisible(true)
			self.btnGo:setVisible(false)
		end
	end

	self.textLimit:setText(utils.format(Lang.get(30597), round, self.miscData.max_round))
	self.panel:playStateAnimator(self.awardState[state])
end

function ActivityChristmasCell:onGoClick()
	local jumpId = self.miscData.jump_id

	if jumpId then
		JumpGuideManager.jump(jumpId)
	end
end

function ActivityChristmasCell:onConfirmClick()
	CommonBonusDlg.setCustomizeFlyConfig(true, self.mParent.treePanel_FlyTarget)
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.achData.index, self.achData.type), self.opId)
end

local GridTreeAwards = Class("GridTreeAwards", UIControls.Child)

GridTreeAwards.awardState = {
	"GridTreeAwardDis",
	"GridTreeAwardHigh",
	"GridTreeAwardNml"
}
GridTreeAwards.ICON_PATH = "Atlas/ActivityAtlas/ActivityTreeTaskAtlas"

function GridTreeAwards:ctor()
	self.btnInfo = UIControls.Button(self, "BtnInfo")

	self.btnInfo:addEventClick(self.showInfo_getAward)

	self.panel = UIControls.Panel(self, "")

	self.panel:setVisible(true)

	self.textNum = UIControls.Label(self, "BtnInfo/AwardPanel/TextNum")
	self.textLimit = UIControls.Label(self, "BtnInfo/NumPanel/TextNum")
	self.rayCast = UIControls.Panel(self, "BtnInfo/Raycast")

	self.rayCast:setVisible(true)

	self.imgBgNml1 = UIControls.Image(self, "BtnInfo/BgNml1")
	self.imgBgHigh = UIControls.Image(self, "BtnInfo/BgHigh")
	self.imgBgNml2 = UIControls.Image(self, "BtnInfo/BgNml2")
	self.textBgDis = UIControls.Label(self, "BtnInfo/BgDis/Text")
	self.imgBgDis = UIControls.Image(self, "BtnInfo/BgDis")
	self.imgBgLeaves = UIControls.Image(self, "BtnInfo/BgLeaves")
	self.efx = UIControls.LazyEffectPlayer(self, "BtnInfo/EfxLight")
	self.grid = UIControls.getGridAwardContainer(self, "BtnInfo/AwardPanel")
end

function GridTreeAwards:setCellData_tree(idx, data, opId, progress)
	self.achData = data
	self.opId = opId

	if idx <= 6 then
		self.efx:playEffectByPath("Effects/UI/efx_ui_TreeAward_Christmas1.prefab")
	elseif idx == 7 then
		self.efx:playEffectByPath("Effects/UI/efx_ui_TreeAward_Christmas7.prefab")
	end

	local awardData = ResRandClient[self.achData.award]
	local item = BaseObject.GetObject(awardData.show_ids[1], awardData.show_nums[1])

	self.grid.mDisableWays = false

	self.grid:setContainerConfig(9)
	self.grid:setObj(item)

	self.grid.grid.isShowPreviewTips = true
	self.grid.grid.mDisableWays = false

	self.grid:setTextNumCtrlEnable()
	self.grid:setVisible(true)

	if item.itemType == Const.ITEM_TYPE_SKIN and self.grid.grid.imgMask then
		self.grid.grid.imgMask:setImage("Atlas/CommonAtlas/GridAtlas/GridAtlas", "IconMask1")
	end

	if self.grid.grid.hideTextNum then
		self.grid.grid:hideTextNum(true)
	end

	local txtNum = self.grid.grid.object and self.grid.grid.object.num or 1

	if txtNum ~= 1 then
		self.textNum:setText(ClientUtils.getNumShortStr(txtNum))
	else
		self.textNum:setVisible(false)
	end

	self.progress = self.mParent.actData.serverData[data.type]

	local state = data.state

	self.panel:playStateAnimator(self.awardState[state])

	if state == Const.ACT_ACHIEVE_STATE_GOT or state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		if self.mParent.efxPanels[idx] then
			self.mParent.efxPanels[idx]:setVisible(true)
		end
	elseif self.mParent.efxPanels[idx] then
		self.mParent.efxPanels[idx]:setVisible(false)
	end

	if idx == 6 then
		self.imgBgNml1:setImage(self.ICON_PATH, "BtnTreeRedNml")
		self.imgBgHigh:setImage(self.ICON_PATH, "BtnTreeRedSel")
		self.imgBgNml2:setImage(self.ICON_PATH, "BtnTreeRedDis")
		self.textBgDis:setTextWithColor(Lang.get(74), "COLORRANK01")
		self.imgBgDis:setImage(self.ICON_PATH, "BtnTreeRedReceive")
	elseif idx == 7 then
		self.imgBgNml1:setImage(self.ICON_PATH, "BtnTreeStarNml")
		self.imgBgHigh:setImage(self.ICON_PATH, "BtnTreeStarSel")
		self.imgBgNml2:setImage(self.ICON_PATH, "BtnTreeStarDis")
		self.textBgDis:setTextWithColor(Lang.get(74), "COLORRANK01")
		self.imgBgDis:setImage(self.ICON_PATH, "BtnTreeStarReceive")
		self.imgBgLeaves:setImage(self.ICON_PATH, "IconLeavesY")
	end

	local paramTo = data.lastParam > 0 and data.param - data.lastParam or data.param

	if data.nextAward then
		progress = progress - data.lastParam
		self.mParent.treePanel_FlyTarget = self.mParent.treePanels[idx]
	elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		progress = paramTo
	else
		progress = 0
	end

	self.textLimit:setText(progress .. "/" .. paramTo)
end

function GridTreeAwards:showInfo_getAward()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.achData.index, self.achData.type), self.opId)
end

local classNameStr = "ActivityAwardChristmasPage"
local ActivityAchieveChristmas = Class(classNameStr, UIControls.Child)

MixinClass(ActivityAchieveChristmas, ActivityPanelMixin)

function ActivityAchieveChristmas:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.scrollItems = UIControls.ScrollViewLoopV(self, "ContentList", 0, self.onCellChanged)
	self.treePanel_FlyTarget = nil
	self.treePanels = {}

	for i = 1, 7 do
		self.treePanels[i] = GridTreeAwards(self, "TreePanel/TreeAwardPanel" .. i, "System/Activity/TreeTask/GridTreeAward")
	end

	self.efxPanels = {}

	for i = 1, 6 do
		self.efxPanels[i] = UIControls.Panel(self, "EfxPanel" .. i)
	end
end

function ActivityAchieveChristmas:onCellChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = ActivityChristmasCell(sender, "System/Activity/TreeTask/ActivityTreeTaskCell", newIdx, 0, 0)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setCellData_task(self.clientData_task[newIdx], self.actObj.opId)
end

function ActivityAchieveChristmas:_setData(pageData)
	local actData = self.actObj.actData

	self.opId = self.actObj.opId
	self.actType = self.actObj.actType
	self.clientData_tree = {}
	self.clientData_task = {}
	self.progress = {}

	if actData and actData.clientData then
		self.actData = actData

		for type, data in pairs(actData.clientData) do
			if type ~= AVT_ACHIEVE_TYPE_CHRISTMAS then
				if actData.serverData then
					data[1].svrData = actData.serverData[type]

					table.insert(self.clientData_task, data[1])
				end
			else
				table.insert(self.clientData_tree, data)
			end
		end
	end
end

function ActivityAchieveChristmas:_onShow(isOnPageShow)
	if isOnPageShow then
		local ChristmasSvrData = {}

		if self.actObj.actData and self.actObj.actData.serverData then
			ChristmasSvrData = self.actObj.actData.serverData[AVT_ACHIEVE_TYPE_CHRISTMAS] or {}
		end

		local state
		local nextAward = true
		local lastParam = 0

		for _, value in ipairs(self.clientData_tree[1]) do
			state = self.actData:getAchieveState(value.type, value.index)

			if state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH and nextAward then
				nextAward = false
				value.nextAward = true
			else
				value.nextAward = false
			end

			value.state = state
			value.lastParam = lastParam
			lastParam = value.param
		end

		for idx, value in ipairs(self.clientData_tree[1]) do
			if self.treePanels[idx] then
				self.treePanels[idx]:setCellData_tree(idx, value, self.actObj.opId, ChristmasSvrData.progress or 0)
			end
		end

		table.sort(self.clientData_task, function(a, b)
			return a.show_priority < b.show_priority
		end)

		local tab = self:sortTask(self.clientData_task)

		self.clientData_task = tab

		self.scrollItems:setTotalCount(#self.clientData_task)
	end
end

function ActivityAchieveChristmas:sortTask(tab)
	for _, data in ipairs(tab) do
		local achieve = self.actData:getAchieveState(data.type, data.index)

		if data.type == 1 and achieve == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			achieve = Const.ACT_ACHIEVE_STATE_GOT
		end

		data.achieveState = achieve
	end

	local sortTab = {}

	for i, v in pairs(tab) do
		if v.achieveState == Const.ACT_ACHIEVE_STATE_ENOUGH then
			table.insert(sortTab, v)
		end
	end

	for i, v in pairs(tab) do
		if v.achieveState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			table.insert(sortTab, v)
		end
	end

	for i, v in pairs(tab) do
		if v.achieveState == Const.ACT_ACHIEVE_STATE_GOT then
			table.insert(sortTab, v)
		end
	end

	return sortTab
end

function ActivityAchieveChristmas:onActivityDataRefresh(actObj)
	self:_setData()
	self:_onShow(true)
end

function ActivityAchieveChristmas:onGetFinalBonus()
	return
end

return ActivityAchieveChristmas
