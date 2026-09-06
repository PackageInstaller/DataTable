-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/view/YearCardPreheatGameItem.lua

module("logic.extensions.yearcardpreheat.view.YearCardPreheatGameItem", package.seeall)

local YearCardPreheatGameItem = class("YearCardPreheatGameItem")

function YearCardPreheatGameItem:buildUI(go)
	self._go = go
	self._showGo = goutil.findChild(go, "select")
	self._defaultGo = goutil.findChild(go, "default")
	self._selectGo = goutil.findChild(go, "kuang")
	self._petcon = goutil.findChild(self._showGo, "mask/petcon")
	self._btn = Framework.ButtonAdapter.Get(go)

	self._btn:AddClickListener(self._onClickBtn, self)

	self._animator = go:GetComponent(ComponentType.Animator)
end

function YearCardPreheatGameItem:init(id)
	self._id = id
	self._isGamePlay = false
	self._isSelect = false
	self._isClear = false

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(id))

	uGuiUtil.setSpriteToImage(self._petcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	self:updateState()
	goutil.setActive(self._selectGo, false)
end

function YearCardPreheatGameItem:reset()
	if self._btn then
		self._btn:RemoveClickListener()
	end

	uGuiUtil.clearImage(self._petcon)

	if self._tweener then
		self._tweener:Kill()

		self._tweener = nil
	end
end

function YearCardPreheatGameItem:_onClickBtn()
	if not self._isGamePlay or self._isSelect or self._isClear or UnityEngine.Input.touchCount > 1 then
		-- block empty
	else
		self._isSelect = true

		self:updateState()
		self._animator:Play("fanpai")
		GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatSelectCard, self)
	end
end

function YearCardPreheatGameItem:updateSelectState(cellInfo)
	goutil.setActive(self._selectGo, cellInfo == self)
end

function YearCardPreheatGameItem:setGamePlayState(state)
	self._isGamePlay = checkbool(state)
end

function YearCardPreheatGameItem:updateMatch(state)
	local isMatch = checkbool(state)

	if self._isSelect then
		self._isClear = isMatch
		self._isSelect = false
	end
end

function YearCardPreheatGameItem:updateState()
	if self._tweener then
		self._tweener:Kill()

		self._tweener = nil
	end

	if self._isClear then
		self._animator.enabled = false

		goutil.setActive(self._defaultGo, false)
		goutil.setActive(self._showGo, false)
		goutil.setActive(self._selectGo, false)
	elseif not self._isSelect then
		self._animator:Play("gaipai")

		self._tweener = TweenUtil.DoDelay(0.5, function()
			self:_handleFinishAni()
		end)
	end
end

function YearCardPreheatGameItem:_handleFinishAni()
	goutil.setActive(self._defaultGo, not self._isSelect)
	goutil.setActive(self._showGo, self._isSelect)
end

return YearCardPreheatGameItem
