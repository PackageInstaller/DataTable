-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceMultiNodeView.lua

module("logic.extensions.sourcetrace.view.SourceTraceMultiNodeView", package.seeall)

local SourceTraceMultiNodeView = class("SourceTraceMultiNodeView", ViewComponent)
local ICON_TYPE_LOAD = 1
local ICON_TYPE_SPRITE = 2
local LINK_MAX_COUNT = 3

function SourceTraceMultiNodeView:ctor()
	SourceTraceMultiNodeView.super.ctor(self)
end

function SourceTraceMultiNodeView:unbindEvents()
	SourceTraceMultiNodeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnPre)
	GameUtil.rmClickHandler(self._btnClose)
end

function SourceTraceMultiNodeView:bindEvents()
	SourceTraceMultiNodeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNext, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickPre, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SourceTraceMultiNodeView:buildUI()
	SourceTraceMultiNodeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._cost = self:getGo("cost")
	self._costCon = self:getGo("cost/con")
	self._txtCost = self:getTxt("cost/txtCost")
	self._colorChangeTxtCost = self._txtCost.gameObject:GetComponent(ComponentType.UITextColorChange)
	self._txtActiveTips = self:getGo("txtActiveTips")
	self._effectTableview = self:getGo("mutiInfo/effectTableview")
	self._effectTableCell = self:getGo("mutiInfo/effectTableview/effectTableCell")
	self._effectTableList = ScrollerList.create(self._effectTableview, self._effectTableCell, GameUtil.handler(self._updateEffectCell, self), GameUtil.handler(self._clearEffectCell, self))

	self._effectTableList:setCenterMode(true)

	self._txtNodeName = self:getTxt("txtNodeName")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtBaseDesc = self:getTxt("desctableview/viewport/content/txtBaseDesc")
	self._nodeTablecell = self:getGo("mutiInfo/nodeTableview/nodeTablecell")
	self._nodeTableview = self:getGo("mutiInfo/nodeTableview")
	self._nodeTableList = ScrollerList.create(self._nodeTableview, self._nodeTablecell, GameUtil.handler(self._updateNodeCell, self), GameUtil.handler(self._clearNodeCell, self))
	self._linkGo = self:getGo("mutiInfo/link")
	self._linkGoMap = {}

	for i = 1, LINK_MAX_COUNT do
		self._linkGoMap[i] = self._linkGoMap[i] or {}

		for j = 1, LINK_MAX_COUNT do
			self._linkGoMap[i][j] = goutil.findChild(self._linkGo, string.format("link_%d_%d", i, j))
		end
	end

	self._btnNext = self:getGo("btnNext")
	self._btnPre = self:getGo("btnPre")
	self._canActiveTag = self:getGo("activeTag")
end

function SourceTraceMultiNodeView:onExit()
	SourceTraceMultiNodeView.super.onExit(self)
	MaterialMgr.resetAll(self._costCon)
end

function SourceTraceMultiNodeView:onEnter()
	SourceTraceMultiNodeView.super.onEnter(self)
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

	self._sourceTraceId = petCfg.sourceTraceId
	self._multiNode = {}

	local nodsCfg = SourceTraceConfig.instance:getSourceTraceNodeCfgs(self._sourceTraceId)

	self._multiNodeIndex = 1

	for i, v in ipairs(nodsCfg) do
		if #v.effectIds > 1 then
			table.insert(self._multiNode, v.nodeId)

			if v.nodeId == self._nodeId then
				self._multiNodeIndex = #self._multiNode
			end
		end
	end

	self:_refreshView()
end

