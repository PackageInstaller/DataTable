-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleGroundCell.lua

GroundCellStatus = {
	HIGHLIGHT = 2,
	NORMAL = 0,
	OCCUPIED = 1
}
BattleGroundCell = class("BattleGroundCell", DisposableObject, _M)

BattleGroundCell:has("_posInTeam", {
	is = "rw"
})
BattleGroundCell:has("_battleGround", {
	is = "rw"
})

function BattleGroundCell:initialize(args)
	super.initialize(self)
	self:_setupView(args)

	self._targetViewRec = {}
	self._occupiedHeros = {}
	self._trapMap = {}
end

function BattleGroundCell:getDisplayNode()
	return self._baseNode
end

function BattleGroundCell:setScaleX(scale)
	self._displayNode:setScaleX(scale)
	self._targetNode:setScaleX(scale)
	self._previewNode:setScaleX(scale)
	self._randomPreview:setScaleX(scale)
end

function BattleGroundCell:setOpacity(opacity)
	self.normalShow:runAction(cc.FadeTo:create(0.1, opacity * 0.5))
	self.highLightShow:runAction(cc.FadeTo:create(0.1, opacity))
end

function BattleGroundCell:getAABB()
	local node = self._displayNode
	local size = self.normalShow:getContentSize()

	return cc.rect(10, 0, size.width * node:getScaleX() - 20, size.height * node:getScaleY())
end

function BattleGroundCell:getViewFrame()
	local node = self._displayNode
	local size = self.normalShow:getContentSize()

	return cc.rect(0, 0, size.width * node:getScaleX(), size.height * node:getScaleY())
end

function BattleGroundCell:setScale(sx, sy)
	self._displayNode:setScale(sx, sy)
end

function BattleGroundCell:setStatus(status, heroModel)
	if self:isLocked() and status == GroundCellStatus.NORMAL then
		return
	end

	if status == GroundCellStatus.NORMAL then
		for k, v in pairs(self._occupiedHeros) do
			if heroModel == v and heroModel then
				table.remove(self._occupiedHeros, k)
			end
		end

		if #self._occupiedHeros > 0 then
			self:setStatus(GroundCellStatus.OCCUPIED)

			return
		end
	end

	self.normalShow:setVisible(status == GroundCellStatus.NORMAL)

	if status == GroundCellStatus.HIGHLIGHT then
		self.highLightShow:setVisible(true)
	else
		if self.occupiedShow then
			self.occupiedShow:setVisible(status == GroundCellStatus.OCCUPIED)
		end

		self.highLightShow:setVisible(false)
	end

	self.status = status
end

