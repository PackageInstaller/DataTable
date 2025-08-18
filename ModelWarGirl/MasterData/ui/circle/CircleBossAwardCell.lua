-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBossAwardCell.lua

local ResClanBattleLayer = require("ClientData/ResClanBattleLayer")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local strClassName = "CircleBossAwardCell"
local CircleBossAwardCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function CircleBossAwardCell:ctor()
	self:initUI()
end

function CircleBossAwardCell:initUI()
	self.panelSelf = UIControls.Panel(self, "")
	self.imgBgRank = UIControls.Image(self, "BgRank")
	self.txtRank = UIControls.Label(self, "TextRank")
	self.framePanelAwardAdd = UIControls.Panel(self, "BgAward1/AwardAddPanel")
	self.frameImgBgArrow = UIControls.Image(self, "BgAward1/BgArrow")
	self.framePanelText = UIControls.Panel(self, "BgAward1/TextPanel")
	self.frameImgArrow = UIControls.Image(self, "BgAward1/ImgArrow")
	self.frameTxtCondition = UIControls.Label(self, "BgAward1/TextPanel/Text")
	self.frameTxtDes = UIControls.Label(self, "BgAward1/TextPanel/TextDes")
	self.itemPanelAwardAdd = UIControls.Panel(self, "BgAward2/AwardAddPanel")
	self.itemImgBgArrow = UIControls.Image(self, "BgAward2/BgArrow")
	self.itemImgArrow = UIControls.Image(self, "BgAward2/ImgArrow")
	self.itemTxtCondition = UIControls.Label(self, "BgAward2/Text")
	self.itemTxtDes = UIControls.Label(self, "BgAward2/TextDes")
end

function CircleBossAwardCell:setCircleBossAwardData(circleBossAwardData, circleRank, playerRank)
	self.circleBossAwardData = circleBossAwardData
	self.circleRank = circleRank
	self.playerRank = playerRank
	self.rank = self.circleBossAwardData.resData.ranking

	if self.rank <= 3 then
		self.imgBgRank:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgRankS" .. self.rank)
		self.txtRank:setVisible(false)
	else
		self.imgBgRank:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgRankSOther")
		self.txtRank:setVisible(true)
		self.txtRank:setText(self.rank)
	end

	local layerConfig = CurAvatar.myCircle:getCurBattleLayerConfig()
	local miscData = ResClanBattleMisc[1]
	local animtorState = self.rank == self.playerRank and "BossAwardCellSel" or "BossAwardCellNml"

	self.panelSelf:playStateAnimator(animtorState)

	local needRankData = miscData.feat_head_frame[1]
	local frameGear = 1

	if self.circleRank > 0 then
		for idx, _needRankData in ipairs(miscData.feat_head_frame) do
			if self.circleRank <= _needRankData.ranking then
				frameGear = idx
				needRankData = _needRankData
			end
		end
	end

	local headFrameObject = BaseObject.GetObject(needRankData.id)

	if not self.gridAwardHeadFrame then
		self.gridAwardHeadFrame = UIControls.getGridAwardContainer(self, "BgAward1/AwardPanel")
		self.gridAwardHeadFrame.mDisableWays = true
	end

	self.gridAwardHeadFrame:setObj(headFrameObject)
	self.gridAwardHeadFrame.imgLock:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgLock")

	local isFrameLock = self.circleRank < 0 or self.circleRank > needRankData.ranking

	self.gridAwardHeadFrame:setState(isFrameLock)
	self.gridAwardHeadFrame:setVisible(true)

	if frameGear == #miscData.feat_head_frame then
		self.frameImgBgArrow:setVisible(false)
		self.framePanelText:setVisible(false)
		self.frameImgArrow:setVisible(false)
		self.framePanelAwardAdd:setVisible(false)
	elseif isFrameLock then
		self.frameImgBgArrow:setVisible(false)
		self.framePanelText:setVisible(true)
		self.frameImgArrow:setVisible(false)
		self.framePanelAwardAdd:setVisible(false)
		self.frameTxtDes:setText(Lang.get(45093))
		self.frameTxtCondition:setText(utils.format(Lang.get(41690), miscData.feat_head_frame[1].ranking))
	else
		self.frameImgBgArrow:setVisible(true)
		self.framePanelText:setVisible(true)
		self.frameImgArrow:setVisible(true)
		self.frameTxtDes:setText(Lang.get(41691))
		self.frameTxtCondition:setText(utils.format(Lang.get(41690), miscData.feat_head_frame[frameGear + 1].ranking))
		self.framePanelAwardAdd:setVisible(true)

		local nextRankData = miscData.feat_head_frame[frameGear + 1]
		local nextFrameObject = BaseObject.GetObject(nextRankData.id)

		if not self.gridNextAwardHeadFrame then
			self.gridNextAwardHeadFrame = UIControls.getGridAwardContainer(self, "BgAward1/AwardAddPanel")
			self.gridNextAwardHeadFrame.mDisableWays = true
		end

		self.gridNextAwardHeadFrame:setObj(nextFrameObject)
		self.gridNextAwardHeadFrame.imgLock:setImage("Atlas/CircleBattleAtlas/_cht/CircleBattleAtlas3", "BgLock")
		self.gridNextAwardHeadFrame:setState(true)
		self.gridNextAwardHeadFrame:setVisible(true)
	end

	local awardItemNum = math.floor(layerConfig.feat_award * (self.circleBossAwardData.resData.award_rate / 10000))
	local awardItemObject = BaseObject.GetObject(miscData.feat_award_item_id, awardItemNum)

	if not self.gridAwardItem then
		self.gridAwardItem = UIControls.getGridAwardContainer(self, "BgAward2/AwardPanel")
		self.gridAwardItem.mDisableWays = true
	end

	self.gridAwardItem:setObj(awardItemObject)
	self.gridAwardItem:setVisible(true)

	local curBattleLayer = CurAvatar.myCircle:getCurBattleLayer()

	if curBattleLayer == #ResClanBattleLayer then
		self.itemPanelAwardAdd:setVisible(false)
		self.itemImgBgArrow:setVisible(false)
		self.itemImgArrow:setVisible(false)
		self.itemTxtCondition:setVisible(false)
		self.itemTxtDes:setVisible(false)
	else
		self.itemPanelAwardAdd:setVisible(true)

		local nextAwardItemNum = math.floor(ResClanBattleLayer[curBattleLayer + 1].feat_award * (self.circleBossAwardData.resData.award_rate / 10000))

		self.itemTxtCondition:setText(utils.format(Lang.get(38573), curBattleLayer))

		local awardAddItemNum = nextAwardItemNum - awardItemNum
		local awardAddItemObject = BaseObject.GetObject(miscData.feat_award_item_id, awardAddItemNum)

		if not self.gridAwardAddItem then
			self.gridAwardAddItem = UIControls.getGridAwardContainer(self, "BgAward2/AwardAddPanel")
			self.gridAwardAddItem.mDisableWays = true
		end

		self.gridAwardAddItem:setObj(awardAddItemObject)
		self.gridAwardAddItem:setVisible(true)
	end
end

return CircleBossAwardCell
