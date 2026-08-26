-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossTalentItem.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentItem", package.seeall)

local TowerAssistBossTalentItem = class("TowerAssistBossTalentItem", ListScrollCellExtend)
local RootPosX = 0
local RootPosY = -385

function TowerAssistBossTalentItem:onInitView()
	self.transform = self.viewGO.transform
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.imgTalent = gohelper.findChildImage(self.viewGO, "btn/image_BG")
	self.goSelect = gohelper.findChild(self.viewGO, "btn/goSelect")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btn")
	self.bigEff = gohelper.findChild(self.viewGO, "btn/btneff_big")
	self.smallEff = gohelper.findChild(self.viewGO, "btn/btneff_small")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerAssistBossTalentItem:addEvents()
	self.addClickCb(self, self.btnClick, self.onBtnClick, self)
end

function TowerAssistBossTalentItem:removeEvents()
	self:removeClickCb(self.btnClick)
end

function TowerAssistBossTalentItem:_editableInitView()
	return
end

function TowerAssistBossTalentItem:onBtnClick()
	if not self._mo then
		return
	end

	TowerAssistBossTalentListModel.instance:setSelectTalent(self._mo.id)
end

function TowerAssistBossTalentItem:onUpdateMO(mo)
	gohelper.setActive(self.viewGO, true)

	self._mo = mo
	self.isBigNode = self._mo.config.isBigNode == 1

	self:refreshNode()
	self:refreshState()
	self:refreshSelect()
end

function TowerAssistBossTalentItem:refreshNode()
	if not self._mo then
		return
	end

	TowerConfig.instance:setTalentImg(self.imgTalent, self._mo.config, true)

	local posX, posY = self:getNodePos()

	recthelper.setAnchor(self.transform, posX, posY)

	local scale = self.isBigNode and 1.2 or 0.6

	transformhelper.setLocalScale(self.goSelect.transform, scale, scale, 1)

	local nodeScale = 1

	if self.isBigNode and not self._mo:isRootNode() then
		nodeScale = 0.7
	end

	transformhelper.setLocalScale(self.transform, nodeScale, nodeScale, 1)
end

function TowerAssistBossTalentItem:getWidth()
	if not self._mo then
		return 0
	end

	return self.isBigNode and 72 or 24
end

function TowerAssistBossTalentItem:getLocalPos()
	local x, y = recthelper.getAnchor(self.transform)
	local localX = x - RootPosX
	local localY = y - RootPosY

	return localX, localY
end

function TowerAssistBossTalentItem:refreshState()
	if not self._mo then
		return
	end

	local mo = self._mo
	local isActive = mo:isActiveTalent()
	local isActiveGroup = mo:isActiveGroup()
	local isParentActive = mo:isParentActive()
	local isSelectedSystemTalentPlan = mo:isSelectedSystemTalentPlan()
	local canActive = not isActive and not isActiveGroup and isParentActive

	if canActive and not isSelectedSystemTalentPlan then
		if self.isGray then
			self.anim:Play("tocanlight")
		else
			self.anim:Play("canlight")
		end

		self.isGray = false
	elseif isActive then
		if not self.isLighted then
			self.anim:Play("lighted")
		end

		self.isGray = false
	else
		self.anim:Play("gray")

		self.isGray = true
	end

	self.isLighted = isActive

	gohelper.setActive(self.bigEff, isActive and self.isBigNode)
	gohelper.setActive(self.smallEff, isActive and not self.isBigNode)
end

function TowerAssistBossTalentItem:refreshSelect()
	if not self._mo then
		return
	end

	local isSelect = TowerAssistBossTalentListModel.instance:isSelectTalent(self._mo.id)

	gohelper.setActive(self.goSelect, isSelect)
end

function TowerAssistBossTalentItem:getNodePos()
	local position = self._mo.config.position
	local param = string.splitToNumber(position, "#") or {}

	if not param[1] then
		local r = 0

		if not param[2] then
			local o = 0
			local rad = math.rad(o)
			local x = r * math.cos(rad) + RootPosX
			local y = r * math.sin(rad) + RootPosY

			return x, y
		end
	end
end

function TowerAssistBossTalentItem:playLightingAnim()
	self.isLighted = true

	self.anim:Play("lighting")
	gohelper.setActive(self.bigEff, self.isBigNode)
	gohelper.setActive(self.smallEff, not self.isBigNode)
end

function TowerAssistBossTalentItem:onDestroyView()
	return
end

return TowerAssistBossTalentItem
