-- chunkname: @IQIGame\\UI\\ChallengeRewardUI.lua

local ChallengeRewardUI = Base:Extend("ChallengeRewardUI", "IQIGame.Onigao.UI.ChallengeRewardUI", {
	closeTime = 0,
	CompanionUnitCells = {}
})
local BattleUnitSettlementCell = require("IQIGame.UI.Battle.BattleUnitSettlementCell")

function ChallengeRewardUI:OnInit()
	UGUIUtil.SetText(self.goBtnTxt, ChallengeRewardUIApi:GetString("goBtnTxt"))
	UGUIUtil.SetText(self.RewardText, ChallengeRewardUIApi:GetString("RewardText"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateJump()
		self:OnClickJumpBtn()
	end

	for i = 1, 5 do
		local battleUnitCell = BattleUnitSettlementCell.New(UnityEngine.Object.Instantiate(self.BattleEndUnitCellMould))

		battleUnitCell.View.transform:SetParent(self.SoulGrid.transform, false)
		table.insert(self.CompanionUnitCells, battleUnitCell)
	end

	self.jumpBtnTab = {}

	for i, v in pairsCfg(CfgWaysToStrengthenTable) do
		local item = UnityEngine.Object.Instantiate(self.BtnMould)

		item.transform:SetParent(self.LoseGrid.transform, false)
		item:SetActive(true)

		local tab = {}

		LuaCodeInterface.BindOutlet(item, tab)
		UGUIUtil.SetText(tab.Title, v.ButtionWord)
		UGUIUtil.SetText(tab.TitleEng, v.EngName)

		tab.BtnSelf.name = tostring(v.Id)

		table.insert(self.jumpBtnTab, tab.BtnSelf)
		LuaCodeInterface.ClearOutlet(item, tab)
	end
end

function ChallengeRewardUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeRewardUI:OnOpen(userData)
	self.rewardData = userData
	self.closeTime = 0

	if self.rewardData.isAutoClose then
		self.closeTime = PlayerModule.GetServerTime() + 3
	end

	self:UpdateView()
end

function ChallengeRewardUI:OnClose(userData)
	self.closeTime = 0
	self.rewardData = nil

	self:StopTimer()
	EventDispatcher.Dispatch(EventID.RefreshRankEvent)

	MainCityBattleModule.Instance.BattleOverCommand = nil

	GuildModule.CheckQuiteScene()
end

function ChallengeRewardUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)

	for i, v in pairs(self.jumpBtnTab) do
		v:GetComponent("Button").onClick:AddListener(self.delegateJump)
	end
end

function ChallengeRewardUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)

	for i, v in pairs(self.jumpBtnTab) do
		v:GetComponent("Button").onClick:RemoveListener(self.delegateJump)
	end
end

function ChallengeRewardUI:OnPause()
	return
end

function ChallengeRewardUI:OnResume()
	return
end

function ChallengeRewardUI:OnCover()
	return
end

function ChallengeRewardUI:OnReveal()
	return
end

function ChallengeRewardUI:OnRefocus(userData)
	return
end

function ChallengeRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i = 1, #self.CompanionUnitCells do
		self.CompanionUnitCells[i]:OnUpdate()
	end

	if self.closeTime > 0 and PlayerModule.GetServerTime() > self.closeTime then
		self.closeTime = 0

		UIModule.CloseSelf(self)
	end
end

function ChallengeRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeRewardUI:OnDestroy()
	for i, v in pairs(self.jumpBtnTab) do
		self.jumpBtnTab[i] = nil
	end

	for i = 1, #self.CompanionUnitCells do
		self.CompanionUnitCells[i]:Dispose()
	end
end

function ChallengeRewardUI:OnClickBtnClose()
	if self.rewardData.onBtnCloseCallBack then
		self.rewardData.onBtnCloseCallBack()
	end

	UIModule.Close(Constant.UIControllerName.ChallengeRewardUI)
end

