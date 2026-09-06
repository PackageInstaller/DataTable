-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceUpgradeView.lua

module("logic.extensions.sourcetrace.view.SourceTraceUpgradeView", package.seeall)

local SourceTraceUpgradeView = class("SourceTraceUpgradeView", ViewComponent)
local SINGLE_COSTGO_POS = {
	0,
	-155
}
local MUTIL_COSTGO_POS = {
	0,
	-120
}
local ICON_TYPE_LOAD = 1
local ICON_TYPE_SPRITE = 2

function SourceTraceUpgradeView:ctor()
	SourceTraceUpgradeView.super.ctor(self)
end

function SourceTraceUpgradeView:unbindEvents()
	SourceTraceUpgradeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function SourceTraceUpgradeView:bindEvents()
	SourceTraceUpgradeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SourceTraceUpgradeView:buildUI()
	SourceTraceUpgradeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("totalInfo/buttomInfo/btnSure")
	self._txtSure = self:getTxt("totalInfo/buttomInfo/btnSure/txt")
	self._mutiInfo = self:getGo("totalInfo/mutiInfo")
	self._singleInfo = self:getGo("totalInfo/singleInfo")
	self._singleIconLoad = self:getGo("totalInfo/singleInfo/Mask/ImgC_Skill")
	self._singleIconSprite = self:getGo("totalInfo/singleInfo/Mask/ImgC_Icon")
	self._imageChangeSingleIcon = self._singleIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	self._cost = self:getGo("totalInfo/cost")
	self._costCon = self:getGo("totalInfo/cost/con")
	self._txtCost = self:getTxt("totalInfo/cost/txtCost")
	self._colorChangeTxtCost = self._txtCost.gameObject:GetComponent(ComponentType.UITextColorChange)
	self._effectTableview = self:getGo("totalInfo/mutiInfo/effectTableview")
	self._effectTableCell = self:getGo("totalInfo/mutiInfo/effectTableview/effectTableCell")
	self._effectTableList = ScrollerList.create(self._effectTableview, self._effectTableCell, GameUtil.handler(self._updateEffectCell, self), GameUtil.handler(self._clearEffectCell, self))

	self._effectTableList:setCenterMode(true)

	self._singleActiveTag = self:getGo("totalInfo/buttomInfo/singleActiveTag")
	self._activeTag = self:getGo("totalInfo/buttomInfo/activeTag")
	self._multiTips = self:getGo("totalInfo/buttomInfo/multiTips")
	self._txtName = self:getTxt("totalInfo/singleInfo/effectName/txtName")
	self._txtMutilDesc = self:getTxt("totalInfo/mutiInfo/txtDesc")
	self._txtSingleDesc = self:getTxt("totalInfo/singleInfo/txtDesc")
end

function SourceTraceUpgradeView:onExit()
	SourceTraceUpgradeView.super.onExit(self)
	self._effectTableList:dispose()
	uGuiUtil.clearImage(self._singleIconLoad)
	MaterialMgr.resetAll(self._costCon)
end

function SourceTraceUpgradeView:onEnter()
	SourceTraceUpgradeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_SourceTraceUnlockNodeRes, self._PM_SourceTraceUnlockNodeRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_SourceTraceChangeEffectRes, self._PM_SourceTraceChangeEffectRes, self)

	local params = self:getOpenParam()

	self._nodeId = checknumber(params[1])
	self._effectId = checknumber(params[2])
	self._curPetMo = BagPetsController.instance:GetCurPetMo()
	self._nodeInfoMap = {}

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		self._nodeInfoMap[v.nodeId] = v
	end

	self._nodeInfo = nil

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		if v.nodeId == self._nodeId then
			self._nodeInfo = v

			break
		end
	end

	local petCfg = CharacterConfig.instance:getPetCo(self._curPetMo.raceId)
	local sourceTraceId = petCfg.sourceTraceId

	self._nodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(sourceTraceId, self._nodeId)
	self._isMultiEffect = #self._nodeCfg.effectIds > 1

	GameUtil.SetActive(self._mutiInfo, self._isMultiEffect)
	GameUtil.SetActive(self._singleInfo, not self._isMultiEffect)

	if self._effectId == 0 then
		self._effectId = self._nodeCfg.effectIds[1]
	end

	if self._isMultiEffect then
		GameUtil.setAnchoredPos(self._cost, MUTIL_COSTGO_POS[1], MUTIL_COSTGO_POS[2], 0)
	else
		GameUtil.setAnchoredPos(self._cost, SINGLE_COSTGO_POS[1], SINGLE_COSTGO_POS[2], 0)
	end

	self:_refreshView()
end

