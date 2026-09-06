-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/FamilyHoudingClgStageView.lua

module("logic.extensions.familyhoundingclg.view.FamilyHoudingClgStageView", package.seeall)

local FamilyHoudingClgStageView = class("FamilyHoudingClgStageView", ViewComponent)

function FamilyHoudingClgStageView:buildUI()
	FamilyHoudingClgStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._con = goutil.findChild(self.mainGO, "con")
	self._tipsCol = goutil.findChild(self.mainGO, "tipsCol")
	self._tipsCol_txt = goutil.findChildTextComponent(self.mainGO, "tipsCol/txt")
	self._desc_txt = goutil.findChildTextComponent(self.mainGO, "ruleCol/desc/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")

	local rankScrollerview = goutil.findChild(self.mainGO, "ruleCol/rankScrollerview")
	local rankScrollercell = goutil.findChild(self.mainGO, "ruleCol/rankScrollercell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "ruleCol/itemScrollercell")
	self._rankScrollList = ScrollerList.create(rankScrollerview, rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._btnSweep = goutil.findChild(self.mainGO, "ruleCol/btnSweep")
	self._btnChallenge_btn = goutil.findChild(self.mainGO, "ruleCol/btnChallenge/btn")
	self._btnChallenge_desc_txt = goutil.findChildTextComponent(self.mainGO, "ruleCol/btnChallenge/desc/txt")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function FamilyHoudingClgStageView:bindEvents()
	FamilyHoudingClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSweep, self._onClickBtnSweep, self)
	GameUtil.addClickHandler(self._btnChallenge_btn, self._onClickBtnChallenge, self)
end

function FamilyHoudingClgStageView:unbindEvents()
	FamilyHoudingClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSweep)
	GameUtil.rmClickHandler(self._btnChallenge_btn)
end

function FamilyHoudingClgStageView:onEnter()
	FamilyHoudingClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fhId = checknumber(params[1])
	self._dayIndex = checknumber(params[2])

	local isInTime = FamilyHoudingClgController.instance:isInTime(self._fhId)

	if not isInTime then
		local text = string.format("不在开启期限内( id = %d )", self._fhId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._planTimeData = FamilyHoudingClgConfig.instance:getFhPlanTimeData(self._fhId)
	self._bossData = FamilyHoudingClgConfig.instance:getFhBossData(self._fhId, self._dayIndex)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.handlePM_FamilyHounding_GetInfoRes, self._onUpdate, self)
	FamilyHoudingClgController.instance:sendPM_FamilyHounding_GetInfoReq()
end

function FamilyHoudingClgStageView:onExit()
	FamilyHoudingClgStageView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	self:_onClear()
end

function FamilyHoudingClgStageView:_onSetUI()
	return
end

function FamilyHoudingClgStageView:_onUpdate()
	local curFhId = FamilyHoudingClgController.instance:getCurPlanId()
	local dayIndex = FamilyHoudingClgController.instance:getCurDayIndex()

	if curFhId ~= self._fhId or dayIndex ~= self._dayIndex then
		local text = "挑战已更新"

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_onUpdatePlaneUI()
	self:_onUpdateRuleColUI()
end

function FamilyHoudingClgStageView:_onClear()
	self:_onClearRuleCol()
end

function FamilyHoudingClgStageView:_onUpdatePlaneUI()
	local curBuffId = FamilyHoudingClgController.instance:getCurBuffId()
	local buffData = FamilyHoudingClgConfig.instance:getFhBuffData(curBuffId)
	local nextBuffData = FamilyHoudingClgConfig.instance:getFhBuffData(curBuffId + 1)
	local formatTime = buffData and GameUtil.getFormatTimeByStamp(GameUtil.string2time(buffData.startTime), nil)
	local nextFormatTime = nextBuffData and GameUtil.getFormatTimeByStamp(GameUtil.string2time(nextBuffData.startTime), nil)
	local str1 = not string.nilorempty(formatTime) and not string.nilorempty(nextFormatTime) and string.format("祝福时间：%s-%s\n", formatTime, nextFormatTime) or not string.nilorempty(formatTime) and string.format("祝福时间：%s-永久\n", formatTime) or "祝福时间：永久\n"

	if buffData then
		if not buffData.desc then
			local buffDesc = ""
			local str2 = string.format("本期祝福：%s", buffDesc)

			self._tipsCol_txt.text = string.format("%s%s", str1, str2)

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tipsCol:GetComponent(goutil.Type_RectTransform))

			local leftTimes = FamilyHoudingClgController.instance:getLeftChallengeTimes()
			local maxTimes = FamilyHoudingClgController.instance:getMaxChallengeTimes(self._fhId)

			self._btnChallenge_desc_txt.text = string.format("挑战次数：%s/%s", leftTimes, maxTimes)

			local skinId = self._bossData.skinId

			if not self._bossData.lihuiPos then
				if not self._bossData.lihuiPos[3] then
					local x, y, scale = checknumber(self._bossData.lihuiPos[1]), checknumber(self._bossData.lihuiPos[2]), 1

					self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, self._bossData.lihuiPos[3], nil, true, x, y)

					if skinId > 0 then
						MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
					end

					self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
				end
			end
		end
	end
end

function FamilyHoudingClgStageView:_onUpdateRuleColUI()
	self._desc_txt.text = self._bossData.desc

	local damagePrizeCfg = FamilyHoudingClgConfig.instance:getFhDamagePrizeCfg(self._bossData.damagePrizePlanId)

	self._rankScrollList:reloadData(damagePrizeCfg)
end

function FamilyHoudingClgStageView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function FamilyHoudingClgStageView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local index = cell.index + 1
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtDesc.text = data.desc
	txtNum.text = index

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function FamilyHoudingClgStageView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function FamilyHoudingClgStageView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function FamilyHoudingClgStageView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function FamilyHoudingClgStageView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function FamilyHoudingClgStageView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function FamilyHoudingClgStageView:_onClickBtnSweep()
	local result, tips = FamilyHoudingClgController.instance:getTryPracticeStageClgResultAndTips(self._fhId, self._dayIndex)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	FamilyHoudingClgController.instance:enterBattle(self._fhId, self._dayIndex, true)
end

function FamilyHoudingClgStageView:_onClickBtnChallenge()
	local result, tips = FamilyHoudingClgController.instance:getTryFightStageClgResultAndTips(self._fhId, self._dayIndex)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	FamilyHoudingClgController.instance:enterBattle(self._fhId, self._dayIndex, false)
end

function FamilyHoudingClgStageView:_onClickBtnTip()
	local key = FamilyHoudingClgConfig.instance:getFhCommonValue(self._fhId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return FamilyHoudingClgStageView
