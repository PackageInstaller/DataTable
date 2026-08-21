-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Rank\\BtnPlayerRankCell.lua

local Circle = require("Common/Object/Circle")
local BtnPlayerRankCell = {}

function BtnPlayerRankCell:ctorMixin()
	self:initUI()
end

function BtnPlayerRankCell:initUI()
	self.imgBg = UIControls.Image(self, "BgPanel/Bg")
	self.imgBgPanel = UIControls.Image(self, "BgPanel")
	self.txtPlayerName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.txtRankNum = UIControls.Label(self, "BgPanel/TextRankNum")
	self.txtRankNone = UIControls.Panel(self, "BgPanel/TextRankNone")
	self.txtTime = UIControls.Label(self, "BgPanel/TextTime")
	self.txtScore = UIControls.Label(self, "BgPanel/TextNumRank")

	if UIControls.checkControlFunc(self, "BgPanel/TextServer") then
		self.txtServer = UIControls.Label(self, "BgPanel/TextServer")
	end

	self.imgRank = UIControls.Image(self, "BgPanel/ImgRank")
	self.imgSelf = UIControls.Image(self, "")

	if UIControls.checkControlFunc(self, "BgPanel/BtnReplay") then
		self.btnReplay = UIControls.Button(self, "BgPanel/BtnReplay")

		self.btnReplay:addEventClick(self.onBtnReplayClick)

		self.imgLine = UIControls.Image(self, "BgPanel/ImgLine")
	end
end

function BtnPlayerRankCell:setData(data, idx)
	self.data = data
	self.idx = idx

	local rankBgSprite = self.data.rank <= 3 and self.data.rank >= 1 and "BgRank" .. self.data.rank or "BgRankOther"

	if self.data.rankType == Const.RANK_TYPE_MULTIPVP or self.data.rankType == Const.RANK_TYPE_OPACTPVP then
		local rankBgPanelSprite = self.data.rank <= 3 and self.data.rank >= 1 and "BgRanking" .. self.data.rank or "BgRankingOther"

		self.imgBgPanel:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", rankBgPanelSprite)
		self.imgBg:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", rankBgSprite)
	else
		self.imgBg:setImage("Atlas/OtherBattleAtlas/AsynPVPAtlas", rankBgSprite)
	end

	self.txtRankNum:setVisible(self.data.rank > 3)
	self.txtRankNum:setText(self.data.rank)
	self.txtRankNone:setVisible(self.data.rank <= 0)
	self.imgRank:setVisible(self.data.rank >= 1 and self.data.rank <= 3)

	if self.data.rank >= 1 and self.data.rank <= 3 then
		if self.data.rankType == Const.RANK_TYPE_MULTIPVP or self.data.rankType == Const.RANK_TYPE_OPACTPVP then
			self.imgRank:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", "IconRank" .. self.data.rank)
		else
			self.imgRank:setImage("Atlas/OtherBattleAtlas/AsynPVPAtlas", "IconRank" .. self.data.rank)
		end
	end

	if self.data.data.comm.uid == CurAvatar.uid then
		self.data.data.comm = CurAvatar:getMyRoleSimpleComm()
	end

	local commonData = self.data.data

	if commonData.tick > 0 then
		if self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER or self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_FEAT then
			local txtTimeTitleStr = self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER and Lang.get(42784) or Lang.get(30525)

			self.txtTime:setText(string.format(txtTimeTitleStr, os.date("%Y/%m/%d %H:%M:%S", commonData.tick)))
		elseif self.data.rankType == Const.RANK_TYPE_SNEAK_BATTLE then
			local txtTimeTitleStr = Lang.get(95792)

			self.txtTime:setText(utils.format(txtTimeTitleStr, utils.calcTimeTxt(commonData.tick)))
		else
			self.txtTime:setText(string.format(Lang.get(30525), utils.getDeadlineStr(commonData.tick, true)))
		end
	end

	self.rankUIInfo = UIConst.RANK_UI_INFO[self.data.rankType]

	self.txtTime:setVisible(self.idx ~= nil and not self.rankUIInfo.hideTime)

	if self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
		self.playerName = commonData.comm.name
	else
		local playerName, serverName = utils.GetPlayerName(commonData.comm.name)

		self.playerName = playerName
		self.svrName = serverName
	end

	self.txtPlayerName:setText(self.playerName)

	if self.txtServer then
		self.txtServer:setVisible(self.rankUIInfo.showSvrName ~= nil)

		if self.rankUIInfo.showSvrName ~= nil then
			self.txtServer:setText(string.format(Lang.get(30168), self.svrName))
		end
	end

	self.txtScore:setText(UIConst.getRankScoreStr(self.data.rankType, commonData.score))

	if self.txtPower then
		self:refreshPower(commonData.power or 0)
	end

	self:setAdditionalData()
	self:chekReplayData()
	self:handleSpecialType()
