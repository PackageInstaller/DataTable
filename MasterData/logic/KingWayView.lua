-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingWayView.lua

module("logic.extensions.kingway.view.KingWayView", package.seeall)

local KingWayView = class("KingWayView", ViewComponent)

function KingWayView:ctor()
	KingWayView.super.ctor(self)

	self.wayInfoList = nil
	self.isInitList = {
		false,
		false
	}
	self.lineAllList = nil
	self.itemAllList = nil
	self.roleModelList = nil
	self.isInitSlide = false
end

function KingWayView:bindEvents()
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.viewTipBtn:AddClickListener(function()
		UIStateManager.instance:open(ViewName.RulesView, "kingload")
	end, self)
	self.bossClickBtn:AddClickListener(function()
		if self.battleId < self.allKingCount then
			FloatWordMgr.instance:show("击败所有精灵后才可挑战圣光飞龙！")

			return
		end

		if self.battleId > self.allKingCount then
			FloatWordMgr.instance:show("该挑战已成功通关！")

			return
		end

		if self.selfMaxPower < self.wayInfoList[self.battleId].zdlLimit then
			FloatWordMgr.instance:show(string.format("当前战力未达到%s，不可挑战！", self.wayInfoList[self.battleId].zdlLimit))

			return
		end

		UIStateManager.instance:clear()
		KingWayModel.instance:ClickKingWayLastNpcBtn()
	end, self)
	self.tableSR:RegisterCallback(function()
		return 2
	end, function()
		return 1240, 530
	end, self.CellAtIndex, self)
end

function KingWayView:unbindEvents()
	for _, item in pairs(self.itemAllList or {}) do
		if item and item.subGo then
			GameUtil.asBtn(item.subGo):RemoveClickListener()
		end
	end

	self.viewCloseBtn:RemoveClickListener()
	self.viewTipBtn:RemoveClickListener()
	self.bossClickBtn:RemoveClickListener()
	self.tableSR:UnRegisterCallback()
end

function KingWayView:buildUI()
	KingWayView.super.buildUI(self)

	local upShowGo = self:getGo("upShowGo")

	self.viewCloseBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewCloseBtn")
	self.viewTipBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewTipBtn")
	self.powerTxt = goutil.findChildTextComponent(upShowGo, "powerGo/powerTxt")
	self.bossClickBtn = self:getBtn("bossClickBtn")
	self.sgzyShowTxt = self:getGo("bossClickBtn/sgzyShowTxt"):GetComponent("Text")
	self.bossLockGo = self:getGo("bossClickBtn/bossLockGo")
	self.bossCellTxt = self:getGo("bossClickBtn/bossCellTxt"):GetComponent("Text")
	self.bossWinGo = self:getGo("bossClickBtn/bossWinGo")
	self.bossRedGo = self:getGo("bossClickBtn/bossRedGo")
	self.sgzyShowTxt.text = ""
	self.bossCellTxt.text = ""

	self.bossLockGo:SetActive(false)
	self.bossWinGo:SetActive(false)
	self.bossRedGo:SetActive(false)

	self.cellGo = self:getGo("cellGo")
	self.choiseGo = self:getGo("choiseGo")
	self.jiantouGo = self:getGo("choiseGo/jiantouGo")
	self.redpointGo = self:getGo("choiseGo/redpointGo")

	self.cellGo:SetActive(false)
	self.redpointGo:SetActive(false)
	self.choiseGo:SetActive(false)

	self.itemGo_1 = self:getGo("itemGo_1")
	self.itemGo_2 = self:getGo("itemGo_2")
	self.tableSR = self:getGo("itemAllSR"):GetComponent("UITableview")

	self.itemGo_1:SetActive(false)
	self.itemGo_2:SetActive(false)

	self.viewEffPos = self:getGo("viewEffPos")
end

function KingWayView:onEnterFinished()
	KingWayView.super.onEnterFinished(self)
end

function KingWayView:onExitFinished()
	return
end

