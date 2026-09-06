-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/FlipGameItem.lua

module("logic.extensions.dreamteam.view.FlipGameItem", package.seeall)

local FlipGameItem = class("FlipGameItem")
local FlipGameState = {
	Default = 1,
	Erase = 3,
	Select = 2,
	UnSelect = 4
}

function FlipGameItem:ctor()
	self._id = 0
	self._curState = FlipGameState.Default
end

function FlipGameItem:buildUI(go)
	self._go = go
	self._selectGo = goutil.findChild(go, "select")
	self._txt = goutil.findChildTextComponent(go, "select/txt")
	self._defaultGo = goutil.findChild(go, "default")
	self._btn = Framework.ButtonAdapter.Get(go)

	self._btn:AddClickListener(self._onClickBtn, self)

	self._selectSpriteChange = goutil.findChild(go, "select"):GetComponent(typeof(UIImageSpriteChange))
	self._animator = go:GetComponent(ComponentType.Animator)
	self._position = go.transform.position
end

function FlipGameItem:init(id, index)
	self._id = id
	self._index = index
	self._txt.text = id

	self._selectSpriteChange:SetState(id)
	self:setState(FlipGameState.Default)
end

function FlipGameItem:reset()
	if self._btn then
		self._btn:RemoveClickListener()
	end
end

function FlipGameItem:_onClickBtn()
	if self._curState == FlipGameState.Default or self._curState == FlipGameState.UnSelect then
		printInfo("test _onClickBtn 默认状态")

		local isSuccess = FlipGameModel.instance:addSelectIndex(self._index, self._id)

		if isSuccess then
			self:setState(FlipGameState.Select)
		end

		GlobalDispatcher:dispatch(GlobalNotify.FlipGameSelect)
	elseif self._curState == FlipGameState.Select then
		printInfo("test _onClickBtn 选中状态")
	else
		printInfo("test _onClickBtn 消除状态")
	end
end

function FlipGameItem:setState(state)
	self._curState = state

	if self._curState == FlipGameState.Default then
		goutil.setActive(self._defaultGo, true)
		goutil.setActive(self._selectGo, false)
	elseif self._curState == FlipGameState.Select then
		goutil.setActive(self._defaultGo, false)
		goutil.setActive(self._selectGo, true)
	elseif self._curState == FlipGameState.UnSelect then
		goutil.setActive(self._defaultGo, true)
		goutil.setActive(self._selectGo, false)
	else
		goutil.setActive(self._defaultGo, false)
		goutil.setActive(self._selectGo, false)
	end
end

function FlipGameItem:changeToUnSelectState()
	self:setState(FlipGameState.UnSelect)
end

function FlipGameItem:changeToEraseState()
	self:setState(FlipGameState.Erase)
	FlipGameModel.instance:addToEraseList(self._id)
end

function FlipGameItem:getPosition()
	if not goutil.isNil(self._go) then
		return self._go.transform.position
	else
		return Vector3.New(0, 0, 0)
	end
end

return FlipGameItem
