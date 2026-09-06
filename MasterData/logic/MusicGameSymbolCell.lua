-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/data/MusicGameSymbolCell.lua

module("logic.extensions.musicgame.data.symbolcell.MusicGameSymbolCell", package.seeall)

local MusicGameSymbolCell = class("MusicGameSymbolCell")

function MusicGameSymbolCell:ctor(entityId)
	self._entityId = entityId
	self._state = MusicGameEnum.SymbolState_Standing
	self._isHit = false
	self._boundingBox2D = BoundingBox2D.New()
	self._deltaTime = 0
	self._baseSpeed = 100
	self._speed = 0
	self._view = nil
end

function MusicGameSymbolCell:reset()
	self._state = MusicGameEnum.SymbolState_Standing

	PointerDownHandler.Get(self._btnClick):RemoveLuaHandler(self._pointerDownHandler)

	self._btnClick = nil
	self._colliderBox = nil
	self._mainGo = nil
	self._lineId = 0
	self._isHit = false
	self._deltaTime = 0

	UIEffectManager.instance:stopEffect(self._hitEff)

	self._hitEff = nil
	self._view = nil
end

function MusicGameSymbolCell:dispose()
	self._entityId = nil
	self._boundingBox2D = nil
end

function MusicGameSymbolCell:init(mainGo, lineId, speedRate, view)
	self._mainGo = mainGo
	self._lineId = lineId
	self._speedRate = speedRate

	if self._speedRate <= 0 then
		self._speedRate = 1
	end

	self._speed = self._baseSpeed * self._speedRate
	self._view = view
	self._btnClick = goutil.findChild(mainGo, "btnClick")
	self._colliderBox = goutil.findChild(mainGo, "colliderBox")
	self._effRoot = goutil.findChild(mainGo, "effRoot")

	local cellX, cellY, cellZ = self:getLocalPos()
	local boxX, boxY, boxZ = Framework.TransformUtil.GetLocalPos(self._colliderBox.transform, nil, nil, nil)

	self._boundingBox2D:setSize(self._colliderBox.transform.sizeDelta.x, self._colliderBox.transform.sizeDelta.y)
	self._boundingBox2D:setCenter(cellX + boxX, cellY + boxY)

	self._pointerDownHandler = PointerDownHandler.Get(self._btnClick):AddLuaHandler(function(_go, eventData)
		self:_onPointerDownHandler(_go, eventData)
	end)

	GameUtil.SetActive(self._btnClick, true)
end

function MusicGameSymbolCell:onTicking(deltaTime)
	self._deltaTime = deltaTime

	if self._state == MusicGameEnum.SymbolState_Standing then
		-- block empty
	elseif self._state == MusicGameEnum.SymbolState_Running then
		local deltaY = self._deltaTime * self._speed
		local x, y, z = self:getLocalPos()

		Framework.TransformUtil.SetLocalPos(self._mainGo.transform, x, y - deltaY, z)
		self:updateBoundingBox2D()
	elseif self._state == MusicGameEnum.SymbolState_Ending then
		-- block empty
	elseif self._state == MusicGameEnum.SymbolState_Ended then
		-- block empty
	end
end

function MusicGameSymbolCell:_onPointerDownHandler()
	if self._state == MusicGameEnum.SymbolState_Running then
		GlobalDispatcher:dispatch(GlobalNotify.MusicGameOnClickSymbolCell, self._entityId)
	end
end

function MusicGameSymbolCell:_changeState(state)
	self._state = state
end

function MusicGameSymbolCell:startRunning()
	self:_changeState(MusicGameEnum.SymbolState_Running)
end

function MusicGameSymbolCell:trickHit(box2D)
	if self._state == MusicGameEnum.SymbolState_Running then
		self._isHit = self._boundingBox2D:intersects(box2D)

		self:_changeState(MusicGameEnum.SymbolState_Ending)
		GameUtil.SetActive(self._btnClick, false)

		if self._isHit then
			AudioPlayerEx.instance:playEffect(30001)

			local effParent = self._effRoot

			UIEffectManager.instance:stopEffect(self._hitEff)

			local path = "20220930/aruisimuqin/fx_ui_aruisimq_dianji.prefab"

			local function finishHandler(handlerTarget, eff)
				self:_changeState(MusicGameEnum.SymbolState_Ended)
			end

			local function loadedHandler(handlerTarget, eff)
				eff:setParent(effParent.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = true
			end

			self._hitEff = UIEffectManager.instance:playEffect(self._view, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, nil)
		else
			AudioPlayerEx.instance:playEffect(30111)
		end
	end
end

function MusicGameSymbolCell:trickOutBound()
	if self._state == MusicGameEnum.SymbolState_Running then
		self:_changeState(MusicGameEnum.SymbolState_Ended)
	end
end

function MusicGameSymbolCell:getEntityId()
	return self._entityId
end

function MusicGameSymbolCell:getState()
	return self._state
end

function MusicGameSymbolCell:getGameObject()
	return self._mainGo
end

function MusicGameSymbolCell:getLineId()
	return self._lineId
end

function MusicGameSymbolCell:isHit()
	return self._isHit
end

function MusicGameSymbolCell:getLocalPos()
	return Framework.TransformUtil.GetLocalPos(self._mainGo.transform, 0, 0, 0)
end

function MusicGameSymbolCell:setLocalPos(vector)
	local x, y, z = self:getLocalPos()

	Framework.TransformUtil.SetLocalPos(self._mainGo.transform, vector.x, vector.y, z)
end

function MusicGameSymbolCell:getBoundingBox2D()
	return self._boundingBox2D
end

function MusicGameSymbolCell:updateBoundingBox2D()
	local cellX, cellY, cellZ = self:getLocalPos()
	local boxX, boxY, boxZ = Framework.TransformUtil.GetLocalPos(self._colliderBox.transform, nil, nil, nil)

	self._boundingBox2D:setSize(self._colliderBox.transform.sizeDelta.x, self._colliderBox.transform.sizeDelta.y)
	self._boundingBox2D:setCenter(cellX + boxX, cellY + boxY)
end

return MusicGameSymbolCell