function KingWayView:onExit()
	self.isInitSlide = false
	self.tempMat = nil

	GlobalDispatcher:removeListener("UpdataKingWayView", self.UpdataKingWayView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PlayerStrengthChange, self.SetPlayerMaxPower, self)
	removetimer(self.DownTimeEff, self)

	self.wayInfoList = nil
	self.isInitList = {
		false,
		false
	}

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	for _, item in pairs(self.itemAllList or {}) do
		if item and item.subGo and item.subGo.activeSelf then
			item.subGo:SetActive(false)
		end
	end

	for _, loader in pairs(self.roleModelList or {}) do
		if loader then
			RoleObjectPool.instance:removeRole(loader)
		end
	end

	self.roleModelList = nil
end

function KingWayView:destroyUI()
	self.lineAllList = nil

	for _, item in pairs(self.itemAllList or {}) do
		if item and item.subGo then
			UnityEngine.GameObject.Destroy(item.subGo)
		end
	end

	self.itemAllList = nil
end

function KingWayView:onEnter()
	KingWayView.super.onEnter(self)
	self.redpointGo:SetActive(false)

	self.tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))

	local effPath = "fx_ui_wangzhezhilu/fx_ui_wangzhezhilu_smoke.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewEffPos, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewEffPos.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)

	self.allKingCount = KingWayModel.instance:GetKingAllBattleCount()

	self:UpdataKingWayView()
	GlobalDispatcher:addListener("UpdataKingWayView", self.UpdataKingWayView, self)
	GlobalDispatcher:addListener(GlobalNotify.PlayerStrengthChange, self.SetPlayerMaxPower, self)
end

function KingWayView:UpdataKingWayView()
	self:SetPlayerMaxPower()

	self.wayInfoList = KingWayConfig.instance:GetWayBaseCfg()

	if self.wayInfoList == nil or #self.wayInfoList ~= self.allKingCount then
		error("sr_王者之路  KingWayView:UpdataKingWayView()    获取配置个数 ~= " .. self.allKingCount)

		return
	end

	self.tableSR:ReloadData()

	if KingWayModel.instance.kingBaseInfo == nil then
		return
	end

	self.battleId, self.stageId = KingWayModel.instance:GetKingBattleAndStageId()

	local count = self.allKingCount - 1

	if self.wayInfoList[self.allKingCount] then
		self.bossCellTxt.text = self.wayInfoList[self.allKingCount].challengeDes or "传说神宠-圣光飞龙"
	end

	if count < self.battleId then
		self.sgzyShowTxt.text = "已获得 " .. count .. "/" .. count

		if self.battleId > self.allKingCount then
			self.bossLockGo:SetActive(self.selfMaxPower < self.wayInfoList[self.allKingCount].zdlLimit)
		else
			self.bossLockGo:SetActive(self.selfMaxPower < self.wayInfoList[self.battleId].zdlLimit)
		end

		local isRed = KingWayModel.instance:GetKingViewRedPoint()

		self.bossRedGo:SetActive(isRed)

		if self.wayInfoList[self.allKingCount] then
			self.bossCellTxt.text = self.wayInfoList[self.allKingCount].challengeName or "传说神宠-圣光飞龙"
		end
	else
		self.sgzyShowTxt.text = "已获得 " .. self.battleId - 1 .. "/" .. count

		self.bossLockGo:SetActive(true)
		self.bossRedGo:SetActive(false)
	end

	self.bossWinGo:SetActive(self.battleId > self.allKingCount)
	self.choiseGo:SetActive(false)
	settimer(0.5, self.DownTimeEff, self, false)
end

function KingWayView:SetPlayerMaxPower(count)
	self.selfMaxPower = count and count >= 0 and count or RoleModel.instance:getMaxPower() or 0
	self.powerTxt.text = "当前战力：" .. self.selfMaxPower
end

