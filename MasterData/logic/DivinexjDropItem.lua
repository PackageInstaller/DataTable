-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/model/DivinexjDropItem.lua

module("logic.extensions.divinexingjiangclg.model.DivinexjDropItem", package.seeall)

local DivinexjDropItem = class("DivinexjDropItem")

function DivinexjDropItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._mainGo = go
	self._rectTrans = go:GetComponent(goutil.Type_RectTransform)
	self._iconChange = goutil.findChild(go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
end

function DivinexjDropItem:getMainGO()
	return self._mainGo
end

function DivinexjDropItem:init(pillarIndex, birthPos, deathPos, astroId)
	self._pillarIndex = pillarIndex
	self._birthPos = birthPos
	self._deathPos = deathPos
	self._astroId = astroId
	self._moveSpeed = DivineXingJiangClgGameModel.instance:getDropMoveSpeed()
	self._horizontalPole = nil
	self._horzontalMoveDirX = 1
	self._isUpdate = true
	self._curPillarIndex = pillarIndex

	self._iconChange:SetState(self._astroId - 1)
	self:_initDropItemPos()
end

function DivinexjDropItem:onReset()
	self._horizontalPole = nil
	self._isUpdate = false
end

function DivinexjDropItem:_initDropItemPos()
	self._rectTrans.anchoredPosition = self._birthPos
end

function DivinexjDropItem:updateDropItemPos(horizontalPoleClsDic)
	if self._isUpdate then
		local anchoredPosition = self._rectTrans.anchoredPosition
		local newY = anchoredPosition.y - Time.deltaTime * self._moveSpeed
		local isNewAdd = false

		if self._horizontalPole == nil then
			for k, v in pairs(horizontalPoleClsDic) do
				local leftIndex = v:getLeftPillarIndex()
				local rightIndex = leftIndex + 1

				if self._curPillarIndex == leftIndex or self._curPillarIndex == rightIndex then
					local horizontalPolePosY = v:getPosY()

					if horizontalPolePosY < anchoredPosition.y and newY <= horizontalPolePosY then
						self._horizontalPole = v

						self._horizontalPole:addDropItem(self)

						self._rectTrans.anchoredPosition = Vector2.New(anchoredPosition.x, horizontalPolePosY)
						self._horzontalMoveDirX = self._curPillarIndex == leftIndex and 1 or -1
						isNewAdd = true

						break
					end
				end
			end
		end

		if self._horizontalPole then
			if not isNewAdd then
				local newX = anchoredPosition.x + Time.deltaTime * self._moveSpeed * self._horzontalMoveDirX
				local isLeftEnd = self._horzontalMoveDirX == -1

				if isLeftEnd then
					local var_6_0 = self._horizontalPole:getLeftPosX()

					if not var_6_0 then
						var_6_0 = self._horizontalPole:getRightPosX()

						local endX = var_6_0

						if isLeftEnd then
							if endX < anchoredPosition.x and newX <= endX then
								self._horizontalPole:removeDropItem(self)

								self._horizontalPole = nil
								self._rectTrans.anchoredPosition = Vector2.New(endX, anchoredPosition.y)
								self._curPillarIndex = self._curPillarIndex - 1
							else
								self._rectTrans.anchoredPosition = Vector2.New(newX, anchoredPosition.y)
							end
						elseif endX > anchoredPosition.x and endX <= newX then
							self._horizontalPole:removeDropItem(self)

							self._horizontalPole = nil
							self._rectTrans.anchoredPosition = Vector2.New(endX, anchoredPosition.y)
							self._curPillarIndex = self._curPillarIndex + 1
						else
							self._rectTrans.anchoredPosition = Vector2.New(newX, anchoredPosition.y)
						end
					end
				end
			end
		else
			self._rectTrans.anchoredPosition = Vector2.New(anchoredPosition.x, newY)
		end

		if anchoredPosition.y < self._deathPos.y then
			self._isUpdate = false

			DivineXingJiangClgGameController.instance:localNotify(DivineXingJiangClgGameController.EventCaculateScore, self._astroId, self._mainGo:GetInstanceID(), self._curPillarIndex)
		end
	end
end

function DivinexjDropItem:isOverLap(leftPillarIndex, topY, bottomY)
	if self._curPillarIndex == leftPillarIndex or self._curPillarIndex == leftPillarIndex + 1 then
		local y = self._rectTrans.anchoredPosition.y

		return y <= topY and bottomY <= y
	else
		return false
	end
end

return DivinexjDropItem
