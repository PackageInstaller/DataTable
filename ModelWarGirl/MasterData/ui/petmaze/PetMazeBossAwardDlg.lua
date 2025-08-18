-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\PetMazeBossAwardDlg.lua

local ScoreNode = Class("PetMazeBossAwardDlg_ScoreNode", UIControls.Child)

function ScoreNode:ctor()
	self.imgBg = UIControls.Image(self, "")
	self.halfWidth = self.imgBg:getSize().width * 0.5
	self.getPanel = UIControls.Panel(self, "ImgGet")
	self.txtScore = UIControls.Label(self, "TextPro")
end

function ScoreNode:setData(config, checkGet, nextScore)
	local score = config.score

	self.score = score

	self.txtScore:setText(score)
	self.getPanel:setVisible(checkGet)

	if checkGet then
		self.imgBg:setImage("Atlas/MazzPetAtlas/MazzPetAtlas7", "BgArrow2")
	elseif nextScore == score then
		self.imgBg:setImage("Atlas/MazzPetAtlas/MazzPetAtlas7", "BgArrow1")
	else
		self.imgBg:setImage("Atlas/MazzPetAtlas/MazzPetAtlas7", "BgArrow3")
	end

	self.awardNodeList = self.awardNodeList or {}

	ClientUtils.CreateBonusGrid(self, self.awardNodeList, "AwardPanel", config.awardid, false, nil, true)
end

local PetMazeBossAwardDlg = Class("PetMazeBossAwardDlg", UIControls.Window)

function PetMazeBossAwardDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.scrollPanel = UIControls.Panel(self, "BgPanel/AwardList/Content")
	self.scrollPosY = self.scrollPanel:getPosition().y
	self.slider = UIControls.Slider(self, "BgPanel/AwardList/Content/Slider")
	self.sliderPanel = UIControls.Panel(self, "BgPanel/AwardList/Content/Slider")
end

function PetMazeBossAwardDlg:destroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	PetMazeBossAwardDlg.super.destroy(self)
end

function PetMazeBossAwardDlg:setData(configList, curScore, maxScore)
	self.scoreNodeList = self.scoreNodeList or {}

	local scoreList = {}
	local nextScore = 0

	self.focusIdx = 0
	self.curIdx = 0
	self.nextIdx = 0
	self.score = curScore

	for k, v in pairs(configList) do
		if k <= maxScore then
			table.insert(scoreList, k)
		end
	end

	table.sort(scoreList)

	local dataNum = #scoreList
	local nodeNum = #self.scoreNodeList

	for i = 1, dataNum do
		local node

		if i <= nodeNum then
			node = self.scoreNodeList[i]
		else
			node = ScoreNode(self, "BgPanel/AwardList/Content", "System/MazzPet/MazzPetAwardNmlCell")

			table.insert(self.scoreNodeList, node)
		end

		local score = scoreList[i]
		local checkFinish = score <= curScore

		if checkFinish then
			self.curIdx = i
		end

		if not checkFinish and nextScore == 0 then
			nextScore = score
			self.focusIdx = i
			self.nextIdx = i
		end

		node:setVisible(true)
		node:setData(configList[score], checkFinish, nextScore)
	end

	if dataNum < nodeNum then
		for i = dataNum + 1, nodeNum do
			self.scoreNodeList[i]:setVisible(false)
		end
	end

	self.focusIdx = self.focusIdx > 0 and self.focusIdx or dataNum

	if self.focusIdx > dataNum - 4 then
		self.focusIdx = dataNum - 4
	end

	if self.focusIdx < 1 then
		self.focusIdx = 1
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = FrameTimer.New(Slot(self.focusAction, self), 1)

	self.timer:Start()
end

function PetMazeBossAwardDlg:focusAction()
	local focusNode = self.scoreNodeList[self.focusIdx]
	local focusPos = focusNode:getPosition()

	self.scrollPanel:setPosition(-(focusPos.x - focusNode.halfWidth), self.scrollPosY)

	local arrowPos = 0

	if self.curIdx > 0 then
		local curNode = self.scoreNodeList[self.curIdx]
		local curPos = curNode:getPosition().x
		local curScore = curNode.score

		arrowPos = curPos

		if self.nextIdx > 0 then
			local nextNode = self.scoreNodeList[self.nextIdx]
			local nextPos = nextNode:getPosition().x
			local nextScore = nextNode.score

			arrowPos = arrowPos + (self.score - curScore) / (nextScore - curScore) * (nextPos - curPos)
		end
	end

	local maxPos = self.scrollPanel:getRectSize().width - focusNode.halfWidth
	local rate = maxPos > 0 and arrowPos / maxPos or 0

	self.slider:setValue(rate)

	self.timer = nil
end

function PetMazeBossAwardDlg:onClickBtnClose()
	self:setVisible(false)
end

return PetMazeBossAwardDlg