function ChallengeRewardUI:UpdateView()
	if self.rewardData then
		self.ImgBg:SetActive(self.rewardData.type == 1)
		self.WinView:SetActive(self.rewardData.win)
		self.LoseView:SetActive(not self.rewardData.win)

		if self.rewardData.battleType == 1 then
			self:ShowHurtRank(PandaBattleModule.Instance.BattleOverCommand, PandaBattleModule.Instance.BattleAreaCid)
		elseif self.rewardData.battleType == 2 then
			self:ShowHurtRank(GuildBattleModule.Instance.BattleOverCommand, GuildBattleModule.Instance.BattleAreaCid)
		elseif self.rewardData.battleType == 3 then
			self:ShowHurtRank(MiningBattleModule.Instance.BattleOverCommand, MiningBattleModule.Instance.BattleAreaCid)
		elseif self.rewardData.battleType == 4 then
			self:ShowHurtRank(AmusementParkBattleModule.Instance.BattleOverCommand, AmusementParkBattleModule.Instance.BattleAreaCid)
		else
			self:ShowHurtRank(MainCityBattleModule.Instance.BattleOverCommand, MainCityBattleModule.Instance.BattleAreaCid)
		end

		if self.rewardData.win then
			UGUIUtil.SetText(self.TextWinTitle, ChallengeUIApi:GetString("TextRewardTitle", self.rewardData.type, self.rewardData.win, 1))
			UGUIUtil.SetText(self.TextWinEngTitle, ChallengeUIApi:GetString("TextRewardTitle", self.rewardData.type, self.rewardData.win, 2))
			self.ImgLine:SetActive(self.rewardData.type == 1)

			if self.rewardData.oldMaxHurt ~= nil and self.rewardData.oldMaxHurt > 0 then
				self.ContentText:SetActive(true)

				self.ContentText:GetComponent("Text").text = ChallengeUIApi:GetString("TextMsg3", self.rewardData.oldMaxHurt)
			else
				self.ContentText:SetActive(false)
			end

			self.RewardGrid:SetActive(self.rewardData.getItems and #self.rewardData.getItems > 0)
			UGUIUtil.SetText(self.RewardGrid, ChallengeUIApi:GetString("TextTitle4"))

			for i = 1, self.RewardGrid.transform.childCount - 1 do
				local obj = self.RewardGrid.transform:GetChild(1).gameObject

				UnityEngine.GameObject.DestroyImmediate(obj)
			end

			if self.rewardData.getItems then
				for i, v in pairs(self.rewardData.getItems) do
					if CfgItemTable[v.cid].IsRewardShow then
						local item = UnityEngine.Object.Instantiate(self.GridMould)

						item.transform:SetParent(self.RewardGrid.transform, false)
						UGUIUtil.SetText(item.transform:Find("Name/Text_01").gameObject, CfgItemTable[v.cid].Name)

						local itemObj = item.transform:Find("Slot"):GetChild(0).gameObject
						local itemCell = ItemCell.PackageOrReuseView(self, itemObj)

						itemCell:SetItem(CfgItemTable[v.cid])
						itemCell:SetNum(v.num)

						local tagObj = item.transform:Find("Tag").gameObject

						tagObj:SetActive(v.tag ~= nil)

						if tagObj and v.tag ~= nil then
							if v.tag > 0 then
								tagObj:SetActive(true)
							else
								tagObj:SetActive(true)
							end

							UGUIUtil.SetText(tagObj.transform:Find("Text_01").gameObject, ChallengeWorldBossUIApi:GetString("RewardTag", v.tag))
						end
					end
				end
			end
		else
			UGUIUtil.SetText(self.TextLoseTitle, ChallengeUIApi:GetString("TextRewardTitle", self.rewardData.type, self.rewardData.win, 1))
			UGUIUtil.SetText(self.TextLoseEngTitle, ChallengeUIApi:GetString("TextRewardTitle", self.rewardData.type, self.rewardData.win, 2))
			self.TextLoseHurt:SetActive(true)

			self.TextLoseHurt:GetComponent("Text").text = ChallengeUIApi:GetString("TextLoseHurt")
		end
	end
end

function ChallengeRewardUI:ShowHurtRank(battleOverCommandData, battleAreaCid)
	local isShow = false

	if battleOverCommandData then
		local cfgBattleAreaData = CfgBattleAreaTable[battleAreaCid]
		local soulPODs = battleOverCommandData.Attacker.ArrFightUnitPOD
		local dmgRecords = battleOverCommandData.DmgRecords
		local hurtRecords = battleOverCommandData.HurtRecords
		local healRecords = battleOverCommandData.HealRecords
		local totalDmg = 0
		local totalHurt = 0
		local totalHeal = 0
		local maxDmg = 0
		local maxHurt = 0
		local maxHeal = 0

		for i = 1, #soulPODs do
			local fightUnitPOD = soulPODs[i]

			totalDmg = totalDmg + dmgRecords[fightUnitPOD.MonsterCfgId]
			totalHurt = totalHurt + hurtRecords[fightUnitPOD.MonsterCfgId]
			totalHeal = totalHeal + healRecords[fightUnitPOD.MonsterCfgId]
			maxDmg = math.max(maxDmg, dmgRecords[fightUnitPOD.MonsterCfgId])
			maxHurt = math.max(maxHurt, hurtRecords[fightUnitPOD.MonsterCfgId])
			maxHeal = math.max(maxHeal, healRecords[fightUnitPOD.MonsterCfgId])
		end

		local animCells = {}

		for i = 1, #self.CompanionUnitCells do
			local battleUnitCell = self.CompanionUnitCells[i]
			local fightUnitPOD = soulPODs[i]
			local monsterCid = -1

			if fightUnitPOD ~= nil then
				monsterCid = fightUnitPOD.MonsterCfgId

				table.insert(animCells, battleUnitCell)
			end

			battleUnitCell:SetItem(fightUnitPOD, dmgRecords[monsterCid], hurtRecords[monsterCid], healRecords[monsterCid], maxDmg, maxHurt, maxHeal, totalDmg, totalHurt, totalHeal, cfgBattleAreaData.AwaysDraw)

			isShow = true
		end

		self:StopTimer()

		self.CellTweenTimer = FrameTimer.New(function()
			if self.CellTweenTimer.loop == 1 then
				self.CellTweenTimer = nil
			end

			local battleUnitCell = animCells[1]

			battleUnitCell:DoTweenPlay()
			table.remove(animCells, 1)

			if #animCells == 0 then
				self.Playing = false
			end
		end, 5, #animCells)

		self.CellTweenTimer:Start()
	end

	self.SoulGrid:SetActive(isShow)
end

function ChallengeRewardUI:OnClickJumpBtn()
	self:OnClickBtnClose()

	local go = self.UIController:GetCurrentTarget()
	local id = tonumber(go.name)
	local cfg = CfgWaysToStrengthenTable[id]

	JumpModule.Jump(cfg.Function)
end

function ChallengeRewardUI:StopTimer()
	if self.CellTweenTimer ~= nil then
		self.CellTweenTimer:Stop()

		self.CellTweenTimer = nil
	end
end

return ChallengeRewardUI