function KingWayView:DownTimeEff()
	if self.battleId >= self.allKingCount then
		return
	end

	if self.itemAllList[self.battleId] == nil or self.itemAllList[self.battleId].subGo == nil then
		return
	end

	self.choiseGo:SetActive(true)
	self.choiseGo.transform:SetParent(self.itemAllList[self.battleId].subGo.transform)
	Framework.TransformUtil.SetLocalPos(self.choiseGo.transform, 0, 0, 0)

	local isRed = KingWayModel.instance:GetKingViewRedPoint()

	self.redpointGo:SetActive(isRed)
end

function KingWayView:CellAtIndex(view, idx)
	local cell = view:DequeueCellByTag(idx)

	if not cell then
		local content = view:GetContent()

		if idx == 0 then
			self.itemGo_1:SetActive(true)
			self.itemGo_1.transform:SetParent(content.transform)

			cell = self.itemGo_1:GetComponent("UITableviewCell")
		else
			self.itemGo_2:SetActive(true)
			self.itemGo_2.transform:SetParent(content.transform)

			cell = self.itemGo_2:GetComponent("UITableviewCell")
		end
	end

	cell.data = idx + 1
	cell.index = idx
	cell.tag = idx

	self:UpdateCell(cell, subCount)

	if idx == 0 then
		GuideController.instance:setViewVar("kingway_loaded_end", 1)
	end

	if idx > 0 then
		return cell
	end

	local conGo = view:GetContent()

	if not self.isInitSlide and conGo then
		self.isInitSlide = true

		if self.battleId < 4 then
			Framework.TransformUtil.SetLocalPos(conGo.transform, 0, 0, 0)
		elseif self.battleId == 4 then
			Framework.TransformUtil.SetLocalPos(conGo.transform, -500, 0, 0)
		elseif self.battleId == 5 then
			Framework.TransformUtil.SetLocalPos(conGo.transform, -900, 0, 0)
		else
			Framework.TransformUtil.SetLocalPos(conGo.transform, -1100, 0, 0)
		end
	end

	return cell
end

