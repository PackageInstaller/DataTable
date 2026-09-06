-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropRewardsPreviewView.lua

module("logic.extensions.catchprops.view.FlynuorewardView", package.seeall)

local CatchPropRewardsPreviewView = class("CatchPropRewardsPreviewView", ViewComponent)

function CatchPropRewardsPreviewView:buildUI()
	CatchPropRewardsPreviewView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo("tablecell")

	self._tableCell:SetActive(false)

	local txtTitle = self:getTxt("txtTitle")
	local integralTxt = self:getTxt("topTitle/integral")
	local rewardTxt = self:getTxt("topTitle/reward")

	txtTitle.text = lang("text_reward_instruction_title")
	integralTxt.text = lang("text_integrals")
	rewardTxt.text = lang("text_reward")
end

function CatchPropRewardsPreviewView:bindEvents()
	CatchPropRewardsPreviewView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._tableview:RegisterCallback(self._numCellsInTableview, self._tableCellSizeForIndex, self._tableCellAtIndex, self)
end

function CatchPropRewardsPreviewView:unbindEvents()
	CatchPropRewardsPreviewView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function CatchPropRewardsPreviewView:onEnter()
	CatchPropRewardsPreviewView.super.onEnter(self)
	self:_updateView()
end

function CatchPropRewardsPreviewView:onEnterFinished()
	CatchPropRewardsPreviewView.super.onEnterFinished(self)
end

function CatchPropRewardsPreviewView:onExit()
	CatchPropRewardsPreviewView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)
end

function CatchPropRewardsPreviewView:onExitFinished()
	CatchPropRewardsPreviewView.super.onExitFinished(self)
end

function CatchPropRewardsPreviewView:_updateView()
	local prizeCos = CatchPropsModel.instance:getAllPrizes()

	self._prizeDatas = {}

	if prizeCos then
		for k, v in pairs(prizeCos) do
			table.insert(self._prizeDatas, v)
		end

		table.sort(self._prizeDatas, function(x, y)
			return x.integral > y.integral
		end)
	end

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
end

function CatchPropRewardsPreviewView:_numCellsInTableview()
	return #self._prizeDatas
end

function CatchPropRewardsPreviewView:_tableCellSizeForIndex(view, idx)
	return 300, 108
end

function CatchPropRewardsPreviewView:_tableCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._prizeDatas[idx + 1]
	local integral = goutil.findChildTextComponent(cell.gameObject, "text")
	local reward = goutil.findChild(cell.gameObject, "reward")

	integral.text = string.format(lang("text_integrals_num"), data.integral)

	local prizes = string.split(data.prize, "#")
	local cnt = #prizes
	local transform = reward.transform
	local childCount = transform.childCount

	while childCount < cnt do
		UGUIToolHelper.AddChild(reward, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, cnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.setCellByCfg(prizes[i], go)
	end

	for i = cnt + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	return cell
end

function CatchPropRewardsPreviewView:_clearTableview(cell)
	local reward = goutil.findChild(cell.gameObject, "reward")

	for i = 1, reward.transform.childCount do
		local go = reward.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
	end
end

return CatchPropRewardsPreviewView
