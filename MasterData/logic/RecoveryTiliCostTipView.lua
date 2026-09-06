-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/RecoveryTiliCostTipView.lua

module("logic.extensions.lottery.view.RecoveryTiliCostTipView", package.seeall)

local RecoveryTiliCostTipView = class("RecoveryTiliCostTipView", ViewComponent)

function RecoveryTiliCostTipView:ctor()
	RecoveryTiliCostTipView.super.ctor(self)
end

function RecoveryTiliCostTipView:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._useBtn:AddClickListener(self._onClickUse, self)
	self._m10Btn:AddClickListener(self._onClickM10, self)
	self._minusBtn:AddClickListener(self._onClickMinus, self)
	self._addBtn:AddClickListener(self._onClickAdd, self)
	self._a10Btn:AddClickListener(self._onClickA10, self)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
end

function RecoveryTiliCostTipView:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._useBtn:RemoveClickListener()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
end

function RecoveryTiliCostTipView:buildUI()
	self._closeBtn = self:getBtn("BG/Close")
	self.txtTitle = self:getTxt("BG/txtTitle")
	self.txtUse = self:getTxt("Tip/BtnUse/Txt")
	self._useBtn = self:getBtn("Tip/BtnUse")
	self._m10Btn = self:getBtn("Tip/Marks/BtnM10")
	self._minusBtn = self:getBtn("Tip/Marks/BtnMs")
	self._addBtn = self:getBtn("Tip/Marks/BtnAdd")
	self._a10Btn = self:getBtn("Tip/Marks/BtnA10")
	self._nameTxt = self:getTxt("Tip/TxtName")
	self._haveTxt = self:getTxt("Tip/TxtHave")
	self.icon = self:getGo("Tip/IconBg")
	self._procNumText = self:getInput("Tip/IptItem")
	self._imgReward = self:getGo("Tip/imgReward")
	self._txtReward = self:getTxt("Tip/txtReward")
end

function RecoveryTiliCostTipView:destroyUI()
	return
end

function RecoveryTiliCostTipView:onEnter()
	self._matType = self._viewPresentor._openParam[1]
	self._goodsId = self._viewPresentor._openParam[2]
	self._index = self._viewPresentor._openParam[3]
	self._matCfg = MaterialConfig.instance:getCfgByMatAndId(self._matType, self._goodsId)
	self._matGetStrengthList = SupplyConfig.instance:getMatGetStrengthList()
	self.txtTitle.text = lang("道具使用")
	self.txtUse.text = lang("使用")

	self:initTip()
end

function RecoveryTiliCostTipView:initTip()
	local hasNum = MaterialModel.instance:getMaterialsNumber(self._matType, self._goodsId)
	local matName = MaterialMgr.getMaterialsName(self._matType, self._goodsId)
	local rewardStrenghNum = self._matGetStrengthList[self._index - 1]

	self._haveTxt.text = string.format("已拥有：%d", hasNum)
	self.sellMaxNum = hasNum

	local defaultNum = math.min(hasNum, 1)

	self._procNumText:SetText(defaultNum)

	self._nameTxt.text = matName
	self._txtReward.text = defaultNum * rewardStrenghNum

	MaterialMgr.setCell(self._matType, self._goodsId, self.icon)
end

function RecoveryTiliCostTipView:onEnterFinished()
	return
end

function RecoveryTiliCostTipView:onExit()
	MaterialMgr.resetAll(self.icon)
end

function RecoveryTiliCostTipView:onExitFinished()
	return
end

function RecoveryTiliCostTipView:_changeNumText(delta)
	local num = checknumber(self._procNumText:GetText()) + delta
	local rewardStrenghNum = self._matGetStrengthList[self._index - 1]

	num = Mathf.Clamp(num, 1, self.sellMaxNum)

	self._procNumText:SetText(tostring(num))

	self._txtReward.text = num * rewardStrenghNum
end

function RecoveryTiliCostTipView:_onValueChanged(strNum)
	local rewardStrenghNum = self._matGetStrengthList[self._index - 1]
	local num = checknumber(strNum)

	num = Mathf.Clamp(num, 1, self.sellMaxNum)

	self._procNumText:SetText(tostring(num))

	self._txtReward.text = num * rewardStrenghNum
end

function RecoveryTiliCostTipView:_onClickClose()
	self:close()
end

function RecoveryTiliCostTipView:sendUseMsg()
	local num = checknumber(self._procNumText:GetText())

	if self._matCfg.materialUseType == MatUseType.GOLDEN_DIAMOND_CARD then
		FloatWordMgr.instance:show(langPara("金钻特权有效期天数+%s天", checkint(self._matCfg.content) * num))
	end

	MaterialFacade.instance:useItem(self._matType, self._goodsId, num, nil, GameUtil.handler(self._onClickClose, self))
end

function RecoveryTiliCostTipView:_onClickUse()
	local content = self._matCfg.content

	if content then
		local temList = {}
		local temp = string.split(content, "#")

		for i, v in ipairs(temp) do
			local arr = string.split(v, ":")
			local matType = checknumber(arr[1])
			local id = checknumber(arr[2])
			local day = checknumber(arr[3])

			if matType == MatType.PET_SKIN and day > 0 then
				local skinCfg = PetSkinConfig.instance:getPetSkinCfg(id)
				local skinGroup = checknumber(skinCfg.skinGroup)
				local list = PetSkinConfig.instance:getPetSkinListBySkinGroup(skinGroup)
				local hasPet = false

				for i, v in ipairs(list) do
					hasPet = hasPet or BagPetsController.instance:getPetNumByRaceId(v.raceId) > 0
				end

				if not hasPet then
					table.insert(temList, skinCfg)
				end
			end
		end

		if #temList > 0 then
			local skinNameList = {}

			for i, v in ipairs(temList) do
				table.insert(skinNameList, v.skinName)
			end

			TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("使用此道具会获得皮肤【%s】,您还未获得可穿戴该皮肤的精灵，是否确定使用体验卡兑换该皮肤体验权？", table.concat(skinNameList, ", ")), function()
				self:realUseMaterial(self._matCfg)
			end)
			self:close()

			return
		end
	end

	self:realUseMaterial(self._matCfg)
end

function RecoveryTiliCostTipView:realUseMaterial(cfg)
	if cfg and cfg.materialValuable == 1 then
		GameUtil.SetActive(self.mainGO, false)
		UIStateManager.instance:open(ViewName.GiftbagopenView, GameUtil.handler(self.sendUseMsg, self))
	else
		self:sendUseMsg()
	end
end

function RecoveryTiliCostTipView:_onClickM10()
	self:_changeNumText(-10)
end

function RecoveryTiliCostTipView:_onClickMinus()
	self:_changeNumText(-1)
end

function RecoveryTiliCostTipView:_onClickAdd()
	self:_changeNumText(1)
end

function RecoveryTiliCostTipView:_onClickA10()
	self:_changeNumText(10)
end

return RecoveryTiliCostTipView