end

function BtnPlayerRankCell:handleSpecialType(...)
	if self.data.rankType == Const.RANK_TYPE_SNEAK_BATTLE then
		local commonData = self.data.data

		self.txtTime:setVisible(commonData.tick > 0)
	end
end

function BtnPlayerRankCell:setAdditionalData()
	if self.data.rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
		if not self.gridCircle then
			self.gridCircle = UIControls.GridCircleCommonChild(self, "GridPlayer", "System/Common/Grid/GridCircleCommon", 0, 0, true)

			self.gridCircle:setSelectCallback(Slot(self.openCircleShowDlg, self))
		end

		local commonData = self.data.data

		self.gridCircle:setByCommInfo(commonData.comm)
	else
		if not self.playerHead then
			self.playerHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon")
		end

		local commonData = self.data.data

		self.playerHead:setCommInfo(commonData.comm, true, self)
	end
end

function BtnPlayerRankCell:openCircleShowDlg(gridCircle)
	local circleInfo = gridCircle.commInfo

	if circleInfo.uid == CurAvatar.circleRoleData.clangid and CurAvatar.myCircle then
		local showCircleDlg = UIManager.getUI("showCircleDlg", true)

		showCircleDlg:setCircle(CurAvatar.myCircle)
	else
		local circle = CurAvatar:tryGetCircleDetailInfo(circleInfo.uid)

		if circle then
			local showCircleDlg = UIManager.getUI("showCircleDlg", true)

			if circle then
				showCircleDlg:setCircle(circle)
			end
		end
	end
end

function BtnPlayerRankCell:chekReplayData(...)
	if self.btnReplay and (self.data.rankType == Const.RANK_TYPE_WORLDBOSS or Const.RANK_TYPE_PET_MAZE or Const.RANK_TYPE_BOSS_EXPAND_MAP[self.data.rankType]) then
		self.replayId = self.data.data.replay_id

		if self.data.rankType == Const.RANK_TYPE_WORLDBOSS and self.data.data.comm.uid == CurAvatar.uid then
			local actData = CurAvatar:getWorldBossActData()

			if actData then
				if CurAvatar.onShowWorldBossRankIndex and CurAvatar.onShowWorldBossRankIndex ~= 1 then
					self.replayId = actData:getReplayId2()
				else
					self.replayId = actData:getReplayId()
				end
			end
		end

		if not self.replayId or self.replayId == "0" then
			self.btnReplay:setVisible(false)
			self.imgLine:setVisible(false)
		else
			self.btnReplay:setVisible(true)
			self.imgLine:setVisible(true)
		end
	end
end

function BtnPlayerRankCell:onBtnReplayClick(...)
	if self.replayId == nil or self.replayId == "0" then
		MsgManager.clientNotice(333)

		return
	end

	if self.data.rankType == Const.RANK_TYPE_WORLDBOSS then
		CurAvatar.cachedWorldBossRecord = {}
		CurAvatar.cachedWorldBossRecord.name = self.playerName

		RPC.pVEBattleReplay(self.replayId, BattleConst.BATTLE_TYPE_WORLD_BOSS)
	elseif Const.RANK_TYPE_BOSS_EXPAND_MAP[self.data.rankType] then
		CurAvatar.cachedBossExpandRecord = {}
		CurAvatar.cachedBossExpandRecord.levelId = self.data.data.param

		RPC.pVEBattleReplay(self.replayId, BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND)
	elseif self.data.rankType == Const.RANK_TYPE_PET_MAZE then
		RPC.pVEBattleReplay(self.replayId, BattleConst.BATTLE_TYPE_MAZE_PET)
	end
end

return BtnPlayerRankCell