function SourceTraceMultiNodeView:_refreshView()
	self._nodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(self._sourceTraceId, self._nodeId)

	self._effectTableList:reloadData(self._nodeCfg.effectIds)

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

		GameUtil.SetActive(self._txtActiveTips, self._nodeInfo ~= nil)
	else
		GameUtil.SetActive(self._txtActiveTips, true)
	end

	GameUtil.SetActive(self._cost, self._nodeInfo == nil)

	self._txtNodeName.text = langPara("源核%s", GameUtil.toRomanNumber(self._multiNodeIndex))
	self._txtTitle.text = langPara("源核%s信息", GameUtil.toRomanNumber(self._multiNodeIndex))

	local groupInfoCfg = SourceTraceConfig.instance:getGroupInfoCfg(self._sourceTraceId)

	self._txtBaseDesc.text = groupInfoCfg and groupInfoCfg.skillBaseDesc or lang("无基础效果描述")

	local nodeInfo = {}

	for i, v in ipairs(self._multiNode) do
		table.insert(nodeInfo, {
			nodeId = v,
			index = i,
			nodeInfo = self._nodeInfoMap[v]
		})
	end

	self._nodeTableList:reloadData(nodeInfo)

	for i, v in pairs(self._linkGoMap) do
		for j, go in ipairs(v) do
			GameUtil.SetActive(go, false)
		end
	end

	local selectEffectIndex = 1

	for i, v in ipairs(self._nodeCfg.effectIds) do
		if v == self._effectId then
			selectEffectIndex = i
		end
	end

	if self._linkGoMap[self._multiNodeIndex] then
		GameUtil.SetActive(self._linkGoMap[self._multiNodeIndex][selectEffectIndex], true)
	end

	local isActivable = true

	if self._nodeCfg.preNodeIds then
		for i, v in ipairs(self._nodeCfg.preNodeIds) do
			if self._nodeInfoMap[v] == nil then
				isActivable = false

				break
			end
		end
	end

	GameUtil.SetActive(self._canActiveTag, not isActivable)
	GameUtil.SetActive(self._btnSure, self._nodeInfo or isActivable == true)
end

function SourceTraceMultiNodeView:_updateEffectCell(view, cell, data, tag)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local activeTag = goutil.findChild(go, "activeTag")
	local btn = goutil.findChild(go, "btn")
	local imgSelect = goutil.findChild(go, "imgSelect")

	GameUtil.SetActive(imgSelect, data == self._effectId)
	GameUtil.SetActive(activeTag, self._nodeInfo and self._nodeInfo.effectId == data)

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

function SourceTraceMultiNodeView:_clearEffectCell(cell)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIconLoad)
end

function SourceTraceMultiNodeView:_updateNodeCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgBgSelect = goutil.findChild(go, "imgBgSelect")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	GameUtil.SetActive(imgBgSelect, data.index == self._multiNodeIndex)

	if self._multiNodeIndex == data.index then
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(self._effectId)

		txtDesc.text = langPara("源核%s：%s", GameUtil.toRomanNumber(data.index), effectCfg.desc)
	elseif data.nodeInfo then
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(data.nodeInfo.effectId)

		txtDesc.text = langPara("源核%s：%s", GameUtil.toRomanNumber(data.index), effectCfg.desc)
	else
		txtDesc.text = langPara("源核%s：未激活", GameUtil.toRomanNumber(data.index))
	end
end

function SourceTraceMultiNodeView:_clearNodeCell(cell)
	return
end

function SourceTraceMultiNodeView:_onClickSure()
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
	elseif self._nodeInfo.effectId == self._effectId then
		FloatWordMgr.instance:show(lang("已激活"))
	else
		SourceTraceAgent.instance:sendPM_SourceTraceChangeEffectReq(self._curPetMo.petId, self._nodeId, self._effectId)
	end
end

function SourceTraceMultiNodeView:_onClickEffectCell(effectId)
	self._effectId = effectId

	self:_refreshView()
end

function SourceTraceMultiNodeView:_onClickNext()
	self._multiNodeIndex = self._multiNodeIndex + 1

	if self._multiNodeIndex > #self._multiNode then
		self._multiNodeIndex = 1
	end

	self._nodeId = self._multiNode[self._multiNodeIndex]
	self._nodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(self._sourceTraceId, self._nodeId)
	self._nodeInfo = self._nodeInfoMap[self._nodeId]
	self._effectId = self._nodeInfo and self._nodeInfo.effectId or self._nodeCfg.effectIds[1]

	self:_refreshView()
end

function SourceTraceMultiNodeView:_onClickPre()
	self._multiNodeIndex = self._multiNodeIndex - 1

	if self._multiNodeIndex <= 0 then
		self._multiNodeIndex = #self._multiNode
	end

	self._nodeId = self._multiNode[self._multiNodeIndex]
	self._nodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(self._sourceTraceId, self._nodeId)
	self._nodeInfo = self._nodeInfoMap[self._nodeId]
	self._effectId = self._nodeInfo and self._nodeInfo.effectId or self._nodeCfg.effectIds[1]

	self:_refreshView()
end

function SourceTraceMultiNodeView:_PM_SourceTraceUnlockNodeRes()
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

function SourceTraceMultiNodeView:_PM_SourceTraceChangeEffectRes()
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

return SourceTraceMultiNodeView