function KingWayView:UpdateCell(cell)
	local index = cell.data

	if self.isInitList[index] then
		return
	end

	self.isInitList[index] = true

	local lineAllTran = goutil.findChild(cell, "lineAllTran").transform
	local cellAllTran = goutil.findChild(cell, "cellAllTran").transform

	self.lineAllList = self.lineAllList or {}

	for i = 1, lineAllTran.childCount do
		local go = lineAllTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")
		local num = tonumber(names[2])

		self.lineAllList[num] = self.lineAllList[num] or {}
		self.lineAllList[num][tonumber(names[3])] = go:GetComponent("UIImageSpriteChange")
	end

	self.itemAllList = self.itemAllList or {}

	for i = 1, cellAllTran.childCount do
		local go = cellAllTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		self.itemAllList[tonumber(names[2])] = {
			parGo = go
		}
	end

	local subStart = 1
	local subEnd = 4

	if index ~= 1 then
		subStart = 5
		subEnd = self.allKingCount - 1
	end

	for i = subStart, subEnd do
		self.itemAllList[i] = self.itemAllList[i] or {}

		if self.itemAllList[i].subGo == nil then
			local go = UnityEngine.GameObject.Instantiate(self.cellGo, self.itemAllList[i].parGo.transform)

			go:SetActive(true)

			self.itemAllList[i].subGo = go
			self.itemAllList[i].roleModel = goutil.findChild(go, "roleModel")
			self.itemAllList[i].subIconIma = go:GetComponent("UIImageSpriteChange")
			self.itemAllList[i].subDesTxt = goutil.findChildTextComponent(go, "cellTxt")
			self.itemAllList[i].winIconGo = goutil.findChild(go, "winIconGo")
			self.itemAllList[i].lockGo = goutil.findChild(go, "lockGo")
		end

		local num = i

		self.itemAllList[num].lockGo:SetActive(false)

		local loader = self:ShowRoleModel(num, self.itemAllList[num].roleModel)

		self.itemAllList[num].subDesTxt.text = self.wayInfoList[num].challengeName

		if num < self.battleId then
			self.itemAllList[num].subIconIma:SetState(num + 7)
			self.itemAllList[num].winIconGo:SetActive(true)
		elseif num == self.battleId then
			self.itemAllList[num].subIconIma:SetState(num - 1)
			self.itemAllList[num].winIconGo:SetActive(false)

			if self.selfMaxPower < self.wayInfoList[num].zdlLimit then
				self.itemAllList[num].subDesTxt.text = self.wayInfoList[num].challengeDes

				self.itemAllList[num].lockGo:SetActive(true)
			end
		else
			self.itemAllList[num].subIconIma:SetState(num - 1)
			self.itemAllList[num].winIconGo:SetActive(false)

			self.itemAllList[num].subDesTxt.text = self.wayInfoList[num].challengeDes

			self.itemAllList[num].lockGo:SetActive(true)
		end

		local modelOff = CharacterConfig.instance:getModelUIPosAndScale("kingway", self.wayInfoList[num].petId)

		uGuiUtil.setLocalPosition(self.itemAllList[num].roleModel, Vector3.New(modelOff[1] or 0, modelOff[2] or 0, 0))
		uGuiUtil.setLocalScale(self.itemAllList[num].roleModel, Vector3.New(modelOff[3] or 1, modelOff[3] or 1, modelOff[3] or 1))

		self.roleModelList = self.roleModelList or {}
		self.roleModelList[num] = loader

		GameUtil.asBtn(self.itemAllList[num].subGo):AddClickListener(function()
			if num > self.battleId then
				FloatWordMgr.instance:show("请先通关前面的关卡！")

				return
			end

			if num < self.battleId then
				FloatWordMgr.instance:show("该挑战已成功通关！")

				return
			end

			if self.selfMaxPower < self.wayInfoList[num].zdlLimit then
				FloatWordMgr.instance:show(string.format("当前战力未达到%s，不可挑战！", self.wayInfoList[num].zdlLimit))

				return
			end

			KingWayModel.instance:SetBattlePlayerPrefs(true)

			if num == #self.wayInfoList and num == self.allKingCount then
				UIStateManager.instance:clear()
				KingWayModel.instance:ClickKingWayLastNpcBtn()

				return
			end

			UIStateManager.instance:push(ViewName.KingBattle, num)
		end)

		local list = self.lineAllList[num]

		if list and #list > 0 then
			for j = 1, #list do
				list[j]:SetState(num <= self.battleId and 1 or 0)
			end
		end
	end
end

function KingWayView:ShowRoleModel(index, modelGo)
	if self.wayInfoList == nil or self.wayInfoList[index] == nil or modelGo == nil then
		return
	end

	local petId = self.wayInfoList[index].petId
	local petCfg = CharacterConfig.instance:getPetCo(petId)

	if petCfg == nil then
		error("sr_王者之路  KingBattleView:ShowRoleModel()    精灵配置为空 = " .. petId)

		return
	end

	local loader

	if self.roleModelList and self.roleModelList[index] then
		loader = self.roleModelList[index]
	end

	local offset = CharactorFacade.instance:getLegendModelUIPosAndScale(petId)
	local x, y, scale = 0, 0, 1
	local scaleY

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])

		if offset[4] then
			local var_20_0 = {}

			var_20_0[1] = offset[3] or 1
			var_20_0[2] = offset[4] * 0.4
			var_20_0[3] = offset[4] * 0.4
			scale = var_20_0
		else
			scale = offset[3] or 1
		end
	end

	loader = loader and RoleObjectPool.instance:removeRole(loader)
	loader = RoleObjectPool.instance:addRoleToParent(loader, petCfg.faceIds, modelGo, scale * 0.3, function(go)
		if go ~= nil then
			local skeleton = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

			self.tempMat.mainTexture = skeleton.material.mainTexture
			skeleton.material = self.tempMat
		end
	end, nil, x, y)

	return loader
end

return KingWayView
