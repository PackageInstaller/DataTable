-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbgameresultView.lua

module("logic.extensions.fbbchallenge.view.FbbgameresultView", package.seeall)

local FbbgameresultView = class("FbbgameresultView", ViewComponent)

function FbbgameresultView:ctor()
	FbbgameresultView.super.ctor(self)
end

function FbbgameresultView:buildUI()
	FbbgameresultView.super.buildUI(self)

	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "title/txt")
	self._btnAgain = self:getBtn("btnAgain")
	self._btnSure = self:getBtn("btnSure")
	self._shovelItemGo = self:getGo("Effect/item")
	self._arrowGo = self:getGo("Effect/arrow")
	self._effectGo = self:getGo("Effect/effect")
	self._txtNum = goutil.findChildTextComponent(self.mainGO, "Effect/item/num/txtNum")
	self._imgIconGo = self:getGo("Effect/effect/imgIcon")
	self._txtEffectDesc = goutil.findChildTextComponent(self.mainGO, "Effect/effect/txtDesc")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "Effect/effect/txtName")
	self._upArrowGo = self:getGo("arrow")
end

function FbbgameresultView:bindEvents()
	FbbgameresultView.super.bindEvents(self)
	self._btnAgain:AddClickListener(self._onClickbtnAgain, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function FbbgameresultView:unbindEvents()
	FbbgameresultView.super.unbindEvents(self)
	self._btnAgain:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function FbbgameresultView:destroyUI()
	FbbgameresultView.super.destroyUI(self)
end

function FbbgameresultView:onEnter()
	FbbgameresultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._shovelNums = params[1]
	self._lastShovelNums = params[2]

	self:_updateView()
end

function FbbgameresultView:onEnterFinished()
	FbbgameresultView.super.onEnterFinished(self)
end

function FbbgameresultView:onExit()
	FbbgameresultView.super.onExit(self)
	uGuiUtil.clearImage(self._imgIconGo)
end

function FbbgameresultView:onExitFinished()
	FbbgameresultView.super.onExitFinished(self)
end

function FbbgameresultView:_onClickbtnAgain()
	UIStateManager.instance:popByName(ViewName.FbbgameView)
	FbbchallengeController.instance:gotoPlaySamallGame()
end

function FbbgameresultView:_onClickbtnSure()
	self:close()
end

function FbbgameresultView:_updateView()
	local hasNewEffect = false

	self._txtNum.text = ""

	goutil.setActive(self._upArrowGo, false)

	if self._shovelNums <= 0 then
		self._txtDesc.text = "<color=red>追击失败！</color>"
		self._txtTitle.text = "当前效果"
	elseif self._shovelNums <= self._lastShovelNums then
		self._txtDesc.text = "追击成功，未超过原战意，保留原最高战意！"
		self._txtTitle.text = "当前效果"
	else
		hasNewEffect = true
		self._txtNum.text = string.format("剩余<color=#20b376>X%s</color>", self._shovelNums)
		self._txtTitle.text = "新效果"
		self._txtDesc.text = "追击王也成功，战意提升了！"

		goutil.setActive(self._upArrowGo, true)
	end

	goutil.setActive(self._shovelItemGo, hasNewEffect)
	goutil.setActive(self._arrowGo, hasNewEffect)
	self:_updateBuff()
end

function FbbgameresultView:_updateBuff()
	local maxNum = math.max(self._shovelNums, self._lastShovelNums)
	local cfg = FbbchallengeModel.instance:getBuffCfg(maxNum)

	self._txtName.text = "Lv." .. cfg.grade
	self._txtEffectDesc.text = cfg.desc

	uGuiUtil.setSpriteToImage(self._imgIconGo, nil, GameUrl.getIconFolderUrl("expevents", cfg.buffKey))
end

return FbbgameresultView