function BattleGroundCell:setOccupiedHero(heroModel)
	self._occupiedHeros = self._occupiedHeros or {}
	self._occupiedHeros[#self._occupiedHeros + 1] = heroModel

	self:setStatus(GroundCellStatus.OCCUPIED)
end

function BattleGroundCell:setOccupiedHeros(occupiedHeros)
	self._occupiedHeros = occupiedHeros
end

function BattleGroundCell:getOccupiedHeros()
	return self._occupiedHeros
end

function BattleGroundCell:getFrontOccupiedHero()
	if self._occupiedHeros and #self._occupiedHeros > 0 then
		return self._occupiedHeros[#self._occupiedHeros]
	end
end

function BattleGroundCell:getStatus()
	return self.status
end

function BattleGroundCell:canBeSitByExtraSkillCard(card)
	if not card then
		return false
	end

	return true
end

function BattleGroundCell:canBeSitByCard(card)
	if not card then
		return false
	end

	if card.getCardInfo then
		local cardInfo = card:getCardInfo()

		if cardInfo then
			if next(cardInfo.seatRules) then
				if self:getStatus() ~= GroundCellStatus.OCCUPIED then
					return true
				else
					local occupHero = self:getFrontOccupiedHero()

					if occupHero then
						local canBeSit = false

						for rule, _ in pairs(cardInfo.seatRules) do
							canBeSit = rule == "SUMMONED" and occupHero:getIsSummond() or occupHero:hasFlag(rule)

							if canBeSit then
								break
							end
						end

						if occupHero:getRoleType() == RoleType.Master then
							return false
						elseif canBeSit then
							return true
						end

						return false
					else
						return self:getStatus() ~= GroundCellStatus.OCCUPIED
					end
				end
			else
				return self:getStatus() ~= GroundCellStatus.OCCUPIED
			end
		end
	end

	return false
end

function BattleGroundCell:setRelPosition(relPos, extraZ)
	assert(relPos ~= nil)

	self._relPosition = relPos

	if self._battleGround ~= nil then
		self._battleGround:setRelPosition(self:getDisplayNode(), relPos, extraZ)

		self._relScale = self:getDisplayNode():getScale()
	end
end

function BattleGroundCell:getRelPosition()
	if self._relPosition == nil then
		return {
			x = 0,
			y = 0
		}
	else
		return {
			x = self._relPosition.x,
			y = self._relPosition.y
		}
	end
end

function BattleGroundCell:_setupView(data)
	self._baseNode = cc.Node:create()
	self._displayNode = cc.Node:create():addTo(self._baseNode)
	self.normalShow = cc.Sprite:createWithSpriteFrameName(data.normalImage)

	if data.occupiedImage then
		self.occupiedShow = cc.Sprite:createWithSpriteFrameName(data.occupiedImage)

		self.occupiedShow:setOpacity(100)
		self._displayNode:addChild(self.occupiedShow)
	end

	self.highLightShow = cc.Sprite:createWithSpriteFrameName(data.highLightImage)

	self.normalShow:setOpacity(25)
	self.highLightShow:setOpacity(255)
	self.highLightShow:setBrightness(100)
	self._displayNode:addChild(self.normalShow)
	self._displayNode:addChild(self.highLightShow)
	self.normalShow:setVisible(true)
	self.highLightShow:setVisible(false)

	self.status = GroundCellStatus.NORMAL
	self._targetNode = cc.Node:create():addTo(self._baseNode)

	self._targetNode:setVisible(false)

	self._targetShow = cc.Sprite:createWithSpriteFrameName(data.targetImage)

	self._targetShow:addTo(self._targetNode)

	self._healTargetShow = cc.Sprite:createWithSpriteFrameName(data.healTargetImage)

	self._healTargetShow:addTo(self._targetNode)

	self._previewNode = cc.Node:create():addTo(self._baseNode)

	self._previewNode:setVisible(false)

	self._targetPreview = cc.Sprite:createWithSpriteFrameName(data.targetImage)

	self._targetPreview:addTo(self._previewNode)

	self._healTargetPreview = cc.Sprite:createWithSpriteFrameName(data.healTargetImage)

	self._healTargetPreview:addTo(self._previewNode)

	self._randomPreview = cc.Sprite:createWithSpriteFrameName(data.randomImage)

	self._randomPreview:addTo(self._previewNode)

	self._baseColorTrans = self._displayNode:getColorTransform()
	self._trapNode = cc.Node:create():addTo(self._baseNode, 10)
	self._lockShowAnim = cc.MovieClip:create("jinzhishangren_jinzhishangren")

	self._lockShowAnim:addTo(self._baseNode):offset(6, 10)
	self._lockShowAnim:setVisible(false)

	self._lockShow = cc.Sprite:createWithSpriteFrameName(data.lockImage)

	self._lockShow:addTo(self._baseNode):offset(0, 0)
	self._lockShow:setVisible(false)
end

function BattleGroundCell:setPreview(cellInfo)
	local color = cellInfo.color
	local isRandom = cellInfo.isRandom

	self._displayNode:setVisible(false)
	self._previewNode:setVisible(true)

	if color == "Red" then
		self._healTargetPreview:setVisible(false)

		local targetPreview = self._targetPreview

		targetPreview:setVisible(true)
		targetPreview:stopAllActions()
		targetPreview:setScale(1.2)
		targetPreview:setOpacity(0)
		targetPreview:runAction(cc.Spawn:create(cc.ScaleTo:create(0.1, 1), cc.FadeIn:create(0.1)))
	else
		self._targetPreview:setVisible(false)

		local targetPreview = self._healTargetPreview

		targetPreview:setVisible(true)
		targetPreview:stopAllActions()
		targetPreview:setOpacity(0)
		targetPreview:posite(0, -5)
		targetPreview:runAction(cc.Spawn:create(cc.MoveTo:create(0.1, cc.p(0, 0)), cc.FadeIn:create(0.1)))
	end

	local doubt = self._randomPreview

	doubt:stopAllActions()
	doubt:setVisible(isRandom)

	if isRandom then
		doubt:runAction(cc.Sequence:create(cc.Show:create(), cc.DelayTime:create(0.3), cc.Hide:create(), cc.DelayTime:create(0.3), cc.Show:create()))
	end
end

function BattleGroundCell:resumePreview()
	self._previewNode:setVisible(false)

	if not self._targetNode:isVisible() then
		self._displayNode:setVisible(true)
	end
end

function BattleGroundCell:showBlock()
	self._lockShow:setVisible(true)
	self._lockShowAnim:setVisible(true)
end

function BattleGroundCell:hideBlock()
	self._lockShow:setVisible(false)
	self._lockShowAnim:setVisible(false)
end

function BattleGroundCell:showTarget(actId, isHeal)
	if actId == nil or self._targetViewRec[actId] then
		return
	end

	self._targetViewRec[actId] = true

	self._displayNode:setVisible(false)
	self._targetNode:setVisible(true)

	if not isHeal then
		self._healTargetShow:setVisible(false)

		local targetShow = self._targetShow

		targetShow:setVisible(true)
		targetShow:stopAllActions()
		targetShow:setScale(1.2)
		targetShow:setOpacity(0)
		targetShow:runAction(cc.Spawn:create(cc.ScaleTo:create(0.1, 1), cc.FadeIn:create(0.1)))
	else
		self._targetShow:setVisible(false)

		local targetShow = self._healTargetShow

		targetShow:setVisible(true)
		targetShow:stopAllActions()
		targetShow:setOpacity(0)
		targetShow:posite(0, -5)
		targetShow:runAction(cc.Spawn:create(cc.MoveTo:create(0.1, cc.p(0, 0)), cc.FadeIn:create(0.1)))
	end
end

function BattleGroundCell:cancelTarget(actId)
	if actId == nil then
		return
	end

	self._targetViewRec[actId] = nil

	if next(self._targetViewRec) == nil then
		self._targetNode:setVisible(false)

		if not self._previewNode:isVisible() then
			self._displayNode:setVisible(true)
		end
	end
end

function BattleGroundCell:runScaleAction()
	self.highLightShow:setScale(1.3)
	self.highLightShow:runAction(cc.ScaleTo:create(0.1, 1))
end

function BattleGroundCell:lock()
	self._lockTimes = (self._lockTimes or 0) + 1

	if self._lockTimes == 1 then
		self:setStatus(GroundCellStatus.OCCUPIED)
	end
end

function BattleGroundCell:unlock()
	if self._lockTimes then
		self._lockTimes = self._lockTimes - 1

		if self._lockTimes <= 0 then
			self:setStatus(GroundCellStatus.NORMAL)
		end
	end
end

function BattleGroundCell:isLocked()
	return self._lockTimes and self._lockTimes > 0
end

function BattleGroundCell:addTrap(param, isleft)
	local display = param.disp

	if display == nil or display == "" then
		return
	end

	local trapModel = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "TrapModel_" .. display, "content")

	if not trapModel then
		return
	end

	if not trapModel.Priority then
		local priorityValue = 0

		if not trapModel.Type then
			local priorityGroup = "@Default"

			if not trapModel.zOrder then
				local zOrder = 0

				if not self._trapMap[priorityGroup] then
					local groupMap = {}

					groupMap[display] = groupMap[display] or {}
					self._trapMap[priorityGroup] = groupMap

					local trapValue = groupMap[display]

					trapValue.count = (trapValue.count or 0) + 1

					if trapValue.count <= 1 or trapValue.displayNodes == nil or #trapValue.displayNodes == 0 then
						if trapModel.Effect and trapModel.Effect ~= "" then
							trapValue.loopMode = trapModel.Loop
							trapValue.priority = priorityValue
							trapValue.displayNodes = {}

							local function addEffect(anim, layer)
								return self:addActiveEffect(anim, trapValue.loopMode == 1, trapModel.EffectPos, layer, tonumber(zOrder) + 1, function(cid, mc)
									if trapValue.loopMode == 0 then
										table.removevalues(trapValue.displayNodes, mc)
										mc:removeFromParent()
									end
								end, isleft)
							end

							local displayNode = addEffect(trapModel.Effect, "front")

							displayNode:setVisible(false)

							trapValue.displayNodes[#trapValue.displayNodes + 1] = displayNode
						end

						self:refreshTrapEffect()
					end
				end
			end
		end
	end
end

function BattleGroundCell:removeTrap(param)
	local display = param.disp

	if display == nil or display == "" then
		return
	end

	for key, groupMap in pairs(self._trapMap) do
		for disp, trapValue in pairs(groupMap) do
			if disp == display then
				trapValue.count = math.max(trapValue.count - 1, 0)

				if trapValue.count == 0 then
					if trapValue.displayNodes then
						for i, displayNode in ipairs(trapValue.displayNodes) do
							displayNode:stop()
							displayNode:removeFromParent(true)
						end
					end

					groupMap[display] = nil
				end
			end
		end
	end

	self:refreshTrapEffect()
end

function BattleGroundCell:addActiveEffect(mcFile, loop, offset, layer, zOrder, callback, isLeft)
	if not mcFile then
		return
	end

	layer = layer or "front"
	offset = offset or {}
	offsetY = offset[2] or 0
	offsetX = offset[1] or 0

	local anim = cc.MovieClip:create(mcFile, "BattleMCGroup")

	assert(anim, "MovieClip :" .. mcFile .. " not exists!")
	anim:addEndCallback(function(cid, mc)
		if loop ~= true then
			mc:stop()

			if callback then
				callback(cid, mc)
			end
		end
	end)

	local point = cc.p(offsetX, offsetY)

	anim:addTo((layer == "front" or nil) and (self._trapNode or self._trapNode))
	anim:setLocalZOrder(layer == "front" and zOrder or -zOrder)
	anim:setPosition(point)
	anim:setScaleX(isLeft and 1 or -1)

	return anim
end

function BattleGroundCell:refreshTrapEffect()
	for key, grounMap in pairs(self._trapMap) do
		local por = 65535

		for display, trapValue in pairs(grounMap) do
			por = math.min(trapValue.priority or 0, por)

			local displayNodes = trapValue.displayNodes

			if displayNodes then
				for _, displayNode in ipairs(displayNodes) do
					displayNode:setVisible(false)
				end
			end
		end

		for display, trapValue in pairs(grounMap) do
			if trapValue.priority == por then
				local displayNodes = trapValue.displayNodes

				if displayNodes then
					for _, displayNode in ipairs(displayNodes) do
						displayNode:setVisible(true)
					end
				end
			end
		end
	end
end
