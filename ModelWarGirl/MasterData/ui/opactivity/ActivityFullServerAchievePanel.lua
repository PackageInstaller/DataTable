-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityFullServerAchievePanel.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local FullServerAchieveNodeCell = Class("FullServerAchieveNodeCell", UIControls.Child)

function FullServerAchieveNodeCell:ctor()
	self:initUI()
end

function FullServerAchieveNodeCell:initUI()
	self.notYetPanel = UIControls.Panel(self, "NodePanel/NotYetPanel")
	self.getPanel = UIControls.Panel(self, "NodePanel/GetPanel")
	self.num1 = UIControls.Label(self, "NodePanel/NotYetPanel/Num")
	self.num2 = UIControls.Label(self, "NodePanel/GetPanel/Num")
	self.imgNotYet = UIControls.Image(self, "NodePanel/NotYetPanel/ImgNodeSel")
	self.imgGet = UIControls.Image(self, "NodePanel/GetPanel/ImgNodeNml")
	self.getAnim = UIControls.UIAni(self, "NodePanel/GetPanel")
	self.btnGet = UIControls.Button(self, "BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.efxGet = UIControls.LazyEffectPlayer(self, "AwardPanel/EfxGet")
	self.content = UIControls.Image(self, "AwardPanel/Content")
	self.stateGet = UIControls.Image(self, "AwardPanel/StateGet")
	self.bgAward = UIControls.Image(self, "AwardPanel/BgAward")
	self.grids = {}
end

function FullServerAchieveNodeCell:setData(data)
	self.data = data

	if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[2] then
		self.imgAtlas = "Atlas/ActivityAtlas/" .. self.mParent.replaceableCellPath[2]
	else
		self.imgAtlas = "Atlas/ActivityAtlas/ActivityChineseCabbageDogAtlas/ActivityChineseCabbageDogAtlas"
	end

	self.imgNotYet:setImage(self.imgAtlas, "ImgNodeSel" .. data.index)
	self.imgGet:setImage(self.imgAtlas, "ImgNodeNml" .. data.index)

	if #self.mParent.detailData == self.data.index then
		self.content:setImage(self.imgAtlas, "ImgFinalAward")
	else
		self.content:setImage(self.imgAtlas, "ImgAward")
	end

	self.state = self.mParent.actObj.actData:getAchieveState(data.type, data.index)

	local bgImgName = {
		"BgAwardDis",
		"BgAwardNml",
		"BgAwardSel"
	}

	self.bgAward:setImage(self.imgAtlas, bgImgName[self.state])
	self.notYetPanel:setVisible(self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH)
	self.getPanel:setVisible(self.state ~= Const.ACT_ACHIEVE_STATE_NOT_ENOUGH)
	self.stateGet:setVisible(self.state == Const.ACT_ACHIEVE_STATE_GOT)

	local progress, param = self.mParent.actObj.actData:getAchieveShowProgress(data)

	self.num1:setText(ClientUtils.getNumShortStr(param))
	self.num2:setText(ClientUtils.getNumShortStr(param))

	if self.state == Const.ACT_ACHIEVE_STATE_GOT then
		self.getAnim:stopAni("ChineseCabbageDogNode")
		self.btnGet:setVisible(false)
		self.efxGet:setVisible(false)
	elseif self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.getAnim:startAniLoop("ChineseCabbageDogNode")
		self.efxGet:setVisible(true)
		self.btnGet:setVisible(true)
	else
		self.efxGet:setVisible(false)
		self.btnGet:setVisible(true)
	end
end

function FullServerAchieveNodeCell:onBtnGetClick()
	if self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		if #self.mParent.detailData == self.data.index and self.mParent.actObj.clientTemplateData and self.mParent.actObj.clientTemplateData.template_args then
			local noticeId = self.mParent.actObj.clientTemplateData.template_args[1] or 0

			MsgManager.clientNotice(noticeId)
		end

		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.actObj.opId, self.data.index, self.data.type), self.mParent.actObj.opId)
	else
		self.mParent:showNodeAward(self.data)
	end
end

local ActivityFullServerAchievePanel = Class("ActivityFullServerAchievePanel", UIControls.Child)

MixinClass(ActivityFullServerAchievePanel, ActivityPanelMixin)

function ActivityFullServerAchievePanel:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textNum = UIControls.Label(self, "NumPanel/TextNum")
	self.showNodeAwardPanel = UIControls.Panel(self, "ShowNodeAward")
	self.textTitle = UIControls.Label(self, "ShowNodeAward/TextTitle")
	self.nodeCells = {}
	self.showAwardGrids = {}

	if UIControls.checkControlFunc(self, "ShowNodeAward/UIClickThrough") then
		self.btnCloseAward = UIControls.Button(self, "ShowNodeAward/UIClickThrough")

		self.btnCloseAward:addEventClick(self.closeShowChoose)
	end
end

function ActivityFullServerAchievePanel:_setData()
	self.clientData = self.actObj.actData.clientData

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/ChineseCabbageDogAwardNodeCell"
	else
		self.cellPath = "System/Activity/ActivityChineseCabbageDog/ChineseCabbageDogAwardNodeCell"
	end

	self.detailData = {}

	for achieveType, aInfo in pairs(self.clientData) do
		self.achieveType = achieveType

		for index, aData in ipairs(aInfo) do
			table.insert(self.detailData, aData)
		end
	end

	self:refreshUI()
end

function ActivityFullServerAchievePanel:refreshUI()
	self.progress = self.actObj.actData:getAchieveShowProgress(self.detailData[1])

	for i = 1, #self.detailData do
		local slider = UIControls.Slider(self, "Slider" .. i)

		if slider then
			local progress, param = self.actObj.actData:getAchieveShowProgress(self.detailData[i])

			if param <= self.progress then
				slider:setValue(1)
			else
				local lastParam = 0

				if self.detailData[i - 1] then
					progress, lastParam = self.actObj.actData:getAchieveShowProgress(self.detailData[i - 1])
				end

				slider:setValue((self.progress - lastParam) / (param - lastParam))
			end
		end
	end

	self.textNum:setText(self.progress)

	for index, aData in ipairs(self.detailData) do
		local nodeCell = self.nodeCells[index]

		if nodeCell == nil then
			nodeCell = FullServerAchieveNodeCell(self, "NodeAwardList", self.cellPath, 0, 0, true)
		end

		nodeCell:setData(aData)

		self.nodeCells[index] = nodeCell
	end
end

function ActivityFullServerAchievePanel:showNodeAward(achieveData)
	local progress, param = self.actObj.actData:getAchieveShowProgress(achieveData)

	self.textTitle:setText(string.format(Lang.get(83184), param))
	ClientUtils.CreateBonusGrid(self, self.showAwardGrids, "ShowNodeAward/Content", achieveData.award, true, nil, true)
	self.showNodeAwardPanel:setVisible(true)
end

function ActivityFullServerAchievePanel:closeShowChoose()
	self.showNodeAwardPanel:setVisible(false)
end

function ActivityFullServerAchievePanel:onActivityDataRefresh(actObj)
	self:refreshUI()
end

return ActivityFullServerAchievePanel
