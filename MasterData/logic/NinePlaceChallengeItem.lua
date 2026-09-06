-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NinePlaceChallengeItem.lua

module("logic.extensions.nineplace.view.NinePlaceChallengeItem", package.seeall)

local NinePlaceChallengeItem = class("NinePlaceChallengeItem")

function NinePlaceChallengeItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:onEnter()
end

function NinePlaceChallengeItem:OnDestroy()
	self:onExit()
end

function NinePlaceChallengeItem:buildUI()
	self.ytg = goutil.findChild(self.mainGO, "ytg")
	self.goOkBtn = goutil.findChild(self.mainGO, "okBtn")
	self.okBtn = GameUtil.asBtn(self.goOkBtn)
	self.rewardCon = goutil.findChild(self.mainGO, "rewardCon/Viewport/Content")
	self.cellClone = goutil.findChild(self.mainGO, "rewardCon/Viewport/Content/cell")
	self.itemGroup = ItemGroup.New(self.rewardCon, self.cellClone, nil, nil, true)
	self.uIImgNumeralText = goutil.findChild(self.mainGO, "Num"):GetComponent(ComponentType.UIImgNumeralText)
	self.isLoaded = true

	if self.needRefreshData then
		self:initView()
	end
end

function NinePlaceChallengeItem:onEnter()
	self.okBtn:AddClickListener(self.onClickOk, self)
end

function NinePlaceChallengeItem:onExit()
	self.okBtn:RemoveClickListener()
	MaterialMgr.resetAll(self.rewardCon)
end

function NinePlaceChallengeItem:setData(currStageId, creepsMasterId, data, index)
	self.cfg = NinePlaceConfig.instance:getMonsterCfg(currStageId, creepsMasterId)
	self.currStageId = currStageId
	self.data = data
	self.index = index

	if not self.isLoaded then
		self.needRefreshData = true

		return
	end

	self:initView()
end

function NinePlaceChallengeItem:initView()
	if self.uIImgNumeralText then
		self.uIImgNumeralText:SetNum(self.index)
	end

	if self.data then
		local isPass = self.data.masterIdx >= self.index
		local canChallege = false

		if self.data then
			canChallege = self.data.masterIdx + 1 == self.index
		end

		self.isCanChallege = canChallege
		self.isPass = isPass

		GameUtil.SetActive(self.goOkBtn, canChallege)
		GameUtil.SetActive(self.ytg, isPass)

		local rewards = {}

		if self.cfg then
			local arr1 = string.split(self.cfg.prize, "#")

			for i, v in ipairs(arr1) do
				table.insert(rewards, v)
			end
		end

		self.itemGroup:updateWithMoArray(rewards, function(item, data)
			MaterialMgr.setCellByCfg(data, item.mainGO)
		end)
	end
end

function NinePlaceChallengeItem:onClickOk()
	if self.isPass then
		FloatWordMgr.instance:show("无法重复挑战哦")

		return
	elseif self.isCanChallege then
		if self.currStageId == 1 and self.index == 2 then
			local isOpen = FuncOpenModel.instance:getFuncIsOpen(201)

			if not isOpen then
				local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(44)

				if cfgFuncOpen then
					FloatWordMgr.instance:show(cfgFuncOpen.description)
				end

				return
			end
		end

		UIStateManager.instance:push(ViewName.NineplaceMissionView, self.currStageId, self.cfg.creepsMasterId)
	else
		FloatWordMgr.instance:show("请先通过前面的挑战哦")
	end
end

return NinePlaceChallengeItem
