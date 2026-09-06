-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/DomainSkillTipsView.lua

module("logic.extensions.common.instruction.view.DomainSkillTipsView", package.seeall)

local DomainSkillTipsView = class("DomainSkillTipsView", ViewComponent)

function DomainSkillTipsView:buildUI()
	DomainSkillTipsView.super.buildUI(self)

	self._nodeParent = self:getGo("Node")
	self._bgContent = self:getGo("Node/Nego_Content")
	self._imgIcon = self:getGo("Node/ImgC_Con")
	self._txtName = self:getTxt("Node/TxtC_Name")
	self._txtSkillType = self:getTxt("Node/TxtC_Type")
	self._scrollView = self:getGo("Node/SrollView"):GetComponent(ComponentType.ScrollRect)
	self._contentNode = self:getGo("Node/SrollView/Viewport/Content")
	self._customInput = UICustomInput.Get(self.mainGO)
end

function DomainSkillTipsView:bindEvents()
	DomainSkillTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function DomainSkillTipsView:unbindEvents()
	DomainSkillTipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function DomainSkillTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function DomainSkillTipsView:onEnter()
	DomainSkillTipsView.super.onEnter(self)

	local params = self:getOpenParam()
	local skinId = params[1]
	local skillId = params[2]
	local curCfg = BattleConfig.instance:getSkillCo(skillId, skinId)
	local skillType = GameEnum.SkillNameToType[curCfg.type]

	self._txtSkillType.text = ConstString.SkillType[skillType]
	self._txtName.text = curCfg.name

	local layerCos = BattleConfig.instance:getDomainSkillLevels(skillId)
	local transform = self._contentNode.transform
	local childCount = transform.childCount
	local cnt = #layerCos

	while childCount < cnt do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	local posx, posy = 4, -6

	for i = 1, cnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local layerName = goutil.findChildTextComponent(go, "layerName")
		local desc = goutil.findChildTextComponent(go, "TxtC_Desc")

		layerName.text = curCfg.name .. GameUtil.toRomanNumber(i)
		desc.text = layerCos[i].desc

		Framework.TransformUtil.SetLocalPos(go.transform, posx, posy, 0)

		local preferredHeight = desc.preferredHeight

		posy = posy - 40 - preferredHeight
	end

	for i = cnt + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	local sizeDelta = self._contentNode.transform.sizeDelta

	sizeDelta.y = -posy + 10
	self._contentNode.transform.sizeDelta = sizeDelta

	MaterialMgr.setSkillByFaceId(skillId, skinId, self._imgIcon)
end

function DomainSkillTipsView:onExit()
	MaterialMgr.resetAll(self._imgIcon)
	DomainSkillTipsView.super.onExit(self)
end

return DomainSkillTipsView
