-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsProp.lua

module("logic.extensions.catchprops.view.CatchPropsProp", package.seeall)

local CatchPropsProp = class("CatchPropsProp")
local boundingBox = BoundingBox2D.New()
local half_gravity = 100

function CatchPropsProp:ctor()
	self:reset()
end

function CatchPropsProp:dispose()
	self:reset()
end

function CatchPropsProp:reset()
	self._currX = 0
	self._currY = 0
	self._startY = 0
	self._propType = CatchPropsPropType.Normal
	self._gameObject = nil
	self._deltaTime = 0
	self._colliderLocalX = 0
	self._colliderLocalY = 0
	self._colliderSizeX = 60
	self._colliderSizeY = 60
	self._chooseRaceId = 0
	self._view = nil
end

function CatchPropsProp:update(deltaTime)
	self._deltaTime = self._deltaTime + deltaTime

	local s = self._deltaTime * self._deltaTime * half_gravity

	self._currY = self._startY - s

	self:setPosition(self._currX, self._currY)
end

function CatchPropsProp:isOutOfBound(minYPosition)
	return minYPosition >= self._currY
end

function CatchPropsProp:setView(view)
	self._view = view
end

function CatchPropsProp:setEffParent(parent)
	self._parent = parent
end

function CatchPropsProp:setPropType(type)
	self._propType = type
end

function CatchPropsProp:setChoosePetRaceId(raceId)
	self._chooseRaceId = raceId
end

function CatchPropsProp:getPropType()
	return self._propType
end

function CatchPropsProp:setGameObject(go)
	self._gameObject = go

	if go then
		collider = goutil.findChild(go, "collider")

		local petIcon = goutil.findChild(go, "conMask/con")

		if collider then
			local cx, cyPos = Framework.TransformUtil.GetLocalPos(collider.transform, nil, nil, nil)

			self._colliderLocalX = cx
			self._colliderLocalY = cyPos

			local sizeDelta = collider.transform.sizeDelta

			self._colliderSizeX = sizeDelta.x
			self._colliderSizeY = sizeDelta.y
		end

		if petIcon then
			if (self._propType == CatchPropsPropType.ChoosePetRedBag or self._propType == CatchPropsPropType.AddTime) and self._chooseRaceId and self._chooseRaceId ~= 0 then
				local modelCo = CharacterConfig.instance:getModelCo(self._chooseRaceId)

				if modelCo then
					if not modelCo.headName then
						local petIconName = ""

						uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petIconName))
					end
				end
			else
				local raceIdArr = CatchPropsConfig.instance:getPetIconRaceId()
				local randomNum = math.random(1, #raceIdArr)
				local randomRaceId = raceIdArr[randomNum]

				while randomRaceId == self._chooseRaceId do
					randomNum = math.random(1, #raceIdArr)
					randomRaceId = raceIdArr[randomNum]
				end

				local modelCo = CharacterConfig.instance:getModelCo(randomRaceId)

				if modelCo then
					if not modelCo.headName then
						local petIconName = ""

						uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petIconName))
					end
				end
			end
		end
	end
end

function CatchPropsProp:getGameObject()
	return self._gameObject
end

function CatchPropsProp:setStartPosition(x, y)
	self._startY = y

	self:setPosition(x, y)
end

function CatchPropsProp:setPosition(x, y)
	self._currX = x
	self._currY = y

	if self._gameObject then
		Framework.TransformUtil.SetLocalPos(self._gameObject.transform, x, y, 0)
	end
end

function CatchPropsProp:getPosition()
	return self._currX, self._currY
end

function CatchPropsProp:getBoundingBox()
	boundingBox:setSize(self._colliderSizeX, self._colliderSizeY)
	boundingBox:setCenter(self._currX + self._colliderLocalX, self._currY + self._colliderLocalY)

	return boundingBox
end

function CatchPropsProp:onCatached()
	local eff = UIEffectManager.instance:playEffectBrief(self._view, CatchPropsModel.instance:getCollisionEffPath(), self._gameObject, false)

	eff:setEffTime(1)
	eff:setParent(self._parent)
	eff:setScale(1)
	eff:setLocalPos(self._currX, self._currY, 0)

	if self._propType == CatchPropsPropType.Normal then
		local score = CatchPropsConfig.instance:getPropScoreUnit()

		CatchPropsController.instance:onGetScore(score)
	elseif self._propType == CatchPropsPropType.ChoosePetRedBag then
		local score = CatchPropsConfig.instance:getPropSpecialScoreUnit()

		CatchPropsController.instance:onGetScore(score)
	elseif self._propType == CatchPropsPropType.AddTime then
		local time = CatchPropsConfig.instance:getSpecialPropsAddTime()

		CatchPropsController.instance:onGetTime(time)
	end
end

return CatchPropsProp
