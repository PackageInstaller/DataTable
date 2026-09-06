-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SGChildObj.lua

module("logic.extensions.anniversarycake.view.spheregame.SGChildObj", package.seeall)

local SGChildObj = class("SGChildObj")

SGChildObj.Color = {
	{
		g = 48,
		b = 103,
		r = 105
	},
	{
		g = 82,
		b = 30,
		r = 94
	},
	{
		g = 233,
		b = 215,
		r = 171
	},
	{
		g = 141,
		b = 141,
		r = 225
	},
	{
		g = 152,
		b = 32,
		r = 232
	},
	{
		g = 236,
		b = 36,
		r = 217
	}
}

function SGChildObj:ctor()
	self._colorIndex = 0
end

function SGChildObj:buildUI(go)
	self.mainGO = go
	self._image = self.mainGO:GetComponent(goutil.Type_UIImage)
	self._image.enabled = true
	self._spriteChange = self.mainGO:GetComponent(ComponentType.UIImageSpriteChange)
end

function SGChildObj:onEnter()
	return
end

function SGChildObj:onExit()
	self.mainGO.transform:DOKill()

	if self._sequence then
		self._sequence:Kill()

		self._sequence = nil
	end
end

function SGChildObj:getGo()
	return self.mainGO
end

function SGChildObj:setColorIndex(colorIndex)
	self._colorIndex = colorIndex

	self:updateColor()
end

function SGChildObj:getColorIndex()
	return self._colorIndex
end

function SGChildObj:updateColor()
	self._spriteChange:SetState(self._colorIndex - 1)
end

function SGChildObj:moveTo(worldPos)
	GlobalDispatcher:dispatch(GlobalNotify.SGCloseClick)
	self.mainGO.transform:DOMove(worldPos, 0.1):OnComplete(function()
		GlobalDispatcher:dispatch(GlobalNotify.SGOpenClick)
	end)
end

function SGChildObj:moveToPositions(pos1, pos2)
	if self._sequence then
		self._sequence:Kill(true)

		self._sequence = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.SGCloseClick)

	local sequence = DG.Tweening.DOTween.Sequence()
	local tween1 = self.mainGO.transform:DOMove(pos1, 0.2)
	local tween2 = self.mainGO.transform:DOMove(pos2, 0.2)

	sequence:Append(tween1)
	sequence:Append(tween2)
	sequence:AppendCallback(function()
		GlobalDispatcher:dispatch(GlobalNotify.SGOpenClick)
	end)

	self._sequence = sequence
end

return SGChildObj