function SourceTraceUpgradeView:_refreshView()
	local effectCfg = SourceTraceConfig.instance:getEffectCfg(self._effectId)

	uGuiUtil.clearImage(self._singleIconLoad)

	if self._isMultiEffect == true then
		self._effectTableList:reloadData(self._nodeCfg.effectIds)
	else
		GameUtil.SetActive(self._singleIconLoad, false)
		GameUtil.SetActive(self._singleIconSprite, false)

		if effectCfg.iconType == ICON_TYPE_LOAD then
			GameUtil.SetActive(self._singleIconLoad, true)
			uGuiUtil.setSpriteToImage(self._singleIconLoad, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(effectCfg.iconRes))
		elseif effectCfg.iconType == ICON_TYPE_SPRITE then
			GameUtil.SetActive(self._singleIconSprite, true)
			self._imageChangeSingleIcon:ChangeSprite(effectCfg.iconRes)
		end
	end

	if not string.nilorempty(self._nodeCfg.unlockCost) then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._nodeCfg.unlockCost)

		MaterialMgr.resetAll(self._costCon)

		local proxy = MaterialMgr.setCell(matType, matId, self._costCon)

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				TipsFacade.instance:openItemSourceView(self._nodeCfg.unlockCost)
			end)
		end

		local curNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		self._txtCost.text = langPara("%d<color=#1E356CFF>/%d</color>", curNum, matNum)

		if curNum < matNum then
			self._colorChangeTxtCost:SetState(0)
		else
			self._colorChangeTxtCost:SetState(1)
		end
	end

	self._txtName.text = effectCfg.name
	self._txtMutilDesc.text = effectCfg.desc
	self._txtSingleDesc.text = effectCfg.desc

	local isActivable = true

	if self._nodeCfg.preNodeIds then
		for i, v in ipairs(self._nodeCfg.preNodeIds) do
			if self._nodeInfoMap[v] == nil then
				isActivable = false

				break
			end
		end
	end

	GameUtil.SetActive(self._singleActiveTag, not self._isMultiEffect and self._nodeInfo ~= nil)
	GameUtil.SetActive(self._activeTag, not isActivable)
	GameUtil.SetActive(self._multiTips, self._isMultiEffect == true)
	GameUtil.SetActive(self._cost, self._nodeInfo == nil)
	GameUtil.SetActive(self._btnSure, (self._isMultiEffect or self._nodeInfo == nil) and isActivable == true)

	self._txtSure.text = (not self._isMultiEffect or self._nodeInfo == nil) and lang("激活") or lang("激活")
end

function SourceTraceUpgradeView:_updateEffectCell(view, cell, data, tag)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local activeTag = goutil.findChild(go, "activeTag")
	local btn = goutil.findChild(go, "btn")
	local var_9_0 = goutil.findChild(go, "imgSelect")

	GameUtil.SetActive(imgSelect, self._isMultiEffect and data == self._effectId)
	GameUtil.SetActive(activeTag, self._isMultiEffect and self._nodeInfo and self._nodeInfo.effectId == data)

	local effectCfg = SourceTraceConfig.instance:getEffectCfg(data)

	uGuiUtil.clearImage(skillIconLoad)
	GameUtil.SetActive(skillIconLoad, false)
	GameUtil.SetActive(skillIconSprite, false)

	if effectCfg.iconType == ICON_TYPE_LOAD then
		GameUtil.SetActive(skillIconLoad, true)
		uGuiUtil.setSpriteToImage(skillIconLoad, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(effectCfg.iconRes))
	elseif effectCfg.iconType == ICON_TYPE_SPRITE then
		GameUtil.SetActive(skillIconSprite, true)
		imageChangeSkillIcon:ChangeSprite(effectCfg.iconRes)
	end

	GameUtil.addClickHandler(btn, function()
		self:_onClickEffectCell(data)
	end)
end

function SourceTraceUpgradeView:_clearEffectCell(cell)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIconLoad)
end

function SourceTraceUpgradeView:_isCanActiveNode(groupId, nodeId)
	local cfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(groupId, nodeId)
	local isActivable = self._nodeInfoMap[cfg.nodeId] == nil

	if isActivable == true and cfg.preNodeIds then
		for i, v in ipairs(cfg.preNodeIds) do
			if self._nodeInfoMap[v] == nil then
				isActivable = false

				break
			end
		end
	end

	local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(cfg.unlockCost)

	if isActivable == true and not MaterialModel.instance:IsEnough(costMatType, costMatId, costMatNum) then
		isActivable = false
	end

	return isActivable
end

function SourceTraceUpgradeView:_onClickEffectCell(effectId)
	self._effectId = effectId

	self:_refreshView()
end

function SourceTraceUpgradeView:_onClickSure()
	if self._nodeInfo == nil then
		if self._nodeCfg.preNodeIds then
			for i, v in ipairs(self._nodeCfg.preNodeIds) do
				if self._nodeInfoMap[v] == nil then
					FloatWordMgr.instance:show(lang("前置节点未解锁"))

					return
				end
			end
		end

		local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(self._nodeCfg.unlockCost)

		if not MaterialModel.instance:IsEnough(costMatType, costMatId, costMatNum) then
			FloatWordMgr.instance:show(lang("所需材料不足"))

			return
		end

		SourceTraceAgent.instance:sendPM_SourceTraceUnlockNodeReq(self._curPetMo.petId, self._nodeId)
	elseif self._isMultiEffect == true then
		if self._nodeInfo.effectId == self._effectId then
			FloatWordMgr.instance:show(lang("已激活"))
		else
			SourceTraceAgent.instance:sendPM_SourceTraceChangeEffectReq(self._curPetMo.petId, self._nodeId, self._effectId)
		end
	else
		FloatWordMgr.instance:show(lang("已激活"))
	end
end

function SourceTraceUpgradeView:_PM_SourceTraceUnlockNodeRes()
	self._curPetMo = BagPetsController.instance:GetCurPetMo()
	self._nodeInfoMap = {}

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		self._nodeInfoMap[v.nodeId] = v
	end

	self._nodeInfo = nil

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		if v.nodeId == self._nodeId then
			self._nodeInfo = v

			break
		end
	end

	if self._effectId ~= self._nodeCfg.effectIds[1] then
		SourceTraceAgent.instance:sendPM_SourceTraceChangeEffectReq(self._curPetMo.petId, self._nodeId, self._effectId)
	else
		self:_refreshView()
	end
end

function SourceTraceUpgradeView:_PM_SourceTraceChangeEffectRes()
	self._curPetMo = BagPetsController.instance:GetCurPetMo()
	self._nodeInfoMap = {}

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		self._nodeInfoMap[v.nodeId] = v
	end

	self._nodeInfo = nil

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		if v.nodeId == self._nodeId then
			self._nodeInfo = v

			break
		end
	end

	self:_refreshView()
end

return SourceTraceUpgradeView
