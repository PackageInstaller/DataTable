-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampgame/FunCampGameItem.lua

module("logic.extensions.funcamp.view.funcampgame.FunCampGameItem", package.seeall)

local FunCampGameItem = class("FunCampGameItem")

module("logic.extensions.dreamteam.view.FunCampGameItem", package.seeall)

local FunCampGameItem = class("FunCampGameItem")
local FunCampGameState = {
	Default = 1,
	Erase = 3,
	Select = 2,
	UnSelect = 4
}

function FunCampGameItem:ctor()
	self._id = 0
	self._curState = FunCampGameState.Default
end

function FunCampGameItem:buildUI(go)
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

function FunCampGameItem:init(id, index)
	self._id = id
	self._index = index
	self._txt.text = id

	self._selectSpriteChange:SetState(id)
	self:setState(FunCampGameState.Default)
end

function FunCampGameItem:reset()
	if self._btn then
		self._btn:RemoveClickListener()
	end
end

function FunCampGameItem:_onClickBtn()
	if self._curState == FunCampGameState.Default or self._curState == FunCampGameState.UnSelect then
		printInfo("test _onClickBtn 默认状态")

		local isSuccess = FunCampGameModel.instance:addSelectIndex(self._index, self._id)

		if isSuccess then
			self:setState(FunCampGameState.Select)
		end

		GlobalDispatcher:dispatch(GlobalNotify.FunCampGameSelect)
	elseif self._curState == FunCampGameState.Select then
		printInfo("test _onClickBtn 选中状态")
	else
		printInfo("test _onClickBtn 消除状态")
	end
end

function FunCampGameItem:setState(state)
	self._curState = state

	if self._curState == FunCampGameState.Default then
		goutil.setActive(self._defaultGo, true)
		goutil.setActive(self._selectGo, false)
	elseif self._curState == FunCampGameState.Select then
		goutil.setActive(self._defaultGo, false)
		goutil.setActive(self._selectGo, true)
	elseif self._curState == FunCampGameState.UnSelect then
		goutil.setActive(self._defaultGo, true)
		goutil.setActive(self._selectGo, false)
	else
		goutil.setActive(self._defaultGo, false)
		goutil.setActive(self._selectGo, false)
	end
end

function FunCampGameItem:changeToUnSelectState()
	self:setState(FunCampGameState.UnSelect)
end

function FunCampGameItem:changeToEraseState()
	self:setState(FunCampGameState.Erase)
	FunCampGameModel.instance:addToEraseList(self._id)
end

function FunCampGameItem:getPosition()
	if not goutil.isNil(self._go) then
		return self._go.transform.position
	else
		return Vector3.New(0, 0, 0)
	end
end

return FunCampGameItem
